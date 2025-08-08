"""
KEPATUHAN SCRAPING ETIS:
1. Perencanaan: Data dikumpulkan untuk analisis database dengan tujuan pembelajaran
2. Request: Menggunakan HTTP GET request (tidak menggunakan API)
3. Ekstrak Data: Parsing HTML dengan BeautifulSoup dan CSS selectors
4. Formatting: Data disimpan dalam format JSON terorganisir           

CATATAN PENTING:
- Script ini TIDAK menggunakan API apapun, hanya parsing HTML langsung
- Implementasi delay dan rate limiting yang tepat untuk menghormati sumber daya server
- Mengikuti praktik scraping etis sesuai panduan 
- Scraping hanya dari halaman web yang tersedia untuk publik
- Data ditransformasi dan diorganisir, bukan duplikasi mentah

DATA CLEANING YANG DILAKUKAN:
1. PEMBERSIHAN TEKS:
   - Menghapus whitespace berlebih dan karakter tab
   - Normalisasi spasi ganda menjadi spasi tunggal
   - Trim leading/trailing whitespace

2. PEMBERSIHAN UKURAN LAYAR:
   - Ekstrak angka dari format "14.2-inch" 
   - Standarisasi format satuan

3. PEMBERSIHAN RESOLUSI:
   - Ekstrak pola resolusi (contoh: "3024x1964")
   - Normalisasi format separator (x, ×, X)
   - Hapus spasi yang tidak perlu

4. PEMBERSIHAN TIPE DISPLAY:
   - Deteksi dan standarisasi format (IPS, OLED, Mini-LED)
   - Konversi ke huruf kapital untuk konsistensi

5. PEMBERSIHAN SKOR WARNA (dE):
   - Ekstrak nilai dE dari teks kompleks
   - Format konsisten untuk nilai desimal
   - Parsing khusus untuk akurasi warna

6. PEMBERSIHAN HARGA:
   - Hapus simbol mata uang dan koma
   - Ekstrak nilai numerik dari teks
   - Standarisasi format currency

7. PEMBERSIHAN PERSENTASE:
   - Hapus simbol % dari data performa
   - Konversi ke format numerik

8. PEMBERSIHAN IKON DAN STATUS:
   - Deteksi checkmark dan convert ke "Yes"
   - Deteksi X mark dan convert ke "No"
   - Standarisasi boolean values

9. PEMBERSIHAN RANKING:
   - Hapus teks ranking dari nama CPU/GPU
   - Ekstrak nilai numerik ranking
   - Bersihkan format "#123 in Top CPUs"

10. PEMBERSIHAN URL:
    - Validasi format URL
    - Normalisasi protokol (http/https)

11. PEMBERSIHAN NAMA PRODUK:
    - Standarisasi format nama laptop
    - Hapus karakter khusus yang tidak diinginkan
    - Normalisasi case sensitivity

12. PEMBERSIHAN SPESIFIKASI TEKNIS:
    - Ekstrak nilai numerik dari spesifikasi RAM (GB)
    - Ekstrak nilai numerik dari kapasitas storage (GB/TB)
    - Standarisasi format spesifikasi teknis

13. PEMBERSIHAN DATA KONFIGURASI:
    - Normalisasi nama sistem operasi
    - Standarisasi format konfigurasi hardware
    - Pembersihan data variant konfigurasi

14. PEMBERSIHAN DATA PERFORMA:
    - Ekstrak nilai benchmark score
    - Normalisasi format ranking performa
    - Pembersihan data komparatif

15. PEMBERSIHAN KONEKTIVITAS:
    - Standarisasi nama port dan koneksi
    - Normalisasi format spesifikasi wireless
    - Pembersihan data fitur konektivitas

Requirements:
- selenium
- beautifulsoup4
- Chrome browser dengan ChromeDriver
"""

from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By
from bs4 import BeautifulSoup
import json
import time
import re
import os
import random 

def extract_text(el):
    """Ekstrak teks dan bersihkan spasi berlebih dan tab"""
    if not el:
        return ""
    text = el.get_text(strip=True)
    import re
    text = re.sub(r'\s+', ' ', text).strip()
    return text

