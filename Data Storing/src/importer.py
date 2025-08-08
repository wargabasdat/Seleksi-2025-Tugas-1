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

        for i, revenue in enumerate(revenue_data):
            try:
                cursor.execute(
                    """INSERT IGNORE INTO revenue (revenue_id, game_id, region_id, month, revenue_text, revenue_value, rank_position, trend_direction, trend_value, currency, scraped_at) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)""",
                    (revenue['revenue_id'], revenue['game_id'], revenue['region_id'], revenue['month'], revenue['revenue_text'], revenue['revenue_value'], revenue.get('rank'), revenue.get('trend_direction','stable'), revenue.get('trend_value'), revenue.get('currency','USD'), revenue.get('scraped_at'))
                )
            except mysql.connector.Error as err:
                print(f"Error inserting revenue data at index {i}: {err}")
                continue
        # for revenue in revenue_data:
        #     cursor.execute(
        #         "INSERT IGNORE INTO revenue (revenue_id, game_id, region_id, month, revenue_text, revenue_value, rank_position, trend_direction, trend_value, currency, scraped_at) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)",
        #         (revenue['revenue_id'], revenue['game_id'], revenue['region_id'], revenue['month'], revenue['revenue_text'], revenue['revenue_value'], revenue['rank'], revenue['trend_direction'], revenue['trend_value'], revenue['currency'], revenue['scraped_at'])
        #     )

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