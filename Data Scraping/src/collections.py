import json
import time
from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.chrome.service import Service
from urllib.parse import urljoin

# Setup headless browser
options = Options()
options.add_argument("--headless=new")
options.add_argument("--no-sandbox")
options.add_argument("--disable-gpu")
options.add_argument("--window-size=1920x1080")
service = Service("/opt/homebrew/bin/chromedriver")
driver = webdriver.Chrome(service=service, options=options)

base_url = "https://dumaofficial.com"
collections_url = f"{base_url}/collections/all"

print("Scraping collections...")

driver.get(collections_url)
time.sleep(2)
soup = BeautifulSoup(driver.page_source, "html.parser")

collections = []

for tag in soup.select('a[href^="/collections/all/collection_"]'):
    href = tag.get("href")
    name = tag.get_text(strip=True)
    full_url = urljoin(base_url, href)

    collections.append({
        "name": name,
        "url": full_url
    })

driver.quit()

with open("collections.json", "w", encoding="utf-8") as f:
    json.dump(collections, f, indent=2, ensure_ascii=False)

print(f"Scraped {len(collections)} collections.")
