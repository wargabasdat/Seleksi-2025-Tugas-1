import os
import sys
import logging

from typing import List, Dict

sys.path.append(os.path.join(os.path.dirname(__file__)))
from extractor.extractor import Extractor

class SongArtistExtractor(Extractor):
    """Extracts song-artist relationships from song-artist mapping."""
    
    def __init__(self, browser) -> None:
        
        super().__init__(browser)
        self.existing_relationships: set = set()
    
    def get_data(self, song_artist_map: Dict[tuple, List[str]]) -> List[Dict[str, str]]:
        
        all_relationships = []
        
        logging.info(f"[SongArtist] Processing {len(song_artist_map)} songs")
        
        for (album_id, track_order), artist_ids in song_artist_map.items():
            for artist_id in artist_ids:
                relationship_key = f"{album_id}_{track_order}_{artist_id}"
                
                if relationship_key not in self.existing_relationships:
                    relationship = {
                        'artist_id': artist_id,
                        'album_id': album_id,
                        'track_order': track_order
                    }
                    all_relationships.append(relationship)
                    self.existing_relationships.add(relationship_key)
        
        self.data = all_relationships
        
        logging.info(f"[SongArtist] Total relationships extracted: {len(all_relationships)}")
        
        return self.data