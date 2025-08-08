import subprocess
import logging
import os

# Konfigurasi logging dasar
logging.basicConfig(level=logging.INFO, format='[%(asctime)s] [%(levelname)s] %(message)s')
BASE_DIR = os.path.dirname(os.path.abspath(__file__))
PROJECT_ROOT = os.path.dirname(BASE_DIR)

# Konfigurasi file log untuk menyimpan riwayat eksekusi
LOG_FILE = os.path.join(BASE_DIR, 'pipeline.log')
logging.basicConfig(
    level=logging.INFO,
    format='[%(asctime)s] [%(levelname)s] - %(message)s',
    handlers=[
        logging.FileHandler(LOG_FILE), # Simpan log ke file
        logging.StreamHandler()  
    ]
)

# Daftar tugas yang akan dijalankan secara berurutan
TASKS = [
    {
        "name": "Data Scraping",
        "path": os.path.join(PROJECT_ROOT, 'Data Scraping', 'src', 'scraper.py')
    },
    {
        "name": "Data Storing",
        "path": os.path.join(PROJECT_ROOT, 'Data Storing', 'src', 'loader.py')
    },
    {
        "name": "Data Warehouse ETL",
        "path": os.path.join(PROJECT_ROOT, 'Data Warehouse', 'src', 'etl.py')
    }
]

def run_task(task_name, script_path):
    """Fungsi untuk menjalankan satu skrip Python dan menangani hasilnya."""
    logging.info(f"Memulai tugas: {task_name}")
    
    # Cek apakah file skrip benar-benar ada sebelum mencoba menjalankannya
    if not os.path.exists(script_path):
        logging.error(f"Script tidak ditemukan: {script_path}")
        return False
        
    try:
        # Menjalankan skrip python sebagai proses terpisah
        subprocess.run(
            ['python', script_path], 
            check=True, 
            capture_output=True, # Tangkap output untuk logging jika perlu
            text=True
        )
        logging.info(f"Tugas '{task_name}' berhasil diselesaikan.")
        return True
    except subprocess.CalledProcessError as e:
        # Menangkap error jika skrip gagal
        logging.error(f"Tugas '{task_name}' gagal!")
        logging.error(f"Error output:\n{e.stderr}")
        return False

# main function untuk menjalankan pipeline
if __name__ == "__main__":
    logging.info("=============================================")
    logging.info("ETL PIPELINE EXECUTION STARTED")
    logging.info("=============================================")
    
    # Loop melalui setiap tugas dan jalankan
    for task in TASKS:
        success = run_task(task['name'], task['path'])
        if not success:
            logging.critical("Pipeline dibatalkan.")
            break
    else:
        logging.info("Semua task berhasil dijalankan. Pipeline selesai.")
        
    logging.info("=============================================\n")

logging.shutdown()