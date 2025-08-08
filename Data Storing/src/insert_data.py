import json
import re
import os
import sys
import random

# Adapter PostgreSQL
try:
    import psycopg2
    from psycopg2.extras import RealDictCursor
    POSTGRES_AVAILABLE = True
except ImportError:
    print("Install adapter PostgreSQL: pip install psycopg2-binary")
    POSTGRES_AVAILABLE = False

class SimpleDatabaseInsertion:
    def __init__(self, data_dir: str, db_config: dict):
        """Initialize dengan config database dan directory data JSON"""
        self.data_dir = data_dir
        self.db_config = db_config
        self.connection = None
        self.cursor = None
        random.seed(42)  
        self.used_ids = set()

    def generate_unique_5digit_id(self):
        """Generate ID acak 5 digit yang unik"""
        while True:
            random_id = random.randint(10000, 99999)
            if random_id not in self.used_ids:
                self.used_ids.add(random_id)
                return random_id

    def connect_database(self):
        """Terhubung ke database PostgreSQL"""
        try:
            self.connection = psycopg2.connect(
                host=self.db_config['host'],
                database=self.db_config['database'],
                user=self.db_config['user'],
                password=self.db_config['password'],
                port=self.db_config.get('port', 5432)
            )
            self.cursor = self.connection.cursor(cursor_factory=RealDictCursor)
            print("Terhubung ke database PostgreSQL")
        except Exception as e:
            print(f"Koneksi database gagal: {e}")
            raise

    def disconnect_database(self):
        """Tutup koneksi database"""
        if self.cursor:
            self.cursor.close()
        if self.connection:
            self.connection.close()
        print("Koneksi database ditutup")
    
    # Pembersihan data dan transformasi
    def clean_value(self, value, data_type="text"):
        if value is None:
            return None
        
        str_value = str(value).strip()
        
        # Periksa jika string kosong atau nilai yang menandakan NULL
        if not str_value or str_value.lower() in ['null', 'none', 'n/a', 'nan', '-', '–', '—', '']:
            return None
        
        # Untuk data type text, periksa dan hapus nilai yang tidak valid atau sampah data
        if data_type == "text":
            invalid_patterns = [
                r'x\d+see\s*photo',  # Pattern untuk "x4See photo", "x2See photo", dll
                r'see\s*photo',      # Pattern untuk "See photo"
                r'see\s*image',      # Pattern untuk "See image"
                # Hapus pattern r'x\d+' karena mengganggu resolution seperti "2880x1800"
            ]
            
            for pattern in invalid_patterns:
                if re.search(pattern, str_value.lower()):
                    return None
            
        if data_type == "integer":
            cleaned = re.sub(r'[^\d.-]', '', str_value)
            try:
                return int(float(cleaned)) if cleaned else None
            except:
                return None
        elif data_type == "float":
            cleaned = re.sub(r'[^\d.-]', '', str_value)
            try:
                return float(cleaned) if cleaned else None
            except:
                return None
        elif data_type == "price":
            cleaned = re.sub(r'[\$,]', '', str_value)
            try:
                return round(float(cleaned), 2) if cleaned else None
            except:
                return None
        else:
            return str_value if str_value and str_value.strip() else None

    def load_and_insert_json(self, filename, table_name, insert_sql, transform_func):
        """Memuat file JSON dan insert ke database dengan transformasi"""
        file_path = os.path.join(self.data_dir, filename)
        
        if not os.path.exists(file_path):
            print(f"File tidak ditemukan: {filename}")
            return
            
        with open(file_path, 'r', encoding='utf-8') as f:
            raw_data = json.load(f)
        
        print(f"Processing {filename} -> {table_name}")
        
        try:
            count = 0
            for item in raw_data:
                # Transformasi data 
                cleaned_data = transform_func(item, count)
                if cleaned_data:  
                    self.cursor.execute(insert_sql, cleaned_data)
                    count += 1
            
            self.connection.commit()
            print(f"   Berhasil insert {count} record ke {table_name}")
            
        except Exception as e:
            print(f"   Error saat insert {table_name}: {e}")
            self.connection.rollback()
            raise

    def preprocess_and_match_data(self):
        """Preprocessing data untuk generate ID unik dan mencocokkan relasi"""
        print("Preprocessing dan generating ID unik untuk semua tabel...")
        
        # Muat semua file JSON 
        json_files = {}
        file_list = [
            'Laptop.json', 'Laptop_Score.json', 'CPU.json', 'GPU.json', 'CPU_Performance.json', 
            'GPU_Performance.json', 'Laptop_Configuration.json',
            'Features.json', 'Ports_Connectivity.json', 'Laptop_Detailed_Spec.json',
            'Laptop_Image.json'
        ]
        
        for filename in file_list:
            file_path = os.path.join(self.data_dir, filename)
            if os.path.exists(file_path):
                with open(file_path, 'r', encoding='utf-8') as f:
                    json_files[filename] = json.load(f)
                print(f"   Memuat {filename}: {len(json_files[filename])} record")
            else:
                json_files[filename] = []
                print(f"   Tidak ditemukan {filename}, menggunakan data kosong")
        
        # Generate ID unik 
        print("Generating ID unik 5 digit untuk semua tabel...")
        
        # 1. Generate laptop_id
        laptop_id_mapping = {}  
        laptop_name_to_id = {}  
        for laptop in json_files['Laptop.json']:
            unique_id = self.generate_unique_5digit_id()
            rank = laptop.get('rank', len(laptop_id_mapping) + 1)
            name = laptop.get('name', '').strip()
            
            laptop_id_mapping[rank] = unique_id
            if name:
                laptop_name_to_id[name] = unique_id
        
        # 2. Generate cpu_perf_id
        cpu_perf_id_mapping = {}  
        cpu_perf_name_to_id = {}  
        for idx, cpu_perf in enumerate(json_files['CPU_Performance.json']):
            unique_id = self.generate_unique_5digit_id()
            cpu_name = cpu_perf.get('cpu_name', '').strip()
            
            cpu_perf_id_mapping[idx] = unique_id
            if cpu_name:
                cpu_perf_name_to_id[cpu_name] = unique_id
        
        # 3. Generate gpu_perf_id
        gpu_perf_id_mapping = {}  
        gpu_perf_name_to_id = {}  
        for idx, gpu_perf in enumerate(json_files['GPU_Performance.json']):
            unique_id = self.generate_unique_5digit_id()
            gpu_name = gpu_perf.get('gpu_name', '').strip()
            
            gpu_perf_id_mapping[idx] = unique_id
            if gpu_name:
                gpu_perf_name_to_id[gpu_name] = unique_id
        
        # 4. Generate cpu_id dan pencocokan
        print("Mencocokkan data CPU dengan ID unik...")
        matched_cpu = []
        cpu_id_mapping = {}  
        for idx, cpu_item in enumerate(json_files['CPU.json']):
            unique_id = self.generate_unique_5digit_id()
            cpu_id_mapping[idx] = unique_id
            
            cpu_name = cpu_item.get('cpu', '').strip()
            laptop_rank = cpu_item.get('laptop_rank')
            laptop_name = cpu_item.get('laptop_name', '').strip()
            
            laptop_id = None
            if laptop_rank and laptop_rank in laptop_id_mapping:
                laptop_id = laptop_id_mapping[laptop_rank]
            elif laptop_name and laptop_name in laptop_name_to_id:
                laptop_id = laptop_name_to_id[laptop_name]
            else:
                fallback_rank = (idx % len(laptop_id_mapping)) + 1
                laptop_id = laptop_id_mapping.get(fallback_rank)
            
            cpu_perf_id = None
            if cpu_name:
                for perf_name, perf_id in cpu_perf_name_to_id.items():
                    if (cpu_name.lower() in perf_name.lower() or 
                        perf_name.lower() in cpu_name.lower()):
                        cpu_perf_id = perf_id
                        break
            
            matched_cpu.append({
                'cpu_id': unique_id,
                'cpu_name': cpu_name,
                'laptop_id': laptop_id,
                'cpu_perf_id': cpu_perf_id,
                'original_data': cpu_item
            })
        
        # 5. Generate gpu_id dan pencocokan
        print("Mencocokkan data GPU dengan ID unik...")
        matched_gpu = []
        gpu_id_mapping = {}  
        for idx, gpu_item in enumerate(json_files['GPU.json']):
            unique_id = self.generate_unique_5digit_id()
            gpu_id_mapping[idx] = unique_id
            
            gpu_name = gpu_item.get('gpu', '').strip()
            laptop_rank = gpu_item.get('laptop_rank')
            laptop_name = gpu_item.get('laptop_name', '').strip()
            
            laptop_id = None
            if laptop_rank and laptop_rank in laptop_id_mapping:
                laptop_id = laptop_id_mapping[laptop_rank]
            elif laptop_name and laptop_name in laptop_name_to_id:
                laptop_id = laptop_name_to_id[laptop_name]
            else:
                fallback_rank = (idx % len(laptop_id_mapping)) + 1
                laptop_id = laptop_id_mapping.get(fallback_rank)
            
            gpu_perf_id = None
            if gpu_name:
                for perf_name, perf_id in gpu_perf_name_to_id.items():
                    if (gpu_name.lower() in perf_name.lower() or 
                        perf_name.lower() in gpu_name.lower()):
                        gpu_perf_id = perf_id
                        break
            
            matched_gpu.append({
                'gpu_id': unique_id,
                'gpu_name': gpu_name,
                'laptop_id': laptop_id,
                'gpu_perf_id': gpu_perf_id,
                'original_data': gpu_item
            })
        
        # 6. Generate config_id dan pencocokan
        print("Mencocokkan data Konfigurasi dengan ID unik...")
        matched_config = []
        for config_item in json_files['Laptop_Configuration.json']:
            unique_id = self.generate_unique_5digit_id()
            config_name = config_item.get('config_name', '').strip()
            laptop_name_from_config = config_item.get('laptop_name', '').strip()
            laptop_rank = config_item.get('laptop_rank')
            config_ranking = config_item.get('configuration_ranking')
            config_cpu_name = config_item.get('cpu', '').strip()
            config_gpu_name = config_item.get('gpu', '').strip()
            
            laptop_id = None
            if laptop_name_from_config:
                for laptop_name, lid in laptop_name_to_id.items():
                    if (laptop_name_from_config.lower() == laptop_name.lower() or
                        laptop_name_from_config.lower() in laptop_name.lower() or 
                        laptop_name.lower() in laptop_name_from_config.lower()):
                        laptop_id = lid
                        break
            elif laptop_rank and laptop_rank in laptop_id_mapping:
                laptop_id = laptop_id_mapping[laptop_rank]

            if not laptop_id and config_ranking:
                try:
                    ranking_int = int(config_ranking)
                    fallback_rank = ((ranking_int - 1) % len(laptop_id_mapping)) + 1
                    laptop_id = laptop_id_mapping.get(fallback_rank)
                except (ValueError, TypeError):
                    fallback_rank = (len(matched_config) % len(laptop_id_mapping)) + 1
                    laptop_id = laptop_id_mapping.get(fallback_rank)
            
            # Cari CPU yang cocok
            cpu_id = None
            if config_cpu_name:
                for cpu_match in matched_cpu:
                    cpu_name = cpu_match['cpu_name']
                    if cpu_name and config_cpu_name:
                        if (config_cpu_name.lower() == cpu_name.lower() or
                            config_cpu_name.lower() in cpu_name.lower() or 
                            cpu_name.lower() in config_cpu_name.lower()):
                            cpu_id = cpu_match['cpu_id']
                            break
            
            # Cari GPU yang cocok 
            gpu_id = None
            if config_gpu_name:
                for gpu_match in matched_gpu:
                    gpu_name = gpu_match['gpu_name']
                    if gpu_name and config_gpu_name:
                        if (config_gpu_name.lower() == gpu_name.lower() or
                            config_gpu_name.lower() in gpu_name.lower() or 
                            gpu_name.lower() in config_gpu_name.lower()):
                            gpu_id = gpu_match['gpu_id']
                            break
            
            matched_config.append({
                'config_id': unique_id,
                'laptop_id': laptop_id,
                'cpu_id': cpu_id,
                'gpu_id': gpu_id,
                'original_data': config_item
            })
        
        # Simpan semua mapping dan data yang telah dicocokkan
        self.id_mappings = {
            'laptop': laptop_id_mapping,
            'cpu_perf': cpu_perf_id_mapping,
            'gpu_perf': gpu_perf_id_mapping,
            'cpu': cpu_id_mapping,
            'gpu': gpu_id_mapping
        }
        
        # Generate detail_id, feature_id, port_id, dan score_id
        features_id_mapping = {}
        ports_id_mapping = {}
        details_id_mapping = {}
        score_id_mapping = {}
        
        for i in range(len(json_files['Features.json'])):
            features_id_mapping[i] = self.generate_unique_5digit_id()
            
        for i in range(len(json_files['Ports_Connectivity.json'])):
            ports_id_mapping[i] = self.generate_unique_5digit_id()
            
        for i in range(len(json_files['Laptop_Detailed_Spec.json'])):
            details_id_mapping[i] = self.generate_unique_5digit_id()
            
        for i in range(len(json_files['Laptop_Score.json'])):
            score_id_mapping[i] = self.generate_unique_5digit_id()
        
        self.id_mappings.update({
            'features': features_id_mapping,
            'ports': ports_id_mapping,
            'details': details_id_mapping,
            'score': score_id_mapping
        })
        
        self.matched_data = {
            'cpu': matched_cpu,
            'gpu': matched_gpu,
            'config': matched_config,
            'raw_files': json_files
        }
        
        print(f"Proses generate ID dan pencocokan selesai!")
        print(f"- Generate {len(laptop_id_mapping)} ID Laptop unik")
        print(f"- Generate {len(cpu_perf_id_mapping)} ID Performa CPU unik")
        print(f"- Generate {len(gpu_perf_id_mapping)} ID Performa GPU unik")
        print(f"- Generate {len(features_id_mapping)} ID Fitur unik")
        print(f"- Generate {len(ports_id_mapping)} ID Port unik")
        print(f"- Generate {len(details_id_mapping)} ID Spesifikasi Detail unik")
        print(f"- Generate {len(score_id_mapping)} ID Score unik")
        print(f"- Mencocokkan {len(matched_cpu)} record CPU dengan ID unik")
        print(f"- Mencocokkan {len(matched_gpu)} record GPU dengan ID unik")
        print(f"- Mencocokkan {len(matched_config)} record Konfigurasi dengan ID unik")
        
        print("\n Ringkasan Pencocokan Konfigurasi:")
        matched_laptops = sum(1 for config in matched_config if config['laptop_id'])
        matched_cpus = sum(1 for config in matched_config if config['cpu_id'])
        matched_gpus = sum(1 for config in matched_config if config['gpu_id'])
        print(f"- Konfigurasi dengan Laptop yang cocok: {matched_laptops}/{len(matched_config)}")
        print(f"- Konfigurasi dengan CPU yang cocok: {matched_cpus}/{len(matched_config)}")
        print(f"- Konfigurasi dengan GPU yang cocok: {matched_gpus}/{len(matched_config)}")
        return True

    def insert_all_data(self):
        """Insert semua data dengan urutan yang benar menggunakan data yang sudah dicocokkan"""
        print("Memulai proses insert data dengan relasi yang sudah dicocokkan...")
        
        # 1. Features
        print("Memproses data Features dengan ID unik -> Features")
        try:
            count = 0
            for idx, unique_id in self.id_mappings['features'].items():
                if idx < len(self.matched_data['raw_files']['Features.json']):
                    item = self.matched_data['raw_files']['Features.json'][idx]
                    
                    cleaned_data = {
                        'fingerprint_reader': self.clean_value(item.get('fingerprint_reader')),
                        'web_camera': self.clean_value(item.get('web_camera')),
                        'backlit_keyboard': self.clean_value(item.get('backlit_keyboard')),
                        'microphone': self.clean_value(item.get('microphone')),
                        'speakers': self.clean_value(item.get('speakers')),
                        'security_lock_slot': self.clean_value(item.get('security_lock_slot'))
                    }
                    
                    self.cursor.execute("""
                        INSERT INTO Features (feature_id, fingerprint_reader, web_camera, backlit_keyboard, 
                                           microphone, speakers, security_lock_slot)
                        VALUES (%(feature_id)s, %(fingerprint_reader)s, %(web_camera)s, %(backlit_keyboard)s,
                               %(microphone)s, %(speakers)s, %(security_lock_slot)s)
                    """, {**cleaned_data, 'feature_id': unique_id})
                    count += 1
            
            self.connection.commit()
            print(f"   Berhasil insert {count} record ke Features")
            
        except Exception as e:
            print(f"   Error saat insert Features: {e}")
            self.connection.rollback()
            raise

        # 2. Ports_Connectivity 
        print("Memproses data Ports_Connectivity dengan ID unik -> Ports_Connectivity")
        try:
            count = 0
            for idx, unique_id in self.id_mappings['ports'].items():
                if idx < len(self.matched_data['raw_files']['Ports_Connectivity.json']):
                    item = self.matched_data['raw_files']['Ports_Connectivity.json'][idx]
                    
                    # Handle bluetooth dengan lebih robust
                    bluetooth_val = item.get('bluetooth', '')
                    bluetooth_clean = None
                    
                    if bluetooth_val:
                        # Filter keluar nilai yang bukan bluetooth (seperti 'Wi-Fi 6E')
                        if 'wi-fi' not in str(bluetooth_val).lower() and 'wifi' not in str(bluetooth_val).lower():
                            bluetooth_num = re.search(r'[\d.]+', str(bluetooth_val))
                            if bluetooth_num:
                                try:
                                    bluetooth_clean = float(bluetooth_num.group())
                                except:
                                    bluetooth_clean = None
                            else:
                                # Jika tidak ada angka sama sekali, set None
                                bluetooth_clean = None
                    
                    # Ambil USB Type-A yang pertama tersedia
                    usb_type_a_value = None
                    for usb_a_key in ['usb_type_a', 'usb_type-a', '3x_usb_type-a', '2x_usb_type-a', '1x_usb_type-a', '4x_usb_type-a']:
                        if item.get(usb_a_key):
                            usb_type_a_value = item.get(usb_a_key)
                            break
                    
                    # Ambil USB Type-C yang pertama tersedia
                    usb_type_c_value = None
                    for usb_c_key in ['usb_type_c', 'usb_type-c', '3x_usb_type-c', '2x_usb_type-c', '1x_usb_type-c', '4x_usb_type-c']:
                        if item.get(usb_c_key):
                            usb_type_c_value = item.get(usb_c_key)
                            break
                    
                    cleaned_data = {
                        'usb_type_a': self.clean_value(usb_type_a_value),
                        'usb_type_c': self.clean_value(usb_type_c_value),
                        'hdmi': self.clean_value(item.get('hdmi')),
                        'card_reader': self.clean_value(item.get('card_reader')),
                        'ethernet_lan': self.clean_value(item.get('ethernet_lan')),
                        'wifi': self.clean_value(item.get('wi-fi')), 
                        'bluetooth': bluetooth_clean,
                        'audio_jack': self.clean_value(item.get('audio_jack'))
                    }
                    
                    self.cursor.execute("""
                        INSERT INTO Ports_Connectivity (port_id, usb_type_a, usb_type_c, hdmi, card_reader,
                                                       ethernet_lan, wifi, bluetooth, audio_jack)
                        VALUES (%(port_id)s, %(usb_type_a)s, %(usb_type_c)s, %(hdmi)s, %(card_reader)s,
                               %(ethernet_lan)s, %(wifi)s, %(bluetooth)s, %(audio_jack)s)
                    """, {**cleaned_data, 'port_id': unique_id})
                    count += 1
            
            self.connection.commit()
            print(f"   Berhasil insert {count} record ke Ports_Connectivity")
            
        except Exception as e:
            print(f"   Error saat insert Ports_Connectivity: {e}")
            self.connection.rollback()
            raise

        # 3. Laptop 
        print("Memproses data Laptop dengan ID unik -> Laptop")
        try:
            count = 0
            for rank, unique_id in self.id_mappings['laptop'].items():
                laptop_data = None
                for laptop in self.matched_data['raw_files']['Laptop.json']:
                    if laptop.get('rank') == rank:
                        laptop_data = laptop
                        break
                
                if laptop_data:
                    # Bersihkan ukuran layar (hapus "-inch")
                    screen_size = laptop_data.get('screen_size', '')
                    screen_clean = re.sub(r'-inch', '', str(screen_size))
                    screen_float = self.clean_value(screen_clean, 'float')
                    
                    # Bersihkan warna (hapus "dE")
                    color = laptop_data.get('color', '')
                    color_clean = re.sub(r'\s*dE', '', str(color))
                    color_float = self.clean_value(color_clean, 'float')
                    
                    # Bersihkan kecerahan (hapus "nits")
                    brightness = laptop_data.get('max_brightness', '')
                    brightness_clean = re.sub(r'\s*nits?', '', str(brightness))
                    brightness_int = self.clean_value(brightness_clean, 'integer')
                    
                    # Bersihkan DCI-P3 (hapus "%")
                    dci_p3 = laptop_data.get('dci_p3', '')
                    dci_clean = re.sub(r'%', '', str(dci_p3))
                    dci_float = self.clean_value(dci_clean, 'float')
                    
                    # Bersihkan contrast 
                    contrast = laptop_data.get('contrast', '')
                    contrast_clean = self.clean_value(contrast) if contrast else None
                    
                    # Handle name dan resolution dengan lebih hati-hati
                    laptop_name = laptop_data.get('name', '')
                    if laptop_name and str(laptop_name).strip() and str(laptop_name).strip().lower() not in ['null', 'none']:
                        laptop_name_clean = str(laptop_name).strip()
                    else:
                        laptop_name_clean = None
                    
                    resolution = laptop_data.get('resolution', '')
                    if resolution and str(resolution).strip() and str(resolution).strip().lower() not in ['null', 'none']:
                        resolution_clean = str(resolution).strip()
                    else:
                        resolution_clean = None
                    
                    cleaned_data = {
                        'rank': self.clean_value(laptop_data.get('rank'), 'integer'),
                        'name': laptop_name_clean,
                        'detail_url': self.clean_value(laptop_data.get('detail_url')),
                        'screen_size': screen_float,
                        'resolution': resolution_clean,
                        'display_type': self.clean_value(laptop_data.get('display_type')),
                        'panel_info': self.clean_value(laptop_data.get('panel')),
                        'color': color_float,
                        'max_brightness': brightness_int,
                        'contrast': contrast_clean,
                        'dci_p3': dci_float,
                        'eye_safety': self.clean_value(laptop_data.get('eye_safety'))
                    }
                    
                    self.cursor.execute("""
                        INSERT INTO Laptop (laptop_id, rank, laptop_name, detail_url,
                                           screen_size, resolution, display_type, panel_info,
                                           color, max_brightness, contrast, dci_p3, eye_safety)
                        VALUES (%(laptop_id)s, %(rank)s, %(name)s, %(detail_url)s,
                               %(screen_size)s, %(resolution)s, %(display_type)s, %(panel_info)s,
                               %(color)s, %(max_brightness)s, %(contrast)s, %(dci_p3)s, %(eye_safety)s)
                    """, {**cleaned_data, 'laptop_id': unique_id})
                    count += 1
            
            self.connection.commit()
            print(f"   Berhasil insert {count} record ke Laptop")
            
        except Exception as e:
            print(f"   Error saat insert Laptop: {e}")
            self.connection.rollback()
            raise

        print("   Memproses data Laptop_Score dengan ID unik -> Laptop_Score")
        try:
            count = 0
            laptop_score_data = self.matched_data['raw_files'].get('Laptop_Score.json', [])
            
            if not laptop_score_data:
                print("   Warning: Laptop_Score.json tidak ditemukan, melewati insert Laptop_Score")
            else:
                for idx, score_data in enumerate(laptop_score_data):
                    # Generate unique score_id
                    score_id = self.id_mappings['score'].get(idx)
                    if not score_id:
                        continue
                        
                    # Cari laptop_id berdasarkan rank
                    laptop_id = None
                    rank = score_data.get('rank')
                    if rank and rank in self.id_mappings['laptop']:
                        laptop_id = self.id_mappings['laptop'][rank]
                    
                    if laptop_id:
                        cleaned_data = {
                            'score_id': score_id,
                            'color_score': self.clean_value(score_data.get('color_score')),
                            'max_brightness_score': self.clean_value(score_data.get('max_brightness_score')),
                            'contrast_score': self.clean_value(score_data.get('contrast_score')),
                            'dci_p3_score': self.clean_value(score_data.get('dci_p3_score')),
                            'eye_safety_score': self.clean_value(score_data.get('eye_safety_score')),
                            'laptop_id': laptop_id
                        }
                        
                        self.cursor.execute("""
                            INSERT INTO Laptop_Score (score_id, color_score, max_brightness_score, contrast_score,
                                                     dci_p3_score, eye_safety_score, laptop_id)
                            VALUES (%(score_id)s, %(color_score)s, %(max_brightness_score)s, %(contrast_score)s,
                                   %(dci_p3_score)s, %(eye_safety_score)s, %(laptop_id)s)
                        """, cleaned_data)
                        count += 1
            
            self.connection.commit()
            print(f"   Berhasil insert {count} record ke Laptop_Score")
            
        except Exception as e:
            print(f"   Error saat insert Laptop_Score: {e}")
            self.connection.rollback()
            raise

        # 4. Laptop_Detailed_Spec 
        print("Memproses data Laptop_Detailed_Spec dengan ID unik -> Laptop_Detailed_Spec")
        try:
            count = 0
            for idx, unique_id in self.id_mappings['details'].items():
                if idx < len(self.matched_data['raw_files']['Laptop_Detailed_Spec.json']):
                    item = self.matched_data['raw_files']['Laptop_Detailed_Spec.json'][idx]
                    feature_id = self.id_mappings['features'].get(idx)
                    port_id = self.id_mappings['ports'].get(idx)
                    laptop_id = None
                    if idx < len(self.id_mappings['laptop']):
                        rank_list = sorted(self.id_mappings['laptop'].keys())
                        if idx < len(rank_list):
                            rank_key = rank_list[idx]
                            laptop_id = self.id_mappings['laptop'][rank_key]
                    
                    # Bersihkan storage_type dari teks "x4See photo" dan "See photo"
                    storage_type_raw = item.get('storage_type', '')
                    if storage_type_raw:
                        # Hapus teks "x4See photo" dan "See photo"
                        storage_type_clean = re.sub(r'x4See photo|See photo', '', storage_type_raw).strip()
                    else:
                        storage_type_clean = storage_type_raw
                    
                    cleaned_data = {
                        'storage_spec': self.clean_value(item.get('storage')),
                        'storage_type': self.clean_value(storage_type_clean),
                        'ram_spec': self.clean_value(item.get('ram')),
                        'battery': self.clean_value(item.get('battery')),
                        'body_material': self.clean_value(item.get('body_material')),
                        'dimensions': self.clean_value(item.get('dimensions')),
                        'weight': self.clean_value(item.get('weight')),
                        'feature_id': feature_id,
                        'port_id': port_id,
                        'laptop_id': laptop_id
                    }
                    
                    self.cursor.execute("""
                        INSERT INTO Laptop_Detailed_Spec (detail_id, storage_spec, storage_type, ram_spec,
                                                         battery, body_material, dimensions, weight,
                                                         feature_id, port_id, laptop_id)
                        VALUES (%(detail_id)s, %(storage_spec)s, %(storage_type)s, %(ram_spec)s,
                               %(battery)s, %(body_material)s, %(dimensions)s, %(weight)s,
                               %(feature_id)s, %(port_id)s, %(laptop_id)s)
                    """, {**cleaned_data, 'detail_id': unique_id})
                    count += 1
            
            self.connection.commit()
            print(f"   Berhasil insert {count} record ke Laptop_Detailed_Spec")
            
        except Exception as e:
            print(f"   Error saat insert Laptop_Detailed_Spec: {e}")
            self.connection.rollback()
            raise

        # 5. CPU 
        print("Memproses data CPU yang telah dicocokkan dengan ID unik -> CPU")
        try:
            count = 0
            inserted_cpu_data = []
            for cpu_match in self.matched_data['cpu']:
                cpu_name_cleaned = self.clean_value(cpu_match['cpu_name'])
                if cpu_name_cleaned:
                    cleaned_data = {
                        'cpu_name': cpu_name_cleaned,
                        'laptop_id': cpu_match['laptop_id']
                    }
                    self.cursor.execute("""
                        INSERT INTO CPU (cpu_id, cpu_name, laptop_id)
                        VALUES (%(cpu_id)s, %(cpu_name)s, %(laptop_id)s)
                    """, {**cleaned_data, 'cpu_id': cpu_match['cpu_id']})
                    inserted_cpu_data.append(cpu_match)
                    count += 1
                else:
                    cpu_name_raw = cpu_match.get('cpu_name', '')
                    if cpu_name_raw and cpu_name_raw.strip():
                        cleaned_data = {
                            'cpu_name': cpu_name_raw.strip()[:100],
                            'laptop_id': cpu_match['laptop_id']
                        }
                        self.cursor.execute("""
                            INSERT INTO CPU (cpu_id, cpu_name, laptop_id)
                            VALUES (%(cpu_id)s, %(cpu_name)s, %(laptop_id)s)
                        """, {**cleaned_data, 'cpu_id': cpu_match['cpu_id']})
                        cpu_match['cpu_name'] = cpu_name_raw.strip()[:100]
                        inserted_cpu_data.append(cpu_match)
                        count += 1
            
            self.matched_data['inserted_cpu'] = inserted_cpu_data
            
            self.connection.commit()
            print(f"   Berhasil insert {count} record ke CPU")
            
        except Exception as e:
            print(f"   Error saat insert CPU: {e}")
            self.connection.rollback()
            raise

        # 6. CPU_Performance 
        print("Memproses data CPU_Performance dengan ID unik -> CPU_Performance")
        try:
            count = 0
            skipped = 0
            
            inserted_cpu_ids = set()
            for cpu_match in self.matched_data.get('inserted_cpu', self.matched_data['cpu']):
                inserted_cpu_ids.add(cpu_match['cpu_id'])
            
            for idx, unique_id in self.id_mappings['cpu_perf'].items():
                if idx < len(self.matched_data['raw_files']['CPU_Performance.json']):
                    item = self.matched_data['raw_files']['CPU_Performance.json'][idx]
                    
                    perf_pct = item.get('performance_percentage', '')
                    perf_clean = re.sub(r'%', '', str(perf_pct))
                    perf_float = self.clean_value(perf_clean, 'float')
                    
                    cpu_id = None
                    cpu_name_from_perf = item.get('cpu', '').strip()
                    if not cpu_name_from_perf:
                        cpu_name_from_perf = item.get('cpu_name', '').strip()
                    
                    if cpu_name_from_perf:
                        for cpu_match in self.matched_data.get('inserted_cpu', self.matched_data['cpu']):
                            cpu_name = cpu_match['cpu_name']
                            if cpu_name and cpu_name_from_perf:
                                if (cpu_name_from_perf.lower() == cpu_name.lower() or
                                    cpu_name_from_perf.lower() in cpu_name.lower() or 
                                    cpu_name.lower() in cpu_name_from_perf.lower()):
                                    cpu_id = cpu_match['cpu_id']
                                    break
                    
                    if cpu_id and cpu_id in inserted_cpu_ids:
                        cleaned_data = {
                            'cpu_url': self.clean_value(item.get('cpu_url')),
                            'cpu_benchmark_score': self.clean_value(item.get('benchmark_score'), 'integer'),
                            'cpu_performance_percentage': perf_float,
                            'cpu_performance_ranking': self.clean_value(item.get('cpu_performance_ranking'), 'integer'),
                            'cpu_id': cpu_id
                        }
                        
                        self.cursor.execute("""
                            INSERT INTO CPU_Performance (cpu_perf_id, cpu_url, cpu_benchmark_score,
                                                        cpu_performance_percentage, cpu_performance_ranking, cpu_id)
                            VALUES (%(cpu_perf_id)s, %(cpu_url)s, %(cpu_benchmark_score)s,
                                   %(cpu_performance_percentage)s, %(cpu_performance_ranking)s, %(cpu_id)s)
                        """, {**cleaned_data, 'cpu_perf_id': unique_id})
                        count += 1
                    else:
                        skipped += 1
            
            self.connection.commit()
            print(f"   Berhasil insert {count} record ke CPU_Performance")
            if skipped > 0:
                print(f"   Melewati {skipped} record karena tidak ada CPU yang cocok")
            
        except Exception as e:
            print(f"   Error saat insert CPU_Performance: {e}")
            self.connection.rollback()
            raise

        # 7. GPU 
        print("Memproses data GPU yang telah dicocokkan dengan ID unik -> GPU")
        try:
            count = 0
            for gpu_match in self.matched_data['gpu']:
                cleaned_data = {
                    'gpu_name': self.clean_value(gpu_match['gpu_name']),
                    'laptop_id': gpu_match['laptop_id']
                }
                if cleaned_data['gpu_name']: 
                    self.cursor.execute("""
                        INSERT INTO GPU (gpu_id, gpu_name, laptop_id)
                        VALUES (%(gpu_id)s, %(gpu_name)s, %(laptop_id)s)
                    """, {**cleaned_data, 'gpu_id': gpu_match['gpu_id']})
                    count += 1
            
            self.connection.commit()
            print(f"   Berhasil insert {count} record ke GPU")
            
        except Exception as e:
            print(f"   Error saat insert GPU: {e}")
            self.connection.rollback()
            raise

        # 8. GPU_Performance 
        print("Memproses data GPU_Performance dengan ID unik -> GPU_Performance")
        try:
            count = 0
            for idx, unique_id in self.id_mappings['gpu_perf'].items():
                if idx < len(self.matched_data['raw_files']['GPU_Performance.json']):
                    item = self.matched_data['raw_files']['GPU_Performance.json'][idx]
                    
                    # Bersihkan percentage (hilangkan "%")
                    perf_pct = item.get('performance_percentage', '')
                    perf_clean = re.sub(r'%', '', str(perf_pct))
                    perf_float = self.clean_value(perf_clean, 'float')
                    
                    gpu_id = None
                    gpu_name_from_perf = item.get('gpu', '').strip()
                    if not gpu_name_from_perf:
                        gpu_name_from_perf = item.get('gpu_name', '').strip()
                    
                    if gpu_name_from_perf:
                        for gpu_match in self.matched_data['gpu']:
                            gpu_name = gpu_match['gpu_name']
                            if gpu_name and gpu_name_from_perf:
                                if (gpu_name_from_perf.lower() == gpu_name.lower() or
                                    gpu_name_from_perf.lower() in gpu_name.lower() or 
                                    gpu_name.lower() in gpu_name_from_perf.lower()):
                                    gpu_id = gpu_match['gpu_id']
                                    break
                    
                    # Debug: peringatan jika tidak ada GPU yang cocok ditemukan
                    if not gpu_id and gpu_name_from_perf:
                        print(f"   Peringatan: Tidak ada GPU yang cocok ditemukan untuk data performa: {gpu_name_from_perf[:50]}")
                    
                    cleaned_data = {
                        'gpu_url': self.clean_value(item.get('gpu_url')),
                        'gpu_benchmark_score': self.clean_value(item.get('benchmark_score'), 'integer'),
                        'gpu_performance_percentage': perf_float,
                        'gpu_performance_ranking': self.clean_value(item.get('gpu_performance_ranking'), 'integer'),
                        'gpu_id': gpu_id
                    }
                    
                    self.cursor.execute("""
                        INSERT INTO GPU_Performance (gpu_perf_id, gpu_url, gpu_benchmark_score,
                                                    gpu_performance_percentage, gpu_performance_ranking, gpu_id)
                        VALUES (%(gpu_perf_id)s, %(gpu_url)s, %(gpu_benchmark_score)s,
                               %(gpu_performance_percentage)s, %(gpu_performance_ranking)s, %(gpu_id)s)
                    """, {**cleaned_data, 'gpu_perf_id': unique_id})
                    count += 1
            
            self.connection.commit()
            print(f"   Berhasil insert {count} record ke GPU_Performance")
            
        except Exception as e:
            print(f"   Error saat insert GPU_Performance: {e}")
            self.connection.rollback()
            raise

        # 9. Laptop_Configuration 
        print("Memproses data Konfigurasi yang telah dicocokkan dengan ID unik -> Laptop_Configuration")
        try:
            count = 0
            for config_match in self.matched_data['config']:
                item = config_match['original_data']
                
                # Bersihkan RAM (ekstrak angka dari "64GB RAM")
                ram_text = item.get('ram', '')
                ram_match = re.search(r'(\d+)', str(ram_text))
                ram_value = int(ram_match.group(1)) if ram_match else None
                
                # Bersihkan Storage (ekstrak angka dari "1000GB SSD")
                storage_text = item.get('storage', '')
                storage_match = re.search(r'(\d+)', str(storage_text))
                storage_value = int(storage_match.group(1)) if storage_match else None
                
                cleaned_data = {
                    'configuration_ranking': self.clean_value(item.get('configuration_ranking'), 'integer'),
                    'config_laptop_name': self.clean_value(item.get('config_name')),  
                    'ram': ram_value,
                    'storage': storage_value,
                    'os': self.clean_value(item.get('os')),
                    'price': self.clean_value(item.get('price'), 'price'),
                    'review_url': self.clean_value(item.get('review_url')),
                    'amazon_url': self.clean_value(item.get('amazon_url')),
                    'laptop_specs_url': self.clean_value(item.get('url')),
                    'laptop_id': config_match['laptop_id'],
                    'gpu_id': config_match['gpu_id'],
                    'cpu_id': config_match['cpu_id']
                }
                
                self.cursor.execute("""
                    INSERT INTO Laptop_Configuration (config_id, configuration_ranking, config_Laptop_name, ram, storage,
                                                     os, price, review_url, amazon_url, laptop_specs_url,
                                                     laptop_id, gpu_id, cpu_id)
                    VALUES (%(config_id)s, %(configuration_ranking)s, %(config_laptop_name)s, %(ram)s, %(storage)s,
                           %(os)s, %(price)s, %(review_url)s, %(amazon_url)s, %(laptop_specs_url)s,
                           %(laptop_id)s, %(gpu_id)s, %(cpu_id)s)
                """, {**cleaned_data, 'config_id': config_match['config_id']})
                count += 1
            
            self.connection.commit()
            print(f"   Berhasil insert {count} record ke Laptop_Configuration")
            
        except Exception as e:
            print(f"   Error saat insert Laptop_Configuration: {e}")
            self.connection.rollback()
            raise

        # 10. Laptop_Image 
        print("Memproses data Laptop_Image dengan ID laptop unik -> Laptop_Image")
        try:
            count = 0
            for laptop_img in self.matched_data['raw_files']['Laptop_Image.json']:
                laptop_rank = laptop_img.get('laptop_rank')
                image_urls = laptop_img.get('image_urls', [])
                
                laptop_id = None
                if laptop_rank and laptop_rank in self.id_mappings['laptop']:
                    laptop_id = self.id_mappings['laptop'][laptop_rank]
                
                if laptop_id:
                    for image_url in image_urls:
                        if image_url: 
                            cleaned_data = {
                                'laptop_id': laptop_id,
                                'image_url': self.clean_value(image_url)
                            }
                            
                            if cleaned_data['laptop_id'] and cleaned_data['image_url']:
                                self.cursor.execute("""
                                    INSERT INTO Laptop_Image (laptop_id, image_url)
                                    VALUES (%(laptop_id)s, %(image_url)s)
                                    ON CONFLICT (laptop_id, image_url) DO NOTHING
                                """, cleaned_data)
                                count += 1
            
            self.connection.commit()
            print(f"   Berhasil insert {count} record ke Laptop_Image")
            
        except Exception as e:
            print(f"   Error saat insert Laptop_Image: {e}")
            self.connection.rollback()
            raise
        
        print("Semua proses insert data berhasil diselesaikan!")

    # Main
    def run(self):
        """Jalankan preprocessing + insert data """
        print("Simple Database Insertion - INSERT DATA WITH PREPROCESSING")
        print("=" * 60)
        
        try:
            # Langkah 1: Koneksi
            print("\nLangkah 1: Koneksi ke Database")
            self.connect_database()
            
            # Langkah 2: Preprocessing dan Matching
            print("\nLangkah 2: Preprocessing dan Matching Data")
            self.preprocess_and_match_data()
            
            # Langkah 3: Insert Data (dengan relasi yang sudah dicocokkan)
            print("\nLangkah 3: Insert Data dengan Relasi yang Telah Dicocokkan")
            self.insert_all_data()
            
            print("\nProses insert data berhasil diselesaikan!")
            print("Semua data berhasil dimasukkan ke database PostgreSQL dengan relasi yang tepat")
            
        except Exception as e:
            print(f"\nError: {e}")
            sys.exit(1)
        finally:
            self.disconnect_database()

