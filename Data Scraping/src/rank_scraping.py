from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
from webdriver_manager.chrome import ChromeDriverManager
from bs4 import BeautifulSoup
import time
import json


def init_driver():
    chrome_options = Options()
    chrome_options.add_argument("--headless")
    driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()), options=chrome_options)
    return driver

def fetch_page(url, driver, wait=10):
    driver.get(url)
    time.sleep(wait)
    return driver.page_source

# Mengambil informasi karakter rank 1-3
def get_high_characters(soup):

    high_characters = soup.select('section.topRanking li.character')
    results = []

    for c in high_characters:
        rank = c.find('div', class_='character-head-rank')
        number = c.find('span', class_='no')
        name = c.find('span', class_='name')
        votes = c.find('div', class_='character-number')
        profile = c.find('a', class_='character-head-profile')
        comment =  c.find('p', class_='character-comment-text')

        results.append({
            "rank": rank.get_text(strip=True) if rank else None,
            "number": number.get_text(strip=True) if number else None,
            "name": name.get_text(strip=True) if name else None,
            "votes": votes.get_text(strip=True).replace('votes', '').strip() if votes else None,
            "comment": comment.get_text(strip=True) if comment else None,
            "profile_link": profile['href'] if profile else None
        }) 

    return results

# Mengambil informasi karakter rank 4-10
def get_lr_characters(soup):

    lr_characters = soup.select('ol.lowRank li.character')
    results = []

    for c in lr_characters:
        rank = c.find('div', class_='character-head-rank')
        number = c.find('div', class_='character-head-no')
        name = c.find('div', class_='character-head-name')
        votes = c.find('div', class_='character-number')
        profile = c.find('a', class_='character-head-profile')

        results.append({
            "rank": rank.get_text(strip=True) if rank else None,
            "number": number.get_text(strip=True) if number else None,
            "name": name.get_text(strip=True) if name else None,
            "votes": votes.get_text(strip=True).replace('votes', '').strip() if votes else None,
            "profile_link": profile['href'] if profile else None
        }) 

    return results

# Mengambil informasi karakter rank 11-90
def get_lru_characters(soup):

    lru_charaters = soup.select('ol.lowRank_under li.character')
    results = []
    for c in lru_charaters:
        rank = c.find('div', class_='character-head-rank')
        number = c.find('div', class_='character-head-no')
        name = c.find('div', class_='character-head-name')
        votes = c.find('div', class_='character-number')
        profile = c.find('a', class_='character-head-profile')

        results.append({
            "rank": rank.get_text(strip=True) if rank else None,
            "number": number.get_text(strip=True) if number else None,
            "name": name.get_text(strip=True) if name else None,
            "votes": votes.get_text(strip=True).replace('votes', '').strip() if votes else None,
            "profile_link": profile['href'] if profile else None
        }) 

    return results

# Mengambil informasi top 10 dari masing-masing region
def get_region_characters_high(soup, region_id):
    country_section = soup.find('section', id=region_id)
    if not country_section:
        return []
    
    region_characters = country_section.select('ol.overseas-country-ranking.topThree li.character')
    results = []

    for c in region_characters:
        rank = c.find('div', class_='character-head-rank')
        number = c.find('span', class_='no')
        name = c.find('span', class_='name')
        profile = c.find('a', class_='character-head-profile')

        results.append({
            "rank": rank.get_text(strip=True) if rank else None,
            "number": number.get_text(strip=True) if number else None,
            "name": name.get_text(strip=True) if name else None,
            "profile_link": profile['href'] if profile else None
        })

    return results

def get_region_characters_low(soup, region_id):

    country_section = soup.find('section', id=region_id)
    if not country_section:
        return []
    
    region_characters = country_section.select('ol.overseas-country-ranking.lowRank li.character')
    results = []

    for c in region_characters:
        rank = c.find('div', class_='character-head-rank')
        number = c.find('div', class_='character-head-no')
        name = c.find('div', class_='character-head-name')
        profile = c.find('a', class_='character-head-profile')

        results.append({
            "rank": rank.get_text(strip=True) if rank else None,
            "number": number.get_text(strip=True) if number else None,
            "name": name.get_text(strip=True) if name else None,
            "profile_link": profile['href'] if profile else None
        })

    return results

def scrape_regions(driver):
    regions = {
        "The Chinese Mainland": "https://www.sanrio.co.jp/special/characterranking/2025/en/result/world/#china",
        "Hong Kong": "https://www.sanrio.co.jp/special/characterranking/2025/en/result/world/#hongkong",
        "Taiwan": "https://www.sanrio.co.jp/special/characterranking/2025/en/result/world/#taiwan",
        "South Korea": "https://www.sanrio.co.jp/special/characterranking/2025/en/result/world/#korea",
        "United States": "https://www.sanrio.co.jp/special/characterranking/2025/en/result/world/#usa",
        "Brazil": "https://www.sanrio.co.jp/special/characterranking/2025/en/result/world/#brazil",
        "United Kingdom": "https://www.sanrio.co.jp/special/characterranking/2025/en/result/world/#uk",
        "Italy": "https://www.sanrio.co.jp/special/characterranking/2025/en/result/world/#italy",
        "Germany": "https://www.sanrio.co.jp/special/characterranking/2025/en/result/world/#germany",
        "France": "https://www.sanrio.co.jp/special/characterranking/2025/en/result/world/#france",
        "Australia": "https://www.sanrio.co.jp/special/characterranking/2025/en/result/world/#australia",
        "Singapore": "https://www.sanrio.co.jp/special/characterranking/2025/en/result/world/#singapore",
        "Thailand": "https://www.sanrio.co.jp/special/characterranking/2025/en/result/world/#thailand",
        "Spain": "https://www.sanrio.co.jp/special/characterranking/2025/en/result/world/#spain"
    }

    region_data = {}
    
    world_url = "https://www.sanrio.co.jp/special/characterranking/2025/en/result/world/"

    html = fetch_page(world_url, driver)
    soup = BeautifulSoup(html, 'lxml')

    for region_name, region_url in regions.items():
        region_id = region_url.split('#')[-1]

        high_chars = get_region_characters_high(soup, region_id)
        low_chars = get_region_characters_low(soup, region_id)

        region_data[region_name] = {
            "high": high_chars,
            "low": low_chars
        }
        time.sleep(1)

    return region_data
        
        
def main():
    driver = init_driver()

    # Overall ranking
    ov_url = 'https://www.sanrio.co.jp/special/characterranking/2025/en/result/'
    ov_html = fetch_page(ov_url, driver)
    ov_soup = BeautifulSoup(ov_html, 'lxml')
    
    high = get_high_characters(ov_soup)
    lr = get_lr_characters(ov_soup)
    lru = get_lru_characters(ov_soup)

    # Region ranking
    regions = scrape_regions(driver)

    driver.quit()

    overall_data = {
        "high_rank": high,
        "low_rank": lr,
        "low_rank_under": lru
    }

    with open('../data/overall_ranking.json', 'w', encoding='utf-8') as f:
        json.dump(overall_data, f, ensure_ascii=False, indent=2)

    region_data = {
        "regions_ranks" : regions
    }

    with open('../data/region_ranking.json', 'w', encoding='utf-8') as f:
        json.dump(region_data, f, ensure_ascii=False, indent=2)

    # Nama region
    region_names = list(regions.keys())
    region_names_data = {
        "region_names": region_names
    }

    with open('../data/region.json', 'w', encoding='utf-8') as f:
        json.dump(region_names_data, f, ensure_ascii=False, indent=2)
   

if __name__ == "__main__":
    main()