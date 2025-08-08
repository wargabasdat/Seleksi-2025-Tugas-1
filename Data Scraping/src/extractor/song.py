import os
import sys
import logging
import time
import re

from datetime import datetime
from typing import List, Dict, Any, Optional
from bs4 import BeautifulSoup, Tag
from selenium.webdriver.common.by import By
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.common.action_chains import ActionChains

sys.path.append(os.path.join(os.path.dirname(__file__)))
from extractor.extractor import Extractor

class SongExtractor(Extractor):
    
    def __init__(self, browser) -> None:
        super().__init__(browser)
        self.artist_ids: set = set()
        self.song_artist_map: Dict[tuple, List[str]] = {}
    
    def get_data(self, song_map: Dict[str, Dict[str, Any]]) -> List[Dict[str, Any]]:
        self.data = []
        
        for map_key, song_info in song_map.items():
            song_url = song_info['song_url']
            album_id = song_info['album_id']
            track_order = song_info['track_order']
            
            logging.info(f"[Song] Processing song: {song_url}")
            song_data = self._get_song_details(song_url, album_id, track_order)
            if song_data:
                self.data.append(song_data)
                logging.info(f"[Song] Successfully extracted: {song_data.get('title', 'Unknown')}")
            
            time.sleep(2)
        
        logging.info(f"[Song] Total songs extracted: {len(self.data)}")
        
        return self.data
    
    def get_artist_ids(self) -> List[str]:
        return list(self.artist_ids)
    
    def get_song_artist_map(self) -> Dict[tuple, List[str]]:
        return self.song_artist_map.copy()
    
    def _get_song_details(self, song_url: str, album_id: str, track_order: int) -> Optional[Dict[str, Any]]:
        """Navigate to song page and extract detailed information
        
        Args:
            song_url: Full URL of the song page
            
        Returns:
            Dictionary with detailed song data or None if extraction fails
        """
        
        try:
            self.browser.get(song_url)
            
            try:
                WebDriverWait(self.browser, 30).until(
                    lambda driver: driver.find_elements(By.TAG_NAME, 'body') and
                                  driver.find_elements(By.CSS_SELECTOR, 'span[data-testid="entityTitle"] h1')
                )
            except:
                logging.warning("[Song] Timeout waiting for page to load")
            
            time.sleep(3)
            
            page_source = self.browser.page_source
            soup = BeautifulSoup(page_source, 'html.parser')
            
            details: Dict[str, Any] = {}
            details['album_id'] = album_id
            details['track_order'] = track_order
            
            title_element = soup.find('span', {'data-testid': 'entityTitle'})
            if title_element and isinstance(title_element, Tag):
                h1_element = title_element.find('h1')
                if h1_element and isinstance(h1_element, Tag):
                    details['title'] = h1_element.get_text(strip=True)

            artist_ids = self._extract_artists(soup)
            if artist_ids:
                for artist_id in artist_ids:
                    self.artist_ids.add(artist_id)
                
                # Store in song_artist_map using (album_id, track_order) as key
                map_key = (album_id, track_order)
                self.song_artist_map[map_key] = artist_ids
            
            release_date_raw = self._extract_release_date(soup)
            if release_date_raw:
                parsed_date = self._parse_release_date(release_date_raw)
                if parsed_date:
                    details['release_date'] = parsed_date
            
            playcount_element = soup.find('span', {'data-testid': 'playcount'})
            if playcount_element and isinstance(playcount_element, Tag):
                playcount_text = playcount_element.get_text(strip=True)
                play_count = self._parse_playcount(playcount_text)
                if play_count:
                    details['play_count'] = play_count
            
            duration_elements = soup.find_all('span', {'data-encore-id': 'text'})
            for elem in duration_elements:
                if isinstance(elem, Tag):
                    text = elem.get_text(strip=True)
                    if re.match(r'^\d+:\d+$', text):
                        duration_seconds = self._convert_duration_to_seconds(text)
                        if duration_seconds:
                            details['duration'] = duration_seconds
                        break
            
            return details
            
        except Exception as e:
            logging.warning(f"[Song] Failed to get details for song {song_url}: {str(e)}")
            return None
    
    def _extract_release_date(self, soup: BeautifulSoup) -> Optional[str]:
        
        try:
            date_element = soup.find('span', {'data-testid': 'release-date'})
            if not date_element:
                return None
            
            basic_date = date_element.get_text(strip=True)
            try:
                date_elem_selenium = self.browser.find_element(By.CSS_SELECTOR, 'span[data-testid="release-date"]')
                actions = ActionChains(self.browser)
                actions.move_to_element(date_elem_selenium).perform()
                time.sleep(1)
                
                updated_element = self.browser.find_element(By.CSS_SELECTOR, 'span[data-testid="release-date"]')
                title_attr = updated_element.get_attribute('title')
                if title_attr and title_attr != basic_date:
                    return title_attr
                
                for selector in ['[role="tooltip"]', '.tooltip', '[data-testid="tooltip"]']:
                    tooltip_elements = self.browser.find_elements(By.CSS_SELECTOR, selector)
                    for tooltip in tooltip_elements:
                        tooltip_text = tooltip.text.strip()
                        if tooltip_text and tooltip_text != basic_date and len(tooltip_text) > len(basic_date):
                            return tooltip_text
                
            except Exception:
                pass
            
            return basic_date
            
        except Exception as e:
            logging.warning(f"[Song] Failed to extract release date: {str(e)}")
            return None
    
    def _convert_duration_to_seconds(self, duration_text: str) -> Optional[int]:
        try:
            if ':' not in duration_text:
                return None
            
            parts = duration_text.split(':')
            if len(parts) == 2:
                minutes = int(parts[0])
                seconds = int(parts[1])
                return minutes * 60 + seconds
            elif len(parts) == 3:  # Handle H:MM:SS format
                hours = int(parts[0])
                minutes = int(parts[1])
                seconds = int(parts[2])
                return hours * 3600 + minutes * 60 + seconds
            
            return None
            
        except Exception as e:
            logging.warning(f"[Song] Failed to parse duration '{duration_text}': {str(e)}")
            return None
    
    def _parse_playcount(self, playcount_text: str) -> Optional[int]:
        try:
            return int(playcount_text.replace(',', ''))
            
        except Exception as e:
            logging.warning(f"[Song] Failed to parse play count '{playcount_text}': {str(e)}")
            return None
    
    def _parse_release_date(self, date_text: str) -> Optional[str]:
        try:
            date_text = date_text.strip().lower()
            
            month_names = {
                'jan': 1, 'january': 1, 'feb': 2, 'february': 2, 'mar': 3, 'march': 3,
                'apr': 4, 'april': 4, 'may': 5, 'jun': 6, 'june': 6,
                'jul': 7, 'july': 7, 'aug': 8, 'august': 8, 'sep': 9, 'sept': 9, 'september': 9,
                'oct': 10, 'october': 10, 'nov': 11, 'november': 11, 'dec': 12, 'december': 12
            }
            
            pattern = r'(\d{1,2})\s+(jan|january|feb|february|mar|march|apr|april|may|jun|june|jul|july|aug|august|sep|sept|september|oct|october|nov|november|dec|december)\s+(\d{4})'
            match = re.search(pattern, date_text)
            if match:
                day, month_name, year = match.groups()
                month = month_names[month_name]
                return datetime(int(year), month, int(day)).strftime('%Y-%m-%d')
            
            pattern = r'(jan|january|feb|february|mar|march|apr|april|may|jun|june|jul|july|aug|august|sep|sept|september|oct|october|nov|november|dec|december)\s+(\d{1,2}),\s+(\d{4})'
            match = re.search(pattern, date_text)
            if match:
                month_name, day, year = match.groups()
                month = month_names[month_name]
                return datetime(int(year), month, int(day)).strftime('%Y-%m-%d')
            
            logging.warning(f"[Song] Could not parse date format: '{date_text}'")
            return None
            
        except Exception as e:
            logging.warning(f"[Song] Error parsing date '{date_text}': {str(e)}")
            return None
    
    def _extract_artists(self, soup: BeautifulSoup) -> List[str]:
        try:
            artist_ids = []
            
            artist_cards = soup.find_all('div', {'data-testid': 'track-artist-link-card'})
            for card in artist_cards:
                if isinstance(card, Tag):
                    artist_links = card.find_all('a', href=lambda x: isinstance(x, str) and '/artist/' in x)
                    for link in artist_links:
                        if isinstance(link, Tag):
                            href = link.get('href')
                            if href:
                                artist_id = str(href).split('/')[-1]
                                if artist_id and artist_id not in artist_ids:
                                    artist_ids.append(artist_id)
            
            if not artist_ids:
                artist_link = soup.find('a', {'data-testid': 'creator-link'})
                if artist_link and isinstance(artist_link, Tag):
                    href = artist_link.get('href')
                    if href:
                        artist_id = str(href).split('/')[-1]
                        artist_ids.append(artist_id)
            
            return artist_ids
            
        except Exception as e:
            logging.warning(f"[Song] Error extracting artists: {str(e)}")
            return []
    
