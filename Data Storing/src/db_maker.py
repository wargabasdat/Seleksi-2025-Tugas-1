import mariadb
import sys
import json
import os
import getpass

def get_db_connection(config):
    try:
        conn = mariadb.connect(**config)
        return conn
    except mariadb.Error as e:
        print(f"Error connecting to MariaDB: {e}")
        return None

def main():
    db_user = input("Enter your MariaDB username: ")
    db_password = getpass.getpass("Enter your MariaDB password: ")
    db_name = "ncis_db"

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
    TABLES['Personnel'] = """
        CREATE OR REPLACE TABLE Personnel (
            name VARCHAR(255) PRIMARY KEY
        ) ENGINE=InnoDB;
        """

    TABLES['User'] = """
        CREATE OR REPLACE TABLE User (
            username VARCHAR(255) PRIMARY KEY
        ) ENGINE=InnoDB;
        """

    TABLES['Episode'] = """
        CREATE OR REPLACE TABLE Episode (
            episode_id INT PRIMARY KEY, 
            season INT NOT NULL,
            episode_in_season INT NOT NULL,
            title VARCHAR(255),
            air_date DATE,
            summary TEXT,
            rating_value FLOAT CHECK (rating_value >= 0),
            rating_count INT CHECK (rating_count >= 0),
            CONSTRAINT chk_season CHECK (season >= 1),
            CONSTRAINT chk_episode_in_season CHECK (episode_in_season >= 1)
        ) ENGINE=InnoDB;
        """

    TABLES['Comment'] = """
        CREATE OR REPLACE TABLE Comment (
            episode_id INT,
            comment_number INT CHECK (comment_number >= 1),
            username VARCHAR(255),
            content TEXT,
            upvote_count INT CHECK (upvote_count >= 0),
            downvote_count INT CHECK (downvote_count >= 0),
            PRIMARY KEY (episode_id, comment_number),
            FOREIGN KEY (episode_id) REFERENCES Episode(episode_id) ON DELETE CASCADE,
            FOREIGN KEY (username) REFERENCES User(username) ON DELETE SET NULL
        ) ENGINE=InnoDB;
        """

    TABLES['Crew'] = """
        CREATE OR REPLACE TABLE Crew (
            episode_id INT,
            name VARCHAR(255),
            role VARCHAR(255),
            status ENUM('Main', 'Guest') NOT NULL,
            PRIMARY KEY (episode_id, name, role),
            FOREIGN KEY (episode_id) REFERENCES Episode(episode_id) ON DELETE CASCADE,
            FOREIGN KEY (name) REFERENCES Personnel(name) ON DELETE CASCADE
        ) ENGINE=InnoDB;
        """

    TABLES['Cast'] = """
        CREATE OR REPLACE TABLE Cast (
            episode_id INT,
            name VARCHAR(255),
            character_name VARCHAR(255) NOT NULL,
            status ENUM('Main', 'Guest') NOT NULL,
            PRIMARY KEY (episode_id, name, character_name),
            FOREIGN KEY (episode_id) REFERENCES Episode(episode_id) ON DELETE CASCADE,
            FOREIGN KEY (name) REFERENCES Personnel(name) ON DELETE CASCADE
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
        print("\nCreating tables...")
        for table_name in TABLES:
            cursor.execute(TABLES[table_name])
            print(f"Table '{table_name}' is ready.")
        
        data_dir = os.path.join(os.path.dirname(__file__), "..", "..", "Data Scraping", "data")
        
        # load data from json
        print ("\nLoading data into tables...")

        with open(os.path.join(data_dir, 'casts.json'), 'r', encoding='utf-8') as f:
            casts = json.load(f)
        with open(os.path.join(data_dir, 'crews.json'), 'r', encoding='utf-8') as f:
            crews = json.load(f)
        personnel_names = {p['actor'] for p in casts} | {p['name'] for p in crews}
        cursor.executemany("INSERT INTO Personnel (name) VALUES (?)", [(name,) for name in personnel_names])
        print(f"Loaded {cursor.rowcount} personnel.")

        with open(os.path.join(data_dir, 'comments.json'), 'r', encoding='utf-8') as f:
            comments = json.load(f)
        usernames = {c['username'] for c in comments}
        cursor.executemany("INSERT INTO User (username) VALUES (?)", [(user,) for user in usernames])
        print(f"Loaded {cursor.rowcount} users.")

        with open(os.path.join(data_dir, 'episodes.json'), 'r', encoding='utf-8') as f:
            episodes = json.load(f)
        ep_sql = "INSERT INTO Episode (episode_id, season, episode_in_season, title, air_date, summary, rating_value, rating_count) VALUES (?, ?, ?, ?, ?, ?, ?, ?)"
        cursor.executemany(ep_sql, [(e['episode_id'], e['season'], e['episode_in_season'], e['title'], e['air_date'], e['summary'], e.get('rating_value'), e.get('rating_count')) for e in episodes])
        print(f"Loaded {cursor.rowcount} episodes.")

        cast_sql = "INSERT INTO Cast (episode_id, name, character_name, status) VALUES (?, ?, ?, ?)"
        cursor.executemany(cast_sql, [(c['episode_id'], c['actor'], c['character'], c['status']) for c in casts])
        print(f"Loaded {cursor.rowcount} cast appearances.")

        crew_sql = "INSERT INTO Crew (episode_id, name, role, status) VALUES (?, ?, ?, ?)"
        cursor.executemany(crew_sql, [(c['episode_id'], c['name'], c['role'], c['status']) for c in crews])
        print(f"Loaded {cursor.rowcount} crew appearances.")

        comment_sql = "INSERT INTO Comment (episode_id, comment_number, username, content, upvote_count, downvote_count) VALUES (?, ?, ?, ?, ?, ?)"
        cursor.executemany(comment_sql, [(c['episode_id'], c['comment_number'], c['username'], c['content'], c.get('upvote_count'), c.get('downvote_count')) for c in comments])
        print(f"Loaded {cursor.rowcount} comments.")

        conn.commit()
        print("\nAll data loaded to the database successfully.")

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