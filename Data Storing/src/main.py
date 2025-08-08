import json
import os
import psycopg2

# === Fungsi untuk membuat tabel-tabel yang diperlukan dalam database ===
def create_tables(cursor):
    commands = (
        """
        DROP TABLE IF EXISTS camera_video_capabilities;
        DROP TABLE IF EXISTS scores;
        DROP TABLE IF EXISTS cameras;
        DROP TABLE IF EXISTS lenses;
        DROP TABLE IF EXISTS brands;
        DROP TABLE IF EXISTS sensor_formats;
        DROP TABLE IF EXISTS lens_mounts;
        DROP TABLE IF EXISTS video_resolutions;
        """,
        """
        CREATE TABLE brands (
            brand_id SERIAL PRIMARY KEY,
            brand_name VARCHAR(100) UNIQUE NOT NULL
        );
        """,
        """
        CREATE TABLE sensor_formats (
            format_id SERIAL PRIMARY KEY,
            format_name VARCHAR(50) UNIQUE NOT NULL
        );
        """,
        """
        CREATE TABLE lens_mounts (
            mount_id SERIAL PRIMARY KEY,
            mount_name VARCHAR(100) UNIQUE NOT NULL
        );
        """,
        """
        CREATE TABLE video_resolutions (
            resolution_id SERIAL PRIMARY KEY,
            resolution_name VARCHAR(50) UNIQUE NOT NULL,
            max_fps INT
        );
        """,
        """
        CREATE TABLE lenses (
            lens_id SERIAL PRIMARY KEY,
            lens_name VARCHAR(255) NOT NULL,
            brand VARCHAR(100),
            price_usd INT,
            aperture VARCHAR(50),
            focal_length VARCHAR(50),
            stabilization BOOLEAN,
            mount_id INT,
            CONSTRAINT fk_lens_mount FOREIGN KEY(mount_id) REFERENCES lens_mounts(mount_id)
        );
        """,
        """
        CREATE TABLE cameras (
            camera_id INT PRIMARY KEY,
            name VARCHAR(255),
            model VARCHAR(100),
            launch_date DATE,
            launch_price_usd INT,
            pixel_depth_mp DECIMAL(4, 1),
            brand_id INT,
            format_id INT,
            mount_id INT,
            CONSTRAINT fk_brand FOREIGN KEY(brand_id) REFERENCES brands(brand_id),
            CONSTRAINT fk_format FOREIGN KEY(format_id) REFERENCES sensor_formats(format_id),
            CONSTRAINT fk_mount FOREIGN KEY(mount_id) REFERENCES lens_mounts(mount_id)
        );
        """,
        """
        CREATE TABLE scores (
            score_id INT PRIMARY KEY,
            camera_id INT NOT NULL,
            score_type VARCHAR(50),
            score_value DECIMAL(10, 1),
            CONSTRAINT fk_camera FOREIGN KEY(camera_id) REFERENCES cameras(camera_id) ON DELETE CASCADE
        );
        """,
        """
        CREATE TABLE camera_video_capabilities (
            camera_id INT,
            resolution_id INT,
            PRIMARY KEY (camera_id, resolution_id),
            CONSTRAINT fk_camera FOREIGN KEY(camera_id) REFERENCES cameras(camera_id) ON DELETE CASCADE,
            CONSTRAINT fk_resolution FOREIGN KEY(resolution_id) REFERENCES video_resolutions(resolution_id) ON DELETE CASCADE
        );
        """
    )
    for command in commands:
        cursor.execute(command)

# === Fungsi untuk memasukkan data ke dalam tabel-tabel yang sudah dibuat ===
def insert_data(cursor, cameras_data, scores_data):
    print("Memasukkan data ke tabel 'brands' dan 'sensor_formats'...")
    unique_brands = set(cam['brand'] for cam in cameras_data if cam.get('brand'))
    unique_formats = set(cam['sensor_format'] for cam in cameras_data if cam.get('sensor_format'))

    cursor.executemany("INSERT INTO brands (brand_name) VALUES (%s) ON CONFLICT DO NOTHING;", [(brand,) for brand in unique_brands])
    cursor.executemany("INSERT INTO sensor_formats (format_name) VALUES (%s) ON CONFLICT DO NOTHING;", [(fmt,) for fmt in unique_formats])
    
    cursor.execute("SELECT brand_name, brand_id FROM brands;")
    brand_map = {name: id for name, id in cursor.fetchall()}
    cursor.execute("SELECT format_name, format_id FROM sensor_formats;")
    format_map = {name: id for name, id in cursor.fetchall()}

    print("Memasukkan data ke tabel 'cameras'...")
    cameras_to_insert = []
    for cam in cameras_data:
        cameras_to_insert.append({
            'camera_id': cam['camera_id'],
            'name': cam['name'],
            'model': cam['model'],
            'launch_date': cam['launch_date'],
            'launch_price_usd': cam['launch_price_usd'],
            'pixel_depth_mp': cam['pixel_depth_mp'],
            'brand_id': brand_map.get(cam['brand']),
            'format_id': format_map.get(cam['sensor_format']),
            'mount_id': None
        })
    camera_insert_query = "INSERT INTO cameras VALUES (%(camera_id)s, %(name)s, %(model)s, %(launch_date)s, %(launch_price_usd)s, %(pixel_depth_mp)s, %(brand_id)s, %(format_id)s, %(mount_id)s);"
    cursor.executemany(camera_insert_query, cameras_to_insert)

    print("Memasukkan data ke tabel 'scores'...")
    score_insert_query = "INSERT INTO scores VALUES (%(score_id)s, %(camera_id)s, %(score_type)s, %(score_value)s);"
    cursor.executemany(score_insert_query, scores_data)
    
    print("Data untuk tabel cameras dan scores berhasil dimasukkan.")

# === Main Execution ===
if __name__ == "__main__":
    conn_params = {
        "host": "localhost",
        "database": "seleksi_asisten_basdat",
        "user": "postgres",
        "password": "221022",
        "client_encoding": "utf8"
    }
    current_dir = os.path.dirname(__file__)
    data_dir = os.path.join(current_dir, '..', '..', 'Data Scraping', 'data')
    cameras_filepath = os.path.join(data_dir, 'cameras.json')
    scores_filepath = os.path.join(data_dir, 'scores.json')

    try:
        with open(cameras_filepath, 'r', encoding='utf-8') as f:
            final_cameras = json.load(f)
        with open(scores_filepath, 'r', encoding='utf-8') as f:
            final_scores = json.load(f)

        with psycopg2.connect(**conn_params) as conn:
            conn.set_client_encoding('UTF8')
            with conn.cursor() as cursor:
                create_tables(cursor)
                insert_data(cursor, final_cameras, final_scores)
        
        print("\n✅ Proses penyimpanan data ke database berhasil sepenuhnya.")

    except (IOError, json.JSONDecodeError) as e:
        print(f"Error saat membaca file: {e}")
    except UnicodeDecodeError as e:
        print(f"Error encoding: {e}")
        print("Coba periksa encoding file JSON atau setting database PostgreSQL")
    except psycopg2.Error as e:
        print(f"Error saat berinteraksi dengan database: {e}")