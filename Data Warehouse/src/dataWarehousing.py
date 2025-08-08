import psycopg2
import json
import os

def create_tables(cur):
    cur.execute("""
    CREATE TABLE IF NOT EXISTS DimJob (
        jobsID SERIAL PRIMARY KEY,
        jobName VARCHAR(100) UNIQUE NOT NULL
    );
    """)
    cur.execute("""
    CREATE TABLE IF NOT EXISTS DimCountry (
        countryID SERIAL PRIMARY KEY,
        countryName VARCHAR(100) UNIQUE NOT NULL
    );
    """)
    cur.execute("""
    CREATE TABLE IF NOT EXISTS DimPerson (
        personID SERIAL PRIMARY KEY,
        personName VARCHAR(255) NOT NULL,
        rank INT
    );
    """)
    cur.execute("""
    CREATE TABLE IF NOT EXISTS FactPerson (
        factPersonID SERIAL PRIMARY KEY,
        personID INT REFERENCES DimPerson(personID),
        jobsID INT REFERENCES DimJob(jobsID),
        countryID INT REFERENCES DimCountry(countryID),
        occurrence INT DEFAULT 1,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );
    """)

def load_data_to_warehouse(cur, data):
    job_map = {}
    country_map = {}
    person_map = {}

    # Insert DimJob
    for item in data:
        job = item['job'].strip()
        if job not in job_map:
            cur.execute("INSERT INTO DimJob (jobName) VALUES (%s) ON CONFLICT (jobName) DO NOTHING RETURNING jobsID;", (job,))
            res = cur.fetchone()
            if res:
                job_map[job] = res[0]
            else:
                cur.execute("SELECT jobsID FROM DimJob WHERE jobName=%s;", (job,))
                job_map[job] = cur.fetchone()[0]

    # Insert DimCountry
    for item in data:
        country = item['country'].strip()
        if country not in country_map:
            cur.execute("INSERT INTO DimCountry (countryName) VALUES (%s) ON CONFLICT (countryName) DO NOTHING RETURNING countryID;", (country,))
            res = cur.fetchone()
            if res:
                country_map[country] = res[0]
            else:
                cur.execute("SELECT countryID FROM DimCountry WHERE countryName=%s;", (country,))
                country_map[country] = cur.fetchone()[0]

    # Insert DimPerson dan FactPerson
    for item in data:
        name = item['name'].strip()
        rank = item['rank']
        job = item['job'].strip()
        country = item['country'].strip()

        # Insert DimPerson
        cur.execute("INSERT INTO DimPerson (personName, rank) VALUES (%s, %s) RETURNING personID;", (name, rank))
        person_id = cur.fetchone()[0]

        # Insert FactPerson
        cur.execute("""
            INSERT INTO FactPerson (personID, jobsID, countryID, occurrence) VALUES (%s, %s, %s, 1);
        """, (person_id, job_map[job], country_map[country]))

def main():
    # Koneksi DB
    conn = psycopg2.connect(
        dbname="beautiful_faces_2023",
        user="postgres",
        password="08Des2004",
        host="localhost",
        port="5432"
    )
    cur = conn.cursor()

    create_tables(cur)

    # Load data dari JSON
    with open("Data Scraping/data/beautiful_faces_2023.json", "r", encoding="utf-8") as f:
        data = json.load(f)

    load_data_to_warehouse(cur, data)
    conn.commit()

    cur.close()
    conn.close()
    print("Data berhasil dimuat ke data warehouse.")

if __name__ == "__main__":
    main()
