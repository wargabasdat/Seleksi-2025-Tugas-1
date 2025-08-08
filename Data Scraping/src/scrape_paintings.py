import requests
import re
import json

# Header untuk request HTTP
HEADERS = {
    "User-Agent": 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'
}

# Daftar URL halaman painting
URLS = [
    "https://www.topofart.com/top-100-art-reproductions.php/1",
    "https://www.topofart.com/top-100-art-reproductions.php/2",
    "https://www.topofart.com/top-100-art-reproductions.php/3",
    "https://www.topofart.com/top-100-art-reproductions.php/4",
    "https://www.topofart.com/top-100-art-reproductions.php/5",
]

# Scrape satu halaman painting
def scrape_page(url: str) -> list[dict]:
    r = requests.get(url, headers=HEADERS, timeout=20)
    r.raise_for_status()
    html = r.text

    # Ubah HTML ke text, hapus tag
    text = re.sub(r"<[^>]+>", "\n", html)
    lines = [ln.strip() for ln in text.split("\n") if ln.strip()]

    paintings = []
    museums = {}
    cities = {}
    countries = {}

    sku_positions = [] # Simpan posisi baris SKU
    for i in range(len(lines)):
        if lines[i].startswith('SKU:'):
            sku_positions.append(i)
    
    # Loop setiap painting berdasarkan SKU
    for sku_pos in sku_positions:
        try:
            sku_line = lines[sku_pos]
            sku = sku_line.replace('SKU:', '').strip()
            
            title = ""
            year = ""
            artist = ""
            oil_price = ""
            canvas_price = ""
            original_size = ""
            museum = ""
            city = ""
            country = ""
            
            # Ambil harga dan info painting
            if sku_pos >= 2 and lines[sku_pos-1].startswith('€'):
                canvas_price = lines[sku_pos-1].replace('€', '').strip()
                
                if sku_pos >= 3 and lines[sku_pos-2] == "Canvas Print":
                    
                    if sku_pos >= 4 and lines[sku_pos-3].startswith('€'):
                        oil_price = lines[sku_pos-3].replace('€', '').strip()
                        
                        if sku_pos >= 5 and lines[sku_pos-4] == "Oil Painting":
                            oil_painting_pos = sku_pos - 4
                            # Cari tahun, judul, dan artist
                            for j in range(oil_painting_pos - 1, max(0, oil_painting_pos - 10), -1):
                                line = lines[j]
                                if re.match(r'^(1[4-9]\d{2}|20[0-2]\d|c\.\d{4}(?:/\d{2,4})?)$', line):
                                    year = line
                                    if j > 0:
                                        title = lines[j-1]
                                    artist_parts = []
                                    for k in range(j + 1, oil_painting_pos):
                                        part = lines[k]
                                        if (part != "Oil Painting" and not part.startswith('€')):
                                            artist_parts.append(part)
                                    artist = ' '.join(artist_parts).strip()
                                    break
            
            # Ambil ukuran, museum, kota, negara
            j = sku_pos + 2
            title_size_line = lines[j]
            size_line = lines[j+1]

            if "Original Size:" in title_size_line:
                original_size = size_line.replace("Original Size:", "").strip()

            museum_line = lines[j+2].strip()
            parts = museum_line.rsplit(' ', 2)

            if len(parts) == 3:
                museum, city, country = parts
            else:
                museum = museum_line.strip()
                city, country = "", ""
            
            # Simpan painting jika data lengkap
            if title and sku and year and artist and oil_price and canvas_price:
                painting = {
                    'title': title,
                    'year': year,
                    'artist': artist,
                    'oil_price_euro': oil_price,
                    'canvas_price_euro': canvas_price,
                    'sku': sku,
                    'original_size': original_size,
                    'museum': museum,
                }

                # Hindari duplikat SKU
                if not any(p['sku'] == sku for p in paintings):
                    paintings.append(painting)
                
                # Simpan data negara
                if country not in countries:
                    countries[country] = {"name": country}

                # Simpan data kota
                key_city = (city, country)
                if key_city not in cities:
                    cities[key_city] = {"name": city, "country": country}

                # Simpan data museum
                if museum not in museums:
                    museums[museum] = {"name": museum, "city_name": city}
                
        except IndexError:
            continue
    
    print(f"Total paintings: {len(paintings)}")
    print("=" * 50)
    print("paintings: " + str(paintings) )
    
    return paintings, museums, cities, countries

# Scrape semua halaman painting
def scrape_all() -> list[dict]:
    all_p, all_m, all_cy, all_cn = [], {}, {}, {}
    for url in URLS:
        p, m, cy, cn = scrape_page(url)
        all_p.extend(p)
        all_m.update(m)
        all_cy.update(cy)
        all_cn.update(cn)

    return list(all_p), list(all_m.values()), list(all_cy.values()), list(all_cn.values())

# Simpan hasil ke file JSON
def save_json(paintings: list[dict], museums: list[dict], cities: list[dict], countries: list[dict]):
    painting_filename = "Data Scraping/data/top_paintings.json"
    museum_filename = "Data Scraping/data/museums.json"
    city_filename = "Data Scraping/data/cities.json"
    country_filename = "Data Scraping/data/countries.json"
    with open(painting_filename, "w", encoding="utf-8") as f:
        json.dump(paintings, f, indent=2, ensure_ascii=False)
    print(f"Saved to {painting_filename}")
    with open(museum_filename, "w", encoding="utf-8") as f:
        json.dump(museums, f, indent=2, ensure_ascii=False)
    print(f"Saved to {museum_filename}")
    with open(city_filename, "w", encoding="utf-8") as f:
        json.dump(cities, f, indent=2, ensure_ascii=False)
    print(f"Saved to {city_filename}")
    with open(country_filename, "w", encoding="utf-8") as f:
        json.dump(countries, f, indent=2, ensure_ascii=False)
    print(f"Saved to {country_filename}")

# Main program
if __name__ == "__main__":
    paintings, museums, cities, countries = scrape_all()
    save_json(paintings, museums, cities, countries)
