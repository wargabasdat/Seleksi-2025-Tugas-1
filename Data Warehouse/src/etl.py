import os
import psycopg2
import pandas as pd
from dotenv import load_dotenv

def get_db_connection():
    """Membuat dan mengembalikan koneksi ke database PostgreSQL."""
    load_dotenv()
    
    conn = psycopg2.connect(
        host=os.getenv("DB_WAREHOUSE_HOST"),
        port=os.getenv("DB_WAREHOUSE_PORT"),
        dbname=os.getenv("DB_WAREHOUSE_NAME"),
        user=os.getenv("DB_WAREHOUSE_USER"),
        password=os.getenv("DB_WAREHOUSE_PASSWORD")
    )
    return conn

def get_operational_db_connection():
    """Mendapatkan koneksi ke database operasional."""
    load_dotenv()
    return psycopg2.connect(
        host=os.getenv("DB_HOST"),
        port=os.getenv("DB_PORT"),
        dbname=os.getenv("DB_NAME"),
        user=os.getenv("DB_USER"),
        password=os.getenv("DB_PASSWORD")
    )

def get_dwh_db_connection():
    """Mendapatkan koneksi ke database data warehouse."""
    load_dotenv()
    return psycopg2.connect(
        host=os.getenv("DB_HOST"),
        port=os.getenv("DB_PORT"),
        dbname=os.getenv("DWH_DB_NAME"),
        user=os.getenv("DB_USER"),
        password=os.getenv("DB_PASSWORD")
    )

def extract_from_db():
    """Mengambil data dari database operasional."""
    conn = get_operational_db_connection()
    query = """
        SELECT
            g.title,
            g.initial_rank AS rank,
            STRING_AGG(gn.name, ', ') AS genre
        FROM
            games g
        JOIN
            game_genres gg ON g.game_id = gg.game_id
        JOIN
            genres gn ON gg.genre_id = gn.genre_id
        GROUP BY
            g.game_id, g.title, g.initial_rank;
    """
    df = pd.read_sql_query(query, conn)
    conn.close()
    return df

def create_dwh_tables():
    """Membuat tabel dimensi dan fakta untuk Data Warehouse."""
    conn = get_dwh_db_connection()
    cur = conn.cursor()
    
    cur.execute("DROP TABLE IF EXISTS FactGameRank, DimGame, DimGenre;")

    cur.execute("""
        CREATE TABLE DimGame (
            game_key SERIAL PRIMARY KEY,
            title VARCHAR(255) NOT NULL
        );
    """)

    cur.execute("""
        CREATE TABLE DimGenre (
            genre_key SERIAL PRIMARY KEY,
            genre_name VARCHAR(100) NOT NULL
        );
    """)

    cur.execute("""
        CREATE TABLE FactGameRank (
            game_key INTEGER REFERENCES DimGame(game_key),
            genre_key INTEGER REFERENCES DimGenre(genre_key),
            rank INTEGER,
            PRIMARY KEY (game_key, genre_key)
        );
    """)
    
    conn.commit()
    cur.close()
    conn.close()
    print("Tabel Data Warehouse berhasil dibuat.")

def load_to_dwh(df):
    """Melakukan transformasi dan memuat data ke dalam tabel DWH."""
    conn = get_dwh_db_connection()
    cur = conn.cursor()

    all_genres = set()
    df['genre'].str.split(',').apply(lambda x: [all_genres.add(g.strip()) for g in x])
    
    genre_map = {}
    for genre_name in sorted(list(all_genres)):
        cur.execute("INSERT INTO DimGenre (genre_name) VALUES (%s) RETURNING genre_key;", (genre_name,))
        genre_map[genre_name] = cur.fetchone()[0]

    game_map = {}
    for title in df['title'].unique():
        cur.execute("INSERT INTO DimGame (title) VALUES (%s) RETURNING game_key;", (title,))
        game_map[title] = cur.fetchone()[0]

    for index, row in df.iterrows():
        game_key = game_map[row['title']]
        genres = [g.strip() for g in row['genre'].split(',')]
        for genre_name in genres:
            genre_key = genre_map[genre_name]
            cur.execute(
                "INSERT INTO FactGameRank (game_key, genre_key, rank) VALUES (%s, %s, %s);",
                (game_key, genre_key, row['rank'])
            )

    conn.commit()
    cur.close()
    conn.close()
    print("Data berhasil dimuat ke Data Warehouse.")

def create_dwh_tables():
    """Membuat tabel dimensi dan fakta untuk Data Warehouse."""
    conn = get_db_connection()
    cur = conn.cursor()
    
    cur.execute("DROP TABLE IF EXISTS FactGameRank, DimGame, DimGenre;")

    # Membuat tabel DimGame
    cur.execute("""
        CREATE TABLE DimGame (
            game_key SERIAL PRIMARY KEY,
            title VARCHAR(255) NOT NULL
        );
    """)

    # Membuat tabel DimGenre
    cur.execute("""
        CREATE TABLE DimGenre (
            genre_key SERIAL PRIMARY KEY,
            genre_name VARCHAR(100) NOT NULL
        );
    """)

    # Membuat tabel FactGameRank
    cur.execute("""
        CREATE TABLE FactGameRank (
            game_key INTEGER REFERENCES DimGame(game_key),
            genre_key INTEGER REFERENCES DimGenre(genre_key),
            rank INTEGER,
            PRIMARY KEY (game_key, genre_key)
        );
    """)
    
    conn.commit()
    cur.close()
    conn.close()
    print("Tabel Data Warehouse berhasil dibuat.")

def load_to_dwh(df):
    """Melakukan transformasi dan memuat data ke dalam tabel DWH."""
    conn = get_db_connection()
    cur = conn.cursor()

    # Transformasi dan Load DimGenre
    all_genres = set()
    df['genre'].str.split(',').apply(lambda x: [all_genres.add(g.strip()) for g in x])
    
    genre_map = {}
    for genre_name in sorted(list(all_genres)):
        cur.execute("INSERT INTO DimGenre (genre_name) VALUES (%s) RETURNING genre_key;", (genre_name,))
        genre_map[genre_name] = cur.fetchone()[0]

    # Transformasi dan Load DimGame
    game_map = {}
    for title in df['title'].unique():
        cur.execute("INSERT INTO DimGame (title) VALUES (%s) RETURNING game_key;", (title,))
        game_map[title] = cur.fetchone()[0]

    # 3. Load FactGameRank
    for index, row in df.iterrows():
        game_key = game_map[row['title']]
        genres = [g.strip() for g in row['genre'].split(',')]
        for genre_name in genres:
            genre_key = genre_map[genre_name]
            cur.execute(
                "INSERT INTO FactGameRank (game_key, genre_key, rank) VALUES (%s, %s, %s);",
                (game_key, genre_key, row['rank'])
            )

    conn.commit()
    cur.close()
    conn.close()
    print("Data berhasil dimuat ke Data Warehouse.")


if __name__ == "__main__":
    # function untuk membuat tabel DWH
    create_dwh_tables()
    
    # Ekstrak data dari database sumber
    source_df = extract_from_db()
    
    # Load data ke DWH
    if not source_df.empty:
        load_to_dwh(source_df)
    else:
        print("Tidak ada data untuk dimuat.")
