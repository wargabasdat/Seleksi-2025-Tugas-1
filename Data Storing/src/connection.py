import json
import pymysql
import os
from datetime import datetime
from typing import Dict, List, Any, Optional
import logging
from dotenv import load_dotenv

# Load environment variables from root directory
load_dotenv('.env')

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)

class DatabaseConnection:
    def __init__(self):
        self.connection = None
        self.cursor = None
        
    def connect(self) -> bool:
        """Establish database connection using environment variables."""
        try:
            print("host:", os.getenv('MYSQL_HOST'))
            print("port:", os.getenv('MYSQL_PORT'))
            print("user:", os.getenv('MYSQL_USER'))
            print("password:", os.getenv('MYSQL_PASSWORD'))
            print("database:", os.getenv('MYSQL_DATABASE'))

            self.connection = pymysql.connect(
                host=os.getenv('MYSQL_HOST'),
                port=int(os.getenv('MYSQL_PORT')),
                user=os.getenv('MYSQL_USER'),
                password=os.getenv('MYSQL_PASSWORD'),
                database=os.getenv('MYSQL_DATABASE'),
                charset='utf8mb4',
                autocommit=False,
            )
            self.cursor = self.connection.cursor()
            logging.info("Successfully connected to database")
            return True
        except pymysql.Error as e:
            logging.error(f"Failed to connect to database: {e}")
            return False
    
    def disconnect(self):
        """Close database connection."""
        if self.cursor:
            self.cursor.close()
        if self.connection:
            self.connection.close()
        logging.info("Database connection closed")
    
    def clear_all_tables(self):
        """Clear all tables in dependency order."""
        try:
            # Disable foreign key checks temporarily
            self.cursor.execute("SET FOREIGN_KEY_CHECKS = 0")
            
            # Clear tables in reverse dependency order
            tables = [
                'Playlist_Song',
                'Song_Artist', 
                'Song',
                'Album',
                'Playlist',
                'Artist',
                'User',
                'Genre'
            ]
            
            for table in tables:
                self.cursor.execute(f"DELETE FROM {table}")
                logging.info(f"Cleared table: {table}")
            
            # Re-enable foreign key checks
            self.cursor.execute("SET FOREIGN_KEY_CHECKS = 1")
            self.connection.commit()
            logging.info("All tables cleared successfully")
            
        except pymysql.Error as e:
            logging.error(f"Failed to clear tables: {e}")
            self.connection.rollback()
            raise
    
    def load_json_data(self, filepath: str) -> List[Dict[str, Any]]:
        """Load data from JSON file."""
        try:
            with open(filepath, 'r', encoding='utf-8') as f:
                data = json.load(f)
            logging.info(f"Loaded {len(data)} records from {filepath}")
            return data
        except FileNotFoundError:
            logging.warning(f"File not found: {filepath}")
            return []
        except json.JSONDecodeError as e:
            logging.error(f"Failed to parse JSON from {filepath}: {e}")
            return []
    
    def insert_genres(self, data: List[Dict[str, Any]]):
        """Insert genre data."""
        if not data:
            return
            
        query = "INSERT IGNORE INTO Genre (genre_id, name) VALUES (%s, %s)"
        values = [(record['genre_id'], record['name']) for record in data]
        
        try:
            self.cursor.executemany(query, values)
            self.connection.commit()
            logging.info(f"Inserted {len(values)} genres")
        except pymysql.Error as e:
            logging.error(f"Failed to insert genres: {e}")
            self.connection.rollback()
            raise
    
    def insert_artists(self, data: List[Dict[str, Any]]):
        """Insert artist data."""
        if not data:
            return
            
        query = """
        INSERT IGNORE INTO Artist (artist_id, name, status, monthly_listeners, followers_count) 
        VALUES (%s, %s, %s, %s, %s)
        """
        values = []
        for record in data:
            values.append((
                record['artist_id'],
                record['name'],
                record.get('status', 'Not Verified'),
                record.get('monthly_listeners'),
                record.get('followers_count')
            ))
        
        try:
            self.cursor.executemany(query, values)
            self.connection.commit()
            logging.info(f"Inserted {len(values)} artists")
        except pymysql.Error as e:
            logging.error(f"Failed to insert artists: {e}")
            self.connection.rollback()
            raise
    
    def insert_users(self, data: List[Dict[str, Any]]):
        """Insert user data."""
        if not data:
            return
            
        query = """
        INSERT IGNORE INTO User (user_id, name, status, followers_count, following_count, public_playlist_count) 
        VALUES (%s, %s, %s, %s, %s, %s)
        """
        values = []
        for record in data:
            values.append((
                record['user_id'],
                record['name'],
                record.get('status', 'Not Verified'),
                record.get('followers_count'),
                record.get('following_count'),
                record.get('public_playlist_count')
            ))
        
        try:
            self.cursor.executemany(query, values)
            self.connection.commit()
            logging.info(f"Inserted {len(values)} users")
        except pymysql.Error as e:
            logging.error(f"Failed to insert users: {e}")
            self.connection.rollback()
            raise
    
    def insert_playlists(self, data: List[Dict[str, Any]]):
        """Insert playlist data."""
        if not data:
            return
            
        query = """
        INSERT IGNORE INTO Playlist (playlist_id, genre_id, name, save_count, song_count, 
                                   duration, type, description, creator_id) 
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
        """
        values = []
        for record in data:
            values.append((
                record['playlist_id'],
                record.get('genre_id'),
                record['name'],
                record.get('save_count'),
                record.get('song_count'),
                record.get('duration'),
                record.get('type'),
                record.get('description'),
                record.get('creator_id')
            ))
        
        try:
            self.cursor.executemany(query, values)
            self.connection.commit()
            logging.info(f"Inserted {len(values)} playlists")
        except pymysql.Error as e:
            logging.error(f"Failed to insert playlists: {e}")
            self.connection.rollback()
            raise
    
    def insert_albums(self, data: List[Dict[str, Any]]):
        """Insert album data."""
        if not data:
            return
            
        query = """
        INSERT IGNORE INTO Album (album_id, artist_id, title, release_date, song_count, duration) 
        VALUES (%s, %s, %s, %s, %s, %s)
        """
        values = []
        for record in data:
            release_date = None
            if record.get('release_date'):
                try:
                    release_date = datetime.strptime(record['release_date'], '%Y-%m-%d').date()
                except ValueError:
                    logging.warning(f"Invalid date format for album {record['album_id']}: {record['release_date']}")
            
            values.append((
                record['album_id'],
                record.get('artist_id'),
                record['title'],
                release_date,
                record.get('song_count'),
                record.get('duration')
            ))
        
        try:
            self.cursor.executemany(query, values)
            self.connection.commit()
            logging.info(f"Inserted {len(values)} albums")
        except pymysql.Error as e:
            logging.error(f"Failed to insert albums: {e}")
            self.connection.rollback()
            raise
    
    def insert_songs(self, data: List[Dict[str, Any]]):
        """Insert song data."""
        if not data:
            return
            
        query = """
        INSERT IGNORE INTO Song (album_id, track_order, title, release_date, play_count, duration) 
        VALUES (%s, %s, %s, %s, %s, %s)
        """
        values = []
        for record in data:
            release_date = None
            if record.get('release_date'):
                try:
                    release_date = datetime.strptime(record['release_date'], '%Y-%m-%d').date()
                except ValueError:
                    logging.warning(f"Invalid date format for song {record['album_id']}-{record['track_order']}: {record['release_date']}")
            
            values.append((
                record['album_id'],
                record['track_order'],
                record['title'],
                release_date,
                record.get('play_count'),
                record.get('duration')
            ))
        
        try:
            self.cursor.executemany(query, values)
            self.connection.commit()
            logging.info(f"Inserted {len(values)} songs")
        except pymysql.Error as e:
            logging.error(f"Failed to insert songs: {e}")
            self.connection.rollback()
            raise
    
    def insert_song_artists(self, data: List[Dict[str, Any]]):
        """Insert song-artist relationships."""
        if not data:
            return
            
        query = """
        INSERT IGNORE INTO Song_Artist (artist_id, album_id, track_order) 
        VALUES (%s, %s, %s)
        """
        values = [(record['artist_id'], record['album_id'], record['track_order']) for record in data]
        
        try:
            self.cursor.executemany(query, values)
            self.connection.commit()
            logging.info(f"Inserted {len(values)} song-artist relationships")
        except pymysql.Error as e:
            logging.error(f"Failed to insert song-artist relationships: {e}")
            self.connection.rollback()
            raise
    
    def insert_playlist_songs(self, data: List[Dict[str, Any]]):
        """Insert playlist-song relationships."""
        if not data:
            return
            
        query = """
        INSERT IGNORE INTO Playlist_Song (playlist_id, album_id, track_order, added_date) 
        VALUES (%s, %s, %s, %s)
        """
        values = []
        for record in data:
            added_date = None
            if record.get('added_date'):
                try:
                    added_date = datetime.strptime(record['added_date'], '%Y-%m-%d').date()
                except ValueError:
                    logging.warning(f"Invalid date format for playlist song: {record['added_date']}")
            
            values.append((
                record['playlist_id'],
                record['album_id'],
                record['track_order'],
                added_date
            ))
        
        try:
            self.cursor.executemany(query, values)
            self.connection.commit()
            logging.info(f"Inserted {len(values)} playlist-song relationships")
        except pymysql.Error as e:
            logging.error(f"Failed to insert playlist-song relationships: {e}")
            self.connection.rollback()
            raise


