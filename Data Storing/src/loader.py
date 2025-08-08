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
            host=os.getenv("DB_HOST"),
            port=os.getenv("DB_PORT"),
            dbname=os.getenv("DB_NAME"),
            user=os.getenv("DB_USER"),
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
        """CREATE TABLE IF NOT EXISTS users ( user_id SERIAL PRIMARY KEY, username VARCHAR(50) NOT NULL, email VARCHAR(255) NOT NULL, password_hash VARCHAR(255) NOT NULL, created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP );""",
        """CREATE TABLE IF NOT EXISTS developers ( developer_id SERIAL PRIMARY KEY, name VARCHAR(255) NOT NULL );""",
        """CREATE TABLE IF NOT EXISTS publishers ( publisher_id SERIAL PRIMARY KEY, name VARCHAR(255) NOT NULL );""",
        """CREATE TABLE IF NOT EXISTS genres ( genre_id SERIAL PRIMARY KEY, name VARCHAR(100) NOT NULL );""",
        """CREATE TABLE IF NOT EXISTS regions ( region_id SERIAL PRIMARY KEY, name VARCHAR(50) NOT NULL );""",
        """CREATE TABLE IF NOT EXISTS game_media ( critic_id SERIAL PRIMARY KEY, name VARCHAR(100) NOT NULL, website VARCHAR(255) );""",
        
        """
        CREATE TABLE IF NOT EXISTS games (
            game_id SERIAL PRIMARY KEY,
            title VARCHAR(255) NOT NULL,
            initial_rank INT
        );
        """,
        
        """
        CREATE TABLE IF NOT EXISTS game_developers (
            game_id INT,
            developer_id INT
        );
        """,
        """
        CREATE TABLE IF NOT EXISTS game_publishers (
            game_id INT,
            publisher_id INT
        );
        """,
        """
        CREATE TABLE IF NOT EXISTS game_genres (
            game_id INT,
            genre_id INT
        );
        """,

        """CREATE TABLE IF NOT EXISTS reviews ( review_id SERIAL PRIMARY KEY, game_id INT NOT NULL, critic_id INT NOT NULL, score INT, review_summary TEXT, review_url VARCHAR(255) );""",
        """CREATE TABLE IF NOT EXISTS regional_releases ( release_id SERIAL PRIMARY KEY, game_id INT NOT NULL, region_id INT NOT NULL, release_date DATE, regional_title VARCHAR(255) );""",
        """CREATE TABLE IF NOT EXISTS user_game_library ( user_game_id SERIAL PRIMARY KEY, user_id INT NOT NULL, game_id INT NOT NULL, status VARCHAR(20) NOT NULL DEFAULT 'played', user_rating INT, added_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP );"""
    ]
    
    try:
        with conn.cursor() as cur:
            for command in ddl_commands:
                cur.execute(command)
            
            # Add the timestamp column if it doesn't exist
            cur.execute("""
                ALTER TABLE games
                ADD COLUMN IF NOT EXISTS timestamp_ekstraksi TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP;
            """)

        conn.commit()
        print("(LOG) Berhasil membuat tabel-tabel yang diperlukan.")
    except psycopg2.Error as e:
        print(f"(LOG) Error membuat atau mengupdate tabel: {e}")
        conn.rollback()

def apply_constraints(conn):
    """
    Menerapkan constraint dan trigger dari file SQL terpisah.
    """
    script_dir = os.path.dirname(os.path.abspath(__file__))
    constraints_file = os.path.join(script_dir, "constraints.sql")
    try:
        with conn.cursor() as cur:
            with open(constraints_file, 'r') as f:
                sql = f.read()
                cur.execute(sql)
        conn.commit()
        print("(LOG) Berhasil menerapkan constraints dan triggers.")
    except (IOError, psycopg2.Error) as e:
        print(f"(LOG) Error menerapkan constraints: {e}")
        conn.rollback()

def get_or_create_id(cur, table_name, name, column_name='name'):
    if not name:
        return None
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
                cur.execute(
                    """
                    INSERT INTO games (title, initial_rank, timestamp_ekstraksi)
                    VALUES (%s, %s, CURRENT_TIMESTAMP)
                    ON CONFLICT (title) DO UPDATE SET
                        initial_rank = EXCLUDED.initial_rank,
                        timestamp_ekstraksi = CURRENT_TIMESTAMP
                    RETURNING game_id;
                    """,
                    (record['title'], record['rank'])
                )
                game_id = cur.fetchone()[0]

                if record.get('genre'):
                    genres = [g.strip() for g in record['genre'].split(',') if g.strip()]
                    for genre_name in genres:
                        genre_id = get_or_create_id(cur, 'genres', genre_name)
                        if genre_id:
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
            apply_constraints(conn)
            load_data_to_db(conn, game_data)
        finally:
            conn.close()
            print("Database connection closed.")

if __name__ == "__main__":
    main()