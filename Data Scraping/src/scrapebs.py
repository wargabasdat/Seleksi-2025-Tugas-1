import requests
from bs4 import BeautifulSoup
import json

url = "https://rcdb.com/r.htm?ot=2&op=2025"
headers = {
    "User-Agent": "Mozilla/5.0"
}

response = requests.get(url, headers=headers)
soup = BeautifulSoup(response.content, "html.parser")

# Temukan semua baris data (tr) di dalam tabel
rows = soup.select("div.stdtbl.rer table tr")[1:]  # skip header

data_list = []

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
    opened = opened_tag.get("datetime", "").strip() if opened_tag else "-"


    data = {
        "name": name_tag.text.strip() if name_tag else "-",
        "park": park_tag.text.strip() if park_tag else "-",
        "type": type_tag.text.strip() if type_tag else "-",
        "design": design_tag.text.strip() if design_tag else "-",
        "status": status_tag.text.strip() if status_tag else "-",
        "opened": opened_tag.get("datetime", "").strip() if opened_tag else "-"
    }

    data_list.append(data)

# Simpan ke file JSON
with open("data/coasters_2025_bs4.json", "w", encoding="utf-8") as f:
    json.dump(data_list, f, ensure_ascii=False, indent=2)

print("Data berhasil disimpan ke coasters_2025_bs4.json")
