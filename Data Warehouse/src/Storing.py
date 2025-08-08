import psycopg2
from datetime import datetime

# Konfigurasi koneksi database
SOURCE_DB = {
    "dbname": "tech_in_asia",
    "user": "postgres",
    "password": "password123",
    "host": "localhost",
    "port": "5432"
}

TARGET_DB = {
    "dbname": "techinasia_dw",
    "user": "postgres",
    "password": "password123",
    "host": "localhost",
    "port": "5432"
}

# Query untuk membuat tabel DW
CREATE_TABLE_QUERIES = [
    """
    CREATE TABLE IF NOT EXISTS dim_company (
        company_id VARCHAR(13) PRIMARY KEY,
        company_name VARCHAR(50) NOT NULL
    )
    """,
    """
    CREATE TABLE IF NOT EXISTS dim_industry (
        industry_id VARCHAR(12) PRIMARY KEY,
        industry_name VARCHAR(100) NOT NULL
    )
    """,
    """
    CREATE TABLE IF NOT EXISTS dim_function (
        function_id INTEGER PRIMARY KEY,
        function_name VARCHAR(30) NOT NULL
    )
    """,
    """
    CREATE TABLE IF NOT EXISTS dim_location (
        location_id VARCHAR(12) PRIMARY KEY,
        city VARCHAR(100) NOT NULL,
        country VARCHAR(100) NOT NULL
    )
    """,
    """
    CREATE TABLE IF NOT EXISTS dim_compensation_package (
        compensation_id VARCHAR(12) PRIMARY KEY,
        min_salary INTEGER,
        max_salary INTEGER,
        currency VARCHAR(10),
        with_equity BOOLEAN
    )
    """,
    """
    CREATE TABLE IF NOT EXISTS dim_time (
        time_id DATE PRIMARY KEY,
        day INT,
        month INT,
        year INT,
        day_of_week VARCHAR(10)
    )
    """,
    """
    CREATE TABLE IF NOT EXISTS dim_company_industry (
        company_id VARCHAR(13) NOT NULL,
        industry_id VARCHAR(12) NOT NULL,
        PRIMARY KEY (company_id, industry_id),
        FOREIGN KEY (company_id) REFERENCES dim_company(company_id) ON DELETE CASCADE,
        FOREIGN KEY (industry_id) REFERENCES dim_industry(industry_id) ON DELETE CASCADE
    );
    """,
    """
    CREATE TABLE IF NOT EXISTS fact_job (
        job_id VARCHAR(40) NOT NULL,
        snapshot_at TIMESTAMP NOT NULL,
        is_active BOOLEAN,
        company_id VARCHAR(13),
        function_id INTEGER,
        location_id VARCHAR(12),
        compensation_id VARCHAR(12),
        posted_time_id DATE,
        PRIMARY KEY (job_id, snapshot_at),
        FOREIGN KEY (company_id) REFERENCES dim_company(company_id),
        FOREIGN KEY (function_id) REFERENCES dim_function(function_id),
        FOREIGN KEY (location_id) REFERENCES dim_location(location_id),
        FOREIGN KEY (compensation_id) REFERENCES dim_compensation_package(compensation_id),
        FOREIGN KEY (posted_time_id) REFERENCES dim_time(time_id)
    )
    """
]

def create_dw_tables():
    try:
        conn = psycopg2.connect(**TARGET_DB)
        cur = conn.cursor()

        # Eksekusi semua query CREATE TABLE yang ada di list
        for query in CREATE_TABLE_QUERIES:
            cur.execute(query)

        conn.commit()
        cur.close()
        conn.close()
        print("✅ Semua tabel DW berhasil dibuat!")
    except Exception as e:
        print("❌ Error membuat tabel:", e)

