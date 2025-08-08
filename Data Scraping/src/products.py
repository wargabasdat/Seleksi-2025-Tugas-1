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

def clean_description(text):
    text = re.split(r"Details|CARE INSTRUCTIONS|Shipping/Returns|Return/Shipping|SHIPPING", text, flags=re.IGNORECASE)[0]
    text = re.sub(r"^Description\s*\n?", "", text, flags=re.IGNORECASE)
    return re.sub(r'\s+', ' ', text).strip()

def extract_material(desc):
    match = re.search(r"Material\s*:\s*(.*?)(?:\n|Size\s*:|Measurement\s*:)", desc, re.IGNORECASE | re.DOTALL)
    if match: return match.group(1).strip()
    return ""

def extract_size(desc):
    match = re.search(r"Size\s*:\s*(.*?)\n", desc, re.IGNORECASE)
    if match: return match.group(1).strip()
    return ""

def get_category_id(category_name):
    category_map = { "Dress": "C001", "Top": "C002", "Outerwear": "C003", "Card": "C004", "Pants": "C005", "Skirt": "C006", "Overall":"C007", "Accesories":"C008", "Blanket":"C009", "Cushion":"C010", "Vests":"C011" }
    for key, value in category_map.items():
        if key.lower() in category_name.lower(): return value
    return "C999"

def get_product_detail(driver, url):
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
                return None

    soup = BeautifulSoup(driver.page_source, "html.parser")
    og_img = soup.find("meta", property="og:image")
    image_url = og_img['content'] if og_img else ""
    name = "Nama Tidak Ditemukan"
    if soup.title and soup.title.string:
        name = soup.title.string.split("–")[0].strip()

    material, size, category, raw_desc = "", "", "uncategorized", ""
    price, compare_at_price = 0, 0
    detail_script = soup.find("script", type="application/ld+json")
    if detail_script:
        try:
            data = json.loads(detail_script.string)
            raw_desc = data.get("description", "")
            material = extract_material(raw_desc)
            size = extract_size(raw_desc)
            category = data.get("category", category)
            name = data.get("name", name)
            if "offers" in data and data["offers"]: price = data["offers"][0].get("price", 0)
        except (json.JSONDecodeError, AttributeError): pass
    description = clean_description(raw_desc)
    product_id = "None"
    script_tag = soup.find("script", attrs={"type": "application/json", "data-product-json": True})
    if script_tag:
        try:
            product_json = json.loads(script_tag.string)
            product_id = str(product_json["product"]["id"])
            variants = product_json.get("product", {}).get("variants", [])
            if variants:
                price = variants[0].get("price", 0) / 100
                temp_compare_price = variants[0].get("compare_at_price")
                if temp_compare_price: compare_at_price = temp_compare_price / 100
        except (json.JSONDecodeError, AttributeError, KeyError): pass
    if product_id == "None": return None
    return {
        "product_id": product_id, "name": name, "category": category, "description": description,
        "material": material, "size": size, "image_url": image_url, "price": price,
        "compare_at_price": compare_at_price
    }

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

    all_products_data = []
    discount_products_data = []
    normal_products_data = []
    category_set = set()

    all_product_urls = get_all_product_urls(driver, start_url)

    print("\nTahap 2: Memproses setiap URL untuk mendapatkan detail produk")
    total_urls = len(all_product_urls)
    for i, url in enumerate(all_product_urls):
        if i > 0 and i % 100 == 0:
            print(f"\nTelah memproses {i} produk. Merestart browser untuk menyegarkan sesi...")
            driver.quit()
            driver = get_driver()
            print("Browser berhasil direstart, melanjutkan proses.\n")

        print(f"Memproses produk {i + 1}/{total_urls}...")

        try:
            detail = get_product_detail(driver, url)
        except InvalidSessionIdException:
            print(f"  -> !!! Browser session CRASHED. Kemungkinan karena halaman bermasalah.")
            print(f"  -> Merestart browser...")
            driver = get_driver()
            print(f"  -> Mencoba lagi URL yang gagal: {url}")
            detail = get_product_detail(driver, url)

        if not detail:
            continue

        category_id = get_category_id(detail['category'])
        category_set.add((category_id, detail['category'].title()))

        full_record = {
            "product_id": detail['product_id'], "name": detail['name'], "category_id": category_id,
            "description": detail['description'], "material": detail['material'], "size": detail['size'],
            "image_url": detail['image_url'], "price": detail['price']
        }
        all_products_data.append(full_record)
        print(f"  -> Berhasil scrape: {detail['name']}")

        is_discounted = detail['compare_at_price'] and detail['compare_at_price'] > detail['price']

        if is_discounted:
            discount_record = {
                "product_id": detail['product_id'],
                "normal_price": detail['compare_at_price']
            }
            discount_products_data.append(discount_record)
        else:
            normal_record = {
                "product_id": detail['product_id']
            }
            normal_products_data.append(normal_record)

    driver.quit()

    print("\n----------------------------------------")
    print(f"Scraping complete. Total products found: {len(all_products_data)}")
    print(f"Total discount products found: {len(discount_products_data)}")
    print(f"Total normal products found: {len(normal_products_data)}")
    print("------------------------------------------\n")

    append_and_dedup_json("/Users/allodyaq/Seleksi-2025-Tugas-1/Data Scraping/data/products.json", all_products_data)
    append_and_dedup_json("/Users/allodyaq/Seleksi-2025-Tugas-1/Data Scraping/data/discount_products.json", discount_products_data)
    append_and_dedup_json("/Users/allodyaq/Seleksi-2025-Tugas-1/Data Scraping/data/normal_products.json", normal_products_data)

    categories = sorted(list(category_set), key=lambda x: x[0])
    with open("/Users/allodyaq/Seleksi-2025-Tugas-1/Data Scraping/data/categories.json", "w", encoding="utf-8") as f:
        json.dump([{"category_id": cid, "name": name} for cid, name in categories if cid != "C999"], f, indent=2, ensure_ascii=False)

    print("All data has been saved to .json files.")

if __name__ == "__main__":
    main()