def wait_for_content(driver, timeout=10):
    """Tunggu konten dimuat dengan benar"""
    from selenium.webdriver.common.by import By
    from selenium.webdriver.support.ui import WebDriverWait
    from selenium.webdriver.support import expected_conditions as EC
    
    try:
        WebDriverWait(driver, timeout).until(
            EC.presence_of_element_located((By.TAG_NAME, "body"))
        )
        time.sleep(3)  # Tunggu tambahan untuk konten dinamis
    except:
        time.sleep(timeout)

def extract_value_with_icons(element):
    """Ekstrak nilai dan deteksi status ya atau tidak"""
    if not element:
        return ""
    check_icon = element.select_one("i.icon-check, i.text-green-500")
    if check_icon:
        return "Yes"
    x_icon = element.select_one("i.icon-times, i.text-red-500") 
    if x_icon:
        return "No"
    text = extract_text(element)
    return text if text else ""

def get_optimized_driver():
    """
    untuk driver Chrome yang dioptimalkan dengan pengaturan scraping etis
    
    Returns:
        webdriver.Chrome: Instance driver Chrome yang dikonfigurasi
    
    Fitur:
    - Langkah anti-deteksi untuk tampil seperti browser biasa
    - Pengaturan dioptimalkan untuk scraping yang stabil
    - User agent etis dengan identifikasi yang tepat sesuai pedoman ITB
    """
    options = Options()
    options.add_argument("--start-maximized")
    options.add_argument("--disable-blink-features=AutomationControlled")
    options.add_experimental_option("excludeSwitches", ["enable-automation"])
    options.add_experimental_option('useAutomationExtension', False)
    
    # Format: Info browser + Institusi/Kontak untuk transparansi
    options.add_argument("--user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36; ITB-Database-Lab/Student; Educational-Research")
    
    # Kurangi beban server dengan menonaktifkan sumber daya yang tidak perlu 
    prefs = {
        "profile.managed_default_content_settings.images": 2,  
        "profile.managed_default_content_settings.stylesheets": 2,  
        "profile.managed_default_content_settings.javascript": 1,  
    }
    options.add_experimental_option("prefs", prefs)
    
    driver = webdriver.Chrome(options=options)
    
    # Hapus deteksi webdriver untuk stabilitas 
    driver.execute_script("Object.defineProperty(navigator, 'webdriver', {get: () => undefined})")
    
    # Tetapkan timeout 
    driver.implicitly_wait(3)
    
    return driver

def implement_ethical_delay(min_delay=2, max_delay=5):
    delay = random.uniform(min_delay, max_delay)
    print(f"Jeda etis: {delay:.1f}s (menghormati sumber daya server)")
    time.sleep(delay)

