import psycopg2
import json
from datetime import datetime, timedelta
from collections import defaultdict
import os

#fungsi untuk membuat koneksi ke data warehouse
def create_warehouse_connection():
    try:
        conn = psycopg2.connect(
            host="localhost",
            database="kalmstudios_warehouse",
            user="your_username",
            password="your_password",
            port="5432"
        )
        return conn
    except Exception as e:
        print(f"Warehouse connection failed: {e}")
        return None

# fungsi untuk membuat skema data warehouse
def create_warehouse_schema(conn):
    """Create Simplified Star Schema"""
    schema_queries = [
        # Dimension: Date
        """
        CREATE TABLE IF NOT EXISTS dim_date (
            date_key SERIAL PRIMARY KEY,
            full_date DATE NOT NULL UNIQUE,
            day_of_week VARCHAR(10),
            month_name VARCHAR(15),
            year INTEGER,
            is_weekend BOOLEAN DEFAULT FALSE
        );
        """,
        
        # Dimension: Classes  
        """
        CREATE TABLE IF NOT EXISTS dim_classes (
            class_key SERIAL PRIMARY KEY,
            class_id VARCHAR(50) NOT NULL UNIQUE,
            class_name VARCHAR(100),
            category_name VARCHAR(30),
            difficulty_level VARCHAR(30),
            duration_minutes INTEGER,
            location VARCHAR(50)
        );
        """,
        
        # Dimension: Instructors
        """
        CREATE TABLE IF NOT EXISTS dim_instructors (
            instructor_key SERIAL PRIMARY KEY,
            instructor_id VARCHAR(30) NOT NULL UNIQUE,
            instructor_name VARCHAR(50),
            role VARCHAR(50)
        );
        """,
        
        # Dimension: Location
        """
        CREATE TABLE IF NOT EXISTS dim_location (
            location_key SERIAL PRIMARY KEY,
            location_name VARCHAR(50) NOT NULL UNIQUE
        );
        """,
        
        # Fact: Class Summary
        """
        CREATE TABLE IF NOT EXISTS fact_class_summary (
            summary_key SERIAL PRIMARY KEY,
            class_key INTEGER NOT NULL,
            instructor_key INTEGER,
            date_key INTEGER,
            location_key INTEGER NOT NULL,
            total_reviews INTEGER DEFAULT 0,
            avg_rating DECIMAL(3,2) DEFAULT 0.00,
            total_duration_hours DECIMAL(4,2) DEFAULT 0.00,
            equipment_count INTEGER DEFAULT 0,
            
            FOREIGN KEY (class_key) REFERENCES dim_classes(class_key),
            FOREIGN KEY (instructor_key) REFERENCES dim_instructors(instructor_key),
            FOREIGN KEY (date_key) REFERENCES dim_date(date_key),
            FOREIGN KEY (location_key) REFERENCES dim_location(location_key)
        );
        """
    ]
    
    cursor = conn.cursor()
    
    for i, query in enumerate(schema_queries, 1):
        try:
            cursor.execute(query)
        except Exception as e:
            print(f"Schema creation error at step {i}: {e}")
    
    conn.commit()
    cursor.close()
    print("Schema created")

# fungsi untuk memuat file JSON
def load_json_file(filepath):
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            return json.load(f)
    except Exception as e:
        print(f"Error loading {filepath}: {e}")
        return []

# fungsi untuk mengisi dimensi date dengan tanggal unik dari jadwal
def populate_dim_date(conn):
    cursor = conn.cursor()
    schedules = load_json_file('../../Data Scraping/data/preprocessed/final_schedules.json')
    
    unique_dates = set()
    for schedule in schedules:
        try:
            schedule_date = datetime.strptime(schedule['date'], '%Y-%m-%d').date()
            unique_dates.add(schedule_date)
        except:
            continue
    
    for date in sorted(unique_dates):
        day_of_week = date.strftime('%A')
        month_name = date.strftime('%B')
        year = date.year
        is_weekend = date.weekday() >= 5
        
        cursor.execute("""
            INSERT INTO dim_date (full_date, day_of_week, month_name, year, is_weekend)
            VALUES (%s, %s, %s, %s, %s)
            ON CONFLICT (full_date) DO NOTHING
        """, (date, day_of_week, month_name, year, is_weekend))
    
    conn.commit()
    print(f"Date dimension populated: {len(unique_dates)} dates")

