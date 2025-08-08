# Import module
import requests
from bs4 import BeautifulSoup
import re
import json
import os

# URL yang akan digunakan
URL = "https://www.haibunda.com/moms-life/20231230164315-76-325037/daftar-100-perempuan-tercantik-di-dunia-2023-ada-lyodra-hingga-jisoo-blackpink"

# Header
headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) '
                  'DataScrapingProject/1.0 (contact: email@example.com)'
}

# Function untuk mendapatkan data
def scrape_faces():
    resp = requests.get(URL, headers=headers)
    soup = BeautifulSoup(resp.text, 'html.parser')

    paragraphs = soup.find_all('p')
    data = []

    for p in paragraphs:
        text = p.get_text(separator="\n", strip=True)
        matches = re.findall(r'(\d+)\.\s*([^\n]+)', text)

        for rank, name in matches:
            parts = [x.strip() for x in name.split(',', 1)]  # split data
            person_name = parts[0]
            description = parts[1].rstrip('.') if len(parts) > 1 else ""

            # Memisahkan job & country             
            words = description.split()
            country_words = []
            for w in reversed(words):
                # Mengambil kata kapital di akhir (bisa lebih dari 1 kata) untuk country
                if w and w[0].isupper() and not w.isupper():
                    country_words.insert(0, w)
                else:
                    break

            country = " ".join(country_words).strip()
            job = " ".join(words[:len(words)-len(country_words)]).strip()

            # Kalau job kosong tapi description ada akan diisi job
            if not job and description:
                job = description

            # Kalau country kosong akan diisi default
            if not country:
                country = "asal tidak tersedia"

            data.append({
                "rank": int(rank),
                "name": person_name,
                "job": job,
                "country": country
            })

    return data

# Function untuk preprocessing data
def preprocess_data(data):
    # Memulai rank dari rank 1
    start_index = next((i for i, item in enumerate(data) if item["rank"] == 1), None)
    if start_index is not None:
        data = data[start_index:]

    # Preprocessing khusus job & country
    for item in data:
        name = item.get("name", "")
        job = item.get("job", "")
        country = item.get("country", "")

        # Cleaning data salah 

        # Jika job "idola" dan country "K-Pop"
        if country.lower() == "k-pop" and job.lower() == "idola":
            item["job"] = "idola K-Pop"
            item["country"] = "Korea"
        elif "idola k-pop" in job.lower():
            item["country"] = "Korea"
        elif country.lower() == "k-pop":
            item["country"] = "Korea"
        
        # Data Kang Seulgi
        if "kang seulgi" in name.lower() and country.lower() == "asal tidak tersedia":
            item["job"] = "idola K-Pop"
            item["country"] = "Korea"

        # Data Klelia Andriolatou    
        if "klelia andriolatou" in name.lower() and country.lower() == "asal tidak tersedia":
            item["country"] = "Greek"

    return data

if __name__ == "__main__":
    # Source ke folder data 
    output_dir = os.path.join(os.path.dirname(__file__), "../data")
    os.makedirs(output_dir, exist_ok=True)

    # Ambil data
    faces = scrape_faces()
    faces = preprocess_data(faces)

    # Menyimpan ke JSON
    output_path = os.path.join(output_dir, "beautiful_faces_2023.json")
    with open(output_path, "w", encoding="utf-8") as f:
        json.dump(faces, f, ensure_ascii=False, indent=4)

    print(f"Data berhasil disimpan di {output_path}")
