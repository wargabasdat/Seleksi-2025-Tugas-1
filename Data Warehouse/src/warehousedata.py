import json
import psycopg2
from psycopg2 import extras
import re
import pandas as pd
import os

DB_HOST = "localhost"
DB_NAME = "manhwa_warehouse"
DB_USER = ""  # Ganti dengan username PostgreSQL
DB_PASS = ""  # Ganti dengan password PostgreSQL

DATA_DIR = os.path.join(os.pardir, os.pardir, 'Data Scraping', 'data')

def connect_db():
    """Establishes a connection to the PostgreSQL database."""
    try:
        conn = psycopg2.connect(host=DB_HOST, dbname=DB_NAME, user=DB_USER, password=DB_PASS)
        return conn
    except psycopg2.Error as e:
        print(f"Error connecting to database: {e}")
        return None

def create_tables(cur):
    """Creates the dimension, fact, and bridge tables in the database."""
    print("Creating tables...")
    cur.execute("""
        CREATE TABLE IF NOT EXISTS dim_manhwa (
            manhwa_id SERIAL PRIMARY KEY,
            title VARCHAR(255) UNIQUE NOT NULL,
            status VARCHAR(50),
            serialization VARCHAR(255),
            published_start_year INTEGER,
            published_end_year INTEGER
        );
    """)

    cur.execute("""
        CREATE TABLE IF NOT EXISTS dim_author (
            author_id SERIAL PRIMARY KEY,
            author_name VARCHAR(255) UNIQUE NOT NULL,
            given_name VARCHAR(255),
            family_name VARCHAR(255),
            birthday DATE,
            website VARCHAR(255),
            member_favorites INTEGER
        );
    """)

    cur.execute("""
        CREATE TABLE IF NOT EXISTS dim_company (
            company_id SERIAL PRIMARY KEY,
            company_name VARCHAR(255) UNIQUE NOT NULL,
            total_works INTEGER
        );
    """)

    cur.execute("""
        CREATE TABLE IF NOT EXISTS dim_genre (
            genre_id SERIAL PRIMARY KEY,
            genre_name VARCHAR(255) UNIQUE NOT NULL,
            total_works INTEGER,
            description TEXT
        );
    """)

    cur.execute("""
        CREATE TABLE IF NOT EXISTS dim_character (
            character_id SERIAL PRIMARY KEY,
            character_name VARCHAR(255) UNIQUE NOT NULL,
            role VARCHAR(50),
            member_favorites INTEGER
        );
    """)

    cur.execute("""
        CREATE TABLE IF NOT EXISTS fact_manhwa (
            fact_id SERIAL PRIMARY KEY,
            manhwa_id INTEGER REFERENCES dim_manhwa(manhwa_id),
            company_id INTEGER REFERENCES dim_company(company_id),
            score DECIMAL(4, 2),
            chapters INTEGER
        );
    """)

    cur.execute("""
        CREATE TABLE IF NOT EXISTS fact_manhwa_authors (
            fact_author_id SERIAL PRIMARY KEY,
            manhwa_id INTEGER REFERENCES dim_manhwa(manhwa_id),
            author_id INTEGER REFERENCES dim_author(author_id)
        );
    """)

    cur.execute("""
        CREATE TABLE IF NOT EXISTS fact_manhwa_genres (
            fact_genre_id SERIAL PRIMARY KEY,
            manhwa_id INTEGER REFERENCES dim_manhwa(manhwa_id),
            genre_id INTEGER REFERENCES dim_genre(genre_id)
        );
    """)

    cur.execute("""
        CREATE TABLE IF NOT EXISTS fact_manhwa_characters (
            fact_character_id SERIAL PRIMARY KEY,
            manhwa_id INTEGER REFERENCES dim_manhwa(manhwa_id),
            character_id INTEGER REFERENCES dim_character(character_id)
        );
    """)
    print("Tables created successfully!")

