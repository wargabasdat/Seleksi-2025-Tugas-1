import time
import json
import re
import os
from urllib.parse import urljoin
from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.common.exceptions import TimeoutException, InvalidSessionIdException

def get_driver():
    options = Options()
    options.add_argument("--headless")
    options.add_argument("--no-sandbox")
    options.add_argument("--disable-gpu")
    options.add_argument("--window-size=1920x1080")
    prefs = {"profile.managed_default_content_settings.images": 2}
    options.add_experimental_option("prefs", prefs)
    driver = webdriver.Chrome(options=options)
    driver.set_page_load_timeout(60)
    driver.implicitly_wait(10)
    return driver

def append_and_dedup_json(file_path, new_data, key='product_id'):
    if os.path.exists(file_path):
        with open(file_path, 'r', encoding='utf-8') as f:
            old_data = json.load(f)
    else:
        old_data = []

    combined = old_data + new_data
    unique_dict = {str(item[key]): item for item in combined} 
    unique_data = list(unique_dict.values())

    with open(file_path, 'w', encoding='utf-8') as f:
        json.dump(unique_data, f, indent=2, ensure_ascii=False)

def extract_measurements(description_text, product_id):
    def clean_details_dict(pairs):
        details_dict = {}
        for key, value in pairs:
            clean_key = key.strip().split('\n')[-1].strip().lower()
            if clean_key == 'sleevelength':
                clean_key = 'sleeve length'
            if 'back rise' in clean_key:
                clean_key = 'front/back rise'
            details_dict[clean_key] = value.strip()
        return details_dict

    measurements_data = []
    measurement_section_match = re.search(
        r"Measurement\s*:\s*(.*?)(?:\n\s*\nKindly note|\n\s*\nCARE INSTRUCTIONS)",
        description_text, re.DOTALL | re.IGNORECASE)
    
    if not measurement_section_match:
        return []

    measurement_block = measurement_section_match.group(1).strip()
    
    if not re.search(r"^Size\s+[a-zA-Z0-9]", measurement_block, re.IGNORECASE):
        size_name = "ALL SIZE"
        pairs = re.findall(r"([a-zA-Z\s\n/]+?)\s*:\s*(.*?)\s*\n", measurement_block + "\n")
        if pairs:
            details_dict = clean_details_dict(pairs)
            measurements_data.append({
                "product_id": product_id,
                "size_name": size_name,
                "details": details_dict
            })
    else:
        size_blocks = re.split(r"\n*\s*Size\s+", measurement_block)
        for block in size_blocks:
            if not block.strip():
                continue
            lines = block.strip().split('\n')
            raw_size_name = lines[0].strip()
            size_name = raw_size_name.replace("Size", "").strip().upper()
            if size_name == "": continue 
            details_text = "\n".join(lines[1:])
            pairs = re.findall(r"([a-zA-Z\s\n/]+?)\s*:\s*(.*?)\s*\n", details_text + "\n")
            if pairs:
                details_dict = clean_details_dict(pairs)
                measurements_data.append({
                    "product_id": product_id,
                    "size_name": size_name,
                    "details": details_dict
                })
    return measurements_data

def get_measurements_detail(driver, url):
    retries = 3
    for i in range(retries):
        try:
            driver.get(url)
            break
        except TimeoutException:
            print(f"  -> Timeout on URL: {url}. Attempt {i + 1}/{retries}.")
            if i < retries - 1:
                time.sleep(5)
            else:
                print(f"  -> Skipping product after {retries} failed attempts.")
                return []

    soup = BeautifulSoup(driver.page_source, "html.parser")
    product_id, raw_desc = None, ""
    script_tag_id = soup.find("script", attrs={"type": "application/json", "data-product-json": True})
    if script_tag_id:
        try:
            product_id = str(json.loads(script_tag_id.string)["product"]["id"])
        except (json.JSONDecodeError, KeyError): pass
    if not product_id: return []
    script_tag_desc = soup.find("script", type="application/ld+json")
    if script_tag_desc:
        try:
            raw_desc = json.loads(script_tag_desc.string).get("description", "")
        except json.JSONDecodeError: pass
    if raw_desc:
        return extract_measurements(raw_desc, product_id)
    return []

def get_all_product_urls(driver, start_url):
    print("Tahap 1: Mengumpulkan semua URL produk")
    driver.get(start_url)
    time.sleep(5)
    urls = set()
    last_height = driver.execute_script("return document.body.scrollHeight")
    while True:
        driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
        time.sleep(3)
        new_height = driver.execute_script("return document.body.scrollHeight")
        soup = BeautifulSoup(driver.page_source, "html.parser")
        for item in soup.select(".ProductItem__Title a"):
            full_url = urljoin(start_url, item['href'])
            urls.add(full_url)
        print(f"Mengumpulkan... {len(urls)} URL ditemukan.")
        if new_height == last_height:
            print("Sudah mencapai bagian bawah halaman.")
            break
        last_height = new_height
    print(f"Selesai. Total {len(urls)} URL unik ditemukan.")
    return list(urls)

def main():
    driver = get_driver()
    base_url = "https://dumaofficial.com"
    start_url = f"{base_url}/collections/all"

    measurement_data = []
    all_product_urls = get_all_product_urls(driver, start_url)

    print("\nTahap 2: Memproses setiap URL untuk mendapatkan data pengukuran")
    total_urls = len(all_product_urls)
    for i, url in enumerate(all_product_urls):
        if i > 0 and i % 100 == 0:
            print(f"\nTelah memproses {i} produk. Merestart browser untuk menyegarkan sesi...")
            driver.quit()
            driver = get_driver()
            print("Browser berhasil direstart, melanjutkan proses.\n")
        print(f"Memproses produk {i + 1}/{total_urls}...")
        try:
            measurements_list = get_measurements_detail(driver, url)
        except InvalidSessionIdException:
            print(f"  -> !!! Browser session CRASHED. Merestart browser...")
            driver = get_driver()
            print(f"  -> Mencoba lagi URL yang gagal: {url}")
            measurements_list = get_measurements_detail(driver, url)
        if measurements_list:
            print(f"  -> Ditemukan {len(measurements_list)} set pengukuran.")
            measurement_data.extend(measurements_list)
    driver.quit()

    print("\n-------------------------------------------------------")
    print(f"Scraping complete. Total products with measurements: {len(measurement_data)}")
    print("-------------------------------------------------------\n")

    append_and_dedup_json("/Users/allodyaq/Seleksi-2025-Tugas-1/Data Scraping/data/measurements.json", measurement_data)
    print("All data has been saved to json")

if __name__ == "__main__":
    main()
