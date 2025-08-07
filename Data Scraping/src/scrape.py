
import re
import sys
import csv
import json
from datetime import datetime
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import time
import random
import os

def setup_chrome_driver():
    chrome_options = Options()
    # chrome_options.add_argument("--headless")
    chrome_options.add_argument("--no-sandbox")
    chrome_options.add_argument("--disable-dev-shm-usage")
    chrome_options.add_argument("--disable-blink-features=AutomationControlled")
    chrome_options.add_experimental_option("excludeSwitches", ["enable-automation"])
    chrome_options.add_experimental_option('useAutomationExtension', False)
    chrome_options.add_argument("--user-agent=Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36")
    driver = webdriver.Chrome(options=chrome_options)
    driver.execute_script("Object.defineProperty(navigator, 'webdriver', {get: () => undefined})")
    return driver

def get_game_urls(driver):
    url = 'https://www.roblox.com/discover'
    driver.get(url)
    time.sleep(8)
    # Scroll down to load more games
    for _ in range(3):
        driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
        time.sleep(2)
    # Find all game links
    game_cards = driver.find_elements(By.CSS_SELECTOR, 'li.list-item.game-card.game-tile a[href*="/games/"]')
    game_urls = list({card.get_attribute("href") for card in game_cards if card.get_attribute("href")})
    return game_urls

def get_current_time():
    return str(datetime.now().strftime('%Y-%m-%d'))

def get_game_attributes(driver):
    try:
        attributes = driver.find_elements(By.CSS_SELECTOR, 'p.text-lead.font-caption-body')
        attribute_list = []
        for i in range(9):  
            try:
                attribute_list.append(attributes[i].text)
            except:
                attribute_list.append('-')
        return attribute_list
    except:
        return ['-'] * 9

def get_thumbs_up(driver):
    try:
        up = driver.find_element(By.CSS_SELECTOR, 'span#vote-up-text.vote-text')
        return up.text.strip()
    except:
        return '-'

def get_thumbs_down(driver):
    try:
        down = driver.find_element(By.CSS_SELECTOR, 'span#vote-down-text.vote-text')
        return down.text.strip()
    except:
        return '-'

def get_game_title(driver):
    try:
        title_element = driver.find_element(By.CSS_SELECTOR, 'h1.game-name')
        return title_element.get_attribute("title")
    except:
        return '-'
    
def get_community_name(driver):
    try:
        community_element = driver.find_element(By.CSS_SELECTOR, 'a.text-name.text-overflow')
        return community_element.text.strip()
    except:
        return '-'

def get_maturity(driver):
    try:
        element = driver.find_element(By.CSS_SELECTOR, 'a.age-recommendation-title.text')
        text = element.text.strip()
        return text.replace("Maturity: ", "")
    except:
        return '-'

def get_gameid(game_url: str):
    game_ID_list = re.findall(r'\d+', game_url)
    for gameID in game_ID_list:
        if len(gameID) > 6:
            return gameID
    return '-'

def remove_special_characters(data: list):
    return [str(item).replace('"','').replace("'",'').replace('|','').replace('\n','').replace(',','') for item in data]

def validate_game_data(driver, data: list):
    if len(data) == 17:
        return data
    else:
        print('\n\n ERROR: ROW DID NOT HAVE CORRECT NUMBER OF FEATURES \n\n')
        os.makedirs('./data', exist_ok=True)
        with open('./data/incompleteData.txt', 'a', encoding='utf-8') as f:
            f.write(driver.page_source)
            for attribute in data:
                f.write(str(attribute))
        return []

def scrape_community(driver, game_url):
    community_data = {}
    creator_name = '-'
    creator_link = '-'

    try:
        driver.get(game_url)
        WebDriverWait(driver, 10).until(EC.presence_of_element_located((By.TAG_NAME, "body")))
        time.sleep(1.5)

        community_elem = driver.find_element(By.CSS_SELECTOR, 'a.text-name.text-overflow')
        community_name = community_elem.text.strip()
        community_link = community_elem.get_attribute('href')

        driver.get(community_link)
        WebDriverWait(driver, 10).until(EC.presence_of_element_located((By.TAG_NAME, "body")))
        time.sleep(1.5)

        try:
            member_elem = driver.find_element(By.CSS_SELECTOR, 'span.flex.items-center.bg-surface-300.radius-circle.text-caption-medium.padding-x-medium.padding-y-xsmall')
            member_text = member_elem.text.strip()
            member_count = member_text.replace("Members", "").strip()
        except:
            member_count = '-'

        try:
            creator_elem = driver.find_element(By.CSS_SELECTOR, 'a.MuiTypography-root.MuiTypography-inherit.MuiLink-root.web-blox-css-tss-quks9y-Link-colorInherit-Link-root.MuiLink-underlineHover.web-blox-css-mui-94v26k')
            creator_name = creator_elem.text.strip()
            creator_link = creator_elem.get_attribute('href')
        except:
            creator_name = '-'
            creator_link = '-'

        community_data = {
            'Community Name': community_name,
            'Members': member_count,
            'Creator Name': creator_name
        }

    except Exception as e:
        print(f'[Community ERROR]: {e}')

    return community_data, creator_name, creator_link