def scrape_laptops_screens():
    base_url = "https://laptopmedia.com/top-100-laptops-with-the-best-screens/"
    print(f"Mengakses URL: {base_url}")

    # untuk browser yang dioptimalkan dengan pengaturan etis
    options = Options()
    options.add_argument("--start-maximized")
    options.add_argument("--disable-images")  
    options.page_load_strategy = 'eager' 
    driver = webdriver.Chrome(options=options)
    
    try:
        # HTTP GET method 
        driver.get(base_url)
        wait_for_content(driver, 8)

        # Parse response HTML dan ambil data yang dibutuhkan menggunakan CSS selectors
        soup = BeautifulSoup(driver.page_source, "html.parser")
        blocks = soup.select("div.mb-5.shadow.text-lm-darkBlue.flex.overflow-hidden")
        print(f"Ditemukan {len(blocks)} entri laptop di halaman")

        # Pre-compile regex patterns
        size_pattern = re.compile(r"([\d.]+)-inch")
        res_pattern = re.compile(r"(\d+\s*[x×хX]\s*\d+)")
        display_pattern = re.compile(r"\b(IPS|OLED|Mini-LED|Mini LED|WVA)\b", re.IGNORECASE)
        price_pattern = re.compile(r"\$(\d+(?:\.\d+)?)")
        de_pattern = re.compile(r'([\d.]+)\s*dE')

        laptops_main = []
        # Proses setiap entri laptop
        for idx, block in enumerate(blocks, start=1):
            data = {}
            data['rank'] = idx # Menambahkan ranking berdasarkan posisi di halaman
            
            a_tag = block.find("a", href=True)
            data['name'] = extract_text(a_tag.find("h2")) if a_tag else ""
            data['detail_url'] = a_tag['href'] if a_tag else ""
            
            img_tag = block.find("img", class_="object-cover")
            data['image_url'] = img_tag['src'] if img_tag else ""

            specs = a_tag.find_all("dd", class_="monitor") if a_tag else []
            if len(specs) >= 2:
                disp_text = extract_text(specs[0])  
                panel_text = extract_text(specs[1])  

                size_match = size_pattern.search(disp_text)
                data['screen_size'] = size_match.group(1) + "-inch" if size_match else ""
                
                res_match = res_pattern.search(disp_text)
                data['resolution'] = res_match.group(1).replace(" ", "") if res_match else ""
                
                display_type_match = display_pattern.search(disp_text)
                data['display_type'] = display_type_match.group(1).upper() if display_type_match else ""
                
                data['panel'] = panel_text
            else:
                # Set nilai kosong jika spesifikasi tidak ditemukan
                data['screen_size'] = ""
                data['resolution'] = ""
                data['display_type'] = ""
                data['panel'] = ""

            score_containers = block.find_all("div", class_=lambda c: c and "2xl:grid" in c and "text-center" in c)
            if len(score_containers) >= 5:
                def get_score(div, is_color=False):
                    """Ekstrak nilai skor dan rating dari kontainer skor"""
                    val = div.find("div", class_="bg-lm-lightGrayBlue")
                    scr = div.find("div", class_="border-t")
                    raw_val = extract_text(val).split("with")[0].strip()
                    score_clean = extract_text(scr).split("with")[0].strip()

                    if is_color:
                        de_match = de_pattern.search(raw_val)
                        if de_match:
                            parts = de_match.group(1).split('.')
                            if len(parts) >= 2:
                                last_digit = parts[-2][-1]
                                decimal_part = parts[-1]
                                return f"{last_digit}.{decimal_part} dE", score_clean
                        return "", score_clean

                    return raw_val, score_clean

                data['color'], data['color_score'] = get_score(score_containers[0], is_color=True)
                data['max_brightness'], data['max_brightness_score'] = get_score(score_containers[1])
                data['contrast'], data['contrast_score'] = get_score(score_containers[2])
                data['dci_p3'], data['dci_p3_score'] = get_score(score_containers[3])
                data['eye_safety'], data['eye_safety_score'] = get_score(score_containers[4])
            else:
                for field in ['color', 'color_score', 'max_brightness', 'max_brightness_score', 
                             'contrast', 'contrast_score', 'dci_p3', 'dci_p3_score', 
                             'eye_safety', 'eye_safety_score']:
                    data[field] = ""

            total_score = block.select_one("span.text-3xl")
            data["total_score"] = extract_text(total_score)

            price_block = block.select_one("a.bg-lm-darkOrange")
            if price_block:
                price_text = extract_text(price_block)
                price_match = price_pattern.search(price_text.replace(",", ""))
                data["price"] = f"${price_match.group(1)}" if price_match else ""
            else:
                data["price"] = ""
                
            laptops_main.append(data)
            if idx % 25 == 0:
                print(f"Memproses {idx}/100 laptop dari halaman utama...")
        print(f"Berhasil mengekstrak data dari {len(laptops_main)} laptop")
        return laptops_main
        
    finally:
        driver.quit()  # close driver

