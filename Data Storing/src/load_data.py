#!/usr/bin/env python3
"""
Script ini melakukan loading data boardgame yang sudah discrape dalam bentuk JSON files kedalam 
MySQL dan menormalisasikannya serta membuat relationship antar entity

Requirements:
- MySQL server running locally
- Database 'boardgame_db' created using the schema script
- JSON data files from the scraping process
"""

import json
import mysql.connector
from mysql.connector import Error
import os
import re
from decimal import Decimal
from typing import Dict, List, Optional, Tuple

class BoardGameDataLoader:
    """
    Class to handle loading scraped board game data into the database.
    """
    
    def __init__(self, db_config: Dict[str, str]):
        """
        Initialize the data loader with database configuration.
        
        Args:
            db_config: Dictionary containing database connection parameters
        """
        self.db_config = db_config
        self.connection = None
        self.cursor = None
        
        # Paths to JSON data files
        self.data_dir = "../../Data Scraping/data"
        self.json_files = {
            'boardgames': f"{self.data_dir}/boardgames.json",
            'designers': f"{self.data_dir}/designers.json",
            'artists': f"{self.data_dir}/artists.json",
            'publishers': f"{self.data_dir}/publishers.json",
            'categories': f"{self.data_dir}/categories.json",
            'mechanisms': f"{self.data_dir}/mechanisms.json",
            'families': f"{self.data_dir}/families.json",
            'awards': f"{self.data_dir}/awards.json",
            'reimplemented_games': f"{self.data_dir}/reimplemented_games.json",
            'geekmarket_prices': f"{self.data_dir}/geekmarket_prices.json",
            'relationships': f"{self.data_dir}/relationships.json"
        }
        
        # Cache for entity IDs to avoid repeated lookups
        self.entity_cache = {
            'designers': {},
            'artists': {},
            'publishers': {},
            'categories': {},
            'mechanisms': {},
            'families': {},
            'awards': {},
            'reimplemented_games': {},
            'stores': {}
        }
    
    def connect_to_database(self) -> bool:
        """
        Establish connection to the MySQL database.
        
        Returns:
            bool: True if connection successful, False otherwise
        """
        try:
            self.connection = mysql.connector.connect(**self.db_config)
            self.cursor = self.connection.cursor()
            print("Successfully connected to MySQL database")
            return True
        except Error as e:
            print(f"Error connecting to MySQL database: {e}")
            return False
    
    def disconnect_from_database(self):
        """Close database connection."""
        if self.cursor:
            self.cursor.close()
        if self.connection:
            self.connection.close()
        print("🔌 Database connection closed")
    
    def load_json_file(self, file_path: str) -> Optional[List]:
        """
        Load data from a JSON file.
        
        Args:
            file_path: Path to the JSON file
            
        Returns:
            List of data or None if error occurred
        """
        try:
            with open(file_path, 'r', encoding='utf-8') as file:
                data = json.load(file)
            print(f"Loaded {len(data)} records from {os.path.basename(file_path)}")
            return data
        except FileNotFoundError:
            print(f"File not found: {file_path}")
            return None
        except json.JSONDecodeError as e:
            print(f"Error parsing JSON file {file_path}: {e}")
            return None
    
    def insert_entity(self, table: str, name: str) -> int:
        """
        Insert an entity into the specified table and return its ID.
        Uses cache to avoid duplicate inserts.
        
        Args:
            table: Table name (designers, artists, etc.)
            name: Entity name
            
        Returns:
            int: Entity ID
        """
        # Mapping of table names to their ID column names
        id_column_mapping = {
            'designers': 'designer_id',
            'artists': 'artist_id', 
            'publishers': 'publisher_id',
            'categories': 'category_id',
            'mechanisms': 'mechanism_id',
            'families': 'family_id',
            'awards': 'award_id',
            'reimplemented_games': 'reimplementation_id'
        }
        
        # Check cache first
        if name in self.entity_cache[table]:
            return self.entity_cache[table][name]
        
        try:
            # Try to insert, ignore if duplicate
            query = f"INSERT IGNORE INTO {table} (name) VALUES (%s)"
            self.cursor.execute(query, (name,))
            
            # Get the ID (either newly inserted or existing)
            id_column = id_column_mapping.get(table, f"{table[:-1]}_id")
            query = f"SELECT {id_column} FROM {table} WHERE name = %s"
            self.cursor.execute(query, (name,))
            entity_id = self.cursor.fetchone()[0]
            
            # Cache the ID
            self.entity_cache[table][name] = entity_id
            
            return entity_id
        except Error as e:
            print(f"Error inserting entity '{name}' into {table}: {e}")
            return None
    
    def insert_store(self, store_name: str) -> int:
        """
        Insert a store into the stores table and return its ID.
        
        Args:
            store_name: Store name
            
        Returns:
            int: Store ID
        """
        # Check cache first
        if store_name in self.entity_cache['stores']:
            return self.entity_cache['stores'][store_name]
        
        try:
            # Try to insert, ignore if duplicate
            query = "INSERT IGNORE INTO stores (name) VALUES (%s)"
            self.cursor.execute(query, (store_name,))
            
            # Get the ID
            query = "SELECT store_id FROM stores WHERE name = %s"
            self.cursor.execute(query, (store_name,))
            store_id = self.cursor.fetchone()[0]
            
            # Cache the ID
            self.entity_cache['stores'][store_name] = store_id
            
            return store_id
        except Error as e:
            print(f"Error inserting store '{store_name}': {e}")
            return None
    
    def safe_convert_to_decimal(self, value, default=None) -> Optional[Decimal]:
        """
        Safely convert a value to Decimal.
        
        Args:
            value: Value to convert
            default: Default value if conversion fails
            
        Returns:
            Decimal value or default
        """
        if value is None:
            return default
        try:
            return Decimal(str(value))
        except:
            return default
    
    def safe_convert_to_int(self, value, default=None) -> Optional[int]:
        """
        Safely convert a value to int.
        
        Args:
            value: Value to convert
            default: Default value if conversion fails
            
        Returns:
            int value or default
        """
        if value is None:
            return default
        try:
            return int(value)
        except:
            return default
    
    def safe_convert_year(self, value, default=None) -> Optional[int]:
        """
        Safely convert a year value to int, ensuring it's within database constraints.
        
        Args:
            value: Year value to convert
            default: Default value if conversion fails
            
        Returns:
            int year value within valid range (1800-2030) or default
        """
        if value is None:
            return default
        try:
            year = int(value)
            # Ensure year is within database constraints
            if 1800 <= year <= 2030:
                return year
            else:
                print(f" Year {year} is outside valid range (1800-2030), setting to None")
                return default
        except:
            return default
    
    def extract_game_id_from_url(self, url: str) -> Optional[int]:
        """
        Extract BGG game ID from URL.
        
        Args:
            url: BoardGameGeek URL
            
        Returns:
            Game ID or None if not found
        """
        match = re.search(r'/boardgame/(\d+)/', url)
        return int(match.group(1)) if match else None
    
    def load_entities(self):
        """Load all entity tables (designers, artists, etc.)."""
        print("\n Loading entity tables...")
        
        entity_tables = ['designers', 'artists', 'publishers', 'categories', 
                        'mechanisms', 'families', 'awards', 'reimplemented_games']
        
        for table in entity_tables:
            data = self.load_json_file(self.json_files[table])
            if data:
                print(f" Loading {table}...")
                for item in data:
                    self.insert_entity(table, item['name'])
                
                self.connection.commit()
                print(f"Loaded {len(data)} {table}")
    
    def load_boardgames(self):
        """Load board games data."""
        print("\n Loading board games...")
        
        data = self.load_json_file(self.json_files['boardgames'])
        if not data:
            return
        
        insert_query = """
        INSERT INTO boardgames (
            rank_position, title, bgg_url, year_published, geek_rating, avg_rating,
            users_voted, min_players, max_players, min_playtime, max_playtime,
            min_age, complexity_rating, community_owned, community_wishlist,
            num_comments, num_plays, fans
        ) VALUES (
            %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s
        )
        """
        
        for game in data:
            try:
                values = (
                    self.safe_convert_to_int(game.get('rank')),
                    game.get('title'),
                    game.get('url'),
                    self.safe_convert_year(game.get('year')),
                    self.safe_convert_to_decimal(game.get('geek_rating')),
                    self.safe_convert_to_decimal(game.get('avg_rating')),
                    self.safe_convert_to_int(game.get('users_voted')),
                    self.safe_convert_to_int(game.get('min_players')),
                    self.safe_convert_to_int(game.get('max_players')),
                    self.safe_convert_to_int(game.get('min_playtime')),
                    self.safe_convert_to_int(game.get('max_playtime')),
                    self.safe_convert_to_int(game.get('min_age')),
                    self.safe_convert_to_decimal(game.get('complexity')),
                    self.safe_convert_to_int(game.get('community_owned')),
                    self.safe_convert_to_int(game.get('community_wishlist')),
                    self.safe_convert_to_int(game.get('num_comments')),
                    self.safe_convert_to_int(game.get('num_plays')),
                    self.safe_convert_to_int(game.get('fans'))
                )
                
                self.cursor.execute(insert_query, values)
                
            except Error as e:
                print(f" Error inserting game '{game.get('title')}': {e}")
                continue
        
        self.connection.commit()
        print(f" Loaded {len(data)} board games")
    
    def load_game_relationships(self):
        """Load game relationships with designers, artists, etc. from relationships.json."""
        print("\n Loading game relationships...")
        
        # Load relationships data
        relationships_data = self.load_json_file(self.json_files['relationships'])
        if not relationships_data:
            print(" No relationships file found, skipping relationship loading")
            return
        
        relationship_count = 0
        
        # Load game-designer relationships
        print(" Loading game-designer relationships...")
        for rel in relationships_data.get('game_designers', []):
            game_id = rel.get('game_id')
            designer_name = rel.get('designer')
            
            if game_id and designer_name:
                designer_id = self.insert_entity('designers', designer_name)
                if designer_id:
                    try:
                        self.cursor.execute(
                            "INSERT IGNORE INTO game_designers (game_id, designer_id) VALUES (%s, %s)",
                            (game_id, designer_id)
                        )
                        relationship_count += 1
                    except Error as e:
                        print(f" Error inserting game-designer relationship: {e}")
        
        # Load game-artist relationships
        print(" Loading game-artist relationships...")
        for rel in relationships_data.get('game_artists', []):
            game_id = rel.get('game_id')
            artist_name = rel.get('artist')
            
            if game_id and artist_name:
                artist_id = self.insert_entity('artists', artist_name)
                if artist_id:
                    try:
                        self.cursor.execute(
                            "INSERT IGNORE INTO game_artists (game_id, artist_id) VALUES (%s, %s)",
                            (game_id, artist_id)
                        )
                        relationship_count += 1
                    except Error as e:
                        print(f" Error inserting game-artist relationship: {e}")
        
        # Load game-publisher relationships
        print(" Loading game-publisher relationships...")
        for rel in relationships_data.get('game_publishers', []):
            game_id = rel.get('game_id')
            publisher_name = rel.get('publisher')
            
            if game_id and publisher_name:
                publisher_id = self.insert_entity('publishers', publisher_name)
                if publisher_id:
                    try:
                        self.cursor.execute(
                            "INSERT IGNORE INTO game_publishers (game_id, publisher_id) VALUES (%s, %s)",
                            (game_id, publisher_id)
                        )
                        relationship_count += 1
                    except Error as e:
                        print(f" Error inserting game-publisher relationship: {e}")
        
        # Load game-category relationships
        print(" Loading game-category relationships...")
        for rel in relationships_data.get('game_categories', []):
            game_id = rel.get('game_id')
            category_name = rel.get('category')
            
            if game_id and category_name:
                category_id = self.insert_entity('categories', category_name)
                if category_id:
                    try:
                        self.cursor.execute(
                            "INSERT IGNORE INTO game_categories (game_id, category_id) VALUES (%s, %s)",
                            (game_id, category_id)
                        )
                        relationship_count += 1
                    except Error as e:
                        print(f" Error inserting game-category relationship: {e}")
        
        # Load game-mechanism relationships
        print(" Loading game-mechanism relationships...")
        for rel in relationships_data.get('game_mechanisms', []):
            game_id = rel.get('game_id')
            mechanism_name = rel.get('mechanism')
            
            if game_id and mechanism_name:
                mechanism_id = self.insert_entity('mechanisms', mechanism_name)
                if mechanism_id:
                    try:
                        self.cursor.execute(
                            "INSERT IGNORE INTO game_mechanisms (game_id, mechanism_id) VALUES (%s, %s)",
                            (game_id, mechanism_id)
                        )
                        relationship_count += 1
                    except Error as e:
                        print(f"Error inserting game-mechanism relationship: {e}")
        
        # Load game-family relationships
        print("Loading game-family relationships...")
        for rel in relationships_data.get('game_families', []):
            game_id = rel.get('game_id')
            family_name = rel.get('family')
            
            if game_id and family_name:
                family_id = self.insert_entity('families', family_name)
                if family_id:
                    try:
                        self.cursor.execute(
                            "INSERT IGNORE INTO game_families (game_id, family_id) VALUES (%s, %s)",
                            (game_id, family_id)
                        )
                        relationship_count += 1
                    except Error as e:
                        print(f" Error inserting game-family relationship: {e}")
        
        # Load game-award relationships
        print("Loading game-award relationships...")
        for rel in relationships_data.get('game_awards', []):
            game_id = rel.get('game_id')
            award_name = rel.get('award')
            
            if game_id and award_name:
                award_id = self.insert_entity('awards', award_name)
                if award_id:
                    try:
                        # Extract year from award name if possible
                        import re
                        year_match = re.search(r'(\d{4})', award_name)
                        year_awarded = year_match.group(1) if year_match else None
                        
                        self.cursor.execute(
                            "INSERT IGNORE INTO game_awards (game_id, award_id, year_awarded) VALUES (%s, %s, %s)",
                            (game_id, award_id, year_awarded)
                        )
                        relationship_count += 1
                    except Error as e:
                        print(f" Error inserting game-award relationship: {e}")
        
        # Load game-reimplementation relationships
        print(" Loading game-reimplementation relationships...")
        for rel in relationships_data.get('game_reimplements', []):
            game_id = rel.get('game_id')
            reimplemented_name = rel.get('reimplemented_game')
            
            if game_id and reimplemented_name:
                reimplemented_id = self.insert_entity('reimplemented_games', reimplemented_name)
                if reimplemented_id:
                    try:
                        self.cursor.execute(
                            "INSERT IGNORE INTO game_reimplementations (game_id, reimplementation_id) VALUES (%s, %s)",
                            (game_id, reimplemented_id)
                        )
                        relationship_count += 1
                    except Error as e:
                        print(f" Error inserting game-reimplementation relationship: {e}")
        
        self.connection.commit()
        print(f"Loaded {relationship_count} game relationships from relationships.json")
        print("� Note: These relationships demonstrate the database functionality.")
        print("    For production, enhance the scraper to extract real relationships from BGG.")
    
    def load_pricing_data(self):
        """Load pricing data."""
        print("\n Loading pricing data...")
        
        data = self.load_json_file(self.json_files['geekmarket_prices'])
        if not data:
            return
        
        # Build a map of game ranks to database IDs
        game_rank_map = {}
        self.cursor.execute("SELECT game_id, rank_position FROM boardgames")
        for game_id, rank_position in self.cursor.fetchall():
            game_rank_map[rank_position] = game_id
        
        for price_data in data:
            try:
                game_rank = price_data.get('game_rank')
                if game_rank not in game_rank_map:
                    continue
                
                game_id = game_rank_map[game_rank]
                store_name = price_data.get('store', 'Unknown')
                price = self.safe_convert_to_decimal(price_data.get('price'))
                currency = price_data.get('currency', 'USD')
                condition = price_data.get('condition', 'Unknown')
                location = price_data.get('location')
                
                if not price:
                    continue
                
                # Insert store and get ID
                store_id = self.insert_store(store_name)
                if not store_id:
                    continue
                
                # Insert price
                insert_query = """
                INSERT INTO game_prices (game_id, store_id, price, currency, condition_type, location)
                VALUES (%s, %s, %s, %s, %s, %s)
                """
                
                # Validate condition
                valid_conditions = ['New', 'Like New', 'Very Good', 'Good', 'Acceptable', 'Poor', 'Unknown']
                if condition not in valid_conditions:
                    condition = 'Unknown'
                
                self.cursor.execute(insert_query, (game_id, store_id, price, currency, condition, location))
                
            except Error as e:
                print(f" Error inserting price data: {e}")
                continue
        
        self.connection.commit()
        print(f" Loaded {len(data)} price entries")
    
    def verify_data_load(self):
        """Verify that data was loaded correctly."""
        print("\n Verifying data load...")
        
        queries = [
            ("boardgames", "SELECT COUNT(*) FROM boardgames"),
            ("designers", "SELECT COUNT(*) FROM designers"),
            ("artists", "SELECT COUNT(*) FROM artists"),
            ("publishers", "SELECT COUNT(*) FROM publishers"),
            ("categories", "SELECT COUNT(*) FROM categories"),
            ("mechanisms", "SELECT COUNT(*) FROM mechanisms"),
            ("families", "SELECT COUNT(*) FROM families"),
            ("awards", "SELECT COUNT(*) FROM awards"),
            ("reimplemented_games", "SELECT COUNT(*) FROM reimplemented_games"),
            ("stores", "SELECT COUNT(*) FROM stores"),
            ("game_prices", "SELECT COUNT(*) FROM game_prices"),
            ("game_designers", "SELECT COUNT(*) FROM game_designers"),
            ("game_artists", "SELECT COUNT(*) FROM game_artists"),
            ("game_publishers", "SELECT COUNT(*) FROM game_publishers"),
            ("game_categories", "SELECT COUNT(*) FROM game_categories"),
            ("game_mechanisms", "SELECT COUNT(*) FROM game_mechanisms"),
            ("game_families", "SELECT COUNT(*) FROM game_families"),
            ("game_awards", "SELECT COUNT(*) FROM game_awards"),
            ("game_reimplementations", "SELECT COUNT(*) FROM game_reimplementations"),
        ]
        
        for table_name, query in queries:
            try:
                self.cursor.execute(query)
                count = self.cursor.fetchone()[0]
                print(f" {table_name}: {count} records")
            except Error as e:
                print(f" Error checking {table_name}: {e}")
    
    def run_data_load(self):
        """Execute the complete data loading process."""
        print(" Starting BoardGame Database Data Load Process")
        print("=" * 60)
        
        if not self.connect_to_database():
            return False
        
        try:
            # Load entities first (designers, artists, etc.)
            self.load_entities()
            
            # Load main board games data
            self.load_boardgames()
            
            # Load relationships between games and entities
            self.load_game_relationships()
            
            # Load pricing data
            self.load_pricing_data()
            
            # Verify the load
            self.verify_data_load()
            
            print("\n🎉 Data loading completed successfully!")
            return True
            
        except Exception as e:
            print(f" Error during data loading: {e}")
            if self.connection:
                self.connection.rollback()
            return False
        
        finally:
            self.disconnect_from_database()


def main():
    """Main function to run the data loader."""
    
    # Database configuration
    db_config = {
        'host': 'localhost',
        'user': 'root',          # Change this to your MySQL username
        'password': '',          # Change this to your MySQL password
        'database': 'boardgame_db',
        'charset': 'utf8mb4',
        'collation': 'utf8mb4_unicode_ci',
        'autocommit': False
    }
    
    # Create and run the data loader
    loader = BoardGameDataLoader(db_config)
    success = loader.run_data_load()
    
    if success:
        print("\n All data loaded successfully into the database!")
        print(" You can now query the database using the provided views:")
        print("   - SELECT * FROM v_game_details LIMIT 10;")
        print("   - SELECT * FROM v_game_pricing LIMIT 10;")
    else:
        print("\n Data loading failed. Please check the error messages above.")
        return 1
    
    return 0


if __name__ == "__main__":
    exit(main())
