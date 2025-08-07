
import requests
from bs4 import BeautifulSoup
import pandas as pd
import json
import re
import os

def scrape_gamebrott_article():
    """
    Scrapes the top 100 PS2 games from a Gamebrott article.

    Fetches the HTML content, parses it to extract game rank, title, and description,
    and returns the data as a list of dictionaries.
    """
    URL = "https://gamebrott.com/100-game-ps2-terbaik-di-dunia/"
    try:
        response = requests.get(URL)
        response.raise_for_status()  # Raise an exception for bad status codes
    except requests.exceptions.RequestException as e:
        print(f"Error fetching the URL: {e}")
        return []

    soup = BeautifulSoup(response.text, 'html.parser')
    
    games = []
    # Find all h2 tags, which are used for game titles
    game_titles = soup.find_all('h2')

    for title_tag in game_titles:
        title_text = title_tag.get_text(strip=True)
        
        # Check if the title follows the expected "rank. title" format
        if re.match(r"^\d+\.\s", title_text):
            description_tag = title_tag.find_next_sibling('p')
            # The text is expected to be "Genre: [The Genre]"
            genre_text = description_tag.get_text(strip=True) if description_tag else ""
            
            games.append({
                "raw_title": title_text,
                "genre_text": genre_text
            })

    print(f"Successfully scraped {len(games)} game entries.")
    return games

def clean_data(games):
    """
    Cleans and transforms the scraped game data.
    
    - Extracts rank from title and converts to integer.
    - Cleans title by removing the rank.
    - Extracts genre from the genre text.
    """
    cleaned_list = []
    for game in games:
        raw_title = game["raw_title"]
        
        # Extract rank and title using regex
        match = re.match(r"^(\d+)\.\s*(.*)", raw_title)
        if match:
            rank = int(match.group(1))
            title = match.group(2).strip()
            
            # Extract genre
            genre_text = game["genre_text"]
            genre = ""
            if genre_text.startswith("Genre:"):
                genre = genre_text.replace("Genre:", "").strip()

            cleaned_list.append({
                "rank": rank,
                "title": title,
                "genre": genre
            })
            
    # Sort by rank ascending
    cleaned_list.sort(key=lambda x: x['rank'])
    print(f"Successfully cleaned {len(cleaned_list)} games.")
    return cleaned_list

def save_to_json(data, filename):
    """
    Saves the given data to a JSON file.
    """
    # Ensure the directory exists
    os.makedirs(os.path.dirname(filename), exist_ok=True)
    
    try:
        with open(filename, 'w', encoding='utf-8') as f:
            json.dump(data, f, ensure_ascii=False, indent=2)
        print(f"Data successfully saved to {filename}")
    except IOError as e:
        print(f"Error writing to file {filename}: {e}")

def main():
    """
    Main function to run the scraper, cleaner, and save the data.
    """
    # Define the output file path relative to the script's location
    script_dir = os.path.dirname(os.path.abspath(__file__))
    output_file = os.path.join(script_dir, "..", "data", "list_games_ps2.json")

    scraped_games = scrape_gamebrott_article()
    if scraped_games:
        cleaned_games = clean_data(scraped_games)
        save_to_json(cleaned_games, output_file)

if __name__ == "__main__":
    main()
