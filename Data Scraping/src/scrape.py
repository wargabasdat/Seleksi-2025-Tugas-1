import requests
from bs4 import BeautifulSoup
import json
import time

BASE_URL = "https://rcdb.com"
HEADERS = {
    "User-Agent": "Mozilla/5.0 (X11; Linux x86_64); Basis Data/13523078@std.stei.itb.ac.id"
}

def extract_id_from_href(href):
    return int(href.strip("/").split(".")[0]) if href else None

def get_coaster_detail(coaster_id):
    url = f"{BASE_URL}/{coaster_id}.htm"
    response = requests.get(url, headers=HEADERS)
    soup = BeautifulSoup(response.content, "html.parser")

    feature_div = soup.select_one("#feature > div")

    # lokasi park
    city = region = country = None
    links = feature_div.find_all("a") if feature_div else []
    if len(links) >= 3:
        city = links[-3].text.strip()
        region = links[-2].text.strip()
        country = links[-1].text.strip()

    # id manufacturer
    manufacturer_id = None
    p_tags = soup.select("#feature p")
    manufacturer_tag = None

    for p in p_tags:
        if "Make:" in p.text:
            links = p.find_all("a")
            if links:
                manufacturer_tag = links[0]
                break

    if manufacturer_tag and manufacturer_tag.has_attr("href"):
        manufacturer_id = extract_id_from_href(manufacturer_tag["href"])

    return {
        "location": {
            "city": city,
            "region": region,
            "country": country
        },
        "manufacturer_id": manufacturer_id
    }

def get_manufacturer_details(manufacturer_id):
    url = f"{BASE_URL}/{manufacturer_id}.htm"
    response = requests.get(url, headers=HEADERS)
    soup = BeautifulSoup(response.content, "html.parser")

    feature_div = soup.select_one("#feature > div")
    if not feature_div:
        return None

    name_tag = feature_div.find("h1")
    name = name_tag.text.strip() if name_tag else None

    links = feature_div.find_all("a")
    if len(links) < 3:
        return {
            "id": manufacturer_id,
            "name": name,
            "location": None
        }

    city = links[-3].text.strip()
    region = links[-2].text.strip()
    country = links[-1].text.strip()

    return {
        "id": manufacturer_id,
        "name": name,
        "location": {
            "city": city,
            "region": region,
            "country": country
        }
    }

coasters = []
parks_dict = {} 
manufacturers_dict = {} 

for page_num in range(1,10):
    print(f"Scraping page {page_num}")
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
        park_name = park_tag.text.strip() if park_tag else None

        coaster_detail = get_coaster_detail(coaster_id)
        manufacturer_id = coaster_detail["manufacturer_id"]

        if manufacturer_id and manufacturer_id not in manufacturers_dict:
            manufacturer_data = get_manufacturer_details(manufacturer_id)
            if manufacturer_data:
                manufacturers_dict[manufacturer_id] = manufacturer_data

        # buat struktur json nya
        coaster_data = {
            "id": coaster_id,
            "name": name_tag.text.strip() if name_tag else None,
            "park_id": park_id,
            "manufacturer_id": manufacturer_id,
            "type": type_tag.text.strip() if type_tag else None,
            "design": design_tag.text.strip() if design_tag else None,
            "status": status_tag.text.strip() if status_tag else None,
            "opened": opened_tag.get("datetime", "").strip() if opened_tag else None
        }
        coasters.append(coaster_data)
        print(f"Coaster {coaster_id} scraped.")

        if park_id and park_id not in parks_dict:
            parks_dict[park_id] = {
                "id": park_id,
                "name": park_name,
                "location": coaster_detail["location"] or None
            }

        time.sleep(0.5)

    time.sleep(1.5)

# simpan ke coasters.json
with open("data/roller_coasters.json", "w", encoding="utf-8") as f:
    json.dump(coasters, f, ensure_ascii=False, indent=2)

# simpan ke parks.json
parks = list(parks_dict.values())
with open("data/parks.json", "w", encoding="utf-8") as f:
    json.dump(parks, f, ensure_ascii=False, indent=2)

# simpan ke manufacturers.json
manufacturers = list(manufacturers_dict.values())
with open("data/manufacturers.json", "w", encoding="utf-8") as f:
    json.dump(manufacturers, f, ensure_ascii=False, indent=2)

print(f"Data berhasil disimpan ke roller_coasters.json ({len(coasters)} rc), "
      f"parks.json ({len(parks)} park), dan manufacturer.json ({len(manufacturers)} manufacturer)")