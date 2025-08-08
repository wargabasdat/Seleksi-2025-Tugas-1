# %%
import json         # untuk memproses file JSON
import psycopg2     # untuk melakukan koneksi dan eksekusi query ke database PostgreSQL.

# %%
# === PARAMETER KONEKSI GLOBAL ===
CONN_PARAMS = {
    'dbname': 'ssbuspirits',
    'user': 'postgres',
    'password': 'evander',
    'host': 'localhost',
    'port': '5432'
}


# === FUNCTION UNTUK MENYIMPAN JSON KE POSTGRES ===
def store_json_to_postgres(json_filename, table_name, columns, conn_params):
    # Buka file JSON
    with open(json_filename, 'r', encoding='utf-8') as f:
        data = json.load(f)

    # Koneksi ke PostgreSQL
    conn = psycopg2.connect(**conn_params)
    cur = conn.cursor()

    # Bangun query INSERT
    placeholders = ', '.join(['%s'] * len(columns))
    column_names = ', '.join(columns)
    conflict_target = columns[0]  # kolom pertama adalah PRIMARY KEY

    query = f"""
        INSERT INTO {table_name} ({column_names})
        VALUES ({placeholders})
        ON CONFLICT ({conflict_target}) DO NOTHING;
    """

    # Eksekusi query untuk setiap data
    for row in data:
        values = tuple(row[col] for col in columns)
        cur.execute(query, values)

    conn.commit()
    cur.close()
    conn.close()

# %%
# series.json
store_json_to_postgres(
    json_filename='../../Data Scraping/data/series.json',
    table_name='series',
    columns=['series_id', 'name'],
    conn_params=CONN_PARAMS
)

# %%
# spirits.json
store_json_to_postgres(
    json_filename='../../Data Scraping/data/spirits.json',
    table_name='spirits',
    columns=['spirits_id', 'name', 'category', 'spirit_battle', 'series_id'],
    conn_params=CONN_PARAMS
)

# %%
# ability.json
store_json_to_postgres(
    json_filename='../../Data Scraping/data/ability.json',
    table_name='ability',
    columns=['ability_id', 'name'],
    conn_params=CONN_PARAMS
)

# %%
# equipable_spirits.json
store_json_to_postgres(
    json_filename='../../Data Scraping/data/equipable_spirits.json',
    table_name='equipable_spirits',
    columns=['spirits_id', 'class', 'ability_id'],
    conn_params=CONN_PARAMS
)

# %%
# primary_spirits.json
store_json_to_postgres(
    json_filename='../../Data Scraping/data/primary_spirits.json',
    table_name='primary_spirits',
    columns=['spirits_id', 'type', 'slot_capacity', 'min_power', 'max_power', 'min_attack', 'max_attack', 'min_defense', 'max_defense'],
    conn_params=CONN_PARAMS
)

# %%
# support_spirits.json
store_json_to_postgres(
    json_filename='../../Data Scraping/data/support_spirits.json',
    table_name='support_spirits',
    columns=['spirits_id', 'slot_cost'],
    conn_params=CONN_PARAMS
)

# %%
# obtaining_method.json
store_json_to_postgres(
    json_filename='../../Data Scraping/data/obtaining_method.json',
    table_name='obtaining_method',
    columns=['method_id', 'name'],
    conn_params=CONN_PARAMS
)

# %%
# spirits_obtain.json

# Menggunakan metode atau kode tersendiri karena memiliki 2 primary key (fungsi store_json_to_postgres hanya mendukung kolom pertama sebagai primary key)
with open('../../Data Scraping/data/spirits_obtain.json', 'r', encoding='utf-8') as f:
    data = json.load(f)
try:
    conn = psycopg2.connect(**CONN_PARAMS)
    cur = conn.cursor()

    for row in data:
        spirits_id = row['spirits_id']
        method_id = row['method_id']
        
        cur.execute("""
            INSERT INTO spirits_obtain (spirits_id, method_id)
            VALUES (%s, %s)
            ON CONFLICT DO NOTHING;
        """, (spirits_id, method_id))

    conn.commit()
    cur.close()
    conn.close()

except Exception as e:
    print("Terjadi error:", e)


