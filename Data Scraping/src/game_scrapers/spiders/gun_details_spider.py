"""
spiders/gun_details_spider.py

Spider ini bertanggung jawab untuk menemukan dan mengekstrak informasi detail
dari setiap pistol (Gun) yang ada di Blox Fruits Wiki.
"""
import logging
from datetime import datetime
from scrapy.spiders import Rule
from scrapy.linkextractors import LinkExtractor

# Impor Base Spider dan Item spesifik
from .base_equipment_spider import BaseEquipmentSpider
from ..items import GunDetailsItem

logger = logging.getLogger(__name__)

class GunDetailsSpider(BaseEquipmentSpider):
    """
    CrawlSpider yang secara otomatis menavigasi ke halaman detail setiap pistol
    dari halaman indeks "Guns" dan mengekstrak datanya.
    
    Mewarisi semua metode parsing (_parse_...) dari BaseEquipmentSpider.
    """
    name = 'gun_details_spider'
    allowed_domains = ['blox-fruits.fandom.com']
    start_urls = ['https://blox-fruits.fandom.com/wiki/Guns']

    # Aturan crawling untuk menemukan link ke halaman detail pistol
    rules = (
        Rule(
            LinkExtractor(
                # Batasi pencarian link di dalam div daftar item (berdasarkan inspeksi)
                restrict_css=('div.item-list', 'div#mw-content-text'),
                # Izinkan pola URL yang umum untuk item
                allow=(r'/wiki/[A-Z]\w+',),
                # Tolak URL yang tidak relevan
                deny=(r'/wiki/Category:', r'/wiki/File:', r'/wiki/Swords/Legacy')
            ),
            callback='parse_gun',
            follow=False
        ),
    )

    def parse_gun(self, response):
        """
        Callback yang dieksekusi untuk setiap halaman detail pistol.
        
        Metode ini bertindak sebagai orkestrator:
        1. Menginisialisasi GunDetailsItem.
        2. Memanggil metode-metode helper yang diwarisi dari BaseEquipmentSpider.
        3. Menghasilkan (yield) item yang sudah terisi lengkap.
        """
        gun_name = response.url.split('/')[-1].replace('_', ' ')
        uid = 'sword_' + sword_name.lower().replace(' ', '_').replace('(', '').replace(')', '')
        logger.info(f"Memproses pistol: {gun_name}")

        item = GunDetailsItem(
            uid=uid,
            gun_name=gun_name,
            url=response.url,
            timestamp=datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
            abilities=[],
            change_history=[]
        )

        # Panggil metode-metode yang diwarisi dari BaseEquipmentSpider
        self._parse_equipment_infobox(response, item)
        self._parse_equipment_abilities(response, item, gun_name)
        self._parse_change_history(response, item)

        if item.get('type') and item.get('rarity'):
            yield item
        else:
            logger.warning(f"Item untuk '{gun_name}' tidak lengkap. Item diabaikan.")