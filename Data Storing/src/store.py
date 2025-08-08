import json, os, re, urllib.parse
import psycopg2
import subprocess
import shlex

# ===== Path folder data =====
DATA_DIR = 'Seleksi-2025-Tugas-1/Data Scraping/data'   # ganti kalau file JSON ada di folder lain

def jp(fname): return os.path.join(DATA_DIR, fname)

def load_json(fname):
    with open(jp(fname), 'r', encoding='utf-8') as f:
        return json.load(f)

def clean_text(x):
    if not isinstance(x, str):
        return x

    # Decode karakter encoded di URL (%27 -> ')
    x = urllib.parse.unquote(x)

    # Mapping karakter aneh ke normal
    replacements = {
        '\u00A0': ' ', '\u2000': ' ', '\u2001': ' ', '\u2002': ' ', '\u2003': ' ',
        '\u2004': ' ', '\u2005': ' ', '\u2006': ' ', '\u2007': ' ', '\u2008': ' ',
        '\u2009': ' ', '\u200A': ' ', '\u202F': ' ', '\u205F': ' ', '\u3000': ' ',
        '\u2013': '-', '\u2014': '-', '–': '-', '—': '-',
        '\u2018': "'", '\u2019': "'", '\u201C': '"', '\u201D': '"',
        'â€™': "'", 'â€œ': '"', 'â€': '"', 'â€“': '-',
    }

    for old, new in replacements.items():
        x = x.replace(old, new)

    # Hapus spasi berlebihan
    x = re.sub(r'\s+', ' ', x)

    return x.strip()
def to_int_or_null(v):
    if v is None: return None
    s = str(v).strip()
    if s == "": return None
    # buang koma pada capacity
    s = s.replace(",", "")
    try:
        return int(s)
    except:
        return None

# ===== Load data JSON =====
active_theatres   = load_json('active_theatres.json')            # Theatre_name, Capacity
design_works      = load_json('architects.json')                 # ID, Theatre   (relasi)
former_theatres   = load_json('former_existing_theatres.json')   # Theatre_name, Current_use, Last_opened
list_architects   = load_json('list_architects.json')            # Architect, ID (master architect)
organizations     = load_json('organizations.json')              # Owner
productions       = load_json('productions.json')                # Title, Theatre_name, Opening_year
theatres          = load_json('theatres.json')                   # Theatre_name, Address, Opening_year, Owner
broadway_shows    = load_json('shows.json')                       # Show

# ===== Connect DB =====
conn = psycopg2.connect(
    host='localhost', dbname='broadway', user='postgres', password='noeriza', port=5432
)
cur = conn.cursor()

# ===== Create schema (PK production pakai (show_title, theatre_name, opening_year)) =====
schema = """
DROP TABLE IF EXISTS design_work CASCADE;
DROP TABLE IF EXISTS active_theatre CASCADE;
DROP TABLE IF EXISTS former_existing_theatre CASCADE;
DROP TABLE IF EXISTS production CASCADE;
DROP TABLE IF EXISTS broadway_show CASCADE;
DROP TABLE IF EXISTS theatre CASCADE;
DROP TABLE IF EXISTS architect CASCADE;
DROP TABLE IF EXISTS organization CASCADE;

CREATE TABLE organization(
    company_name VARCHAR(200) PRIMARY KEY,
    company_type VARCHAR(100)
);

CREATE TABLE architect(
    id INT PRIMARY KEY,
    name VARCHAR(200) NOT NULL
);

CREATE TABLE theatre(
    theatre_name VARCHAR(200) PRIMARY KEY,
    address VARCHAR(300),
    opening_year INT,
    company_name VARCHAR(200) REFERENCES organization(company_name)
);

CREATE TABLE active_theatre(
    theatre_name VARCHAR(200) PRIMARY KEY REFERENCES theatre(theatre_name),
    capacity INT
);

CREATE TABLE former_existing_theatre(
    theatre_name VARCHAR(200) PRIMARY KEY REFERENCES theatre(theatre_name),
    last_opened INT,
    current_use VARCHAR(200)
);

CREATE TABLE broadway_show(
    title VARCHAR(300) PRIMARY KEY,
    composer VARCHAR(200),
    writer VARCHAR(200),
    lyricist VARCHAR(200),
    show_type VARCHAR(50)
);

CREATE TABLE production(
    show_title   VARCHAR(300) REFERENCES broadway_show(title),
    theatre_name VARCHAR(200) REFERENCES theatre(theatre_name),
    opening_year INT,
    PRIMARY KEY (show_title, theatre_name, opening_year)
);

CREATE TABLE design_work(
    architect_id INT REFERENCES architect(id),
    theatre_name VARCHAR(200) REFERENCES theatre(theatre_name),
    PRIMARY KEY (architect_id, theatre_name)
);
"""
cur.execute(schema)
conn.commit()
print("✅ Schema dibuat")

