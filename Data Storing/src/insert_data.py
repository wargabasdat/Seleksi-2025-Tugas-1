import psycopg2
import json
import os
import json

BASE_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), '..', '..'))
DATA_DIR = os.path.join(BASE_DIR, 'Data Scraping', 'data')

# Koneksi ke PostgreSQL
conn = psycopg2.connect(
    host="localhost",
    database="videogames_db", 
    user="postgres",
    password="1234"  
)

cur = conn.cursor()

cur.execute("DELETE FROM cast_credit")
cur.execute("DELETE FROM director_credit")
cur.execute("DELETE FROM videogame")
cur.execute("DELETE FROM star")
cur.execute("DELETE FROM director")

# Reset sequence untuk table videogame, director, dan star
cur.execute("ALTER SEQUENCE videogame_id_seq RESTART WITH 1")
cur.execute("ALTER SEQUENCE director_id_seq RESTART WITH 1")
cur.execute("ALTER SEQUENCE star_id_seq RESTART WITH 1")


print("Seluruh data lama telah dihapus. Memulai proses insert data baru...\n")

# Load JSON files
with open(os.path.join(DATA_DIR, 'directors_videogames.json'), 'r', encoding='utf-8') as f:
    directors_data = json.load(f)

with open(os.path.join(DATA_DIR, 'stars_videogames.json'), 'r', encoding='utf-8') as f:
    stars_data = json.load(f)

with open(os.path.join(DATA_DIR, 'videogames.json'), 'r', encoding='utf-8') as f:
    videogames_data = json.load(f)

# Insert directors
for director in directors_data:
    cur.execute("""
        INSERT INTO director (id, director_name)
        VALUES (%s, %s)
        ON CONFLICT (id) DO NOTHING;
    """, (director['id'], director['name']))

# Insert stars
for star in stars_data:
    cur.execute("""
        INSERT INTO star (id, star_name)
        VALUES (%s, %s)
        ON CONFLICT (id) DO NOTHING;
    """, (star['id'], star['name']))

# Insert videogames dan relasi ke cast_credit dan director_credit
for game in videogames_data:
    cur.execute("""
        INSERT INTO videogame (title, year, age_rating, rating, description)
        VALUES (%s, %s, %s, %s, %s)
        RETURNING id;
    """, (
        game['title'],
        game['year'],
        game['age rating'],
        float(game['rating']) if game['rating'] else None,
        game['description']
    ))
    
    videogame_id = cur.fetchone()[0]

    # Insert into director_credit
    for director_id in game['directors']:
        cur.execute("""
            INSERT INTO director_credit (videogame_id, director_id)
            VALUES (%s, %s)
            ON CONFLICT DO NOTHING;
        """, (videogame_id, director_id))

    # Insert into cast_credit
    for star_id in game['stars']:
        cur.execute("""
            INSERT INTO cast_credit (videogame_id, star_id)
            VALUES (%s, %s)
            ON CONFLICT DO NOTHING;
        """, (videogame_id, star_id))

# Simpan perubahan dan tutup koneksi
conn.commit()
cur.close()
conn.close()

print("\nData berhasil dimasukkan ke database.")
