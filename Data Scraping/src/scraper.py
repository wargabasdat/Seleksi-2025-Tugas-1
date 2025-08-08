import json
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
from datetime import datetime
import time
import re
import traceback

# parse revenue to float
def parse_revenue(revenue_text: str) -> float:
    if not isinstance(revenue_text, str):
        return 0.0
    
    revenue_text = revenue_text.strip().upper().replace('$','').replace(',', '')
    multiplier = 1.0

    if revenue_text in ["-", "N/A", "None", ""]:
        return 0.0

    if revenue_text.endswith('B'):
        multiplier = 1e9
        revenue_text = revenue_text[:-1]
    elif revenue_text.endswith('M'):
        multiplier = 1e6
        revenue_text = revenue_text[:-1]
    elif revenue_text.endswith('K'):
        multiplier = 1e3
        revenue_text = revenue_text[:-1]
    
    try:
        cleaned = re.sub(r'[^\d.]', '', revenue_text)
        if not cleaned:
            return 0.0
        value = float(cleaned)
        return value * multiplier
    except (ValueError, TypeError):
        return 0.0
    

# parse trend to up, down, stable, and new from svg
def parse_trend(row):
    try:
        up_svg = row.find_elements(By.CSS_SELECTOR, "svg.lucide.lucide-arrow-up")
        down_svg = row.find_elements(By.CSS_SELECTOR, "svg.lucide.lucide-arrow-down")
        stable_svg = row.find_elements(By.CSS_SELECTOR, "svg.lucide.lucide-minus")

        row_text = row.text
        if "NEW" in row.text:
            return {"direction": "new","value": None}
        
        # searching for <span> beside the up and down svg for the value of the trend
        if up_svg:
            try: # look for span that in the same div as the svg
                up_svg_element = up_svg[0]
                parent = up_svg_element.find_element(By.XPATH, "..")
                spans_in_parent = parent.find_elements(By.CSS_SELECTOR, "span")
                for span in spans_in_parent:
                    span_text = span.text.strip()
                    if span_text.isdigit():
                        value = int(span_text)
                        return {"direction": "up", "value": value}
            except Exception as e:
                return {"direction": "up", "value": None}
            
        elif down_svg:
            try: # look for span that in the same div as the svg
                down_svg_element = down_svg[0]
                parent = down_svg_element.find_element(By.XPATH, "..")
                spans_in_parent = parent.find_elements(By.CSS_SELECTOR, "span")
                for span in spans_in_parent:
                    span_text = span.text.strip()
                    if span_text.isdigit():
                        value = int(span_text)
                        return {"direction": "down", "value": value}
            except Exception as e:
                return {"direction": "down", "value": None}
        elif stable_svg:
            return {"direction": "stable", "value": None}
        else: # no svg for trend found
            return {"direction": "stable", "value": None}
    except Exception as e:
        return {"direction": "stable", "value": None}

# click previous month button
def month_navigation(driver):
    try:
        print("Navigate to previous month...")
        prev_svg = driver.find_element(By.CSS_SELECTOR, "svg.lucide.lucide-chevron-left")
        if prev_svg:
            parent_button = prev_svg.find_element(By.XPATH, "..")
            if parent_button.tag_name.lower() == 'button':
                driver.execute_script("arguments[0].click();", parent_button)
            else:
                driver.execute_script("arguments[0].click();", prev_svg)
            time.sleep(3)
            return True
    except Exception as e:
        print(f"Error navigating to previous month: {e}")
        return False

# click split button
def region_navigation(driver):
    try:
        print("Navigate to all region...")
        split_svg = driver.find_element(By.CSS_SELECTOR, "svg.lucide.lucide-split")
        if split_svg:
            parent_button = split_svg.find_element(By.XPATH, "..")
            if parent_button.tag_name.lower() == 'button':
                driver.execute_script("arguments[0].click();", parent_button)
            else:
                driver.execute_script("arguments[0].click();", split_svg)
            time.sleep(3)
            return True
    except Exception as e:
        print(f"Error navigating to all region: {e}")
        return False

