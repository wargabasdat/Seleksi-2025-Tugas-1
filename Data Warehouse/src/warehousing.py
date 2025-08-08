import json
import os
from datetime import datetime
import psycopg2

def clean_text(text):
    if not isinstance(text, str):
        return text
    
    replacements = {
        ' – ': ' - ', ' –': ' -', '– ': '- ', '–': '-', '—': '-',
        'â€"': '-', 'â€™': "'", 'â€œ': '"', 'â€': '"', 'â€¦': '...',
        'Â': '', 'ΓÇô': '-',
        'ô': 'o', 
        '\u00A0': ' ', '\u2000': ' ', '\u2001': ' ', '\u2002': ' ', 
        '\u2003': ' ', '\u2004': ' ', '\u2005': ' ', '\u2006': ' ',
        '\u2007': ' ', '\u2008': ' ', '\u2009': ' ', '\u200A': ' ',
        '\u202F': ' ', '\u205F': ' ', '\u3000': ' ',
    }
    
    for old, new in replacements.items():
        text = text.replace(old, new)
    
    return text

init_conn = psycopg2.connect(
    host = 'localhost',
    dbname = 'kodekiddo',
    user = 'postgres',
    password = 'veli14',
    port = 5432,
)

wh_conn = psycopg2.connect(
    host = 'localhost',
    dbname = 'warehouse_kodekiddo',
    user = 'postgres',
    password = 'veli14',
    port = 5432,
)

init_cur = init_conn.cursor()
wh_cur = wh_conn.cursor()

schema = '''
DROP TABLE IF EXISTS fact_initial_payment CASCADE;
DROP TABLE IF EXISTS dim_book_zone CASCADE;
DROP TABLE IF EXISTS dim_price CASCADE;
DROP TABLE IF EXISTS dim_books CASCADE;
DROP TABLE IF EXISTS dim_zone CASCADE;
DROP TABLE IF EXISTS dim_class CASCADE;

CREATE TABLE IF NOT EXISTS dim_class(
    course_name VARCHAR(50) PRIMARY KEY,
    course_materials VARCHAR(1000) NOT NULL,
    course_audience VARCHAR(100) NOT NULL,
    course_duration VARCHAR(100) NOT NULL,
    course_enrollment INT NOT NULL,
    course_tuition INT NOT NULL
);

CREATE TABLE IF NOT EXISTS dim_zone(
    zone_id INT PRIMARY KEY,
    details VARCHAR(1000) NOT NULL 
);

CREATE TABLE IF NOT EXISTS dim_books(
    book_id INT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    subtitle VARCHAR(200),
    isbn VARCHAR(20) NOT NULL,
    translator VARCHAR(50),
    total_pages INT NOT NULL,
    length DECIMAL(10,2) NOT NULL,
    width DECIMAL(10,2) NOT NULL,
    spine DECIMAL(10,2) NOT NULL
);

CREATE TABLE IF NOT EXISTS dim_price (
    book_id INT PRIMARY KEY,
    price_zone_1 INT NOT NULL,
    price_zone_2 INT NOT NULL,
    price_zone_3 INT NOT NULL,
    price_zone_4 INT NOT NULL,
    price_zone_5 INT NOT NULL,
    price_zone_6 INT NOT NULL,
    FOREIGN KEY (book_id) REFERENCES dim_books(book_id)
);

CREATE TABLE IF NOT EXISTS dim_book_zone (
    book_id INT,
    zone_id INT,
    PRIMARY KEY (book_id, zone_id),
    FOREIGN KEY (book_id) REFERENCES dim_books(book_id),
    FOREIGN KEY (zone_id) REFERENCES dim_zone(zone_id)
);

CREATE TABLE IF NOT EXISTS fact_initial_payment(
    coding_class_name VARCHAR(50),
    book_id INT,
    zone_id INT,
    total_price INT NOT NULL,
    PRIMARY KEY (coding_class_name, book_id, zone_id),
    FOREIGN KEY (coding_class_name) REFERENCES dim_class(course_name),
    FOREIGN KEY (book_id) REFERENCES dim_books(book_id),
    FOREIGN KEY (zone_id) REFERENCES dim_zone(zone_id)
);
'''

wh_cur.execute(schema)
wh_conn.commit()

extract_dim_class = '''
    SELECT course_name, course_materials, course_audience, course_duration, course_enrollment, course_tuition
    FROM coding_class_info
'''
init_cur.execute(extract_dim_class)
class_data = init_cur.fetchall()

