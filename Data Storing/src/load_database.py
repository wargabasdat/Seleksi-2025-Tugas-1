import json
import mysql.connector
from mysql.connector import Error
import os

DB_CONFIG_SERVER = {
    'host': 'localhost',
    'user': 'root',
    'password': '' # Sesuaikan
}
DB_NAME = 'cpu_database' # Nama DB
INPUT_FILE = '../../Data Scraping/data/preprocessed_processors_data.json'

TABLES = {}

# Daftar Table
TABLES['manufacturer'] = """
    CREATE TABLE manufacturer (
        manufacturer_id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(255) UNIQUE NOT NULL
    ) ENGINE=InnoDB;
"""
TABLES['socket'] = """
    CREATE TABLE socket (
        socket_id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(255) UNIQUE NOT NULL
    ) ENGINE=InnoDB;
"""
TABLES['codename'] = """
    CREATE TABLE codename (
        codename_id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(255) UNIQUE NOT NULL
    ) ENGINE=InnoDB;
"""
TABLES['generation'] = """
    CREATE TABLE generation (
        generation_id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(255) UNIQUE NOT NULL
    ) ENGINE=InnoDB;
"""
TABLES['graphics'] = """
    CREATE TABLE graphics (
        graphics_id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(255) UNIQUE NOT NULL
    ) ENGINE=InnoDB;
"""
TABLES['memory_type'] = """
    CREATE TABLE memory_type (
        memory_type_id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(255) UNIQUE NOT NULL
    ) ENGINE=InnoDB;
"""
TABLES['feature'] = """
    CREATE TABLE feature (
        feature_id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(255) UNIQUE NOT NULL
    ) ENGINE=InnoDB;
"""
TABLES['processor'] = """
    CREATE TABLE processor (
        processor_id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(255) NOT NULL,
        cores INT NOT NULL,
        threads INT NOT NULL,
        frequency_ghz DECIMAL(8, 2) NOT NULL,
        turbo_clock_ghz DECIMAL(8, 2),
        cache_l1_kb INT,
        cache_l2_kb INT NOT NULL,
        cache_l3_mb INT,
        tdp_watts INT NOT NULL,
        launch_price_usd INT,
        process_size_nm INT,
        release_date DATE,
        is_multiplier_unlocked BOOLEAN NOT NULL,
        manufacturer_id INT NOT NULL,
        socket_id INT NOT NULL,
        codename_id INT NOT NULL,
        generation_id INT NOT NULL,
        graphics_id INT,
        memory_type_id INT NOT NULL,
        FOREIGN KEY (manufacturer_id) REFERENCES manufacturer(manufacturer_id),
        FOREIGN KEY (socket_id) REFERENCES socket(socket_id),
        FOREIGN KEY (codename_id) REFERENCES codename(codename_id),
        FOREIGN KEY (generation_id) REFERENCES generation(generation_id),
        FOREIGN KEY (graphics_id) REFERENCES graphics(graphics_id),
        FOREIGN KEY (memory_type_id) REFERENCES memory_type(memory_type_id),
        CONSTRAINT chk_cores CHECK (cores > 0),
        CONSTRAINT chk_threads CHECK (threads > 0)
    ) ENGINE=InnoDB;
"""
TABLES['processor_features'] = """
    CREATE TABLE processor_features (
        processor_id INT,
        feature_id INT,
        PRIMARY KEY (processor_id, feature_id),
        FOREIGN KEY (processor_id) REFERENCES processor(processor_id) ON DELETE CASCADE,
        FOREIGN KEY (feature_id) REFERENCES feature(feature_id) ON DELETE CASCADE
    ) ENGINE=InnoDB;
"""