def insert_data(conn):
    """Loads and transforms data from JSON files and inserts it into the database."""
    print("Loading data from JSON files...")
    
    manhwa_file = os.path.join(DATA_DIR, 'manhwa_data.json')
    authors_file = os.path.join(DATA_DIR, 'authors_data.json')
    companies_file = os.path.join(DATA_DIR, 'companies_data.json')
    genres_file = os.path.join(DATA_DIR, 'genres_data.json')
    characters_file = os.path.join(DATA_DIR, 'characters_data.json')

    with open(manhwa_file, 'r', encoding='utf-8') as f:
        manhwa_data = json.load(f)
    with open(authors_file, 'r', encoding='utf-8') as f:
        authors_data = json.load(f)
    with open(companies_file, 'r', encoding='utf-8') as f:
        companies_data = json.load(f)
    with open(genres_file, 'r', encoding='utf-8') as f:
        genres_data = json.load(f)
    with open(characters_file, 'r', encoding='utf-8') as f:
        characters_data = json.load(f)

    df_manhwa = pd.DataFrame(manhwa_data)
    df_authors = pd.DataFrame(authors_data)
    df_companies = pd.DataFrame(companies_data)
    df_genres = pd.DataFrame(genres_data)
    df_characters = pd.DataFrame(characters_data)

    cur = conn.cursor()

    company_map = {}
    author_map = {}
    genre_map = {}
    character_map = {}
    manhwa_map = {}

    print("Inserting into dim_company...")
    for _, row in df_companies.iterrows():
        try:
            if not row['Company Name']: continue
            cur.execute("INSERT INTO dim_company (company_name, total_works) VALUES (%s, %s) ON CONFLICT (company_name) DO NOTHING;", (row['Company Name'], row['Total Works']))
            cur.execute("SELECT company_id FROM dim_company WHERE company_name = %s;", (row['Company Name'],))
            company_map[row['Company Name']] = cur.fetchone()[0]
        except Exception as e:
            print(f"Error inserting company {row['Company Name']}: {e}")
            conn.rollback()
    conn.commit()
    print("dim_company populated.")

    print("Inserting into dim_author...")
    for _, row in df_authors.iterrows():
        try:
            if not row['Author Name']: continue
            birthday = row.get('Birthday')
            parsed_birthday = None
            if isinstance(birthday, str) and birthday.strip():
                try:
                    if re.search(r'\d{4}', birthday):
                        parsed_birthday = pd.to_datetime(birthday).strftime('%Y-%m-%d')
                    else:
                        parsed_birthday = pd.to_datetime(f"{birthday}, 1900").strftime('%Y-%m-%d')
                except Exception as e:
                    print(f"Warning: Could not parse birthday '{birthday}' for author '{row['Author Name']}': {e}. Setting to NULL.")
            
            cur.execute("""
                INSERT INTO dim_author (author_name, given_name, family_name, birthday, website, member_favorites)
                VALUES (%s, %s, %s, %s, %s, %s) ON CONFLICT (author_name) DO NOTHING;
            """, (row['Author Name'], row['Given Name'], row['Family Name'], parsed_birthday, row['Website'], row['Member Favorites']))
            cur.execute("SELECT author_id FROM dim_author WHERE author_name = %s;", (row['Author Name'],))
            author_map[row['Author Name']] = cur.fetchone()[0]
        except Exception as e:
            print(f"Error inserting author {row['Author Name']}: {e}")
            conn.rollback()
    conn.commit()
    print("dim_author populated.")

    print("Inserting into dim_genre...")
    for _, row in df_genres.iterrows():
        try:
            if not row['Genre Name']: continue
            cur.execute("INSERT INTO dim_genre (genre_name, total_works, description) VALUES (%s, %s, %s) ON CONFLICT (genre_name) DO NOTHING;", (row['Genre Name'], row['Total Works'], row['Description']))
            cur.execute("SELECT genre_id FROM dim_genre WHERE genre_name = %s;", (row['Genre Name'],))
            genre_map[row['Genre Name']] = cur.fetchone()[0]
        except Exception as e:
            print(f"Error inserting genre {row['Genre Name']}: {e}")
            conn.rollback()
    conn.commit()
    print("dim_genre populated.")

    print("Inserting into dim_character...")
    for _, row in df_characters.iterrows():
        try:
            if not row['Character Name']: continue
            member_favorites = int(row['Member Favorites']) if row['Member Favorites'] else None
            cur.execute("""
                INSERT INTO dim_character (character_name, role, member_favorites)
                VALUES (%s, %s, %s) ON CONFLICT (character_name) DO NOTHING;
            """, (row['Character Name'], row['Role'], member_favorites))
            cur.execute("SELECT character_id FROM dim_character WHERE character_name = %s;", (row['Character Name'],))
            character_map[row['Character Name']] = cur.fetchone()[0]
        except Exception as e:
            print(f"Error inserting character {row['Character Name']}: {e}")
            conn.rollback()
    conn.commit()
    print("dim_character populated.")

    print("Inserting into dim_manhwa and fact tables...")
    for _, row in df_manhwa.iterrows():
        try:
            if not row['Title']: continue

            published_start_year = None
            published_end_year = None
            published = row.get('Published')
            if isinstance(published, list) and published:
                published_str = ' '.join(published)
                years = re.findall(r'\d{4}', published_str)
                if years:
                    published_start_year = int(years[0])
                if len(years) > 1:
                    published_end_year = int(years[1])

            serialization_name = row['Serialization'][0] if isinstance(row['Serialization'], list) and row['Serialization'] else None
            
            cur.execute("""
                INSERT INTO dim_manhwa (title, status, serialization, published_start_year, published_end_year)
                VALUES (%s, %s, %s, %s, %s) ON CONFLICT (title) DO NOTHING;
            """, (row['Title'], row['Status'], serialization_name, published_start_year, published_end_year))
            cur.execute("SELECT manhwa_id FROM dim_manhwa WHERE title = %s;", (row['Title'],))
            manhwa_id = cur.fetchone()[0]
            manhwa_map[row['Title']] = manhwa_id
            
            company_id = company_map.get(serialization_name)

            score = float(row['Score']) if row['Score'] else None
            chapters = int(row['Chapters']) if row['Chapters'] else None
            cur.execute("""
                INSERT INTO fact_manhwa (manhwa_id, company_id, score, chapters)
                VALUES (%s, %s, %s, %s);
            """, (manhwa_id, company_id, score, chapters))
            
            if row['Authors']:
                for author_name in row['Authors']:
                    author_id = author_map.get(author_name)
                    if author_id:
                        cur.execute("INSERT INTO fact_manhwa_authors (manhwa_id, author_id) VALUES (%s, %s);", (manhwa_id, author_id))

            if row['Genres']:
                for genre_name in row['Genres']:
                    genre_id = genre_map.get(genre_name)
                    if genre_id:
                        cur.execute("INSERT INTO fact_manhwa_genres (manhwa_id, genre_id) VALUES (%s, %s);", (manhwa_id, genre_id))

            for _, char_row in df_characters.iterrows():
                mangaography = char_row.get('Mangaography')
                if mangaography and row['Title'] in mangaography:
                    character_id = character_map.get(char_row['Character Name'])
                    if character_id:
                        cur.execute("INSERT INTO fact_manhwa_characters (manhwa_id, character_id) VALUES (%s, %s);", (manhwa_id, character_id))

            conn.commit()
        except Exception as e:
            print(f"Error during processing manhwa {row['Title']}: {e}")
            conn.rollback()

    cur.close()
    print("All data insertion attempts completed.")

def main():
    """Main function to run the ETL process."""
    print("Starting ETL process...")
    try:
        import psycopg2
        import pandas as pd
        import os
    except ImportError:
        print("Required libraries not found. Installing 'psycopg2-binary', 'pandas', and 'os'...")
        import subprocess
        subprocess.check_call(['pip', 'install', 'psycopg2-binary', 'pandas'])
        print("Libraries installed. Restarting script...")
        import sys
        os.execv(sys.executable, ['python'] + sys.argv)
        return

    conn = connect_db()
    if conn:
        try:
            with conn.cursor() as cur:
                create_tables(cur)
            insert_data(conn)
            print("ETL process completed successfully!")
        except Exception as e:
            conn.rollback()
            print(f"An error occurred during ETL: {e}")
        finally:
            conn.close()

if __name__ == "__main__":
    main()