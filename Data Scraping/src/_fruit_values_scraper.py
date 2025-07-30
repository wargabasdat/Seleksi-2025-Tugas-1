import requests
from bs4 import BeautifulSoup
import logging
import time
import os
import re # Tambahkan untuk regex jika diperlukan, terutama untuk pembersihan data

logging.basicConfig(level=logging.INFO,
                    format='%(asctime)s - %(levelname)s - %(message)s',
                    handlers=[
                        logging.FileHandler(os.path.join(os.path.dirname(__file__), '..', 'logs', "fruit_values_scraper.log")),
                        logging.StreamHandler()
                    ])
logger = logging.getLogger(__name__)

def scrape_fruit_values():
    """
    Melakukan scraping nilai buah (value, demand) dan status dari bloxfruitsvalues.com.
    Mengambil dari berbagai kategori.
    """
    categories = ['common', 'uncommon', 'rare', 'legendary', 'mythical'] 
    all_fruit_values = []

    for category in categories:
        url = f"https://bloxfruitsvalues.com/{category}"
        logger.info(f"Memulai scraping nilai buah dari {url}")
        
        try:
            response = requests.get(url, timeout=15)
            response.raise_for_status()
            soup = BeautifulSoup(response.text, 'html.parser')

            # --- Selektor Wadah Kartu Buah Individual ---
            fruit_cards = soup.find_all('div', class_='bg-white/5 flex flex-col gap-10 pt-2 pb-5 px-3 rounded-lg')
            
            if fruit_cards:
                for card in fruit_cards:
                    fruit_name = "N/A"
                    value = "N/A"
                    demand = "N/A"
                    fruit_category_label = "N/A" # Ini label 'Mythical', 'Rare', dll.
                    status = "N/A" # Status: Stable, Overpaid, Underpaid

                    # --- Ekstrak Kategori Buah (label di atas nama) ---
                    category_element = card.find('p', class_='text-xs font-semibold text-white/40 absolute top-0 left-0 h-4 w-12')
                    if category_element:
                        fruit_category_label = category_element.get_text(strip=True)
                    
                    # --- Ekstrak Nama Buah ---
                    name_element = card.find('h1', class_='text-2xl font-semibold mt-1 text-[#f2f2f2] absolute top-2 left-0 h-10 w-24 cursor-pointer')
                    if not name_element: # Fallback jika class terlalu spesifik atau berubah
                        name_element = card.find('h1') 
                    if name_element:
                        fruit_name = name_element.get_text(strip=True)

                    # --- Ekstrak Nilai (Value) dan Permintaan (Demand) ---
                    # Keduanya berada dalam struktur yang sama, tetapi di div pembungkus yang berbeda.
                    # Kita harus menemukan div pembungkus untuk 'Value' dan 'Demand' terlebih dahulu.
                    
                    # Cari semua div dengan class 'flex-row px-3 ml-1 justify-between w-full items-end mb-1'
                    # karena ini adalah wadah untuk pasangan (label + angka) 'Value' dan 'Demand'
                    # Di dalam setiap section, cari div yang berisi teks label (misal "Value" atau "Demand")
                    value_demand_div = card.find_all('div', class_='text-sm font-medium text-[#f2f2f2] mt-px')
                    value_div = value_demand_div[0] if len(value_demand_div) > 0 else None
                    demand_div = value_demand_div[1] if len(value_demand_div) > 1 else None
                    if value_div and demand_div:
                        value_demand_element = card.find_all('h2', class_='text-2xl contents')
                        value_element = value_demand_element[0] if len(value_demand_element) > 0 else None
                        demand_element = value_demand_element[1] if len(value_demand_element) > 1 else None
                        if value_element:
                            extracted_data = value_element.get_text(strip=True)
                            value = extracted_data
                        if demand_element:
                            extracted_data = demand_element.get_text(strip=True)
                            demand = extracted_data
                    else:
                        print("Label div tidak ditemukan, periksa struktur HTML.")

                    # --- Ekstrak Status (Stable, Overpaid, Underpaid) ---
                    # Ini adalah h1 dengan class 'text-sm font-medium' yang berisi status
                    status_element = card.find('h1', class_='text-sm font-medium')
                    if status_element:
                        status = status_element.get_text(strip=True)


                    all_fruit_values.append({
                        'category': fruit_category_label, # Gunakan label yang di-scrape dari halaman
                        'fruit_name': fruit_name,
                        'value': value,
                        'demand': demand,
                        'status': status
                    })
                logger.info(f"Berhasil mengikis {len(fruit_cards)} buah dari kategori '{category}'.")
            else:
                logger.warning(f"Tidak ada kartu buah ditemukan di {url}. Periksa selektor 'fruit_cards'.")

        except requests.exceptions.RequestException as e:
            logger.error(f"Gagal mengakses URL {url}: {e}")
        except Exception as e:
            logger.error(f"Kesalahan tak terduga saat mengikis nilai buah dari '{category}': {e}", exc_info=True)
        
        time.sleep(2) # Jeda antar permintaan ke kategori berikutnya

    return all_fruit_values

if __name__ == '__main__':
    values_data = scrape_fruit_values()
    if values_data:
        print("\n--- Hasil Uji Coba Scraping Nilai Buah ---")
        for item in values_data:
            print(f"Kategori: {item['category']}, Nama: {item['fruit_name']}, Nilai: {item['value']}, Demand: {item['demand']}, Status: {item['status']}")
    else:
        print("Gagal mendapatkan nilai buah.")