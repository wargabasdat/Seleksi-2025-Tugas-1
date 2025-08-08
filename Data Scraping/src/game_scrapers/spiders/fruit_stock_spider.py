import scrapy
import time
import logging
from datetime import datetime, timedelta
from dateutil import parser as dateparser

# Impor Item yang relevan
from ..items import FruitStockResultItem, FruitStockItem

logger = logging.getLogger(__name__)

class FruitStockSpider(scrapy.Spider):
    name = "fruit_stock_spider"
    allowed_domains = ["bloxfruits.fandom.com"]
    start_urls = ["https://bloxfruits.fandom.com/wiki/Blox_Fruits_%22Stock%22"]

    def parse(self, response):
        logger.info("Spider stok buah mulai berjalan")
        
        # --- Ekstraksi Waktu & Pembuatan UID untuk Event ---
        reset_iso = response.xpath("//span[@class='countdowndate']/text()").get()
        stock_start_time = "Tidak ditemukan"
        stock_event_uid = f"stock_{datetime.now().strftime('%Y%m%d%H%M%S')}" # Fallback UID

        if reset_iso:
            try:
                reset_dt = dateparser.parse(reset_iso)
                start_dt = reset_dt - timedelta(hours=4)
                stock_start_time = start_dt.strftime("%Y-%m-%d %H:%M:%S UTC")
                # Buat UID yang lebih konsisten dari waktu mulai stok
                stock_event_uid = f"stock_{start_dt.strftime('%Y%m%d%H%M%S')}"
            except Exception as e:
                stock_start_time = f"Format waktu error: {e}"
        
        logger.info(f"Waktu mulai stock: {stock_start_time} (UID: {stock_event_uid})")

        # 1. Yield Item untuk "Stock Event" itu sendiri
        stock_event_item = FruitStockResultItem(
            stock_event_uid=stock_event_uid,
            timestamp=datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
            stock_start_time=stock_start_time
        )
        yield stock_event_item

        # --- Ekstraksi Buah di dalam Stok ---
        current_stock_section = response.xpath("//div[@id='mw-customcollapsible-Current']")
        if current_stock_section:
            fruit_stock_divs = current_stock_section.xpath(".//div[contains(@class, 'fruit-stock')]")
            if not fruit_stock_divs:
                logger.warning("Tidak ada div 'fruit-stock' ditemukan dalam wadah 'CURRENT STOCK'.")
                return

            logger.info(f"Ditemukan {len(fruit_stock_divs)} item dalam stok saat ini.")
            for item_div in fruit_stock_divs:
                fruit_name = item_div.xpath(".//a[@title]/@title").get("Nama tidak diketahui")
                price_text = item_div.xpath('.//span[contains(@class, "color-currency(Money)")]/text()').re_first(r'[\d,]+')

                # 2. Yield Item terpisah untuk SETIAP buah di dalam stok
                fruit_in_stock_item = FruitStockItem(
                    stock_event_uid=stock_event_uid, # Hubungkan ke event-nya
                    fruit_name=fruit_name,
                    price=price_text.strip() if price_text else "Harga tidak diketahui"
                )
                yield fruit_in_stock_item
        else:
            logger.error("Wadah 'CURRENT STOCK' tidak ditemukan.")

        logger.info("Spider stok buah selesai.")