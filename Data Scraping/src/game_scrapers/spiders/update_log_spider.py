# spiders/update_log_spider.py

import scrapy
import logging
import re
from datetime import datetime

from ..items import UpdateLogItem

logger = logging.getLogger(__name__)

class UpdateLogSpider(scrapy.Spider):
    """
    Spider ini mengekstrak daftar semua update game dan tanggal rilisnya
    dari halaman Blox Fruits Wiki Updates.
    """
    name = 'update_log_spider'
    allowed_domains = ['blox-fruits.fandom.com']
    start_urls = ['https://blox-fruits.fandom.com/wiki/Updates']

    def parse(self, response):
        logger.info(f"Memulai scraping dari halaman: {response.url}")
        update_rows = response.css('div.wds-tab__content table.fandom-table tr')
        update_count = 0

        for row in update_rows:
            update_title = row.css('div.update-header b::text').get()
            
            # Lewati baris jika tidak ada judul sama sekali
            if not update_title:
                continue
            
            # Bersihkan judul dari spasi di awal/akhir
            update_title = update_title.strip()

            # --- PEMBUATAN UPDATE_ID ---
            # Ambil semua teks sebelum karakter ':'
            update_id = update_title.split(':')[0].strip()
            # ---------------------------
            
            # Ekstrak Tanggal Rilis menggunakan Regex
            all_text_in_td = ''.join(row.css('td ::text').getall())
            match = re.search(r"Released on (.*?)\s*—", all_text_in_td, re.IGNORECASE)
            release_date = match.group(1).strip() if match else "Tanggal tidak ditemukan"

            # Isi item
            item = UpdateLogItem()
            item['update_id'] = update_id
            item['update_title'] = update_title
            item['release_date'] = release_date
            item['timestamp'] = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
            
            update_count += 1
            yield item

        logger.info(f"Scraping selesai. Berhasil mengekstrak {update_count} entri update.")