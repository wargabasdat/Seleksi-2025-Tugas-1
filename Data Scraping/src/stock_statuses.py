import re
import json
from urllib.parse import urljoin
from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.chrome.service import Service

# Setup headless browser
options = Options()
options.add_argument("--headless=new")
options.add_argument("--no-sandbox")
options.add_argument("--disable-gpu")
options.add_argument("--window-size=1920x1080")
service = Service("/opt/homebrew/bin/chromedriver")
driver = webdriver.Chrome(service=service, options=options)

base_url = "https://dumaofficial.com"
url = f"{base_url}/collections/all"

print("Starting stock status scraper...")
driver.get(url)
soup = BeautifulSoup(driver.page_source, "html.parser")

tags = soup.select('a[href*="stockstatus_"]')
statuses = {}

for tag in tags:
    href = tag.get("href", "")
    match = re.search(r"stockstatus_([a-zA-Z0-9\-]+)", href)
    if match:
        status_key = match.group(1).upper()
        full_url = urljoin(base_url, href)
        statuses[status_key] = full_url

driver.quit()

formatted_statuses = [{"status": s, "url": statuses[s]} for s in sorted(statuses)]

with open("stock_statuses.json", "w", encoding="utf-8") as f:
    json.dump(formatted_statuses, f, indent=2, ensure_ascii=False)

print(f"Scraped {len(formatted_statuses)} stock statuses.")
