import re
import json
from urllib.parse import urljoin
from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.chrome.service import Service

# Setup browser
options = Options()
options.add_argument("--headless=new")
options.add_argument("--no-sandbox")
options.add_argument("--disable-gpu")
options.add_argument("--window-size=1920x1080")
service = Service("/opt/homebrew/bin/chromedriver")
driver = webdriver.Chrome(service=service, options=options)

base_url = "https://dumaofficial.com"
url = f"{base_url}/collections/all"

print("Starting size scraper...")
driver.get(url)
soup = BeautifulSoup(driver.page_source, "html.parser")

# Temukan semua link dengan 'size_' di href-nya
tags = soup.select('a[href*="size_"]')
sizes = {}

for tag in tags:
    href = tag.get("href", "")
    match = re.search(r"size_([a-zA-Z0-9\-]+)", href)
    if match:
        size_key = match.group(1).upper()
        full_url = urljoin(base_url, href)
        sizes[size_key] = full_url

driver.quit()

sizes_json = [{"size": size, "url": sizes[size]} for size in sorted(sizes)]

with open("sizes.json", "w", encoding="utf-8") as f:
    json.dump(sizes_json, f, indent=2, ensure_ascii=False)

print(f"Scraped {len(sizes_json)} sizes.")
