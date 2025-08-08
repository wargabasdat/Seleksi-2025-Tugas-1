import os
import json
import mysql.connector

DB_NAME = "seleksi_basdat_new"
DB_USER = "root"
DB_PASSWORD = "4L1y42003" # sesuaikan dengan password MySQL
DB_HOST = "localhost"
DB_PORT = 3306

# helper
def to_bool(value):
    return value.lower() == "supported"

def load_json(filename):
    base_path = os.path.abspath(
        os.path.join(os.path.dirname(__file__), "..", "..", "Data Scraping", "data", "preprocessed")
    )
    path = os.path.join(base_path, filename)
    with open(path, "r", encoding="utf-8") as f:
        return json.load(f)

def parse_int(val):
    try:
        return int(val)
    except:
        return 0


# setup DB dan tabel
def create_tables():
    conn = mysql.connector.connect(
        host=DB_HOST, user=DB_USER, password=DB_PASSWORD, port=DB_PORT
    )
    cursor = conn.cursor()
    cursor.execute(f"CREATE DATABASE IF NOT EXISTS {DB_NAME};")
    cursor.execute(f"USE {DB_NAME};")

    commands = [
        """
        CREATE TABLE IF NOT EXISTS Monetization_Level (
            level_id INT AUTO_INCREMENT PRIMARY KEY,
            min_RBM INT,
            monthly_bonus INT
        );
        """,
        """
        CREATE TABLE IF NOT EXISTS Creator (
            creator_id INT AUTO_INCREMENT PRIMARY KEY,
            name VARCHAR(255),
            friends INT,
            followers INT,
            following INT, 
            level_id INT,
            FOREIGN KEY (level_id) REFERENCES Monetization_Level(level_id)
        );
        """,
        """
        CREATE TABLE IF NOT EXISTS Community (
            community_id INT AUTO_INCREMENT PRIMARY KEY,
            name TEXT,
            member INT,
            creator_id INT,
            FOREIGN KEY (creator_id) REFERENCES Creator(creator_id)
        );
        """,
        """
        CREATE TABLE IF NOT EXISTS Genre (
            genre_id INT AUTO_INCREMENT PRIMARY KEY,
            genre VARCHAR(255)
        );
        """,
        """
        CREATE TABLE IF NOT EXISTS Maturity (
            maturity_id INT AUTO_INCREMENT PRIMARY KEY,
            maturity VARCHAR(255),
            description VARCHAR(500)
        );
        """,
        """
        CREATE TABLE IF NOT EXISTS Server (
            server_id INT AUTO_INCREMENT PRIMARY KEY,
            server_size INT,
            is_private_available BOOLEAN,
            server_region VARCHAR(255),
            server_status BOOLEAN
        );
        """,
        """
        CREATE TABLE IF NOT EXISTS Game (
            game_id BIGINT PRIMARY KEY,
            title TEXT,
            voice_chat BOOLEAN,
            camera BOOLEAN,
            date_created DATE,
            last_updated DATE,
            community_id INT,
            maturity_id INT,
            genre_id INT,
            server_id INT,
            url TEXT,
            FOREIGN KEY (community_id) REFERENCES Community(community_id),
            FOREIGN KEY (genre_id) REFERENCES Genre(genre_id),
            FOREIGN KEY (maturity_id) REFERENCES Maturity(maturity_id),
            FOREIGN KEY (server_id) REFERENCES Server(server_id)
        );
        """,
        """
        CREATE TABLE IF NOT EXISTS Statistics (
            game_id BIGINT,
            date DATE,
            active_users INT,
            favorites INT,
            visits INT,
            PRIMARY KEY (game_id, date),
            FOREIGN KEY (game_id) REFERENCES Game(game_id)
        );
        """
    ]

    for command in commands:
        cursor.execute(command)

    conn.commit()
    return conn, cursor

# inserting data
def insert_data(cursor):
    cursor.execute(f"USE {DB_NAME}")

    # genre
    genres = load_json("genre_preprocessed.json")
    for genre in genres:
        cursor.execute(
            "INSERT IGNORE INTO Genre (genre_id, genre) VALUES (%s, %s)",
            (genre["genre_id"], genre["genre_name"])
        )

    # maturity
    maturities = load_json("maturity_preprocessed.json")
    for maturity in maturities:
        cursor.execute(
            "INSERT IGNORE INTO Maturity (maturity_id, maturity) VALUES (%s, %s)",
            (maturity["maturity_id"], maturity["maturity_level"])
        )

    # server
    servers = load_json("server_preprocessed.json")
    for server in servers:
        cursor.execute(
            "INSERT IGNORE INTO Server (server_id, server_size) VALUES (%s, %s)",
            (server["server_id"], server["server_size"])
        )

    # creator
    creators = load_json("creator_preprocessed.json")
    for creator in creators:
        cursor.execute("""
            INSERT IGNORE INTO Creator (creator_id, name, friends, followers, following)
            VALUES (%s, %s, %s, %s, %s)
        """, (
            creator["creatorID"],
            creator["Creator Name"],
            parse_int(creator["Friends"]),
            parse_int(creator["Followers"]),
            parse_int(creator["Following"])
        ))

    # community
    communities = load_json("community_preprocessed.json")
    for community in communities:
        cursor.execute("""
            INSERT IGNORE INTO Community (community_id, name, member, creator_id)
            VALUES (%s, %s, %s, %s)
        """, (
            community["communityID"],
            community["Community Name"],
            community["Members"],
            community["creatorID"]
        ))

    # game + statistics
    games = load_json("game_preprocessed.json")
    for game in games:
        cursor.execute("""
            INSERT IGNORE INTO Game (
                game_id, title, voice_chat, camera, date_created, last_updated,
                community_id, maturity_id, genre_id, server_id, url
            ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """, (
            int(game["gameID"]),
            game["Title"],
            to_bool(game["Voice Chat"]),
            to_bool(game["Camera"]),
            game["Date Created"],
            game["Last Updated"],
            game["communityID"],
            game["maturity_id"],
            game["genreID"],
            game["server_id"],
            game["URL"]
        ))

        cursor.execute("""
            INSERT IGNORE INTO Statistics (game_id, date, active_users, favorites, visits)
            VALUES (%s, %s, %s, %s, %s)
        """, (
            int(game["gameID"]),
            game["Date"],
            game["Active Users"],
            game["Favorites"],
            game["Total Visits"]
        ))

if __name__ == "__main__":
    conn, cursor = create_tables()
    insert_data(cursor)
    conn.commit()
    cursor.close()
    conn.close()
  
