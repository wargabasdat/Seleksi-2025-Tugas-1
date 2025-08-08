import json
import psycopg2
from typing import TypedDict, List, Sequence

# --- Define TypedDicts ---

class Index(TypedDict):
    index_name: str
    index_link: str

class TropeUsage(TypedDict):
    trope_name: str
    trope_usage: str

class Trope(TypedDict):
    trope_name: str
    trope_link: str
    trope_description: str

class Series(TypedDict):
    series_name: str
    series_link: str
    series_tropes: Sequence[TropeUsage]
    series_indexes: List[Index]

# --- Load NDJSON using built-in json ---

def load_ndjson(filepath):
    with open(filepath, "r", encoding="utf-8") as f:
        return [json.loads(line) for line in f if line.strip()]

series_data: List[Series] = load_ndjson("../../Data Scraping/data/series.ndjson")
trope_data: List[Trope] = load_ndjson("../../Data Scraping/data/tropes.ndjson")

# --- Connect to PostgreSQL ---

conn = psycopg2.connect(
    dbname="tvtropes",
    user="postgres",
    password="postgres",
    host="localhost",
    port="5432"
)
cur = conn.cursor()

# --- Create Tables ---

cur.execute("""
CREATE TABLE IF NOT EXISTS idx (
    index_name TEXT PRIMARY KEY,
    index_link TEXT NOT NULL
);
""")

cur.execute("""
CREATE TABLE IF NOT EXISTS trope (
    trope_name TEXT PRIMARY KEY,
    trope_link TEXT NOT NULL,
    trope_description TEXT NOT NULL
);
""")

cur.execute("""
CREATE TABLE IF NOT EXISTS series (
    series_name TEXT PRIMARY KEY,
    series_link TEXT NOT NULL
);
""")

cur.execute("""
CREATE TABLE IF NOT EXISTS series_index (
    series_name TEXT NOT NULL,
    index_name TEXT NOT NULL,
    FOREIGN KEY (series_name) REFERENCES series(series_name),
    FOREIGN KEY (index_name) REFERENCES idx(index_name),
    PRIMARY KEY (series_name, index_name)
);
""")

cur.execute("""
CREATE TABLE IF NOT EXISTS series_trope (
    series_name TEXT NOT NULL,
    trope_name TEXT NOT NULL,
    trope_usage TEXT NOT NULL,
    FOREIGN KEY (series_name) REFERENCES series(series_name),
    FOREIGN KEY (trope_name) REFERENCES trope(trope_name),
    PRIMARY KEY (series_name, trope_name)
);
""")

# --- Insert Tropes ---

for trope in trope_data:
    cur.execute("""
    INSERT INTO trope (trope_name, trope_link, trope_description)
    VALUES (%s, %s, %s)
    ON CONFLICT (trope_name) DO NOTHING
    """, (trope['trope_name'], trope['trope_link'], trope['trope_description']))

# --- Insert Series and Related Data ---

for series in series_data:
    cur.execute("""
    INSERT INTO series (series_name, series_link)
    VALUES (%s, %s)
    ON CONFLICT (series_name) DO NOTHING
    """, (series['series_name'], series['series_link']))

    for idx in series['series_indexes']:
        cur.execute("""
        INSERT INTO idx (index_name, index_link)
        VALUES (%s, %s)
        ON CONFLICT (index_name) DO NOTHING
        """, (idx['index_name'], idx['index_link']))
        cur.execute("""
        INSERT INTO series_index (series_name, index_name)
        VALUES (%s, %s)
        ON CONFLICT DO NOTHING
        """, (series['series_name'], idx['index_name']))

    for usage in series['series_tropes']:
        cur.execute("""
        INSERT INTO series_trope (series_name, trope_name, trope_usage)
        VALUES (%s, %s, %s)
        ON CONFLICT DO NOTHING
        """, (series['series_name'], usage['trope_name'], usage['trope_usage']))

# --- Commit and Close ---

conn.commit()
cur.close()
conn.close()
