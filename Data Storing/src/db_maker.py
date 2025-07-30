import mariadb
import sys
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
        cursor.execute(f"CREATE DATABASE IF NOT EXISTS `{db_name}` CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci';")
        print(f"Database '{db_name}' is ready.")
    except mariadb.Error as e:
        print(f"Error creating database: {e}")
        sys.exit(1)
    conn.close()

    db_config = {**initial_config, 'database': db_name}

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
            season INT,
            episode_in_season INT CHECK (episode_in_season >= 1),
            title VARCHAR(255),
            air_date DATE,
            summary TEXT,
            rating_value FLOAT CHECK (rating_value >= 0),
            rating_count INT CHECK (rating_count >= 0)
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
            PRIMARY KEY (episode_id, name),
            FOREIGN KEY (episode_id) REFERENCES Episode(episode_id) ON DELETE CASCADE,
            FOREIGN KEY (name) REFERENCES Personnel(name) ON DELETE CASCADE
        ) ENGINE=InnoDB;
        """
    
    conn = get_db_connection(db_config)
    if not conn:
        sys.exit(1)
        
    cursor = conn.cursor()
    
    try:
        # temporarily disables foreign key checks 
        cursor.execute("SET FOREIGN_KEY_CHECKS=0;")

        print("\nCreating tables...")
        for table_name in TABLES:
            table_sql = TABLES[table_name]
            try:
                cursor.execute(table_sql)
                print(f"Table '{table_name}' created successfully.")
            except mariadb.Error as e:
                print(f"\nError creating table '{table_name}': {e}")

    finally:
        # reenables foreign key checks
        cursor.execute("SET FOREIGN_KEY_CHECKS=1;")

        cursor.close()
        conn.close()
        print("\nAll tables created successfully in the database.")

if __name__ == "__main__":
    main()