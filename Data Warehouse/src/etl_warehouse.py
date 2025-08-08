#!/usr/bin/env python3
"""
BoardGame Data Warehouse ETL Pipeline
Created: August 7, 2025

This script performs Extract-Transform-Load operations from the operational
boardgame_db to the analytical boardgame_dw data warehouse.

Features:
- Incremental data loading
- Slowly Changing Dimension (SCD) Type 2 support
- Data quality validation
- Comprehensive error handling and logging
- Automated scheduling support

Requirements:
- Operational database 'boardgame_db' with current data
- Data warehouse 'boardgame_dw' schema created
- MySQL connector and other dependencies

Usage:
    python etl_warehouse.py [--full-refresh] [--batch-name "Custom Batch"]

Author: Board Game Database Project
"""

import mysql.connector
from mysql.connector import Error
import logging
import sys
import argparse
from datetime import datetime, date
from typing import Dict, List, Optional, Tuple, Any
import hashlib
import json
from decimal import Decimal

class DataWarehouseETL:
    """
    ETL pipeline for loading operational data into the data warehouse.
    """
    
    def __init__(self, source_config: Dict[str, str], target_config: Dict[str, str]):
        """
        Initialize ETL pipeline with source and target database configurations.
        
        Args:
            source_config: Source database (operational) connection parameters
            target_config: Target database (warehouse) connection parameters
        """
        self.source_config = source_config
        self.target_config = target_config
        self.source_conn = None
        self.target_conn = None
        self.source_cursor = None
        self.target_cursor = None
        self.batch_id = None
        
        # Setup logging
        self.setup_logging()
        
        # ETL metadata
        self.current_timestamp = datetime.now()
        self.current_date_key = int(self.current_timestamp.strftime('%Y%m%d'))
        
    def setup_logging(self):
        """Setup comprehensive logging configuration."""
        log_format = '%(asctime)s - %(levelname)s - %(funcName)s - %(message)s'
        logging.basicConfig(
            level=logging.INFO,
            format=log_format,
            handlers=[
                logging.FileHandler(f'etl_warehouse_{datetime.now().strftime("%Y%m%d_%H%M%S")}.log'),
                logging.StreamHandler(sys.stdout)
            ]
        )
        self.logger = logging.getLogger(__name__)
        
    def connect_databases(self):
        """Establish connections to source and target databases."""
        try:
            # Connect to source (operational) database
            self.source_conn = mysql.connector.connect(**self.source_config)
            self.source_cursor = self.source_conn.cursor(dictionary=True)
            self.logger.info("✅ Connected to source database (boardgame_db)")
            
            # Connect to target (warehouse) database
            self.target_conn = mysql.connector.connect(**self.target_config)
            self.target_cursor = self.target_conn.cursor(dictionary=True)
            self.logger.info("✅ Connected to target database (boardgame_dw)")
            
        except Error as e:
            self.logger.error(f"❌ Database connection failed: {e}")
            raise
            
    def disconnect_databases(self):
        """Close database connections."""
        if self.source_cursor:
            self.source_cursor.close()
        if self.source_conn:
            self.source_conn.close()
        if self.target_cursor:
            self.target_cursor.close()
        if self.target_conn:
            self.target_conn.close()
        self.logger.info("🔌 Database connections closed")
        
    def start_batch(self, batch_name: str = "Daily ETL"):
        """
        Initialize a new ETL batch in the control table.
        
        Args:
            batch_name: Name/description of the ETL batch
        """
        try:
            insert_query = """
                INSERT INTO etl_batch_log (batch_name, start_time, status)
                VALUES (%s, %s, 'Running')
            """
            self.target_cursor.execute(insert_query, (batch_name, self.current_timestamp))
            self.target_conn.commit()
            
            self.batch_id = self.target_cursor.lastrowid
            self.logger.info(f"🚀 Started ETL batch {self.batch_id}: {batch_name}")
            
        except Error as e:
            self.logger.error(f"❌ Failed to start batch: {e}")
            raise
            
    def end_batch(self, status: str = "Success", error_message: str = None):
        """
        Complete the ETL batch with final status.
        
        Args:
            status: Final batch status (Success, Failed, Cancelled)
            error_message: Error message if status is Failed
        """
        try:
            update_query = """
                UPDATE etl_batch_log 
                SET end_time = %s, status = %s, error_message = %s
                WHERE batch_id = %s
            """
            self.target_cursor.execute(update_query, (
                datetime.now(), status, error_message, self.batch_id
            ))
            self.target_conn.commit()
            
            emoji = "✅" if status == "Success" else "❌"
            self.logger.info(f"{emoji} Batch {self.batch_id} completed with status: {status}")
            
        except Error as e:
            self.logger.error(f"❌ Failed to end batch: {e}")
            
    def log_data_lineage(self, source_table: str, target_table: str, records_extracted: int):
        """
        Log data lineage information for audit purposes.
        
        Args:
            source_table: Source table name
            target_table: Target table name
            records_extracted: Number of records extracted
        """
        try:
            insert_query = """
                INSERT INTO etl_data_lineage 
                (batch_id, source_table, target_table, extraction_timestamp, records_extracted)
                VALUES (%s, %s, %s, %s, %s)
            """
            self.target_cursor.execute(insert_query, (
                self.batch_id, source_table, target_table, 
                self.current_timestamp, records_extracted
            ))
            
        except Error as e:
            self.logger.error(f"❌ Failed to log data lineage: {e}")
            
    def generate_surrogate_key_hash(self, *values) -> str:
        """
        Generate a consistent hash for surrogate key creation.
        
        Args:
            *values: Values to hash together
            
        Returns:
            Hash string for surrogate key generation
        """
        combined = "|".join(str(v) if v is not None else "NULL" for v in values)
        return hashlib.md5(combined.encode()).hexdigest()[:8]
        
    def extract_games(self) -> List[Dict]:
        """
        Extract game data from operational database.
        
        Returns:
            List of game records
        """
        self.logger.info("📤 Extracting games data...")
        
        query = """
            SELECT 
                game_id, rank_position, title, bgg_url, year_published,
                geek_rating, avg_rating, users_voted, min_players, max_players,
                min_playtime, max_playtime, min_age, complexity_rating,
                community_owned, community_wishlist, num_comments, num_plays, fans
            FROM boardgames
            ORDER BY game_id
        """
        
        self.source_cursor.execute(query)
        records = self.source_cursor.fetchall()
        
        self.logger.info(f"📤 Extracted {len(records)} games")
        self.log_data_lineage("boardgames", "dim_game", len(records))
        
        return records
        
    def extract_entities(self, table_name: str, id_field: str, name_field: str) -> List[Dict]:
        """
        Extract entity data (designers, publishers, etc.) from operational database.
        
        Args:
            table_name: Source table name
            id_field: ID field name
            name_field: Name field name
            
        Returns:
            List of entity records
        """
        self.logger.info(f"📤 Extracting {table_name} data...")
        
        query = f"SELECT {id_field}, {name_field} FROM {table_name} ORDER BY {id_field}"
        
        self.source_cursor.execute(query)
        records = self.source_cursor.fetchall()
        
        self.logger.info(f"📤 Extracted {len(records)} {table_name}")
        self.log_data_lineage(table_name, f"dim_{table_name[:-1]}", len(records))
        
        return records
        
    def load_dimension_games(self, games: List[Dict], is_full_refresh: bool = False):
        """
        Load games into dimension table with SCD Type 2 support.
        
        Args:
            games: List of game records
            is_full_refresh: Whether to perform full refresh
        """
        self.logger.info("📥 Loading games dimension...")
        
        inserted = 0
        updated = 0
        
        for game in games:
            try:
                # Check if game already exists with same attributes (SCD Type 2)
                check_query = """
                    SELECT game_key, game_id, complexity_rating, min_players, max_players
                    FROM dim_game 
                    WHERE game_id = %s AND is_current = TRUE
                """
                self.target_cursor.execute(check_query, (game['game_id'],))
                existing = self.target_cursor.fetchone()
                
                # Determine if this is a new record or update needed
                needs_new_record = True
                if existing:
                    # Check if key attributes changed (SCD Type 2)
                    if (existing['complexity_rating'] == game['complexity_rating'] and
                        existing['min_players'] == game['min_players'] and
                        existing['max_players'] == game['max_players']):
                        needs_new_record = False
                
                if needs_new_record:
                    # If existing record, expire it
                    if existing:
                        expire_query = """
                            UPDATE dim_game 
                            SET expiry_date = %s, is_current = FALSE
                            WHERE game_key = %s
                        """
                        self.target_cursor.execute(expire_query, (
                            date.today(), existing['game_key']
                        ))
                        updated += 1
                    
                    # Insert new record
                    insert_query = """
                        INSERT INTO dim_game (
                            game_id, title, bgg_url, year_published, min_players, max_players,
                            min_playtime, max_playtime, min_age, complexity_rating,
                            effective_date, is_current
                        ) VALUES (
                            %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, TRUE
                        )
                    """
                    self.target_cursor.execute(insert_query, (
                        game['game_id'], game['title'], game['bgg_url'],
                        game['year_published'], game['min_players'], game['max_players'],
                        game['min_playtime'], game['max_playtime'], game['min_age'],
                        game['complexity_rating'], date.today()
                    ))
                    inserted += 1
                    
            except Error as e:
                self.logger.error(f"❌ Error loading game {game['game_id']}: {e}")
                
        self.target_conn.commit()
        self.logger.info(f"📥 Games dimension loaded: {inserted} inserted, {updated} updated")
        
    def load_dimension_entities(self, entities: List[Dict], table_name: str, 
                              id_field: str, name_field: str):
        """
        Load entity dimensions (designers, publishers, etc.).
        
        Args:
            entities: List of entity records
            table_name: Target dimension table name
            id_field: Source ID field name
            name_field: Source name field name
        """
        self.logger.info(f"📥 Loading {table_name} dimension...")
        
        inserted = 0
        
        for entity in entities:
            try:
                # Check if entity already exists
                # Some tables don't have SCD support (is_current column)
                has_scd = table_name in ['dim_designer', 'dim_publisher', 'dim_game']
                
                if has_scd:
                    check_query = f"""
                        SELECT COUNT(*) as count FROM {table_name}
                        WHERE {id_field} = %s AND is_current = TRUE
                    """
                else:
                    check_query = f"""
                        SELECT COUNT(*) as count FROM {table_name}
                        WHERE {id_field} = %s
                    """
                
                self.target_cursor.execute(check_query, (entity[id_field],))
                exists = self.target_cursor.fetchone()['count'] > 0
                
                if not exists:
                    # Map table-specific column names
                    name_column = {
                        'dim_designer': 'designer_name',
                        'dim_publisher': 'publisher_name', 
                        'dim_category': 'category_name',
                        'dim_mechanism': 'mechanism_name'
                    }.get(table_name, 'name')
                    
                    # Insert new entity
                    if has_scd:
                        insert_query = f"""
                            INSERT INTO {table_name} (
                                {id_field}, {name_column},
                                effective_date, is_current
                            ) VALUES (%s, %s, %s, TRUE)
                        """
                        self.target_cursor.execute(insert_query, (
                            entity[id_field], entity[name_field], date.today()
                        ))
                    else:
                        insert_query = f"""
                            INSERT INTO {table_name} (
                                {id_field}, {name_column}
                            ) VALUES (%s, %s)
                        """
                        self.target_cursor.execute(insert_query, (
                            entity[id_field], entity[name_field]
                        ))
                    inserted += 1
                    
            except Error as e:
                self.logger.error(f"❌ Error loading {name_field}: {e}")
                
        self.target_conn.commit()
        self.logger.info(f"📥 {table_name} loaded: {inserted} new records")
        
    def load_fact_game_metrics(self, games: List[Dict]):
        """
        Load game metrics into the fact table.
        
        Args:
            games: List of game records with metrics
        """
        self.logger.info("📥 Loading fact_game_metrics...")
        
        inserted = 0
        
        for game in games:
            try:
                # Get game_key from dimension
                game_key_query = """
                    SELECT game_key FROM dim_game 
                    WHERE game_id = %s AND is_current = TRUE
                """
                self.target_cursor.execute(game_key_query, (game['game_id'],))
                game_key_result = self.target_cursor.fetchone()
                
                if not game_key_result:
                    self.logger.warning(f"⚠️ Game key not found for game_id {game['game_id']}")
                    continue
                    
                game_key = game_key_result['game_key']
                
                # Check if fact record already exists for this date
                check_query = """
                    SELECT COUNT(*) as count FROM fact_game_metrics
                    WHERE game_key = %s AND time_key = %s
                """
                self.target_cursor.execute(check_query, (game_key, self.current_date_key))
                exists = self.target_cursor.fetchone()['count'] > 0
                
                if not exists:
                    # Calculate rank percentile (assuming out of 100)
                    rank_percentile = ((101 - game['rank_position']) / 100) * 100 if game['rank_position'] else None
                    
                    # Insert fact record
                    insert_query = """
                        INSERT INTO fact_game_metrics (
                            game_key, time_key, users_voted, community_owned, 
                            community_wishlist, num_comments, num_plays, fans,
                            geek_rating, avg_rating, complexity_rating, 
                            rank_position, rank_percentile, batch_id
                        ) VALUES (
                            %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s
                        )
                    """
                    self.target_cursor.execute(insert_query, (
                        game_key, self.current_date_key,
                        game['users_voted'], game['community_owned'],
                        game['community_wishlist'], game['num_comments'],
                        game['num_plays'], game['fans'],
                        game['geek_rating'], game['avg_rating'],
                        game['complexity_rating'], game['rank_position'],
                        rank_percentile, self.batch_id
                    ))
                    inserted += 1
                    
            except Error as e:
                self.logger.error(f"❌ Error loading fact for game {game['game_id']}: {e}")
                
        self.target_conn.commit()
        self.logger.info(f"📥 Fact metrics loaded: {inserted} records")
        
    def load_fact_game_rankings(self, games: List[Dict]):
        """
        Load game rankings with historical tracking.
        
        Args:
            games: List of game records with rankings
        """
        self.logger.info("📥 Loading fact_game_rankings...")
        
        inserted = 0
        
        for game in games:
            try:
                # Get game_key
                game_key_query = """
                    SELECT game_key FROM dim_game 
                    WHERE game_id = %s AND is_current = TRUE
                """
                self.target_cursor.execute(game_key_query, (game['game_id'],))
                game_key_result = self.target_cursor.fetchone()
                
                if not game_key_result:
                    continue
                    
                game_key = game_key_result['game_key']
                
                # Get previous ranking
                prev_rank_query = """
                    SELECT rank_position FROM fact_game_rankings
                    WHERE game_key = %s 
                    ORDER BY time_key DESC 
                    LIMIT 1
                """
                self.target_cursor.execute(prev_rank_query, (game_key,))
                prev_rank_result = self.target_cursor.fetchone()
                previous_rank = prev_rank_result['rank_position'] if prev_rank_result else None
                
                # Insert ranking record
                insert_query = """
                    INSERT INTO fact_game_rankings (
                        game_key, time_key, rank_position, previous_rank,
                        geek_rating, batch_id
                    ) VALUES (%s, %s, %s, %s, %s, %s)
                    ON DUPLICATE KEY UPDATE
                        rank_position = VALUES(rank_position),
                        previous_rank = VALUES(previous_rank),
                        geek_rating = VALUES(geek_rating)
                """
                self.target_cursor.execute(insert_query, (
                    game_key, self.current_date_key, game['rank_position'],
                    previous_rank, game['geek_rating'], self.batch_id
                ))
                inserted += 1
                
            except Error as e:
                self.logger.error(f"❌ Error loading ranking for game {game['game_id']}: {e}")
                
        self.target_conn.commit()
        self.logger.info(f"📥 Fact rankings loaded: {inserted} records")
        
    def update_aggregate_tables(self):
        """Update pre-calculated aggregate tables."""
        self.logger.info("📊 Updating aggregate tables...")
        
        try:
            # Update category performance aggregates
            category_agg_query = """
                INSERT INTO agg_category_performance (
                    category_key, total_games, avg_rating, avg_complexity,
                    total_community_owned, avg_rank_position
                )
                SELECT 
                    dc.category_key,
                    COUNT(DISTINCT dg.game_key) as total_games,
                    AVG(fgm.geek_rating) as avg_rating,
                    AVG(dg.complexity_rating) as avg_complexity,
                    SUM(fgm.community_owned) as total_community_owned,
                    AVG(fgm.rank_position) as avg_rank_position
                FROM dim_category dc
                JOIN bridge_game_category bgc ON dc.category_key = bgc.category_key
                JOIN dim_game dg ON bgc.game_key = dg.game_key AND dg.is_current = TRUE
                JOIN fact_game_metrics fgm ON dg.game_key = fgm.game_key
                JOIN dim_time dt ON fgm.time_key = dt.time_key
                WHERE dt.date_value = CURDATE()
                GROUP BY dc.category_key
                ON DUPLICATE KEY UPDATE
                    total_games = VALUES(total_games),
                    avg_rating = VALUES(avg_rating),
                    avg_complexity = VALUES(avg_complexity),
                    total_community_owned = VALUES(total_community_owned),
                    avg_rank_position = VALUES(avg_rank_position),
                    last_updated = CURRENT_TIMESTAMP
            """
            self.target_cursor.execute(category_agg_query)
            
            self.target_conn.commit()
            self.logger.info("📊 Aggregate tables updated successfully")
            
        except Error as e:
            self.logger.error(f"❌ Error updating aggregates: {e}")
            
    def run_etl(self, full_refresh: bool = False, batch_name: str = "Daily ETL"):
        """
        Execute the complete ETL pipeline.
        
        Args:
            full_refresh: Whether to perform full data refresh
            batch_name: Name for this ETL batch
        """
        try:
            self.logger.info("🚀 Starting Data Warehouse ETL Pipeline")
            
            # Initialize
            self.connect_databases()
            self.start_batch(batch_name)
            
            # Extract phase
            self.logger.info("📤 EXTRACT Phase Starting...")
            games = self.extract_games()
            designers = self.extract_entities("designers", "designer_id", "name")
            publishers = self.extract_entities("publishers", "publisher_id", "name")
            categories = self.extract_entities("categories", "category_id", "name")
            mechanisms = self.extract_entities("mechanisms", "mechanism_id", "name")
            
            # Transform & Load phase
            self.logger.info("🔄 TRANSFORM & LOAD Phase Starting...")
            
            # Load dimensions
            self.load_dimension_games(games, full_refresh)
            self.load_dimension_entities(designers, "dim_designer", "designer_id", "name")
            self.load_dimension_entities(publishers, "dim_publisher", "publisher_id", "name")
            self.load_dimension_entities(categories, "dim_category", "category_id", "name")
            self.load_dimension_entities(mechanisms, "dim_mechanism", "mechanism_id", "name")
            
            # Load facts
            self.load_fact_game_metrics(games)
            self.load_fact_game_rankings(games)
            
            # Update aggregates
            self.update_aggregate_tables()
            
            # Complete successfully
            self.end_batch("Success")
            self.logger.info("✅ ETL Pipeline completed successfully!")
            
        except Exception as e:
            error_msg = str(e)
            self.logger.error(f"❌ ETL Pipeline failed: {error_msg}")
            self.end_batch("Failed", error_msg)
            raise
        finally:
            self.disconnect_databases()

def main():
    """Main execution function with command line argument support."""
    parser = argparse.ArgumentParser(description='BoardGame Data Warehouse ETL Pipeline')
    parser.add_argument('--full-refresh', action='store_true', 
                       help='Perform full data refresh instead of incremental')
    parser.add_argument('--batch-name', type=str, default='Manual ETL',
                       help='Custom name for this ETL batch')
    
    args = parser.parse_args()
    
    # Database configurations
    source_config = {
        'host': 'localhost',
        'database': 'boardgame_db',
        'user': 'root',
        'password': '',
        'charset': 'utf8mb4'
    }
    
    target_config = {
        'host': 'localhost',
        'database': 'boardgame_dw',
        'user': 'root',
        'password': '',
        'charset': 'utf8mb4'
    }
    
    # Execute ETL
    etl = DataWarehouseETL(source_config, target_config)
    etl.run_etl(args.full_refresh, args.batch_name)

if __name__ == "__main__":
    main()
