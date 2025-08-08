import requests
import re
import json
import time
from urllib.parse import urljoin
from bs4 import BeautifulSoup

# Header untuk request HTTP
HEADERS = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'
}

BASE_URL = "https://www.topofart.com/"
URL = "https://www.topofart.com/artists-a-z.php"

# Ambil konten HTML dari URL
def get_page_content(url):
    try:
        response = requests.get(url, headers=HEADERS)
        response.raise_for_status()
        return response.text
    except Exception as e:
        print(f"Error fetching {url}: {e}")
        return None

# Ambil daftar artist dari halaman utama
def extract_artists_list():
    content = get_page_content(URL)
    if not content:
        return []
    soup = BeautifulSoup(content, 'html.parser')
    artists = []
    artist_links = soup.find_all('a', href=re.compile(r'/artists/[^/]+/$'))
    for link in artist_links:
        artist_name = link.get_text(strip=True)
        artist_url = urljoin(BASE_URL, link['href'])
        artists.append({
            'name': artist_name,
            'url': artist_url
        })
    print(f"Found {len(artists)} artists")
    for artist in artists:
        print(f" - {artist['name']}")
    return artists

# Ekstrak biografi artist dari halaman
def extract_biography(content):
    soup = BeautifulSoup(content, 'html.parser')
    all_text = soup.get_text()
    lines = [line.strip() for line in all_text.split('\n') if line.strip()]
    biography_lines = []
    start_capturing = False
    for line in lines:
        if re.match(r'^\d{4}-\d{4}$', line) or line.endswith('Painter'):
            continue
        if not start_capturing and any(keyword in line.lower() for keyword in 
            ['was born', 'born in', 'was a', 'lived', 'studied', 'painted', 'became', 'moved to']):
            start_capturing = True
        if start_capturing and ('Paintings' in line and line.endswith('Paintings')):
            break
        if start_capturing and (line.startswith('SKU:') or line.startswith('$') or 'Oil Painting' in line):
            break
        if start_capturing and len(line) > 20:  
            biography_lines.append(line)
    biography = ' '.join(biography_lines).strip()
    biography = re.sub(r'\s+', ' ', biography)
    biography = re.sub(r'\[[^\]]*\]', '', biography)  
    return biography if biography else ""  

# Ambil info jumlah halaman painting
def extract_page_info(text_content):
    page_match = re.search(r'(\d+)\s+of\s+(\d+)', text_content)
    if page_match:
        current_page = int(page_match.group(1))
        total_pages = int(page_match.group(2))
        return {'current_page': current_page, 'total_pages': total_pages}
    return {'current_page': 1, 'total_pages': 1}

# Ekstrak data painting dari text halaman
def extract_paintings_from_text(content: str):
    soup = BeautifulSoup(content, 'html.parser')
    text = soup.get_text()
    lines = [ln.strip() for ln in text.splitlines() if ln.strip()]
    paintings = []
    for i in range(len(lines)):
        if lines[i].startswith('SKU:'):
            try:
                sku = lines[i].replace('SKU:', '').strip()
                title_year_line = lines[i-2] if i-2 >= 0 else ""
                title_match = re.match(r'^(.*)\s(\d{4}|c\.\d{4})$', title_year_line)
                if title_match:
                    title = title_match.group(1).strip()
                    year = title_match.group(2)
                else:
                    title = title_year_line
                    year = ""
                price_line = lines[i-1] if i-1 >= 0 else ""
                oil_price, canvas_price = "", ""
                oil_match = re.search(r'Oil Painting€([\d.,]+)', price_line)
                canvas_match = re.search(r'Canvas Print€([\d.,]+)', price_line)

                if oil_match:
                    oil_price = oil_match.group(1)
                if canvas_match:
                    canvas_price = canvas_match.group(1)

                artist = lines[i+1] if i+1 < len(lines) else ""
                size_museum_line = lines[i+2] if i+2 < len(lines) else ""
                original_size = ""
                museum = ""
                city = ""
                country = ""
                size_museum_line = size_museum_line.replace("Original Size:", "").strip()
                match = re.match(r'^([^\s]+(?:\s*x\s*[^\s]+)+(?:\s*cm|\.cm|\.?))\s*(.*)$', size_museum_line)
                if match:
                    original_size = match.group(1).strip()
                    museum = match.group(2).strip()
                else:
                    original_size = ""
                    museum = size_museum_line

                museum_parts = museum.split(',')
                if len(museum_parts) >= 3:
                    museum = museum_parts[0].strip()
                    city = museum_parts[1].strip()
                    country = ','.join(museum_parts[2:]).strip()
                else:
                    museum = museum.strip()
                painting = {
                    'title': title,
                    'year': year,
                    'artist': artist,
                    'oil_price_euro': oil_price,
                    'canvas_price_euro': canvas_price,
                    'sku': sku,
                    'original_size': original_size,
                    'museum': museum,
                    'city': city,
                    'country': country
                }
                paintings.append(painting)
            except Exception as e:
                print(f"Error parsing: {e}")
                continue
    print(f"Total paintings: {len(paintings)}")
    return paintings

