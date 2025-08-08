import json
import psycopg2
from psycopg2.extras import execute_values

# fungsi untuk menyambungkan ke database
def connect_to_db():
    try:
        conn = psycopg2.connect(
            host="localhost",
            database="kalmstudios",
            user="your_username",          # Ganti sesuai username
            password="your_password", # Ganti sesuai password
            port="5432"
        )
        return conn
    except Exception as e:
        print(f"Connection failed: {e}")
        return None

# fungsi untuk membuat tabel pada database
def create_tables(conn):
    create_table_queries = [
        # Categories
        """
        CREATE TABLE IF NOT EXISTS categories (
            category_id INTEGER PRIMARY KEY,
            category_name VARCHAR(20) NOT NULL UNIQUE
        );
        """,
        
        # Classes
        """
        CREATE TABLE IF NOT EXISTS classes (
            class_id VARCHAR(50) PRIMARY KEY,
            name VARCHAR(60) NOT NULL,
            category_id INTEGER NOT NULL,
            duration INTEGER,
            difficulty_level VARCHAR(20),
            location VARCHAR(30),
            about_class_description TEXT,
            FOREIGN KEY (category_id) REFERENCES categories(category_id)
        );
        """,
        
        # Equipment
        """
        CREATE TABLE IF NOT EXISTS equipment (
            equipment_id SERIAL PRIMARY KEY,
            equipment_name VARCHAR(20) NOT NULL UNIQUE
        );
        """,
        
        # Class_Equipment (Junction table)
        """
        CREATE TABLE IF NOT EXISTS class_equipment (
            class_id VARCHAR(50) NOT NULL,
            equipment_id INTEGER NOT NULL,
            PRIMARY KEY (class_id, equipment_id),
            FOREIGN KEY (class_id) REFERENCES classes(class_id) ON DELETE CASCADE,
            FOREIGN KEY (equipment_id) REFERENCES equipment(equipment_id) ON DELETE CASCADE
        );
        """,
        
        # Instructors
        """
        CREATE TABLE IF NOT EXISTS instructors (
            instructor_id VARCHAR(20) PRIMARY KEY,
            name VARCHAR(30) NOT NULL,
            role VARCHAR(30)
        );
        """,
        
        # Reviews
        """
        CREATE TABLE IF NOT EXISTS reviews (
            review_order INTEGER NOT NULL,
            class_id VARCHAR(50) NOT NULL,
            instructor_reviewed VARCHAR(30),
            review_text TEXT,
            review_location VARCHAR(30),
            stars_rating INTEGER CHECK (stars_rating >= 1 AND stars_rating <= 5),
            PRIMARY KEY (class_id, review_order),
            FOREIGN KEY (class_id) REFERENCES classes(class_id) ON DELETE CASCADE
        );
        """,
        
        # Related Classes
        """
        CREATE TABLE IF NOT EXISTS related_classes (
            related_order INTEGER NOT NULL,
            main_class_id VARCHAR(50) NOT NULL,
            title VARCHAR(60),
            stars_rating DECIMAL(2,1),
            duration INTEGER,
            difficulty_level VARCHAR(20),
            description TEXT,
            PRIMARY KEY (main_class_id, related_order),
            FOREIGN KEY (main_class_id) REFERENCES classes(class_id) ON DELETE CASCADE
        );
        """,
        
        # Schedules
        """
        CREATE TABLE IF NOT EXISTS schedules (
            schedule_id VARCHAR(20) PRIMARY KEY,
            class_id VARCHAR(50) NOT NULL,
            instructor_id VARCHAR(20) NOT NULL,
            date DATE NOT NULL,
            start_time TIME,
            duration INTEGER,
            location VARCHAR(50),
            FOREIGN KEY (class_id) REFERENCES classes(class_id) ON DELETE CASCADE,
            FOREIGN KEY (instructor_id) REFERENCES instructors(instructor_id) ON DELETE CASCADE
        );
        """
    ]
    
    cursor = conn.cursor()
    
    for query in create_table_queries:
        try:
            cursor.execute(query)
            print("Table created successfully")
        except Exception as e:
            print(f"Error creating table: {e}")
    
    conn.commit()
    cursor.close()

