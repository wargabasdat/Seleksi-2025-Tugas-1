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

class PlaylistExtractor(Extractor):
    """Extracts playlist data from Spotify genre collection pages."""
    
    def __init__(self, browser) -> None:
        
        super().__init__(browser)
        self.user_id_map: Dict[str, str] = {}
        self.processed_playlist_ids: Dict[str, str] = {}
    
    def get_data(self, genres: List[Dict[str, str]], playlist_limit: Optional[int] = None) -> List[Dict[str, Any]]:

        self.data = []
        self.duplicate_info = []
        self.processed_playlist_ids = {}
        
        for genre in genres:
            genre_name = genre['name']
            genre_id = genre['genre_id']
            genre_url = f"https://open.spotify.com/genre/{genre_id}"
            
            logging.info(f"[Playlist] Processing playlists for genre: {genre_name}")
            playlists = self._get_playlists_from_genre(genre_url, genre_id, playlist_limit)
            self.data.extend(playlists)
            
            time.sleep(2)
        
        self._save_duplicate_info()
        
        logging.info(f"[Playlist] Total playlists extracted: {len(self.data)}")

        return self.data
    
    def get_user_id_map(self) -> Dict[str, str]:
        return self.user_id_map.copy()
    
    
    def _get_playlists_from_genre(self, genre_url: str, genre_id: str, playlist_limit: Optional[int] = None) -> List[Dict[str, Any]]:

        self.browser.get(genre_url)
        
        WebDriverWait(self.browser, 15).until(
            EC.presence_of_element_located((By.TAG_NAME, 'body'))
        )
        
        time.sleep(3)
        
        page_source = self.browser.page_source
        soup = BeautifulSoup(page_source, 'html.parser')
        
        playlist_links = soup.find_all('a', {
            'class': 'Gi6Lr1whYBA2jutvHvjQ',
            'tabindex': '-1'
        })
        
        # Fallback selector for playlist links
        if not playlist_links:
            playlist_links = soup.find_all('a', href=lambda x: isinstance(x, str) and '/playlist/' in x)
        
        extracted_playlists = []
        
        for link in playlist_links:
            
            if isinstance(link, Tag):
                href = link.get('href')
                if not href or '/playlist/' not in str(href):
                    continue
                
                href_str = str(href) if href else ''
                playlist_id = href_str.split('/')[-1] if '/' in href_str else href_str
                
                title_attr = link.get('title')
                playlist_name = str(title_attr).strip() if title_attr else ''
                
                if not playlist_name:
                    title_element = link.find('p', {'data-encore-id': 'cardTitle'})
                    if title_element and isinstance(title_element, Tag):
                        playlist_name = title_element.get_text(strip=True)
                
                if not playlist_name:
                    continue
                
                if playlist_id in self.processed_playlist_ids:
                    original_genre_id = self.processed_playlist_ids[playlist_id]
                    self.duplicate_info.append({
                        'playlist_id': playlist_id,
                        'name': playlist_name,
                        'original_genre': original_genre_id,
                        'new_genre': genre_id,
                        'action': 'skipped_duplicate'
                    })
                    logging.info(f"[Playlist] Skipping duplicate playlist: {playlist_name} (Original: {original_genre_id}, New: {genre_id})")
                    continue

                playlist_data = self._process_playlist_link(link, genre_id)
                if playlist_data:
                    extracted_playlists.append(playlist_data)
                    self.processed_playlist_ids[playlist_id] = genre_id
                    logging.info(f"[Playlist] Found new playlist: {playlist_name}")
                    
                    if playlist_limit is not None and len(extracted_playlists) >= playlist_limit:
                        logging.info(f"[Playlist] Reached playlist limit ({playlist_limit}) for genre {genre_id}")
                        break
        
        logging.info(f"[Playlist] Successfully extracted {len(extracted_playlists)} new playlists from genre")

        return extracted_playlists
    
    def _process_playlist_link(self, link: Tag, genre_id: str) -> Optional[Dict[str, Any]]:
        """Process a single playlist link and extract basic data
        
        Args:
            link: BeautifulSoup element representing a playlist link
            genre_id: Genre identifier to associate with the playlist
            
        Returns:
            Dictionary with playlist data or None if extraction fails
        """

        href = link.get('href')
        if not href or '/playlist/' not in str(href):
            return None
        
        title_attr = link.get('title')
        playlist_name = str(title_attr).strip() if title_attr else ''
        
        if not playlist_name:
            title_element = link.find('p', {'data-encore-id': 'cardTitle'})
            if title_element and isinstance(title_element, Tag):
                playlist_name = title_element.get_text(strip=True)
        
        if not playlist_name:
            return None
        
        href_str = str(href) if href else ''
        full_url = f"https://open.spotify.com{href_str}" if href_str.startswith('/') else href_str
        playlist_id = href_str.split('/')[-1] if '/' in href_str else href_str

        detailed_data = self._get_playlist_details(full_url, playlist_id)
        
        base_data = {
            'playlist_id': playlist_id,
            'genre_id': genre_id,
            'name': playlist_name
        }

        if detailed_data:
            base_data.update(detailed_data)
            return base_data
        return None
    
    def _get_playlist_details(self, playlist_url: str, playlist_id: str) -> Optional[Dict[str, Any]]:
        
        try:
            self.browser.get(playlist_url)
            
            try:
                WebDriverWait(self.browser, 30).until(
                    lambda driver: (
                        # Basic page
                        driver.find_elements(By.TAG_NAME, 'body') and
                        # Title
                        driver.find_elements(By.CSS_SELECTOR, 'span[data-testid="entityTitle"]') and
                        # Description area (even if empty)
                        (driver.find_elements(By.CSS_SELECTOR, '.xgmjVLxjqfcXK5BV_XyN') or True) and
                        # Creator link
                        (driver.find_elements(By.CSS_SELECTOR, 'a[data-testid="creator-link"]') or True) and
                        # Stats section (saves, songs, duration)
                        (driver.find_elements(By.CSS_SELECTOR, '.blfR_YJUsKUvdgTejBSb span') or
                         driver.find_elements(By.CSS_SELECTOR, 'span.poz9gZKE7xqFwgk231J4') or
                         driver.find_elements(By.CSS_SELECTOR, 'span[data-encore-id="text"]')) and
                        # Type/category
                        (driver.find_elements(By.CSS_SELECTOR, 'span.lp9Tfm4rsM9_pfbIE0zd') or True)
                    )
                )
            except:
                logging.warning(f"[Playlist] Timeout waiting for playlist details: {playlist_id}")
            
            time.sleep(3)
            
            page_source = self.browser.page_source
            soup = BeautifulSoup(page_source, 'html.parser')
            
            details = {}

            stats_section = soup.find('div', class_='blfR_YJUsKUvdgTejBSb')
            if stats_section and isinstance(stats_section, Tag):

                all_spans = stats_section.find_all('span')
                for span in all_spans:

                    if isinstance(span, Tag):
                        span_text = span.get_text(strip=True)

                        # Skip playlists with episodes (podcasts)
                        if 'episodes' in span_text:
                            logging.info(f"[Playlist] Skipping playlist with episodes (podcast): {playlist_id}")
                            return None

                        elif 'saves' in span_text:
                            saves_match = re.search(r'([\d,]+)', span_text)
                            if saves_match:
                                details['save_count'] = int(saves_match.group(1).replace(',', ''))

                        elif 'songs' in span_text or 'items' in span_text:
                            songs_match = re.search(r'(\d+)', span_text)
                            if songs_match:
                                details['song_count'] = int(songs_match.group(1))

                        elif span.get('class') and 'poz9gZKE7xqFwgk231J4' in str(span.get('class')):
                            details['duration'] = self._convert_duration_to_minutes(span_text)
                            
            type_elements = soup.find_all('span', {'data-encore-id': 'text'})
            for elem in type_elements:
                if isinstance(elem, Tag):
                    class_attr = elem.get('class')
                    if class_attr and 'lp9Tfm4rsM9_pfbIE0zd' in str(class_attr):
                        details['type'] = elem.get_text(strip=True)
                        break
            
            title_element = soup.find('span', {'data-testid': 'entityTitle'})
            if title_element and isinstance(title_element, Tag):
                h1_element = title_element.find('h1')
                if h1_element and isinstance(h1_element, Tag):
                    details['name'] = h1_element.get_text(strip=True)
            
            description_element = soup.find('div', class_='xgmjVLxjqfcXK5BV_XyN')
            if description_element and isinstance(description_element, Tag):
                details['description'] = description_element.get_text(strip=True).replace('"', '')
            
            creator_link = soup.find('a', {'data-testid': 'creator-link'})
            if creator_link and isinstance(creator_link, Tag):
                href = creator_link.get('href')
                username = creator_link.get_text(strip=True)

                # Extract user_id from href (e.g., "/user/spotify" -> "spotify")
                if href and username:
                    href_str = str(href)
                    user_id = href_str.split('/')[-1] if '/' in href_str else href_str
                    details['creator_id'] = user_id

                    # Store in user_id map for later user extraction
                    self.user_id_map[user_id] = username
            
            return details
            
        except Exception as e:
            logging.warning(f"[Playlist] Failed to get details for playlist {playlist_id}: {str(e)}")
            return None
    
    
    def _convert_duration_to_minutes(self, duration_text: str) -> Optional[int]:
        try:
            total_minutes = 0
            
            hour_match = re.search(r'(\d+)\s*hr', duration_text, re.IGNORECASE)
            if hour_match:
                total_minutes += int(hour_match.group(1)) * 60
            
            min_match = re.search(r'(\d+)\s*min', duration_text, re.IGNORECASE)
            if min_match:
                total_minutes += int(min_match.group(1))
            
            return total_minutes if total_minutes > 0 else None
            
        except Exception as e:
            logging.warning(f"[Playlist] Failed to parse duration '{duration_text}': {str(e)}")
            return None
    
    def _save_duplicate_info(self) -> None:
        try:
            with open("Data Scraping/data/duplicate_playlists.txt", "w", encoding="utf-8") as f:
                f.write("=== DUPLICATE PLAYLIST DEBUG INFO ===\n\n")
                
                if not self.duplicate_info:
                    f.write("No duplicates found during this extraction.\n")
                else:
                    for info in self.duplicate_info:
                        f.write(f"SKIPPED: {info['name']} (ID: {info['playlist_id']})\n")
                        f.write(f"  Original Genre: {info['original_genre']}\n")
                        f.write(f"  New Genre: {info['new_genre']}\n")
                        f.write("  Reason: Duplicate playlist - skipped to avoid duplicates\n\n")

                    f.write("Total duplicates found: {}\n".format(len(self.duplicate_info)))
                        
            logging.info(f"[Playlist] Saved duplicate info: {len(self.duplicate_info)} entries")
        except Exception as e:
            logging.warning(f"[Playlist] Failed to save duplicate debug info: {str(e)}")
