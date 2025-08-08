import psycopg2
import json

# hubungkan database
conn = psycopg2.connect(
    host="localhost",
    database="gunung",
    user="postgres",
    password="admin"
)
cur = conn.cursor()

# insert negara dari daftar_negara.json
with open('../../Data Scraping/data/daftar_negara.json', encoding='utf-8') as f:
    data = json.load(f)
    for negara in data:
        cur.execute("""
            INSERT INTO Negara (id_negara, nama_negara)
            VALUES (%s, %s)
            ON CONFLICT DO NOTHING;
        """, (negara['id'], negara['nama']))

# insert pegunungan dari daftar_pegunungan.json
with open('../../Data Scraping/data/daftar_pegunungan.json', encoding='utf-8') as f:
    data = json.load(f)
    for pegunungan in data:
        cur.execute("""
            INSERT INTO Pegunungan (id_pegunungan, nama, jumlah_gunung)
            VALUES (%s, %s, %s)
            ON CONFLICT DO NOTHING;
        """, (pegunungan['id'], pegunungan['nama'], pegunungan['jumlah_gunung']))

# insert gunung dan lokasi_gunung dari daftar_gunung.json
with open('../../Data Scraping/data/daftar_gunung.json', encoding='utf-8') as f:
    data = json.load(f)
    for gunung in data:
        cur.execute("""
            INSERT INTO Gunung (id_gunung, peringkat, nama_gunung, ketinggian_m, lintang, bujur, id_pegunungan)
            VALUES (%s, %s, %s, %s, %s, %s, %s)
            ON CONFLICT DO NOTHING;
        """, (
            gunung['id'],
            int(gunung['peringkat']),
            gunung['nama'],
            gunung['ketinggian_m'],
            gunung['lintang'],
            gunung['bujur'],
            gunung['id_pegunungan']
        ))

        for id_negara in gunung['id_negara']:
            cur.execute("""
                INSERT INTO Lokasi_Gunung (id_negara, id_gunung)
                VALUES (%s, %s)
                ON CONFLICT DO NOTHING;
            """, (id_negara, gunung['id']))

# commit
conn.commit()
cur.close()
conn.close()
print("Done.")