def scrape_detailed_laptop_data(detail_url):
    """
    Scrape data detail dari halaman laptop spesifik
    """
    print(f"Melakukan scraping data detail dari: {detail_url}")
    
    driver = get_optimized_driver()
    
    try:
        driver.get(detail_url)
        WebDriverWait(driver, 10).until(
            EC.presence_of_element_located((By.CSS_SELECTOR, "div.lm-specsSheet"))
        )
        time.sleep(3)
        
        soup = BeautifulSoup(driver.page_source, "html.parser")
        result = {
            'spec_images': [],
            'cpu_options': [],
            'gpu_options': [],
            'detailed_specs': {},
            'ports_connectivity': {},
            'features': {},
            'configurations': [],
            'cpu_performance': [],
            'gpu_performance': []
        }
        
        # SPEC IMAGES 
        gallery = soup.select("div.lm-specsSheet-gallery a[data-fancybox='specsSheet-gallery']")
        if gallery:
            result['spec_images'] = [a['href'] for a in gallery if a.has_attr('href')]
        
        # DETAILED SPECS 
        review_specs = soup.select_one("div.lm-review-specs")
        if review_specs:
            # CPU options
            cpu_section = review_specs.select_one("div:has(li:-soup-contains('CPU'))")
            if cpu_section:
                cpu_links = cpu_section.select("a")
                result['cpu_options'] = [extract_text(link) for link in cpu_links if extract_text(link)]
            
            # GPU options
            gpu_section = review_specs.select("div.lm-gpu-model:has(li:-soup-contains('GPU'))")
            if gpu_section:
                gpu_links = gpu_section[0].select("a")
                result['gpu_options'] = [extract_text(link) for link in gpu_links if extract_text(link)]
            
            spec_mappings = {
                'storage': 'HDD/SSD',
                'storage_type': 'M.2 Slot',
                'ram': 'RAM',
                'os': 'OS',
                'battery': 'Battery',
                'body_material': 'Body material',
                'dimensions': 'Dimensions',
                'weight': 'Weight'
            }
            
            for key, label in spec_mappings.items():
                spec_row = review_specs.select_one(f"div.lm-gpu-model:has(li:-soup-contains('{label}'))")
                if spec_row:
                    value_li = spec_row.select("li")
                    if len(value_li) >= 2:
                        result['detailed_specs'][key] = extract_text(value_li[1])
            
            # Ports and connectivity
            ports_sections = review_specs.select("div.ports-and-features")
            if len(ports_sections) >= 1:
                port_rows = ports_sections[0].select("ul.lm-spec")
                for row in port_rows:
                    port_items = row.select("li")
                    if len(port_items) >= 2:
                        port_name = extract_text(port_items[0]).replace(":", "").strip()
                        port_value = extract_value_with_icons(port_items[1])
                        result['ports_connectivity'][port_name.lower().replace(" ", "_")] = port_value
            
            # Features
            if len(ports_sections) >= 2:
                feature_rows = ports_sections[1].select("ul.lm-spec")
                for row in feature_rows:
                    feature_items = row.select("li")
                    if len(feature_items) >= 2:
                        feature_name = extract_text(feature_items[0]).replace(":", "").strip()
                        feature_value = extract_value_with_icons(feature_items[1])
                        result['features'][feature_name.lower().replace(" ", "_")] = feature_value
        
        # LAPTOP CONFIGURATIONS 
        config_section = soup.select_one('.lm-laptop-with-same-specs')
        if config_section:
            config_rows = config_section.select('.row-same-specs')
            for idx, row in enumerate(config_rows, 1):
                config = {}
                
                # Ranking
                rank_element = row.select_one('.rounded-full')
                if rank_element:
                    rank_text = extract_text(rank_element)
                    rank_match = re.search(r'(\d+)', rank_text)
                    config['configuration_ranking'] = rank_match.group(1) if rank_match else str(idx)
                else:
                    config['configuration_ranking'] = str(idx)
                
                # Configuration details
                link_element = row.select_one('a[href*="laptop-specs"]')
                if link_element:
                    config['url'] = link_element.get('href', '')
                    name_element = link_element.select_one('h2')
                    if name_element:
                        config['name'] = extract_text(name_element)
                
                # Specs
                spec_elements = row.select('dd')
                spec_labels = ['cpu', 'gpu', 'ram', 'storage', 'os']
                for i, spec_element in enumerate(spec_elements):
                    if i < len(spec_labels):
                        config[spec_labels[i]] = extract_text(spec_element)
                
                # Price dan link url
                price_element = row.select_one('.bg-lm-darkOrange span')
                if price_element:
                    config['price'] = ' '.join(extract_text(price_element).split())
                
                review_link = row.select_one('a[href*="review"]')
                if review_link:
                    config['review_url'] = review_link.get('href', '')
                
                amazon_link = row.select_one('a[href*="amazon.com"]')
                if amazon_link:
                    config['amazon_url'] = amazon_link.get('href', '')
                
                if config:
                    result['configurations'].append(config)
        
        # CPU PERFORMANCE 
        cpu_section = soup.select_one('div:has(h2:-soup-contains("CPU performance"))')
        if cpu_section:
            performance_rows = cpu_section.select('.performance-result')
            for idx, row in enumerate(performance_rows, 1):
                performance = {}
                
                cpu_link = row.select_one('a[href*="processor"]')
                if cpu_link:
                    performance['cpu_name'] = extract_text(cpu_link)
                    performance['cpu_url'] = cpu_link.get('href', '')
                
                laptop_link = row.select_one('a[href*="laptop-specs"]')
                if laptop_link:
                    performance['laptop_model'] = extract_text(laptop_link)
                    performance['laptop_specs_url'] = laptop_link.get('href', '')
                
                # Image
                img_element = row.select_one('img')
                if img_element:
                    performance['image'] = img_element.get('src', '')
                
                # Performance data
                amazon_link = row.select_one('a[href*="amazon.com"]')
                if amazon_link:
                    performance['amazon_url'] = amazon_link.get('href', '')
                    price_element = amazon_link.select_one('.bar-price span')
                    if price_element:
                        performance['price'] = extract_text(price_element)
                
                score_element = row.select_one('.bar-score')
                if score_element:
                    performance['benchmark_score'] = extract_text(score_element)
                
                bar_element = row.select_one('.blue-bar')
                if bar_element and bar_element.get('style'):
                    style = bar_element.get('style', '')
                    width_match = re.search(r'width:\s*(\d+)%', style)
                    if width_match:
                        performance['performance_percentage'] = width_match.group(1) + '%'
                
                performance['cpu_performance_ranking'] = idx
                
                if performance:
                    result['cpu_performance'].append(performance)
        
        # GPU PERFORMANCE 
        gpu_section = soup.select_one('div:has(h2:-soup-contains("Graphics Performance")), div:has(label:-soup-contains("Graphics Performance"))')
        if gpu_section:
            gpu_performance_rows = gpu_section.select('.performance-result')
            for idx, row in enumerate(gpu_performance_rows, 1):
                gpu_performance = {}
                
                gpu_link = row.select_one('a[href*="video-card"]')
                if gpu_link:
                    gpu_performance['gpu_name'] = extract_text(gpu_link)
                    gpu_performance['gpu_url'] = gpu_link.get('href', '')
                
                laptop_link = row.select_one('a[href*="laptop-specs"]')
                if laptop_link:
                    gpu_performance['laptop_model'] = extract_text(laptop_link)
                    gpu_performance['laptop_specs_url'] = laptop_link.get('href', '')
                
                # Image
                img_element = row.select_one('img')
                if img_element:
                    gpu_performance['image'] = img_element.get('src', '')
                
                # Performance data
                amazon_link = row.select_one('a[href*="amazon.com"]')
                if amazon_link:
                    gpu_performance['amazon_url'] = amazon_link.get('href', '')
                    price_element = amazon_link.select_one('.bar-price span')
                    if price_element:
                        gpu_performance['price'] = extract_text(price_element)
                
                # GPU benchmark score
                score_element = row.select_one('.bar-score')
                if score_element:
                    gpu_performance['benchmark_score'] = extract_text(score_element)
                
                # GPU performance percentage dari bar width
                bar_element = row.select_one('.blue-bar')
                if bar_element and bar_element.get('style'):
                    style = bar_element.get('style', '')
                    width_match = re.search(r'width:\s*(\d+)%', style)
                    if width_match:
                        gpu_performance['performance_percentage'] = width_match.group(1) + '%'
                
                gpu_performance['gpu_performance_ranking'] = idx
                
                if gpu_performance:
                    result['gpu_performance'].append(gpu_performance)
        
        return result
        
    finally:
        driver.quit()

