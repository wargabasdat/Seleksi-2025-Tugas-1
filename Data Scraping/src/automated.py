import json
import subprocess
import sys
from datetime import datetime
from scrape import (
    setup_chrome_driver, get_current_time, get_game_attributes, get_game_title,
    get_community_name, get_maturity, get_thumbs_up, get_thumbs_down, get_gameid,
    remove_special_characters, validate_game_data, scrape_community, scrape_creator,
    save_json, write_data_to_json
)
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.common.by import By
from selenium.webdriver.support import expected_conditions as EC
import time
import os
import random

BASE_DIR = os.path.dirname(os.path.abspath(__file__))                 # .../Data Scraping/src
PROJECT_DIR = os.path.abspath(os.path.join(BASE_DIR, ".."))           # .../Data Scraping
DATA_RAW_DIR = os.path.join(PROJECT_DIR, "data", "raw")               # .../Data Scraping/data/raw
GAME_JSON_PATH = os.path.join(DATA_RAW_DIR, "game.json")              # .../Data Scraping/data/raw/game.json
COMM_JSON_PATH = os.path.join(DATA_RAW_DIR, "community.json")
CREATOR_JSON_PATH = os.path.join(DATA_RAW_DIR, "creator.json")
PREPROCESS_PATH = os.path.join(BASE_DIR, "preprocess.py")             # .../Data Scraping/src/preprocess.py
STORING_PATH = os.path.abspath(os.path.join(PROJECT_DIR, "..", "Data Storing", "src", "storing.py"))

LOG_PATH = os.path.join(os.path.dirname(PROJECT_DIR), "log.txt")   

def load_game_urls_from_json(file_path=GAME_JSON_PATH):
    with open(file_path, 'r', encoding='utf-8') as f:
        game_data = json.load(f)
    return [entry['URL'] for entry in game_data if 'URL' in entry]

def main():
    os.makedirs(DATA_RAW_DIR, exist_ok=True)

    driver = setup_chrome_driver()
    game_urls = load_game_urls_from_json()
    final_data, community_json, creator_json = [], [], []

    for count, game_url in enumerate(game_urls):
        print(f"\nScraping game {count+1}/{len(game_urls)}: {game_url}")
        try:
            driver.get(game_url)
            WebDriverWait(driver, 10).until(EC.presence_of_element_located((By.TAG_NAME, "body")))
            time.sleep(random.uniform(1.0, 2.5))

            # game
            row = [
                get_current_time(),
                *get_game_attributes(driver),
                get_game_title(driver),
                get_community_name(driver),
                get_maturity(driver),
                get_thumbs_up(driver),
                get_thumbs_down(driver),
                get_gameid(game_url),
                game_url,
            ]
            row = remove_special_characters(row)
            row = validate_game_data(driver, row)
            if row:
                final_data.append(row)

            # community + creator
            community_data, creator_name, creator_link = scrape_community(driver, game_url)
            if community_data:
                community_json.append(community_data)
            if creator_name != '-' and creator_link != '-':
                cr = scrape_creator(driver, creator_name, creator_link)
                if cr:
                    creator_json.append(cr)

        except Exception as e:
            print(f"Error scraping game {count+1}: {e}")
            continue
    driver.quit()

    # overwrite JSON
    write_data_to_json(final_data)
    save_json(community_json, COMM_JSON_PATH)
    save_json(creator_json, CREATOR_JSON_PATH)

    # run preprocess & storing
    subprocess.run([sys.executable, PREPROCESS_PATH], check=False)
    subprocess.run([sys.executable, STORING_PATH], check=False)

    # append log
    now = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    with open(LOG_PATH, 'a', encoding='utf-8') as log:
        log.write(f"[{now}] OK: scraping + preprocess + storing selesai. Total games: {len(final_data)}\n")
    print(f"[{now}] Automated pipeline done.")

if __name__ == '__main__':
    main()
