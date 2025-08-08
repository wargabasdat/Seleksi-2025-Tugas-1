import json, time, os
import requests
from bs4 import BeautifulSoup
import re

URL_BASE = "https://boardgamegeek.com/browse/boardgame"
HEADER = {"User-Agent": "Mozilla/5.0. ; Institute of Technology Bandung/Student/18223008@std.stei.itb.ac.id"}

class BoardGameDataSeparator:
    """Class to handle separation of scraped data into different JSON files"""
    
    def __init__(self, data_dir="../data"):
        self.data_dir = data_dir
        self.games = []
        self.designers = set()
        self.artists = set()
        self.publishers = set()
        self.categories = set()
        self.mechanisms = set()
        self.families = set()
        self.awards = set()
        self.reimplemented_games = set()
        self.geekmarket_prices = []
        
        # Ensure data directory exists
        os.makedirs(data_dir, exist_ok=True)
    
    def add_game_data(self, game_data):
        """Add game data and extract separate entities"""
        
        # Store main game data
        main_game_data = {
            'rank': game_data.get('rank'),
            'title': game_data.get('title'),
            'url': game_data.get('url'),
            'year': game_data.get('year'),
            'geek_rating': game_data.get('geek_rating'),
            'avg_rating': game_data.get('avg_rating'),
            'users_voted': game_data.get('users_voted'),
            'min_players': game_data.get('min_players'),
            'max_players': game_data.get('max_players'),
            'min_playtime': game_data.get('min_playtime'),
            'max_playtime': game_data.get('max_playtime'),
            'min_age': game_data.get('min_age'),
            'complexity': game_data.get('complexity'),
            'community_owned': game_data.get('community_owned'),
            'community_wishlist': game_data.get('community_wishlist'),
            'num_comments': game_data.get('num_comments'),
            'num_plays': game_data.get('num_plays'),
            'fans': game_data.get('fans')
        }
        self.games.append(main_game_data)
        
        # Extract separate entities
        game_id = len(self.games)  # Use position as temporary ID
        
        # Designers
        for designer in game_data.get('designers', []):
            if designer:
                self.designers.add(designer)
        
        # Artists
        for artist in game_data.get('artists', []):
            if artist:
                self.artists.add(artist)
        
        # Publishers
        for publisher in game_data.get('publishers', []):
            if publisher:
                self.publishers.add(publisher)
        
        # Categories
        for category in game_data.get('categories', []):
            if category:
                self.categories.add(category)
        
        # Mechanisms
        for mechanism in game_data.get('mechanisms', []):
            if mechanism:
                self.mechanisms.add(mechanism)
        
        # Families
        for family in game_data.get('families', []):
            if family:
                self.families.add(family)
        
        # Awards
        for award in game_data.get('awards', []):
            if award:
                self.awards.add(award)
        
        # Reimplemented games
        for reimpl in game_data.get('reimplements', []):
            if reimpl:
                self.reimplemented_games.add(reimpl)
        
        # GeekMarket prices
        for price_data in game_data.get('geekmarket_prices', []):
            if price_data:
                price_entry = price_data.copy()
                price_entry['game_rank'] = game_data.get('rank')
                price_entry['game_title'] = game_data.get('title')
                self.geekmarket_prices.append(price_entry)
    
    def save_all_files(self):
        """Save all separated data to JSON files"""
        
        # # Measure if there is any old files
        # old_files_to_remove = [
        #     f"{self.data_dir}/games.json",
        #     f"{self.data_dir}/boardgames_detailed.json"
        # ]
        # for old_file in old_files_to_remove:
        #     if os.path.exists(old_file):
        #         os.remove(old_file)
        #         print(f"   Removed old file: {os.path.basename(old_file)}")
        
        # Save main games data as boardgames.json
        with open(f"{self.data_dir}/boardgames.json", "w", encoding='utf-8') as f:
            json.dump(self.games, f, indent=2, ensure_ascii=False)
        
        # Save designers
        designers_list = [{"name": designer} for designer in sorted(self.designers)]
        with open(f"{self.data_dir}/designers.json", "w", encoding='utf-8') as f:
            json.dump(designers_list, f, indent=2, ensure_ascii=False)
        
        # Save artists
        artists_list = [{"name": artist} for artist in sorted(self.artists)]
        with open(f"{self.data_dir}/artists.json", "w", encoding='utf-8') as f:
            json.dump(artists_list, f, indent=2, ensure_ascii=False)
        
        # Save publishers
        publishers_list = [{"name": publisher} for publisher in sorted(self.publishers)]
        with open(f"{self.data_dir}/publishers.json", "w", encoding='utf-8') as f:
            json.dump(publishers_list, f, indent=2, ensure_ascii=False)
        
        # Save categories
        categories_list = [{"name": category} for category in sorted(self.categories)]
        with open(f"{self.data_dir}/categories.json", "w", encoding='utf-8') as f:
            json.dump(categories_list, f, indent=2, ensure_ascii=False)
        
        # Save mechanisms
        mechanisms_list = [{"name": mechanism} for mechanism in sorted(self.mechanisms)]
        with open(f"{self.data_dir}/mechanisms.json", "w", encoding='utf-8') as f:
            json.dump(mechanisms_list, f, indent=2, ensure_ascii=False)
        
        # Save families
        families_list = [{"name": family} for family in sorted(self.families)]
        with open(f"{self.data_dir}/families.json", "w", encoding='utf-8') as f:
            json.dump(families_list, f, indent=2, ensure_ascii=False)
        
        # Save awards
        awards_list = [{"name": award} for award in sorted(self.awards)]
        with open(f"{self.data_dir}/awards.json", "w", encoding='utf-8') as f:
            json.dump(awards_list, f, indent=2, ensure_ascii=False)
        
        # Save reimplemented games
        reimplemented_list = [{"name": reimpl} for reimpl in sorted(self.reimplemented_games)]
        with open(f"{self.data_dir}/reimplemented_games.json", "w", encoding='utf-8') as f:
            json.dump(reimplemented_list, f, indent=2, ensure_ascii=False)
        
        # Save GeekMarket prices
        with open(f"{self.data_dir}/geekmarket_prices.json", "w", encoding='utf-8') as f:
            json.dump(self.geekmarket_prices, f, indent=2, ensure_ascii=False)
        
        # Save relationship mappings
        self._save_relationship_mappings()
        
        # Print summary
        print(f"\n📁 Data saved to separate JSON files:")
        print(f"   boardgames.json: {len(self.games)} games")
        print(f"   designers.json: {len(self.designers)} designers")
        print(f"   artists.json: {len(self.artists)} artists")
        print(f"   publishers.json: {len(self.publishers)} publishers")
        print(f"   categories.json: {len(self.categories)} categories")
        print(f"   mechanisms.json: {len(self.mechanisms)} mechanisms")
        print(f"   families.json: {len(self.families)} families")
        print(f"   awards.json: {len(self.awards)} awards")
        print(f"   reimplemented_games.json: {len(self.reimplemented_games)} reimplemented games")
        print(f"   geekmarket_prices.json: {len(self.geekmarket_prices)} price entries")
    
    def _save_relationship_mappings(self):
        """Save relationship mappings for database loading"""
        
        # For helping when loading data
        relationships = {
            'game_designers': [],
            'game_artists': [],
            'game_publishers': [],
            'game_categories': [],
            'game_mechanisms': [],
            'game_families': [],
            'game_awards': [],
            'game_reimplements': []
        }
        
        # Disclaimer: this is a simplified approach. If there is the chance, storing these relationship with proper ID would be much better
        with open(f"{self.data_dir}/relationships.json", "w", encoding='utf-8') as f:
            json.dump(relationships, f, indent=2, ensure_ascii=False)

