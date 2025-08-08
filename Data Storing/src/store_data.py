# File: Data Storing/src/store_data.py

import logging
import os
from typing import Dict, List

import pandas as pd
import psycopg2
from dotenv import load_dotenv
from psycopg2.extras import execute_values

# ===================================================================
# KONFIGURASI DAN KETETAPAN (CONSTANTS)
# ===================================================================

# Muat environment variables dari file .env (opsional tapi sangat disarankan)
# Buat file bernama .env di root proyek Anda dan isi dengan format:
# DB_USER=postgres
# DB_PASSWORD=123
load_dotenv()

# Konfigurasi Logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

# Konfigurasi Database (mengambil dari environment variables)
DB_CONFIG = {
    "dbname": os.getenv("DB_NAME", "blox_fruits_db"),
    "user": os.getenv("DB_USER", "postgres"),
    "password": os.getenv("DB_PASSWORD", "123"),
    "host": os.getenv("DB_HOST", "localhost"),
    "port": os.getenv("DB_PORT", "5432"),
}

# Lokasi Path
SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
DATA_DIR = os.path.join(SCRIPT_DIR, '..', '..', 'Data Scraping', 'src', 'data')
JSON_FILES = {
    "fruits": "fruits.json",
    "swords": "swords.json",
    "guns": "guns.json",
    "values": "fruit_values.json",
    "updates": "update_logs.json",
    "stock": "fruit_stock.json"
}

# ===================================================================
# FUNGSI UTILITAS DATABASE
# ===================================================================

def get_db_connection():
    """Membuat dan mengembalikan koneksi ke database PostgreSQL."""
    try:
        conn = psycopg2.connect(**DB_CONFIG)
        logging.info("✅ Berhasil terhubung ke database PostgreSQL.")
        return conn
    except psycopg2.OperationalError as e:
        logging.error(f"❌ Gagal terhubung ke database: {e}")
        logging.error("Pastikan PostgreSQL server berjalan dan detail koneksi di .env sudah benar.")
        return None

def bulk_insert(conn, df: pd.DataFrame, table_name: str, pkey_cols: List[str] | None = None):
    """
    Melakukan INSERT data dari DataFrame ke tabel PostgreSQL secara massal.
    Jika pkey_cols diberikan, gunakan ON CONFLICT DO NOTHING.
    Jika tidak, lakukan INSERT biasa.

    :param conn: Koneksi database psycopg2.
    :param df: DataFrame yang akan di-load.
    :param table_name: Nama tabel tujuan.
    :param pkey_cols: Opsional, daftar kolom primary key untuk ON CONFLICT.
    """
    if df.empty:
        logging.info(f"DataFrame untuk tabel '{table_name}' kosong, proses insert dilewati.")
        return

    cols = ','.join(df.columns)
    
    # Pilih jenis SQL berdasarkan adanya pkey_cols
    if pkey_cols:
        pkey = ','.join(pkey_cols)
        sql = f"INSERT INTO {table_name} ({cols}) VALUES %s ON CONFLICT ({pkey}) DO NOTHING"
    else:
        # INSERT biasa tanpa pengecekan konflik
        sql = f"INSERT INTO {table_name} ({cols}) VALUES %s"
    
    with conn.cursor() as cur:
        execute_values(cur, sql, list(df.itertuples(index=False, name=None)))
    logging.info(f"✅ Memuat {len(df)} baris ke tabel '{table_name}'.")
# ===================================================================
# FUNGSI TRANSFORMASI DATA
# ===================================================================

def load_all_dataframes(data_dir: str, files: Dict[str, str]) -> Dict[str, pd.DataFrame]:
    """Membaca semua file JSON dari direktori dan mengembalikannya sebagai dictionary of DataFrames."""
    dataframes = {}
    for name, filename in files.items():
        path = os.path.join(data_dir, filename)
        dataframes[name] = pd.read_json(path)
    logging.info("✅ Berhasil membaca semua file JSON ke DataFrames.")
    return dataframes

def transform_updates(df: pd.DataFrame) -> pd.DataFrame:
    """Mentransformasi data untuk tabel 'update'."""
    return df[['update_id', 'update_title', 'release_date', 'timestamp']]

