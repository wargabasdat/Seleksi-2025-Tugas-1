import requests
from bs4 import BeautifulSoup
import json
import time
import re
from datetime import datetime
import os
from concurrent.futures import ThreadPoolExecutor, as_completed

# scrape episode guide (master list)
def get_master_list():
    url = "https://epguides.com/NCIS/"
    headers = {
        'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36',
        'From': '13523122@std.stei.itb.ac.id'  
    }

    try:
        response = requests.get(url, headers=headers)
        response.raise_for_status()
    except requests.exceptions.RequestException as e:
        print(f"Error fetching master list: {e}")
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

                raw_date_str = cells[2].text.strip()
                if raw_date_str: 
                    date_obj = datetime.strptime(raw_date_str, "%d %b %y")
                    air_date = date_obj.strftime("%Y-%m-%d")
                else:
                    air_date = None

                season, episode_in_season = map(int, cells[1].text.strip().split('-'))
                
                episode_data = {
                    "overall_episode_number": int(cells[0].text.strip().replace('.', '')),
                    "season": season, 
                    "episode_in_season": episode_in_season,
                    "air_date": air_date, 
                    "title": title_tag.text.strip(),
                    "detail_url": title_tag['href']
                }
                all_episodes_stubs.append(episode_data)
            except (ValueError, IndexError, AttributeError):
                continue
    return all_episodes_stubs

# scrape episode details 
def get_episode_details(detail_url):
    if not detail_url: return {}
    headers = {
        'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36',
        'From': '13523122@std.stei.itb.ac.id'  
    }
    details = {}
    # print(f"   Fetching episode details from: {detail_url}")
    try:
        response = requests.get(detail_url, headers=headers)
        response.raise_for_status()
        time.sleep(1)
        soup = BeautifulSoup(response.content, 'html.parser')
        details['summary'] = soup.select_one("section#general-information article p").get_text(strip=True) if soup.select_one("section#general-information article p") else None
        details['rating_value'] = float(soup.select_one('[itemprop="ratingValue"]').text.strip()) if soup.select_one('[itemprop="ratingValue"]') else None
        details['rating_count'] = int(soup.select_one('[itemprop="ratingCount"]').text.strip()) if soup.select_one('[itemprop="ratingCount"]') else None
        
        comments = []
        comment_id_counter = 1
        for comment_article in soup.select("article.comment"):
            username = comment_article.select_one("span.username a").text.strip() if comment_article.select_one("span.username a") else None
            
            # handle content extraction
            content_container = comment_article.select_one(".content.rendered-content")
            if content_container:
                paragraphs = [p.get_text(strip=True) for p in content_container.find_all('p')]
                content = ' '.join(paragraphs)
            else:
                content = None
            
            upvote_tag = comment_article.select_one(".upvote-vote")
            downvote_tag = comment_article.select_one(".downvote-vote")

            # handle no upvotes or downvotes
            upvote_text = upvote_tag.text.strip() if upvote_tag else '0'
            upvote_count = 0 if upvote_text == '|' else int(upvote_text)

            downvote_text = downvote_tag.text.strip() if downvote_tag else '0'
            downvote_count = 0 if downvote_text == '|' else int(downvote_text)

            if username and content:
                comments.append({
                    "comment_number": comment_id_counter,
                    "username": username,
                    "content": content,
                    "upvote_count": upvote_count,
                    "downvote_count": downvote_count
                })
                comment_id_counter += 1
        details['comments'] = comments

    except requests.exceptions.RequestException as e:
        print(f"Error scraping episode details: {e}")
    return details

# scrape people involved in the episode (cast n crew)
def get_people_involved(url, person_type, status):
    if not url: return []
    headers = {
        'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36',
        'From': '13523122@std.stei.itb.ac.id'
    }
    people_list = []
    # print(f"   Fetching {status.lower()} {person_type} from: {url}")
    try:
        response = requests.get(url, headers=headers)
        response.raise_for_status()
        time.sleep(1)

        soup = BeautifulSoup(response.content, 'html.parser')

        for person_box in soup.select('article.grid-x.personbox'):
            name_tag = person_box.select_one('h2 > a')
            if not name_tag: continue

            name = name_tag.text.strip()
            person_data = {}

            if person_type == 'cast':
                character_tag = person_box.select_one("a[href*='/characters/']")
                if character_tag:
                    raw_character = character_tag.text.strip()
                    cleaned_character = re.sub(r' \"[^"]*\"', '', raw_character)
                    person_data = {"actor": name, "character": cleaned_character, "status": status}
            
            elif person_type == 'crew':
                role_container = person_box.select_one('div.auto.cell')
                if role_container:
                    full_text = role_container.get_text(separator=' ', strip=True)
                    role = full_text.replace(name, '').replace('as', '').strip()
                    person_data = {"name": name, "role": role, "status": status}

            if person_data:
                people_list.append(person_data)

    except requests.exceptions.RequestException as e:
        print(f"Error scraping {person_type}: {e}")
    return people_list

