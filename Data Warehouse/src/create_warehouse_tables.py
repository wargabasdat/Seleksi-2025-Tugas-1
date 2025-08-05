import psycopg2

# Koneksi ke database data warehouse
conn = psycopg2.connect(
    host="localhost",
    database="videogames_dw",
    user="postgres",
    password="1234" 
)

cur = conn.cursor()

drop_statements = [
    "DROP TABLE IF EXISTS dim_videogame, dim_year, dim_director, fact_videogame_rating, fact_director_credit CASCADE;",
]

# Buat tabel dimensi dan fact
create_tables_queries = [
    # dim_videogame
    """
    CREATE TABLE IF NOT EXISTS dim_videogame (
        videogame_id INTEGER PRIMARY KEY,
        title TEXT NOT NULL
    );
    """,

    # dim_year
    """
    CREATE TABLE IF NOT EXISTS dim_year (
        year_id INTEGER PRIMARY KEY
    );
    """,

    # dim_director
    """
    CREATE TABLE IF NOT EXISTS dim_director (
        director_id INTEGER PRIMARY KEY,
        director_name TEXT NOT NULL
    );
    """,

    # fact_videogame_rating
    """
    CREATE TABLE IF NOT EXISTS fact_videogame_rating (
        videogame_id INTEGER,
        year_id INTEGER,
        rating FLOAT,
        PRIMARY KEY (videogame_id, year_id),
        FOREIGN KEY (videogame_id) REFERENCES dim_videogame (videogame_id),
        FOREIGN KEY (year_id) REFERENCES dim_year (year_id)
    );
    """,

    # fact_director_credit
    """
    CREATE TABLE IF NOT EXISTS fact_director_credit (
        videogame_id INTEGER,
        year_id INTEGER,
        director_id INTEGER,
        PRIMARY KEY (videogame_id, year_id, director_id),
        FOREIGN KEY (videogame_id) REFERENCES dim_videogame (videogame_id),
        FOREIGN KEY (year_id) REFERENCES dim_year (year_id),
        FOREIGN KEY (director_id) REFERENCES dim_director (director_id)
    );
    """
]

# Jalankan semua query
for query in drop_statements + create_tables_queries:
    cur.execute(query)

# Simpan perubahan dan tutup koneksi
conn.commit()
cur.close()
conn.close()
print("\nSemua tabel sudah berhasil dibuat.")
