from abc import ABC, abstractmethod

from bs4 import BeautifulSoup

class Page(ABC):
    def __init__(self, url: str):
        self.url = url
        self.content = None

    @abstractmethod
    async def set_content(self):
        "set content from URL"
        pass

    @abstractmethod
    def get_content(self) -> BeautifulSoup:
        pass