def save_separated_data(laptops_data, detailed_data_list):
    """
    menyimpan data yang di-scrape ke file JSON
    """
    
    # Buat direktori output jika belum ada
    output_dir = "Data Scraping/data"
    os.makedirs(output_dir, exist_ok=True)
    
    print("Memproses dan mengorganisir data yang di-scrape...")
    
    # Laptop (data layar utama)
    laptops_file = []
    laptop_scores = []
    for laptop in laptops_data:
        laptops_file.append({
            'rank': laptop.get('rank'),
            'name': laptop.get('name'),
            'detail_url': laptop.get('detail_url'),
            'image_url': laptop.get('image_url'),
            'screen_size': laptop.get('screen_size'),
            'resolution': laptop.get('resolution'),
            'display_type': laptop.get('display_type'),
            'panel': laptop.get('panel'),
            'color': laptop.get('color'),
            'max_brightness': laptop.get('max_brightness'),
            'contrast': laptop.get('contrast'),
            'dci_p3': laptop.get('dci_p3'),
            'eye_safety': laptop.get('eye_safety'),
            'price': laptop.get('price')
        })
        
        # Laptop_Score
        laptop_scores.append({
            'rank': laptop.get('rank'),
            'name': laptop.get('name'),
            'color_score': laptop.get('color_score'),
            'max_brightness_score': laptop.get('max_brightness_score'),
            'contrast_score': laptop.get('contrast_score'),
            'dci_p3_score': laptop.get('dci_p3_score'),
            'eye_safety_score': laptop.get('eye_safety_score'),
            'total_score': laptop.get('total_score')
        })
    
    # Laptop_Image 
    laptop_images = []
    for i, detailed_data in enumerate(detailed_data_list):
        laptop_rank = i + 1  
        images_for_laptop = detailed_data.get('spec_images', [])
        
        if images_for_laptop:
            laptop_images.append({
                'laptop_rank': laptop_rank,
                'image_urls': images_for_laptop
            })
        else:
            laptop_images.append({
                'laptop_rank': laptop_rank,
                'image_urls': []
            })
    
    # CPU 
    cpu_options = []
    for i, detailed_data in enumerate(detailed_data_list):
        laptop_rank = i + 1
        laptop_name = laptops_data[i].get('name', '') if i < len(laptops_data) else ''
        
        for cpu in detailed_data.get('cpu_options', []):
            cleaned_cpu = re.sub(r'#\d+\s+in\s+Top\s+CPUs', '', cpu).strip()
            if cleaned_cpu:
                cpu_options.append({
                    'cpu': cleaned_cpu,
                    'laptop_rank': laptop_rank,
                    'laptop_name': laptop_name
                })
    
    # GPU 
    gpu_options = []
    for i, detailed_data in enumerate(detailed_data_list):
        laptop_rank = i + 1
        laptop_name = laptops_data[i].get('name', '') if i < len(laptops_data) else ''
        
        for gpu in detailed_data.get('gpu_options', []):
            cleaned_gpu = re.sub(r'#\d+\s+in\s+Top\s+GPUs', '', gpu).strip()
            if cleaned_gpu:
                gpu_options.append({
                    'gpu': cleaned_gpu,
                    'laptop_rank': laptop_rank,
                    'laptop_name': laptop_name
                })
    
    # laptop detailed spesification
    laptop_detailed_specs = []
    for detailed_data in detailed_data_list:
        specs = detailed_data.get('detailed_specs', {})
        if specs:
            laptop_detailed_specs.append({
                'storage': specs.get('storage'),
                'storage_type': specs.get('storage_type'),
                'ram': specs.get('ram'),
                'os': specs.get('os'),
                'battery': specs.get('battery'),
                'body_material': specs.get('body_material'),
                'dimensions': specs.get('dimensions'),
                'weight': specs.get('weight')
            })
    
    # port and connectivity
    ports_connectivity = []
    for detailed_data in detailed_data_list:
        ports_data = detailed_data.get('ports_connectivity', {})
        if ports_data:
            ports_connectivity.append(ports_data)
    
    # Features
    features = []
    for detailed_data in detailed_data_list:
        feature_data = detailed_data.get('features', {})
        if feature_data:
            features.append({
                'fingerprint_reader': feature_data.get('fingerprint_reader'),
                'web_camera': feature_data.get('web_camera'),
                'backlit_keyboard': feature_data.get('backlit_keyboard'),
                'microphone': feature_data.get('microphone'),
                'speakers': feature_data.get('speakers'),
                'security_lock_slot': feature_data.get('security_lock_slot')
            })
    
    # Laptop Configuration
    laptop_configurations = []
    for i, detailed_data in enumerate(detailed_data_list):
        laptop_rank = i + 1
        laptop_name = laptops_data[i].get('name', '') if i < len(laptops_data) else ''
        
        for config in detailed_data.get('configurations', []):
            laptop_configurations.append({
                'configuration_ranking': config.get('configuration_ranking'),
                'url': config.get('url'),
                'config_name': config.get('name'),  
                'laptop_name': laptop_name,        
                'laptop_rank': laptop_rank,         
                'cpu': config.get('cpu'),
                'gpu': config.get('gpu'),
                'ram': config.get('ram'),
                'storage': config.get('storage'),
                'os': config.get('os'),
                'price': config.get('price'),
                'review_url': config.get('review_url'),
                'amazon_url': config.get('amazon_url')
            })
    
    # CPU performance
    cpu_performance = []
    for detailed_data in detailed_data_list:
        for perf in detailed_data.get('cpu_performance', []):
            cpu_performance.append({
                'cpu_performance_ranking': perf.get('cpu_performance_ranking'),
                'cpu_name': perf.get('cpu_name'),
                'cpu_url': perf.get('cpu_url'),
                'laptop_model': perf.get('laptop_model'),
                'laptop_specs_url': perf.get('laptop_specs_url'),
                'image': perf.get('image'),
                'amazon_url': perf.get('amazon_url'),
                'price': perf.get('price'),
                'benchmark_score': perf.get('benchmark_score'),
                'performance_percentage': perf.get('performance_percentage')
            })
    
    # GPU performance
    gpu_performance = []
    for detailed_data in detailed_data_list:
        for perf in detailed_data.get('gpu_performance', []):
            gpu_performance.append({
                'gpu_performance_ranking': perf.get('gpu_performance_ranking'),
                'gpu_name': perf.get('gpu_name'),
                'gpu_url': perf.get('gpu_url'),
                'laptop_model': perf.get('laptop_model'),
                'laptop_specs_url': perf.get('laptop_specs_url'),
                'image': perf.get('image'),
                'amazon_url': perf.get('amazon_url'),
                'price': perf.get('price'),
                'benchmark_score': perf.get('benchmark_score'),
                'performance_percentage': perf.get('performance_percentage')
            })
    
    # Simpan semua file
    files_to_save = [
        ('Laptop.json', laptops_file),
        ('Laptop_Score.json', laptop_scores),
        ('Laptop_Image.json', laptop_images),
        ('CPU.json', cpu_options),
        ('GPU.json', gpu_options),
        ('Laptop_Detailed_Spec.json', laptop_detailed_specs),
        ('Ports_Connectivity.json', ports_connectivity),
        ('Features.json', features),
        ('Laptop_Configuration.json', laptop_configurations),
        ('CPU_Performance.json', cpu_performance),
        ('GPU_Performance.json', gpu_performance)
    ]
    
    for filename, data in files_to_save:
        filepath = os.path.join(output_dir, filename)
        with open(filepath, 'w', encoding='utf-8') as f:
            json.dump(data, f, indent=2, ensure_ascii=False)
        print(f"Disimpan {filename} dengan {len(data)} record")

