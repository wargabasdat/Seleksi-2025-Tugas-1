import requests
from bs4 import BeautifulSoup
import json
import re
import os
import time
from requests.sessions import Session

def scrape_awards_table(html_content):
    soup = BeautifulSoup(html_content, 'html.parser')
    table = soup.find('table')
    if not table:
        print("Peringatan: Tabel penghargaan tidak ditemukan di halaman ini. Melewatkan.")
        return []
        
    all_rows = table.find_all('tr')
    header_row = None
    for row in all_rows:
        if row.find('th'):
            header_row = row
            break
              
    music_shows = []
    header_cells = header_row.find_all('th')[1:]
    
    for th in header_cells:
        small_tag = th.find('small')
        if small_tag:
            show_name = small_tag.get_text(strip=True)
            music_shows.append(show_name)
    data_rows = []
    for row in all_rows:
        if row.find('td'):
            data_rows.append(row)

    all_awards_list = []
    for row in data_rows:
        cells = row.find_all('td')
        if not cells or len(cells) <= 1:
            continue
        week_cell = cells[0]
        week_text = week_cell.get_text(strip=True)
        if len(week_text) >= 5:
            year = int(week_text[:4])
            week = int(week_text[4:])
        else:
            continue
        for i, cell in enumerate(cells[1:]):
            cell_text = cell.get_text(strip=True)
            if not cell_text or cell_text == '-':
                continue
            if i >= len(music_shows):
                continue
            a_tags = cell.find_all('a')
            if len(a_tags) >= 2:
                group_a_tag = a_tags[0]
                group = group_a_tag.get_text(strip=True)
                link = group_a_tag.get('href')
                song = a_tags[1].get_text(strip=True)
                award_data = {
                    "show": music_shows[i],
                    "week": week,
                    "year": year,
                    "group": group,
                    "link": link,
                    "song": song
                }
                all_awards_list.append(award_data)
    return all_awards_list

def main():
    all_awards = []
    years_to_scrape = range(2025, 2014, -1)
    base_url = 'https://soridata.com/awards.html?year='
    
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
    
    try:
        main_page = session.get('https://soridata.com/', timeout=15)
        time.sleep(2)
    except Exception as e:
        print(f"Gagal mengakses halaman utama")

    for year in years_to_scrape:
        url = f'{base_url}{year}'
        print(f"\nMengambil data dari: {url}")
        try:
            time.sleep(3)
            response = session.get(url, timeout=20)
            response.raise_for_status()
            awards_from_page = scrape_awards_table(response.text)
            all_awards.extend(awards_from_page)
        except requests.exceptions.Timeout:
            print(f"Timeout")
        except requests.exceptions.RequestException as e:
            print(f"Gagal mengambil data")
    
    output_folder = os.path.join("Data Scraping", "data")
    os.makedirs(output_folder, exist_ok=True)
    output_path = os.path.join(output_folder, "awards.json")
    with open(output_path, 'w', encoding='utf-8') as f:
        json.dump(all_awards, f, ensure_ascii=False, indent=4)
    print(f"\nProses scraping selesai! Total {len(all_awards)} data disimpan di {output_path}")

if __name__ == "__main__":
    main()
