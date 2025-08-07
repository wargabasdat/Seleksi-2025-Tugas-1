import psycopg2
import ast

storing_conn = psycopg2.connect(
    dbname="duma_website", user="postgres", password=" ", host="localhost", port="5432"
)
dw_conn = psycopg2.connect(
    dbname="duma_dw", user="postgres", password=" ", host="localhost", port="5432"
)

storing_cur = storing_conn.cursor()
dw_cur = dw_conn.cursor()

print("Extracting...")

storing_cur.execute("SELECT * FROM categories")
categories = storing_cur.fetchall()

storing_cur.execute("""
    SELECT p.*, 
           CASE 
               WHEN dp.product_id IS NOT NULL THEN TRUE
               ELSE FALSE
           END AS is_discount
    FROM products p
    LEFT JOIN discount_products dp ON p.product_id = dp.product_id
""")
products = storing_cur.fetchall()

storing_cur.execute("SELECT * FROM variants")
variants = storing_cur.fetchall()

storing_cur.execute("SELECT * FROM measurements")
measurements = storing_cur.fetchall()

print("Extract complete.")

print("Loading to dim_category...")
for row in categories:
    dw_cur.execute(
        "INSERT INTO dim_category (category_id, name) VALUES (%s, %s) ON CONFLICT DO NOTHING", 
        row
    )

print("Loading to dim_products...")
for row in products:
    try:
        is_discount = True if str(row[6]).lower() in ["true", "1", "yes"] else False
        dw_cur.execute("""
            INSERT INTO dim_products (product_id, name, description, material, size, image_url, is_discount)
            VALUES (%s, %s, %s, %s, %s, %s, %s)
            ON CONFLICT DO NOTHING
        """, (
            row[0], row[1], row[2], row[3], row[4], row[6], is_discount  # ← row[6] adalah image_url, bukan row[5]
        ))
    except Exception as e:
        print(f"ERROR on row: {row[0]} → {e}")

print("Loading to dim_variants...")
for row in variants:
    dw_cur.execute("""
        INSERT INTO dim_variants (variant_id, variant_name, availability, color)
        VALUES (%s, %s, %s, %s)
        ON CONFLICT DO NOTHING
    """, (
        row[0], row[1], row[2], row[3]
    ))

print("Loading to dim_measurements...")
valid_measurements = set()
for row in measurements:
    try:
        measurement_id = row[0]
        size_name = row[2] 
        detail_str = row[3] 
        dw_cur.execute("""
            INSERT INTO dim_measurements (measurement_id, size_name, detail)
            VALUES (%s, %s, %s)
            ON CONFLICT DO NOTHING
        """, (measurement_id, size_name, detail_str))
        valid_measurements.add(measurement_id)
    except Exception as e:
        print(f"Skipped row due to error: {e} | row: {row}")

print("Loading to fact_catalog...")
storing_cur.execute("""
    SELECT 
        p.product_id, 
        p.category_id, 
        v.variant_id, 
        m.measurement_id, 
        p.price
    FROM products p
    JOIN variants v ON p.product_id = v.product_id
    JOIN measurements m ON p.product_id = m.product_id
""")
fact_rows = storing_cur.fetchall()

for row in fact_rows:
    if row[3] in valid_measurements:
        dw_cur.execute("""
            INSERT INTO fact_catalog (product_id, category_id, variant_id, measurement_id, price)
            VALUES (%s, %s, %s, %s, %s)
            ON CONFLICT DO NOTHING
        """, row)

dw_conn.commit()
print("All data loaded successfully!")

storing_cur.close()
dw_cur.close()
storing_conn.close()
dw_conn.close()