extract_dim_price = '''
    SELECT * FROM books_price
'''
init_cur.execute(extract_dim_price)
price_data = init_cur.fetchall()

extract_dim_zone = '''
    SELECT * FROM zone
'''
init_cur.execute(extract_dim_zone)
zone_data = init_cur.fetchall()

extract_dim_book_zone = '''
    SELECT * FROM book_zone
'''
init_cur.execute(extract_dim_book_zone)
book_zone_data = init_cur.fetchall()

extract_dim_books = '''
    SELECT book_id, title, subtitle, isbn, translator, total_pages, length, width, spine
    FROM books
'''
init_cur.execute(extract_dim_books)
books_data = init_cur.fetchall()

insert_dim_class = 'INSERT INTO dim_class(course_name, course_materials, course_audience, course_duration, course_enrollment, course_tuition) VALUES (%s, %s, %s, %s, %s, %s) ON CONFLICT (course_name) DO NOTHING'
for i in class_data:
    insert_values = (
        clean_text(i[0]), clean_text(i[1]), clean_text(i[2]),
        clean_text(i[3]), i[4], i[5]
    )
    wh_cur.execute(insert_dim_class, insert_values)
print("Berhasil menambahkan data pada dim_class")

insert_dim_zone = 'INSERT INTO dim_zone(zone_id, details) VALUES (%s, %s) ON CONFLICT (zone_id) DO NOTHING'
for i in zone_data:
    insert_values = (
        i[0], clean_text(i[1])
    )
    wh_cur.execute(insert_dim_zone, insert_values)
print("Berhasil menambahkan data pada dim_zone")

insert_dim_books = 'INSERT INTO dim_books(book_id, title, subtitle, isbn, translator, total_pages, length, width, spine) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s) ON CONFLICT (book_id) DO NOTHING'
for i in books_data:
    insert_values = (
        i[0], clean_text(i[1]),
        clean_text(i[2] or ''), clean_text(i[3]), clean_text(i[4] or ''),
        i[5], i[6], i[7], i[8]
    )
    wh_cur.execute(insert_dim_books, insert_values)
print("Berhasil menambahkan data pada dim_books")

insert_dim_price = 'INSERT INTO dim_price(book_id, price_zone_1, price_zone_2, price_zone_3, price_zone_4, price_zone_5, price_zone_6) VALUES (%s, %s, %s, %s, %s, %s, %s) ON CONFLICT (book_id) DO NOTHING'
for i in price_data:
    insert_values = (
        i[0], i[1], i[2], i[3], i[4], i[5], i[6]
    )
    wh_cur.execute(insert_dim_price, insert_values)
print("Berhasil menambahkan data pada dim_price")

insert_dim_book_zone = 'INSERT INTO dim_book_zone(book_id, zone_id) VALUES (%s, %s) ON CONFLICT (book_id, zone_id) DO NOTHING'
for i in book_zone_data:
    insert_values = (
        i[0], i[1]
    )
    wh_cur.execute(insert_dim_book_zone, insert_values)
print("Berhasil menambahkan data pada dim_book_zone")

insert_fact = '''
INSERT INTO fact_initial_payment(coding_class_name, book_id, zone_id, total_price)
SELECT 
    CASE 
        WHEN bz.book_id = 1 THEN 'Coding for SD (Advance)'
        WHEN bz.book_id = 3 THEN 'Coding for SMP'
        WHEN bz.book_id = 4 THEN 'Coding for SMA'
        WHEN bz.book_id = 5 THEN 'Coding for SMP'
    END as coding_class_name,
    bz.book_id,
    bz.zone_id,
    c.course_enrollment + c.course_tuition + 
    CASE 
        WHEN bz.zone_id = 1 THEN p.price_zone_1
        WHEN bz.zone_id = 2 THEN p.price_zone_2
        WHEN bz.zone_id = 3 THEN p.price_zone_3
        WHEN bz.zone_id = 4 THEN p.price_zone_4
        WHEN bz.zone_id = 5 THEN p.price_zone_5
        WHEN bz.zone_id = 6 THEN p.price_zone_6
        ELSE 0
    END as total_price
FROM dim_book_zone bz
JOIN dim_price p ON bz.book_id = p.book_id
JOIN dim_class c ON c.course_name = (
    CASE 
        WHEN bz.book_id = 1 THEN 'Coding for SD (Advance)'
        WHEN bz.book_id = 3 THEN 'Coding for SMP'
        WHEN bz.book_id = 4 THEN 'Coding for SMA'
        WHEN bz.book_id = 5 THEN 'Coding for SMP'
    END
)
WHERE CASE 
    WHEN bz.book_id = 1 THEN 'Coding for SD (Advance)'
    WHEN bz.book_id = 3 THEN 'Coding for SMP'
    WHEN bz.book_id = 4 THEN 'Coding for SMA'
    WHEN bz.book_id = 5 THEN 'Coding for SMP'
END IS NOT NULL
'''

