from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
from webdriver_manager.chrome import ChromeDriverManager
from selenium.common.exceptions import TimeoutException
from bs4 import BeautifulSoup
import time
import json
import urllib3

def init_driver():
    chrome_options = Options()
    chrome_options.add_argument("--headless")
    driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()), options=chrome_options)
    driver.set_page_load_timeout(180)
    return driver

def fetch_page(url, driver, wait=10):
    driver.get(url)
    time.sleep(wait)
    return driver.page_source

def get_profile_data(soup, profile_url, character_info):
 
    results = []
    character_friends = soup.select('ul.p-characterDetailProfile__relatedList li.p-characterDetailProfile__relatedItem')
    character_desc = soup.select('p.p-characterDetailFv__caption.for-mobile')

    character_record = {
        "name": character_info.get("name"),
        "description": None,
        "friends": []
    }
    
    if character_desc:
        description_text = character_desc[0].get_text(strip=True)
        character_record["description"] = description_text
    
    for c in character_friends:
        friend_name = c.find('h4', class_='p-characterDetailProfile__relatedItemHeading')
        if friend_name:
            character_record["friends"].append(friend_name.get_text(strip=True))

    results.append(character_record)
    return results

def main():
    try:
        with open('../data/overall_ranking.json', 'r', encoding='utf-8') as f:
            overall_data = json.load(f)

    except FileNotFoundError:
        print("Ranking data file not found. Please run rank_scraping.py first.")
        return
    
    driver = init_driver()
    all_profiles = []

    categories = ["high_rank", "low_rank", "low_rank_under"]
    
    for category in categories:
        for character in overall_data[category]:
            profile_link = character.get("profile_link")
            if profile_link:
                try: 
                    html = fetch_page(profile_link, driver)
                    soup = BeautifulSoup(html, 'lxml')
                    profile_data = get_profile_data(soup, profile_link, character)
                    all_profiles.extend(profile_data)
                    time.sleep(1)

                except(TimeoutException, urllib3.exceptions.ReadTimeoutError) as e:
                    time.sleep(5)
                    continue

    driver.quit()

    with open('../data/character.json', 'w', encoding='utf-8') as f:
        json.dump(all_profiles, f, ensure_ascii=False, indent=2)

if __name__ == "__main__":
    main()