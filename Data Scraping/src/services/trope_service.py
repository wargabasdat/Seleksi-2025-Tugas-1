import asyncio
from adapters.bs_page import BSPage
from models.indexes import Index
from models.pages import Page
from models.series import Series
from models.trope_usage import TropeUsage
from models.tropes import Trope
from bs4 import Tag
import json

class TropeService:

    async def get_tropes_from_series(self, series: Series):
        page = await BSPage.from_url(series["series_link"])
        trope_usages, tropes = await self.parse_tropes(page)
        return trope_usages, tropes

    async def get_and_attach_tropes_from_series(self, series: Series):
        usage, tropes = await self.get_tropes_from_series(series)
        series["series_tropes"] = usage
        series = await self.attach_indexes(series)
        print(f"Finished with {series["series_name"]}!")
        return series, tropes

    async def parse_tropes(self, page: Page):
        trope_usages = []
        tropes = []

        all_uls = page.get_content().select("#main-article > ul, .folder > ul")
        tasks = []

        for ul in all_uls:
            for li in ul:
                tasks.append(self.process_li(li))

        results = await asyncio.gather(*tasks)

        for usage_list, trope_list in results:
            trope_usages.extend(usage_list)
            tropes.extend(trope_list)

        return trope_usages, tropes

    async def process_li(self, li: Tag):
        link_tag = li.find("a")
        if not link_tag:
            return [], []

        trope_name = str(link_tag.text)
        trope_link = "http://tvtropes.org" + str(link_tag.get("href"))

        if trope_name.startswith("Tropes "):
            try:
                sub_page = await BSPage.from_url(trope_link)
                return await self.parse_tropes(sub_page)
            except Exception:
                return [], []
        else:
            trope_usage_text = self.parse_trope_usage(li)

            # Run both Laconic page fetch and parsing of usage in parallel
            description = await self.get_trope_description(trope_link)

            trope = Trope(
                trope_name=trope_name,
                trope_link=trope_link,
                trope_description=description
            )

            trope_usage = TropeUsage(
                trope_name=trope_name,
                trope_usage=trope_usage_text
            )

            return [trope_usage], [trope]

    def parse_trope_usage(self, li: Tag):
        li.find("a").decompose()
        for ul in li.find_all("ul"):
            for lis in ul:
                lis.decompose()
            ul.decompose()
        return str(li.text[3:]).strip()

    async def get_trope_description(self, trope_link: str):
        try:
            laconic_url = trope_link.replace("Main", "Laconic")
            page = await BSPage.from_url(laconic_url)
            para = page.get_content().select_one("#main-article > p:nth-child(1)")
            return para.text.strip() if para else ""
        except Exception:
            return ""

    def save_to_json(self, list, filepath):
        with open(filepath, "a", encoding="utf-8") as f:
            for item in list:
                f.write(json.dumps(item) + "\n")

    async def attach_indexes(self, series):
        page = await BSPage.from_url(series["series_link"])
        idx = page.get_content().select("#main-entry > div.section-links > div.links > ul > li:nth-child(2)")
        indexes = []
        for id in idx:
            index = Index(index_name=id.text.strip(), index_link="http://tvtropes.org" + str(id.find("a").get("href")))
            indexes.append(index)
        series["series_indexes"] = indexes
        return series
