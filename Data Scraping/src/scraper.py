import requests
from bs4 import BeautifulSoup
import json
import time

# ep related data blm bisa but udh get the proper link

def scrape_master_list_with_links():
    url = "https://epguides.com/NCIS/"
    headers = {'User-Agent': 'Mozilla/5.0'}
    
    try:
        response = requests.get(url, headers=headers)
        response.raise_for_status()
    except requests.exceptions.RequestException as e:
        print(f"Error fetching base URL: {e}")
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
                    continue # skip if no link

                season, episode_in_season = map(int, cells[1].text.strip().split('-'))
                
                episode_data = {
                    "overall_episode_number": int(cells[0].text.strip().replace('.', '')), # for unique id
                    "season": season,
                    "episode_in_season": episode_in_season,
                    "air_date": cells[2].text.strip(),
                    "title": title_tag.text.strip(),
                    "tvmaze_detail_url": title_tag['href']
                }
                all_episodes_stubs.append(episode_data)
            except (ValueError, IndexError, AttributeError) as e:
                print(f"Skipping a row in episode list due to parsing error: {e}")
                continue
    return all_episodes_stubs

def get_tvmaze_details(detail_url):
    if not detail_url: return {}
    
    headers = {'User-Agent': 'Mozilla/5.0'}
    details = {}
    print(f"  -> Fetching details from: {detail_url}") # comment later on!!

    try:
        response = requests.get(detail_url, headers=headers)
        response.raise_for_status()
        time.sleep(1) 

        soup = BeautifulSoup(response.content, 'html.parser')
        
        # doesnt work yet
        details['summary'] = soup.select_one("#episode-summary").get_text(strip=True) if soup.select_one("#episode-summary") else None
        details['rating'] = float(soup.select_one(".ratings-wrapper .average-rating").text.strip()) if soup.select_one(".ratings-wrapper .average-rating") else None
        
        crew = [] # doesnt work yet
        for item in soup.select("#episode-crew-list .crew-list-item"):
            role = item.select_one(".role").text.strip().lower()
            name = item.select_one(".name").text.strip()
            crew.append({"name": name, "role": role})
        details['crew'] = crew

        cast = [] # doesnt work yet
        for item in soup.select("#episode-cast-list .cast-list-item"):
            actor = item.select_one(".person-name").text.strip()
            character = item.select_one(".character-name").text.strip()
            cast.append({"actor": actor, "character": character})
        details['cast'] = cast

    except requests.exceptions.RequestException as e:
        print(f"  -> Error scraping TVmaze details: {e}")
        
    return details

if __name__ == "__main__":
    master_list = scrape_master_list_with_links()
    
    all_episodes = []
    all_casts = []
    all_crews = []

    if master_list:
        # slice aja for testing bruh
        episodes_to_process = master_list #[:5] 

        for episode_stub in episodes_to_process:
            details = get_tvmaze_details(episode_stub.get('tvmaze_detail_url'))
            
            episode_id = episode_stub['overall_episode_number']
            
            all_episodes.append({
                "episode_id": episode_id,
                "season": episode_stub['season'],
                "episode_in_season": episode_stub['episode_in_season'],
                "title": episode_stub['title'],
                "air_date": episode_stub['air_date'],
                "summary": details.get('summary'),
                "rating": details.get('rating')
            })
            
            for crew_member in details.get('crew', []):
                all_crews.append({
                    "episode_id": episode_id,
                    "name": crew_member['name'],
                    "role": crew_member['role']
                })
            
            for cast_member in details.get('cast', []):
                all_casts.append({
                    "episode_id": episode_id,
                    "actor": cast_member['actor'],
                    "character": cast_member['character']
                })

        with open("episodes.json", 'w', encoding='utf-8') as f:
            json.dump(all_episodes, f, ensure_ascii=False, indent=2)
        print("\nData saved to episodes.json")

        with open("casts.json", 'w', encoding='utf-8') as f:
            json.dump(all_casts, f, ensure_ascii=False, indent=2)
        print("Data saved to casts.json")

        with open("crews.json", 'w', encoding='utf-8') as f:
            json.dump(all_crews, f, ensure_ascii=False, indent=2)
        print("Data saved to crews.json")
        
        print(f"\nScraping complete for {len(episodes_to_process)} episodes.")