import re
import time
import json
from urllib.parse import urljoin
from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.chrome.service import Service
from selenium.common.exceptions import TimeoutException

# Setup headless browser content
options = Options()
options.add_argument("--headless=new")
options.add_argument("--no-sandbox")
options.add_argument("--disable-gpu")
options.add_argument("--window-size=1920x1080")
options.add_argument("--blink-settings=imagesEnabled=false")
service = Service("/opt/homebrew/bin/chromedriver")
driver = webdriver.Chrome(service=service, options=options)
driver.set_page_load_timeout(30)

base_url = "https://dumaofficial.com"
product_links = []
page = 1

print("Starting product scraper...")

# Step 1: Collect all product URLs
while True:
    url = f"{base_url}/collections/all?page={page}"
    try:
        driver.get(url)
    except TimeoutException:
        print(f"[Timeout] Skipping page {page}")
        break
    time.sleep(2)
    soup = BeautifulSoup(driver.page_source, "html.parser")
    items = soup.select("a.ProductItem__ImageWrapper")
    if not items:
        break
    for item in items:
        href = item.get("href")
        if href and "/collections/all/products/" in href:
            full_url = urljoin(base_url, href.split("?")[0])
            if full_url not in product_links:
                product_links.append(full_url)
    page += 1

# Step 2: Scrape individual product pages
products = []

for link in product_links:
    try:
        driver.get(link)
    except TimeoutException:
        print(f"[Timeout] Skipping product: {link}")
        continue

    time.sleep(0.1)
    soup = BeautifulSoup(driver.page_source, "html.parser")
    script = soup.find("script", type="application/ld+json", string=lambda x: x and '"@type": "Product"' in x)
    if not script:
        continue

    try:
        data = json.loads(script.string)
        full_desc = data.get("description", "").strip()

        for splitter in ["Details", "Measurement", "Material"]:
            if splitter in full_desc:
                short_desc = full_desc.split(splitter)[0].strip()
                break
        else:
            short_desc = full_desc

        short_desc = re.sub(r"^Description\s*", "", short_desc).replace("\n", " ").strip()

        material_match = re.search(r"Material\s*:\s*(.*)", full_desc)
        size_match = re.search(r"Size\s*:\s*(.*)", full_desc)
        material = material_match.group(1).strip() if material_match else None
        size = size_match.group(1).strip() if size_match else None
        measurements = re.findall(r"(Size\s*\d.*?)\n\n", full_desc, re.DOTALL)

        name = data.get("name")
        image = data.get("image", {}).get("url")
        url = urljoin(base_url, data.get("url", ""))
        category = data.get("category")

        variants = []
        prices = set()
        sold_out_flags = []

        for offer in data.get("offers", []):
            variant_name = offer.get("name")
            price = float(offer.get("price"))
            availability = offer.get("availability", "")
            sold_out = "OutOfStock" in availability
            variant_url = urljoin(base_url, offer.get("url", ""))
            prices.add(price)
            sold_out_flags.append(sold_out)
            variants.append({
                "variant_name": variant_name,
                "price": price,
                "sold_out": sold_out,
                "variant_url": variant_url
            })

        product = {
            "name": name,
            "category": category,
            "description": short_desc,
            "material": material,
            "size": size,
            "measurements": measurements,
            "url": url,
            "image": image,
            "variants": variants,
            "sold_out": all(sold_out_flags),
            "discount": len(prices) > 1 or "Price--compareAt" in str(soup)
        }

        products.append(product)

    except Exception as e:
        print(f"[Error] {e}")
        continue

driver.quit()

# Save data
with open("products.json", "w", encoding="utf-8") as f:
    json.dump(products, f, indent=2, ensure_ascii=False)

with open("discount_products.json", "w", encoding="utf-8") as f:
    json.dump([p for p in products if p["discount"]], f, indent=2, ensure_ascii=False)

print(f"Scraped {len(products)} products.")
