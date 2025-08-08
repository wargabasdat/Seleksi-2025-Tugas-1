import json
import psycopg2

# Konfig koneksi database
db_params = {
    "host": "localhost",
    "database": "cgv_cinemas",
    "user": "postgres",
    "password": "*********" #sensor mandiri wkwkw
}

# Baca data dari file JSON
try:
    with open('data\city.json', 'r', encoding='utf-8') as f:
        cities_data = json.load(f)
    with open('data\cinema.json', 'r', encoding='utf-8') as f:
        cinemas_data = json.load(f)
    with open('data\auditorium.json', 'r', encoding='utf-8') as f:
        auditoriums_data = json.load(f)
except FileNotFoundError as e:
    print(f"Error: File JSON tidak ditemukan. {e}")
    exit()

# Dictionary buat mapping nama auditorium ke ID
auditorium_id_map = {auditorium['name']: auditorium['id'] for auditorium in auditoriums_data}

# Masukkan data ke database
conn = None
try:
    conn = psycopg2.connect(**db_params)
    cur = conn.cursor()
    
    #  Memuat data ke tabel city 
    print("Memuat data ke tabel city...")
    for city in cities_data:
        cur.execute("INSERT INTO city (id, name) VALUES (%s, %s) ON CONFLICT (id) DO NOTHING;",
                    (int(city['CityID']), city['CityName']))

    #  Memuat data ke tabel cinema 
    print("Memuat data ke tabel cinema...")
    for cinema in cinemas_data:
        cur.execute("INSERT INTO cinema (id, name, address, id_kota) VALUES (%s, %s, %s, %s) ON CONFLICT (id) DO NOTHING;",
                    (int(cinema['CinemaID']), cinema['CinemaName'], cinema['CinemaAddress'], int(cinema['CityID'])))
        
        #  Memuat data ke tabel auditorium_type 
    print("Memuat data ke tabel auditorium_type...")
    for auditorium in auditoriums_data:
        cur.execute("INSERT INTO auditorium_type (id, name) VALUES (%s, %s) ON CONFLICT (id) DO NOTHING;",
                    (auditorium['id'], auditorium['name']))
    
    # --- Memuat data ke tabel perantara cinema_auditorium ---
    print("Memuat data ke tabel cinema_auditorium...")
    for cinema in cinemas_data:
        for auditorium_type_name in cinema['auditoriumTypes']:
            auditorium_type_id = auditorium_id_map.get(auditorium_type_name)
            if auditorium_type_id is not None:
                cur.execute("INSERT INTO cinema_auditorium (id_bioskop, id_auditorium_type) VALUES (%s, %s) ON CONFLICT DO NOTHING;",
                            (int(cinema['CinemaID']), auditorium_type_id))

    conn.commit()
    print("Data berhasil dimuat.")

except (Exception, psycopg2.DatabaseError) as error:
    print(f"Error saat memuat data: {error}")
finally:
    if conn is not None:
        cur.close()
        conn.close()