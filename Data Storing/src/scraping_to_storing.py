import psycopg2
import json
import os

conn = psycopg2.connect(
    dbname="duma_website",
    user="postgres",
    password=" ",
    host="localhost",
    port="5432"
)
cur = conn.cursor()

def load_json(filename):
    base_path = "/Users/allodyaq/Seleksi-2025-Tugas-1/Data Scraping/data"
    full_path = os.path.join(base_path, filename)
    with open(full_path, 'r') as f:
        return json.load(f)

categories = load_json('categories.json')
products = load_json('products.json')
discount_products = load_json('discount_products.json')
normal_products = load_json('normal_products.json')
variants = load_json('variants.json')
measurements = load_json('measurements.json')

for cat in categories:
    cur.execute("""
        INSERT INTO categories (category_id, name)
        VALUES (%s, %s)
        ON CONFLICT DO NOTHING
    """, (cat['category_id'], cat['name']))

valid_product_ids = {p['product_id'] for p in products}

for prod in products:
    cur.execute("""
        INSERT INTO products (product_id, name, category_id, description, material, size, image_url, price)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
        ON CONFLICT DO NOTHING
    """, (
        prod['product_id'], prod['name'], prod['category_id'], prod['description'],
        prod['material'], prod['size'], prod['image_url'], prod['price']
    ))

for dp in discount_products:
    if dp['product_id'] in valid_product_ids:
        cur.execute("""
            INSERT INTO discount_products (product_id, normal_price)
            VALUES (%s, %s)
            ON CONFLICT DO NOTHING
        """, (dp['product_id'], dp['normal_price']))

for np in normal_products:
    if np['product_id'] in valid_product_ids:
        cur.execute("""
            INSERT INTO normal_products (product_id)
            VALUES (%s)
            ON CONFLICT DO NOTHING
        """, (np['product_id'],))

for v in variants:
    if v['product_id'] in valid_product_ids:
        cur.execute("""
            INSERT INTO variants (variant_id, product_id, variant_name, availability, color)
            VALUES (%s, %s, %s, %s, %s)
            ON CONFLICT DO NOTHING
        """, (
            v['variant_id'], v['product_id'], v['variant_name'], v['availability'], v['color']
        ))

for m in measurements:
    if m['product_id'] in valid_product_ids:
        cur.execute("""
            INSERT INTO measurements (product_id, size_name, details)
            VALUES (%s, %s, %s)
            ON CONFLICT DO NOTHING
        """, (
            m['product_id'], m['size_name'], json.dumps(m['details'])
        ))

conn.commit()
cur.close()
conn.close()

print("Scraping to storing completed.")
