import psycopg2
import json
import os
from dotenv import load_dotenv

def get_db_connection():
    """
    Koneksi ke server PSQL database menggunakan environment variables.
    """
    load_dotenv()
    try:
        conn = psycopg2.connect(
            host=os.getenv("DB_HOST", "localhost"),
            port=os.getenv("DB_PORT", "5432"),
            dbname=os.getenv("DB_NAME", "top_ps2_games"),
            user=os.getenv("DB_USER", "postgres"),
            password=os.getenv("DB_PASSWORD")
        )
        return conn
    except psycopg2.OperationalError as e:
        print(f"Error connecting to the database: {e}")
        return None

def create_all_tables(conn):
    """
    Membuat semua tabel yang diperlukan sesuai dengan diagram skema yang baru.
    """
    ddl_commands = [
        # Tabel master
        """CREATE TABLE IF NOT EXISTS users ( user_id SERIAL PRIMARY KEY, username VARCHAR(50) UNIQUE NOT NULL, email VARCHAR(255) UNIQUE NOT NULL, password_hash VARCHAR(255) NOT NULL, created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP );""",
        """CREATE TABLE IF NOT EXISTS developers ( developer_id SERIAL PRIMARY KEY, name VARCHAR(255) UNIQUE NOT NULL );""",
        """CREATE TABLE IF NOT EXISTS publishers ( publisher_id SERIAL PRIMARY KEY, name VARCHAR(255) UNIQUE NOT NULL );""",
        """CREATE TABLE IF NOT EXISTS genres ( genre_id SERIAL PRIMARY KEY, name VARCHAR(100) UNIQUE NOT NULL );""",
        """CREATE TABLE IF NOT EXISTS regions ( region_id SERIAL PRIMARY KEY, name VARCHAR(50) UNIQUE NOT NULL );""",
        """CREATE TABLE IF NOT EXISTS game_media ( critic_id SERIAL PRIMARY KEY, name VARCHAR(100) UNIQUE NOT NULL, website VARCHAR(255) );""",
        
        """
        CREATE TABLE IF NOT EXISTS games (
            game_id SERIAL PRIMARY KEY,
            release_id INT, -- Sesuai diagram, meskipun FK lebih umum ada di tabel anak
            title VARCHAR(255) UNIQUE NOT NULL,
            initial_rank INT
        );
        """,
        
        """
        CREATE TABLE IF NOT EXISTS game_developers (
            game_id INT REFERENCES games(game_id) ON DELETE CASCADE,
            developer_id INT REFERENCES developers(developer_id) ON DELETE CASCADE,
            PRIMARY KEY (game_id, developer_id)
        );
        """,
        """
        CREATE TABLE IF NOT EXISTS game_publishers (
            game_id INT REFERENCES games(game_id) ON DELETE CASCADE,
            publisher_id INT REFERENCES publishers(publisher_id) ON DELETE CASCADE,
            PRIMARY KEY (game_id, publisher_id)
        );
        """,
        """
        CREATE TABLE IF NOT EXISTS game_genres (
            game_id INT REFERENCES games(game_id) ON DELETE CASCADE,
            genre_id INT REFERENCES genres(genre_id) ON DELETE CASCADE,
            PRIMARY KEY (game_id, genre_id)
        );
        """,

        """CREATE TABLE IF NOT EXISTS reviews ( review_id SERIAL PRIMARY KEY, game_id INT NOT NULL REFERENCES games(game_id) ON DELETE CASCADE, critic_id INT NOT NULL REFERENCES game_media(critic_id) ON DELETE CASCADE, score INT, review_summary TEXT, review_url VARCHAR(255), UNIQUE(game_id, critic_id) );""",
        """CREATE TABLE IF NOT EXISTS regional_releases ( release_id SERIAL PRIMARY KEY, game_id INT NOT NULL REFERENCES games(game_id) ON DELETE CASCADE, region_id INT NOT NULL REFERENCES regions(region_id) ON DELETE CASCADE, release_date DATE, regional_title VARCHAR(255) );""",
        """CREATE TABLE IF NOT EXISTS user_game_library ( user_game_id SERIAL PRIMARY KEY, user_id INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE, game_id INT NOT NULL REFERENCES games(game_id) ON DELETE CASCADE, status VARCHAR(20) NOT NULL DEFAULT 'played', user_rating INT, added_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP, UNIQUE(user_id, game_id) );"""
    ]
    
    try:
        with conn.cursor() as cur:
            for command in ddl_commands:
                cur.execute(command)
        conn.commit()
        print("(LOG) Berhasil membuat tabel-tabel yang diperlukan.")
    except psycopg2.Error as e:
        print(f"(LOG) Error membuat atau mengupdate tabel: {e}")
        conn.rollback()

