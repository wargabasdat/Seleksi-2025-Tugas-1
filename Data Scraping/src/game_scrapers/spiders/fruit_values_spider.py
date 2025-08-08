import scrapy
import logging
from datetime import datetime
from game_scrapers.items import FruitValuesItem

logger = logging.getLogger(__name__)

class FruitValuesSpider(scrapy.Spider):
    name = 'fruit_values_spider'
    allowed_domains = ['bloxfruitsvalues.com'] 
    start_urls = [
        'https://bloxfruitsvalues.com/common',
        'https://bloxfruitsvalues.com/uncommon',
        'https://bloxfruitsvalues.com/rare',
        'https://bloxfruitsvalues.com/legendary',
        'https://bloxfruitsvalues.com/mythical',
    ]

    def parse(self, response):
        # Dapatkan nama kategori dari URL (misal: 'common', 'uncommon')
        category = response.url.split('/')[-1]
        if not category: 
            category = response.url.split('/')[-2]
        
        logger.info(f"Memulai scraping kategori: {category} dari {response.url}")

        # --- Selektor Wadah Kartu Buah Individual ---
        fruit_cards = response.css('div.bg-white\\/5.flex.flex-col.gap-10.pt-2.pb-5.px-3.rounded-lg')
        
        if fruit_cards:
            logger.info(f"Ditemukan {len(fruit_cards)} kartu buah untuk kategori '{category}'.")
            for i, card in enumerate(fruit_cards):
                item = FruitValuesItem()
                item['fruit_name'] = "N/A"
                item['value'] = "N/A"
                item['demand'] = "N/A"
                item['status'] = "N/A"

                # --- Ekstrak Nama Buah ---
                name_element = card.css('h1.text-2xl.font-semibold.mt-1.text-\\[\\#f2f2f2\\].absolute.top-2.left-0.h-10.w-24.cursor-pointer::text').get()
                if not name_element:
                    name_element = card.css('h1::text').get() 
                if name_element:
                    item['fruit_name'] = name_element.strip()
                else:
                    logger.warning(f"[{category}] Kartu #{i+1}: Nama buah tidak ditemukan.")
                
                # --- Ekstrak Nilai (Value) dan Permintaan (Demand) ---
                all_h2_contents = card.css('h2.text-2xl.contents::text').getall()
                if len(all_h2_contents) >= 1:
                    item['value'] = all_h2_contents[0].strip()
                else:
                    logger.warning(f"[{category}] Kartu #{i+1} ({item['fruit_name']}): Nilai (Value) tidak ditemukan.")

                if len(all_h2_contents) >= 2:
                    item['demand'] = all_h2_contents[1].strip()
                else:
                    logger.warning(f"[{category}] Kartu #{i+1} ({item['fruit_name']}): Permintaan (Demand) tidak ditemukan.")

                # --- Ekstrak Status (Stable, Overpaid, Underpaid) ---
                status_element = card.css('h1.text-sm.font-medium::text').get()
                if status_element:
                    item['status'] = status_element.strip()
                else:
                    logger.warning(f"[{category}] Kartu #{i+1} ({item['fruit_name']}): Status (h1.text-sm) tidak ditemukan.")

                # Hasilkan Item
                if item.get('fruit_name') != "N/A" and item.get('value') != "N/A" and item.get('demand') != "N/A":
                    yield item
                else:
                    logger.warning(f"[{category}] Kartu #{i+1} ({item['fruit_name']}): Item tidak lengkap atau data Value/Demand N/A. Item diabaikan.")
            
            logger.info(f"Berhasil mengikis {len(fruit_cards)} buah dari kategori '{category}'.")
        else:
            logger.warning(f"Tidak ada kartu buah ditemukan di {response.url}. Periksa selektor 'div.bg-white\\/5.flex.flex-col.gap-10.pt-2.pb-5.px-3.rounded-lg'.")