# fungsi untuk mengisi dimensi classes dengan menggabungkan kelas dan kategori
def populate_dim_classes(conn):
    cursor = conn.cursor()
    
    classes = load_json_file('../../Data Scraping/data/preprocessed/final_classes.json')
    categories = load_json_file('../../Data Scraping/data/preprocessed/final_categories.json')
    
    category_lookup = {cat['category_id']: cat['category_name'] for cat in categories}
    
    for cls in classes:
        category_name = category_lookup.get(cls['category_id'], 'Unknown')
        
        cursor.execute("""
            INSERT INTO dim_classes (class_id, class_name, category_name, difficulty_level, duration_minutes, location)
            VALUES (%s, %s, %s, %s, %s, %s)
            ON CONFLICT (class_id) DO NOTHING
        """, (
            cls['class_id'],
            cls['name'],
            category_name,
            cls['difficulty_level'],
            cls['duration'],
            cls['location']
        ))
    
    conn.commit()
    print(f"Classes dimension populated: {len(classes)} classes")

# fungsi untuk mengisi dimensi instructors
def populate_dim_instructors(conn):
    cursor = conn.cursor()
    instructors = load_json_file('../../Data Scraping/data/preprocessed/final_instructors.json')
    
    for instructor in instructors:
        cursor.execute("""
            INSERT INTO dim_instructors (instructor_id, instructor_name, role)
            VALUES (%s, %s, %s)
            ON CONFLICT (instructor_id) DO NOTHING
        """, (
            instructor['instructor_id'],
            instructor['name'],
            instructor['role']
        ))
    
    conn.commit()
    print(f"Instructors dimension populated: {len(instructors)} instructors")

# fungsi untuk mengisi dimensi location dengan mengekstrak lokasi unik dari jadwal dan kelas
def populate_dim_location(conn):
    cursor = conn.cursor()
    
    classes = load_json_file('../../Data Scraping/data/preprocessed/final_classes.json')
    schedules = load_json_file('../../Data Scraping/data/preprocessed/final_schedules.json')
    
    locations = set()
    
    for cls in classes:
        if cls.get('location'):
            locations.add(cls['location'])
    
    for schedule in schedules:
        if schedule.get('location'):
            locations.add(schedule['location'])
    
    for location in locations:
        cursor.execute("""
            INSERT INTO dim_location (location_name)
            VALUES (%s)
            ON CONFLICT (location_name) DO NOTHING
        """, (location,))
    
    conn.commit()
    print(f"Location dimension populated: {len(locations)} locations")

