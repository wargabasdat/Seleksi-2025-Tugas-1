import os
import json
import logging

from typing import List, Dict, Any
from selenium import webdriver
from abc import ABC, abstractmethod

class Extractor(ABC):
    """Abstract base class for Spotify data extractors."""
    
    def __init__(self, browser: webdriver.Chrome) -> None:
        
        self.browser = browser
        self.data: List[Dict[str, Any]] = []
    
    @abstractmethod
    def get_data(self, *args, **kwargs) -> List[Dict[str, Any]]:
        pass
    
    def save_to_json(self, filename: str) -> None:

        directory = os.path.dirname(filename)
        if directory and not os.path.exists(directory):
            os.makedirs(directory, exist_ok=True)
        
        with open(filename, 'w', encoding='utf-8') as f:
            json.dump(self.data, f, indent=2, ensure_ascii=False)

        logging.info(f"[Extractor] Data saved to {filename}")
