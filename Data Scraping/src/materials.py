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

print("Starting material scraper...")
driver.get(url)
soup = BeautifulSoup(driver.page_source, "html.parser")

tags = soup.select('a[href*="material_"]')
materials = {}

for tag in tags:
    href = tag.get("href", "")
    match = re.search(r"material_([a-zA-Z0-9\-]+)", href)
    if match:
        material_name = match.group(1).upper()
        full_url = urljoin(base_url, href)
        materials[material_name] = full_url

driver.quit()

formatted_materials = [{"material": m, "url": materials[m]} for m in sorted(materials)]

with open("materials.json", "w", encoding="utf-8") as f:
    json.dump(formatted_materials, f, indent=2, ensure_ascii=False)

print(f"Scraped {len(formatted_materials)} materials.")
