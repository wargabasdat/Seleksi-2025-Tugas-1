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
    """Extracts many-to-many relationships between playlists and songs.
    
    Inherits from Extractor abstract base class.
    
    Attributes:
        existing_relationships: Set of already processed relationships
    """
    
    def __init__(self, browser) -> None:
        """Initialize the PlaylistSongExtractor with a browser instance
        
        Args:
            browser: Selenium Chrome WebDriver instance
        """

        super().__init__(browser)
        self.existing_relationships: set = set()
    
    def get_data(self, playlists: List[Dict[str, Any]], chosen_playlists: Optional[List[str]] = None, song_limit: Optional[int] = None) -> List[Dict[str, str]]:
        """Extract playlist-song relationships from playlists
        
        Args:
            playlists: List of playlist dictionaries with 'playlist_id', 'name', 'url' keys
            chosen_playlists: List of playlist names to filter for detailed song extraction.
                             If None or empty, extracts songs from all playlists.
            song_limit: Maximum number of songs to extract from each playlist.
                       If None, extracts all songs found.
            
        Returns:
            List of playlist-song relationship dictionaries with playlist_id, song_id, and added_date
            
        Raises:
            Exception: If any step in the relationship extraction process fails
        """
        
        all_relationships = []
        processed_playlists = 0
        
        logging.info(f"[PlaylistSong] Processing {len(playlists)} playlists")
        
        for playlist in playlists:
            playlist_name = playlist.get('name', '')
            playlist_id = playlist.get('playlist_id', '')
            playlist_url = playlist.get('url', '')
            
            if chosen_playlists and playlist_name not in chosen_playlists:
                continue
                
            logging.info(f"[PlaylistSong] Extracting songs for playlist: {playlist_name}")
            relationships = self._extract_playlist_songs(playlist_url, playlist_id, song_limit)
            
            if relationships:
                processed_playlists += 1
                logging.info(f"[PlaylistSong] Found {len(relationships)} songs in playlist: {playlist_name}")
                
                for relationship in relationships:
                    relationship_key = f"{relationship['playlist_id']}_{relationship['song_id']}"
                    
                    # Check for duplicate relationships
                    if relationship_key not in self.existing_relationships:
                        all_relationships.append(relationship)
                        self.existing_relationships.add(relationship_key)
                        logging.info(f"[PlaylistSong] Found relationship: {playlist_id} -> {relationship['song_id']} (added: {relationship['added_date']})")
            
            time.sleep(2)

        self.data = all_relationships
        
        if chosen_playlists:
            logging.info(f"[PlaylistSong] Processed {processed_playlists} chosen playlists out of {len(playlists)} total playlists")
        else:
            logging.info(f"[PlaylistSong] Processed all {processed_playlists} playlists")
            
        logging.info(f"[PlaylistSong] Total relationships extracted: {len(all_relationships)}")
        
        return self.data
    
    def _extract_playlist_songs(self, playlist_url: str, playlist_id: str, song_limit: Optional[int] = None) -> Optional[List[Dict[str, str]]]:
        """Extract playlist-song relationships directly from a playlist page
        
        Args:
            playlist_url: Full URL of the playlist page
            playlist_id: Unique identifier for the playlist
            song_limit: Maximum number of songs to extract. If None, extracts all songs.
            
        Returns:
            List of relationship dictionaries with playlist_id, song_id, and added_date, or None if extraction fails
        """
        try:
            logging.info(f"[PlaylistSong] Extracting songs for playlist: {playlist_id}")
            self.browser.get(playlist_url)
            
            WebDriverWait(self.browser, 10).until(
                EC.presence_of_element_located((By.TAG_NAME, 'body'))
            )

            time.sleep(3)
            
            page_source = self.browser.page_source
            soup = BeautifulSoup(page_source, 'html.parser')
            
            relationships = []
            track_rows = soup.find_all('div', {'role': 'row'})
            
            # Fallback: just get track links without dates
            if not track_rows:
                track_links = soup.find_all('a', href=lambda x: isinstance(x, str) and '/track/' in x)
                for link in track_links:
                    if isinstance(link, Tag):
                        href = link.get('href')
                        if href and '/track/' in str(href):
                            href_str = str(href)
                            song_id = href_str.split('/')[-1] if '/' in href_str else href_str
                            
                            relationships.append({
                                'playlist_id': playlist_id,
                                'song_id': song_id,
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
                                href_str = str(href)
                                song_id = href_str.split('/')[-1] if '/' in href_str else href_str
                                
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
                                if not added_date:
                                    logging.warning(f"[PlaylistSong] Could not parse added date for song {song_id} in playlist {playlist_id}")
                                
                                relationships.append({
                                    'playlist_id': playlist_id,
                                    'song_id': song_id,
                                    'added_date': added_date
                                })
                                
                                if song_limit is not None and len(relationships) >= song_limit:
                                    logging.info(f"[PlaylistSong] Limiting to {song_limit} songs for playlist {playlist_id}")
                                    break
            
            logging.info(f"[PlaylistSong] Found {len(relationships)} songs in playlist {playlist_id}")
            return relationships if relationships else None
            
        except Exception as e:
            logging.warning(f"[PlaylistSong] Failed to extract songs from playlist {playlist_id}: {str(e)}")
            return None
    
    def _parse_added_date(self, date_text: str) -> Optional[str]:
        """Parse Spotify date formats into standardized YYYY-MM-DD format
        
        Handles these specific formats:
        - "X week(s) ago"
        - "X day(s) ago" 
        - "X hour(s) ago"
        - "DD MMM YYYY" (e.g., "7 Nov 2024")
        
        Args:
            date_text: Date text from Spotify
            
        Returns:
            Standardized date string in YYYY-MM-DD format, or None if parsing fails
        """
        
        try:
            date_text = date_text.strip().lower()
            today = datetime.now()
            
            # Handle relative dates with "ago"
            if 'ago' in date_text:
                # Match patterns like "6 days ago", "2 weeks ago", "3 hours ago"
                time_match = re.search(r'(\d+)\s+(minute|hour|day|week)s?\s+ago', date_text)
                if time_match:
                    number = int(time_match.group(1))
                    unit = time_match.group(2)
                    
                    if unit == 'hour' or unit == 'minute':
                        # If less than 24 hours ago, consider it today
                        calculated_date = today
                    elif unit == 'day':
                        calculated_date = today - timedelta(days=number)
                    elif unit == 'week':
                        calculated_date = today - timedelta(weeks=number)
                    else:
                        return 'unknown'
                    
                    return calculated_date.strftime('%Y-%m-%d')
            
            # Handle exact dates in format "DD MMM YYYY" (e.g., "7 Nov 2024")
            # Month name mappings for short forms
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
            
            # Pattern: "feb 5, 2024" (month first with comma)
            date_pattern = re.search(r'(jan|feb|mar|apr|may|jun|jul|aug|sep|sept|oct|nov|dec)\s+(\d{1,2}),\s+(\d{4})', date_text)
            if date_pattern:
                month_name, day, year = date_pattern.groups()
                month = month_names[month_name]
                parsed_date = datetime(int(year), month, int(day))
                return parsed_date.strftime('%Y-%m-%d')
            
            # If no pattern matches, return null
            logging.warning(f"[PlaylistSong] Could not parse date format: '{date_text}'")
            return None
            
        except Exception as e:
            logging.warning(f"[PlaylistSong] Error parsing date '{date_text}': {str(e)}")
            return None
