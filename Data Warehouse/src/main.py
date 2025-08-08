import psycopg2
import os

# === Fungsi untuk membuat tabel Data Warehouse ===
def create_dw_tables(cursor):
    commands = (
        """
        DROP TABLE IF EXISTS fact_camera_performance;
        DROP TABLE IF EXISTS dim_cameras;
        DROP TABLE IF EXISTS dim_brands;
        DROP TABLE IF EXISTS dim_sensor_formats;
        DROP TABLE IF EXISTS dim_time;
        """,
        """
        CREATE TABLE dim_brands (
            brand_key SERIAL PRIMARY KEY,
            brand_name VARCHAR(100) NOT NULL
        );
        """,
        """
        CREATE TABLE dim_sensor_formats (
            format_key SERIAL PRIMARY KEY,
            format_name VARCHAR(50) NOT NULL
        );
        """,
        """
        CREATE TABLE dim_cameras (
            camera_key SERIAL PRIMARY KEY,
            camera_id INT NOT NULL,
            name VARCHAR(255),
            model VARCHAR(100)
        );
        """,
        """
        CREATE TABLE dim_time (
            time_key INT PRIMARY KEY,
            full_date DATE NOT NULL,
            year INT NOT NULL,
            quarter INT NOT NULL,
            month INT NOT NULL,
            day INT NOT NULL
        );
        """,
        """
        CREATE TABLE fact_camera_performance (
            camera_key INT REFERENCES dim_cameras(camera_key),
            brand_key INT REFERENCES dim_brands(brand_key),
            format_key INT REFERENCES dim_sensor_formats(format_key),
            time_key INT REFERENCES dim_time(time_key),
            launch_price_usd INT,
            pixel_depth_mp DECIMAL(4, 1),
            overall_score INT,
            portrait_score DECIMAL(4,1),
            landscape_score DECIMAL(4,1),
            sports_score INT
        );
        """
    )
    for command in commands:
        cursor.execute(command)
    print("Tabel Data Warehouse berhasil dibuat.\n")

# === Fungsi untuk melakukan proses ETL ===
def etl_process(cursor):
    print("Mengisi tabel dimensi (dim_brands, dim_sensor_formats, dim_cameras)")
    cursor.execute("INSERT INTO dim_brands (brand_name) SELECT brand_name FROM brands;")
    cursor.execute("INSERT INTO dim_sensor_formats (format_name) SELECT format_name FROM sensor_formats;")
    cursor.execute("INSERT INTO dim_cameras (camera_id, name, model) SELECT camera_id, name, model FROM cameras;")

    print("Mengisi tabel dimensi waktu (dim_time)")
    cursor.execute("""
        INSERT INTO dim_time (time_key, full_date, year, quarter, month, day)
        SELECT DISTINCT
            TO_CHAR(launch_date, 'YYYYMMDD')::INT,
            launch_date,
            EXTRACT(YEAR FROM launch_date),
            EXTRACT(QUARTER FROM launch_date),
            EXTRACT(MONTH FROM launch_date),
            EXTRACT(DAY FROM launch_date)
        FROM cameras WHERE launch_date IS NOT NULL;
    """)

    print("Mengisi tabel fakta (fact_camera_performance)")
    cursor.execute("""
        INSERT INTO fact_camera_performance (
            camera_key, brand_key, format_key, time_key, 
            launch_price_usd, pixel_depth_mp, 
            overall_score, portrait_score, landscape_score, sports_score
        )
        SELECT
            dc.camera_key,
            db.brand_key,
            dsf.format_key,
            dt.time_key,
            c.launch_price_usd,
            c.pixel_depth_mp,
            s_overall.score_value,
            s_portrait.score_value,
            s_landscape.score_value,
            s_sports.score_value
        FROM cameras c
        JOIN dim_cameras dc ON c.camera_id = dc.camera_id
        LEFT JOIN brands b ON c.brand_id = b.brand_id
        LEFT JOIN dim_brands db ON b.brand_name = db.brand_name
        LEFT JOIN sensor_formats sf ON c.format_id = sf.format_id
        LEFT JOIN dim_sensor_formats dsf ON sf.format_name = dsf.format_name
        LEFT JOIN dim_time dt ON c.launch_date = dt.full_date
        LEFT JOIN scores s_overall ON c.camera_id = s_overall.camera_id AND s_overall.score_type = 'Overall'
        LEFT JOIN scores s_portrait ON c.camera_id = s_portrait.camera_id AND s_portrait.score_type = 'Portrait (Color Depth)'
        LEFT JOIN scores s_landscape ON c.camera_id = s_landscape.camera_id AND s_landscape.score_type = 'Landscape (Dynamic Range)'
        LEFT JOIN scores s_sports ON c.camera_id = s_sports.camera_id AND s_sports.score_type = 'Sports (Low-Light ISO)';
    """)
    print("Proses ETL selesai.")


# === Main Execution ===
if __name__ == "__main__":
    conn_params = {
        "host": "localhost",
        "database": "seleksi_asisten_basdat",
        "user": "postgres",
        "password": "221022" 
    }

    try:
        with psycopg2.connect(**conn_params) as conn:
            with conn.cursor() as cursor:
                create_dw_tables(cursor)
                etl_process(cursor)
        
        print("\n✅ Proses pembuatan dan pemuatan Data Warehouse berhasil.")

    except psycopg2.Error as e:
        print(f"Error saat berinteraksi dengan database: {e}")