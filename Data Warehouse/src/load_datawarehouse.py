import psycopg2

# Koneksi ke database sumber (OLTP)
conn_src = psycopg2.connect(
    host="localhost",
    database="videogames_db",
    user="postgres",
    password="1234"
)

# Koneksi ke database warehouse 
conn_dw = psycopg2.connect(
    host="localhost",
    database="videogames_dw",
    user="postgres",
    password="1234"
)

cur_src = conn_src.cursor()
cur_dw = conn_dw.cursor()

# Load dim_videogame dan dim_year
cur_src.execute("SELECT id, title, year, rating FROM videogame")
videogames = cur_src.fetchall()

for vg_id, title, year, rating in videogames:
    # Insert dim_videogame
    cur_dw.execute("""
        INSERT INTO dim_videogame (videogame_id, title)
        VALUES (%s, %s)
        ON CONFLICT (videogame_id) DO NOTHING;
    """, (vg_id, title))

    # Insert dim_year
    cur_dw.execute("""
        INSERT INTO dim_year (year_id)
        VALUES (%s)
        ON CONFLICT (year_id) DO NOTHING;
    """, (year,))

    # Insert fact_videogame_rating
    cur_dw.execute("""
        INSERT INTO fact_videogame_rating (videogame_id, year_id, rating)
        VALUES (%s, %s, %s)
        ON CONFLICT DO NOTHING;
    """, (vg_id, year, rating))


# Load dim_director dan fact_director_credit
cur_src.execute("""
    SELECT dc.videogame_id, v.year, d.id, d.director_name
    FROM director_credit dc
    JOIN director d ON dc.director_id = d.id
    JOIN videogame v ON v.id = dc.videogame_id
""")
directors = cur_src.fetchall()

for vg_id, year, dir_id, dir_name in directors:
    # Insert dim_director
    cur_dw.execute("""
        INSERT INTO dim_director (director_id, director_name)
        VALUES (%s, %s)
        ON CONFLICT (director_id) DO NOTHING;
    """, (dir_id, dir_name))

    # Insert fact_director_credit
    cur_dw.execute("""
        INSERT INTO fact_director_credit (videogame_id, year_id, director_id)
        VALUES (%s, %s, %s)
        ON CONFLICT DO NOTHING;
    """, (vg_id, year, dir_id))

# Simpan perubahan dan tutup koneksi
conn_dw.commit()
cur_src.close()
cur_dw.close()
conn_src.close()
conn_dw.close()

print("\nData berhasil dimuat ke data warehouse.")