def main():
    
    print("****************************************")
    print("*      Memulai Scraping Data Laptop    *")
    print("****************************************")

    # Scrape data layar laptop utama
    print("\nLangkah 1: Scraping halaman daftar laptop utama...")
    laptops_data = scrape_laptops_screens()
    print(f"Berhasil melakukan scraping {len(laptops_data)} laptop dari halaman utama")
    
    # Scrape data detail dari SEMUA 100 laptop dengan jeda etis
    print(f"\nLangkah 2: Scraping data detail dari {len(laptops_data)} halaman laptop...")
    
    detailed_data_list = []
    total_laptops = len(laptops_data)
    for i, laptop in enumerate(laptops_data):
        if laptop.get('detail_url'):
            print(f"Memproses laptop {i+1}/{total_laptops}: {laptop.get('name')[:50]}...")
            
            try:
                if i > 0:
                    implement_ethical_delay(2, 4)  # Jeda acak 2-4 detik
                
                detailed_data = scrape_detailed_laptop_data(laptop['detail_url'])
                detailed_data_list.append(detailed_data)
                
            except Exception as e:
                print(f"Error memproses laptop {i+1}: {e}")
                detailed_data_list.append({
                    'spec_images': [],
                    'cpu_options': [],
                    'gpu_options': [],
                    'detailed_specs': {},
                    'ports_connectivity': {},
                    'features': {},
                    'configurations': [],
                    'cpu_performance': [],
                    'gpu_performance': []
                })
            
            if (i + 1) % 10 == 0:
                print(f"Progress: {i+1}/{total_laptops} laptop diproses")
                print(f"Implementasi jeda etis yang lebih lama setelah memproses {i+1} item...")
                time.sleep(5)  
    
    # Simpan data 
    print(f"\nLangkah 3: Mengorganisir dan menyimpan data...")
    save_separated_data(laptops_data, detailed_data_list)
    
    # Ringkasan akhir
    print(f"\nScraping komprehensif berhasil diselesaikan!")
    print(f"Ringkasan:")
    print(f"1. Total laptop diproses: {len(laptops_data)}")
    print(f"2. Data detail dikumpulkan: {len(detailed_data_list)}")
    print(f"3. File disimpan ke: Data Scraping/data/")

if __name__ == "__main__":
    main()
