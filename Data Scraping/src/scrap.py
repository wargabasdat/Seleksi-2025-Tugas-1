import requests
from bs4 import BeautifulSoup
import json
import time
import random
import math
import os
import re
from urllib.parse import quote_plus

BASE_URL = "https://www.techpowerup.com"
CPU_SPECS_URL = f"{BASE_URL}/cpu-specs/"

# Mendapatkan daftar kata kunci untuk CPU berdasarkan kategori
# Karena web sangat sensitif dengan rate limit, maka satu satu
def get_search_terms():
    return [
        'AMD Ryzen 9',
        'AMD Ryzen 7',
        'AMD Ryzen 5',
        'AMD Ryzen 3',
        'AMD Ryzen Threadripper', 
        'AMD FX',
        'Intel Core i9', 
        'Intel Core i7',
        'Intel Core i5', 
        'Intel Core i3', 
        'Intel Core Ultra', 
        'Intel Xeon',
        'Intel Pentium', 
        'Intel Celeron',
        'Intel Processor', 
        'Qualcomm', 
        'StarFive', 
        'Via'
    ]

# Mengambil link CPU berdasarkan kata kunci
def get_links_from_search(session, search_term):
    encoded_term = quote_plus(search_term)
    search_url = f"{CPU_SPECS_URL}?q={encoded_term}&ajax=true"
    print(f"Mencari dengan kata kunci: '{search_term}'...")

    try:
        response = session.get(search_url, timeout=10)
        response.raise_for_status()
        data = response.json()
        table_html = data.get('list')

        if table_html and "Nothing found" not in table_html:
            soup = BeautifulSoup(table_html, 'html.parser')
            table = soup.find("table", class_="items-desktop-table")
            if table:
                links_on_page = {BASE_URL + row.find('a')['href'] for row in table.find_all('tr')[1:] if row.find('a')}
                print(f"  -> OK. Total link ditemukan: {len(links_on_page)}")
                return list(links_on_page)

    except Exception as e:
        print(f"  -> Gagal memproses pencarian '{search_term}': {e}")
    return []

# Scrape dan parsing informasi detail dari halaman prosesor
def scrape_and_parse_cpu_detail(session, detail_url):
    print(f"Mengambil data dari: {detail_url}")
    try:
        response = session.get(detail_url, timeout=15)
        response.raise_for_status()
        soup = BeautifulSoup(response.text, 'html.parser')

        # Ambil semua spesifikasi dari tabel-tabel yang ada
        specs = {}
        sections = soup.find_all('section', class_='details')
        for section in sections:
            table = section.find('table')
            if table:
                for row in table.find_all('tr'):
                    field_name_tag = row.find('th')
                    field_value_tag = row.find('td')
                    if field_name_tag and field_value_tag:
                        key = field_name_tag.text.strip().replace(':', '').lower().replace(' ', '_').replace('#_of_', '')
                        value = ' '.join(field_value_tag.text.strip().split())
                        specs[key] = value

        # Ambil daftar fitur prosesor jika tersedia
        feature_list = []
        feature_ul = soup.find('ul', class_='clearfix features')
        if feature_ul:
            feature_list = [li.text.strip() for li in feature_ul.find_all('li')]

        # Helper functions untuk parsing data
        def clean_text(text): return text if text else None
        def parse_int(text): return int(re.search(r'[\d,]+', text).group().replace(',', '')) if text and re.search(r'[\d,]+', text) else None
        def parse_float(text): return float(re.search(r'[\d\.]+', text)[0]) if text and re.search(r'[\d\.]+', text) else None

        name_tag = soup.find('h1', class_='cpuname')
        name = clean_text(name_tag.text) if name_tag else "N/A"

        cores_threads_text = specs.get('cores')
        cores, threads = (None, None)
        if cores_threads_text:
            parts = [p.strip() for p in cores_threads_text.split('/')]
            cores = parse_int(parts[0])
            threads = parse_int(parts[1]) if len(parts) > 1 else cores

        # Return dictionary berisi spesifikasi prosesor
        return {
            "name": name, "url": detail_url, 
            "manufacturer": "AMD" if "AMD" in name else "Intel" if "Intel" in name else "Other",
            "cores": cores, "threads": threads, "frequency_ghz": parse_float(specs.get('frequency')),
            "turbo_clock_ghz": parse_float(specs.get('turbo_clock')), "cache_l1_kb": parse_int(specs.get('cache_l1')),
            "cache_l2_kb": parse_int(specs.get('cache_l2')), "cache_l3_mb": parse_int(specs.get('cache_l3')),
            "tdp_watts": parse_int(specs.get('tdp')), "launch_price_usd": parse_int(specs.get('launch_price')),
            "process_size_nm": parse_int(specs.get('process_size')), "codename": clean_text(specs.get('codename')),
            "generation": clean_text(specs.get('generation')), "socket": clean_text(specs.get('socket')),
            "release_date": clean_text(specs.get('release_date')), "integrated_graphics": specs.get('integrated_graphics', 'N/A'),
            "memory_support": clean_text(specs.get('memory_support')), "multiplier_unlocked": clean_text(specs.get('multiplier_unlocked')),
            "features": feature_list if feature_list else None
        }
    except Exception as e:
        print(f"  --> Gagal memproses {detail_url}: {e}")
        return None

# Menyimpan data hasil scraping
def save_progress(data, search_term, output_dir):
    output_filename = os.path.join(output_dir, f"{search_term.replace(' ', '_')}_data.json")
    with open(output_filename, 'w', encoding='utf-8') as f:
        json.dump(data, f, ensure_ascii=False, indent=4)
    print(f"✅ Data untuk '{search_term}' disimpan di '{output_filename}'")

# Melakukan request HTTP
def safe_request(url, session, max_retries=5):
    for attempt in range(max_retries):
        resp = session.get(url, timeout=15)
        if resp.status_code == 429:
            wait_time = 30 * math.pow(2, attempt)  # 30s, 60s, 120s...
            print(f"Rate limit! Tunggu {wait_time:.0f} detik...")
            time.sleep(wait_time)
            continue
        return resp
    return None

# Fungsi utama
if __name__ == "__main__":
    session = requests.Session()
    session.headers.update({
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
    })

    search_terms = get_search_terms()  # Daftar kata kunci pencarian
    output_dir = "../data/cpu_specs_output"  # Direktori output untuk file JSON
    os.makedirs(output_dir, exist_ok=True)  # Buat direktori jika belum ada

    # Memulai scraping untuk setiap kata kunci pencarian
    for term in search_terms:
        print(f"\n--- Memulai scraping untuk '{term}' ---")
        all_cpu_links = get_links_from_search(session, term)
        
        if not all_cpu_links:
            print(f"  -> Tidak ada link ditemukan untuk '{term}', lanjut ke pencarian berikutnya.")
            continue
        
        all_cpu_details = []
        
        for i, link in enumerate(all_cpu_links):
            print(f"Scraping CPU {i+1}/{len(all_cpu_links)}: {link.split('/')[-1]}")
            details = scrape_and_parse_cpu_detail(session, link)
            if details:
                all_cpu_details.append(details)
            time.sleep(random.uniform(3, 6))  # jeda antar request
        
        save_progress(all_cpu_details, term, output_dir)  # Simpan hasil scraping
