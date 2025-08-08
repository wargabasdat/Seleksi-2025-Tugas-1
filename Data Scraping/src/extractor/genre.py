import os
import sys
import logging
import time

from typing import List, Dict, Any, Optional
from bs4 import BeautifulSoup
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.common.exceptions import TimeoutException

sys.path.append(os.path.join(os.path.dirname(__file__)))
from extractor.extractor import Extractor

class GenreExtractor(Extractor):
    """Extracts genre data from Spotify search page."""
    
    def __init__(self, browser) -> None:
        
        super().__init__(browser)
        self.genre_links: List[Dict[str, str]] = []
    
    def get_data(self) -> List[Dict[str, str]]:
        try:
            logging.info("[Genre] Waiting for genre content to load...")
            
            wait = WebDriverWait(self.browser, 30)
            wait.until(EC.presence_of_element_located((By.CSS_SELECTOR, "a[href*='/genre/']")))
            
            time.sleep(3)
            
            page_source = self.browser.page_source
            soup = BeautifulSoup(page_source, 'html.parser')
            
            genre_links = soup.find_all('a', href=lambda x: isinstance(x, str) and '/genre/' in x)
            
            if not genre_links:
                logging.warning("[Genre] No genre links found with href selector, trying alternative selectors...")
                genre_links = soup.find_all('a', {'draggable': 'false'})
                genre_links = [link for link in genre_links if link.get('href') and '/genre/' in link.get('href')]
            
            extracted_links = []
            for link in genre_links:
                genre_data = self._process_genre_link(link)
                if genre_data:
                    extracted_links.append(genre_data)
            
            self.genre_links = extracted_links
            self.data = extracted_links
            logging.info(f"[Genre] Successfully extracted {len(extracted_links)} genre links")

            return extracted_links
            
        except TimeoutException:
            logging.error("[Genre] Timeout waiting for genre content to load")
            return []
        except Exception as e:
            logging.error(f"[Genre] Error extracting genre data: {e}")
            return []
            
    def _process_genre_link(self, link: Any) -> Optional[Dict[str, str]]:
        
        href = link.get('href')
        if not href or not href.startswith('/genre/'):
            return None
        
        span = link.find('span', class_=lambda x: x and 'e-91000-text' in str(x))
        genre_name = span.get('title') if span else 'Unknown'

        excluded_genres = {
            'Podcast', 'Made For You', 'Discover', 'Live Events',
            'Music', 'Decades', 'Charts', 'Musik Indonesia', 'Spotify Singles'
        }
        
        if any(excluded in genre_name for excluded in excluded_genres):
            return None
    
        full_url = f"https://open.spotify.com{href}"
        genre_id = href.split('/')[-1]
        
        return {
            'genre_id': genre_id,
            'name': genre_name
        }
