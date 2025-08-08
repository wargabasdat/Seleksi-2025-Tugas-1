import psycopg2 
import json
import os
from datetime import datetime
from psycopg2 import sql
import logging
import traceback

# =============================
# SETUP LOGGING
# =============================
logging.basicConfig(
    filename=os.path.join("Seleksi-2025-Tugas-1", "Data Storing", "storing.log"),
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - %(message)s"
)

def log_error(msg, e=None):
    """Helper untuk log error lengkap"""
    logging.error(msg)
    if e:
        logging.error(traceback.format_exc())

# =============================
# 1. CONNECT KE POSTGRESQL
# =============================
conn = psycopg2.connect(
    host="localhost",
    port=5432,
    dbname="tech_in_asia",
    user="postgres",
    password=""  # Karena saya tidak berpassword maka tidak diisi apa-apa
)
cursor = conn.cursor()

# =============================
# 2. LOAD FILE JSON
# =============================
today = datetime.today().strftime('%Y-%m-%d')
base_dir = os.path.join("Seleksi-2025-Tugas-1", "Data Scraping", "data", today)

def load_json(name):
    filename = f"{name}.json"
    filepath = os.path.join(base_dir, filename)
    if not os.path.exists(filepath):
        print(f"⚠️ File {filepath} tidak ditemukan!")
        return []
    with open(filepath, "r", encoding="utf-8") as f:
        return json.load(f)

job_data = load_json("jobs")
company_data = load_json("companies")
industry_data = load_json("industries")
function_data = load_json("functions")
company_industry_data = load_json("company_industries")
location_data = load_json("locations")
compensation_data = load_json("compensation_packages")