def get_or_create_id(cur, table_name, name, column_name='name'):
    if not name:
        return None
    # Menyesuaikan nama kolom ID secara dinamis (e.g., 'developers' -> 'developer_id')
    id_column_root = table_name.rstrip('s') if table_name != 'game_media' else 'critic'
    id_column = f"{id_column_root}_id"

    cur.execute(f"SELECT {id_column} FROM {table_name} WHERE {column_name} = %s;", (name,))
    result = cur.fetchone()
    if result:
        return result[0]
    else:
        cur.execute(f"INSERT INTO {table_name} ({column_name}) VALUES (%s) ON CONFLICT ({column_name}) DO UPDATE SET {column_name}=EXCLUDED.{column_name} RETURNING {id_column};", (name,))
        return cur.fetchone()[0]

def load_data_to_db(conn, data):
    try:
        with conn.cursor() as cur:
            for record in data:
                developer_id = get_or_create_id(cur, 'developers', record.get('developer'))
                publisher_id = get_or_create_id(cur, 'publishers', record.get('publisher'))
                
                cur.execute(
                    """
                    INSERT INTO games (title, initial_rank)
                    VALUES (%s, %s)
                    ON CONFLICT (title) DO UPDATE SET
                        initial_rank = EXCLUDED.initial_rank
                    RETURNING game_id;
                    """,
                    (record['title'], record['rank'])
                )
                game_id = cur.fetchone()[0]

                if developer_id:
                    cur.execute(
                        "INSERT INTO game_developers (game_id, developer_id) VALUES (%s, %s) ON CONFLICT DO NOTHING;",
                        (game_id, developer_id)
                    )
                
                if publisher_id:
                    cur.execute(
                        "INSERT INTO game_publishers (game_id, publisher_id) VALUES (%s, %s) ON CONFLICT DO NOTHING;",
                        (game_id, publisher_id)
                    )

                if record.get('genre'):
                    genres = [g.strip() for g in record['genre'].split(',') if g.strip()]
                    for genre_name in genres:
                        genre_id = get_or_create_id(cur, 'genres', genre_name)
                        cur.execute(
                            "INSERT INTO game_genres (game_id, genre_id) VALUES (%s, %s) ON CONFLICT DO NOTHING;",
                            (game_id, genre_id)
                        )
            conn.commit()
            print(f"Successfully loaded and normalized {len(data)} records into the database.")
    except psycopg2.Error as e:
        print(f"Error loading data: {e}")
        conn.rollback()

def main():
    script_dir = os.path.dirname(os.path.abspath(__file__))
    json_file = os.path.join(script_dir, "..", "..", "Data Scraping", "data", "list_games_ps2.json")

    try:
        with open(json_file, 'r', encoding='utf-8') as f:
            game_data = json.load(f)
    except (IOError, json.JSONDecodeError) as e:
        print(f"Error reading or parsing {json_file}: {e}")
        return

    conn = get_db_connection()
    if conn:
        try:
            create_all_tables(conn)
            load_data_to_db(conn, game_data)
        finally:
            conn.close()
            print("Database connection closed.")

if __name__ == "__main__":
    main()