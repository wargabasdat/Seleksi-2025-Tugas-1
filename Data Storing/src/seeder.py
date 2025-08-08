import json, os
from pathlib import Path
from datetime import datetime
import mysql.connector as mysql

ROOT = Path(__file__).resolve().parents[2]
DATA_DIR = ROOT / "Data Scraping" / "data"
COUNTRY_JSON  = DATA_DIR / "country.json"
CITY_JSON     = DATA_DIR / "city.json"
UNICORNS_JSON = DATA_DIR / "unicorns.json"

for p in [COUNTRY_JSON, CITY_JSON, UNICORNS_JSON]:
    if not p.exists():
        raise FileNotFoundError(f"Missing: {p}")


conn = mysql.connect(
    host='localhost',
    user='unicorns_app',
    password='basdat1',
    database='unicorns',
    auth_plugin= 'mysql_native_password'
)

def normalize_date(s):
    if not s: return None
    try:
        return datetime.strptime(s, "%m/%d/%Y").strftime("%Y-%m-%d")
    except Exception:
        return None

DDL = [
    """
    CREATE TABLE IF NOT EXISTS country (
        country_id   INT NOT NULL,
        country_name VARCHAR(255) NOT NULL,
        PRIMARY KEY (country_id),
        UNIQUE KEY ux_country_name (country_name)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
    """,
    
    """
    CREATE TABLE IF NOT EXISTS city (
        country_id INT NOT NULL,
        city_id INT NOT NULL,
        city_name VARCHAR(255) NOT NULL,
        PRIMARY KEY (country_id, city_id),
        CONSTRAINT fk_city_country
            FOREIGN KEY (country_id) REFERENCES country(country_id) ON UPDATE CASCADE ON DELETE CASCADE
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
    """,

    """
    CREATE TABLE IF NOT EXISTS unicorn (
        unicorn_id BIGINT NOT NULL AUTO_INCREMENT,
        company_name VARCHAR(255) NOT NULL,
        valuation DECIMAL(12,2) NULL,
        date_joined DATE NULL,
        country_id INT NOT NULL,
        city_id INT NOT NULL,
        industry VARCHAR(255) NULL,
        investors TEXT NULL,
        PRIMARY KEY (unicorn_id),
        CONSTRAINT fk_unicorn_city
            FOREIGN KEY (country_id, city_id) REFERENCES city(country_id, city_id) ON UPDATE CASCADE ON DELETE RESTRICT
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
    """
]

def run_ddl(cur):
    for stmt in DDL:
        cur.execute(stmt)

def load_json(p: Path):
    with p.open("r", encoding="utf-8") as f:
        return json.load(f)

def main():
    try:
        cur = conn.cursor()
        run_ddl(cur)

        countries = load_json(COUNTRY_JSON)
        cur.executemany(
            """
            INSERT INTO country (country_id, country_name)
            VALUES (%s, %s)
            """,
            [(c["country_id"], c["country_name"]) for c in countries]
        )

        cities = load_json(CITY_JSON)
        city_rows = [(c["country_id"], c["city_name"])
                     for c in cities if c.get("country_id") and c.get("city_name")]
        cur.executemany(
            """
            INSERT INTO city (country_id, city_name)
            VALUES (%s, %s)
            """,
            city_rows
        )

        uni_payload = load_json(UNICORNS_JSON)
        records = uni_payload.get("records", uni_payload)

        uni_rows = []
        for r in records:
            company = r.get("company")
            valuation = r.get("valuation")
            dj = normalize_date(r.get("date_joined"))
            country_id = r.get("country_id")
            city_id = r.get("city_id")
            industry = r.get("industry")
            investors = r.get("investors")
            if not (company and country_id and city_id):
                continue
            uni_rows.append((company, valuation, dj, country_id, city_id, industry, investors))

        cur.executemany(
            """
            INSERT INTO unicorn
              (company_name, valuation, date_joined, country_id, city_id, industry, selected_investors)
            VALUES (%s, %s, %s, %s, %s, %s, %s)
            ON DUPLICATE KEY UPDATE
              valuation = VALUES(valuation),
              date_joined = VALUES(date_joined),
              country_id = VALUES(country_id),
              city_id = VALUES(city_id),
              industry = VALUES(industry),
              selected_investors = VALUES(selected_investors)
            """,
            uni_rows
        )

        conn.commit()
        print(f"Seeded: {len(countries)} countries, {len(city_rows)} cities, {len(uni_rows)} unicorns.")
    finally:
        conn.close()

if __name__ == "__main__":
    main()
