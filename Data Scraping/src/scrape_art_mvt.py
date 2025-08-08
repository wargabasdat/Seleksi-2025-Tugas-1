import requests
import json
from bs4 import BeautifulSoup

# Fungsi utama untuk scraping art styles dan subjects dari halaman TopOfArt
def scrape_art_styles_and_subjects():
    url = "https://www.topofart.com/art-styles.php"
    HEADERS = {
        "User-Agent": 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'
    }
    try:
        session = requests.Session()
        session.headers.update(HEADERS)
        response = session.get(url, timeout=15)
        response.raise_for_status()
        content = response.content
        try:
            text_content = content.decode('utf-8')
        except UnicodeDecodeError:
            try:
                text_content = content.decode('latin-1')
            except:
                text_content = content.decode('utf-8', errors='ignore')
        
        # Pastikan konten yang diambil adalah HTML
        if '<html' not in text_content.lower() and '<!doctype' not in text_content.lower():
            print("Warning: Content doesn't appear to be HTML. Possible encoding or compression issue.")
            print("First 500 bytes of raw content:")
            print(repr(content[:500]))
            return [], []
        
        soup = BeautifulSoup(text_content, 'html.parser')
        
        # Debuugg
        print(text_content[:1000])
        print("\n" + "="*50 + "\n")
        
        styles = []
        subjects = []
        
        # Cari semua section/div yang kemungkinan berisi daftar style/subject
        sections = soup.find_all(['div', 'section', 'article', 'ul', 'ol'])
        for section in sections:
            section_text = section.get_text().lower()
            # Fokus pada section yang mengandung kata kunci style/movement
            if any(keyword in section_text for keyword in ['style', 'movement', 'period', 'ism']):
                links = section.find_all('a')
                for link in links:
                    text = link.get_text(strip=True)
                    href = link.get('href', '')
                    # Filter link yang tidak relevan
                    if (
                        text
                        and len(text) > 2
                        and not any(bad in text.lower() for bad in [
                            'home', 'contact', 'about', 'cart', 'login', 'register',
                            'topofart', 'faqs', 'policy', 'terms', 'paintings', 'silk'
                        ])
                        and not text.isdigit()
                    ):
                        # Klasifikasikan link ke style atau subject berdasarkan kata kunci
                        if any(keyword in (text.lower() + href.lower()) for keyword in ['realism', 'impressionism', 'baroque', 'renaissance', 'modern', 'abstract', 'surreal', 'expressionism', 'cubism']):
                            styles.append(text)
                        elif any(keyword in (text.lower() + href.lower()) for keyword in ['portrait', 'landscape', 'still', 'genre', 'religious', 'mythological', 'historical']):
                            subjects.append(text)
        
        # scan semua link di halaman, kadang ada style/subject di luar section utama
        all_links = soup.find_all('a')
        print(f"Found {len(all_links)} total links")
        for link in all_links:
            text = link.get_text(strip=True)
            href = link.get('href', '')
            if text and len(text) > 2:
                print(f"Link: '{text}' -> '{href}'")
                # Skip link navigasi/menu
                if any(skip in text.lower() for skip in ['home', 'contact', 'about', 'cart', 'login', 'register', 'search', 'top of art', 'copyright']):
                    continue
                # Skip angka atau teks terlalu pendek
                if text.isdigit() or len(text) < 3:
                    continue
                # hardcoded bingung
                style_keywords = ['realism', 'impressionism', 'baroque', 'renaissance', 'modern', 'abstract', 
                                'surreal', 'expressionism', 'cubism', 'romanticism', 'neoclassic', 'gothic',
                                'art nouveau', 'dada', 'futurism', 'minimalism', 'pop art', 'conceptual']
                subject_keywords = ['portrait', 'landscape', 'still life', 'genre', 'religious', 'mythological', 
                                  'historical', 'marine', 'animal', 'flower', 'nude', 'interior', 'cityscape']
                text_lower = text.lower()
                href_lower = href.lower()
                is_style = any(keyword in text_lower or keyword in href_lower for keyword in style_keywords)
                is_subject = any(keyword in text_lower or keyword in href_lower for keyword in subject_keywords)
                if 'movement' in href_lower or 'style' in href_lower or 'period' in href_lower:
                    is_style = True
                elif 'genre' in href_lower or 'subject' in href_lower:
                    is_subject = True
                if is_style:
                    styles.append(text)
                elif is_subject:
                    subjects.append(text)
        
        styles = list(dict.fromkeys(styles))
        subjects = list(dict.fromkeys(subjects))
        styles = [s for s in styles if len(s) > 2 and not s.isdigit()]
        subjects = [s for s in subjects if len(s) > 2 and not s.isdigit()]
        return styles, subjects
        
    except requests.RequestException as e:
        print(f"Error fetching the page: {e}")
        return [], []
    except Exception as e:
        print(f"Error parsing the page: {e}")
        return [], []

# Ubah list string menjadi list of dict dengan key 'name'
def convert_to_object_format(items):
    return [{"name": item} for item in items]

# Simpan hasil scraping ke file JSON
def save_json(subjects, styles):
    import os
    os.makedirs("Data Scraping/data", exist_ok=True)
    subjects_formatted = convert_to_object_format(subjects)
    styles_formatted = convert_to_object_format(styles)
    subject_filename = "Data Scraping/data/art_subjects1.json"
    style_filename = "Data Scraping/data/art_styles1.json"
    with open(subject_filename, "w", encoding="utf-8") as f:
        json.dump(subjects_formatted, f, indent=2, ensure_ascii=False)
    print(f"Saved {len(subjects_formatted)} subjects to {subject_filename}")
    with open(style_filename, "w", encoding="utf-8") as f:
        json.dump(styles_formatted, f, indent=2, ensure_ascii=False)
    print(f"Saved {len(styles_formatted)} styles to {style_filename}")

if __name__ == "__main__":
    styles, subjects = scrape_art_styles_and_subjects()
           