def extract_store_pricing(game_url):
    """Extract pricing information specifically from GeekMarket section"""
    try:
        print(f"[DEBUG] Extracting GeekMarket pricing from: {game_url}")
        res = requests.get(game_url, headers=HEADER)
        soup = BeautifulSoup(res.content, 'html.parser')
        
        stores = []
        page_text = res.text
        
        # Method 1: Look for GeekMarket specific patterns in the page content
        geekmarket_patterns = [
            r'GeekMarket.*?\$(\d+(?:\.\d{2})?).*?(?:condition|cond).*?(new|like new|very good|good|acceptable|poor).*?(?:from|in|location).*?([A-Z]{2,3}|\w+)',
            r'\$(\d+(?:\.\d{2})?).*?(?:condition|cond).*?(new|like new|very good|good|acceptable|poor)',
            r'marketplace.*?\$(\d+(?:\.\d{2})?)',
            r'(?:buy|sell|trade).*?\$(\d+(?:\.\d{2})?)'
        ]
        
        for pattern in geekmarket_patterns:
            matches = re.findall(pattern, page_text, re.IGNORECASE)
            for match in matches:
                if isinstance(match, tuple) and len(match) >= 2:
                    price = match[0]
                    condition = match[1] if len(match) > 1 else "Unknown"
                    location = match[2] if len(match) > 2 else "Unknown"
                    
                    try:
                        price_float = float(price)
                        if 5 <= price_float <= 500:
                            stores.append({
                                "store": "GeekMarket",
                                "price": price,
                                "currency": "USD",
                                "condition": condition.title(),
                                "location": location
                            })
                    except:
                        continue
                elif isinstance(match, str):
                    try:
                        price_float = float(match)
                        if 5 <= price_float <= 500:
                            stores.append({
                                "store": "GeekMarket",
                                "price": match,
                                "currency": "USD"
                            })
                    except:
                        continue
        
        # Method 2: Look for specific GeekMarket API endpoints or data
        game_id_match = re.search(r'/boardgame/(\d+)/', game_url)
        if game_id_match:
            game_id = game_id_match.group(1)
            
            # Try different GeekMarket API endpoints
            geekmarket_endpoints = [
                f"https://boardgamegeek.com/geekmarket/browse?objecttype=thing&objectid={game_id}",
                f"https://boardgamegeek.com/api/geekmarket/{game_id}",
                f"https://boardgamegeek.com/xmlapi2/thing?id={game_id}&marketplace=1"
            ]
            
            for endpoint in geekmarket_endpoints:
                try:
                    market_res = requests.get(endpoint, headers=HEADER, timeout=10)
                    if market_res.status_code == 200:
                        market_text = market_res.text
                        
                        # Look for price patterns in the API/page response
                        price_patterns = [
                            r'price["\']?\s*:\s*["\']?\$?(\d+(?:\.\d{2})?)',
                            r'amount["\']?\s*:\s*["\']?\$?(\d+(?:\.\d{2})?)',
                            r'cost["\']?\s*:\s*["\']?\$?(\d+(?:\.\d{2})?)',
                            r'\$(\d+(?:\.\d{2})?)'
                        ]
                        
                        for pattern in price_patterns:
                            api_prices = re.findall(pattern, market_text)
                            for price in api_prices:
                                try:
                                    price_float = float(price)
                                    if 5 <= price_float <= 500:
                                        stores.append({
                                            "store": "GeekMarket API",
                                            "price": price,
                                            "currency": "USD"
                                        })
                                        break  # Only take first valid price from each endpoint
                                except:
                                    continue
                            if stores:  # If we found prices, no need to try other endpoints
                                break
                except:
                    continue
        
        # Method 3: Look for marketplace/geekmarket sections in the HTML structure
        marketplace_sections = soup.find_all(['div', 'section'], 
                                           class_=lambda x: x and any(word in str(x).lower() 
                                                                     for word in ['market', 'marketplace', 'geekmarket']))
        
        for section in marketplace_sections:
            section_text = section.get_text()
            # Look for prices in marketplace sections
            prices = re.findall(r'\$(\d+(?:\.\d{2})?)', section_text)
            for price in prices:
                try:
                    price_float = float(price)
                    if 5 <= price_float <= 500:
                        stores.append({
                            "store": "GeekMarket Section",
                            "price": price,
                            "currency": "USD"
                        })
                except:
                    continue
        
        # Method 4: Look for embedded marketplace data in JavaScript
        marketplace_js_patterns = [
            r'geekmarket.*?price.*?(\d+(?:\.\d{2})?)',
            r'marketplace.*?price.*?(\d+(?:\.\d{2})?)',
            r'"marketplace".*?"price".*?(\d+(?:\.\d{2})?)',
            r'market.*?data.*?\$(\d+(?:\.\d{2})?)'
        ]
        
        for pattern in marketplace_js_patterns:
            js_matches = re.findall(pattern, page_text, re.IGNORECASE)
            for price in js_matches:
                try:
                    price_float = float(price)
                    if 5 <= price_float <= 500:
                        stores.append({
                            "store": "GeekMarket JS",
                            "price": price,
                            "currency": "USD"
                        })
                except:
                    continue
        
        # Method 5: If no specific GeekMarket data found, look for general pricing in buy/sell context
        if not stores:
            buy_sell_patterns = [
                r'(?:for sale|selling|trade).*?\$(\d+(?:\.\d{2})?)',
                r'(?:price|cost|asking).*?\$(\d+(?:\.\d{2})?)',
                r'buy.*?it.*?now.*?\$(\d+(?:\.\d{2})?)'
            ]
            
            for pattern in buy_sell_patterns:
                matches = re.findall(pattern, page_text, re.IGNORECASE)
                for price in matches:
                    try:
                        price_float = float(price)
                        if 5 <= price_float <= 500:
                            stores.append({
                                "store": "Community Marketplace",
                                "price": price,
                                "currency": "USD"
                            })
                    except:
                        continue
        
        # Remove duplicates based on price and store combination
        unique_stores = []
        seen = set()
        for store in stores:
            store_key = (store.get('store', ''), store.get('price', ''))
            if store_key not in seen and store.get('price'):
                seen.add(store_key)
                unique_stores.append(store)
        
        try:
            unique_stores.sort(key=lambda x: float(x.get('price', 999)))
        except:
            pass
        
        return unique_stores[:5]
        
    except Exception as e:
        print(f"[ERROR] Failed to extract GeekMarket pricing from {game_url}: {str(e)}")
        return []