# process a single episode stub
def process_single_episode(episode_stub):
    episode_id = episode_stub['overall_episode_number']
    detail_url = episode_stub.get('detail_url')
    
    main_details = get_episode_details(detail_url)
    
    guest_cast_list = get_people_involved(detail_url + "/cast", 'cast', 'Guest')
    main_cast_list = get_people_involved(detail_url + "/castappearances", 'cast', 'Main')
    guest_crew_list = get_people_involved(detail_url + "/crew", 'crew', 'Guest')
    main_crew_list = get_people_involved(detail_url + "/crewappearances", 'crew', 'Main')

    episode_data = {
        "episode_id": episode_id, "season": episode_stub['season'],
        "episode_in_season": episode_stub['episode_in_season'], "title": episode_stub['title'],
        "air_date": episode_stub['air_date'], "summary": main_details.get('summary'),
        "rating_value": main_details.get('rating_value'), "rating_count": main_details.get('rating_count')
    }
    
    cast_data = []
    combined_cast = main_cast_list + guest_cast_list
    for cast_member in combined_cast:
        cast_data.append({
            "episode_id": episode_id, "actor": cast_member['actor'], 
            "character": cast_member['character'], "status": cast_member['status']
        })

    crew_data = []
    combined_crew = main_crew_list + guest_crew_list
    for crew_member in combined_crew:
        crew_data.append({
            "episode_id": episode_id, "name": crew_member['name'], 
            "role": crew_member['role'], "status": crew_member['status']
        })
    
    comment_data = []
    for comment in main_details.get('comments', []):
        reordered_comment = {
            "episode_id": episode_id,
            "comment_number": comment.get('comment_number'),
            "username": comment.get('username'),
            "content": comment.get('content'),
            "upvote_count": comment.get('upvote_count'),
            "downvote_count": comment.get('downvote_count')
        }
        comment_data.append(reordered_comment)
        
    return episode_data, cast_data, crew_data, comment_data

if __name__ == "__main__":
    master_list = get_master_list()
    
    all_episodes, all_casts, all_crews, all_comments = [], [], [], []

    if master_list:
        episodes_to_process = master_list
        # episodes_to_process = master_list[:5] 
        total_episodes = len(episodes_to_process)
        total_seasons = episodes_to_process[-1]['season'] if episodes_to_process else 0
        print(f"Processing {total_seasons} seasons ({total_episodes} episodes)...")

        # multithreading to speed up the scraping
        with ThreadPoolExecutor(max_workers=5) as executor: 
            future_to_stub = {executor.submit(process_single_episode, stub): stub for stub in episodes_to_process}
            
            for i, future in enumerate(as_completed(future_to_stub)):
                try:
                    episode_data, cast_data, crew_data, comment_data = future.result()
                    all_episodes.append(episode_data)
                    all_casts.extend(cast_data)
                    all_crews.extend(crew_data)
                    all_comments.extend(comment_data)
                    
                    if (i + 1) % 30 == 0 or (i + 1) == total_episodes:
                        print(f"Processed {i+1}/{total_episodes} episodes")
                except Exception as e:
                    stub = future_to_stub[future]
                    print(f"Error processing {stub['title']}: {e}")

        all_episodes.sort(key=lambda x: x['episode_id'])
        all_casts.sort(key=lambda x: (x['episode_id'], x['status'], x['actor']))
        all_crews.sort(key=lambda x: (x['episode_id'], x['status'], x['name']))
        all_comments.sort(key=lambda x: (x['episode_id'], x.get('comment_number', 0)))

        output_dir = os.path.join("..", "data")
        if not os.path.exists(output_dir):
            os.makedirs(output_dir)

        with open(os.path.join(output_dir, "episodes.json"), 'w', encoding='utf-8') as f: json.dump(all_episodes, f, ensure_ascii=False, indent=2)
        print(f"\nData saved to {os.path.join(output_dir,'episodes.json')}")
        with open(os.path.join(output_dir, "casts.json"), 'w', encoding='utf-8') as f: json.dump(all_casts, f, ensure_ascii=False, indent=2)
        print(f"Data saved to {os.path.join(output_dir, 'casts.json')}")
        with open(os.path.join(output_dir, "crews.json"), 'w', encoding='utf-8') as f: json.dump(all_crews, f, ensure_ascii=False, indent=2)
        print(f"Data saved to {os.path.join(output_dir, 'crews.json')}")
        with open(os.path.join(output_dir, "comments.json"), 'w', encoding='utf-8') as f: json.dump(all_comments, f, ensure_ascii=False, indent=2)
        print(f"Data saved to {os.path.join(output_dir, 'comments.json')}")

        print(f"\nScraping completed for {len(episodes_to_process)} episodes.")