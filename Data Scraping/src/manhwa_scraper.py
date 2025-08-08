import requests 
from bs4 import BeautifulSoup 
import json
import time
import re

base_url = 'https://myanimelist.net/topmanga.php?type=manhwa'
headers = { 
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36; Basis Data/Admin Basis Data/basisdata@std.stei.itb.ac.id' 
} 

all_manga_links = []
manhwa_list = []

limits = [0, 50] 

print("Mengumpulkan tautan dari halaman manhwa teratas...")
for limit in limits:
    url = f'{base_url}&limit={limit}'
    try:
        r = requests.get(url, headers=headers, timeout=15)
        r.raise_for_status()
        soup = BeautifulSoup(r.text, 'html.parser')
        
        manga_rows = soup.find_all('tr', class_='ranking-list')
        
        for row in manga_rows:
            link_tag = row.find('a', class_='hoverinfo_trigger')
            if link_tag and link_tag.get('href'):
                full_link = link_tag['href']
                all_manga_links.append(full_link)
    except requests.exceptions.RequestException as e:
        print(f"Error saat mengumpulkan tautan dari {url}: {e}")
    
    time.sleep(2)

print(f"Berhasil mengumpulkan {len(all_manga_links)} tautan manhwa.")
print("--- Memulai scraping data detail untuk setiap manhwa ---")

def get_info_from_label_regex(soup, label_regex):
    """
    Fungsi ini mencari label di sidebar menggunakan regex dan mengekstrak kontennya.
    Mengatasi masalah antara label tunggal dan jamak.
    Jika data tidak ditemukan, kembalikan None.
    """
    label_tag = soup.find('span', class_='dark_text', string=re.compile(label_regex, re.IGNORECASE))
    if label_tag:
        parent_div = label_tag.parent
        links = parent_div.find_all('a')
        
        if links:
            return [link.get_text(strip=True) for link in links]
        
        text_content = parent_div.get_text(strip=True).replace(label_tag.get_text(strip=True), '').strip()
        
        if ',' in text_content:
            return [item.strip() for item in text_content.split(',')]

        if text_content.lower() in ['unknown', 'n/a', '']:
            return None
        return text_content
    return None

for link in all_manga_links:
    try:
        print(f"Scraping detail for: {link}")
        r = requests.get(link, headers=headers, timeout=15)
        r.raise_for_status()
        soup = BeautifulSoup(r.text, 'html.parser')
        
        title_tag = soup.find('span', itemprop='name')
        title = title_tag.get_text(strip=True) if title_tag else None
        
        score_tag = soup.find('span', itemprop='ratingValue')
        score = score_tag.get_text(strip=True) if score_tag else None
        
        authors = get_info_from_label_regex(soup, 'Authors?:')
        published = get_info_from_label_regex(soup, 'Published:')
        chapters = get_info_from_label_regex(soup, 'Chapters?:')
        status = get_info_from_label_regex(soup, 'Status:')
        serialization = get_info_from_label_regex(soup, 'Serialization:')
        
        genres = get_info_from_label_regex(soup, 'Genres?:')
        themes = get_info_from_label_regex(soup, 'Themes?:')
        
        manhwa_data = {
            'Title': title,
            'Authors': authors,
            'Published': published,
            'Chapters': chapters,
            'Status': status,
            'Serialization': serialization,
            'Genres': genres,
            'Themes': themes,
            'Score': score
        }
        
        manhwa_list.append(manhwa_data)
        print(f"Scraped successfully: {title}")
        
        time.sleep(2)
        
    except requests.exceptions.RequestException as e:
        print(f"Error saat mengikis {link}: {e}")
    except Exception as e:
        print(f"Terjadi kesalahan saat memproses {link}: {e}")

file_name = 'manhwa_data.json'
try:
    with open(file_name, 'w', encoding='utf-8') as f:
        json.dump(manhwa_list, f, indent=4, ensure_ascii=False)
    print(f"\nData berhasil diekspor ke file '{file_name}'")
except IOError as e:
    print(f"Error saat menulis ke file {file_name}: {e}")
except Exception as e:
    print(f"Terjadi kesalahan saat mengekspor data: {e}")