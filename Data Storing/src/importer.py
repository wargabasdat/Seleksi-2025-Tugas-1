import os
import json
import mysql.connector
from datetime import datetime

# importing json file to db
def import_json():
    try:
        conn = mysql.connector.connect(
            host="localhost",
            user="root",
            password="",
            database="game_revenue",
            charset="utf8mb4"
        )
        cursor = conn.cursor()
    except mysql.connector.Error as err:
        print(f"Error: {err}")
        return
    try:
        path = os.path.join(os.path.dirname(__file__), '..', '..', 'Data Scraping', 'data')
        with open(os.path.join(path, 'games.json'),'r',encoding='utf-8') as f:
            games_data = json.load(f)
        with open(os.path.join(path, 'regions.json'),'r',encoding='utf-8') as f:
            regions_data = json.load(f)
        with open(os.path.join(path, 'revenue.json'),'r',encoding='utf-8') as f:
            revenue_data = json.load(f)
        
        # insert data to db
        for region in regions_data:
            cursor.execute(
                "INSERT IGNORE INTO regions (region_id, region_name) VALUES (%s, %s)",
                (region['region_id'], region['region_name'])
            )

        for game in games_data:
            cursor.execute(
                "INSERT IGNORE INTO games (game_id, game_name) VALUES (%s, %s)",
                (game['game_id'], game['game_name'])
            )
        
        game_region_pairs = set()
        successful_revenue_inserts = 0
        failed_revenue_inserts = 0
        
        for i, revenue in enumerate(revenue_data):
            try:
                game_id = revenue['game_id']
                region_id = revenue['region_id']
                pair_key = (game_id, region_id)

                if pair_key not in game_region_pairs:
                    cursor.execute(
                        "INSERT IGNORE INTO In (game_id, region_id) VALUES (%s, %s)",
                        (game_id, region_id)
                    )
                    game_region_pairs.add(pair_key)

                cursor.execute(
                    "SELECT in_id FROM In WHERE game_id = %s AND region_id = %s",
                    (game_id, region_id)
                )

                result = cursor.fetchone()
                if result:
                    in_id = result[0]
                    
                    cursor.execute("""
                        INSERT IGNORE INTO Revenue 
                        (revenue_id, in_id, month, revenue_text, revenue_value, 
                         rank_position, trend_direction, trend_value, currency, scraped_at) 
                        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
                    """, (
                        revenue['revenue_id'],
                        in_id,
                        revenue['month'],
                        revenue['revenue_text'],
                        revenue['revenue_value'],
                        revenue.get('rank'),
                        revenue.get('trend_direction', 'stable'),
                        revenue.get('trend_value'),
                        revenue.get('currency', 'USD'),
                        revenue.get('scraped_at')
                    ))
                    successful_revenue_inserts += 1
                else:
                    failed_revenue_inserts += 1
            except mysql.connector.Error as err:
                print(f"Error inserting revenue data at index {i}: {err}")
                continue

        conn.commit()
        print("Data imported successfully.")
    except Exception as e:
        conn.rollback()
        print(f"An error occurred: {e}")
    finally:
        cursor.close()
        conn.close()

if __name__ == "__main__":
    print("Starting JSON import...")
    import_json()