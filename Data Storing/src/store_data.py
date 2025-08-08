import json
import mysql.connector as mc
from pathlib import Path

# Konfigurasi koneksi database
DB_CONFIG = {
    "host": "localhost",
    "user": "root",
    "password": "meteor",
    "database": "top_paintings",
    "charset":  "utf8mb4"
}

# Koneksi dan cursor MySQL
conn = mc.connect(**DB_CONFIG)
cur  = conn.cursor(buffered=True)   

# Cache untuk id agar tidak query berulang
country_cache, city_cache, museum_cache, artist_cache, art_styles_cache, art_subjects_cache = {}, {}, {}, {}, {}, {}

# Ambil atau buat country
def get_or_create_country(name: str) -> int:
    if name in country_cache:
        return country_cache[name]

    cur.execute("SELECT id_country FROM country WHERE name=%s", (name,))
    row = cur.fetchone()
    if row:
        country_cache[name] = row[0]
        return row[0]

    cur.execute(
        """
        INSERT INTO country(name)
        VALUES (%s)
        ON DUPLICATE KEY UPDATE id_country = LAST_INSERT_ID(id_country)
        """,
        (name,),
    )
    conn.commit()                          
    country_id = cur.lastrowid             
    country_cache[name] = country_id
    return country_id

# Commit jika autocommit mati
def _ensure_committed():
    if not conn.autocommit:
        conn.commit()

# Ambil atau buat city
def get_or_create_city(name: str, country_name: str) -> int:
    key = (name, country_name)
    if key in city_cache:
        return city_cache[key]

    id_country = get_or_create_country(country_name)
    cur.execute(
        "SELECT id_city FROM city WHERE name=%s AND id_country=%s",
        (name, id_country),
    )
    row = cur.fetchone()
    if row:
        city_cache[key] = row[0]
        return row[0]

    cur.execute(
        """
        INSERT INTO city(name, id_country)
        VALUES (%s, %s)
        ON DUPLICATE KEY UPDATE id_city = LAST_INSERT_ID(id_city)
        """,
        (name, id_country),
    )
    _ensure_committed()
    city_id = cur.lastrowid
    city_cache[key] = city_id
    return city_id

# Ambil atau buat museum
def get_or_create_museum(name: str, city_name: str, country_name: str) -> int:
    if name in museum_cache:
        return museum_cache[name]

    cur.execute("SELECT id_museum FROM museum WHERE name=%s", (name,))
    row = cur.fetchone()
    if row:
        museum_cache[name] = row[0]
        return row[0]

    id_city = (
        get_or_create_city(city_name, country_name) if city_name else None
    )
    cur.execute(
        """
        INSERT INTO museum(name, id_city)
        VALUES (%s, %s)
        ON DUPLICATE KEY UPDATE id_museum = LAST_INSERT_ID(id_museum)
        """,
        (name, id_city),
    )
    _ensure_committed()
    museum_id = cur.lastrowid
    museum_cache[name] = museum_id
    return museum_id

# Ambil atau buat artist
def get_or_create_artist(name: str, birth_year=None, death_year=None,
                         nationality=None, biography=None) -> int:
    if name in artist_cache:
        return artist_cache[name]

    cur.execute("SELECT id_artist FROM artist WHERE name=%s", (name,))
    row = cur.fetchone()
    if row:
        artist_cache[name] = row[0]
        cur.execute("""
            UPDATE artist
               SET birth_year=%s, death_year=%s, nationality=%s, biography=%s
             WHERE id_artist=%s
        """, (birth_year, death_year, nationality, biography, row[0]))
        _ensure_committed()
        return row[0]

    cur.execute("""
        INSERT INTO artist(name, birth_year, death_year, nationality, biography)
        VALUES (%s,%s,%s,%s,%s)
        ON DUPLICATE KEY UPDATE id_artist=LAST_INSERT_ID(id_artist),
                                birth_year=VALUES(birth_year),
                                death_year=VALUES(death_year),
                                nationality=VALUES(nationality),
                                biography=VALUES(biography)
    """, (name, birth_year, death_year, nationality, biography))
    _ensure_committed()
    artist_id = cur.lastrowid
    artist_cache[name] = artist_id
    return artist_id

# Ambil atau buat art style
def get_or_create_art_style(name: str) -> int:
    if name in art_styles_cache:
        return art_styles_cache[name]

    cur.execute("SELECT id_style FROM art_style WHERE name=%s", (name,))
    row = cur.fetchone()
    if row:
        art_styles_cache[name] = row[0]
        return row[0]

    cur.execute(
        """
        INSERT INTO art_style(name)
        VALUES (%s)
        ON DUPLICATE KEY UPDATE id_style = LAST_INSERT_ID(id_style)
        """,
        (name,),
    )
    conn.commit()
    art_style_id = cur.lastrowid
    art_styles_cache[name] = art_style_id
    return art_style_id

