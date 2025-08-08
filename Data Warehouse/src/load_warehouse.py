import json
import mysql.connector
from mysql.connector import Error
from datetime import datetime, timedelta

DB_CONFIG_SERVER = {
    'host': 'localhost',
    'user': 'root',
    'password': 'farrel' #Sesuaikan
}
SOURCE_DB_NAME = 'cpu_database'
WAREHOUSE_DB_NAME = 'cpu_warehouse'

TABLES = {}

# Buat Tabel

# Dimension Table
TABLES['dim_manufacturer'] = "CREATE TABLE dim_manufacturer (manufacturer_key INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(255) UNIQUE NOT NULL) ENGINE=InnoDB;"
TABLES['dim_socket'] = "CREATE TABLE dim_socket (socket_key INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(255) UNIQUE NOT NULL) ENGINE=InnoDB;"
TABLES['dim_graphics'] = "CREATE TABLE dim_graphics (graphics_key INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(255) UNIQUE NOT NULL) ENGINE=InnoDB;"
TABLES['dim_date'] = "CREATE TABLE dim_date (date_key INT PRIMARY KEY, full_date DATE, year INT, quarter INT, month INT, day INT, day_of_week INT) ENGINE=InnoDB;"
TABLES['dim_processor'] = "CREATE TABLE dim_processor (processor_key INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(255) NOT NULL, codename VARCHAR(255) NOT NULL, generation VARCHAR(255) NOT NULL, memory_support VARCHAR(255) NOT NULL) ENGINE=InnoDB;"

# Fact Table
TABLES['fact_processors'] = """
    CREATE TABLE fact_processors (
        fact_id INT AUTO_INCREMENT PRIMARY KEY, -- Menambahkan ID unik untuk fact table
        processor_key INT NOT NULL,
        manufacturer_key INT NOT NULL,
        socket_key INT NOT NULL,
        graphics_key INT,
        date_key INT, -- Tidak lagi bagian dari PK, tapi tetap direferensikan
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
        feature_count INT NOT NULL,
        FOREIGN KEY (processor_key) REFERENCES dim_processor(processor_key),
        FOREIGN KEY (manufacturer_key) REFERENCES dim_manufacturer(manufacturer_key),
        FOREIGN KEY (socket_key) REFERENCES dim_socket(socket_key),
        FOREIGN KEY (graphics_key) REFERENCES dim_graphics(graphics_key),
        FOREIGN KEY (date_key) REFERENCES dim_date(date_key)
    ) ENGINE=InnoDB;
"""

