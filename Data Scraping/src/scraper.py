
import requests
from bs4 import BeautifulSoup
import pandas as pd
import json
import re
import os

def scrape_gamebrott_article():
    """
    scraping 100 data game ps2 terbaik di gamebrott.com
    """
    URL = "https://gamebrott.com/100-game-ps2-terbaik-di-dunia/"
    try:
        response = requests.get(URL)
        response.raise_for_status() # bad response akan menimbulkan exception
    except requests.exceptions.RequestException as e:
        print(f"Error fetching the URL: {e}")
        return []

    soup = BeautifulSoup(response.text, 'html.parser')
    
    games = []
    game_titles = soup.find_all('h2')

    for title_tag in game_titles:
        title_text = title_tag.get_text(strip=True)
        
        if re.match(r"^\d+\.\s", title_text):
            description_tag = title_tag.find_next_sibling('p')

            genre_text = description_tag.get_text(strip=True) if description_tag else ""
            
            games.append({
                "raw_title": title_text,
                "genre_text": genre_text
            })

    print(f"(LOG) berhasil memparsing {len(games)} game entries.")
    return games

def clean_data(games):
    """
    Transformasi dan pembersihan data game PS2.
    
    - Ekstraksi rank dan judul game.
    - Membersihkan judul dari rank dan tanda baca.
    - Ekstraksi genre dari deskripsi game.
    """
    cleaned_list = []
    for game in games:
        raw_title = game["raw_title"]
        
        # Ekstrak rank dengan regex
        match = re.match(r"^(\d+)\.\s*(.*)", raw_title)
        if match:
            rank = int(match.group(1))
            title = match.group(2).strip()
            
            # Ekstrak genre (semua game di url gamebrott.com memiliki genre)
            genre_text = game["genre_text"]
            genre = ""
            if genre_text.startswith("Genre:"):
                genre = genre_text.replace("Genre:", "").strip()

            # 3 atribut utama yang akan disimpan
            cleaned_list.append({
                "rank": rank,
                "title": title,
                "genre": genre
            })
            
    # mengurutkan list berdasarkan rank
    cleaned_list.sort(key=lambda x: x['rank'])
    print(f"Successfully cleaned {len(cleaned_list)} games.")
    return cleaned_list

def save_to_json(data, filename):
    """
    Menyimpan data ke file JSON.
    """
    os.makedirs(os.path.dirname(filename), exist_ok=True)
    
    try:
        with open(filename, 'w', encoding='utf-8') as f:
            json.dump(data, f, ensure_ascii=False, indent=2)
        print(f"(LOG) Data berhasil disimpan di {filename}")
    except IOError as e:
        print(f"(LOG) Error menuliskan file di {filename}: {e}")

def main():

    script_dir = os.path.dirname(os.path.abspath(__file__))
    output_file = os.path.join(script_dir, "..", "data", "list_games_ps2.json")

    scraped_games = scrape_gamebrott_article()
    if scraped_games:
        cleaned_games = clean_data(scraped_games)
        save_to_json(cleaned_games, output_file)

if __name__ == "__main__":
    main()
