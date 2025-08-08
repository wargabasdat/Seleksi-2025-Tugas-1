import os
import sys
import logging
import time
import re

from typing import List, Dict, Any, Optional
from bs4 import BeautifulSoup, Tag
from selenium.webdriver.common.by import By
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.common.action_chains import ActionChains

sys.path.append(os.path.join(os.path.dirname(__file__)))
from extractor.extractor import Extractor

class ArtistExtractor(Extractor):
    """Extracts artist data from Spotify artist pages."""
    
    def __init__(self, browser) -> None:
        super().__init__(browser)
    
    def get_data(self, artist_ids: List[str]) -> List[Dict[str, Any]]:
        
        self.data = []
        
        for artist_id in artist_ids:
            artist_url = f"https://open.spotify.com/artist/{artist_id}"
            logging.info(f"[Artist] Processing artist: {artist_url}")
            artist_data = self._get_artist_details(artist_url, artist_id)
            if artist_data:
                self.data.append(artist_data)
                logging.info(f"[Artist] Successfully extracted: {artist_data.get('name', 'Unknown')}")
            
            time.sleep(2)
        
        logging.info(f"[Artist] Total artists extracted: {len(self.data)}")
        
        return self.data
    
    def _get_artist_details(self, artist_url: str, artist_id: str) -> Optional[Dict[str, Any]]:
        
        try:
            self.browser.get(artist_url)
            
            WebDriverWait(self.browser, 30).until(
                EC.presence_of_element_located((By.TAG_NAME, 'body'))
            )

            time.sleep(3)
            
            page_source = self.browser.page_source
            soup = BeautifulSoup(page_source, 'html.parser')
            
            details: Dict[str, Any] = {}
            details['artist_id'] = artist_id

            name_element = soup.find('h1', class_=lambda x: bool(x) and 'e-91000-text' in x and 'encore-text-headline-large' in x)
            if name_element and isinstance(name_element, Tag):
                details['name'] = name_element.get_text(strip=True)
                
            status_elements = soup.find_all('span', {'data-encore-id': 'text'})
            verified_found = False
            for element in status_elements:
                if isinstance(element, Tag):
                    text = element.get_text(strip=True)
                    if 'verified' in text.lower():
                        details['status'] = 'Verified'
                        verified_found = True
                        break
            
            if not verified_found:
                details['status'] = 'Not Verified'
            
            listeners_element = soup.find('span', class_='Ydwa1P5GkCggtLlSvphs')
            if listeners_element and isinstance(listeners_element, Tag):
                listeners_text = listeners_element.get_text(strip=True)
                monthly_listeners = self._parse_monthly_listeners(listeners_text)
                if monthly_listeners is not None:
                    details['monthly_listeners'] = monthly_listeners
            
            followers_count = self._extract_followers()
            if followers_count is not None:
                details['followers_count'] = followers_count
            
            return details
            
        except Exception as e:
            logging.warning(f"[Artist] Failed to get details for artist {artist_id}: {str(e)}")
            return None
    
    def _parse_monthly_listeners(self, listeners_text: str) -> Optional[int]:
        try:
            match = re.search(r'([\d,]+)\s+monthly listeners', listeners_text.lower())
            if match:
                return int(match.group(1).replace(',', ''))
            return None
            
        except Exception as e:
            logging.warning(f"[Artist] Failed to parse monthly listeners '{listeners_text}': {str(e)}")
            return None
    
    def _extract_followers(self) -> Optional[int]:
        try:
            artist_buttons = self.browser.find_elements(By.XPATH, "//button[contains(., 'monthly listeners')]")
            if not artist_buttons:
                return None
            
            actions = ActionChains(self.browser)
            actions.click(artist_buttons[0]).perform()
            time.sleep(3)
            
            updated_soup = BeautifulSoup(self.browser.page_source, 'html.parser')
            
            followers_divs = updated_soup.find_all('div', {'data-encore-id': 'text'})
            for div in followers_divs:
                if isinstance(div, Tag):
                    div_text = div.get_text(strip=True)
                    if re.match(r'^[\d,]+$', div_text):
                        next_div = div.find_next_sibling('div')
                        if next_div and 'followers' in next_div.get_text().lower():
                            try:
                                self.browser.find_element(By.TAG_NAME, 'body').click()
                            except:
                                pass
                            return int(div_text.replace(',', ''))
            
            modal_text = updated_soup.get_text()
            followers_match = re.search(r'([\d,]+)\s+followers?', modal_text.lower())
            if followers_match:
                try:
                    self.browser.find_element(By.TAG_NAME, 'body').click()
                except:
                    pass
                return int(followers_match.group(1).replace(',', ''))
            
            try:
                self.browser.find_element(By.TAG_NAME, 'body').click()
            except:
                pass
            
            return None
            
        except Exception as e:
            logging.warning(f"[Artist] Failed to extract followers: {str(e)}")
            return None