def main():
    """Main function to load all data into database."""
    # Base path for JSON files
    data_path = "Data Scraping/data"
    
    db = DatabaseConnection()
    
    try:
        if not db.connect():
            return
        
        logging.info("Clearing all tables...")
        db.clear_all_tables()
        
        logging.info("Starting data insertion...")
        
        logging.info("Inserting base tables...")
        db.insert_genres(db.load_json_data(f"{data_path}/genre.json"))
        db.insert_artists(db.load_json_data(f"{data_path}/artist.json"))
        
        # Check if user.json exists and load users
        user_data_path = f"{data_path}/user.json"
        if os.path.exists(user_data_path):
            db.insert_users(db.load_json_data(user_data_path))
        else:
            logging.warning("user.json not found, skipping user insertion")
        
        logging.info("Creating albums without song counts...")
        db.insert_albums(db.load_json_data(f"{data_path}/album.json"))
        
        logging.info("Inserting songs...")
        db.insert_songs(db.load_json_data(f"{data_path}/song.json"))
        
        logging.info("Inserting playlists...")
        db.insert_playlists(db.load_json_data(f"{data_path}/playlist.json"))
        
        logging.info("Inserting junction tables...")
        db.insert_song_artists(db.load_json_data(f"{data_path}/song_artist.json"))
        db.insert_playlist_songs(db.load_json_data(f"{data_path}/playlist_song.json"))
        
        logging.info("Data insertion completed successfully!")
        
    except Exception as e:
        logging.error(f"Data insertion failed: {e}")
    finally:
        db.disconnect()

if __name__ == "__main__":
    main()