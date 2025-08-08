"""
spiders/sword_details_spider.py

Spider ini bertanggung jawab untuk menemukan dan mengekstrak informasi detail
dari setiap pedang (Sword) yang ada di Blox Fruits Wiki.
"""
import logging
from datetime import datetime
from scrapy.spiders import Rule
from scrapy.linkextractors import LinkExtractor
from .base_equipment_spider import BaseEquipmentSpider
from ..items import SwordDetailsItem

logger = logging.getLogger(__name__)

class SwordDetailsSpider(BaseEquipmentSpider):
    """
    CrawlSpider yang secara otomatis menavigasi ke halaman detail setiap pedang
    dari halaman indeks "Swords" dan mengekstrak datanya.
    
    Mewarisi semua metode parsing (_parse_...) dari BaseEquipmentSpider.
    """

    name = 'sword_details_spider'
    allowed_domains = ['blox-fruits.fandom.com']
    start_urls = ['https://blox-fruits.fandom.com/wiki/Swords']

    # Aturan crawling untuk menemukan link ke halaman detail pedang
    rules = (
        Rule(
            LinkExtractor(
                # Batasi pencarian link di dalam div daftar item
                restrict_css=('div.item-list', 'div#mw-content-text'),
                # Izinkan pola URL yang umum untuk item
                allow=(r'/wiki/[A-Z]\w+',),
                # Tolak URL yang tidak relevan
                deny=(r'/wiki/Category:', r'/wiki/File:', r'/wiki/Swords/Legacy')
            ),
            # Panggil metode 'parse_sword' untuk setiap link pedang yang ditemukan
            callback='parse_sword',
            follow=False
        ),
    )

    def parse_sword(self, response):
        """
        Callback yang dieksekusi untuk setiap halaman detail pedang.
        
        Metode ini bertindak sebagai orkestrator:
        1. Menginisialisasi SwordDetailsItem.
        2. Memanggil metode-metode helper yang diwarisi dari BaseEquipmentSpider.
        3. Menghasilkan (yield) item yang sudah terisi lengkap.
        """
        sword_name = response.url.split('/')[-1].replace('_', ' ')
        uid = 'sword_' + sword_name.lower().replace(' ', '_').replace('(', '').replace(')', '')
        logger.info(f"Memproses pedang: {sword_name}")

        item = SwordDetailsItem(
            uid=uid,
            sword_name=sword_name,
            url=response.url,
            timestamp=datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
            abilities=[],
            change_history=[]
        )

        # Panggil metode-metode yang diwarisi dari BaseEquipmentSpider
        self._parse_equipment_infobox(response, item)
        self._parse_equipment_abilities(response, item, sword_name)
        self._parse_change_history(response, item)

        if item.get('type') and item.get('rarity'):
            yield item
        else:
            logger.warning(f"Item untuk '{sword_name}' tidak lengkap. Item diabaikan.")