import os
import pandas as pd
from dotenv import load_dotenv
from sqlalchemy import create_engine, text

# Memuat variabel lingkungan dari file .env
load_dotenv()

def get_sqlalchemy_engine(is_dwh=False):
    """
    Membuat koneksi engine SQLAlchemy ke database
    """
    db_user = os.getenv("DB_USER")
    db_password = os.getenv("DB_PASSWORD")
    db_host = os.getenv("DB_HOST")
    db_port = os.getenv("DB_PORT")
    
    if is_dwh:
        db_name = os.getenv("DWH_DB_NAME")
    else:
        db_name = os.getenv("DB_NAME")

    if not all([db_user, db_password, db_host, db_port, db_name]):
        raise ValueError("Satu atau lebih variabel database tidak ditemukan di file .env")

    db_uri = f"postgresql://{db_user}:{db_password}@{db_host}:{db_port}/{db_name}"
    return create_engine(db_uri)

def extract_from_operational_db():
    """Mengambil data dari database operasional menggunakan SQLAlchemy."""
    print("Mengekstrak data dari database operasional...")
    engine = get_sqlalchemy_engine(is_dwh=False)
    query = """
        SELECT
            g.title,
            g.initial_rank AS rank,
            g.timestamp_ekstraksi,
            STRING_AGG(DISTINCT gn.name, ', ') AS genres
        FROM
            games g
        JOIN
            game_genres gg ON g.game_id = gg.game_id
        JOIN
            genres gn ON gg.genre_id = gn.genre_id
        GROUP BY
            g.game_id, g.title, g.initial_rank, g.timestamp_ekstraksi;
    """
    df = pd.read_sql_query(query, engine)
    print(f"Ekstraksi selesai. Ditemukan {len(df)} baris.")
    return df

def create_dwh_tables_if_not_exists():
    """
    Membuat tabel DWH jika belum ada.
    """
    print("Memeriksa dan membuat tabel DWH jika belum ada...")
    engine = get_sqlalchemy_engine(is_dwh=True)
    with engine.connect() as conn:
        conn.execute(text("""
            CREATE TABLE IF NOT EXISTS DimGame (
                game_key SERIAL PRIMARY KEY,
                title VARCHAR(255) UNIQUE NOT NULL
            );
        """))
        conn.execute(text("""
            CREATE TABLE IF NOT EXISTS DimGenre (
                genre_key SERIAL PRIMARY KEY,
                genre_name VARCHAR(100) UNIQUE NOT NULL
            );
        """))
        conn.execute(text("""
            CREATE TABLE IF NOT EXISTS DimDate (
                date_key SERIAL PRIMARY KEY,
                extraction_timestamp TIMESTAMPTZ UNIQUE NOT NULL,
                extraction_date DATE NOT NULL,
                extraction_time TIME NOT NULL
            );
        """))
        conn.execute(text("""
            CREATE TABLE IF NOT EXISTS FactGameRank (
                game_key INTEGER REFERENCES DimGame(game_key),
                genre_key INTEGER REFERENCES DimGenre(genre_key),
                date_key INTEGER REFERENCES DimDate(date_key),
                rank INTEGER,
                PRIMARY KEY (game_key, genre_key, date_key)
            );
        """))
        conn.commit() 
    print("Struktur tabel DWH sudah siap.")

def load_to_dwh(df):
    """
    Melakukan transformasi dan memuat data ke DWH dengan efisien.
    Menggunakan metode 'upsert' (insert on conflict) agar tidak ada duplikasi.
    """
    print("Memulai proses load ke Data Warehouse...")
    engine = get_sqlalchemy_engine(is_dwh=True)

    # 1. Transformasi dan Load Dimensi
    # DimDate
    dim_date = df[['timestamp_ekstraksi']].drop_duplicates().rename(columns={'timestamp_ekstraksi': 'extraction_timestamp'})
    dim_date['extraction_date'] = pd.to_datetime(dim_date['extraction_timestamp']).dt.date
    dim_date['extraction_time'] = pd.to_datetime(dim_date['extraction_timestamp']).dt.time
    dim_date.to_sql('dimdate', engine, if_exists='append', index=False, method=None)
    print("DimDate dimuat.")

    # DimGame
    dim_game = pd.DataFrame(df['title'].unique(), columns=['title'])
    dim_game.to_sql('dimgame', engine, if_exists='append', index=False, method=None)
    print("DimGame dimuat.")

    # DimGenre
    all_genres = set(g.strip() for genres in df['genres'].str.split(',') for g in genres)
    dim_genre = pd.DataFrame(sorted(list(all_genres)), columns=['genre_name'])
    dim_genre.to_sql('dimgenre', engine, if_exists='append', index=False, method=None)
    print("DimGenre dimuat.")
    
    # 2. Ambil Kunci dari Tabel Dimensi untuk Mapping
    print("Mengambil kunci dimensi untuk mapping...")
    dim_date_map = pd.read_sql("SELECT date_key, extraction_timestamp FROM dimdate", engine)
    dim_game_map = pd.read_sql("SELECT game_key, title FROM dimgame", engine)
    dim_genre_map = pd.read_sql("SELECT genre_key, genre_name FROM dimgenre", engine)

    # 3. Persiapan Tabel Fakta
    print("Mempersiapkan data untuk tabel fakta...")
    fact_df = df.merge(dim_game_map, on='title')
    fact_df = fact_df.merge(dim_date_map, left_on='timestamp_ekstraksi', right_on='extraction_timestamp')
    
    # Proses genre yang bisa lebih dari satu per game (explode)
    fact_df['genres'] = fact_df['genres'].str.split(', ')
    fact_df = fact_df.explode('genres').rename(columns={'genres': 'genre_name'})
    fact_df = fact_df.merge(dim_genre_map, on='genre_name')

    # Pilih kolom yang relevan untuk tabel fakta
    fact_df_final = fact_df[['game_key', 'genre_key', 'date_key', 'rank']]
    
    # 4. Load ke Tabel Fakta
    print(f"Memuat {len(fact_df_final)} baris ke FactGameRank...")
    with engine.connect() as conn:
        fact_df_final.to_sql('temp_fact_table', conn, if_exists='replace', index=False)
        
        upsert_query = """
            INSERT INTO FactGameRank (game_key, genre_key, date_key, rank)
            SELECT game_key, genre_key, date_key, rank FROM temp_fact_table
            ON CONFLICT (game_key, genre_key, date_key) DO UPDATE SET
            rank = EXCLUDED.rank;
        """

        conn.execute(text(upsert_query))
        conn.commit()
        
    print("Data berhasil dimuat ke Data Warehouse.")

# main function untuk menjalankan ETL
if __name__ == "__main__":
    create_dwh_tables_if_not_exists()
    
    source_df = extract_from_operational_db()
    
    if not source_df.empty:
        load_to_dwh(source_df)
    else:
        print("Tidak ada data sumber untuk dimuat.")