def main():
    """Fungsi utama untuk menjalankan seluruh proses ETL."""
    conn = None
    try:
        # Connect ke MySQL dan buat DB
        conn = mysql.connector.connect(**DB_CONFIG_SERVER)
        cursor = conn.cursor()
        print("Koneksi ke server MySQL berhasil.")
        
        cursor.execute(f"CREATE DATABASE IF NOT EXISTS {DB_NAME} DEFAULT CHARACTER SET 'utf8mb4'")
        print(f"Database '{DB_NAME}' berhasil dibuat atau sudah ada.")
        cursor.execute(f"USE {DB_NAME}")

        # Buat tabel
        print("Membuat tabel...")
        # Hapus tabel dengan urutan yang benar untuk menghindari error foreign key
        for table_name in reversed(list(TABLES.keys())):
            cursor.execute(f"DROP TABLE IF EXISTS {table_name};")
        
        for table_name in TABLES:
            table_sql = TABLES[table_name]
            try:
                print(f"  -> Membuat tabel: {table_name}", end='')
                cursor.execute(table_sql)
                print(" -> OK")
            except Error as err:
                print(f" -> Gagal: {err}")
        
        # Memasukkan data
        with open(INPUT_FILE, 'r', encoding='utf-8') as f:
            data = json.load(f)
        print(f"\nMemulai proses data loading untuk {len(data)} CPU...")

        # Mapping dictionaries untuk menyimpan ID
        dim_map = {
            'manufacturer': {}, 'socket': {}, 'codename': {}, 
            'generation': {}, 'graphics': {}, 'memory_type': {}, 'feature': {}
        }

        for i, cpu in enumerate(data, 1):
            print(f"  Memproses CPU {i}/{len(data)}: {cpu.get('name')}")

            # Isi Tabel Dimensi & Dapatkan ID
            for dim_name, json_key in [
                ('manufacturer', 'manufacturer'), ('socket', 'socket'), ('codename', 'codename'),
                ('generation', 'generation'), ('graphics', 'integrated_graphics'), ('memory_type', 'memory_support')
            ]:
                value = cpu.get(json_key)
                if value and value not in dim_map[dim_name]:
                    cursor.execute(f"INSERT INTO {dim_name} (name) VALUES (%s) ON DUPLICATE KEY UPDATE name=name;", (value,))
                    cursor.execute(f"SELECT {dim_name}_id FROM {dim_name} WHERE name = %s;", (value,))
                    dim_map[dim_name][value] = cursor.fetchone()[0]

            if cpu.get("features"):
                for feature_name in cpu["features"]:
                    if feature_name not in dim_map['feature']:
                        cursor.execute("INSERT INTO feature (name) VALUES (%s) ON DUPLICATE KEY UPDATE name=name;", (feature_name,))
                        cursor.execute("SELECT feature_id FROM feature WHERE name = %s;", (feature_name,))
                        dim_map['feature'][feature_name] = cursor.fetchone()[0]
            
            # Isi Tabel Utama (processor)
            processor_sql = """INSERT INTO processor (name, cores, threads, frequency_ghz, turbo_clock_ghz, cache_l1_kb, cache_l2_kb, cache_l3_mb, tdp_watts, launch_price_usd, process_size_nm, release_date, is_multiplier_unlocked, manufacturer_id, socket_id, codename_id, generation_id, graphics_id, memory_type_id) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s);"""
            processor_values = (
                cpu.get("name"), cpu.get("cores"), cpu.get("threads"), cpu.get("frequency_ghz"), cpu.get("turbo_clock_ghz"),
                cpu.get("cache_l1_kb"), cpu.get("cache_l2_kb"), cpu.get("cache_l3_mb"), cpu.get("tdp_watts"), cpu.get("launch_price_usd"),
                cpu.get("process_size_nm"), cpu.get("release_date"), cpu.get("multiplier_unlocked"),
                dim_map['manufacturer'].get(cpu.get("manufacturer")), dim_map['socket'].get(cpu.get("socket")), dim_map['codename'].get(cpu.get("codename")),
                dim_map['generation'].get(cpu.get("generation")), dim_map['graphics'].get(cpu.get("integrated_graphics")), dim_map['memory_type'].get(cpu.get("memory_support"))
            )
            cursor.execute(processor_sql, processor_values)
            processor_id = cursor.lastrowid

            # Isi Tabel Penghubung (processor_features)
            if cpu.get("features"):
                for feature_name in cpu["features"]:
                    feature_id = dim_map['feature'].get(feature_name)
                    if processor_id and feature_id:
                        cursor.execute("INSERT INTO processor_features (processor_id, feature_id) VALUES (%s, %s) ON DUPLICATE KEY UPDATE processor_id=processor_id;", (processor_id, feature_id))

        conn.commit()
        print(f"\n✅ Berhasil! Seluruh data telah dimasukkan ke database '{DB_NAME}'.")

    except Error as e:
        print(f"\n❌ Error saat terhubung atau memproses database: {e}")
        if conn:
            conn.rollback()
    finally:
        if 'conn' in locals() and conn.is_connected():
            cursor.close()
            conn.close()
            print("Koneksi MySQL ditutup.")

if __name__ == "__main__":
    main()