# Lokasi file: Data Scraping/run_scrapy_pipeline.py

import os
import sys
import subprocess
import logging
import time
from datetime import datetime

# ===================================================================
# KONFIGURASI
# ===================================================================
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - [%(name)s] - %(message)s')
logger = logging.getLogger("Scrapy_Orchestrator")

# Folder output untuk file JSON, relatif terhadap skrip ini
OUTPUT_DIR = 'data'
# Lokasi folder proyek Scrapy
SCRAPY_PROJECT_DIR = 'src'

SPIDERS_TO_RUN = {
    'fruit_details_spider': 'fruits.json',
    'fruit_values_spider': 'fruit_values.json',
    'fruit_stock_spider': 'fruit_stock.json',
    'sword_details_spider': 'swords.json',
    'gun_details_spider': 'guns.json',
    'update_log_spider': 'update_logs.json',
}
# ===================================================================

def run_extraction():
    """Menjalankan semua spider Scrapy dan menyimpan output ke folder /data."""
    logger.info(f"--- MEMULAI TAHAP EKSTRAKSI (E) ---")
    logger.info(f"Output akan disimpan di folder: '{os.path.abspath(OUTPUT_DIR)}'")
    start_time = time.time()

    # Pastikan folder output ada
    os.makedirs(OUTPUT_DIR, exist_ok=True)

    for i, (spider_name, output_file) in enumerate(SPIDERS_TO_RUN.items(), 1):
        # Gabungkan path folder output dengan nama file
        output_path = os.path.join(OUTPUT_DIR, output_file)

        # Hapus file lama jika ada
        if os.path.exists(output_path):
            os.remove(output_path)

        logger.info(f"[E] Menjalankan spider {i}/{len(SPIDERS_TO_RUN)}: {spider_name}...")
        command = [
            sys.executable, '-m', 'scrapy', 'crawl', spider_name,
            '-O', output_path  # Simpan ke path yang benar
        ]
        
        # Jalankan perintah dari dalam direktori source scrapy
        process = subprocess.run(
            command, 
            cwd=SCRAPY_PROJECT_DIR, 
            capture_output=True, 
            text=True, 
            encoding='utf-8', # Perbaikan untuk UnicodeDecodeError
            errors='ignore'   # Perbaikan untuk UnicodeDecodeError
        )
        
        if process.returncode != 0:
            logger.error(f"❌ Gagal saat menjalankan spider '{spider_name}'.")
            logger.error("--- DETAIL ERROR --- \n" + process.stderr + "\n--- AKHIR DETAIL ERROR ---")
            return False
        else:
            logger.info(f"✅ Spider '{spider_name}' selesai. Output: '{output_path}'.")
    
    duration = time.time() - start_time
    logger.info(f"--- EKSTRAKSI DATA (E) SELESAI dalam {duration:.2f} detik ---")
    return True

if __name__ == '__main__':
    run_extraction()