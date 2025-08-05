import time
import json
import re
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

def parse_color(variant_name):
    """Mengekstrak warna dari nama varian, yang biasanya ada di bagian akhir."""
    if '/' in variant_name:
        color_part = variant_name.split('/')[-1].strip()
        return color_part
    return None

def get_variants_detail(driver, url):
    """Mengekstrak semua varian dari satu halaman produk, dengan logika retry."""
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
    variants_list = []
    product_id = None

    script_tag_id = soup.find("script", attrs={"type": "application/json", "data-product-json": True})
    if script_tag_id:
        try:
            product_id = str(json.loads(script_tag_id.string)["product"]["id"])
        except (json.JSONDecodeError, KeyError): pass
    
    if not product_id: return []

    ld_json_script = soup.find("script", type="application/ld+json")
    if not ld_json_script: return []

    try:
        data = json.loads(ld_json_script.string)
        offers = data.get("offers", [])

        for offer in offers:
            variant_id_match = re.search(r'variant=(\d+)', offer.get("url", ""))
            if not variant_id_match: continue
            
            variant_id = int(variant_id_match.group(1))
            name = offer.get("name", "")
            availability = offer.get("availability", "").split('/')[-1]
            color = parse_color(name)

            variants_list.append({
                "variant_id": variant_id,
                "product_id": product_id,
                "name": name,
                "availability": availability,
                "color": color
            })
    except (json.JSONDecodeError, AttributeError): pass
        
    return variants_list

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

    variant_data = []
    
    all_product_urls = get_all_product_urls(driver, start_url)

    print("\nTahap 2: Memproses setiap URL untuk mendapatkan data varian")
    total_urls = len(all_product_urls)
    for i, url in enumerate(all_product_urls):
        
        if i > 0 and i % 100 == 0:
            print(f"\nTelah memproses {i} produk. Merestart browser untuk menyegarkan sesi...")
            driver.quit()
            driver = get_driver()
            print("Browser berhasil direstart, melanjutkan proses.\n")

        print(f"Memproses produk {i + 1}/{total_urls}...")
        
        try:
            variants_list = get_variants_detail(driver, url)
        except InvalidSessionIdException:
            print(f"  -> !!! Browser session CRASHED. Merestart browser...")
            driver = get_driver()
            print(f"  -> Mencoba lagi URL yang gagal: {url}")
            variants_list = get_variants_detail(driver, url)

        if variants_list:
            product_name = url.split('/')[-1].replace('-', ' ').title()
            print(f"  -> Ditemukan {len(variants_list)} varian untuk '{product_name}'")
            variant_data.extend(variants_list)
            
    driver.quit()

    print("\n---------------------------------------")
    print(f"Scraping complete. Total variants: {len(variant_data)}")
    print("---------------------------------------\n")
    
    with open("variants.json", "w", encoding="utf-8") as f:
        json.dump(variant_data, f, indent=2, ensure_ascii=False)
        
    print("All data has been saved to .json files")

if __name__ == "__main__":
    main()