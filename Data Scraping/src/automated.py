import json
import time
import random
import re
import os
from datetime import datetime
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

# ==== Setup Chrome Driver ====
def setup_chrome_driver():
    chrome_options = Options()
    # chrome_options.add_argument("--headless")  # Uncomment for headless scraping
    chrome_options.add_argument("--no-sandbox")
    chrome_options.add_argument("--disable-dev-shm-usage")
    chrome_options.add_argument("--disable-blink-features=AutomationControlled")
    chrome_options.add_experimental_option("excludeSwitches", ["enable-automation"])
    chrome_options.add_experimental_option('useAutomationExtension', False)
    chrome_options.add_argument("--user-agent=Mozilla/5.0")
    driver = webdriver.Chrome(options=chrome_options)
    driver.execute_script("Object.defineProperty(navigator, 'webdriver', {get: () => undefined})")
    return driver

# ==== Scraping Functions ====
def get_current_time():
    return str(datetime.now().strftime('%Y-%m-%d'))

def get_game_attributes(driver):
    try:
        attributes = driver.find_elements(By.CSS_SELECTOR, 'p.text-lead.font-caption-body')
        return [attr.text if i < len(attributes) else '-' for i in range(9)]
    except:
        return ['-'] * 9

def get_thumbs_up(driver):
    try:
        return driver.find_element(By.CSS_SELECTOR, 'span#vote-up-text.vote-text').text.strip()
    except:
        return '-'

def get_thumbs_down(driver):
    try:
        return driver.find_element(By.CSS_SELECTOR, 'span#vote-down-text.vote-text').text.strip()
    except:
        return '-'

def get_game_title(driver):
    try:
        return driver.find_element(By.CSS_SELECTOR, 'h1.game-name').get_attribute("title")
    except:
        return '-'

def get_community_name(driver):
    try:
        return driver.find_element(By.CSS_SELECTOR, 'a.text-name.text-overflow').text.strip()
    except:
        return '-'

def get_maturity(driver):
    try:
        return driver.find_element(By.CSS_SELECTOR, 'a.age-recommendation-title.text').text.strip().replace("Maturity: ", "")
    except:
        return '-'

def get_gameid(game_url: str):
    match = re.findall(r'\d+', game_url)
    for val in match:
        if len(val) > 6:
            return val
    return '-'

def remove_special_characters(data):
    return [str(item).replace('"','').replace("'",'').replace('|','').replace('\n','').replace(',','') for item in data]

def validate_game_data(data):
    return data if len(data) == 17 else []

def scrape_community(driver):
    try:
        elem = driver.find_element(By.CSS_SELECTOR, 'a.text-name.text-overflow')
        community_name = elem.text.strip()
        community_link = elem.get_attribute('href')

        driver.get(community_link)
        WebDriverWait(driver, 10).until(EC.presence_of_element_located((By.TAG_NAME, "body")))
        time.sleep(1.5)

        members = driver.find_element(By.CSS_SELECTOR, 'span.flex.items-center.bg-surface-300.radius-circle.text-caption-medium.padding-x-medium.padding-y-xsmall').text.replace("Members", "").strip()
        creator_elem = driver.find_element(By.CSS_SELECTOR, 'a.MuiTypography-root.MuiTypography-inherit.MuiLink-root.web-blox-css-tss-quks9y-Link-colorInherit-Link-root.MuiLink-underlineHover.web-blox-css-mui-94v26k')
        creator_name = creator_elem.text.strip()
        creator_link = creator_elem.get_attribute('href')

        return {
            'Community Name': community_name,
            'Members': members,
            'Creator Name': creator_name
        }, creator_name, creator_link

    except:
        return {}, '-', '-'

def scrape_creator(driver, creator_name, creator_link):
    try:
        driver.get(creator_link)
        WebDriverWait(driver, 10).until(EC.presence_of_element_located((By.TAG_NAME, "body")))
        time.sleep(1.5)

        stats = {'Friends': '-', 'Followers': '-', 'Following': '-'}
        elements = driver.find_elements(By.CSS_SELECTOR, 'a.profile-header-social-count')
        for el in elements:
            title = el.get_attribute("title") or ""
            for key in stats:
                if key in title:
                    stats[key] = ''.join(re.findall(r'\d+', title))
        return {
            'Creator Name': creator_name,
            **stats
        }
    except:
        return {}

def save_json(data_list, path):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, 'w', encoding='utf-8') as f:
        json.dump(data_list, f, indent=2, ensure_ascii=False)

# ==== Main Function ====
def main():
    driver = setup_chrome_driver()
    with open("Data Scraping/data/preprocessed/game_preprocessed.json", "r", encoding="utf-8") as f:
        game_list = json.load(f)

    final_data = []
    community_json = []
    creator_json = []

    for i, game in enumerate(game_list):
        url = game["URL"]
        print(f"[{i+1}] Scraping: {url}")

        try:
            driver.get(url)
            WebDriverWait(driver, 10).until(EC.presence_of_element_located((By.TAG_NAME, "body")))
            time.sleep(random.uniform(1.2, 2.3))

            row = [get_current_time()]
            row += get_game_attributes(driver)
            row.append(get_game_title(driver))
            row.append(get_community_name(driver))
            row.append(get_maturity(driver))
            row.append(get_thumbs_up(driver))
            row.append(get_thumbs_down(driver))
            row.append(get_gameid(url))
            row.append(url)

            row = remove_special_characters(row)
            row = validate_game_data(row)
            if row: final_data.append(row)

            community_data, creator_name, creator_link = scrape_community(driver)
            if community_data: community_json.append(community_data)
            if creator_name != '-' and creator_link != '-':
                creator_data = scrape_creator(driver, creator_name, creator_link)
                if creator_data: creator_json.append(creator_data)

        except Exception as e:
            print(f"  [ERROR]: {e}")
            continue

    # ==== Save All ====
    field_names = ['Date', 'Active Users', 'Favorites', 'Total Visits', 'Voice Chat', 'Camera', 
                   'Date Created', 'Last Updated', 'Server Size', 'Genre', 'Title', 'Community', 
                   'Maturity', 'Thumbs Up', 'Thumbs Down', 'gameID', 'URL']
    output_data = [dict(zip(field_names, row)) for row in final_data]

    save_json(output_data, 'data/raw/game.json')
    save_json(community_json, 'data/raw/community.json')
    save_json(creator_json, 'data/raw/creator.json')

    print("✅ Scraping selesai dan data tersimpan!")
    driver.quit()

if __name__ == '__main__':
    main()