def write_data_to_json(data: list):
    file_location = 'data/raw/game.json'
    field_names = ['Date', 'Active Users', 'Favorites', 'Total Visits', 'Voice Chat', 'Camera', 
               'Date Created', 'Last Updated', 'Server Size', 'Genre', 'Title', 'Community',
               'Maturity', 'Thumbs Up', 'Thumbs Down', 'gameID', 'URL']

    json_data = []
    for row in data:
        if len(row) == len(field_names):
            game_dict = {field_names[i]: row[i] for i in range(len(row))}
            json_data.append(game_dict)
    with open(file_location, 'w', encoding='utf-8') as f:
        json.dump(json_data, f, indent=2, ensure_ascii=False)
    print(f'Data saved to: {file_location}')
    print(f'Total games saved: {len(json_data)}')

def scrape_creator(driver, creator_name, creator_link):
    creator_data = {}

    try:
        driver.get(creator_link)
        WebDriverWait(driver, 10).until(EC.presence_of_element_located((By.TAG_NAME, "body")))
        time.sleep(1.5)

        stats = {'Friends': '-', 'Followers': '-', 'Following': '-'}
        social_links = driver.find_elements(By.CSS_SELECTOR, 'a.profile-header-social-count')

        for link in social_links:
            title = link.get_attribute("title") or ""
            if "Friends" in title:
                stats['Friends'] = ''.join(re.findall(r'\d+', title))
            elif "Followers" in title:
                stats['Followers'] = ''.join(re.findall(r'\d+', title))
            elif "Following" in title:
                stats['Following'] = ''.join(re.findall(r'\d+', title))

        creator_data = {
            'Creator Name': creator_name,
            'Friends': stats['Friends'],
            'Followers': stats['Followers'],
            'Following': stats['Following']
        }

    except Exception as e:
        print(f'[Creator ERROR]: {e}')

    return creator_data


def save_json(data_list, file_path):
    os.makedirs('./data', exist_ok=True)
    with open(file_path, 'w', encoding='utf-8') as f:
        json.dump(data_list, f, indent=2, ensure_ascii=False)
        
def main():
    driver = setup_chrome_driver()
    try:
        game_urls = get_game_urls(driver)[:200]
        print(f"Found {len(game_urls)} games to scrape")

        final_data = []
        community_json = []
        creator_json = []

        for count, game_url in enumerate(game_urls[:200]):
            print(f"\nScraping game {count+1}/{len(game_urls)}: {game_url}")
            try:
                # buka halaman game
                driver.get(game_url)
                WebDriverWait(driver, 10).until(
                    EC.presence_of_element_located((By.TAG_NAME, "body"))
                )
                time.sleep(random.uniform(1, 2.5))

                # scrape game info
                game_data = []
                game_data.append(get_current_time())
                game_data.extend(get_game_attributes(driver))
                game_data.append(get_game_title(driver))
                game_data.append(get_community_name(driver))
                game_data.append(get_maturity(driver))
                game_data.append(get_thumbs_up(driver))
                game_data.append(get_thumbs_down(driver))
                game_data.append(get_gameid(game_url))
                game_data.append(game_url)
                game_data = remove_special_characters(game_data)
                game_data = validate_game_data(driver, game_data)
                if game_data:
                    final_data.append(game_data)

                # scrape community & get creator info
                community_data, creator_name, creator_link = scrape_community(driver, game_url)
                if community_data:
                    community_json.append(community_data)

                # scrape creator
                if creator_name != '-' and creator_link != '-':
                    creator_data = scrape_creator(driver, creator_name, creator_link)
                    if creator_data:
                        creator_json.append(creator_data)

            except Exception as e:
                print(f"Error scraping game {count+1}: {e}")
                continue

        write_data_to_json(final_data)
        save_json(community_json, './data/raw/community.json')
        save_json(creator_json, './data/raw/creator.json')

    finally:
        driver.quit()

if __name__ == '__main__':
    main()
