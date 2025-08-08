import psycopg2
import json
import re

def create_database():
    try:
        conn = psycopg2.connect(
            host="localhost",
            database="postgres", 
            user="postgres",
            password="12345678"
        )
        conn.autocommit = True
        cursor = conn.cursor()
        
        # cek DB udah ada apa blm
        cursor.execute("SELECT 1 FROM pg_catalog.pg_database WHERE datname = 'sanrio_db'")
        exists = cursor.fetchone()
        
        if not exists:
            cursor.execute("CREATE DATABASE sanrio_db")
        else:
            print("DB exists")
            
        cursor.close()
        conn.close()
        return True
        
    except Exception as e:
        print(f"error creating DB: {e}")
        return False
    
def connect_to_db():
    try:
        conn = psycopg2.connect(
            host="localhost",      
            database="sanrio_db",  
            user="postgres",       
            password= "12345678"
        )
        conn.set_client_encoding('UTF8')
        return conn
    
    except Exception as e:
        print(f"error connecting to DB: {e}")
        return None
    
def create_tables(conn):
    cursor = conn.cursor()
    
    # characters
    cursor.execute('''
    CREATE TABLE IF NOT EXISTS characters (
        character_id SERIAL PRIMARY KEY,
        name VARCHAR(100) UNIQUE NOT NULL,
        description TEXT
    )
    ''')
    
    # friends
    cursor.execute('''
    CREATE TABLE IF NOT EXISTS friends (
        friend_id SERIAL PRIMARY KEY,
        character_id INTEGER REFERENCES characters(character_id),
        friend_name TEXT
    )
    ''')

    # overall_rankings
    cursor.execute('''
    CREATE TABLE IF NOT EXISTS overall_rankings (
        overall_rank_id SERIAL PRIMARY KEY,
        character_id INTEGER REFERENCES characters(character_id),
        rank INTEGER NOT NULL,
        profile_link TEXT,
        rank_category VARCHAR(10) NOT NULL  -- 'high' or 'low'
    )
    ''')
    
    # high_rank_ov
    cursor.execute('''
    CREATE TABLE IF NOT EXISTS high_rank_ov (
        high_rank_id SERIAL PRIMARY KEY,
        vote_count VARCHAR(20),
        comment TEXT,
        FOREIGN KEY (high_rank_id) REFERENCES overall_rankings(overall_rank_id)
    )
    ''')

    # low_rank_ov
    cursor.execute('''
    CREATE TABLE IF NOT EXISTS low_rank_ov (
        low_rank_id SERIAL PRIMARY KEY,
        FOREIGN KEY (low_rank_id) REFERENCES overall_rankings(overall_rank_id)
    )
    ''')

    # regions
    cursor.execute('''
    CREATE TABLE IF NOT EXISTS regions (
        region_id SERIAL PRIMARY KEY,
        name VARCHAR(100) UNIQUE NOT NULL
    )
    ''')

    # region_rankings
    cursor.execute('''
    CREATE TABLE IF NOT EXISTS region_rankings (
        region_rank_id SERIAL PRIMARY KEY,
        region_id INTEGER REFERENCES regions(region_id),
        rank INTEGER NOT NULL,
        character_id INTEGER REFERENCES characters(character_id),
        profile_link TEXT           
    )
    ''')

    # goods
    cursor.execute('''
    CREATE TABLE IF NOT EXISTS goods (
        goods_id SERIAL PRIMARY KEY,
        name VARCHAR(100),
        character_id INTEGER REFERENCES characters(character_id),
        category VARCHAR(100),
        release_date DATE       
    )
    ''')

    # spots
    cursor.execute('''
    CREATE TABLE IF NOT EXISTS spots (
        spot_id SERIAL PRIMARY KEY,
        name VARCHAR(100),
        place VARCHAR(100),
        category VARCHAR(100),
        date DATE       
    )
    ''')

    # spot_character
    cursor.execute('''
    CREATE TABLE IF NOT EXISTS spot_character (
        spot_id INTEGER REFERENCES spots(spot_id),
        character_id INTEGER REFERENCES characters(character_id),
        PRIMARY KEY (spot_id, character_id)
    )
    ''')

    # news
    cursor.execute('''
    CREATE TABLE IF NOT EXISTS news (
        news_id SERIAL PRIMARY KEY,
        title TEXT,
        category VARCHAR(100)   
    )
    ''')

    # news_character
    cursor.execute('''
    CREATE TABLE IF NOT EXISTS news_character (
        news_id INTEGER REFERENCES news(news_id),
        character_id INTEGER REFERENCES characters(character_id),
        PRIMARY KEY (news_id, character_id)
    )
    ''')
    
    conn.commit()
    cursor.close()


# Insert data dari JSON ke DB
def import_regions(conn):
    cursor = conn.cursor()
    
    with open('c:\\Users\\naura\\OneDrive\\Documents\\ITB\\SMT 5\\Seleksi-2025-Tugas-1\\Data Scraping\\data\\region.json', 'r', encoding='utf-8') as f:
        data = json.load(f)
        regions = data['region_names']
        
    for region in regions:
        cursor.execute("INSERT INTO regions (name) VALUES (%s) ON CONFLICT (name) DO NOTHING", (region,))
    
    conn.commit()
    cursor.close()