# extract data for a specific month
def extract_data(driver, month_name):
    print(f"extracting data for {month_name}")
    month_data = {}
    try:
        time.sleep(3)
        rows = driver.find_elements(By.CSS_SELECTOR, "table tbody tr")
        if not rows:
            rows = driver.find_elements(By.CSS_SELECTOR, "table tr")
        # print(f"found {len(rows)} rows in the table.")

        # limit processing for large dataset
        max_rows_per_batch = 20
        batch_delay = 1

        for i, row in enumerate(rows):
            try:
                if i>0 and i%max_rows_per_batch == 0:
                    time.sleep(batch_delay)
                row_text = row.text.strip()
                if not row_text:
                    continue

                lines = row_text.split('\n')
                if len(lines)<3:
                    print(f"Skipping row {i} due to insufficient data: {row_text}")
                    continue
            
                rank = None
                trend_info = {"direction": "stable", "value": None}
                revenue_value = 0.0
                revenue_text = ""
                game_name = ""
                region = "GLOBAL"
                
                # get rank
                if lines[0].strip().isdigit():
                    rank = int(lines[0].strip())
                
                # get trend
                trend_info = parse_trend(row)
                
                #  get game name and region
                line_idx = 2
                known_regions = ["GLOBAL", "CN", "KR", "JP", "US", "HK", "TW", "MO", "COMBINED"]

                while line_idx<len(lines):
                    current_line = lines[line_idx].strip()
                    # get region
                    if current_line in known_regions:
                        region = current_line
                        line_idx += 1
                        continue
                    # get revenue data (skip)
                    if '$' in current_line:
                        line_idx += 1
                        continue
                    # get game name
                    if (len(current_line)>1 and any(char.isalpha() for char in current_line) and current_line not in known_regions and not current_line.isdigit()):
                        if not game_name:
                            game_name = current_line
                        line_idx += 1
                        continue
                    line_idx += 1

                # game name still not found = extract from cell
                if not game_name:
                    try:
                        cells = row.find_elements(By.CSS_SELECTOR, "td")
                        for j, cell in enumerate(cells):
                            cell_text = cell.text.strip()
                            # Skip rank, trend, and revenue cells
                            if (cell_text.isdigit() or '$' in cell_text or cell_text in known_regions):
                                continue
                            # Look for game name
                            if (len(cell_text) > 2 and any(char.isalpha() for char in cell_text) and cell_text not in known_regions):
                                game_name = cell_text
                                break
                    except Exception as e:
                        print("Error extracting game name from cells: " + str(e))
                
                # clean game name from region or newline
                if game_name:
                    for region_name in known_regions:
                        if game_name.endswith(f"\n{region_name}"):
                            game_name = game_name.replace(f"\n{region_name}","")
                        elif game_name.endswith(region_name):
                            game_name = game_name.replace(region_name,"")
                    game_name = game_name.strip()
                
                # parse revenue
                revenue_amounts = []
                for line in lines:
                    if '$' in line:
                        amounts = re.findall(r'\$[\d,]+(?:\.\d{2})?', line)
                        revenue_amounts.extend(amounts)

                if revenue_amounts:
                    revenue_text = revenue_amounts[-1]
                    revenue_value = parse_revenue(revenue_text)
                else:
                    revenue_text = "N/A"
                    revenue_value = 0.0
                
                if not game_name:
                    game_name = f"Game_{i+1}_{month_name}"
                if len(game_name) < 2: # invalid game name
                    continue

                game_key = f"{game_name}_{region}"
                month_data[game_key] = {
                    "game_name": game_name,
                    "region": region,
                    "rank": rank,
                    "trend": trend_info,
                    "revenue": {
                        "raw_text": revenue_text,
                        "value": revenue_value
                    }
                }
            except Exception as e:
                print(f"Error processing row {i}: {e}")
                continue
    except Exception as e:
        print(f"Error during extracting data in {month_name}: {e}")
        traceback.print_exc()
    return month_data

def scraper() -> list:
    print("Startting scraper...")
    chrome_options = Options()
    chrome_options.add_argument("--no-sandbox")
    chrome_options.add_argument("--disable-dev-shm-usage")
    chrome_options.add_argument("--disable-gpu")
    chrome_options.add_argument("--window-size=1920,1080")
    chrome_options.add_argument("--disable-logging")
    chrome_options.add_argument("--disable-extensions")
    chrome_options.add_argument("--disable-web-security")
    chrome_options.add_argument("--disable-features=VizDisplayCompositor")
    chrome_options.add_argument("--log-level=3")  # Only fatal errors
    chrome_options.add_experimental_option('excludeSwitches', ['enable-logging'])
    chrome_options.add_experimental_option('useAutomationExtension', False)

    user_agent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) 13523026@std.stei.itb.ac.id"
    chrome_options.add_argument(f"--user-agent={user_agent}")

    driver = webdriver.Chrome(options=chrome_options)

    try:
        # load page
        page_url = "https://revenue.ennead.cc/revenue"
        driver.get(page_url)
        print("Page loaded...")
        time.sleep(10)

        # change table first
        if region_navigation(driver):
            print("Change mode successfully.")
            time.sleep(5)
        else:
            print("Failed to change mode.")
        
        games_data = {}
        months = ["Jul_2025", "Jun_2025", "May_2025","Apr_2025", "Mar_2025", "Feb_2025", "Jan_2025"]

        # extract data per month
        for month_idx, month_name in enumerate(months):
            if month_idx>0:
                time.sleep(3)
            
            # extract revenue from specific month
            month_data = extract_data(driver, month_name)

            # checking if the game already in dictionary
            for game_key, game_info in month_data.items():
                game_name = game_info["game_name"]
                region = game_info["region"]
                # update dictionary if exists
                if game_key in games_data:
                    games_data[game_key]["monthly_revenue"][month_name] = {
                        "raw_text": game_info["revenue"]["raw_text"],
                        "value": game_info["revenue"]["value"],
                        "rank": game_info["rank"],
                        "trend": game_info["trend"]
                    }
                else: # adding new game to dictionary
                    games_data[game_key] = {
                        "game_name": game_name,
                        "region_name": region,
                        "monthly_revenue": {
                            "Jan_2025": { "raw_text": "N/A", "value": 0.0, "rank": None, "trend": {"direction":"stable", "value":None}},
                            "Feb_2025": { "raw_text": "N/A", "value": 0.0, "rank": None, "trend": {"direction":"stable", "value":None}},
                            "Mar_2025": { "raw_text": "N/A", "value": 0.0, "rank": None, "trend": {"direction":"stable", "value":None}},
                            "Apr_2025": { "raw_text": "N/A", "value": 0.0, "rank": None, "trend": {"direction":"stable", "value":None}},
                            "May_2025": { "raw_text": "N/A", "value": 0.0, "rank": None, "trend": {"direction":"stable", "value":None}},
                            "Jun_2025": { "raw_text": "N/A", "value": 0.0, "rank": None, "trend": {"direction":"stable", "value":None}},
                            "Jul_2025": { "raw_text": "N/A", "value": 0.0, "rank": None, "trend": {"direction":"stable", "value":None}}
                        },
                        "currency": "USD",
                        "data_source": "https://revenue.ennead.cc/revenue",
                        "scraped_at": datetime.now().isoformat() + "Z"
                    }
                    # change this month data
                    games_data[game_key]["monthly_revenue"][month_name] ={
                        "raw_text": game_info["revenue"]["raw_text"],
                        "value": game_info["revenue"]["value"],
                        "rank": game_info["rank"],
                        "trend": game_info["trend"]
                    }
            if month_idx<len(months)-1:
                if not month_navigation(driver):
                    break
                time.sleep(4)
        time.sleep(2)

        final_games = list(games_data.values())
        print("successfully extracted game data.")
        return final_games
    except Exception as e:
        print(f"error occured:{e}")
        return []
    finally:
        driver.quit()
        


