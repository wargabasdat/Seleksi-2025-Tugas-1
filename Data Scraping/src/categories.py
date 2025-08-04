import requests
from bs4 import BeautifulSoup
import json

base_url = "https://dumaofficial.com"
url = f"{base_url}/collections"

res = requests.get(url)
if res.status_code != 200:
    print("Failed to fetch page:", res.status_code)
    exit()

soup = BeautifulSoup(res.text, "html.parser")

collection_blocks = soup.select("div.CollectionItem__Wrapper")
print(f"Found {len(collection_blocks)} collections")

collections = []
for block in collection_blocks:
    name = block.select_one("h2.SectionHeader__Heading")
    name = name.get_text(strip=True) if name else None

    link_tag = block.select_one("a.CollectionItem__Link")
    relative_url = link_tag['href'] if link_tag else None
    url_full = base_url + relative_url if relative_url else None

    style = block.get("style", "")
    image_url = None
    if "url(" in style:
        image_url = style.split("url(")[-1].split(")")[0].strip("'\"")
        if image_url.startswith("//"):
            image_url = "https:" + image_url

    collections.append({
        "name": name,
        "url": url_full,
        "image": image_url
    })

with open("categories.json", "w", encoding="utf-8") as f:
    json.dump(collections, f, indent=2, ensure_ascii=False)

print(f"Scraped {len(collections)} categories.")
