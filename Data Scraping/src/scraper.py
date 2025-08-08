import logging
import os
import sys
from typing import List, Dict, Optional, Any
from selenium import webdriver
from selenium.common.exceptions import WebDriverException
from selenium.webdriver.chrome.service import Service

sys.path.append(os.path.join(os.path.dirname(__file__)))
from extractor.genre import GenreExtractor
from extractor.playlist import PlaylistExtractor
from extractor.playlist_song import PlaylistSongExtractor
from extractor.song import SongExtractor
from extractor.song_artist import SongArtistExtractor
from extractor.artist import ArtistExtractor
from extractor.album import AlbumExtractor
from extractor.user import UserExtractor

class SpotifyScraper:
    """Main scraper class for extracting Spotify data."""
    
    def __init__(self, start_url: str, chromedriver_path: str, chrome_path: str) -> None:

        self.start_url = start_url
        self.genres: List[Dict[str, Any]] = []
        self.playlists: List[Dict[str, Any]] = []
        self.playlist_songs: List[Dict[str, Any]] = []
        self.songs: List[Dict[str, Any]] = []
        self.song_artists: List[Dict[str, Any]] = []
        self.artists: List[Dict[str, Any]] = []
        self.albums: List[Dict[str, Any]] = []
        self.users: List[Dict[str, Any]] = []
        
        self.browser = self._initialize_browser(chromedriver_path, chrome_path)
        self.genre_extractor = GenreExtractor(self.browser)
        self.playlist_extractor = PlaylistExtractor(self.browser)
        self.playlist_song_extractor = PlaylistSongExtractor(self.browser)
        self.song_extractor = SongExtractor(self.browser)
        self.song_artist_extractor = SongArtistExtractor(self.browser)
        self.artist_extractor = ArtistExtractor(self.browser)
        self.album_extractor = AlbumExtractor(self.browser)
        self.user_extractor = UserExtractor(self.browser)
        
        self.browser.get(self.start_url)
    
    def _initialize_browser(self, chromedriver_path: str, chrome_path: str) -> webdriver.Chrome:

        chrome_options = webdriver.ChromeOptions()
        chrome_options.add_argument('--disable-infobars')
        chrome_options.add_argument('--disable-notifications')
        chrome_options.add_argument('--start-maximized')
        chrome_options.add_argument('--disable-dev-shm-usage')
        chrome_options.add_argument('--no-sandbox')
        chrome_options.add_argument('--disable-logging')
        chrome_options.add_argument('--log-level=3')
        chrome_options.add_experimental_option('excludeSwitches', ['enable-logging'])
        chrome_options.add_experimental_option('useAutomationExtension', False)
        chrome_options.binary_location = chrome_path
        
        try:
            browser = webdriver.Chrome(
                service=Service(chromedriver_path),
                options=chrome_options
            )
            browser.set_page_load_timeout(60)
            return browser
        
        except WebDriverException as e:
            logging.error(f"[Main] Failed to initialize browser: {str(e)}")
            raise

    def _process_genre(self) -> None:
        
        genre_file = "Data Scraping/data/genre.json"
        if os.path.exists(genre_file):
            try:
                import json
                with open(genre_file, 'r', encoding='utf-8') as f:
                    self.genres = json.load(f)
                print(f"\n[Main] Loaded {len(self.genres)} existing genres from file")
                return
            except Exception as e:
                logging.warning(f"[Genre] Failed to load existing file, will re-extract: {str(e)}")

        try:
            self.genres = self.genre_extractor.get_data()
        except Exception as e:
            logging.error(f"[Genre] {str(e)}")
            raise
        
        if not self.genres:
            return
        
        self.genres.sort(key=lambda x: x['name'].lower())
        
        for genre in self.genres[:10]:
            genre_url = f"https://open.spotify.com/genre/{genre['genre_id']}"
            print(f"- {genre['name']}: {genre_url}")
        if len(self.genres) > 10:
            print(f"... and {len(self.genres) - 10} more\n")
        
        try:
            self.genre_extractor.save_to_json(genre_file)
        except Exception as e:
            logging.error(f"[Genre] Error saving genres: {str(e)}")
            raise

    def _process_playlist(self, playlist_limit: Optional[int] = None) -> None:
        """Extract and save playlist data from genres
        
        Args:
            playlist_limit: Maximum number of playlists to extract from each genre
        
        Raises:
            WebDriverException: If browser automation fails
            Exception: If any step in the playlist extraction process fails
        """

        if not self.genres:
            logging.warning("[Playlist] No genres available for playlist extraction")
            return
        
        playlist_file = "Data Scraping/data/playlist.json"
        if os.path.exists(playlist_file):
            logging.info(f"[Playlist] File {playlist_file} already exists, loading existing data")
            try:
                import json
                with open(playlist_file, 'r', encoding='utf-8') as f:
                    self.playlists = json.load(f)
                print(f"\n[Main] Loaded {len(self.playlists)} existing playlists from file")
                return
            except Exception as e:
                logging.warning(f"[Playlist] Failed to load existing file, will re-extract: {str(e)}")
        
        try:
            self.playlists = self.playlist_extractor.get_data(self.genres, playlist_limit)
        except Exception as e:
            logging.error(f"[Playlist] {str(e)}")
            raise
        
        if not self.playlists:
            print("No playlists found!")
            return
        
        print(f"\n[Main] Total playlists found: {len(self.playlists)}")
        
        print(f"\n[Main] Sample playlists:")
        for playlist in self.playlists[:5]:
            print(f"- {playlist['name']} (Type: {playlist.get('type', 'Unknown')})")
        
        if len(self.playlists) > 5:
            print(f"... and {len(self.playlists) - 5} more\n")
        
        try:
            self.playlist_extractor.save_to_json("Data Scraping/data/playlist.json")
        except Exception as e:
            logging.error(f"[Playlist] Error saving playlists: {str(e)}")
            raise

    def _process_song(self) -> None:
        
        song_map = self.playlist_song_extractor.get_song_map()
        if not song_map:
            logging.warning("[Song] No song map available for song extraction")
            return
        
        song_file = "Data Scraping/data/song.json"
        if os.path.exists(song_file):
            try:
                import json
                with open(song_file, 'r', encoding='utf-8') as f:
                    self.songs = json.load(f)
                print(f"\n[Main] Loaded {len(self.songs)} existing songs from file")
                return
            except Exception as e:
                logging.warning(f"[Song] Failed to load existing file, will re-extract: {str(e)}")
        
        logging.info(f"[Song] Found {len(song_map)} unique songs to extract")
        
        try:
            self.songs = self.song_extractor.get_data(song_map)
        except Exception as e:
            logging.error(f"[Song] {str(e)}")
            raise
        
        if not self.songs:
            print("No songs found!")
            return
        
        print(f"\n[Main] Total songs found: {len(self.songs)}")
        
        print(f"\n[Main] Sample songs:")
        for song in self.songs[:5]:
            print(f"- {song.get('title', 'Unknown')} by {song.get('artist_name', 'Unknown Artist')}")
        
        if len(self.songs) > 5:
            print(f"... and {len(self.songs) - 5} more\n")
        
        try:
            self.song_extractor.save_to_json("Data Scraping/data/song.json")
        except Exception as e:
            logging.error(f"[Song] Error saving songs: {str(e)}")
            raise

    def _process_song_artist(self) -> None:
        
        if not self.songs:
            logging.warning("[SongArtist] No songs available for song-artist relationship extraction")
            return
        
        song_artist_file = "Data Scraping/data/song_artist.json"
        if os.path.exists(song_artist_file):
            try:
                import json
                with open(song_artist_file, 'r', encoding='utf-8') as f:
                    self.song_artists = json.load(f)
                print(f"\n[Main] Loaded {len(self.song_artists)} existing song-artist relationships from file")
                return
            except Exception as e:
                logging.warning(f"[SongArtist] Failed to load existing file, will re-extract: {str(e)}")
        
        song_artist_map = self.song_extractor.get_song_artist_map()
        
        if not song_artist_map:
            logging.warning("[SongArtist] No song-artist mapping available")
            return
        
        try:
            self.song_artists = self.song_artist_extractor.get_data(song_artist_map)
        except Exception as e:
            logging.error(f"[SongArtist] {str(e)}")
            raise
        
        if not self.song_artists:
            print("No song-artist relationships found!")
            return
        
        print(f"\n[Main] Total song-artist relationships found: {len(self.song_artists)}")
        
        print(f"\n[Main] Sample relationships:")
        for relationship in self.song_artists[:5]:
            album_id = relationship.get('album_id', 'Unknown')
            track_order = relationship.get('track_order', 'Unknown')
            artist_id = relationship.get('artist_id', 'Unknown')
            print(f"- Album {album_id}, Track {track_order} -> Artist {artist_id}")
        
        if len(self.song_artists) > 5:
            print(f"... and {len(self.song_artists) - 5} more\n")
        
        try:
            self.song_artist_extractor.save_to_json("Data Scraping/data/song_artist.json")
        except Exception as e:
            logging.error(f"[SongArtist] Error saving relationships: {str(e)}")
            raise

    def _process_artist(self) -> None:
        
        if not self.songs:
            logging.warning("[Artist] No songs available for artist extraction")
            return
        
        artist_file = "Data Scraping/data/artist.json"
        if os.path.exists(artist_file):
            try:
                import json
                with open(artist_file, 'r', encoding='utf-8') as f:
                    self.artists = json.load(f)
                print(f"\n[Main] Loaded {len(self.artists)} existing artists from file")
                return
            except Exception as e:
                logging.warning(f"[Artist] Failed to load existing file, will re-extract: {str(e)}")
        
        artist_ids = set()
        
        song_artist_file = "Data Scraping/data/song_artist.json"
        if os.path.exists(song_artist_file):
            try:
                import json
                with open(song_artist_file, 'r', encoding='utf-8') as f:
                    song_artist_data = json.load(f)
                for relationship in song_artist_data:
                    if relationship.get('artist_id'):
                        artist_ids.add(relationship['artist_id'])
                logging.info(f"[Artist] Loaded {len(artist_ids)} artist IDs from song_artist.json")
            except Exception as e:
                logging.warning(f"[Artist] Failed to load artist IDs from song_artist.json: {str(e)}")
        
        if not artist_ids:
            logging.warning("[Artist] No artist IDs available")
            return
        
        artist_ids = list(artist_ids)
        
        logging.info(f"[Artist] Found {len(artist_ids)} unique artists to extract")
        
        try:
            self.artists = self.artist_extractor.get_data(artist_ids)
        except Exception as e:
            logging.error(f"[Artist] {str(e)}")
            raise
        
        if not self.artists:
            print("No artists found!")
            return
        
        print(f"\n[Main] Total artists found: {len(self.artists)}")
        
        print(f"\n[Main] Sample artists:")
        for artist in self.artists[:5]:
            print(f"- {artist.get('name', 'Unknown')} ({artist.get('monthly_listeners', 0):,} monthly listeners)")
        
        if len(self.artists) > 5:
            print(f"... and {len(self.artists) - 5} more\n")
        
        try:
            self.artist_extractor.save_to_json("Data Scraping/data/artist.json")
        except Exception as e:
            logging.error(f"[Artist] Error saving artists: {str(e)}")
            raise

    def _process_album(self) -> None:
        
        album_file = "Data Scraping/data/album.json"
        if os.path.exists(album_file):
            try:
                import json
                with open(album_file, 'r', encoding='utf-8') as f:
                    self.albums = json.load(f)
                print(f"\n[Main] Loaded {len(self.albums)} existing albums from file")
                return
            except Exception as e:
                logging.warning(f"[Album] Failed to load existing file, will re-extract: {str(e)}")
        
        album_ids = set()
        
        song_artist_file = "Data Scraping/data/song_artist.json"
        if os.path.exists(song_artist_file):
            try:
                import json
                with open(song_artist_file, 'r', encoding='utf-8') as f:
                    song_artist_data = json.load(f)
                for relationship in song_artist_data:
                    if relationship.get('album_id'):
                        album_ids.add(relationship['album_id'])
                logging.info(f"[Album] Loaded {len(album_ids)} album IDs from song_artist.json")
            except Exception as e:
                logging.warning(f"[Album] Failed to load album IDs from song_artist.json: {str(e)}")
        
        if not album_ids:
            song_map = self.playlist_song_extractor.get_song_map()
            if song_map:
                for song_info in song_map.values():
                    if song_info.get('album_id'):
                        album_ids.add(song_info['album_id'])
                if album_ids:
                    logging.info(f"[Album] Using {len(album_ids)} album IDs from playlist_song extractor")
        
        if not album_ids:
            logging.warning("[Album] No album IDs available")
            return
        
        album_ids = list(album_ids)
        
        logging.info(f"[Album] Found {len(album_ids)} unique albums to extract")
        
        try:
            self.albums = self.album_extractor.get_data(album_ids)
        except Exception as e:
            logging.error(f"[Album] {str(e)}")
            raise
        
        if not self.albums:
            print("No albums found!")
            return
        
        print(f"\n[Main] Total albums found: {len(self.albums)}")
        
        print(f"\n[Main] Sample albums:")
        for album in self.albums[:5]:
            print(f"- {album.get('title', 'Unknown')} ({album.get('song_count', 0)} songs)")
        
        if len(self.albums) > 5:
            print(f"... and {len(self.albums) - 5} more\n")
        
        try:
            self.album_extractor.save_to_json("Data Scraping/data/album.json")
        except Exception as e:
            logging.error(f"[Album] Error saving albums: {str(e)}")
            raise

    def _process_user(self) -> None:
        
        user_file = "Data Scraping/data/user.json"
        if os.path.exists(user_file):
            try:
                import json
                with open(user_file, 'r', encoding='utf-8') as f:
                    self.users = json.load(f)
                print(f"\n[Main] Loaded {len(self.users)} existing users from file")
                return
            except Exception as e:
                logging.warning(f"[User] Failed to load existing file, will re-extract: {str(e)}")
        
        user_ids = set()
        
        playlist_file = "Data Scraping/data/playlist.json"
        if os.path.exists(playlist_file):
            try:
                import json
                with open(playlist_file, 'r', encoding='utf-8') as f:
                    playlist_data = json.load(f)
                for playlist in playlist_data:
                    if playlist.get('creator_id'):
                        user_ids.add(playlist['creator_id'])
                logging.info(f"[User] Loaded {len(user_ids)} user IDs from playlist.json")
            except Exception as e:
                logging.warning(f"[User] Failed to load user IDs from playlist.json: {str(e)}")
        
        if not user_ids:
            logging.warning("[User] No user IDs available")
            return
        
        user_ids = list(user_ids)
        
        logging.info(f"[User] Found {len(user_ids)} unique users to extract")
        
        try:
            self.users = self.user_extractor.get_data(user_ids)
        except Exception as e:
            logging.error(f"[User] {str(e)}")
            raise
        
        if not self.users:
            print("No users found!")
            return
        
        print(f"\n[Main] Total users found: {len(self.users)}")
        
        print(f"\n[Main] Sample users:")
        for user in self.users[:5]:
            status = user.get('status', 'Unknown')
            followers = user.get('followers_count', 0)
            print(f"- {user.get('user_id', 'Unknown')} ({status}, {followers:,} followers)")
        
        if len(self.users) > 5:
            print(f"... and {len(self.users) - 5} more\n")
        
        try:
            self.user_extractor.save_to_json("Data Scraping/data/user.json")
        except Exception as e:
            logging.error(f"[User] Error saving users: {str(e)}")
            raise

    def _process_playlist_song(self, chosen_playlists: Optional[List[str]] = None, song_limit: Optional[int] = None) -> None:
        """Extract and save playlist-song relationship data
        
        Args:
            chosen_playlists: List of playlist names to filter for detailed extraction
            song_limit: Maximum number of songs to extract from each playlist
        
        Raises:
            Exception: If any step in the playlist-song extraction process fails
        """

        if not self.playlists:
            logging.warning("[PlaylistSong] No playlists available for song extraction")
            return
        
        # Always extract playlist_song to generate song map for other extractors
        try:
            self.playlist_songs = self.playlist_song_extractor.get_data(self.playlists, chosen_playlists, song_limit)
        except Exception as e:
            logging.error(f"[PlaylistSong] {str(e)}")
            raise
        
        if not self.playlist_songs:
            print("No playlist-song relationships found!")
            return
        
        print(f"\n[Main] Total playlist-song relationships found: {len(self.playlist_songs)}")
        
        try:
            self.playlist_song_extractor.save_to_json("Data Scraping/data/playlist_song.json")
        except Exception as e:
            logging.error(f"[PlaylistSong] Error saving relationships: {str(e)}")
            raise

    def _generate_summary(self) -> None:
        """Generate a summary report of all extracted data"""
        try:
            with open("Data Scraping/data/summary.txt", "w", encoding="utf-8") as f:
                f.write("=== SPOTIFY DATA EXTRACTION SUMMARY ===\n\n")
                
                f.write(f"Total Genres: {len(self.genres) if self.genres else 0}\n\n")
                
                if self.playlists and self.genres:
                    f.write("Playlist Count by Genre:\n")
                    f.write("-" * 50 + "\n")
                    
                    genre_playlist_count = {}
                    for playlist in self.playlists:
                        genre_id = playlist.get('genre_id')
                        if genre_id:
                            genre_playlist_count[genre_id] = genre_playlist_count.get(genre_id, 0) + 1
                    
                    for genre in self.genres:
                        genre_id = genre['genre_id']
                        genre_name = genre['name']
                        playlist_count = genre_playlist_count.get(genre_id, 0)
                        f.write(f"{genre_name:<30} | {playlist_count:>3} playlists\n")
                    
                    f.write("-" * 50 + "\n")
                    f.write(f"Total Playlists: {len(self.playlists)}\n\n")
                
                if self.playlist_songs:
                    f.write(f"Total Playlist-Song Relationships: {len(self.playlist_songs)}\n\n")
                
                if self.songs:
                    f.write(f"Total Songs: {len(self.songs)}\n\n")
                
                if self.song_artists:
                    f.write(f"Total Song-Artist Relationships: {len(self.song_artists)}\n\n")
                
                if self.artists:
                    f.write(f"Total Artists: {len(self.artists)}\n\n")
                
                if self.albums:
                    f.write(f"Total Albums: {len(self.albums)}\n\n")
                
                if self.users:
                    f.write(f"Total Users: {len(self.users)}\n\n")
                
                if self.playlists:
                    basic_playlists = [p for p in self.playlists if len(p) == 4]

                    f.write(f"Playlists with Detailed Info Only: {len(self.playlists) - len(basic_playlists)}\n\n")
                    f.write(f"Playlists with Basic Info Only: {len(basic_playlists)}\n")

                    for playlist in basic_playlists:
                        f.write(f"{playlist['name']}\n")

                f.write("Extraction completed successfully!\n")
                
            logging.info("[Main] Summary saved to summary.txt")
            
        except Exception as e:
            logging.warning(f"[Main] Failed to generate summary: {str(e)}")

    def run(self, playlist_limit: Optional[int] = None, chosen_playlists: Optional[List[str]] = None, song_limit: Optional[int] = None) -> None:

        try:
            self._process_genre()
            self._process_playlist(playlist_limit)
            self._process_playlist_song(chosen_playlists, song_limit)
            self._process_song()
            self._process_song_artist()
            self._process_artist()
            self._process_album()
            self._process_user()
            self._generate_summary()

        except WebDriverException as e:
            logging.error(f"[Main - WebDriverException] {str(e)}")

        except Exception as e:
            logging.error(f"[Main - Exception] {str(e)}")

    def close_browser(self) -> None:
        if hasattr(self, 'browser') and self.browser:
            self.browser.quit()