import requests
from bs4 import BeautifulSoup
import json
import time

def scrape_master_list_with_links():
    url = "https://epguides.com/NCIS/"
    headers = {
        'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36',
        'From': '13523122@std.stei.itb.ac.id'  
    }

    try:
        response = requests.get(url, headers=headers)
        response.raise_for_status()
    except requests.exceptions.RequestException as e:
        print(f"Error fetching page: {e}")
        return []

    soup = BeautifulSoup(response.content, 'html.parser')
    eplist_div = soup.find('div', id='eplist')
    if not eplist_div: return []
    episode_table = eplist_div.find('table')
    if not episode_table: return []

    all_episodes_stubs = []
    for row in episode_table.find_all('tr')[1:]:
        cells = row.find_all('td')
        if len(cells) >= 4:
            try:
                title_tag = cells[3].find('a')
                if not (title_tag and title_tag.has_attr('href')):
                    continue

                season, episode_in_season = map(int, cells[1].text.strip().split('-'))
                
                episode_data = {
                    "overall_episode_number": int(cells[0].text.strip().replace('.', '')),
                    "season": season,
                    "episode_in_season": episode_in_season,
                    "air_date": cells[2].text.strip(),
                    "title": title_tag.text.strip(),
                    "tvmaze_detail_url": title_tag['href']
                }
                all_episodes_stubs.append(episode_data)
            except (ValueError, IndexError, AttributeError):
                continue
    return all_episodes_stubs

def get_tvmaze_details(detail_url):
    if not detail_url: return {}
    headers = {
        'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36',
        'From': '13523122@std.stei.itb.ac.id'  
    }
    details = {}
    print(f"  -> Fetching details from: {detail_url}") 

    try:
        response = requests.get(detail_url, headers=headers)
        response.raise_for_status()
        time.sleep(1)
        soup = BeautifulSoup(response.content, 'html.parser')
        rating_value_tag = soup.select_one('[itemprop="ratingValue"]')
        rating_count_tag = soup.select_one('[itemprop="ratingCount"]')
        details['rating_value'] = float(rating_value_tag.text.strip()) if rating_value_tag else None
        details['rating_count'] = int(rating_count_tag.text.strip()) if rating_count_tag else None
        summary_tag = soup.select_one("section#general-information article p")
        details['summary'] = summary_tag.get_text(strip=True) if summary_tag else None
        
        # doesnt work yet, i think pake ver guest cast aja (diff page)
        crew = []
        for item in soup.select("#episode-crew-list .crew-list-item"):
            role = item.select_one(".role").text.strip().lower()
            name = item.select_one(".name").text.strip()
            crew.append({"name": name, "role": role})
        details['crew'] = crew

        # doesnt work yet, i think pake ver guest cast aja (diff page)
        cast = []
        for item in soup.select("#episode-cast-list .cast-list-item"):
            actor = item.select_one(".person-name").text.strip()
            character = item.select_one(".character-name").text.strip()
            cast.append({"actor": actor, "character": character})
        details['cast'] = cast

    except requests.exceptions.RequestException as e:
        print(f"  -> Error scraping episode details: {e}")
    return details

def get_guest_cast(cast_url):
    if not cast_url: return []
    
    headers = {
        'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36',
        'From': '13523122@std.stei.itb.ac.id'  
    }
    guest_list = []
    print(f"  -> Fetching guest cast from: {cast_url}")

    try:
        response = requests.get(cast_url, headers=headers)
        response.raise_for_status()
        time.sleep(1)

        soup = BeautifulSoup(response.content, 'html.parser')
        
        for person_box in soup.select('article.grid-x.personbox'):
            actor_tag = person_box.select_one('h2 > a')
            
            character_tag = person_box.select_one("a[href*='/characters/']")
            
            if actor_tag and character_tag:
                guest_list.append({
                    "actor": actor_tag.text.strip(),
                    "character": character_tag.text.strip()
                })

    except requests.exceptions.RequestException as e:
        print(f"  -> Error scraping guest cast: {e}")
        
    return guest_list

if __name__ == "__main__":
    master_list = scrape_master_list_with_links()
    
    all_episodes = []
    all_casts = []
    all_crews = []
    all_guest_casts = [] 

    if master_list:
        episodes_to_process = master_list[:5]  # remove this later kl mau all

        print(f"\nProcessing {len(episodes_to_process)} episodes...")

        for episode_stub in episodes_to_process:
            details = get_tvmaze_details(episode_stub.get('tvmaze_detail_url'))
            
            guest_cast_url = episode_stub.get('tvmaze_detail_url') + "/cast"
            guest_cast_list = get_guest_cast(guest_cast_url)

            episode_id = episode_stub['overall_episode_number']
            
            all_episodes.append({
                "episode_id": episode_id, 
                "season": episode_stub['season'],
                "episode_in_season": episode_stub['episode_in_season'], 
                "title": episode_stub['title'],
                "air_date": episode_stub['air_date'], 
                "summary": details.get('summary'),
                "rating_value": details.get('rating_value'), 
                "rating_count": details.get('rating_count')
            })
            
            for crew_member in details.get('crew', []):
                all_crews.append({"episode_id": episode_id, "name": crew_member['name'], "role": crew_member['role']})
            
            for cast_member in details.get('cast', []):
                all_casts.append({"episode_id": episode_id, "actor": cast_member['actor'], "character": cast_member['character']})

            for guest in guest_cast_list:
                all_guest_casts.append({"episode_id": episode_id, "actor": guest['actor'], "character": guest['character']})

        with open("../data/episodes.json", 'w', encoding='utf-8') as f: json.dump(all_episodes, f, ensure_ascii=False, indent=2)
        print("\nData saved ../data/to episodes.json")
        with open("../data/casts.json", 'w', encoding='utf-8') as f: json.dump(all_casts, f, ensure_ascii=False, indent=2)
        print("Data saved ../data/to casts.json")
        with open("../data/crews.json", 'w', encoding='utf-8') as f: json.dump(all_crews, f, ensure_ascii=False, indent=2)
        print("Data saved ../data/to crews.json")
        with open("../data/guest_casts.json", 'w', encoding='utf-8') as f: json.dump(all_guest_casts, f, ensure_ascii=False, indent=2)
        print("Data saved ../data/to guest_casts.json")

        print(f"\nScraping complete for {len(episodes_to_process)} episodes.")