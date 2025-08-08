import json
import os
import mysql.connector

current_dir = os.path.dirname(os.path.abspath(__file__))
base_dir = os.path.abspath(os.path.join(current_dir, '..', '..'))
data_dir = os.path.join(base_dir, 'Data Scraping', 'data')

def connect_to_db():
    try:
        conn = mysql.connector.connect(
            host="localhost",
            user="root",
            password="Azkarayan",
            database="kpop_awards",
            auth_plugin='mysql_native_password',
            port=3307
        )
        print("Koneksi database MariaDB berhasil!")
        return conn
    except mysql.connector.Error as err:
        print(f"Error: Gagal terhubung ke database. {err}")
        return None

def create_tables(cur):
    print("Membuat tabel...")

    cur.execute("""
        CREATE TABLE IF NOT EXISTS `Show` (
            name VARCHAR(255) PRIMARY KEY,
            schedule VARCHAR(255),
            episode INT,
            station VARCHAR(255)
        );
    """)

    cur.execute("""
        CREATE TABLE IF NOT EXISTS `Artist` (
            name VARCHAR(255) PRIMARY KEY,
            debut_date DATE,
            views BIGINT
        );
    """)

    cur.execute("""
        CREATE TABLE IF NOT EXISTS `Song` (
            id INT PRIMARY KEY,
            name VARCHAR(255),
            artist_name VARCHAR(255),
            FOREIGN KEY (artist_name) REFERENCES `Artist` (name)
        );
    """)

    cur.execute("""
        CREATE TABLE IF NOT EXISTS `Award` (
            show_name VARCHAR(255),
            year INT,
            week INT,
            song_id INT,
            PRIMARY KEY (show_name, year, week),
            FOREIGN KEY (show_name) REFERENCES `Show` (name),
            FOREIGN KEY (song_id) REFERENCES `Song` (id)
        );
    """)
    print("Tabel berhasil dibuat.")

def insert_data_into_tables(conn, cur):
    try:
        with open(os.path.join(data_dir, 'show.json'), 'r', encoding='utf-8') as f:
            shows = json.load(f)
        with open(os.path.join(data_dir, 'artists.json'), 'r', encoding='utf-8') as f:
            artists = json.load(f)
        with open(os.path.join(data_dir, 'song.json'), 'r', encoding='utf-8') as f:
            songs = json.load(f)
        with open(os.path.join(data_dir, 'awards.json'), 'r', encoding='utf-8') as f:
            awards = json.load(f)

        print("Memasukkan data ke tabel 'Show'...")
        insert_show_sql = "INSERT IGNORE INTO `Show` (name, schedule, episode, station) VALUES (%s, %s, %s, %s);"
        for show in shows:
            cur.execute(insert_show_sql, (show['name'], show['schedule'], show['episode'], show['station']))
        print("Data 'Show' berhasil dimasukkan.")

        print("Memasukkan data ke tabel 'Artist'...")
        insert_artist_sql = "INSERT IGNORE INTO `Artist` (name, debut_date, views) VALUES (%s, %s, %s);"
        for artist in artists:
            cur.execute(insert_artist_sql, (artist['name'], artist['debut_date'], artist['views']))
        print("Data 'Artist' berhasil dimasukkan.")

        print("Memasukkan data ke tabel 'Song'...")
        insert_song_sql = "INSERT IGNORE INTO `Song` (id, name, artist_name) VALUES (%s, %s, %s);"
        for song in songs:
            cur.execute(insert_song_sql, (song['id'], song['song'], song['group']))
        print("Data 'Song' berhasil dimasukkan.")

        print("Memasukkan data ke tabel 'Award'...")
        insert_award_sql = "INSERT IGNORE INTO `Award` (show_name, year, week, song_id) VALUES (%s, %s, %s, %s);"
        for award in awards:
            cur.execute(insert_award_sql, (award['show'], award['year'], award['week'], award['group_song_id']))
        print("Data 'Award' berhasil dimasukkan.")
        
        conn.commit()
        print("Semua data berhasil disimpan.")

    except FileNotFoundError as e:
        print(f"Error: {e}. Pastikan file JSON berada di jalur yang benar.")
    except Exception as e:
        conn.rollback()
        print(f"Error saat memasukkan data: {e}")
        print("Transaksi dibatalkan.")
    finally:
        cur.close()
        conn.close()
        print("Koneksi database ditutup.")


if __name__ == '__main__':
    conn = connect_to_db()
    if conn:
        with conn.cursor() as cur:
            create_tables(cur)
            insert_data_into_tables(conn, cur)
