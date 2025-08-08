import os
import sys
import logging
import time
import re

from datetime import datetime, timedelta
from typing import List, Dict, Optional, Any
from bs4 import BeautifulSoup, Tag
from selenium.webdriver.common.by import By
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.ui import WebDriverWait

sys.path.append(os.path.join(os.path.dirname(__file__)))
from extractor.extractor import Extractor

class PlaylistSongExtractor(Extractor):
    
    def __init__(self, browser) -> None:
        super().__init__(browser)
        self.existing_relationships: set = set()
        self.song_map: Dict[str, Dict[str, Any]] = {}
    
    def get_data(self, playlists: List[Dict[str, Any]], chosen_playlists: Optional[List[str]] = None, song_limit: Optional[int] = None) -> List[Dict[str, str]]:
        
        all_relationships = []
        processed_playlists = 0
        
        logging.info(f"[PlaylistSong] Processing {len(playlists)} playlists")
        
        for playlist in playlists:
            playlist_name = playlist.get('name', '')
            playlist_id = playlist.get('playlist_id', '')
            playlist_url = f"https://open.spotify.com/playlist/{playlist_id}"
            
            if chosen_playlists and playlist_name not in chosen_playlists:
                continue
                
            logging.info(f"[PlaylistSong] Extracting songs for playlist: {playlist_name}")
            relationships = self._extract_playlist_songs(playlist_url, playlist_id, song_limit)
            
            if relationships:
                processed_playlists += 1
                logging.info(f"[PlaylistSong] Found {len(relationships)} songs in playlist: {playlist_name}")
                
                for relationship in relationships:
                    song_id = relationship['song_url'].split('/')[-1]
                    relationship_key = f"{relationship['playlist_id']}_{song_id}"
                    
                    if relationship_key not in self.existing_relationships:
                        all_relationships.append(relationship)
                        self.existing_relationships.add(relationship_key)
            
            time.sleep(2)

        # Assign track numbers after collecting all songs from all playlists
        self.data = self._assign_track_numbers_globally(all_relationships)
        
        playlist_type = "chosen" if chosen_playlists else "all"
        logging.info(f"[PlaylistSong] Processed {processed_playlists} {playlist_type} playlists")
            
        logging.info(f"[PlaylistSong] Total relationships extracted: {len(self.data)}")
        
        return self.data
    
    def _extract_playlist_songs(self, playlist_url: str, playlist_id: str, song_limit: Optional[int] = None) -> Optional[List[Dict[str, str]]]:
        try:
            self.browser.get(playlist_url)
            
            WebDriverWait(self.browser, 30).until(
                EC.presence_of_element_located((By.TAG_NAME, 'body'))
            )

            time.sleep(3)
            
            # Scroll to load all songs
            self._scroll_to_load_all_songs()
            
            page_source = self.browser.page_source
            soup = BeautifulSoup(page_source, 'html.parser')
            
            relationships = []
            track_rows = soup.find_all('div', {'role': 'row'})
            
            if not track_rows:
                track_links = soup.find_all('a', href=lambda x: isinstance(x, str) and '/track/' in x)
                for link in track_links:
                    if isinstance(link, Tag):
                        href = link.get('href')
                        if href and '/track/' in str(href):
                            song_id = str(href).split('/')[-1]
                            song_url = f"https://open.spotify.com/track/{song_id}"
                            
                            # Try to find album link near this track link
                            album_id = "unknown"
                            parent = link.find_parent()
                            if parent and isinstance(parent, Tag):
                                album_link = parent.find('a', href=lambda x: isinstance(x, str) and '/album/' in x)
                                if album_link and isinstance(album_link, Tag):
                                    album_href = album_link.get('href')
                                    if album_href:
                                        album_id = str(album_href).split('/')[-1]
                            
                            relationships.append({
                                'playlist_id': playlist_id,
                                'song_url': song_url,
                                'album_id': album_id,
                                'added_date': None
                            })
                            
                            if song_limit is not None and len(relationships) >= song_limit:
                                break
            else:
                for row in track_rows:
                    if isinstance(row, Tag):
                        track_link = row.find('a', href=lambda x: isinstance(x, str) and '/track/' in x)
                        if track_link and isinstance(track_link, Tag):
                            href = track_link.get('href')
                            if href and '/track/' in str(href):
                                song_id = str(href).split('/')[-1]
                                song_url = f"https://open.spotify.com/track/{song_id}"
                                
                                # Extract album_id from the same row
                                album_id = "unknown"
                                album_link = row.find('a', href=lambda x: isinstance(x, str) and '/album/' in x)
                                if album_link and isinstance(album_link, Tag):
                                    album_href = album_link.get('href')
                                    if album_href:
                                        album_id = str(album_href).split('/')[-1]
                                
                                added_date_raw = None
                                date_column = row.find('div', {'aria-colindex': '4'})
                                if date_column and isinstance(date_column, Tag):
                                    spans = date_column.find_all('span')
                                    date_span = None
                                    for span in spans:
                                        if isinstance(span, Tag):
                                            span_class = span.get('class')
                                            if span_class and any('encore-text-body-small' in str(cls) for cls in span_class):
                                                date_span = span
                                                break
                                            
                                    if date_span and isinstance(date_span, Tag):
                                        added_date_raw = date_span.get_text(strip=True)
                                
                                added_date = self._parse_added_date(added_date_raw) if added_date_raw else None
                                
                                relationships.append({
                                    'playlist_id': playlist_id,
                                    'song_url': song_url,
                                    'album_id': album_id,
                                    'added_date': added_date
                                })
                                
                                if song_limit is not None and len(relationships) >= song_limit:
                                    logging.info(f"[PlaylistSong] Limiting to {song_limit} songs for playlist {playlist_id}")
                                    break
            
            return relationships if relationships else None
            
        except Exception as e:
            logging.warning(f"[PlaylistSong] Failed to extract songs from playlist {playlist_id}: {str(e)}")
            return None
    
    def _parse_added_date(self, date_text: str) -> Optional[str]:
        """
        Args:
            date_text: Date text from Spotify
            
        Returns:
            Standardized date string in YYYY-MM-DD format, or None if parsing fails
        """
        
        try:
            date_text = date_text.strip().lower()
            today = datetime.now()
            
            # Relative dates with "ago"
            if 'ago' in date_text:
                time_match = re.search(r'(\d+)\s+(minute|hour|day|week)s?\s+ago', date_text)
                if time_match:
                    number = int(time_match.group(1))
                    unit = time_match.group(2)
                    
                    if unit == 'hour' or unit == 'minute':
                        calculated_date = today
                    elif unit == 'day':
                        calculated_date = today - timedelta(days=number)
                    elif unit == 'week':
                        calculated_date = today - timedelta(weeks=number)
                    else:
                        return 'unknown'
                    
                    return calculated_date.strftime('%Y-%m-%d')
            
            month_names = {
                'jan': 1, 'feb': 2, 'mar': 3, 'apr': 4, 'may': 5, 'jun': 6,
                'jul': 7, 'aug': 8, 'sep': 9, 'sept': 9, 'oct': 10, 'nov': 11, 'dec': 12
            }
            
            # Pattern: "7 Nov 2024"
            date_pattern = re.search(r'(\d{1,2})\s+(jan|feb|mar|apr|may|jun|jul|aug|sep|sept|oct|nov|dec)\s+(\d{4})', date_text)
            if date_pattern:
                day, month_name, year = date_pattern.groups()
                month = month_names[month_name]
                parsed_date = datetime(int(year), month, int(day))
                return parsed_date.strftime('%Y-%m-%d')
            
            # Pattern: "feb 5, 2024"
            date_pattern = re.search(r'(jan|feb|mar|apr|may|jun|jul|aug|sep|sept|oct|nov|dec)\s+(\d{1,2}),\s+(\d{4})', date_text)
            if date_pattern:
                month_name, day, year = date_pattern.groups()
                month = month_names[month_name]
                parsed_date = datetime(int(year), month, int(day))
                return parsed_date.strftime('%Y-%m-%d')
            
            logging.warning(f"[PlaylistSong] Could not parse date format: '{date_text}'")
            return None
            
        except Exception as e:
            logging.warning(f"[PlaylistSong] Error parsing date '{date_text}': {str(e)}")
            return None
    
    def _scroll_to_load_all_songs(self) -> None:
        """Scroll down to load all songs in the playlist"""
        try:
            last_height = self.browser.execute_script("return document.body.scrollHeight")
            scroll_attempts = 0
            max_attempts = 50  # Prevent infinite scrolling
            
            while scroll_attempts < max_attempts:
                # Scroll down to bottom
                self.browser.execute_script("window.scrollTo(0, document.body.scrollHeight);")
                
                # Wait for new content to load
                time.sleep(2)
                
                # Calculate new scroll height and compare
                new_height = self.browser.execute_script("return document.body.scrollHeight")
                
                if new_height == last_height:
                    # No more content loaded, break
                    break
                    
                last_height = new_height
                scroll_attempts += 1
            
            logging.info(f"[PlaylistSong] Completed scrolling after {scroll_attempts} attempts")
            
        except Exception as e:
            logging.warning(f"[PlaylistSong] Error during scrolling: {str(e)}")
    
    def _assign_track_numbers_globally(self, all_relationships: List[Dict[str, Any]]) -> List[Dict[str, Any]]:
        """Assign track numbers globally after collecting all songs from all playlists"""
        try:
            # Group all songs by album_id across all playlists
            album_songs: Dict[str, List[Dict[str, Any]]] = {}
            
            for relationship in all_relationships:
                album_id = relationship.get('album_id', 'unknown')
                if album_id not in album_songs:
                    album_songs[album_id] = []
                album_songs[album_id].append(relationship)
            
            # Assign track numbers within each album and create final relationships
            final_relationships = []
            
            for album_id, songs in album_songs.items():
                for track_order, song_data in enumerate(songs, 1):
                    final_relationship = {
                        'playlist_id': song_data['playlist_id'],
                        'album_id': album_id,
                        'track_order': track_order,
                        'added_date': song_data['added_date']
                    }
                    final_relationships.append(final_relationship)
                    
                    # Store in map for other extractors
                    map_key = f"{song_data['playlist_id']}_{album_id}_{track_order}"
                    self.song_map[map_key] = {
                        'album_id': album_id,
                        'track_order': track_order,
                        'song_url': song_data['song_url']
                    }
            
            logging.info(f"[PlaylistSong] Assigned track numbers for {len(album_songs)} albums")
            return final_relationships
            
        except Exception as e:
            logging.error(f"[PlaylistSong] Error assigning track numbers globally: {str(e)}")
            return []
    
    def get_song_map(self) -> Dict[str, Dict[str, Any]]:
        return self.song_map
