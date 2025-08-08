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

class AlbumExtractor(Extractor):
    
    def __init__(self, browser) -> None:
        super().__init__(browser)
    
    def get_data(self, album_ids: List[str]) -> List[Dict[str, Any]]:
        self.data = []
        
        for album_id in album_ids:
            album_url = f"https://open.spotify.com/album/{album_id}"
            logging.info(f"[Album] Processing album: {album_url}")
            album_data = self._get_album_details(album_url, album_id)
            if album_data:
                self.data.append(album_data)
                logging.info(f"[Album] Successfully extracted: {album_data.get('title', 'Unknown')}")
            
            time.sleep(2)
        
        logging.info(f"[Album] Total albums extracted: {len(self.data)}")
        
        return self.data
    
    def _get_album_details(self, album_url: str, album_id: str) -> Optional[Dict[str, Any]]:
        try:
            self.browser.get(album_url)
            
            WebDriverWait(self.browser, 30).until(
                EC.presence_of_element_located((By.TAG_NAME, 'body'))
            )

            time.sleep(3)
            
            page_source = self.browser.page_source
            soup = BeautifulSoup(page_source, 'html.parser')
            
            details: Dict[str, Any] = {}
            details['album_id'] = album_id
            
            title_element = soup.find('h1', class_=re.compile(r'e-91000-text.*encore-text-headline-large'))
            if title_element and isinstance(title_element, Tag):
                details['title'] = title_element.get_text(strip=True)
            
            artist_link = soup.find('a', {'data-testid': 'creator-link'})
            if artist_link and isinstance(artist_link, Tag):
                href = artist_link.get('href')
                if href:
                    artist_id = str(href).split('/')[-1]
                    details['artist_id'] = artist_id
            
            release_date_raw = self._extract_release_date(soup)
            if release_date_raw:
                parsed_date = self._parse_release_date(release_date_raw)
                if parsed_date:
                    details['release_date'] = parsed_date
            
            song_count_element = soup.find('span', string=re.compile(r'\d+\s+songs?'))
            if song_count_element and isinstance(song_count_element, Tag):
                song_count_text = song_count_element.get_text(strip=True)
                song_count = self._parse_song_count(song_count_text)
                if song_count:
                    details['song_count'] = song_count
            
            duration_element = soup.find('span', class_='UyzJidwrGk3awngSGIwv')
            if duration_element and isinstance(duration_element, Tag):
                duration_text = duration_element.get_text(strip=True)
                duration_seconds = self._parse_duration(duration_text)
                if duration_seconds:
                    details['duration'] = duration_seconds
            
            return details
            
        except Exception as e:
            logging.warning(f"[Album] Failed to get details for album {album_id}: {str(e)}")
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
            logging.warning(f"[Album] Failed to extract release date: {str(e)}")
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
            
            if re.match(r'^\d{4}$', date_text):
                return f"{date_text}-01-01"
            
            logging.warning(f"[Album] Could not parse date format: '{date_text}'")
            return None
            
        except Exception as e:
            logging.warning(f"[Album] Error parsing date '{date_text}': {str(e)}")
            return None
    
    def _parse_song_count(self, song_count_text: str) -> Optional[int]:
        try:
            match = re.search(r'(\d+)\s+songs?', song_count_text)
            if match:
                return int(match.group(1))
            return None
            
        except Exception as e:
            logging.warning(f"[Album] Failed to parse song count '{song_count_text}': {str(e)}")
            return None
    
    def _parse_duration(self, duration_text: str) -> Optional[int]:
        try:
            duration_text = duration_text.strip().lower()
            total_seconds = 0
            
            hr_match = re.search(r'(\d+)\s*hr', duration_text)
            if hr_match:
                total_seconds += int(hr_match.group(1)) * 3600
            
            min_match = re.search(r'(\d+)\s*min', duration_text)
            if min_match:
                total_seconds += int(min_match.group(1)) * 60
            
            sec_match = re.search(r'(\d+)\s*sec', duration_text)
            if sec_match:
                total_seconds += int(sec_match.group(1))
            
            return total_seconds if total_seconds > 0 else None
            
        except Exception as e:
            logging.warning(f"[Album] Error parsing duration '{duration_text}': {str(e)}")
            return None