# =============================
# 3. CREATE TABLES
# =============================
create_table_queries = [

    # 1. location
    """
    CREATE TABLE IF NOT EXISTS location (
        location_id VARCHAR(12) PRIMARY KEY,
        city VARCHAR(100) NOT NULL,
        country VARCHAR(100) NOT NULL,
        scraped_at TIMESTAMP
    );
    """,

    # 2. function
    """
    CREATE TABLE IF NOT EXISTS function (
        function_id INTEGER PRIMARY KEY,
        function_name VARCHAR(30) NOT NULL,
        scraped_at TIMESTAMP
    );
    """,

    # 3. company
    """
    CREATE TABLE IF NOT EXISTS company (
        company_id VARCHAR(13) PRIMARY KEY,
        company_name VARCHAR(50) NOT NULL,
        scraped_at TIMESTAMP
    );
    """,

    # 4. industry
    """
    CREATE TABLE IF NOT EXISTS industry (
        industry_id VARCHAR(12) PRIMARY KEY,
        industry_name VARCHAR(100) NOT NULL,
        scraped_at TIMESTAMP
    );
    """,

    # 5. compensation_package
    """
    CREATE TABLE IF NOT EXISTS compensation_package (
        compensation_id VARCHAR(12) PRIMARY KEY,
        min_salary INTEGER,
        max_salary INTEGER,
        currency VARCHAR(10),
        with_equity BOOLEAN,
        scraped_at TIMESTAMP
    );
    """,

    # 6. job
    """
    CREATE TABLE IF NOT EXISTS job (
        job_id VARCHAR(40) PRIMARY KEY,
        title VARCHAR(100) NOT NULL,
        job_type VARCHAR(30),
        company_id VARCHAR(13),
        function_id INTEGER,
        location_id VARCHAR(12),
        compensation_id VARCHAR(12),
        is_active BOOLEAN DEFAULT TRUE,
        posted_date DATE,
        scraped_at TIMESTAMP,
        closed_at TIMESTAMP,
        FOREIGN KEY (company_id) REFERENCES company(company_id) ON DELETE SET NULL,
        FOREIGN KEY (function_id) REFERENCES function(function_id) ON DELETE SET NULL,
        FOREIGN KEY (location_id) REFERENCES location(location_id) ON DELETE SET NULL,
        FOREIGN KEY (compensation_id) REFERENCES compensation_package(compensation_id) ON DELETE SET NULL
    );
    """,

    # 7. company_industry
    """
    CREATE TABLE IF NOT EXISTS company_industry (
        company_id VARCHAR(13) NOT NULL,
        industry_id VARCHAR(12) NOT NULL,
        PRIMARY KEY (company_id, industry_id),
        FOREIGN KEY (company_id) REFERENCES company(company_id) ON DELETE CASCADE,
        FOREIGN KEY (industry_id) REFERENCES industry(industry_id) ON DELETE CASCADE
    );
    """,


    # 8. reviewer
    """
    CREATE TABLE IF NOT EXISTS reviewer (
        reviewer_id VARCHAR(12) PRIMARY KEY,
        name VARCHAR(100) NOT NULL,
        company_id VARCHAR(13),
        FOREIGN KEY (company_id) REFERENCES company(company_id) ON DELETE SET NULL
    );
    """,

    # 9. job_description
    """
    CREATE TABLE IF NOT EXISTS job_description (
        job_id VARCHAR(40) PRIMARY KEY,
        responsibilities TEXT,
        requirements TEXT,
        FOREIGN KEY (job_id) REFERENCES job(job_id) ON DELETE CASCADE
    );
    """,

    # 10. internship
    """
    CREATE TABLE IF NOT EXISTS internship (
        job_id VARCHAR(40) PRIMARY KEY,
        duration_month INTEGER,
        is_paid BOOLEAN,
        mentorship_provided BOOLEAN,
        FOREIGN KEY (job_id) REFERENCES job(job_id) ON DELETE CASCADE
    );
    """,

    # 11. user
    """
    CREATE TABLE IF NOT EXISTS "user" (
        user_id VARCHAR(13) PRIMARY KEY,
        name VARCHAR(100) NOT NULL,
        username VARCHAR(20) NOT NULL,
        email VARCHAR(50) NOT NULL,
        password_hash VARCHAR(100) NOT NULL,
        created_at TIMESTAMP NOT NULL
    );
    """,

    # 12. resume
    """
    CREATE TABLE IF NOT EXISTS resume (
        user_id VARCHAR(13) NOT NULL,
        resume_number INTEGER NOT NULL,
        title VARCHAR(100) NOT NULL,
        summary VARCHAR(200),
        PRIMARY KEY (user_id, resume_number),
        FOREIGN KEY (user_id) REFERENCES "user"(user_id) ON DELETE CASCADE
    );
    """,

    # 13. resume_skill
    """
    CREATE TABLE IF NOT EXISTS resume_skill (
        user_id VARCHAR(13) NOT NULL,
        resume_number INTEGER NOT NULL,
        skill VARCHAR(100) NOT NULL,
        PRIMARY KEY (user_id, resume_number, skill),
        FOREIGN KEY (user_id, resume_number) REFERENCES resume(user_id, resume_number) ON DELETE CASCADE
    );
    """,

    # 14. applies
    """
    CREATE TABLE IF NOT EXISTS applies (
        user_id VARCHAR(13) NOT NULL,
        resume_number INTEGER NOT NULL,
        reviewer_id VARCHAR(12) NOT NULL,
        job_id VARCHAR(40) NOT NULL,
        status VARCHAR(10),
        applied_at TIMESTAMP,
        PRIMARY KEY (user_id, resume_number, reviewer_id, job_id),
        FOREIGN KEY (user_id, resume_number) REFERENCES resume(user_id, resume_number) ON DELETE CASCADE,
        FOREIGN KEY (reviewer_id) REFERENCES reviewer(reviewer_id) ON DELETE SET NULL,
        FOREIGN KEY (job_id) REFERENCES job(job_id) ON DELETE CASCADE
    );
    """,

    # 15. freelance
    """
    CREATE TABLE IF NOT EXISTS freelance (
        job_id VARCHAR(40) PRIMARY KEY,
        project_based BOOLEAN,
        contract_length_weeks INTEGER,
        remote_possible BOOLEAN,
        FOREIGN KEY (job_id) REFERENCES job(job_id) ON DELETE CASCADE
    );
    """,

    # 16. contract
    """
    CREATE TABLE IF NOT EXISTS contract (
        job_id VARCHAR(40) PRIMARY KEY,
        contract_duration_months INTEGER,
        renewable BOOLEAN,
        FOREIGN KEY (job_id) REFERENCES job(job_id) ON DELETE CASCADE
    );
    """,

    # 17. full_time
    """
    CREATE TABLE IF NOT EXISTS full_time (
        job_id VARCHAR(40) PRIMARY KEY,
        benefit VARCHAR(100),
        working_hours_per_weeks INTEGER,
        has_insurance BOOLEAN,
        FOREIGN KEY (job_id) REFERENCES job(job_id) ON DELETE CASCADE
    );
    """,

    # 18. part_time
    """
    CREATE TABLE IF NOT EXISTS part_time (
        job_id VARCHAR(40) PRIMARY KEY,
        working_hours_per_weeks INTEGER,
        suitable_for_students BOOLEAN,
        FOREIGN KEY (job_id) REFERENCES job(job_id) ON DELETE CASCADE
    );
    """
]
for query in create_table_queries:
    cursor.execute(query)
