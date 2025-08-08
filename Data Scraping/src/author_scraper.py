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
all_author_links = set()
author_data_list = []

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

print("Mengekstrak tautan penulis dari setiap halaman detail manhwa...")
for i, manga_url in enumerate(manga_detail_links):
    print(f"  [{i+1}/{len(manga_detail_links)}] Memproses halaman: {manga_url}")
    try:
        r = requests.get(manga_url, headers=headers, timeout=15)
        r.raise_for_status()
        soup = BeautifulSoup(r.text, 'html.parser')

        author_label = soup.find('span', class_='dark_text', string=re.compile(r'Authors?:'))

        if author_label:
            parent_div = author_label.find_parent('div', class_='spaceit_pad')
            if parent_div:
                author_links = parent_div.find_all('a')
                for link_tag in author_links:
                    full_link = f"{base_url}{link_tag['href']}"
                    all_author_links.add(full_link)
    except requests.exceptions.RequestException as e:
        print(f"  Error memproses halaman {manga_url}: {e}")
    except Exception as e:
        print(f"  Terjadi kesalahan tak terduga: {e}")
    time.sleep(2)

print(f"Berhasil mengumpulkan {len(all_author_links)} tautan penulis unik.")

def get_info_from_label(soup, label_text):
    label_tag = soup.find('span', class_='dark_text', string=lambda text: text and text.strip().startswith(label_text))
    if label_tag:
        parent_node = label_tag.parent
        text_content = parent_node.get_text(strip=True).replace(label_text, '').strip()

        if label_text == 'Website:':
            website_div = soup.find('span', class_='dark_text', string='Website:')
            if website_div:
                link_tag = website_div.find_next('a')
                if link_tag and link_tag.get('href') and not link_tag['href'].startswith(('/people/', '/dbchanges/')):
                    return link_tag['href']
            return None

        if label_text == 'Given name:':
            return text_content

        if label_text == 'Family name:':
            family_name_span = soup.find('span', class_='dark_text', string='Family name:')
            if family_name_span and family_name_span.next_sibling:
                family_name_text = family_name_span.next_sibling.strip()
                return family_name_text if family_name_text.lower() not in ['unknown', 'n/a', ''] else None
            return None

        if text_content in ['N/A', '', 'Unknown']:
            return None

        return text_content
    return None

def get_published_manga(soup):
    titles = []
    manga_rows = soup.select("tr.js-people-manga")
    for row in manga_rows:
        title_tag = row.select_one("a.js-people-title")
        if title_tag:
            title = title_tag.get_text(strip=True)
            titles.append(title)
    return titles if titles else None

for author_link in sorted(list(all_author_links)):
    try:
        print(f"Scraping detail for author: {author_link}")
        r = requests.get(author_link, headers=headers, timeout=15)
        r.raise_for_status()
        soup = BeautifulSoup(r.text, 'html.parser')

        name_tag = soup.find('h1', class_='title-name')
        full_name = name_tag.get_text(strip=True) if name_tag else None

        given_name = get_info_from_label(soup, 'Given name:')
        family_name = get_info_from_label(soup, 'Family name:')
        birthday = get_info_from_label(soup, 'Birthday:')

        website = get_info_from_label(soup, 'Website:')
        if website in ['http://', 'https://']:
            website = None

        favorites = get_info_from_label(soup, 'Member Favorites:')
        published_manga = get_published_manga(soup)

        author_data = {
            'Author Name': full_name,
            'Given Name': given_name,
            'Family Name': family_name,
            'Birthday': birthday,
            'Website': website,
            'Member Favorites': favorites,
            'Published Manga': published_manga
        }

        author_data_list.append(author_data)
        print(f"Scraped successfully: {full_name}")
        time.sleep(2)

    except requests.exceptions.RequestException as e:
        print(f"Error saat mengikis {author_link}: {e}")
    except Exception as e:
        print(f"Terjadi kesalahan saat memproses {author_link}: {e}")

file_name = 'authors_data.json'
try:
    with open(file_name, 'w', encoding='utf-8') as f:
        json.dump(author_data_list, f, indent=4, ensure_ascii=False)
    print(f"\nData penulis berhasil diekspor ke file '{file_name}'")
except IOError as e:
    print(f"Error saat menulis ke file {file_name}: {e}")
except Exception as e:
    print(f"Terjadi kesalahan saat mengekspor data: {e}")
