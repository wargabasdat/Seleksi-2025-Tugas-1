# spiders/base_equipment_spider.py

import logging
from scrapy.spiders import CrawlSpider
from game_scrapers.items import ChangeHistoryItem, EquipmentAbilityItem

logger = logging.getLogger(__name__)

class BaseEquipmentSpider(CrawlSpider):
    """
    Kelas dasar (Base Class) untuk spider equipment.
    
    Mewarisi dari CrawlSpider dan menyediakan metode-metode helper umum
    untuk mengekstrak informasi dari halaman detail equipment di Blox Fruits Wiki.
    """

    # ==========================================================
    # METODE HELPER GENERIK (Bisa untuk Sword dan Gun)
    # ==========================================================

    def _parse_equipment_infobox(self, response, item):
        """
        Mengekstrak data utama (Type, Rarity, Release Date) dari infobox di sisi kanan halaman.

        Args:
            response: Objek respons Scrapy dari halaman detail equipment.
            item: Objek Item (SwordDetailsItem atau GunDetailsItem) yang akan diisi.
        """
        type_rarity_table = response.css('table.pi-horizontal-group')
        item['type'] = type_rarity_table.css('td[data-source="type"] a::attr(title)').get() or type_rarity_table.css('td[data-source="type"] a::text').get()
        item['rarity'] = type_rarity_table.css('td[data-source="rarity"] a::attr(title)').get() or type_rarity_table.css('td[data-source="rarity"] a::text').get()
        item['release_date'] = response.css('div[data-source="update"] div.pi-data-value a::attr(title)').get(default='').strip()

    def _parse_equipment_abilities(self, response, item, item_name):
        """
        Mencari dan memproses tabel moveset untuk equipment.
        
        Berbeda dengan fruit, equipment umumnya hanya memiliki satu tabel moveset
        tanpa sistem tab.
        """
        tabs = response.css('div.wds-tabber')
        
        if tabs:
            logger.info(f"[{item_name}] Ditemukan sistem tab dengan {len(tabs)} tab.")
            
            tabber = response.css('div.wds-tabber')
            contents = tabber.css('div.wds-tab__content')

            for i, tab in enumerate(tabs):
                tab_text = tab.css('::text').get(default='').strip().lower()
                print(tab_text)
                
                if i < len(contents):
                    table_selector = tabber[i].css('table.article-table, table.fandom-table').get()
                    if table_selector:
                        print("masuk sini")
                        if (not item['abilities']):
                            item['abilities'] = self._extract_equipment_abilities_from_table(tabber[i].css('table.article-table, table.fandom-table'), item_name)
                        
        else:
            logger.info(f"[{item_name}] Tidak ditemukan tab. Mencari satu tabel moveset.")
            
            moveset_table = response.xpath('//h2[span/@id="Moveset"]/following-sibling::table[contains(@class, "fandom-table")][1]')
            if moveset_table:
                item['abilities'] = self._extract_equipment_abilities_from_table(moveset_table, item_name)
            else:
                logger.warning(f"[{item_name}] Tabel moveset tunggal tidak ditemukan.")

    def _extract_equipment_abilities_from_table(self, table_selector, equipment_name):
        """Mengekstrak detail setiap ability dari tabel yang diberikan."""
        abilities_list = []
        rows = table_selector.css('tr')
        i = 0
        while i < len(rows):
            header_row = rows[i]
            # Baris header ability yang valid selalu memiliki <th> dengan colspan="2"
            if header_row.css('th[colspan="2"]'):
                ability = EquipmentAbilityItem()
                ability['equipment_name'] = equipment_name

                keybind_img_name = header_row.css('span[typeof="mw:File"] img::attr(data-image-name)').get('')
                ability['keybind'] = keybind_img_name.replace('LMB.png', 'TAP').replace('-Key.png', '').strip() or header_row.css('td:nth-child(1) b::text').get(default='N/A').strip()
                ability['ability_name'] = header_row.xpath('.//div[contains(@style, "font-size: 25px")]/text()').get(default='N/A').strip()
                ability['mastery_cost'] = header_row.css('span[style*="line-height:"] font::text').get(default='N/A').strip()
                
                if ability.get('ability_name') and ability['ability_name'] != 'N/A':
                    abilities_list.append(ability)
                # Loncat 2 baris untuk langsung ke header ability berikutnya
                i += 2
            else:
                # Jika bukan baris header, lewati saja
                i += 1
        return abilities_list

    def _parse_change_history(self, response, item):
        """
        Mengekstrak riwayat perubahan (Change History) untuk item ini.
        Logika ini cukup fleksibel untuk menangani berbagai struktur halaman.
        """
        history_container = response.css('div.change-history')
        if not history_container:
            return

        potential_headings = history_container.css('div.change-history > a, div.change-history > p')
        for heading in potential_headings:
            version_text = ''.join(heading.css('::text').getall()).strip()
            changes_ul = heading.xpath('following-sibling::ul[1]')
            if changes_ul:
                for change_li in changes_ul.xpath('./li'):
                    history_item = ChangeHistoryItem()
                    change_text = ''.join(change_li.xpath('.//text()').getall()).strip()
                    if version_text and change_text:
                        history_item['version'] = version_text
                        history_item['change'] = change_text
                        item['change_history'].append(history_item)