print("✅ Semua tabel berhasil dibuat.")

create_index_queries = [

    # Index pada kolom pencarian teks
    "CREATE INDEX IF NOT EXISTS idx_job_title ON job (title);",
    "CREATE INDEX IF NOT EXISTS idx_company_name ON company (company_name);",
    "CREATE INDEX IF NOT EXISTS idx_industry_name ON industry (industry_name);",
    "CREATE INDEX IF NOT EXISTS idx_function_name ON function (function_name);",

    # Index pada kolom filter boolean dan tanggal
    "CREATE INDEX IF NOT EXISTS idx_job_is_active ON job (is_active);",
    "CREATE INDEX IF NOT EXISTS idx_job_posted_date ON job (posted_date);",
    "CREATE INDEX IF NOT EXISTS idx_compensation_salary ON compensation_package (min_salary, max_salary);",

    # Index pada kolom foreign key (untuk mempercepat join)
    "CREATE INDEX IF NOT EXISTS idx_job_company_id ON job (company_id);",
    "CREATE INDEX IF NOT EXISTS idx_job_function_id ON job (function_id);",
    "CREATE INDEX IF NOT EXISTS idx_job_location_id ON job (location_id);",
    "CREATE INDEX IF NOT EXISTS idx_job_compensation_id ON job (compensation_id);",
    "CREATE INDEX IF NOT EXISTS idx_reviewer_company_id ON reviewer (company_id);",
    "CREATE INDEX IF NOT EXISTS idx_company_industry_company_id ON company_industry (company_id);",
    "CREATE INDEX IF NOT EXISTS idx_company_industry_industry_id ON company_industry (industry_id);",
    "CREATE INDEX IF NOT EXISTS idx_applies_user_resume ON applies (user_id, resume_number);",
    "CREATE INDEX IF NOT EXISTS idx_applies_job_id ON applies (job_id);",

    # Index pada lokasi dan fungsi untuk filter
    "CREATE INDEX IF NOT EXISTS idx_location_city_country ON location (city, country);"
]
for query in create_index_queries:
    cursor.execute(query)
print("✅ Semua index berhasil dibuat.")

# =============================
# 4. INSERT DATA
# =============================
# Fungsi untuk memasukkan data fungsi pekerjaan ke tabel function
def insert_function():
    logging.info(f"Memasukkan {len(function_data)} function")
    for f in function_data:
        try:
            cursor.execute("""
                INSERT INTO function (function_id, function_name, scraped_at)
                VALUES (%s, %s, %s)
                ON CONFLICT (function_id) DO NOTHING
            """, (f["function_id"], f["function_name"], f.get("scraped_at")))
        except Exception as e:
            log_error(f"Gagal insert function_id {f['function_id']}", e)

# Fungsi untuk memasukkan data industri ke tabel industry
def insert_industry():
    logging.info(f"Memasukkan {len(industry_data)} industry")
    for i in industry_data:
        try:
            cursor.execute("""
                INSERT INTO industry (industry_id, industry_name, scraped_at)
                VALUES (%s, %s, %s)
                ON CONFLICT (industry_id) DO NOTHING
            """, (i["industry_id"], i["industry_name"], i.get("scraped_at")))
        except Exception as e:
            log_error(f"Gagal insert industry_id {i['industry_id']}", e)

# Fungsi untuk memasukkan data perusahaan ke tabel company
def insert_company():
    logging.info(f"Memasukkan {len(company_data)} company")
    for c in company_data:
        try:
            cursor.execute("""
                INSERT INTO company (company_id, company_name, scraped_at)
                VALUES (%s, %s, %s)
                ON CONFLICT (company_id) DO NOTHING
            """, (c["company_id"], c["company_name"], c.get("scraped_at")))
        except Exception as e:
            log_error(f"Gagal insert company_id {c['company_id']}", e)

# Fungsi untuk memasukkan data lokasi ke tabel location
def insert_location():
    logging.info(f"Memasukkan {len(location_data)} location")
    for l in location_data:
        try:
            cursor.execute("""
                INSERT INTO location (location_id, city, country, scraped_at)
                VALUES (%s, %s, %s, %s)
                ON CONFLICT (location_id) DO NOTHING
            """, (l["location_id"], l["city"], l["country"], l.get("scraped_at")))
        except Exception as e:
            log_error(f"Gagal insert location_id {l['location_id']}", e)

