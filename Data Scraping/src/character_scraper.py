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
all_character_info_from_manga_pages = []
unique_character_profile_urls = set()
unique_character_details_map = {}

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

print("Mengekstrak tautan karakter dan peran dari setiap halaman detail manhwa...")
for i, manga_url in enumerate(manga_detail_links):
    character_page_url = f"{manga_url}/characters"
    print(f"  [{i+1}/{len(manga_detail_links)}] Memproses halaman karakter: {character_page_url}")
    try:
        r = requests.get(character_page_url, headers=headers, timeout=15)
        r.raise_for_status()
        soup = BeautifulSoup(r.text, 'html.parser')
        character_tables = soup.find_all('table', class_='js-manga-character-table')

        for table in character_tables:
            character_link_tag = table.find('a', class_='fw-n')
            if character_link_tag and character_link_tag.get('href'):
                profile_url = character_link_tag['href']
                if not profile_url.startswith("http"):
                    profile_url = f"{base_url}{profile_url}"

                role_tag = table.find('small')
                role = role_tag.text.strip() if role_tag else None

                all_character_info_from_manga_pages.append({
                    'profile_url': profile_url,
                    'role': role
                })
                unique_character_profile_urls.add(profile_url)
    except Exception as e:
        print(f"  Error memproses halaman {character_page_url}: {e}")
    time.sleep(2)

print(f"Berhasil mengumpulkan {len(unique_character_profile_urls)} tautan profil karakter unik.")

def get_character_details_from_profile_page(soup):
    breadcrumb = soup.select("div.breadcrumb > div.di-ib")
    character_name = breadcrumb[-1].text.strip() if breadcrumb else None

    mangaography = []
    section = soup.find('div', string='Mangaography')
    if section:
        table = section.find_next('table')
        if table:
            for a in table.find_all('a'):
                title = a.text.strip()
                if title.lower() != 'add' and title != '':
                    mangaography.append(title)

    favorites = None
    fav_text = soup.find(string=re.compile("Member Favorites"))
    if fav_text:
        match = re.search(r'Member Favorites:\s*([\d,]+)', fav_text)
        if match:
            favorites = int(match.group(1).replace(",", ""))

    description = ""
    content_div = soup.find("div", id="content")
    h2 = content_div.find("h2", class_="normal_header") if content_div else None
    if h2:
        desc_parts = []
        for sib in h2.next_siblings:
            if sib.name == "div" and "normal_header" in sib.get("class", []):
                break
            if isinstance(sib, str):
                desc_parts.append(sib.strip())
            elif sib.name == "br":
                desc_parts.append("\n")
            elif sib.name:
                desc_parts.append(sib.get_text(strip=True))
        description = "\n".join(desc_parts).strip()

    return character_name, mangaography or None, favorites, description or None

print("--- Memulai scraping data detail dari profil karakter unik ---")
for profile_url in sorted(unique_character_profile_urls):
    try:
        print(f"Scraping details for: {profile_url}")
        r = requests.get(profile_url, headers=headers, timeout=15)
        r.raise_for_status()
        soup = BeautifulSoup(r.text, 'html.parser')
        name, mangaography, favorites, description = get_character_details_from_profile_page(soup)

        unique_character_details_map[profile_url] = {
            'Character Name': name,
            'Mangaography': mangaography,
            'Member Favorites': favorites,
            'Description': description
        }
        time.sleep(2)
    except Exception as e:
        print(f"Gagal scraping {profile_url}: {e}")

print("\n--- Menggabungkan data karakter dan mengekspor ke JSON ---")
final_character_data_list = []
for char_entry in all_character_info_from_manga_pages:
    profile_url = char_entry['profile_url']
    detail = unique_character_details_map.get(profile_url, {})

    combined = {
        'Character Name': detail.get('Character Name'),
        'Role': char_entry['role'],
        'Mangaography': detail.get('Mangaography'),
        'Member Favorites': detail.get('Member Favorites'),
        'Description': detail.get('Description')
    }
    final_character_data_list.append(combined)

file_name = 'characters_data.json'
try:
    with open(file_name, 'w', encoding='utf-8') as f:
        json.dump(final_character_data_list, f, indent=4, ensure_ascii=False)
    print(f"\nData karakter berhasil disimpan ke file: {file_name}")
except Exception as e:
    print(f"Gagal menyimpan file JSON: {e}")