# Ambil atau buat art subject
def get_or_create_art_subject(name: str) -> int:
    if name in art_subjects_cache:
        return art_subjects_cache[name]

    cur.execute("SELECT id_subject FROM art_subject WHERE name=%s", (name,))
    row = cur.fetchone()
    if row:
        art_subjects_cache[name] = row[0]
        return row[0]

    cur.execute(
        """
        INSERT INTO art_subject(name)
        VALUES (%s)
        ON DUPLICATE KEY UPDATE id_subject = LAST_INSERT_ID(id_subject)
        """,
        (name,),
    )
    conn.commit()
    art_subject_id = cur.lastrowid
    art_subjects_cache[name] = art_subject_id
    return art_subject_id

# Insert atau update painting
def get_or_create_painting(painting, id_artist, id_museum):
    def to_decimal(val):
        if val in ("", None):
            return None
        try:
            return float(val)
        except Exception:
            return None
    cur.execute(
        """
        INSERT INTO painting
          (id_painting, title, year, oil_price, canvas_price, ori_size, id_artist, id_museum)
        VALUES (%s,%s,%s,%s,%s,%s,%s,%s)
        ON DUPLICATE KEY UPDATE
          title=VALUES(title), year=VALUES(year), oil_price=VALUES(oil_price),
          canvas_price=VALUES(canvas_price), ori_size=VALUES(ori_size),
          id_artist=VALUES(id_artist), id_museum=VALUES(id_museum)
        """,
        (
            painting["sku"],
            painting["title"],
            painting.get("year"),
            to_decimal(painting.get("oil_price_euro")),
            to_decimal(painting.get("canvas_price_euro")),
            painting.get("original_size"),
            id_artist,
            id_museum,
        ),
    )

# Relasi artist-style (many-to-many)
def link_artist_style(cur, id_artist, id_style):
    cur.execute(
        "INSERT IGNORE INTO artist_style(id_artist, id_style) VALUES (%s,%s)",
        (id_artist, id_style),
    )

# Load data dari file JSON
BASE = Path("Data Scraping/data/")
countries = json.loads((BASE / "countries.json").read_text(encoding="utf-8"))
cities     = json.loads((BASE / "cities.json").read_text(encoding="utf-8"))
museums    = json.loads((BASE / "museums.json").read_text(encoding="utf-8"))
paintings  = json.loads((BASE / "top_paintings.json").read_text(encoding="utf-8"))
art_styles  = json.loads((BASE / "art_styles.json").read_text(encoding="utf-8"))
art_subjects  = json.loads((BASE / "art_subjects.json").read_text(encoding="utf-8"))
artists = json.loads((BASE / "artists.json").read_text(encoding="utf-8"))

# Masukkan country ke DB
for c in countries:
    get_or_create_country(c["name"])

# Masukkan city ke DB
for c in cities:
    get_or_create_city(c["name"], c["country"])

# Masukkan museum ke DB
for m in museums:
    get_or_create_museum(m["name"], m["city_name"],  
                         next((ct["country"] for ct in cities
                              if ct["name"] == m["city_name"]), ""))

# Masukkan painting ke DB
for p in paintings:
    id_artist = get_or_create_artist(p["artist"])

    m_entry = next((m for m in museums if m["name"] == p["museum"]), None)
    city_name    = m_entry["city_name"] if m_entry else ""
    country_name = next((ct["country"] for ct in cities if ct["name"] == city_name), "")
    id_museum    = get_or_create_museum(p["museum"], city_name, country_name)

    get_or_create_painting(p, id_artist, id_museum)

# Masukkan art style ke DB
for s in art_styles:
    get_or_create_art_style(s["name"])

# Masukkan art subject ke DB
for s in art_subjects:
    get_or_create_art_subject(s["name"])

# Masukkan artist dan relasi style ke DB
for a in artists:
    id_artist = get_or_create_artist(
        a["name"],
        int(a["birth_year"]) if a.get("birth_year") else None,
        int(a["death_year"]) if a.get("death_year") else None,
        a.get("nationality"),
        a.get("biography"),
    )

    styles = a.get("art_style")
    if isinstance(styles, str):
        styles = [s.strip() for s in styles.split(",") if s.strip()]
    for s in styles or []:
        id_style = get_or_create_art_style(s)
        link_artist_style(cur, id_artist, id_style)

    for p in a.get("paintings", []):
        id_museum = get_or_create_museum(
            p.get("museum") or "",
            p.get("city") or "",
            p.get("country") or "",
        )
        get_or_create_painting(p, id_artist, id_museum)

# Commit dan
conn.commit()
cur.close()
conn.close()
