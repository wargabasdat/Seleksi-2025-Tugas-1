from models.pages import Page
import aiohttp
from bs4 import BeautifulSoup

class BSPage(Page):
    session = None  # class variable

    @classmethod
    async def init_session(cls):
        if cls.session is None or cls.session.closed:
            cls.session = aiohttp.ClientSession()

    async def set_content(self):
        async with self.__class__.session.get(self.url) as response:
            if response.status == 200:
                self.content = BeautifulSoup(await response.text(), "lxml")

    @classmethod
    async def from_url(cls, url: str):
        page = cls(url)
        await page.set_content()
        return page

    @classmethod
    async def close_session(cls):
        if cls.session and not cls.session.closed:
            await cls.session.close()

    def get_content(self):
        return self.content