def extract_detailed_game_info(game_url):
    """Extract detailed information from a specific board game page"""
    try:
        print(f"[DEBUG] Fetching details from: {game_url}")
        res = requests.get(game_url, headers=HEADER)
        soup = BeautifulSoup(res.content, 'html.parser')
        
        detailed_info = {}
        page_text = res.text
        
        # Extract the GEEK.geekitemPreload object from JavaScript
        geek_data_match = re.search(r'GEEK\.geekitemPreload\s*=\s*({.*?});', page_text, re.DOTALL)
        if geek_data_match:
            try:
                import json
                geek_data = json.loads(geek_data_match.group(1))
                item_data = geek_data.get('item', {})
                
                # Extract basic game info
                detailed_info['min_players'] = int(item_data.get('minplayers', 0)) if item_data.get('minplayers') else None
                detailed_info['max_players'] = int(item_data.get('maxplayers', 0)) if item_data.get('maxplayers') else None
                detailed_info['min_playtime'] = int(item_data.get('minplaytime', 0)) if item_data.get('minplaytime') else None
                detailed_info['max_playtime'] = int(item_data.get('maxplaytime', 0)) if item_data.get('maxplaytime') else None
                detailed_info['min_age'] = int(item_data.get('minage', 0)) if item_data.get('minage') else None
                
                # Extract weight/complexity from polls
                polls = item_data.get('polls', {})
                weight_data = polls.get('boardgameweight', {})
                if weight_data and 'averageweight' in weight_data:
                    detailed_info['complexity'] = round(float(weight_data['averageweight']), 2)
                
                # Extract designers, artists, publishers from links
                links = item_data.get('links', {})
                
                designers = []
                for designer in links.get('boardgamedesigner', []):
                    designers.append(designer['name'])
                detailed_info['designers'] = designers
                
                artists = []
                for artist in links.get('boardgameartist', []):
                    artists.append(artist['name'])
                detailed_info['artists'] = artists
                
                publishers = []
                for publisher in links.get('boardgamepublisher', []):
                    publishers.append(publisher['name'])
                detailed_info['publishers'] = publishers
                
                # Extract categories
                categories = []
                for category in links.get('boardgamecategory', []):
                    categories.append(category['name'])
                detailed_info['categories'] = categories
                
                # Extract mechanisms
                mechanisms = []
                for mechanism in links.get('boardgamemechanic', []):
                    mechanisms.append(mechanism['name'])
                detailed_info['mechanisms'] = mechanisms
                
                # Extract families
                families = []
                for family in links.get('boardgamefamily', []):
                    families.append(family['name'])
                detailed_info['families'] = families
                
                # Extract awards/honors
                awards = []
                for award in links.get('boardgamehonor', []):
                    awards.append(award['name'])
                detailed_info['awards'] = awards
                
                # Extract reimplements
                reimplements = []
                for reimpl in links.get('reimplements', []):
                    reimplements.append(reimpl['name'])
                detailed_info['reimplements'] = reimplements
                
                # Extract community stats
                stats = item_data.get('stats', {})
                detailed_info['community_owned'] = int(stats.get('numowned', 0))
                detailed_info['community_wishlist'] = int(stats.get('numwish', 0))
                detailed_info['num_comments'] = int(stats.get('numcomments', 0))
                detailed_info['num_plays'] = int(stats.get('numplays', 0))
                detailed_info['fans'] = int(stats.get('numfans', 0))
                
                # Extract GeekMarket pricing information
                detailed_info['geekmarket_prices'] = extract_store_pricing(game_url)
                

                
            except json.JSONDecodeError as e:
                print(f"[ERROR] Failed to parse JSON data: {e}")
        
        time.sleep(1)  # So that the server is not overloaded
        return detailed_info
        
    except Exception as e:
        print(f"[ERROR] Failed to extract details from {game_url}: {str(e)}")
        return {}

