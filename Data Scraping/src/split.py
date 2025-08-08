#!/usr/bin/env python3

import json
from pathlib import Path

DATA_DIR = Path(__file__).resolve().parent.parent / "data"
SRC_FILE = DATA_DIR / "unicorns.json"
COUNTRY_FILE = DATA_DIR / "country.json"
CITY_FILE = DATA_DIR / "city.json"

def main():
    if not SRC_FILE.exists():
        raise SystemExit(f"Source file not found: {SRC_FILE}")
    payload = json.loads(SRC_FILE.read_text(encoding="utf-8"))
    records = payload.get("records", [])

    countries = set()
    for r in records:
        ctry = (r.get("country") or "").strip()
        if ctry:
            countries.add(ctry)
    countries_sorted = sorted(countries, key=lambda s: s.lower())
    country_id_map = {name: i+1 for i, name in enumerate(countries_sorted)}

    city_pairs = set()
    for r in records:
        ctry = (r.get("country") or "").strip()
        city = (r.get("city") or "").strip()
        if ctry and city:
            city_pairs.add((ctry, city))

    city_pairs_sorted = sorted(city_pairs, key=lambda x: (x[0].lower(), x[1].lower()))
    city_id_map = {}
    city_rows = []
    for i, (ctry, city) in enumerate(city_pairs_sorted, start=1):
        cid = i
        city_id_map[(ctry, city)] = cid
        city_rows.append({
            "city_id": cid,
            "city_name": city,
            "country_id": country_id_map[ctry],
        })

    country_rows = [{"country_id": cid, "country_name": name} for name, cid in country_id_map.items()]

    new_records = []
    for r in records:
        ctry = (r.get("country") or "").strip()
        city = (r.get("city") or "").strip()
        new_r = {
            "company": r.get("company"),
            "valuation": r.get("valuation"),
            "date_joined": r.get("date_joined"),
            "country_id": country_id_map.get(ctry),
            "city_id": city_id_map.get((ctry, city)) if ctry and city else None,
            "industry": r.get("industry"),
            "investors": r.get("selected_investors"),
        }
        new_records.append(new_r)

    COUNTRY_FILE.write_text(json.dumps(country_rows, ensure_ascii=False, indent=2), encoding="utf-8")
    CITY_FILE.write_text(json.dumps(city_rows, ensure_ascii=False, indent=2), encoding="utf-8")
    new_payload = {
        "source": payload.get("source"),
        "scraped_at": payload.get("scraped_at"),
        "count": payload.get("count"),
        "records": new_records,
    }
    SRC_FILE.write_text(json.dumps(new_payload, ensure_ascii=False, indent=2), encoding="utf-8")

    print(f"Wrote {len(country_rows)} countries -> {COUNTRY_FILE}")
    print(f"Wrote {len(city_rows)} cities -> {CITY_FILE}")
    print(f"Rewrote unicorns with IDs -> {SRC_FILE}")

if __name__ == "__main__":
    main()
