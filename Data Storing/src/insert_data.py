import psycopg2
import json
import os
from datetime import datetime

BASE_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), '..', '..'))
DATA_DIR = os.path.join(BASE_DIR, 'Data Scraping', 'data')
extracted_time = datetime.now()

# Koneksi ke PostgreSQL
conn = psycopg2.connect(
    host="localhost",
    database="videogames_db", 
    user="postgres",
    password="1234"
)

cur = conn.cursor()

print("Memulai proses insert/update data...\n")

# Load JSON files
with open(os.path.join(DATA_DIR, 'directors_videogames.json'), 'r', encoding='utf-8') as f:
    directors_data = json.load(f)

with open(os.path.join(DATA_DIR, 'stars_videogames.json'), 'r', encoding='utf-8') as f:
    stars_data = json.load(f)

with open(os.path.join(DATA_DIR, 'videogames.json'), 'r', encoding='utf-8') as f:
    videogames_data = json.load(f)

# Insert / update directors
for director in directors_data:
    cur.execute("""
        INSERT INTO director (id, director_name)
        VALUES (%s, %s)
        ON CONFLICT (id) DO UPDATE SET director_name = EXCLUDED.director_name;
    """, (director['id'], director['name']))

# Insert / update stars
for star in stars_data:
    cur.execute("""
        INSERT INTO star (id, star_name)
        VALUES (%s, %s)
        ON CONFLICT (id) DO UPDATE SET star_name = EXCLUDED.star_name;
    """, (star['id'], star['name']))

# Insert / update videogames dan relasi
for game in videogames_data:
    cur.execute("""
        INSERT INTO videogame (title, year, age_rating, rating, description, extracted_at)
        VALUES (%s, %s, %s, %s, %s, %s)
        ON CONFLICT (title, year) DO UPDATE
        SET age_rating = EXCLUDED.age_rating,
            rating = EXCLUDED.rating,
            description = EXCLUDED.description,
            extracted_at = EXCLUDED.extracted_at;
    """, (
        game['title'],
        game['year'],
        game['age rating'],
        float(game['rating']) if game['rating'] else None,
        game['description'],
        extracted_time
    ))

    # Ambil ID
    cur.execute("""
        SELECT id FROM videogame WHERE title = %s AND year = %s;
    """, (game['title'], game['year']))
    result = cur.fetchone()

    if result:
        videogame_id = result[0]
    else:
        print(f" Gagal mendapatkan ID untuk: {game['title']} ({game['year']})")
        continue

    # Insert director_credit (hindari duplikat)
    for director_id in game['directors']:
        cur.execute("""
            INSERT INTO director_credit (videogame_id, director_id)
            VALUES (%s, %s)
            ON CONFLICT DO NOTHING;
        """, (videogame_id, director_id))

    # Insert cast_credit (hindari duplikat)
    for star_id in game['stars']:
        cur.execute("""
            INSERT INTO cast_credit (videogame_id, star_id)
            VALUES (%s, %s)
            ON CONFLICT DO NOTHING;
        """, (videogame_id, star_id))

# Simpan dan tutup koneksi
conn.commit()
cur.close()
conn.close()

print("\nData berhasil dimasukkan / diperbarui di database.")
