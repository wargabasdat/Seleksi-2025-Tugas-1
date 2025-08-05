import requests
from bs4 import BeautifulSoup
import json
import time

BASE_URL = "https://rcdb.com"
HEADERS = {"User-Agent": "Mozilla/5.0"}

def extract_id_from_href(href):
    return int(href.strip("/").split(".")[0]) if href else None

def get_location_from_park_page(park_id):
    url = f"{BASE_URL}/{park_id}.htm"
    response = requests.get(url, headers=HEADERS)
    soup = BeautifulSoup(response.content, "html.parser")

    feature_div = soup.select_one("#feature > div")
    if not feature_div:
        return None

    links = feature_div.find_all("a")
    if len(links) < 3:
        return None

    city = links[-3].text.strip()
    region = links[-2].text.strip()
    country = links[-1].text.strip()

    return {
        "city": city,
        "region": region,
        "country": country
    }

coasters = []
parks_dict = {}  # park_id: {id, name, location}

# Loop halaman 1–9
for page_num in range(1, 10):
    print(f"📄 Scraping page {page_num}...")
    url = f"{BASE_URL}/r.htm?page={page_num}&ot=2&op=2025"
    response = requests.get(url, headers=HEADERS)
    soup = BeautifulSoup(response.content, "html.parser")

    rows = soup.select("div.stdtbl.rer table tr")[1:]

    for row in rows:
        cols = row.find_all("td")
        if len(cols) < 7:
            continue

        name_tag = cols[1].find("a")
        park_tag = cols[2].find("a")
        type_tag = cols[3].find("a")
        design_tag = cols[4].find("a")
        status_tag = cols[5].find("a")
        opened_tag = cols[6].find("time")

        coaster_id = extract_id_from_href(name_tag["href"]) if name_tag else None
        park_id = extract_id_from_href(park_tag["href"]) if park_tag else None
        park_name = park_tag.text.strip() if park_tag else "-"

        # Coaster JSON
        coaster_data = {
            "id": coaster_id,
            "name": name_tag.text.strip() if name_tag else "-",
            "park_id": park_id,
            "type": type_tag.text.strip() if type_tag else "-",
            "design": design_tag.text.strip() if design_tag else "-",
            "status": status_tag.text.strip() if status_tag else "-",
            "opened": opened_tag.get("datetime", "").strip() if opened_tag else "-",
        }
        coasters.append(coaster_data)
        print(f"✅ Coaster {coaster_id} scraped.")

        # Simpan data park jika belum ada
        if park_id and park_id not in parks_dict:
            location = get_location_from_park_page(park_id)
            parks_dict[park_id] = {
                "id": park_id,
                "name": park_name,
                "location": location
            }

        time.sleep(0.5)

    time.sleep(1.5)

# Simpan coasters.json
with open("data/coasters.json", "w", encoding="utf-8") as f:
    json.dump(coasters, f, ensure_ascii=False, indent=2)

# Simpan parks.json
parks = list(parks_dict.values())
with open("data/parks.json", "w", encoding="utf-8") as f:
    json.dump(parks, f, ensure_ascii=False, indent=2)

print("🎢 Data berhasil disimpan ke coasters.json dan parks.json!")
