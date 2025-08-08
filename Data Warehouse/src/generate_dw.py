import pymysql
import os
from datetime import date
from typing import Dict
import logging
from dotenv import load_dotenv

load_dotenv('.env')

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)

class DataWarehouseGenerator:
    def __init__(self):
        self.connection = None
        self.cursor = None
        
    def connect(self) -> bool:
        """Establish database connection using environment variables."""
        try:
            self.connection = pymysql.connect(
                host=os.getenv('MYSQL_HOST', 'localhost'),
                port=int(os.getenv('MYSQL_PORT', '3306')),
                user=os.getenv('MYSQL_USER', 'root'),
                password=os.getenv('MYSQL_PASSWORD', ''),
                database=os.getenv('MYSQL_DATABASE', 'spotify'),
                charset='utf8mb4',
                autocommit=False
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
    
    def clear_warehouse_tables(self):
        """Clear all data warehouse tables."""
        try:
            tables = ['FactSpotify', 'DimDate', 'DimGenre', 'DimArtist', 'DimUser', 'DimAlbum', 'DimSong', 'DimPlaylist']
            
            for table in tables:
                self.cursor.execute(f"DELETE FROM {table}")
                logging.info(f"Cleared table: {table}")
            
            self.connection.commit()
            logging.info("All warehouse tables cleared successfully")
            
        except pymysql.Error as e:
            logging.error(f"Failed to clear warehouse tables: {e}")
            self.connection.rollback()
            raise
    
    def generate_date_dimension(self) -> None:
        """Generate date dimension from unique dates in songs and albums."""
        try:
            self.cursor.execute("""
                SELECT DISTINCT release_date 
                FROM Song 
                WHERE release_date IS NOT NULL
                UNION
                SELECT DISTINCT release_date 
                FROM Album 
                WHERE release_date IS NOT NULL
                ORDER BY release_date
            """)
            
            dates = self.cursor.fetchall()
            
            date_records = []
            for (date_value,) in dates:
                if isinstance(date_value, date):
                    date_key = int(date_value.strftime('%Y%m%d'))
                    year = date_value.year
                    month = date_value.month
                    day = date_value.day
                    
                    date_records.append((date_key, year, month, day))
            
            if date_records:
                self.cursor.executemany("""
                    INSERT INTO DimDate (date_key, year, month, day) 
                    VALUES (%s, %s, %s, %s)
                """, date_records)
                
                self.connection.commit()
                logging.info(f"Inserted {len(date_records)} date dimension records")
            
        except pymysql.Error as e:
            logging.error(f"Failed to generate date dimension: {e}")
            self.connection.rollback()
            raise
    
    def populate_dim_genre(self) -> Dict[str, int]:
        """Populate DimGenre and return mapping of genre_id to genre_key."""
        try:
            self.cursor.execute("SELECT genre_id, name FROM Genre")
            genres = self.cursor.fetchall()
            
            genre_mapping = {}
            for genre_id, name in genres:
                self.cursor.execute("""
                    INSERT INTO DimGenre (genre_id, name) 
                    VALUES (%s, %s)
                """, (genre_id, name))
                
                genre_key = self.cursor.lastrowid
                genre_mapping[genre_id] = genre_key
            
            self.connection.commit()
            logging.info(f"Inserted {len(genres)} genre dimension records")
            return genre_mapping
            
        except pymysql.Error as e:
            logging.error(f"Failed to populate genre dimension: {e}")
            self.connection.rollback()
            raise
    
    def populate_dim_artist(self) -> Dict[str, int]:
        """Populate DimArtist and return mapping of artist_id to artist_key."""
        try:
            self.cursor.execute("SELECT artist_id, name, status FROM Artist")
            artists = self.cursor.fetchall()
            
            artist_mapping = {}
            for artist_id, name, status in artists:
                self.cursor.execute("""
                    INSERT INTO DimArtist (artist_id, name, status) 
                    VALUES (%s, %s, %s)
                """, (artist_id, name, status))
                
                artist_key = self.cursor.lastrowid
                artist_mapping[artist_id] = artist_key
            
            self.connection.commit()
            logging.info(f"Inserted {len(artists)} artist dimension records")
            return artist_mapping
            
        except pymysql.Error as e:
            logging.error(f"Failed to populate artist dimension: {e}")
            self.connection.rollback()
            raise
    
    def populate_dim_user(self) -> Dict[str, int]:
        """Populate DimUser and return mapping of user_id to user_key."""
        try:
            self.cursor.execute("SELECT user_id, name, status FROM User")
            users = self.cursor.fetchall()
            
            user_mapping = {}
            for user_id, name, status in users:
                self.cursor.execute("""
                    INSERT INTO DimUser (user_id, name, status) 
                    VALUES (%s, %s, %s)
                """, (user_id, name, status))
                
                user_key = self.cursor.lastrowid
                user_mapping[user_id] = user_key
            
            self.connection.commit()
            logging.info(f"Inserted {len(users)} user dimension records")
            return user_mapping
            
        except pymysql.Error as e:
            logging.error(f"Failed to populate user dimension: {e}")
            self.connection.rollback()
            raise
    
    def populate_dim_album(self, artist_mapping: Dict[str, int]) -> Dict[str, int]:
        """Populate DimAlbum and return mapping of album_id to album_key."""
        try:
            self.cursor.execute("SELECT album_id, title, artist_id FROM Album")
            albums = self.cursor.fetchall()
            
            album_mapping = {}
            for album_id, title, artist_id in albums:
                artist_key = artist_mapping.get(artist_id)
                
                self.cursor.execute("""
                    INSERT INTO DimAlbum (album_id, title, artist_key) 
                    VALUES (%s, %s, %s)
                """, (album_id, title, artist_key))
                
                album_key = self.cursor.lastrowid
                album_mapping[album_id] = album_key
            
            self.connection.commit()
            logging.info(f"Inserted {len(albums)} album dimension records")
            return album_mapping
            
        except pymysql.Error as e:
            logging.error(f"Failed to populate album dimension: {e}")
            self.connection.rollback()
            raise
    
    def populate_dim_song(self, album_mapping: Dict[str, int]) -> Dict[tuple, int]:
        """Populate DimSong and return mapping of (album_id, track_order) to song_key."""
        try:
            self.cursor.execute("SELECT album_id, track_order, title FROM Song")
            songs = self.cursor.fetchall()
            
            song_mapping = {}
            for album_id, track_order, title in songs:
                album_key = album_mapping.get(album_id)
                
                self.cursor.execute("""
                    INSERT INTO DimSong (album_id, track_order, title, album_key) 
                    VALUES (%s, %s, %s, %s)
                """, (album_id, track_order, title, album_key))
                
                song_key = self.cursor.lastrowid
                song_mapping[(album_id, track_order)] = song_key
            
            self.connection.commit()
            logging.info(f"Inserted {len(songs)} song dimension records")
            return song_mapping
            
        except pymysql.Error as e:
            logging.error(f"Failed to populate song dimension: {e}")
            self.connection.rollback()
            raise
    
    def populate_dim_playlist(self, genre_mapping: Dict[str, int], user_mapping: Dict[str, int]) -> Dict[str, int]:
        """Populate DimPlaylist and return mapping of playlist_id to playlist_key."""
        try:
            self.cursor.execute("SELECT playlist_id, name, type, genre_id, creator_id FROM Playlist")
            playlists = self.cursor.fetchall()
            
            playlist_mapping = {}
            for playlist_id, name, playlist_type, genre_id, creator_id in playlists:
                genre_key = genre_mapping.get(genre_id)
                user_key = user_mapping.get(creator_id)
                
                self.cursor.execute("""
                    INSERT INTO DimPlaylist (playlist_id, name, type, genre_key, user_key) 
                    VALUES (%s, %s, %s, %s, %s)
                """, (playlist_id, name, playlist_type, genre_key, user_key))
                
                playlist_key = self.cursor.lastrowid
                playlist_mapping[playlist_id] = playlist_key
            
            self.connection.commit()
            logging.info(f"Inserted {len(playlists)} playlist dimension records")
            return playlist_mapping
            
        except pymysql.Error as e:
            logging.error(f"Failed to populate playlist dimension: {e}")
            self.connection.rollback()
            raise
    
    def populate_fact_table(self, genre_mapping: Dict[str, int], artist_mapping: Dict[str, int], 
                          user_mapping: Dict[str, int], album_mapping: Dict[str, int], 
                          song_mapping: Dict[tuple, int], playlist_mapping: Dict[str, int]) -> None:
        """Populate the fact table with aggregated data."""
        try:
            self.cursor.execute("""
                SELECT 
                    ps.playlist_id,
                    ps.album_id,
                    ps.track_order,
                    s.release_date,
                    p.save_count,
                    p.song_count as playlist_song_count,
                    p.genre_id,
                    p.creator_id,
                    s.title,
                    s.play_count,
                    s.duration,
                    a.artist_id,
                    ar.monthly_listeners,
                    ar.followers_count
                FROM Playlist_Song ps
                JOIN Playlist p ON ps.playlist_id = p.playlist_id
                JOIN Song s ON ps.album_id = s.album_id AND ps.track_order = s.track_order
                JOIN Album a ON ps.album_id = a.album_id
                JOIN Artist ar ON a.artist_id = ar.artist_id
            """)
            
            fact_records = []
            for record in self.cursor.fetchall():
                (playlist_id, album_id, track_order, release_date, save_count, playlist_song_count,
                 genre_id, creator_id, song_title, play_count, duration, artist_id, 
                 monthly_listeners, followers_count) = record
                
                date_key = None
                if release_date:
                    date_key = int(release_date.strftime('%Y%m%d'))
                
                genre_key = genre_mapping.get(genre_id)
                artist_key = artist_mapping.get(artist_id)
                user_key = user_mapping.get(creator_id)
                album_key = album_mapping.get(album_id)
                song_key = song_mapping.get((album_id, track_order))
                playlist_key = playlist_mapping.get(playlist_id)
                
                fact_records.append((
                    date_key, genre_key, artist_key, album_key, song_key, playlist_key, user_key,
                    save_count or 0, playlist_song_count or 0, followers_count or 0, 
                    monthly_listeners or 0, play_count or 0, duration or 0
                ))
            
            if fact_records:
                self.cursor.executemany("""
                    INSERT INTO FactSpotify (
                        date_key, genre_key, artist_key, album_key, song_key, playlist_key, user_key,
                        save_count, song_count, followers_count, monthly_listeners, play_count, duration
                    ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
                """, fact_records)
                
                self.connection.commit()
                logging.info(f"Inserted {len(fact_records)} fact table records")
            
        except pymysql.Error as e:
            logging.error(f"Failed to populate fact table: {e}")
            self.connection.rollback()
            raise


def main():
    """Main function to generate data warehouse."""
    dw = DataWarehouseGenerator()
    
    try:
        if not dw.connect():
            return
        
        logging.info("Clearing warehouse tables...")
        dw.clear_warehouse_tables()
        
        logging.info("Generating data warehouse dimensions...")
        
        logging.info("Generating date dimension...")
        dw.generate_date_dimension()
        
        logging.info("Populating genre dimension...")
        genre_mapping = dw.populate_dim_genre()
        
        logging.info("Populating artist dimension...")
        artist_mapping = dw.populate_dim_artist()
        
        logging.info("Populating user dimension...")
        user_mapping = dw.populate_dim_user()
        
        logging.info("Populating album dimension...")
        album_mapping = dw.populate_dim_album(artist_mapping)
        
        logging.info("Populating song dimension...")
        song_mapping = dw.populate_dim_song(album_mapping)
        
        logging.info("Populating playlist dimension...")
        playlist_mapping = dw.populate_dim_playlist(genre_mapping, user_mapping)
        
        logging.info("Populating fact table...")
        dw.populate_fact_table(genre_mapping, artist_mapping, user_mapping, 
                              album_mapping, song_mapping, playlist_mapping)
        
        logging.info("Data warehouse generation completed successfully!")
        
    except Exception as e:
        logging.error(f"Data warehouse generation failed: {e}")
    finally:
        dw.disconnect()


if __name__ == "__main__":
    main()