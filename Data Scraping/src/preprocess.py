import json
import re
from datetime import datetime

INPUT_FILE = '../data/combined_processors_data.json' 
OUTPUT_FILE = '../data/preprocessed_processors_data.json'

# Mengubah format tanggal
def transform_date(date_string):
    if not date_string:
        return None
    try:
        # Menghapus sufiks ordinal (st, nd, rd, th) dari tanggal
        cleaned_string = re.sub(r'(st|nd|rd|th)', '', date_string)
        # Mengubah string menjadi objek datetime, lalu memformatnya kembali
        date_object = datetime.strptime(cleaned_string, '%b %d, %Y')
        return date_object.strftime('%Y-%m-%d')
    except (ValueError, TypeError):
        # Mengembalikan None jika format tanggal tidak sesuai atau datanya hilang
        return None

# Mengubah 'Yes' dan 'No' menjadi boolean
def transform_boolean(text):
    if text and isinstance(text, str) and text.lower().strip() == 'yes':
        return True
    return False

# Membersihkan integrated graphics
def standardize_graphics(graphics_text):
    if not graphics_text or graphics_text.lower() == 'n/a':
        return None
    # Daftar kata kunci yang menandakan grafis tidak spesifik
    generic_keywords = ['chipset', 'certain motherboards']
    
    # Jika ada kata kunci generik di dalamnya, kembalikan None
    if any(keyword in graphics_text.lower() for keyword in generic_keywords):
        return None
    
    # Jika tidak, kembalikan teks aslinya
    return graphics_text

# Fungsi utama
def preprocess_data(input_path, output_path):
    try:
        with open(input_path, 'r', encoding='utf-8') as f:
            all_data = json.load(f)
        print(f"Berhasil memuat {len(all_data)} data dari '{input_path}'")
    except FileNotFoundError:
        print(f"Error: File input tidak ditemukan di '{input_path}'")
        print("Pastikan nama file dan path-nya sudah benar.")
        return
    
    preprocessed_list = []
    
    # Looping untuk setiap data CPU dan terapkan fungsi preprocessing
    for cpu_data in all_data:
        processed_cpu = cpu_data.copy() # Salin data agar tidak mengubah data asli
        
        # Terapkan setiap fungsi transformasi
        processed_cpu['release_date'] = transform_date(cpu_data.get('release_date'))
        processed_cpu['multiplier_unlocked'] = transform_boolean(cpu_data.get('multiplier_unlocked'))
        processed_cpu['integrated_graphics'] = standardize_graphics(cpu_data.get('integrated_graphics'))
        
        preprocessed_list.append(processed_cpu)
        
    # Simpan data yang sudah diproses ke file baru
    try:
        with open(output_path, 'w', encoding='utf-8') as f:
            json.dump(preprocessed_list, f, ensure_ascii=False, indent=4)
        print(f"✅ Preprocessing selesai. Data bersih disimpan di '{output_path}'")
    except Exception as e:
        print(f"Error saat menyimpan file output: {e}")


if __name__ == "__main__":
    preprocess_data(INPUT_FILE, OUTPUT_FILE)