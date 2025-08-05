from playwright.sync_api import sync_playwright
import json
import time

url = "https://rcdb.com/r.htm?ot=2&op=2025"
base_url = "https://rcdb.com"

data_list = []

with sync_playwright() as p:
    browser = p.chromium.launch(headless=True)
    page = browser.new_page()
    page.goto(url)
    page.wait_for_selector("div.stdtbl.rer table")

    # Ambil semua baris <tr>
    rows = page.query_selector_all("div.stdtbl.rer table tr")[1:]  # skip header row

    for row in rows:
        cols = row.query_selector_all("td")
        if len(cols) < 7:
            continue

        name_tag = cols[1].query_selector("a")
        park_tag = cols[2].query_selector("a")
        type_tag = cols[3].query_selector("a")
        design_tag = cols[4].query_selector("a")
        status_tag = cols[5].query_selector("a")
        opened_tag = cols[6].query_selector("time")

        data_list.append({
            "name": name_tag.inner_text().strip() if name_tag else "-",
            "park": park_tag.inner_text().strip() if park_tag else "-",
            "type": type_tag.inner_text().strip() if type_tag else "-",
            "design": design_tag.inner_text().strip() if design_tag else "-",
            "status": status_tag.inner_text().strip() if status_tag else "-",
            "opened": opened_tag.inner_text().strip() if opened_tag else "-"
        })

    browser.close()

# Simpan ke file JSON
with open("data/coasters_2025_final.json", "w", encoding="utf-8") as f:
    json.dump(data_list, f, ensure_ascii=False, indent=2)

print("Sukses! Data disimpan ke coasters_2025_final.json")