# fungsi untuk mengisi fact table dengan ringkasan kelas yang mencakup review
def populate_fact_class_summary_complete(conn):
    cursor = conn.cursor()
    
    reviews = load_json_file('../../Data Scraping/data/preprocessed/final_reviews.json')
    schedules = load_json_file('../../Data Scraping/data/preprocessed/final_schedules.json')
    class_equipment = load_json_file('../../Data Scraping/data/preprocessed/final_class_equipment.json')
    
    cursor.execute("DELETE FROM fact_class_summary")
    
    # agregasi review per kelas
    class_reviews = defaultdict(list)
    for review in reviews:
        class_reviews[review['class_id']].append(review['stars_rating'])

    # Hitung metrik review per kelas
    class_review_metrics = {}
    for class_id, ratings in class_reviews.items():
        class_review_metrics[class_id] = {
            'total_reviews': len(ratings),
            'avg_rating': sum(ratings) / len(ratings) if ratings else 0
        }
    
    # hitung jumlah peralatan yang dibutuhkan per kelas
    class_equipment_count = defaultdict(int)
    for equipment in class_equipment:
        class_equipment_count[equipment['class_id']] += 1
    
    # Proses kelas yang terdapat di jadwal
    processed_count = 0
    
    for schedule in schedules:
        cursor.execute("SELECT class_key FROM dim_classes WHERE class_id = %s", (schedule['class_id'],))
        class_key_result = cursor.fetchone()
        if not class_key_result:
            continue
        class_key = class_key_result[0]
        
        cursor.execute("SELECT instructor_key FROM dim_instructors WHERE instructor_id = %s", 
                      (schedule['instructor_id'],))
        instructor_key_result = cursor.fetchone()
        if not instructor_key_result:
            continue
        instructor_key = instructor_key_result[0]
        
        try:
            schedule_date = datetime.strptime(schedule['date'], '%Y-%m-%d').date()
            cursor.execute("SELECT date_key FROM dim_date WHERE full_date = %s", (schedule_date,))
            date_key_result = cursor.fetchone()
            if not date_key_result:
                continue
            date_key = date_key_result[0]
        except:
            continue
        
        cursor.execute("SELECT location_key FROM dim_location WHERE location_name = %s", 
                      (schedule['location'],))
        location_key_result = cursor.fetchone()
        if not location_key_result:
            continue
        location_key = location_key_result[0]
        
        # menambahkan ringkasan kelas ke fact table
        class_id = schedule['class_id']
        review_metrics = class_review_metrics.get(class_id, {'total_reviews': 0, 'avg_rating': 0})
        equipment_count = class_equipment_count.get(class_id, 0)
        
        duration_minutes = schedule.get('duration', 0)
        duration_hours = duration_minutes / 60.0
        
        cursor.execute("""
            INSERT INTO fact_class_summary 
            (class_key, instructor_key, date_key, location_key, total_reviews, avg_rating, total_duration_hours, equipment_count)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
        """, (
            class_key, instructor_key, date_key, location_key, 
            review_metrics['total_reviews'], round(review_metrics['avg_rating'], 2),
            round(duration_hours, 2), equipment_count
        ))
        
        processed_count += 1

    # Proses kelas yang tidak ada di jadwal tapi memiliki review
    unscheduled_count = 0
    
    for class_id, review_metrics in class_review_metrics.items():
        cursor.execute("SELECT COUNT(*) FROM fact_class_summary f JOIN dim_classes c ON f.class_key = c.class_key WHERE c.class_id = %s", (class_id,))
        if cursor.fetchone()[0] > 0:
            continue
        
        cursor.execute("SELECT class_key FROM dim_classes WHERE class_id = %s", (class_id,))
        class_key_result = cursor.fetchone()
        if not class_key_result:
            continue
        class_key = class_key_result[0]
        
        cursor.execute("SELECT location_key FROM dim_location l JOIN dim_classes c ON l.location_name = c.location WHERE c.class_id = %s", (class_id,))
        location_key_result = cursor.fetchone()
        if not location_key_result:
            cursor.execute("SELECT location_key FROM dim_location LIMIT 1")
            location_key_result = cursor.fetchone()
        location_key = location_key_result[0] if location_key_result else 1
        
        equipment_count = class_equipment_count.get(class_id, 0)
        
        cursor.execute("""
            INSERT INTO fact_class_summary 
            (class_key, location_key, total_reviews, avg_rating, total_duration_hours, equipment_count)
            VALUES (%s, %s, %s, %s, %s, %s)
        """, (
            class_key, location_key,
            review_metrics['total_reviews'], round(review_metrics['avg_rating'], 2),
            0.0, equipment_count
        ))
        
        unscheduled_count += 1
    
    conn.commit()
    print(f"Fact table populated: {processed_count} scheduled records, {unscheduled_count} unscheduled records")
    
    cursor.execute("SELECT SUM(total_reviews) FROM fact_class_summary")
    total_reviews_sum = cursor.fetchone()[0]
    print(f"Total reviews in warehouse: {total_reviews_sum}")

def main(): 
    conn = create_warehouse_connection()
    if not conn:
        print("Cannot connect to warehouse database")
        return
    
    try:
        create_warehouse_schema(conn)
        populate_dim_date(conn)
        populate_dim_location(conn)  
        populate_dim_classes(conn)
        populate_dim_instructors(conn)
        populate_fact_class_summary_complete(conn)
        
    except Exception as e:
        print(f"Process failed: {e}")
        import traceback
        traceback.print_exc()
        conn.rollback()
    
    finally:
        conn.close()

if __name__ == "__main__":
    main()