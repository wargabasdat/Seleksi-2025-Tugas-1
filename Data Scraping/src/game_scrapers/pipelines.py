import json
import os
from datetime import datetime
from itemadapter import ItemAdapter # <--- 1. IMPORT ItemAdapter

class JsonWriterPipeline:
    def open_spider(self, spider):
        # Dapatkan path ke folder data (dua level di atas 'game_scrapers')
        # Path: .../Data Scraping/src/game_scrapers/pipelines.py -> .../Data Scraping/data/
        base_data_dir = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', '..', 'data')
        
        # Tentukan subfolder dan nama file berdasarkan nama spider
        if spider.name == 'fruit_stock_spider':
            self.file_path = os.path.join(base_data_dir, 'fruit_stock')
            self.file_prefix = 'stock_data'
        elif spider.name == 'fruit_details_spider':
            self.file_path = os.path.join(base_data_dir, 'fruit_details')
            self.file_prefix = 'fruit_details'
        elif spider.name == 'fruit_values_spider':
            self.file_path = os.path.join(base_data_dir, 'fruit_values')
            self.file_prefix = 'fruit_values'
        elif spider.name == 'sword_details_spider':
            self.file_path = os.path.join(base_data_dir, 'sword_details')
            self.file_prefix = 'sword_details'
        elif spider.name == 'gun_details_spider':
            self.file_path = os.path.join(base_data_dir, 'gun_details')
            self.file_prefix = 'gun_details'
        elif spider.name == 'blox_fruits_master_list_spider':
            self.file_path = os.path.join(base_data_dir, 'fandom_master_list')
            self.file_prefix = 'master_list_data'
        else: # Fallback untuk spider yang tidak dikenal
            self.file_path = os.path.join(base_data_dir, 'other_data')
            self.file_prefix = 'data'
        
        # Pastikan direktori output ada
        os.makedirs(self.file_path, exist_ok=True)
        
        # Buat nama file unik dengan timestamp
        timestamp_str = datetime.now().strftime("%Y%m%d_%H%M%S")
        filename = os.path.join(self.file_path, f"{self.file_prefix}_{timestamp_str}.json")
        
        # Buka file JSON untuk menulis
        self.file = open(filename, 'w', encoding='utf-8')
        # Mulai dengan array JSON
        self.file.write('[\n')
        self.first_item = True # Flag untuk menangani koma antar item

    def close_spider(self, spider):
        # Tutup array JSON dan file
        self.file.write('\n]')
        self.file.close()

    def process_item(self, item, spider):
        # Tambahkan koma sebelum item berikutnya (kecuali yang pertama)
        if self.first_item:
            self.first_item = False
        else:
            self.file.write(',\n')
        
        # --- 2. GANTI dict(item) DENGAN ItemAdapter(item).asdict() ---
        # Ini akan secara rekursif mengubah semua Item (termasuk AbilityItem) menjadi dict
        line = json.dumps(ItemAdapter(item).asdict(), ensure_ascii=False, indent=4)
        self.file.write(line)
        
        return item # Penting: kembalikan item agar bisa diproses oleh pipeline lain (jika ada)