def scrape_main(page=1, extract_details=False):
    url = f"{URL_BASE}/page/{page}"
    res = requests.get(url, headers=HEADER)
    soup = BeautifulSoup(res.content, 'html.parser')
    games = []

    print(f"[DEBUG] Scraping URL: {url}")
    print(f"[DEBUG] Response code: {res.status_code}")

    rows = soup.select("table#collectionitems tr[id*='row_']")
    print(f"[DEBUG] Found {len(rows)} game rows")

    for i, row in enumerate(rows, 1): 
        game_title = row.select_one("td.collection_objectname a.primary")
        if not game_title:
            continue
            
        rank_element = row.select_one("td.collection_rank")
        if not rank_element:
            continue
        rank = rank_element.text.strip().replace('.', '')
        
        ratings = row.select("td.collection_bggrating")
        if len(ratings) >= 3:
            geek_rating = ratings[0].text.strip()
            avg_rating = ratings[1].text.strip()
            voters = ratings[2].text.strip()
        else:
            continue

        year_published = row.select_one("span.smallerfont")
        year = int(year_published.text.strip("()")) if year_published else None

        game_data = {
            "rank": int(rank),
            "title": game_title.text,
            "url": f"https://boardgamegeek.com{game_title['href']}",
            "year": year,
            "geek_rating": float(geek_rating),
            "avg_rating": float(avg_rating),
            "users_voted": int(voters.replace(',', ''))
        }
        
        # Extract detailed information if requested
        if extract_details:
            print(f"[INFO] Extracting details for game {i}/{len(rows)}: {game_title.text}")
            detailed_info = extract_detailed_game_info(game_data["url"])
            game_data.update(detailed_info)
            
            # Remove unwanted fields from the final output
            fields_to_remove = ['bgg_rank', 'strategy_rank', 'average_rating', 'bayes_average', 'num_ratings', 'stddev']
            for field in fields_to_remove:
                if field in game_data:
                    del game_data[field]
        
        games.append(game_data)
    return games

