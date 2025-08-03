import mariadb
import sys
import json
import os
import getpass
from datetime import datetime

def get_db_connection(config):
    try:
        conn = mariadb.connect(**config)
        return conn
    except mariadb.Error as e:
        print(f"Error connecting to MariaDB: {e}")
        return None
    
def get_credentials_from_config(path='config.json'):
    try:
        with open(path, 'r') as f:
            config = json.load(f)
            return config.get('db_user'), config.get('db_password')
    except FileNotFoundError:
        print(f"Error: MariaDB config file not found.")
        return None, None

def get_credentials_manually():
    db_user = input("Enter your MariaDB username: ")
    db_password = getpass.getpass("Enter your MariaDB password: ")
    return db_user, db_password

def main():
    if "--auto" in sys.argv:
        db_user, db_password = get_credentials_from_config()
        if not db_user or not db_password:
            sys.exit(1)
    else:
        db_user, db_password = get_credentials_manually()
        
    db_name = "ncis_dw"

    initial_config = {
        'user': db_user, 'password': db_password, 
        'host': '127.0.0.1', 'port': 3306
    }
    conn = get_db_connection(initial_config)
    if not conn:
        sys.exit(1)
        
    cursor = conn.cursor()
    try:
        cursor.execute(f"DROP DATABASE IF EXISTS `{db_name}`;")
        cursor.execute(f"CREATE DATABASE `{db_name}` CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci';")
        print(f"Database '{db_name}' is ready.")
    except mariadb.Error as e:
        print(f"Error creating database: {e}")
        sys.exit(1)
    conn.close()

    db_config = {**initial_config, 'database': db_name}

    # define tables
    TABLES = {}

    TABLES['DimEpisode'] = """
        CREATE TABLE DimEpisode (
            episode_id INT PRIMARY KEY,
            season INT NOT NULL,
            episode_in_season INT NOT NULL,
            title VARCHAR(255),
            summary TEXT,
            CONSTRAINT chk_season CHECK (season >= 1),
            CONSTRAINT chk_episode_in_season CHECK (episode_in_season >= 1)
        ) ENGINE=InnoDB;
    """

    TABLES['DimDate'] = """
        CREATE TABLE DimDate (
            date_id INT PRIMARY KEY,
            air_date DATE,
            day INT CHECK (day >= 1 AND day <= 31),
            month INT CHECK (month >= 1 AND month <= 12),
            year INT CHECK (year >= 2000 AND year <= 2050)
        ) ENGINE=InnoDB;
    """

    TABLES['DimPersonnel'] = """
        CREATE TABLE DimPersonnel (
            personnel_id INT AUTO_INCREMENT PRIMARY KEY,
            name VARCHAR(255) UNIQUE
        ) ENGINE=InnoDB;
    """
    TABLES['FactEpisodePerformance'] = """
        CREATE TABLE FactEpisodePerformance (
            episode_id INT,
            date_id INT,
            rating_value FLOAT CHECK (rating_value >= 0),
            rating_count INT CHECK (rating_count >= 0),
            comment_count INT CHECK (comment_count >= 0),
            last_updated TIMESTAMP NOT NULL,
            PRIMARY KEY (episode_id),
            FOREIGN KEY (episode_id) REFERENCES DimEpisode(episode_id) ON DELETE CASCADE,
            FOREIGN KEY (date_id) REFERENCES DimDate(date_id) ON DELETE SET NULL
        ) ENGINE=InnoDB;
    """

    TABLES['BridgeCrewInvolvement'] = """
        CREATE TABLE BridgeCrewInvolvement (
            episode_id INT,
            personnel_id INT,
            role VARCHAR(255),
            status ENUM('Main', 'Guest') NOT NULL,
            PRIMARY KEY (episode_id, personnel_id, role),
            FOREIGN KEY (episode_id) REFERENCES DimEpisode(episode_id) ON DELETE CASCADE,
            FOREIGN KEY (personnel_id) REFERENCES DimPersonnel(personnel_id) ON DELETE CASCADE
        ) ENGINE=InnoDB;
    """

    TABLES['BridgeCastInvolvement'] = """
        CREATE TABLE BridgeCastInvolvement (
            episode_id INT,
            personnel_id INT,
            character_name VARCHAR(255),
            status ENUM('Main', 'Guest') NOT NULL,
            PRIMARY KEY (episode_id, personnel_id, character_name),
            FOREIGN KEY (episode_id) REFERENCES DimEpisode(episode_id) ON DELETE CASCADE,
            FOREIGN KEY (personnel_id) REFERENCES DimPersonnel(personnel_id) ON DELETE CASCADE
        ) ENGINE=InnoDB;
    """

    conn = get_db_connection(db_config)
    if not conn: 
        sys.exit(1)
    cursor = conn.cursor()
    
    try:
        # temporarily disable foreign key checks
        cursor.execute("SET FOREIGN_KEY_CHECKS=0;")

        # create tables
        print("\nCreating data warehouse tables...")
        for table_name in TABLES:
            cursor.execute(TABLES[table_name])
            print(f"Table '{table_name}' is ready.")
        
        data_dir = os.path.join(os.path.dirname(__file__), "..", "..", "Data Scraping", "data")

        with open(os.path.join(data_dir, 'episodes.json'), 'r', encoding='utf-8') as f: episodes = json.load(f)
        with open(os.path.join(data_dir, 'casts.json'), 'r', encoding='utf-8') as f: casts = json.load(f)
        with open(os.path.join(data_dir, 'crews.json'), 'r', encoding='utf-8') as f: crews = json.load(f)
        with open(os.path.join(data_dir, 'comments.json'), 'r', encoding='utf-8') as f: comments = json.load(f)

        print("\nLoading data into fact, dimension, and bridge tables...")
        
        unique_dates = {e['air_date'] for e in episodes if e['air_date']}
        date_map = {}
        for date_str in unique_dates:
            dt = datetime.strptime(date_str, "%Y-%m-%d")
            date_key = int(dt.strftime("%Y%m%d"))
            date_map[date_str] = date_key
            cursor.execute("INSERT INTO DimDate (date_id, air_date, year, month, day) VALUES (?, ?, ?, ?, ?)",
                           (date_key, dt.date(), dt.year, dt.month, dt.day))
        print(f"Loaded {len(date_map)} dates.")
        
        unique_people = {p['actor'] for p in casts} | {p['name'] for p in crews}
        cursor.executemany("INSERT INTO DimPersonnel (name) VALUES (?)", [(name,) for name in unique_people])
        cursor.execute("SELECT name, personnel_id FROM DimPersonnel")
        person_map = {name: key for name, key in cursor}
        episode_sql = "INSERT INTO DimEpisode (episode_id, title, season, episode_in_season, summary) VALUES (?, ?, ?, ?, ?)"
        episode_data = [(e['episode_id'], e['title'], e['season'], e['episode_in_season'], e['summary']) for e in episodes]
        cursor.executemany(episode_sql, episode_data)
        print(f"Loaded {cursor.rowcount} episodes.")
        
        comment_counts = {}
        for c in comments:
            ep_id = c['episode_id']
            comment_counts[ep_id] = comment_counts.get(ep_id, 0) + 1

        current_timestamp = datetime.now()
        fact_performance_data = []
        for e in episodes:
            date_key = date_map.get(e['air_date'])
            if date_key:
                fact_performance_data.append((
                    e['episode_id'], 
                    date_key, 
                    e.get('rating_value'), 
                    e.get('rating_count'), 
                    comment_counts.get(e['episode_id'], 0),
                    current_timestamp 
                ))
        fact_sql = "INSERT INTO FactEpisodePerformance (episode_id, date_id, rating_value, rating_count, comment_count, last_updated) VALUES (?, ?, ?, ?, ?, ?)"
        cursor.executemany(fact_sql, fact_performance_data)
        print(f"Loaded {cursor.rowcount} episode performance records.")

        cast_bridge_data = [(c['episode_id'], person_map[c['actor']], c['character'], c['status']) for c in casts]
        cast_sql = "INSERT INTO BridgeCastInvolvement (episode_id, personnel_id, character_name, status) VALUES (?, ?, ?, ?)"
        cursor.executemany(cast_sql, cast_bridge_data)
        print(f"Loaded {cursor.rowcount} cast involvements.")
        
        crew_bridge_data = [(c['episode_id'], person_map[c['name']], c['role'], c['status']) for c in crews]
        crew_sql = "INSERT INTO BridgeCrewInvolvement (episode_id, personnel_id, role, status) VALUES (?, ?, ?, ?)"
        cursor.executemany(crew_sql, crew_bridge_data)
        print(f"Loaded {cursor.rowcount} crew involvements.")

        conn.commit()
        print("\nAll data loaded into the data warehouse successfully.")

    except mariadb.Error as e:
        print(f"An error occurred: {e}")
        conn.rollback()
    except FileNotFoundError as e:
        print(f"JSON file not found: {e}")

    finally:
        # reenable foreign key checks
        cursor.execute("SET FOREIGN_KEY_CHECKS=1;")

        cursor.close()
        conn.close()

if __name__ == "__main__":
    main()