# saving to seperated json
def save_to_json(data, timestamp):
    # initialization
    games_data = []
    regions_data = []
    revenue_data = []
    metadata_data = []

    regions = {}
    region_counter = 1
    games = {}
    games_counter = 1

    for game in data:
        game_name = game["game_name"]
        region_name = game["region_name"]

        if region_name not in regions:
            regions[region_name] = region_counter
            regions_data.append({
                "region_id": region_counter,
                "region_name": region_name,
            })
            region_counter += 1
        region_id = regions[region_name]

        if game_name not in games:
            games[game_name] = games_counter
            games_data.append({
                "game_id" : games_counter,
                "game_name": game_name
            })
            games_counter += 1
        game_id = games[game_name]

        monthly_revenue = game.get("monthly_revenue", {})
        for month, revenue_info in monthly_revenue.items():
            if revenue_info.get("value",0) > 0 or revenue_info.get("rank") is not None or revenue_info.get("raw_text")!="N/A":
                revenue_data.append({
                    "revenue_id": len(revenue_data) + 1,
                    "game_id": game_id,
                    "region_id": region_id,
                    "month": month,
                    "revenue_text": revenue_info.get("raw_text", "N/A"),
                    "revenue_value": revenue_info.get("value", 0),
                    "rank": revenue_info.get("rank"),
                    "trend_direction": revenue_info.get("trend",{}).get("direction", "stable"),
                    "trend_value": revenue_info.get("trend",{}).get("value"),
                    "currency": game.get("currency", "USD"),
                    "scraped_at": game.get("scraped_at", "")
                })
        
    metadata_data.append({
        "scraped_at": datetime.now().isoformat(),
        "source_url": "https://revenue.ennead.cc/revenue",
        "total_games": len(games_data),
        "total_regions": len(regions_data),
        "total_revenue_records": len(revenue_data),
        "months_extracted": ["Jan_2025", "Feb_2025", "Mar_2025", "Apr_2025", "May_2025", "Jun_2025", "Jul_2025"],
        "files_created": ["games.json", "regions.json", "revenue.json", "metadata.json"]
    })

    files_saved=[]

    # save data to different json
    games_file = "../data/games.json"
    with open(games_file, 'w', encoding='utf-8') as f:
        json.dump(games_data, f, indent=4, ensure_ascii=False)
    files_saved.append(games_file)
    print("saved games data to json")

    regions_file = "../data/regions.json"
    with open(regions_file, 'w', encoding='utf-8') as f:
        json.dump(regions_data, f, indent=4, ensure_ascii=False)
    files_saved.append(regions_file)
    print("saved regions data to json")

    revenue_file = "../data/revenue.json"
    with open(revenue_file, 'w', encoding='utf-8') as f:
        json.dump(revenue_data, f, indent=4, ensure_ascii=False)
    files_saved.append(revenue_file)
    print("saved revenue data to json")

    metadata_file = "../data/metadata.json"
    with open(metadata_file, 'w', encoding='utf-8') as f:
        json.dump(metadata_data, f, indent=4, ensure_ascii=False)
    files_saved.append(metadata_file)
    print("saved metadata data to json")

    return files_saved

if __name__ == "__main__":
    scraped_data = scraper()
    if scraped_data:
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        saved_files = save_to_json(scraped_data, timestamp)
        print("Scraped data saved to the following files:")
        for file in saved_files:
            print(f" - {file}")
    else:
        print("No data scraped.")