wh_cur.execute(insert_fact)
print("Berhasil insert data ke fact table (main mapping)")

insert_book_for_beginner = '''
INSERT INTO fact_initial_payment(coding_class_name, book_id, zone_id, total_price)
SELECT 'Coding for SD (Beginner)' as coding_class_name, bz.book_id, bz.zone_id,
    c.course_enrollment + c.course_tuition + 
    CASE 
        WHEN bz.zone_id = 1 THEN p.price_zone_1
        WHEN bz.zone_id = 2 THEN p.price_zone_2
        WHEN bz.zone_id = 3 THEN p.price_zone_3
        WHEN bz.zone_id = 4 THEN p.price_zone_4
        WHEN bz.zone_id = 5 THEN p.price_zone_5
        WHEN bz.zone_id = 6 THEN p.price_zone_6
        ELSE 0
    END as total_price
FROM dim_book_zone bz
JOIN dim_price p ON bz.book_id = p.book_id
JOIN dim_class c ON c.course_name = 'Coding for SD (Beginner)'
WHERE bz.book_id = 2
ON CONFLICT (coding_class_name, book_id, zone_id) DO NOTHING
'''

wh_cur.execute(insert_book_for_beginner)
print("Berhasil insert book 2 mapping ke 'Coding for SD (Beginner)'")

insert_fact_book_for_intro = '''
INSERT INTO fact_initial_payment(coding_class_name, book_id, zone_id, total_price)
SELECT 
    'Introduction to Coding' as coding_class_name,
    bz.book_id, 
    bz.zone_id,
    c.course_enrollment + c.course_tuition + 
    CASE 
        WHEN bz.zone_id = 1 THEN p.price_zone_1
        WHEN bz.zone_id = 2 THEN p.price_zone_2
        WHEN bz.zone_id = 3 THEN p.price_zone_3
        WHEN bz.zone_id = 4 THEN p.price_zone_4
        WHEN bz.zone_id = 5 THEN p.price_zone_5
        WHEN bz.zone_id = 6 THEN p.price_zone_6
        ELSE 0
    END as total_price
FROM dim_book_zone bz
JOIN dim_price p ON bz.book_id = p.book_id
JOIN dim_class c ON c.course_name = 'Introduction to Coding'
WHERE bz.book_id = 2
ON CONFLICT (coding_class_name, book_id, zone_id) DO NOTHING
'''

wh_cur.execute(insert_fact_book_for_intro)
print("Berhasil insert book 2 mapping ke 'Introduction to Coding'")

wh_conn.commit()
print("Berhasil melakukan data warehousing ke database warehouse_kodekiddo")

# Analytical Query
# 1. Rata-rata harga awal yang harus dibayarkan murid dari setiap zona ketika ingin mendaftar ke coding class di Kodekiddo
query1 = '''
SELECT coding_class_name, zone_id, ROUND(AVG(total_price),0) as rata_rata_zona
FROM fact_initial_payment
GROUP BY zone_id, coding_class_name
ORDER BY rata_rata_zona ASC;
'''
wh_cur.execute(query1)

# 2. Harga paling murah dan harga paling mahal dari setiap course
query2 = '''
SELECT coding_class_name, MIN(total_price) as min_price, MAX(total_price) as max_price
FROM fact_initial_payment
GROUP BY coding_class_name
ORDER BY max_price ASC;
'''
wh_cur.execute(query2)

if init_cur:
    init_cur.close()
if wh_cur:
    wh_cur.close()
if init_conn:
    init_conn.close()
if wh_conn:
    wh_conn.close()

# make dump to export to sql
# pg_dump -U <username> -h <hostname> -p <port> <database_name> > <dump_file_name>.sql
# pg_dump -U postgres -h localhost -p 5432 warehouse_kodekiddo > warehouse_kodekiddo.sql 