def transform_fruits_with_values(df_fruits: pd.DataFrame, df_values: pd.DataFrame) -> pd.DataFrame:
    """Menggabungkan data buah dengan data nilainya dan membersihkan kolom numerik."""
    # Pemetaan untuk nama buah yang tidak konsisten
    fruit_name_map = {'chop': 'blade'}
    
    # Buat kunci join yang bersih
    df_fruits['join_key'] = df_fruits['fruit_name'].str.lower().str.strip()
    df_values['join_key'] = df_values['fruit_name'].str.lower().str.replace(' fruit', '', regex=False).str.strip()
    df_values['join_key'] = df_values['join_key'].replace(fruit_name_map)
    
    # Gabungkan DataFrame
    df_merged = pd.merge(
        df_fruits,
        df_values.drop(columns=['fruit_name']),
        on='join_key',
        how='left'
    ).drop(columns=['join_key'])
    
    # Bersihkan kolom numerik
    int_columns = ['money_price', 'robux_price', 'value', 'demand']
    for col in int_columns:
        if col in df_merged.columns:
            series = df_merged[col].astype(str)
            if col == 'demand':
                series = series.str.split('/').str.get(0) # Ambil angka sebelum '/'
            
            series = series.str.replace(',', '', regex=False)
            df_merged[col] = pd.to_numeric(series, errors='coerce').astype('Int64')

    return df_merged

def transform_equipment(df_fruits: pd.DataFrame, df_swords: pd.DataFrame, df_guns: pd.DataFrame) -> pd.DataFrame:
    """Menggabungkan semua item (fruits, swords, guns) ke dalam satu DataFrame untuk tabel 'equipment'."""
    df_fruits_eq = df_fruits.rename(columns={'uid': 'equipment_id', 'fruit_name': 'name'})
    df_swords_eq = df_swords.rename(columns={'uid': 'equipment_id', 'sword_name': 'name'})
    df_guns_eq = df_guns.rename(columns={'uid': 'equipment_id', 'gun_name': 'name'})
    
    common_cols = ['equipment_id', 'name', 'url', 'timestamp', 'type', 'rarity', 'release_date']
    
    df_equipment = pd.concat([
        df_fruits_eq[common_cols],
        df_swords_eq[common_cols],
        df_guns_eq[common_cols]
    ], ignore_index=True)
    
    return df_equipment

def transform_specialized_items(df: pd.DataFrame, new_cols: Dict[str, str], final_cols: List[str]) -> pd.DataFrame:
    """Transformasi untuk tabel spesialis (fruit, sword, gun)."""
    return df.rename(columns=new_cols)[final_cols]

def transform_abilities(df_all_items: pd.DataFrame) -> pd.DataFrame:
    """Mengekstrak semua ability dari semua item dan membersihkan kolom numerik."""
    df_exploded = df_all_items.explode('abilities').dropna(subset=['abilities'])
    abilities_df = pd.json_normalize(df_exploded['abilities'])
    result = pd.concat([df_exploded[['uid']].reset_index(drop=True), abilities_df], axis=1)
    result.rename(columns={'uid': 'equipment_id'}, inplace=True)
    
    # === MULAI PERBAIKAN PENTING ===
    # Proses pembersihan untuk kolom biaya, yang mungkin bernilai besar (di atas 2 Milyar)
    for col in ['mastery_cost', 'fragment_cost']:
        if col in result.columns:
            # Ubah ke string untuk menghapus koma, lalu ubah ke numerik
            series = result[col].astype(str).str.replace(',', '', regex=False)
            # Gunakan Int64 untuk menampung angka besar (BIGINT) dan nilai kosong (NA)
            result[col] = pd.to_numeric(series, errors='coerce').astype('Int64')
        else:
            # Jika kolom tidak ada, buat sebagai kolom kosong bertipe Int64
            result[col] = pd.Series([pd.NA] * len(result), dtype='Int64')
            
    # Pastikan kolom non-numerik lainnya juga ada
    for col in ['ability_name', 'keybind']:
        if col not in result.columns:
            result[col] = None
    return result[['equipment_id', 'ability_name', 'keybind', 'mastery_cost', 'fragment_cost']]

def transform_update_items(df_all_items: pd.DataFrame) -> pd.DataFrame:
    """Mengekstrak riwayat perubahan dari semua item."""
    df_exploded = df_all_items.explode('change_history').dropna(subset=['change_history'])
    history_df = pd.json_normalize(df_exploded['change_history'])
    result = pd.concat([df_exploded[['uid']].reset_index(drop=True), history_df], axis=1)
    
    # Ekstrak update_id
    result['update_id'] = result['version'].str.split(':').str[0].str.split('-').str[0].str.strip()
    result['update_id'] = result['update_id'].replace({'Update 17': 'Update 17.1'})
    
    return result[['update_id', 'uid', 'change']].rename(columns={'uid': 'equipment_id'})
    
