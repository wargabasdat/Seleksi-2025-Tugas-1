import asyncio

from bs4 import BeautifulSoup
from adapters.bs_page import BSPage
from models.indexes import Index
from models.pages import Page
from models.series import Series
from webbrowser import get


class SeriesService:
    def __init__(self):
        self.SERIES_LIST_URLS = "https://tvtropes.org/pmwiki/pagelist_having_pagetype_in_namespace.php?n=Series&t=work"

    async def get_series(self):
        num_of_pages = await self.get_page_amount()
        pages = []
        urls = [f"{self.SERIES_LIST_URLS}&page={i+1}" for i in range(num_of_pages)]
        tasks = [asyncio.create_task(BSPage.from_url(url)) for url in urls]
        for task in asyncio.as_completed(tasks):
            try:
                page = await task
                pages.extend(await self.get_series_from_table(page))
            except Exception as e:
                print(e)
        return pages

    async def get_page_amount(self):
        page = await BSPage.from_url(self.SERIES_LIST_URLS)
        return int(str(page.content.select_one("#wikimiddle > nav").get("data-total-pages")))

    async def get_series_from_table(self, page: Page):
        table = page.get_content().select_one("table")
        series_list = []
        for td in table.find_all("td"):
            series_link = str(td.find("a").get("href"))
            series = Series({
                "series_name": td.text.replace("\xa0", ""),
                "series_link" : series_link,
                "series_tropes" : [],
                "series_indexes": [],
            })
            series_list.append(series)
        return series_list