def etl_jobs():
    try:
        # Koneksi sumber
        src_conn = psycopg2.connect(**SOURCE_DB)
        src_cur = src_conn.cursor()

        # Koneksi target
        tgt_conn = psycopg2.connect(**TARGET_DB)
        tgt_cur = tgt_conn.cursor()

        # Ambil data dari source
        src_cur.execute("""
            SELECT
                j.job_id,
                j.title AS job_title,
                j.job_type,
                j.company_id,
                c.company_name,
                ci.industry_id,
                i.industry_name,
                j.function_id,
                f.function_name,
                j.location_id,
                l.city,
                l.country,
                j.compensation_id,
                cp.min_salary,
                cp.max_salary,
                cp.currency,
                cp.with_equity,
                j.is_active,
                j.posted_date,
                EXTRACT(DAY FROM j.posted_date) AS day,
                EXTRACT(MONTH FROM j.posted_date) AS month,
                EXTRACT(YEAR FROM j.posted_date) AS year,
                TO_CHAR(j.posted_date, 'Day') AS day_of_week
            FROM job j
            JOIN company c ON j.company_id = c.company_id
            LEFT JOIN company_industry ci ON c.company_id = ci.company_id
            LEFT JOIN industry i ON ci.industry_id = i.industry_id
            LEFT JOIN function f ON j.function_id = f.function_id
            LEFT JOIN location l ON j.location_id = l.location_id
            LEFT JOIN compensation_package cp ON j.compensation_id = cp.compensation_id;
        """)

        rows = src_cur.fetchall()
        snapshot_at = datetime.now() # Timestamp snapshot data ETL saat ini

        # Iterasi setiap row hasil query untuk diproses ke dalam DW
        for row in rows:
            (
                job_id, job_title, job_type,
                company_id, company_name,
                industry_id, industry_name,
                function_id, function_name,
                location_id, city, country,
                compensation_id, min_salary, max_salary, currency, with_equity,
                is_active, posted_date, day, month, year, day_of_week
            ) = row

            # Insert data ke tabel dimensi, gunakan ON CONFLICT DO NOTHING untuk mencegah duplikat
            
            if company_id:
                tgt_cur.execute("""
                    INSERT INTO dim_company (company_id, company_name)
                    VALUES (%s, %s)
                    ON CONFLICT (company_id) DO NOTHING
                """, (company_id, company_name))

            if industry_id:
                tgt_cur.execute("""
                    INSERT INTO dim_industry (industry_id, industry_name)
                    VALUES (%s, %s)
                    ON CONFLICT (industry_id) DO NOTHING
                """, (industry_id, industry_name))

        
            if company_id and industry_id:
                tgt_cur.execute("""
                    INSERT INTO dim_company_industry (company_id, industry_id)
                    VALUES (%s, %s)
                    ON CONFLICT (company_id, industry_id) DO NOTHING
                """, (company_id, industry_id))

            if function_id:
                tgt_cur.execute("""
                    INSERT INTO dim_function (function_id, function_name)
                    VALUES (%s, %s)
                    ON CONFLICT (function_id) DO NOTHING
                """, (function_id, function_name))

            if location_id:
                tgt_cur.execute("""
                    INSERT INTO dim_location (location_id, city, country)
                    VALUES (%s, %s, %s)
                    ON CONFLICT (location_id) DO NOTHING
                """, (location_id, city, country))

            if compensation_id:
                tgt_cur.execute("""
                    INSERT INTO dim_compensation_package (compensation_id, min_salary, max_salary, currency, with_equity)
                    VALUES (%s, %s, %s, %s, %s)
                    ON CONFLICT (compensation_id) DO NOTHING
                """, (compensation_id, min_salary, max_salary, currency, with_equity))

            if posted_date:
                # Gunakan posted_date sebagai time_id di dim_time
                tgt_cur.execute("""
                    INSERT INTO dim_time (time_id, day, month, year, day_of_week)
                    VALUES (%s, %s, %s, %s, %s)
                    ON CONFLICT (time_id) DO NOTHING
                """, (posted_date, day, month, year, day_of_week.strip()))

            # Insert data ke tabel fakta fact_job
            # Gunakan kombinasi job_id dan snapshot_at sebagai primary key
            tgt_cur.execute("""
                INSERT INTO fact_job (job_id, snapshot_at, is_active, company_id, function_id, location_id, compensation_id, posted_time_id)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
                ON CONFLICT (job_id, snapshot_at) DO NOTHING
            """, (job_id, snapshot_at, is_active, company_id, function_id, location_id, compensation_id, posted_date))

        tgt_conn.commit()
        print("✅ ETL selesai!")

        # Tutup semua koneksi setelah proses selesai
        src_cur.close()
        src_conn.close()
        tgt_cur.close()
        tgt_conn.close()

    except Exception as e:
        print("❌ Error ETL:", e)

if __name__ == "__main__":
    create_dw_tables()
    etl_jobs()