def main():
    """Fungsi utama"""
    
    if not POSTGRES_AVAILABLE:
        print("PostgreSQL adapter tidak tersedia!")
        print("Install dengan: pip install psycopg2-binary")
        sys.exit(1)
    
    # Konfigurasi
    data_dir = r"c:\Users\Matthew\OneDrive - Institut Teknologi Bandung\seleksi basdat\Seleksi-2025-Tugas-1\Data Scraping\data"  # File JSON sumber
    
    # Konfigurasi database 
    db_config = {
        'host': 'localhost',
        'database': 'top100_laptop_screen',
        'user': 'postgres',            
        'password': 'Matthew487214',    
        'port': 5432
    }
    
    print(f" Direktori sumber: {data_dir}")
    print(f" Database target: {db_config['database']}")
    print("Memulai proses insert data yang telah dipreproses...")
    
    # Jalankan preprocessing + insertion
    storage = SimpleDatabaseInsertion(data_dir, db_config)
    try:
        print("1. Melakukan preprocessing dan matching data...")
        storage.preprocess_and_match_data()
        
        print("\n2. Memulai insertion data ke database...")
        storage.run()
        print("BERHASIL! Semua data telah diinsert dengan relasi yang benar.")
        
    except Exception as e:
        print(f"Error: {e}")
        import traceback
        traceback.print_exc()
    finally:
        storage.disconnect_database()

if __name__ == "__main__":
    main()
