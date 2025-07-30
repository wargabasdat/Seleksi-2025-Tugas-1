import scrapy
import time
import logging
import os
from dateutil import parser as dateparser
from datetime import timedelta

spider_path = os.path.abspath(__file__)
data_scraping_dir = os.path.dirname(os.path.dirname(os.path.dirname(os.path.dirname(spider_path))))
log_dir = os.path.join(data_scraping_dir, "logs")
os.makedirs(log_dir, exist_ok=True)
log_path = os.path.join(log_dir, "fruit_stock_scraper.log")
logger = logging.getLogger("fruit_stock_scraper")
logger.setLevel(logging.INFO)
file_handler = logging.FileHandler(log_path, encoding="utf-8")
formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')
file_handler.setFormatter(formatter)
if not logger.hasHandlers():
    logger.addHandler(file_handler)

class FruitStockSpider(scrapy.Spider):
    name = "fruit_stock_spider"
    allowed_domains = ["bloxfruits.fandom.com"]
    start_urls = [
        "https://bloxfruits.fandom.com/wiki/Blox_Fruits_%22Stock%22"
    ]

    def parse(self, response):
        logger.info("Spider mulai berjalan")
        # --- Ekstraksi Timer ---
        reset_iso = response.xpath(
            "//div[contains(@class, 'button1') and contains(@class, 'mw-customtoggle-Current')]/following-sibling::span//span[@class='countdowndate']/text()"
        ).get()
        stock_start_time = "Tidak ditemukan"
        if reset_iso:
            try:
                reset_dt = dateparser.parse(reset_iso)
                start_dt = reset_dt - timedelta(hours=4)
                stock_start_time = start_dt.strftime("%Y-%m-%d %H:%M:%S UTC")
            except Exception as e:
                stock_start_time = f"Format waktu error: {e}"

        logger.info(f"Waktu mulai stock: {stock_start_time}")

        # --- Ekstraksi Item Stok Saat Ini ---
        current_stock_data = []
        current_stock_section = response.xpath("//div[@id='mw-customcollapsible-Current']")
        if current_stock_section:
            fruit_stock_items = current_stock_section.xpath(".//div[contains(@class, 'fruit-stock')]")
            if fruit_stock_items:
                for item_div in fruit_stock_items:
                    fruit_name = "Nama tidak diketahui"
                    fruit_price = "Harga tidak diketahui"

                    # Nama buah
                    a_tag = item_div.xpath(".//a[@title]")
                    if a_tag:
                        fruit_name = a_tag.attrib.get("title", fruit_name)

                    # Harga buah: cari <span class="color-currency(Money)">
                    price_texts = item_div.xpath('.//span[contains(@class, "color-currency(Money)")]/text()').getall()
                    if price_texts:
                        fruit_price = None
                        for t in price_texts:
                            t = t.strip()
                            if t.replace(',', '').isdigit():
                                fruit_price = t
                                break
                        if not fruit_price:
                            logger.warning(f"Harga untuk '{fruit_name}' tidak ditemukan.")
                    else:
                        logger.warning(f"Harga untuk '{fruit_name}' tidak ditemukan.")
                    
                    current_stock_data.append({
                        'name': fruit_name,
                        'price': fruit_price
                    })
                logger.info(f"Berhasil mengikis {len(current_stock_data)} item stok saat ini.")
            else:
                logger.warning("Tidak ada item 'fruit-stock' ditemukan dalam wadah 'CURRENT STOCK'.")
        else:
            logger.error("Wadah 'CURRENT STOCK' tidak ditemukan.")

        logger.info("Spider selesai berjalan")
        yield {
            'timestamp': time.strftime("%Y-%m-%d %H:%M:%S"),
            'stock_start_time': stock_start_time,
            'current_stock': current_stock_data
        }