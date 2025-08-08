import os
import json

INPUT_DIRECTORY = '../data/cpu_specs_output' 
OUTPUT_FILE_PATH = '../data/combined_processors_data.json'

# Menggabungkan file JSON
def combine_json_files(input_dir, output_file):
    # List kosong untuk menampung semua data dari semua file
    all_data = []
    
    # Cek apakah direktori input ada
    if not os.path.isdir(input_dir):
        print(f"Error: Direktori tidak ditemukan di '{input_dir}'")
        return

    print(f"Membaca file dari direktori: '{input_dir}'...")
    
    # Loop untuk setiap item di dalam direktori input
    for filename in os.listdir(input_dir):
        # Proses hanya jika file berakhiran .json
        if filename.endswith('.json'):
            file_path = os.path.join(input_dir, filename)
            print(f"  -> Memproses file: {filename}")
            
            try:
                with open(file_path, 'r', encoding='utf-8') as f:
                    # Baca konten file JSON
                    data_from_file = json.load(f)
                    
                    # Tambahkan konten ke daftar utama. 
                    # Gunakan extend() jika isi file adalah list, append() jika objek.
                    if isinstance(data_from_file, list):
                        all_data.extend(data_from_file)
                    else:
                        all_data.append(data_from_file)

            except json.JSONDecodeError:
                print(f"     Peringatan: File {filename} bukan JSON yang valid atau kosong. Dilewati.")
            except Exception as e:
                print(f"     Error saat membaca file {filename}: {e}")

    # Cek apakah ada data yang berhasil dikumpulkan
    if not all_data:
        print("Tidak ada data yang berhasil dikumpulkan. File output tidak dibuat.")
        return

    print(f"\nTotal {len(all_data)} data berhasil digabungkan.")
    
    # Menulis semua data yang terkumpul ke satu file output
    try:
        # Membuat direktori output jika belum ada
        output_dir = os.path.dirname(output_file)
        if not os.path.exists(output_dir):
            os.makedirs(output_dir)
            
        with open(output_file, 'w', encoding='utf-8') as f:
            json.dump(all_data, f, ensure_ascii=False, indent=4)
        
        print(f"✅ Berhasil! Semua data telah disimpan di: '{output_file}'")
        
    except Exception as e:
        print(f"Error saat menyimpan file output: {e}")


if __name__ == "__main__":
    combine_json_files(INPUT_DIRECTORY, OUTPUT_FILE_PATH)