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

sys.path.append(os.path.join(os.path.dirname(__file__)))
from extractor.extractor import Extractor

class UserExtractor(Extractor):
    
    def __init__(self, browser) -> None:
        super().__init__(browser)
    
    def get_data(self, user_ids: List[str]) -> List[Dict[str, Any]]:
        self.data = []
        
        for user_id in user_ids:
            user_url = f"https://open.spotify.com/user/{user_id}"
            logging.info(f"[User] Processing user: {user_url}")
            user_data = self._get_user_details(user_url, user_id)
            if user_data:
                self.data.append(user_data)
                logging.info(f"[User] Successfully extracted: {user_id}")
            
            time.sleep(2)
        
        logging.info(f"[User] Total users extracted: {len(self.data)}")
        
        return self.data
    
    def _get_user_details(self, user_url: str, user_id: str) -> Optional[Dict[str, Any]]:
        try:
            self.browser.get(user_url)
            
            WebDriverWait(self.browser, 30).until(
                EC.presence_of_element_located((By.TAG_NAME, 'body'))
            )

            time.sleep(3)
            
            page_source = self.browser.page_source
            soup = BeautifulSoup(page_source, 'html.parser')
            
            details: Dict[str, Any] = {}
            details['user_id'] = user_id
            
            name_element = soup.find('span', {'data-testid': 'entityTitle'})
            if name_element and isinstance(name_element, Tag):
                h1_element = name_element.find('h1')
                if h1_element and isinstance(h1_element, Tag):
                    details['name'] = h1_element.get_text(strip=True)
            
            verified_svg = soup.find('svg', {'data-encore-id': 'verifiedBadge'})
            if isinstance(verified_svg, Tag):
                title_element = verified_svg.find('title')
                if title_element and isinstance(title_element, Tag):
                    details['status'] = 'Verified'
                else:
                    details['status'] = 'Verified'
            else:
                details['status'] = 'Not Verified'
            
            span_elements = soup.find_all('span', {'data-encore-id': 'text'})
            for span in span_elements:
                if isinstance(span, Tag):
                    text = span.get_text(strip=True).lower()
                    
                    if 'followers' in text and 'following' not in text:
                        count = self._parse_count(text, 'followers')
                        if count is not None:
                            details['followers_count'] = count
                    
                    elif 'following' in text:
                        count = self._parse_count(text, 'following')
                        if count is not None:
                            details['following_count'] = count
                    
                    elif 'public playlists' in text:
                        count = self._parse_count(text, 'public playlists')
                        if count is not None:
                            details['public_playlist_count'] = count
            
            return details
            
        except Exception as e:
            logging.warning(f"[User] Failed to get details for user {user_id}: {str(e)}")
            return None
    
    def _parse_count(self, text: str, label: str) -> Optional[int]:
        try:
            pattern = r'([\d,]+)\s+' + re.escape(label)
            match = re.search(pattern, text)
            if match:
                return int(match.group(1).replace(',', ''))
            return None
            
        except Exception as e:
            logging.warning(f"[User] Failed to parse count from '{text}': {str(e)}")
            return None