# Fungsi untuk memasukkan data gaji ke tabel compensation_package
def insert_compensation():
    logging.info(f"Memasukkan {len(compensation_data)} compensation_package")
    for c in compensation_data:
        try:
            cursor.execute("""
                INSERT INTO compensation_package (
                    compensation_id, min_salary, max_salary, currency, with_equity, scraped_at
                ) VALUES (%s, %s, %s, %s, %s, %s)
                ON CONFLICT (compensation_id) DO UPDATE
                SET min_salary = EXCLUDED.min_salary,
                    max_salary = EXCLUDED.max_salary,
                    currency = EXCLUDED.currency,
                    with_equity = EXCLUDED.with_equity,
                    scraped_at = EXCLUDED.scraped_at
                WHERE compensation_package IS DISTINCT FROM EXCLUDED
            """, (
                c["compensation_id"], c.get("min_salary"), c.get("max_salary"),
                c.get("currency"), c.get("with_equity"), c.get("scraped_at")
            ))
        except Exception as e:
            log_error(f"Gagal insert compensation_id {c['compensation_id']}", e)

# Fungsi untuk menghubungkan perusahaan dan industri (many-to-many)
def insert_company_industry():
    logging.info(f"Memasukkan {len(company_industry_data)} company_industry")
    for ci in company_industry_data:
        try:
            cursor.execute("""
                INSERT INTO company_industry (company_id, industry_id)
                VALUES (%s, %s)
                ON CONFLICT DO NOTHING
            """, (ci["company_id"], ci["industry_id"]))
        except Exception as e:
            log_error(f"Gagal insert company_id={ci['company_id']} industry_id={ci['industry_id']}", e)

# Fungsi untuk memasukkan data pekerjaan ke tabel job
def insert_jobs():
    logging.info(f"Memasukkan {len(job_data)} jobs")
    for j in job_data:
        try:
            cursor.execute("""
                INSERT INTO job (
                    job_id, title, job_type, company_id, function_id,
                    location_id, compensation_id, posted_date, scraped_at, is_active, closed_at
                ) VALUES (
                    %s, %s, %s, %s, %s, %s,
                    %s, %s, %s, TRUE, NULL
                )
                ON CONFLICT (job_id) DO UPDATE
                SET compensation_id = EXCLUDED.compensation_id,
                    scraped_at = EXCLUDED.scraped_at,
                    is_active = TRUE,
                    closed_at = NULL
                WHERE job.compensation_id IS DISTINCT FROM EXCLUDED.compensation_id
                OR job.is_active = FALSE
            """, (
                j["job_id"], j["title"], j.get("job_type"),
                j.get("company_id"), j.get("function_id"),
                j.get("location_id"), j.get("compensation_id"),
                j.get("posted_date"), j.get("scraped_at")
            ))

        except Exception as e:
            log_error(f"Gagal insert job_id {j['job_id']}", e)

# =============================
# 5. EKSEKUSI INSERT
# =============================
try:
    # Jalankan semua fungsi insert untuk masing-masing tabel
    insert_function()
    insert_industry()
    insert_company()
    insert_location()
    insert_compensation()
    insert_company_industry()
    insert_jobs()

    # Ambil daftar job_id yang discrape hari ini
    scraped_job_ids = set(j["job_id"] for j in job_data)
    logging.info(f"Total job_id yang discrape hari ini: {len(scraped_job_ids)}")

    # Tandai job lama yang tidak ada di scrape hari ini sebagai tidak aktif
    if scraped_job_ids:
        ids_placeholders = sql.SQL(',').join(sql.Placeholder() * len(scraped_job_ids))
        query = sql.SQL("""
            UPDATE job
            SET is_active = FALSE,
                closed_at = NOW()
            WHERE is_active = TRUE
            AND job_id NOT IN ({})
        """).format(ids_placeholders)
        cursor.execute(query, tuple(scraped_job_ids))
        logging.info(f"Menandai job lama sebagai non-aktif: {cursor.rowcount} rows updated.")

    conn.commit()  # Simpan semua perubahan ke database
    logging.info("✅ Semua data berhasil di-insert ke PostgreSQL.")
except Exception as e:
    conn.rollback()  # Kembalikan perubahan jika ada error
    log_error("❌ Gagal insert data utama", e)
finally:
    cursor.close()
    conn.close()  # Tutup koneksi ke database
