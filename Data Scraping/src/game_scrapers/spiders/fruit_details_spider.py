"""
spiders/fruit_details_spider.py

Spider ini bertanggung jawab untuk menemukan dan mengekstrak informasi detail
dari setiap buah (Fruit) yang ada di Blox Fruits Wiki, termasuk harga,
kemampuan (abilities), dan riwayat perubahannya.
"""
import logging
from datetime import datetime
from game_scrapers.items import FruitDetailsItem, AbilityItem
from scrapy.spiders import CrawlSpider, Rule
from scrapy.linkextractors import LinkExtractor

logger = logging.getLogger(__name__)

class FruitDetailsSpider(CrawlSpider):
    """
    CrawlSpider yang secara otomatis menavigasi ke halaman detail setiap buah
    dari halaman indeks "Blox Fruits" dan mengekstrak datanya secara lengkap.
    """
    name = 'fruit_details_spider'
    allowed_domains = ['blox-fruits.fandom.com']
    
    start_urls = ['https://blox-fruits.fandom.com/wiki/Blox_Fruits']

    # Aturan crawling untuk menemukan link ke halaman detail buah
    rules = (
        Rule(
            LinkExtractor(
                allow=(r'/wiki/[A-Z]\w+$',),
                deny=(r'/wiki/Category:', r'/wiki/File:'),
                restrict_css=('div#mw-content-text',)
            ),
            callback='parse_fruit',
            follow=False
        ),
    )


    def parse_fruit(self, response):
        """
        Metode parse utama yang bertindak sebagai orkestrator.
        Menginisialisasi item dan memanggil metode-metode pembantu untuk
        mengisi data sebelum akhirnya menghasilkan (yield) item tersebut.
        """

        fruit_name = response.url.split('/')[-1].replace('_', ' ')
        uid = 'fruit_' + fruit_name.lower().replace(' ', '_').replace('(', '').replace(')', '')
        logger.info(f"Memulai scraping untuk buah: {fruit_name}")

        item = FruitDetailsItem(
            uid=uid,
            fruit_name=fruit_name,
            url=response.url,
            timestamp=datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
            abilities=[],
            change_history=[]
        )

        self._parse_infobox(response, item)
        self._parse_abilities(response, item)
        self._parse_change_history(response, item)

        if item.get('type') and item.get('rarity'):
            yield item
        else:
            logger.warning(f"Item untuk '{fruit_name}' tidak lengkap (type atau rarity kosong). Item diabaikan.")

    def _parse_infobox(self, response, item):
        """Mengekstrak semua informasi dari infobox di sisi kanan halaman."""
        # Ekstraksi Type dan Rarity
        type_rarity_table = response.css('table.pi-horizontal-group')
        item['type'] = type_rarity_table.css('td[data-source="type"] a::attr(title)').get() or type_rarity_table.css('td[data-source="type"] a::text').get()
        item['rarity'] = type_rarity_table.css('td[data-source="rarity"] a::attr(title)').get() or type_rarity_table.css('td[data-source="rarity"] a::text').get()

        # Ekstraksi Harga
        price_section = response.css('section.pi-item.pi-group.pi-border-color h2.pi-header:contains("Price") + section')
        if price_section:
            money_price_raw = price_section.xpath('.//td[@data-source="money"]/span/text()[last()]').get()
            robux_price_raw = price_section.xpath('.//td[@data-source="robux"]/span/text()[last()]').get()
            item['money_price'] = self._clean_and_convert_to_int(money_price_raw, '$', ',')
            item['robux_price'] = self._clean_and_convert_to_int(robux_price_raw, 'R$', ',')
        
        # Ekstraksi Biaya Awakening
        awakening_cost_raw = response.css('div[data-source="awakening_cost"] div.pi-data-value *::text').getall()
        awakening_cost_text = ''.join(awakening_cost_raw).strip()
        item['awakening_cost'] = self._clean_and_convert_to_int(awakening_cost_text, 'f', ',', '$')

        # Ekstraksi lainnya
        can_m1_raw = response.css('div[data-source="M1"] div.pi-data-value span::text').get()
        if can_m1_raw:
            item['can_m1'] = 'Yes' if '✔' in can_m1_raw else ('No' if '✘' in can_m1_raw else can_m1_raw.strip())
        
        raw_release_date = response.css('div[data-source="update"] div.pi-data-value a::attr(title)').get(default='')

        # Lakukan transformasi string jika data ditemukan
        if raw_release_date:
            # Ganti '/' dengan spasi, lalu 'Updates' (jamak) dengan 'Update' (tunggal)
            cleaned_date = raw_release_date.replace('/', ' ').replace('Updates', 'Update')
            item['release_date'] = cleaned_date.strip()
        else:
            item['release_date'] = '' 
            
    def _parse_abilities(self, response, item):
        """
        Mencari ability dengan memeriksa keberadaan elemen tab yang sebenarnya.
        """
        tabs = response.css('div.wds-tabber')
        
        if tabs:
            logger.info(f"[{item['fruit_name']}] Ditemukan sistem tab dengan {len(tabs)} tab.")
            
            tabber = response.css('div.wds-tabber') # Ambil kontainer utamanya
            contents = tabber.css('div.wds-tab__content')

            for i, tab in enumerate(tabs):
                tab_text = tab.css('::text').get(default='').strip().lower()
                print(tab_text)
                
                if i < len(contents):
                    table_selector = tabber[i].css('table.article-table, table.fandom-table').get()
                    
                    # Hanya proses jika ada tabel di dalam konten tab
                    if table_selector:
                        print("masuk sini")
                        if (not item['abilities']):
                            item['abilities'] = self._extract_abilities_from_table(tabber[i].css('table.article-table, table.fandom-table'), item['fruit_name'])
                        
        else:
            # Skenario 2: Halaman tidak memiliki tab, cari tabel moveset tunggal
            logger.info(f"[{item['fruit_name']}] Tidak ditemukan tab. Mencari satu tabel moveset.")
            
            moveset_table = response.xpath('//h2[span/@id="Moveset"]/following-sibling::table[contains(@class, "fandom-table")][1]')
            if moveset_table:
                item['abilities'] = self._extract_abilities_from_table(moveset_table, item['fruit_name'])
            else:
                logger.warning(f"[{item['fruit_name']}] Tabel moveset tunggal tidak ditemukan.")
    def _extract_abilities_from_table(self, table_selector, fruit_name):
        """
        Mengekstrak detail setiap ability dari SELEKTOR TABEL yang diberikan.
        Fungsi ini sekarang menerima langsung selektor tabelnya.
        """
        abilities_list = []
        if not table_selector:
            return []
        rows = table_selector.css('tr')
        i = 0
        while i < len(rows):
            header_row = rows[i]
            if header_row.css('th[colspan="2"]'):
                ability = AbilityItem()
                ability['fruit_name'] = fruit_name

                keybind_img_name = header_row.css('span[typeof="mw:File"] img::attr(data-image-name)').get('')
                ability['keybind'] = keybind_img_name.replace('LMB.png', 'TAP').replace('-Key.png', '').strip() or header_row.css('td:nth-child(1) b::text').get(default='N/A').strip()
                ability['ability_name'] = header_row.xpath('.//div[contains(@style, "font-size: 25px")]/text()').get(default='N/A').strip()
                ability['mastery_cost'] = header_row.css('span[style*="line-height:"] font::text').get(default='N/A').strip()
                
                fragment_cost_raw = header_row.xpath('.//span[contains(@class, "color-currency(Fragment)")]/text()[last()]').get()
                ability['fragment_cost'] = self._clean_and_convert_to_int(fragment_cost_raw, 'f', ',')
                if ability.get('ability_name') and ability['ability_name'] != 'N/A':
                    abilities_list.append(ability)
                else:
                    logger.info(f"[{fruit_name}] Melewatkan ability dengan nama 'N/A'.")
                i += 2
            else:
                i += 1
                
        if not abilities_list:
            logger.warning(f"[{fruit_name}] Tabel ditemukan tetapi tidak ada ability yang berhasil diekstrak.")
            
        return abilities_list

    def _parse_change_history(self, response, item):
        """
        Mengekstrak riwayat perubahan (Change History) dengan logika yang lebih fleksibel
        untuk menangani struktur HTML yang berbeda-beda.
        """
        from game_scrapers.items import ChangeHistoryItem

        # 1. Pilih kontainer utama tempat semua riwayat berada.
        history_container = response.css('div.change-history')
        if not history_container:
            return

        # 2. Pilih semua elemen yang berpotensi menjadi "judul versi".
        potential_headings = history_container.css('div.change-history > a, div.change-history > p')

        for heading in potential_headings:
            # Ambil teks versi dari elemen heading
            version_text = ''.join(heading.css('::text').getall()).strip()

            # 3. Temukan <ul> yang berisi daftar perubahan setelah heading ini.
            changes_ul = heading.xpath('following-sibling::ul[1]')

            if changes_ul:
                # Iterasi setiap <li> di dalam <ul> tersebut
                for change_li in changes_ul.xpath('./li'):
                    history_item = ChangeHistoryItem()
                    # Ambil semua teks dari dalam <li>, termasuk dari tag di dalamnya (seperti <b>, <a>)
                    change_text = ''.join(change_li.xpath('.//text()').getall()).strip()
                    
                    if version_text and change_text:
                        history_item['version'] = version_text
                        history_item['change'] = change_text
                        item['change_history'].append(history_item)

    def _clean_and_convert_to_int(self, raw_text, *chars_to_remove):
        """
        Membersihkan string dari karakter tertentu dan mengonversinya ke integer.
        Mengembalikan None jika teks kosong atau konversi gagal.
        """
        if not raw_text or not raw_text.strip() or raw_text.strip().lower() == 'none':
            return None
        
        cleaned_text = raw_text
        for char in chars_to_remove:
            cleaned_text = cleaned_text.replace(char, '')
        
        try:
            return int(cleaned_text.strip())
        except (ValueError, TypeError):
            logger.warning(f"Gagal mengonversi '{raw_text}' menjadi integer.")
            return None