def import_characters(conn):
    cursor = conn.cursor()
    
    with open('c:\\Users\\naura\\OneDrive\\Documents\\ITB\\SMT 5\\Seleksi-2025-Tugas-1\\Data Scraping\\data\\character.json', 'r', encoding='utf-8') as f:
        characters = json.load(f)
    
    for character in characters:
        cursor.execute(
            "INSERT INTO characters (name, description) VALUES (%s, %s) ON CONFLICT (name) DO NOTHING RETURNING character_id",
            (character.get('name'), character.get('description'))
        )
        result = cursor.fetchone()
        
        if result:
            character_id = result[0]
        else:
            # select ID karakter yang sudah ada
            cursor.execute("SELECT character_id FROM characters WHERE name = %s", (character.get('name'),))
            character_id = cursor.fetchone()[0]
        
        # Insert friends
        for friend in character.get('friends', []):
            cursor.execute(
                "INSERT INTO friends (character_id, friend_name) VALUES (%s, %s)",
                (character_id, friend)
            )

    conn.commit()
    cursor.close()

def import_overall_rankings(conn):
    cursor = conn.cursor()
    
    with open('c:\\Users\\naura\\OneDrive\\Documents\\ITB\\SMT 5\\Seleksi-2025-Tugas-1\\Data Scraping\\data\\overall_ranking.json', 'r', encoding='utf-8') as f:
        data = json.load(f)
    
    for category in ['high_rank', 'low_rank', 'low_rank_under']:
        for character in data[category]:
            cursor.execute("SELECT character_id FROM characters WHERE name = %s", (character['name'],))
            result = cursor.fetchone()
            
            if not result:
                cursor.execute(
                    "INSERT INTO characters (name, description) VALUES (%s, %s) RETURNING character_id",
                    (character['name'], None)
                )
                character_id = cursor.fetchone()[0]
            else:
                character_id = result[0]
            
            # rank_category, high = rank 1-30, low = rank >30
            rank_category = 'high' if int(character['rank']) <= 30 else 'low'
            
            # insert overall_rankings
            cursor.execute(
                "INSERT INTO overall_rankings (character_id, rank, profile_link, rank_category) VALUES (%s, %s, %s, %s) RETURNING overall_rank_id",
                (character_id, character['rank'], character.get('profile_link'), rank_category)
            )
            rank_id = cursor.fetchone()[0]
            
            # insert high_rank_ov dan low_rank_ov
            if rank_category == 'high':
                cursor.execute(
                    "INSERT INTO high_rank_ov (high_rank_id, vote_count, comment) VALUES (%s, %s, %s)",
                    (rank_id, character.get('votes'), character.get('comment'))
                )
            else:
                cursor.execute(
                    "INSERT INTO low_rank_ov (low_rank_id) VALUES (%s)",
                    (rank_id,)
                )
    
    conn.commit()
    cursor.close()

def import_region_rankings(conn):
    cursor = conn.cursor()
    
    try:
        with open('c:\\Users\\naura\\OneDrive\\Documents\\ITB\\SMT 5\\Seleksi-2025-Tugas-1\\Data Scraping\\data\\region_ranking.json', 'r', encoding='utf-8') as f:
            data = json.load(f)
        
        regions_data = data['regions_ranks']
        
        for region_name, rankings in regions_data.items():
            # get region_id
            cursor.execute("SELECT region_id FROM regions WHERE name = %s", (region_name,))
            result = cursor.fetchone()
            
            if not result:
                print(f"Region {region_name} not found in database, skipping")
                continue
                
            region_id = result[0]
            
            for category in ['high', 'low']:
                if category not in rankings:
                    continue
    
                for character in rankings[category]:
                    cursor.execute("SELECT character_id FROM characters WHERE name = %s", (character.get('name'),))
                    result = cursor.fetchone()
                    
                    if not result:
                        continue
                    
                    character_id = result[0]
                    
                    cursor.execute(
                        "INSERT INTO region_rankings (region_id, rank, character_id, profile_link) VALUES (%s, %s, %s, %s)",
                        (region_id, character.get('rank'), character_id, character.get('profile_link'))
                    )
        conn.commit()
    
    except Exception as e:
        conn.rollback()
        raise
    finally:
        cursor.close()

def delete_characters_by_id(conn, start_id, end_id): # delete karena ada nama alias dari karakter yang sama
    cursor = conn.cursor()
    
    try:
        cursor.execute("DELETE FROM friends WHERE character_id BETWEEN %s AND %s", (start_id, end_id))
        cursor.execute("DELETE FROM high_rank_ov WHERE high_rank_id IN (SELECT overall_rank_id FROM overall_rankings WHERE character_id BETWEEN %s AND %s)", (start_id, end_id))
        cursor.execute("DELETE FROM low_rank_ov WHERE low_rank_id IN (SELECT overall_rank_id FROM overall_rankings WHERE character_id BETWEEN %s AND %s)", (start_id, end_id))
        cursor.execute("DELETE FROM overall_rankings WHERE character_id BETWEEN %s AND %s", (start_id, end_id))
        cursor.execute("DELETE FROM region_rankings WHERE character_id BETWEEN %s AND %s", (start_id, end_id))
        cursor.execute("DELETE FROM goods WHERE character_id BETWEEN %s AND %s", (start_id, end_id))
        cursor.execute("DELETE FROM spot_character WHERE character_id BETWEEN %s AND %s", (start_id, end_id))
        cursor.execute("DELETE FROM news_character WHERE character_id BETWEEN %s AND %s", (start_id, end_id))
        cursor.execute("DELETE FROM characters WHERE character_id BETWEEN %s AND %s", (start_id, end_id))
        
        conn.commit()
        
    except Exception as e:
        conn.rollback()
        raise
    finally:
        cursor.close()


def main():
    if create_database():
        conn = connect_to_db()
        if not conn:
            return
    
    try:
        create_tables(conn)


        import_regions(conn)
        import_characters(conn)
        import_overall_rankings(conn)
        import_region_rankings(conn)
        
        delete_characters_by_id(conn, 93, 98)
        
    except Exception as e:
        print(f"error:{e}")
        conn.rollback()

    finally:
        conn.close()

if __name__ == "__main__":
    main()
