import os
import sys
import logging

from typing import List, Dict, Any, Optional
from bs4 import BeautifulSoup

sys.path.append(os.path.join(os.path.dirname(__file__)))
from extractor.extractor import Extractor

class GenreExtractor(Extractor):
    """Extracts genre data from Spotify search page."""
    
    def __init__(self, browser) -> None:
        
        super().__init__(browser)
        self.genre_links: List[Dict[str, str]] = []
    
    def get_data(self) -> List[Dict[str, str]]:
        
        page_source = self.browser.page_source
        soup = BeautifulSoup(page_source, 'html.parser')
        
        genre_links = soup.find_all('a', {
            'class': 'CqCtb3wr4SK8AiZwxeH0',
            'draggable': 'false'
        })
        
        if not genre_links:
            genre_links = soup.find_all('a', href=lambda x: isinstance(x, str) and '/genre/' in x)
        
        extracted_links = []
        for link in genre_links:
            genre_data = self._process_genre_link(link)
            if genre_data:
                extracted_links.append(genre_data)
        
        self.genre_links = extracted_links
        self.data = extracted_links
        logging.info(f"[Genre] Successfully extracted {len(extracted_links)} genre links")

        return extracted_links
            
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