# Ekstrak detail artist dari halaman profil
def extract_artist_details(artist_url):
    content = get_page_content(artist_url)
    if not content:
        return {}
    soup = BeautifulSoup(content, 'html.parser')
    details = {
        'birth_year': '',
        'death_year': '',
        'nationality': '',
        'art_style': '',
        'biography': '',
        'paintings': [],
        'total_pages': 1
    }

    details['biography'] = extract_biography(content)

    text_content = soup.get_text()
    lines = [line.strip() for line in text_content.split('\n') if line.strip()]

    # Cari tahun lahir dan wafat
    for line in lines:
        year_match = re.search(r'(\d{4})-(\d{4})', line)
        if year_match:
            details['birth_year'] = year_match.group(1)
            details['death_year'] = year_match.group(2)
            break

    # Cari nationality dan art style
    for line in lines:
        if line.endswith("Painter"):
            clean_line = re.sub(r'^\d{4}-\d{4}', '', line).strip()
            before_painter = clean_line.rsplit("Painter", 1)[0].strip()
            parts = before_painter.split()
            if len(parts) >= 2:
                details['nationality'] = ' '.join(parts[:-1])
                details['art_style'] = parts[-1]
            else:
                details['nationality'] = before_painter
                details['art_style'] = ""
            break
    page_info = extract_page_info(text_content)
    details['total_pages'] = page_info['total_pages']
    details['paintings'] = extract_paintings_from_text(content)
    # Ambil painting dari semua halaman jika multi-page
    if details['total_pages'] > 1:
        for page_num in range(2, details['total_pages'] + 1):
            page_url = f"{artist_url.rstrip('/')}/{page_num}"
            print(f"    Fetching page {page_num}/{details['total_pages']}")
            page_content = get_page_content(page_url)
            if page_content:
                page_paintings = extract_paintings_from_text(page_content)
                details['paintings'].extend(page_paintings)
            time.sleep(0.8)  
    return details

# Scrape semua artist, bisa di-limit
def scrape_all_artists(limit=None):
    artists_data = []
    basic_artists = extract_artists_list()
    if limit:
        basic_artists = basic_artists[:limit]
        print(f"Limited to first {limit} artists for testing")
    total_artists = len(basic_artists)
    for i, artist in enumerate(basic_artists, 1):
        print(f"\nProcessing artist {i}/{total_artists}: {artist['name']}")
        details = extract_artist_details(artist['url'])
        artist_data = {
            'name': artist['name'],
            'url': artist['url'],
            'birth_year': details.get('birth_year', ''),
            'death_year': details.get('death_year', ''),
            'nationality': details.get('nationality', ''),
            'art_style': details.get('art_style', ''),
            'biography': details.get('biography', ''),
            'total_pages': details.get('total_pages', 1),
            'paintings': details.get('paintings', [])
        }
        artists_data.append(artist_data)
        print(f"   {artist['name']}: {len(details.get('paintings', []))} paintings with SKUs")
        print(f"   Style: {details.get('nationality', '')} {details.get('art_style', '')}")
        print(f"   Pages: {details.get('total_pages', 1)}")
        print(f"   Biography: {len(details.get('biography', ''))} characters")
        if i < total_artists:
            time.sleep(0.8)
    return artists_data

# Print ringkasan hasil scraping
def print_summary(artists_data):
    if not artists_data:
        print("No data.")
        return
    total_artists = len(artists_data)
    print(f"Total Artists Scraped: {total_artists}")
    print(" Artist Data:")
    for i, artist in enumerate(artists_data[:3], 1):
        print(f"\n{i}. {artist['name']}")
        print(f"   Nationality: {artist['nationality']}")
        print(f"   Art Style: {artist['art_style']}")
        print(f"   Pages Scraped: {artist['total_pages']}")
        if artist['paintings']:
            painting = artist['paintings'][0]
            print(f"   Sample Painting: {painting.get('title', 'Unknown')} ({painting.get('year', 'Unknown')}) - SKU: {painting.get('sku', 'Unknown')}")
        if artist['biography']:
            bio_preview = artist['biography'][:150] + "..." if len(artist['biography']) > 150 else artist['biography']
            print(f"   Biography Preview: {bio_preview}")
    print("-" * 100)

# Simpan hasil ke file JSON
def save_data(artists_data, filename='Data Scraping/data/artists.json'):
    if not artists_data:
        print("No data to save")
        return
    try:
        with open(filename, 'w', encoding='utf-8') as f:
            json.dump(artists_data, f, indent=2, ensure_ascii=False)
        print(f" Data saved to: {filename}")
        print(f"   Artists: {len(artists_data)}")
        total_paintings = sum(len(artist['paintings']) for artist in artists_data)
        print(f"   Total Paintings with SKUs: {total_paintings}")
    except Exception as e:
        print(f"Error saving data: {e}")

# Main entry point
def main():
    artists_data = scrape_all_artists()
    
    print_summary(artists_data)
    
    save_data(artists_data)

if __name__ == "__main__":
    main()