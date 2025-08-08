import requests
from bs4 import BeautifulSoup
import json
import time
import re

base_url = 'https://myanimelist.net'
top_manga_url = f'{base_url}/topmanga.php?type=manhwa'
headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36; Basis Data/Admin Basis Data/basisdata@std.stei.itb.ac.id'
}

manga_detail_links = []
all_genre_links = set()
genre_data_list = []

limits = [0, 50]

print("Mengumpulkan tautan ke halaman detail manhwa...")
for limit in limits:
    url = f'{top_manga_url}&limit={limit}'
    try:
        r = requests.get(url, headers=headers, timeout=15)
        r.raise_for_status()
        soup = BeautifulSoup(r.text, 'html.parser')

        manga_rows = soup.find_all('tr', class_='ranking-list')
        for row in manga_rows:
            link_tag = row.find('a', class_='hoverinfo_trigger')
            if link_tag and link_tag.get('href'):
                manga_detail_links.append(link_tag['href'])
    except requests.exceptions.RequestException as e:
        print(f"  Error saat ambil link dari {url}: {e}")
    
    time.sleep(2)

print(f"Berhasil mengumpulkan {len(manga_detail_links)} tautan.")

print("Mengekstrak genre dari halaman detail manhwa...")
for i, manga_url in enumerate(manga_detail_links):
    print(f"  [{i+1}/{len(manga_detail_links)}] {manga_url}")
    try:
        r = requests.get(manga_url, headers=headers, timeout=15)
        r.raise_for_status()
        soup = BeautifulSoup(r.text, 'html.parser')
        
        genre_info_divs = soup.find_all('div', class_='spaceit_pad')
        for div in genre_info_divs:
            if 'Genre' in div.text:
                genre_links = div.find_all('a', href=True)
                for link_tag in genre_links:
                    full_link = f"{base_url}{link_tag['href']}"
                    all_genre_links.add(full_link)
                break
    except Exception as e:
        print(f"  Error memproses {manga_url}: {e}")
    
    time.sleep(2)

print(f"Berhasil mengumpulkan {len(all_genre_links)} genre unik.")

def parse_genre_page(html_content):
    soup = BeautifulSoup(html_content, 'html.parser')
    
    genre_name = None
    total_works = None
    description = None

    h1_tag = soup.find('h1', class_='h1')
    if h1_tag:
        genre_name = h1_tag.text.replace("Manga", "").strip()

    span_tag = soup.find('span', class_='di-ib mt4')
    if span_tag:
        total_works_span = span_tag.find('span', class_='fw-n')
        if total_works_span:
            raw = total_works_span.text.strip().replace(',', '').replace('(', '').replace(')', '')
            if raw.isdigit():
                total_works = int(raw)

    desc_tag = soup.find('p', class_='genre-description')
    if desc_tag:
        description = desc_tag.text.strip()

    return {
        'Genre Name': genre_name,
        'Total Works': total_works,
        'Description': description
    }

print("\n--- Scraping informasi genre ---")
for link in sorted(list(all_genre_links)):
    try:
        print(f"Scraping: {link}")
        r = requests.get(link, headers=headers, timeout=15)
        r.raise_for_status()
        genre_info = parse_genre_page(r.text)
        genre_data_list.append(genre_info)
        print(f"Scraped successfully:{genre_info['Genre Name']} ({genre_info['Total Works']})")
        time.sleep(2)
    except Exception as e:
        print(f"Gagal: {e}")

file_name = 'genres_data.json'
try:
    with open(file_name, 'w', encoding='utf-8') as f:
        json.dump(genre_data_list, f, indent=4, ensure_ascii=False)
    print(f"\nData berhasil disimpan ke '{file_name}'")
except Exception as e:
    print(f"Gagal menyimpan file: {e}")