def main():
    source_conn = None
    wh_conn = None
    try:
        # Conect MySQL dan buat DB
        conn_server = mysql.connector.connect(**DB_CONFIG_SERVER)
        cursor_server = conn_server.cursor()
        print("Koneksi ke server MySQL berhasil.")
        
        cursor_server.execute(f"CREATE DATABASE IF NOT EXISTS {WAREHOUSE_DB_NAME} DEFAULT CHARACTER SET 'utf8mb4'")
        print(f"Database '{WAREHOUSE_DB_NAME}' berhasil dibuat atau sudah ada.")
        cursor_server.close()
        conn_server.close()

        source_conn = mysql.connector.connect(**DB_CONFIG_SERVER, database=SOURCE_DB_NAME)
        wh_conn = mysql.connector.connect(**DB_CONFIG_SERVER, database=WAREHOUSE_DB_NAME)
        s_cursor = source_conn.cursor(dictionary=True)
        wh_cursor = wh_conn.cursor()

        print("\nMembuat tabel-tabel data warehouse...")
        for table_name in reversed(list(TABLES.keys())):
            wh_cursor.execute(f"DROP TABLE IF EXISTS {table_name};")
        for table_name in TABLES:
            wh_cursor.execute(TABLES[table_name])
            print(f"  -> Tabel '{table_name}' berhasil dibuat.")
        
        # Extract
        print("\n(E) Extract: Mengambil data dari database operasional...")
        extract_query = "SELECT p.*, m.name as manufacturer_name, s.name as socket_name, c.name as codename_name, g.name as generation_name, gr.name as graphics_name, mt.name as memory_type_name FROM processor p LEFT JOIN manufacturer m ON p.manufacturer_id = m.manufacturer_id LEFT JOIN socket s ON p.socket_id = s.socket_id LEFT JOIN codename c ON p.codename_id = c.codename_id LEFT JOIN generation g ON p.generation_id = g.generation_id LEFT JOIN graphics gr ON p.graphics_id = gr.graphics_id LEFT JOIN memory_type mt ON p.memory_type_id = mt.memory_type_id;"
        s_cursor.execute(extract_query)
        processors_data = s_cursor.fetchall()
        print(f"  -> Berhasil mengambil {len(processors_data)} record prosesor.")

        # Load
        print("\n(T, L) Transform & Load: Memasukkan data ke dimension dan fact tables...")
        
        dim_keys = {'manufacturer': {}, 'socket': {}, 'graphics': {}, 'date': {}}

        # Populate Dimensi
        for row in processors_data:
            for dim_name, dim_key, dim_table in [
                ('manufacturer_name', 'manufacturer_key', 'dim_manufacturer'), 
                ('socket_name', 'socket_key', 'dim_socket'),
                ('graphics_name', 'graphics_key', 'dim_graphics')]:
                value = row.get(dim_name)
                if value and value not in dim_keys[dim_name.split('_')[0]]:
                    wh_cursor.execute(f"INSERT INTO {dim_table} (name) VALUES (%s);", (value,))
                    dim_keys[dim_name.split('_')[0]][value] = wh_cursor.lastrowid
        
        # 1. Tambahkan baris "Unknown"
        wh_cursor.execute("INSERT INTO dim_date (date_key, full_date, year, quarter, month, day, day_of_week) VALUES (-1, '1900-01-01', 0, 0, 0, 0, 0);")
        dim_keys['date']['unknown'] = -1
        
        # 2. Populate tanggal lainnya
        s_cursor.execute("SELECT MIN(release_date) as min_date, MAX(release_date) as max_date FROM processor WHERE release_date IS NOT NULL;")
        date_range = s_cursor.fetchone()
        start_date, end_date = date_range['min_date'], date_range['max_date']
        if start_date and end_date:
            current_date = start_date
            while current_date <= end_date:
                date_key = int(current_date.strftime('%Y%m%d'))
                wh_cursor.execute("INSERT INTO dim_date (date_key, full_date, year, quarter, month, day, day_of_week) VALUES (%s, %s, %s, %s, %s, %s, %s);",
                                  (date_key, current_date, current_date.year, (current_date.month-1)//3 + 1, current_date.month, current_date.day, current_date.weekday()+1))
                dim_keys['date'][current_date.strftime('%Y-%m-%d')] = date_key
                current_date += timedelta(days=1)
        print(f"  -> {len(dim_keys['date'])} entri berhasil dimasukkan ke dim_date (termasuk 'Unknown').")

        # Populate dim_processor dan fact_processors
        for row in processors_data:
            wh_cursor.execute("INSERT INTO dim_processor (name, codename, generation, memory_support) VALUES (%s, %s, %s, %s);",
                              (row['name'], row['codename_name'], row['generation_name'], row['memory_type_name']))
            processor_key = wh_cursor.lastrowid

            s_cursor.execute("SELECT COUNT(*) as count FROM processor_features WHERE processor_id = %s;", (row['processor_id'],))
            feature_count = s_cursor.fetchone()['count']
            
            manufacturer_key = dim_keys['manufacturer'].get(row['manufacturer_name'])
            socket_key = dim_keys['socket'].get(row['socket_name'])
            graphics_key = dim_keys['graphics'].get(row['graphics_name'])
            
            # Gunakan -1 jika tanggal tidak ada
            release_date_str = row['release_date'].strftime('%Y-%m-%d') if row['release_date'] else None
            date_key = dim_keys['date'].get(release_date_str) if release_date_str else dim_keys['date']['unknown']
            
            fact_sql = """INSERT INTO fact_processors (processor_key, manufacturer_key, socket_key, graphics_key, date_key, cores, threads, frequency_ghz, turbo_clock_ghz, cache_l1_kb, cache_l2_kb, cache_l3_mb, tdp_watts, launch_price_usd, process_size_nm, feature_count) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s);"""
            wh_cursor.execute(fact_sql, (
                processor_key, manufacturer_key, socket_key, graphics_key, date_key,
                row['cores'], row['threads'], row['frequency_ghz'], row['turbo_clock_ghz'],
                row['cache_l1_kb'], row['cache_l2_kb'], row['cache_l3_mb'], row['tdp_watts'],
                row['launch_price_usd'], row['process_size_nm'], feature_count
            ))

        wh_conn.commit()
        print(f"✅ Berhasil! Seluruh data telah dimasukkan ke data warehouse '{WAREHOUSE_DB_NAME}'.")

    except Error as e:
        print(f"\n❌ Error saat terhubung atau memproses database: {e}")
        if wh_conn:
            wh_conn.rollback()
    finally:
        if 's_cursor' in locals() and s_cursor: s_cursor.close()
        if 'source_conn' in locals() and source_conn.is_connected(): source_conn.close()
        if 'wh_cursor' in locals() and wh_cursor: wh_cursor.close()
        if 'wh_conn' in locals() and wh_conn.is_connected(): wh_conn.close()
        print("Semua koneksi MySQL ditutup.")

if __name__ == "__main__":
    main()