# ===== INSERT: organization (dari organizations.json: Owner -> company_name) =====
for o in organizations:
    cur.execute("""
        INSERT INTO organization(company_name)
        VALUES (%s) ON CONFLICT DO NOTHING
    """, (clean_text(o['Owner']),))
conn.commit()

# ===== INSERT: architect (dari list_architects.json: ID + Architect) =====
for a in list_architects:
    cur.execute("""
        INSERT INTO architect(id, name)
        VALUES (%s, %s) ON CONFLICT DO NOTHING
    """, (a['ID'], clean_text(a['Architect'])))
conn.commit()

# ===== INSERT: theatre (theatres.json: Theatre_name, Address, Opening_year, Owner -> company_name) =====
for t in theatres:
    cur.execute("""
        INSERT INTO theatre(theatre_name, address, opening_year, company_name)
        VALUES (%s, %s, %s, %s)
        ON CONFLICT DO NOTHING
    """, (
        clean_text(t['Theatre_name']),
        clean_text(t.get('Address')),
        to_int_or_null(t.get('Opening_year')),
        clean_text(t.get('Owner'))
    ))
conn.commit()

# ===== INSERT: active_theatre (active_theatres.json) =====
for at in active_theatres:
    cur.execute("""
        INSERT INTO active_theatre(theatre_name, capacity)
        VALUES (%s, %s)
        ON CONFLICT DO NOTHING
    """, (
        clean_text(at['Theatre_name']),
        to_int_or_null(at.get('Capacity'))
    ))
conn.commit()

# ===== INSERT: former_existing_theatre (former_existing_theatres.json) =====
for ft in former_theatres:
    cur.execute("""
        INSERT INTO former_existing_theatre(theatre_name, last_opened, current_use)
        VALUES (%s, %s, %s)
        ON CONFLICT DO NOTHING
    """, (
        clean_text(ft['Theatre_name']),
        to_int_or_null(ft.get('Last_opened')),
        clean_text(ft.get('Current_use'))
    ))
conn.commit()

# ===== INSERT: broadway_show (show.json: cuma kolom Show -> title) =====
for s in broadway_shows:
    cur.execute("""
        INSERT INTO broadway_show(title)
        VALUES (%s) ON CONFLICT DO NOTHING
    """, (clean_text(s['Show']),))
conn.commit()

# ===== INSERT: production (productions.json) =====
for p in productions:
    cur.execute("""
        INSERT INTO production(show_title, theatre_name, opening_year)
        VALUES (%s, %s, %s)
        ON CONFLICT DO NOTHING
    """, (
        clean_text(p['Title']),
        clean_text(p['Theatre_name']),
        to_int_or_null(p.get('Opening_year'))
    ))
conn.commit()

# ===== INSERT: design_work (architects.json: ID + Theatre) =====
for dw in design_works:
    cur.execute("""
        INSERT INTO design_work(architect_id, theatre_name)
        VALUES (%s, %s)
        ON CONFLICT DO NOTHING
    """, (
        dw['ID'],                 # integer ID arsitek
        clean_text(dw['Theatre']) # nama teater persis dari JSON
    ))
conn.commit()

cur.close()
conn.close()
print("🎉 Semua data berhasil dimasukkan")

# ===== Dump database ke file SQL =====
# Pastikan pg_dump ada di PATH atau sesuaikan pathnya
OUTPUT_SQL = "/Users/noeriza/Documents/SELEKSI/Seleksi-2025-Tugas-1/Data Storing/export/broadway.sql"  # ganti kalau mau
cmd = f'/Library/PostgreSQL/17/bin/pg_dump -h localhost -p 5432 -U postgres -d broadway -F p -f "{OUTPUT_SQL}"'
env = os.environ.copy()
env["PGPASSWORD"] = "noeriza"  # samain dengan password yang dipakai psycopg2

try:
    print(f"🗂️  Dumping to: {OUTPUT_SQL}")
    # gunakan shell=False + shlex.split untuk aman
    res = subprocess.run(shlex.split(cmd), env=env, capture_output=True, text=True)
    if res.returncode == 0:
        print("✅ Dump selesai")
    else:
        print("❌ Dump gagal")
        print("STDOUT:", res.stdout)
        print("STDERR:", res.stderr)
except FileNotFoundError:
    print("❌ Tidak menemukan perintah `pg_dump`. Pastikan PostgreSQL bin ada di PATH.")

# ===== Dump database ke file SQL menggunakan terminal =====
# pg_dump -U <username> -h <hostname> -p <port> <database_name> > <dump_file_name>.sql