def transform_stock(df_stock: pd.DataFrame, df_fruits: pd.DataFrame) -> (pd.DataFrame, pd.DataFrame):
    """Memisahkan data stock menjadi stock_event dan stock_item."""
    df_stock_events = df_stock[df_stock['fruit_name'].isna()].copy()
    df_stock_events.rename(columns={'stock_event_uid': 'stock_event_id'}, inplace=True)
    
    df_stock_items = df_stock.dropna(subset=['fruit_name']).copy()
    
    fruit_name_to_uid = df_fruits.set_index('fruit_name')['uid'].to_dict()
    df_stock_items['fruit_id'] = df_stock_items['fruit_name'].map(fruit_name_to_uid)
    
    df_stock_items.dropna(subset=['fruit_id'], inplace=True)
    
    return (
        df_stock_events[['stock_event_id', 'timestamp', 'stock_start_time']],
        df_stock_items[['stock_event_uid', 'fruit_id']].rename(columns={'stock_event_uid': 'stock_event_id'})
    )

# ===================================================================
# FUNGSI UTAMA (MAIN ORCHESTRATOR)
# ===================================================================

def run_pipeline():
    """
    Fungsi utama untuk menjalankan seluruh pipeline ETL:
    1. Ekstrak: Membaca data dari file JSON.
    2. Transform: Membersihkan, menggabungkan, dan menstrukturkan data.
    3. Load: Memuat data yang sudah bersih ke database PostgreSQL.
    """
    conn = get_db_connection()
    if not conn:
        return

    try:
        # 1. EKSTRAK: Muat semua data dari JSON
        dfs = load_all_dataframes(DATA_DIR, JSON_FILES)
        
        # 2. TRANSFORM: Proses setiap bagian data
        logging.info("Memulai proses transformasi data...")
        
        # Gabungkan fruits dengan values terlebih dahulu
        df_fruits_full = transform_fruits_with_values(dfs['fruits'], dfs['values'])
        
        df_equipment = transform_equipment(df_fruits_full, dfs['swords'], dfs['guns'])
        
        df_upd = transform_updates(dfs['updates'])
        
        df_fruit_table = transform_specialized_items(
            df_fruits_full, 
            {'uid': 'equipment_id', 'type': 'fruit_type', 'value': 'fruit_value', 'demand': 'fruit_demand', 'status': 'fruit_status'},
            ['equipment_id', 'fruit_type', 'money_price', 'robux_price', 'can_m1', 'fruit_value', 'fruit_demand', 'fruit_status']
        )
        df_sword_table = transform_specialized_items(dfs['swords'], {'uid': 'equipment_id'}, ['equipment_id'])
        df_gun_table = transform_specialized_items(dfs['guns'], {'uid': 'equipment_id'}, ['equipment_id'])
        
        df_all_items = pd.concat([df_fruits_full, dfs['swords'], dfs['guns']], ignore_index=True)
        df_abilities = transform_abilities(df_all_items)
        df_update_items = transform_update_items(df_all_items)
        
        df_stock_events, df_stock_items = transform_stock(dfs['stock'], df_fruits_full)

        logging.info("✅ Transformasi data selesai.")

        # 3. LOAD: Muat data ke database
        logging.info("Memulai proses memuat data ke database...")
        
        # Ganti pd.NA dengan None agar kompatibel dengan psycopg2
        df_fruit_table = df_fruit_table.astype('object').where(pd.notna(df_fruit_table), None)
        df_abilities = df_abilities.astype('object').where(pd.notna(df_abilities), None)

        bulk_insert(conn, df_upd, 'update', ['update_id'])
        bulk_insert(conn, df_equipment, 'equipment', ['equipment_id'])
        
        bulk_insert(conn, df_fruit_table, 'fruit', ['equipment_id'])
        bulk_insert(conn, df_sword_table, 'sword', ['equipment_id'])
        bulk_insert(conn, df_gun_table, 'gun', ['equipment_id'])
        
        with conn.cursor() as cur:
          cur.execute("TRUNCATE TABLE ability RESTART IDENTITY;")
        # Hapus argumen pkey_cols untuk melakukan INSERT biasa
        bulk_insert(conn, df_abilities, 'ability')

        with conn.cursor() as cur:
            cur.execute("TRUNCATE TABLE update_item RESTART IDENTITY;")
        # Hapus argumen pkey_cols untuk melakukan INSERT biasa
        bulk_insert(conn, df_update_items, 'update_item')
        bulk_insert(conn, df_stock_events, 'stock_event', ['stock_event_id'])
        bulk_insert(conn, df_stock_items, 'stock_item', ['stock_event_id', 'fruit_id'])

        conn.commit()
        logging.info("🎉 Semua data berhasil dimuat dan di-commit ke database.")

    except (Exception, psycopg2.Error) as error:
        logging.error(f"❌ Terjadi error pada pipeline: {error}")
        conn.rollback()
        logging.info("Perubahan di-rollback karena terjadi error.")
    finally:
        if conn:
            conn.close()
            logging.info("Koneksi ke database ditutup.")


if __name__ == '__main__':
    run_pipeline()