# fungsi untuk mengimport data dari json ke database
def import_json_data(conn):  
    cursor = conn.cursor()
    
    # Import Categories
    with open('../../Data Scraping/data/preprocessed/final_categories.json', 'r', encoding='utf-8') as f:
        categories = json.load(f)
    
    for cat in categories:
        cursor.execute(
            "INSERT INTO categories (category_id, category_name) VALUES (%s, %s) ON CONFLICT (category_id) DO NOTHING",
            (cat['category_id'], cat['category_name'])
        )
    print(f"Imported {len(categories)} categories")
    
    # Import Classes
    with open('../../Data Scraping/data/preprocessed/final_classes.json', 'r', encoding='utf-8') as f:
        classes = json.load(f)
    
    for cls in classes:
        cursor.execute("""
            INSERT INTO classes (class_id, name, category_id, duration, difficulty_level, location, about_class_description) 
            VALUES (%s, %s, %s, %s, %s, %s, %s) ON CONFLICT (class_id) DO NOTHING
        """, (
            cls['class_id'], cls['name'], cls['category_id'], 
            cls['duration'], cls['difficulty_level'], cls['location'], cls['about_class_description']
        ))
    print(f"Imported {len(classes)} classes")
    
    # Import Equipment
    with open('../../Data Scraping/data/preprocessed/final_equipment.json', 'r', encoding='utf-8') as f:
        equipment = json.load(f)
    
    for eq in equipment:
        cursor.execute(
            "INSERT INTO equipment (equipment_id, equipment_name) VALUES (%s, %s) ON CONFLICT (equipment_id) DO NOTHING",
            (eq['equipment_id'], eq['equipment_name'])
        )
    print(f"Imported {len(equipment)} equipment types")
    
    # Import Class_Equipment (Junction table)
    with open('../../Data Scraping/data/preprocessed/final_class_equipment.json', 'r', encoding='utf-8') as f:
        class_equipment = json.load(f)
    
    for ce in class_equipment:
        cursor.execute(
            "INSERT INTO class_equipment (class_id, equipment_id) VALUES (%s, %s) ON CONFLICT (class_id, equipment_id) DO NOTHING",
            (ce['class_id'], ce['equipment_id'])
        )
    print(f"Imported {len(class_equipment)} class-equipment relationships")

    # Import Instructors
    with open('../../Data Scraping/data/preprocessed/final_instructors.json', 'r', encoding='utf-8') as f:
        instructors = json.load(f)
    
    for instructor in instructors:
        cursor.execute(
            "INSERT INTO instructors (instructor_id, name, role) VALUES (%s, %s, %s) ON CONFLICT (instructor_id) DO NOTHING",
            (instructor['instructor_id'], instructor['name'], instructor['role'])
        )
    print(f"Imported {len(instructors)} instructors")

    # Import Reviews
    with open('../../Data Scraping/data/preprocessed/final_reviews.json', 'r', encoding='utf-8') as f:
        reviews = json.load(f)
    
    for review in reviews:
        cursor.execute("""
            INSERT INTO reviews (review_order, class_id, instructor_reviewed, review_text, review_location, stars_rating) 
            VALUES (%s, %s, %s, %s, %s, %s) ON CONFLICT (review_order, class_id) DO NOTHING
        """, (
            review['review_order'], review['class_id'], review['instructor_reviewed'],
            review['review_text'], review['review_location'], review['stars_rating']
        ))
    print(f"Imported {len(reviews)} reviews")

    # Import Related Classes
    with open('../../Data Scraping/data/preprocessed/final_related_classes.json', 'r', encoding='utf-8') as f:
        related_classes = json.load(f)
    
    for related in related_classes:
        cursor.execute("""
            INSERT INTO related_classes (related_order, main_class_id, title, stars_rating, duration, difficulty_level, description) 
            VALUES (%s, %s, %s, %s, %s, %s, %s) ON CONFLICT (related_order, main_class_id) DO NOTHING
        """, (
            related['related_order'], related['main_class_id'], related['title'],
            related['stars_rating'], related['duration'],
            related['difficulty_level'], related['description']
        ))
    print(f"Imported {len(related_classes)} related classes")

    # Import Schedules
    with open('../../Data Scraping/data/preprocessed/final_schedules.json', 'r', encoding='utf-8') as f:
        schedules = json.load(f)
    
    for schedule in schedules:
        start_time_formatted = convert_to_time_format(schedule['start_time'])
        cursor.execute("""
            INSERT INTO schedules (schedule_id, class_id, instructor_id, date, start_time, duration, location) 
            VALUES (%s, %s, %s, %s, %s, %s, %s) ON CONFLICT (schedule_id) DO NOTHING
        """, (
            schedule['schedule_id'], schedule['class_id'], schedule['instructor_id'],
            schedule['date'], start_time_formatted, schedule['duration'], schedule['location']
        ))
    print(f"Imported {len(schedules)} schedules")

    conn.commit()
    cursor.close()

# fungsi untuk mengubah format waktu menjadi time
def convert_to_time_format(time_str):
    if not time_str:
        return None
    
    import re
    
    # Extract jam, menit, dan am/pm
    match = re.match(r'(\d{1,2}):(\d{2})(am|pm)', time_str.lower())
    if not match:
        return None
    
    hour = int(match.group(1))
    minute = int(match.group(2))
    period = match.group(3)
    
    # Convert ke format 24 jam
    if period == 'pm' and hour != 12:
        hour += 12
    elif period == 'am' and hour == 12:
        hour = 0
    
    return f"{hour:02d}:{minute:02d}:00"

# main
def main():
    # Connect ke database
    conn = connect_to_db()
    if not conn:
        return
    
    # Create tables
    create_tables(conn)
    
    # Import data
    import_json_data(conn)
    
    conn.close()
    print(f"\nImport completed yay")

if __name__ == "__main__":
    main()