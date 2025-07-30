import scrapy
import re
from datetime import datetime # Import datetime

class FruitStockSpider(scrapy.Spider):
    name = 'fruit_stock_spider'
    allowed_domains = ["bloxfruits.fandom.com"] # Tambahkan allowed_domains (praktik baik Scrapy)
    start_urls = [
        "https://bloxfruits.fandom.com/wiki/Blox_Fruits_%22Stock%22"
    ]

    def parse(self, response):
        # --- 1. Ekstraksi Timer ---
        timer_text = "Timer not found"
        # Gunakan CSS selector karena lebih sederhana untuk kasus ini
        button_div_text = response.css('div.button.mw-customtoggle.current_mw-customtoggle::text').get()
        
        if button_div_text:
            # Gunakan regex yang lebih fleksibel untuk menangani format H, M, S
            match = re.search(r'(\d+H \d+M \d+S|\d+M \d+S)', button_div_text)
            if match:
                timer_text = match.group(1)
            else:
                # Fallback jika pola waktu tidak ditemukan, ambil seluruh teks tombol
                timer_text = button_div_text.strip() 
        self.logger.info(f"Timer terdeteksi: {timer_text}")

        # --- 2. Ekstraksi Item Stok Saat Ini ---
        # Gunakan CSS selector karena lebih mudah dibaca untuk ID dan class
        current_stock_container = response.css('#mw-customcollapsible-current') 
        
        if current_stock_container:
            fruit_stock_items = current_stock_container.css('div.fruit-stock')
            
            if fruit_stock_items:
                for item_div in fruit_stock_items:
                    item = FruitStockItem() # Buat instance Item untuk setiap buah
                    
                    item['timestamp'] = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
                    item['timer'] = timer_text # Timer sama untuk semua item di halaman yang sama

                    # Nama buah: ambil dari atribut 'title' dari tag <a>
                    item['name'] = item_div.css('a::attr(title)').get()

                    # --- PERBAIKAN DI SINI: Selektor Harga Buah ---
                    # Menggunakan XPath yang benar untuk dua class atau CSS selector yang lebih mudah
                    # price_element_raw = item_div.xpath(".//span[contains(@class, 'color-currency') and contains(@class, 'Money')]/text()").get()
                    price_element_raw = item_div.css('span.color-currency.Money::text').get() # Lebih mudah dengan CSS selector
                    
                    if price_element_raw:
                        self.logger.debug(f"Harga mentah ditemukan: {price_element_raw}")
                        # Hapus tanda '$' dan koma ',', lalu konversi ke integer
                        item['price'] = int(price_element_raw.replace('$', '').replace(',', ''))
                    else:
                        item['price'] = None 
                        self.logger.warning(f"Harga untuk '{item.get('name', 'N/A')}' tidak ditemukan atau kosong.")
                    
                    # Yield item untuk dikirim ke pipeline (untuk disimpan)
                    if item.get('name') and item.get('price') is not None:
                        yield item
                    else:
                        self.logger.warning(f"Item stok tidak lengkap atau harga tidak valid: {item.get('name', 'N/A')}. Skip.")
            else:
                self.logger.warning("Tidak ada item 'fruit-stock' ditemukan dalam wadah 'CURRENT STOCK'.")
        else:
            self.logger.error("Wadah 'CURRENT STOCK' tidak ditemukan.")