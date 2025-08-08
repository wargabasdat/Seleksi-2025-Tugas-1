from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
from webdriver_manager.chrome import ChromeDriverManager
from selenium.common.exceptions import TimeoutException
from bs4 import BeautifulSoup
import time
import json
import urllib3
import re

def init_driver():
    chrome_options = Options()
    chrome_options.add_argument("--headless")
    driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()), options=chrome_options)
    driver.set_page_load_timeout(180)
    return driver

def fetch_page(url, driver, wait=5):
    driver.get(url)
    time.sleep(wait)
    return driver.page_source

def setup_translate(from_code="ja", to_code="en"):
    import argostranslate.package
    import argostranslate.translate
    
    argostranslate.package.update_package_index()
    available_packages = argostranslate.package.get_available_packages()
    package_to_install = next(
        (x for x in available_packages if x.from_code == from_code and x.to_code == to_code), None
    )
    if package_to_install:
        argostranslate.package.install_from_path(package_to_install.download())

def is_japanese_char(char):
    code = ord(char)
    japanese_ranges = [
        (0x3040, 0x309F),  # hiragana
        (0x30A0, 0x30FF),  # katakana
        (0x4E00, 0x9FFF),  # kanji
        (0x3000, 0x303F)   # simbol
    ]
    
    for start, end in japanese_ranges:
        if start <= code <= end:
            return True
    return False

def contains_japanese(text):
    if not text:
        return False
    
    for char in text:
        if is_japanese_char(char):
            return True
    return False

def translate(text, from_code="ja", to_code="en"):
    if not text:
        return None

    import argostranslate.translate
    
    translated = argostranslate.translate.translate(text, from_code, to_code)
    
    if not translated:
        return None
    
    if contains_japanese(translated):
        return None
    
    return translated

translation_cache = {}
def cached_translate(text, from_code="ja", to_code="en"):
    if not text:
        return None
    
    if text in translation_cache:
        return translation_cache[text]
    
    result = translate(text, from_code, to_code)
    
    if result: 
        translation_cache[text] = result
    
    return result

def get_profile_data(soup, profile_url, character_info):
 
    character_friends = soup.select('ul.p-characterDetailProfile__relatedList li.p-characterDetailProfile__relatedItem')
    character_desc = soup.select('p.p-characterDetailFv__caption.for-mobile')

    character_record = {
        "name": character_info.get("name"),
        "jp_description": None,
        "friends": []
    }

    if character_desc:
        character_record["jp_description"] = character_desc[0].get_text(strip=True)

    for c in character_friends:
        friend_name = c.find('h4', class_='p-characterDetailProfile__relatedItemHeading')
        if friend_name:
                character_record["friends"].append(friend_name.get_text(strip=True))
                
    return character_record

def normalize_name(name):
    return re.sub(r'[^a-z0-9]', '', name.lower().strip())

def translate_json_file():
    with open('../data/character.json', 'r', encoding='utf-8') as f:
        data = json.load(f)
    
    for character in data:
        if character["jp_description"]:
            character["description"] = translate(character["jp_description"])
        
        translated_friends = []
        for friend in character["friends"]:
            translated = translate(friend)
            if translated and not contains_japanese(translated):
                translated_friends.append(translated)
        character["friends"] = translated_friends
    
    with open('../data/character_en.json', 'w', encoding='utf-8') as f:
        json.dump(data, f, ensure_ascii=False, indent=2)

def main():

    setup_translate()

    try:
        with open('../data/overall_ranking.json', 'r', encoding='utf-8') as f:
            overall_data = json.load(f)

    except FileNotFoundError:
        print("Ranking data file not found")
        return
    
    try:
        with open('../data/region_ranking.json', 'r', encoding='utf-8') as f:
            region_rankings = json.load(f)
    except FileNotFoundError:
        region_rankings = []
    
    
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
                    all_profiles.append(profile_data)
                    time.sleep(1)

                except(TimeoutException, urllib3.exceptions.ReadTimeoutError) as e:
                    time.sleep(5)
                    continue

    driver.quit()

    # translate scraped profiles
    translate_data = []
    for character in all_profiles:
        translated_record = {"name": character["name"]}
        # translate description
        if character["jp_description"]:
            translated_desc = translate(character["jp_description"])

            if not translated_desc and character["jp_description"]:
                import argostranslate.translate
                raw_translation = argostranslate.translate.translate(character["jp_description"], "ja", "en")
                if raw_translation:
                    filtered_text = ''.join([char for char in raw_translation if not is_japanese_char(char)])
                    filtered_text = ' '.join(filtered_text.split())
                    if filtered_text.strip():
                        translated_record["description"] = filtered_text
            else:
                translated_record["description"] = translated_desc

        # translate friends
        translated_friends = []
        for friend in character["friends"]:
            translated = translate(friend)
            if translated and not contains_japanese(translated):
                translated_friends.append(translated)
        translated_record["friends"] = translated_friends

        translate_data.append(translated_record)

    # tambahkan karakter dari region_rankings jika belum ada
    existing_names = {normalize_name(char["name"]) for char in translate_data}

    for region, ranks in region_rankings.get("regions_ranks", {}).items():
        for rank_type in ["high", "low"]:
            for entry in ranks.get(rank_type, []):
                profile_link = entry.get("profile_link")
                if profile_link:
                    char_name = profile_link.rstrip('/').split('/')[-1]
                    norm_name = normalize_name(char_name)
                    if norm_name not in existing_names:
                        new_entry = {
                            "name": char_name,
                            "description": None,
                            "friends": []
                        }
                        translate_data.append(new_entry)
                        existing_names.add(norm_name)
    
    
    with open('../data/character.json', 'w', encoding='utf-8') as f:
        json.dump(translate_data, f, ensure_ascii=False, indent=2)
    

if __name__ == "__main__":
    main()