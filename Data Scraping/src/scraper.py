import logging
import os
import sys
from typing import List, Dict, Optional
from selenium import webdriver
from selenium.common.exceptions import WebDriverException
from selenium.webdriver.chrome.service import Service

sys.path.append(os.path.join(os.path.dirname(__file__)))
from extractor.genre import GenreExtractor
from extractor.playlist import PlaylistExtractor

class SpotifyScraper:
    """Main scraper class for extracting Spotify data
    
    Attributes:
        start_url: Initial Spotify search URL
        genre_links: List of extracted genre data
        collections: List of extracted collection data
        browser: Selenium WebDriver instance
    """
    
    def __init__(self, start_url: str, chromedriver_path: str, chrome_path: str) -> None:
        """Initialize the SpotifyScraper with browser configuration
        
        Args:
            start_url: Initial Spotify search URL to begin scraping
            chromedriver_path: File path to ChromeDriver executable
            chrome_path: File path to Chrome browser executable
            
        Raises:
            WebDriverException: If browser initialization fails
        """

        self.start_url = start_url
        self.genres: List[Dict[str, str]] = []
        self.playlists: List[Dict[str, str]] = []
        
        self.browser = self._initialize_browser(chromedriver_path, chrome_path)
        self.genre_extractor = GenreExtractor(self.browser)
        self.playlist_extractor = PlaylistExtractor(self.browser)
        
        
        self.browser.get(self.start_url)
        logging.info(f"[Main] Navigated to {self.start_url}")
    
    def _initialize_browser(self, chromedriver_path: str, chrome_path: str) -> webdriver.Chrome:
        """
        Args:
            chromedriver_path: File path to ChromeDriver executable
            chrome_path: File path to Chrome browser executable
            
        Returns:
            Configured Chrome WebDriver instance
            
        Raises:
            WebDriverException: If browser initialization fails
        """

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
            logging.info("[Main] Browser initialized successfully")
            return browser
        
        except WebDriverException as e:
            logging.error(f"[Main] Failed to initialize browser: {str(e)}")
            raise

    def _process_genre(self) -> None:
        """Extract and save genre data

        Raises:
            WebDriverException: If browser automation fails
            Exception: If any step in the genre extraction process fails
        """
        
        genre_file = "Data Scraping/data/genre.json"
        if os.path.exists(genre_file):
            logging.info(f"[Genre] File {genre_file} already exists, loading existing data")
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
            logging.info("[Genre] No genres found!")
            return
        
        self.genres.sort(key=lambda x: x['name'].lower())
        logging.info(f"[Genre] Sorted {len(self.genres)} genres alphabetically")
        
        for genre in self.genres[:10]:
            print(f"- {genre['name']}: {genre['url']}")
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

            logging.info("[Main] Summary saved to summary.txt")
            
        except Exception as e:
            logging.warning(f"[Main] Failed to generate summary: {str(e)}")

    def run(self, playlist_limit: Optional[int] = None) -> None:
        """Run the complete scraping process
        
        Args:
            playlist_limit: Maximum number of playlists to extract from each genre.
                           If None, extracts all playlists found.
        
        Orchestrates the full Spotify data extraction workflow
        
        Raises:
            WebDriverException: If browser automation fails
            Exception: If any step in the scraping process fails
        """

        try:
            logging.info("[Main] Starting genre extraction...")
            self._process_genre()
            logging.info("[Main] Genre extraction completed successfully")

            logging.info("[Main] Starting playlist extraction...")
            self._process_playlist(playlist_limit)
            logging.info("[Main] Playlist extraction completed successfully")

        except WebDriverException as e:
            logging.error(f"[Main - WebDriverException] {str(e)}")

        except Exception as e:
            logging.error(f"[Main - Exception] {str(e)}")

    def close_browser(self) -> None:
        """Safely terminates the Chrome WebDriver session."""

        if hasattr(self, 'browser') and self.browser:
            self.browser.quit()