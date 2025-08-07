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
all_serialization_links = set()
company_data_list = []

limits = [0, 50]

print("Mengumpulkan tautan ke halaman detail manhwa dari daftar teratas...")
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
        print(f"Error saat mengumpulkan tautan dari {url}: {e}")
    
    time.sleep(2)

print(f"Berhasil mengumpulkan {len(manga_detail_links)} tautan detail manhwa.")

print("Mengekstrak tautan serialisasi dari setiap halaman detail manhwa...")
for i, manga_url in enumerate(manga_detail_links):
    print(f"  [{i+1}/{len(manga_detail_links)}] Memproses halaman: {manga_url}")
    try:
        r = requests.get(manga_url, headers=headers, timeout=15)
        r.raise_for_status()
        soup = BeautifulSoup(r.text, 'html.parser')
        
        serialization_label = soup.find('span', class_='dark_text', string='Serialization:')
        
        if serialization_label:
            serialization_link_tag = serialization_label.find_next_sibling('a', href=True)
            if serialization_link_tag and serialization_link_tag.get('href'):
                full_link = f"{base_url}{serialization_link_tag['href']}"
                all_serialization_links.add(full_link)
    except requests.exceptions.RequestException as e:
        print(f"  Error memproses halaman {manga_url}: {e}")
    except Exception as e:
        print(f"  Terjadi kesalahan tak terduga: {e}")
    
    time.sleep(2)

print(f"Berhasil mengumpulkan {len(all_serialization_links)} tautan serialisasi unik.")

def get_company_info_from_page(soup):
    company_name_tag = soup.find('h1', class_='h1')
    company_name = company_name_tag.get_text(strip=True) if company_name_tag else None

    total_works = None
    company_header_span = soup.find('span', class_='di-ib mt4') 
    if company_header_span:
        total_works_span = company_header_span.find('span', class_='fw-n')
        if total_works_span:
            total_works_str = total_works_span.get_text(strip=True).replace('(', '').replace(')', '').replace(',', '')
            if total_works_str.isdigit():
                total_works = int(total_works_str)
    
    return company_name, total_works

print("--- Memulai scraping data detail untuk setiap perusahaan serialisasi ---")
for serialization_link in sorted(list(all_serialization_links)):
    try:
        print(f"Scraping detail for company: {serialization_link}")
        r = requests.get(serialization_link, headers=headers, timeout=15)
        r.raise_for_status()
        soup = BeautifulSoup(r.text, 'html.parser')

        company_name, total_works = get_company_info_from_page(soup)

        company_data = {
            'Company Name': company_name,
            'Total Works': total_works
        }
        
        company_data_list.append(company_data)
        print(f"Scraped successfully: {company_name} (Total Works: {total_works})")
        
        time.sleep(2)
        
    except requests.exceptions.RequestException as e:
        print(f"Error saat mengikis {serialization_link}: {e}")
    except Exception as e:
        print(f"Terjadi kesalahan saat memproses {serialization_link}: {e}")

file_name = 'companies_data.json'
try:
    with open(file_name, 'w', encoding='utf-8') as f:
        json.dump(company_data_list, f, indent=4, ensure_ascii=False)
    print(f"\nData perusahaan berhasil diekspor ke file '{file_name}'")
except IOError as e:
    print(f"Error saat menulis ke file {file_name}: {e}")
except Exception as e:
    print(f"Terjadi kesalahan saat mengekspor data: {e}")