def scrape_multiple_pages(start_page=1, end_page=1, extract_details=False):
    """Scrape multiple pages of board games"""
    all_games = []
    
    for page in range(start_page, end_page + 1):
        print(f"[INFO] Scraping page {page}")
        games = scrape_main(page=page, extract_details=extract_details)
        all_games.extend(games)
        
        if page < end_page:
            time.sleep(2)
    
    return all_games

if __name__ == "__main__":
    # Configuration
    extract_detailed_info = True
    start_page = 1
    end_page = 1
    
    # Initialize data separator
    data_separator = BoardGameDataSeparator()
    
    # Scrape the specified pages
    if start_page == end_page:
        result = scrape_main(page=start_page, extract_details=extract_detailed_info)
    else:
        result = scrape_multiple_pages(start_page=start_page, end_page=end_page, extract_details=extract_detailed_info)
    
    # Process each game and separate data
    for game_data in result:
        data_separator.add_game_data(game_data)
    
    # Save all separated data files
    data_separator.save_all_files()
    
    print(f"\n Scraped {len(result)} games and saved to separate JSON files")
    print(" Files created in ../data/ folder:")
    print("   - boardgames.json (main game data with full details)")
    print("   - designers.json, artists.json, publishers.json")
    print("   - categories.json, mechanisms.json, families.json")
    print("   - awards.json, reimplemented_games.json")
    print("   - geekmarket_prices.json")