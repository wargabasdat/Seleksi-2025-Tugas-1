# Import module
import psycopg2
import json

# Koneksi untuk ke database PostgreSQL lokal
conn = psycopg2.connect(
    dbname="beautiful_faces_2023",
    user="postgres",
    password="08Des2004",
    host="localhost",
    port="5432"
)

cur = conn.cursor()

# Load data dari JSON hasil scraping
with open("Data Scraping/data/beautiful_faces_2023.json", "r", encoding="utf-8") as f:
    data = json.load(f)

job_map = {}
country_map = {}

try:
    # Insert job dan country unik
    for item in data:
        job = item["job"]
        country = item["country"]

        if job not in job_map:
            cur.execute("INSERT INTO Job (jobName) VALUES (%s) RETURNING jobsID", (job,))
            job_map[job] = cur.fetchone()[0]
            print(f"Inserted Job: {job} with ID {job_map[job]}")

        if country not in country_map:
            cur.execute("INSERT INTO Country (countryName) VALUES (%s) RETURNING countryID", (country,))
            country_map[country] = cur.fetchone()[0]
            print(f"Inserted Country: {country} with ID {country_map[country]}")

    # Insert data person
    for item in data:
        cur.execute("""
            INSERT INTO Person (rank, personName, jobsID, countryID)
            VALUES (%s, %s, %s, %s)
        """, (
            item["rank"],
            item["name"],
            job_map[item["job"]],
            country_map[item["country"]]
        ))
        print(f"Inserted Person: {item['name']} with rank {item['rank']}")

    conn.commit()

except Exception as e:
    print("Error:", e)
    conn.rollback()

finally:
    cur.close()
    conn.close()
