import requests
from bs4 import BeautifulSoup
import json
import re
import os
import time
from requests.sessions import Session

def clean_and_convert_number(text):
    if not text:
        return 0
    cleaned_text = re.sub(r'[^\d+]', '', text)
    if cleaned_text.endswith('+'):
        cleaned_text = cleaned_text[:-1]
    
    if not cleaned_text:
        return 0
        
    return int(cleaned_text)

def scrape_artist_info(html_content):
    soup = BeautifulSoup(html_content, 'html.parser')
    artist_data = {}
    
    name_tag = soup.find('td', string=re.compile(r'International Stage Name'))
    if name_tag:
        name_cell = name_tag.find_next_sibling('td').find_next_sibling('td')
        if name_cell:
            artist_data['artist_name'] = name_cell.get_text(strip=True)
    else:
        return None

    debut_tag = soup.find('td', string=re.compile(r'Debut Day'))
    if debut_tag:
        debut_cell = debut_tag.find_next_sibling('td').find_next_sibling('td')
        if debut_cell:
            debut_text = debut_cell.get_text(strip=True)
            match = re.search(r'\d{4}-\d{2}-\d{2}', debut_text)
            if match:
                artist_data['debut_day'] = match.group(0)
    else:
        artist_data['debut_day'] = None
    
    sales_tag = soup.find('td', string=re.compile(r'Physical Sales'))
    if sales_tag:
        sales_cell = sales_tag.find_next_sibling('td').find_next_sibling('td')
        if sales_cell:
            sales_text = sales_cell.get_text(strip=True)
            artist_data['physical_sales'] = clean_and_convert_number(sales_text)
    else:
        artist_data['physical_sales'] = 0
            
    views_tag = soup.find('td', string=re.compile(r'Total Youtube Views'))
    if views_tag:
        views_cell = views_tag.find_next_sibling('td').find_next_sibling('td')
        if views_cell:
            views_text = views_cell.get_text(strip=True)
            artist_data['total_youtube_views'] = clean_and_convert_number(views_text)
    else:
        artist_data['total_youtube_views'] = 0
            
    return artist_data

def main():
    session = Session()
    headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
        'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8',
        'Accept-Language': 'en-US,en;q=0.9,id;q=0.8',
        'Accept-Encoding': 'gzip, deflate, br',
        'Connection': 'keep-alive',
        'Upgrade-Insecure-Requests': '1',
        'Sec-Fetch-Dest': 'document',
        'Sec-Fetch-Mode': 'navigate',
        'Sec-Fetch-Site': 'none',
        'Cache-Control': 'max-age=0',
    }
    session.headers.update(headers)
    
    awards_data = []
    try:
        # Path file diperbarui di sini
        awards_file_path = os.path.join(os.path.dirname(os.path.dirname(__file__)), 'data', 'awards.json')
        with open(awards_file_path, 'r', encoding='utf-8') as f:
            awards_data = json.load(f)
    except FileNotFoundError:
        print("File awards.json tidak ditemukan. Pastikan file berada di direktori 'data'.")
        return
        
    unique_links = set(item['link'] for item in awards_data if 'link' in item and item['link'])
    
    all_artists_data = []
    base_url = 'https://soridata.com'
    
    for link in unique_links:
        # Memotong '/awards/' dan menggantinya dengan '/artists/'
        cleaned_link = link.replace('/awards/', '/artists/')
        full_url = f"{base_url}{cleaned_link}"
        
        print(f"\nScraping data dari: {full_url}")
        
        try:
            time.sleep(5)
            response = session.get(full_url, timeout=25)
            response.raise_for_status()
            artist_info = scrape_artist_info(response.text)
            
            if artist_info:
                all_artists_data.append(artist_info)
                print(f"Data untuk {artist_info.get('artist_name', 'Nama tidak ditemukan')} berhasil diambil.")
            else:
                print(f"Gagal mengambil data dari {full_url} karena struktur halaman tidak sesuai.")
        
        except requests.exceptions.Timeout:
            print(f"Timeout saat mengambil data dari {full_url}")
        except requests.exceptions.RequestException as e:
            print(f"Gagal mengambil data dari {full_url}. Error: {e}")
            
    output_folder = "data"
    os.makedirs(output_folder, exist_ok=True)
    output_path = os.path.join(output_folder, "artists.json")
    with open(output_path, 'w', encoding='utf-8') as f:
        json.dump(all_artists_data, f, ensure_ascii=False, indent=4)
    print(f"\nProses scraping selesai! Total {len(all_artists_data)} data artis disimpan di {output_path}")

if __name__ == "__main__":
    main()
