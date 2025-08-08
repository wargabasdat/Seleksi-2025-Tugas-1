from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.chrome.options import Options
import time
import re
from datetime import datetime, timedelta
import hashlib
import os
import json

# ----------------------------
# Fungsi bantu
# ----------------------------

# Fungsi untuk menormalisasi informasi gaji dari string teks
def normalize_salary(compensation_str):
    currency = None
    min_salary = None
    max_salary = None
    with_equity = 'with equity' in compensation_str.lower()

    currency_match = re.match(r"([A-Z]{3})", compensation_str)
    if currency_match:
        currency = currency_match.group(1)

    number_matches = re.findall(r"\d[\d,]*", compensation_str)
    numbers = [int(n.replace(',', '')) for n in number_matches]

    # Tentukan min dan max salary
    if len(numbers) == 1:
        min_salary = max_salary = numbers[0]
    elif len(numbers) >= 2:
        min_salary = numbers[0]
        max_salary = numbers[1]

    return {
        'min_salary': min_salary,
        'max_salary': max_salary,
        'currency': currency,
        'with_equity': with_equity
    }

# Fungsi untuk menormalisasi format tanggal posting lowongan
def normalize_posted_date(raw):
    raw = raw.strip().lower()
    today = datetime.today()

    if 'ago' in raw:  # Format relatif seperti "2d ago", "5h ago"
        if 'h' in raw:
            hours = int(re.search(r'(\d+)h', raw).group(1))
            date = today - timedelta(hours=hours)
        elif 'd' in raw:
            days = int(re.search(r'(\d+)d', raw).group(1))
            date = today - timedelta(days=days)
        elif 'm' in raw:
            minutes = int(re.search(r'(\d+)m', raw).group(1))
            date = today - timedelta(minutes=minutes)
        elif 's' in raw:
            seconds = int(re.search(r'(\d+)s', raw).group(1))
            date = today - timedelta(seconds=seconds)
        else:
            date = today
    else:
        try:
            # Format tanggal absolut seperti "08 Aug 2025"
            date = datetime.strptime(raw, "%d %b %Y")
        except:
            date = today

    return date.strftime('%Y-%m-%d')

# Fungsi untuk menghasilkan hashed ID pendek berbasis SHA1, dengan prefix opsional
def get_hashed_id(value: str, prefix: str = "") -> str:
    return f"{prefix}_{hashlib.sha1(value.encode('utf-8')).hexdigest()[:8]}"

# ----------------------------
# Static Maps
# ----------------------------
# Mapping nama fungsi pekerjaan ke ID integer tetap (hardcoded)
# Menggunakan dictionary karena daftar ini sudah fix dari situs web,
# sehingga tidak perlu di-hash atau digenerate dinamis.
# Dictionary memberikan akses cepat (O(1)) berdasarkan nama fungsi.
function_map = {
    'Software Engineer': 1,
    'Web Development': 2,
    'Project & Product Management': 3,
    'Sales & Business Development': 4,
    'Marketing & PR': 5,
    'Data & Analytics': 6,
    'Media & Journalism': 7,
    'Finance, Legal & Accounting': 8,
    'Enterprise Software & Systems': 9,
    'DevOps & Cloud Management': 10,
    'Human Resources': 11,
    'Graphic & Motion Design': 12,
    'Hardware & Embedded Systems': 13,
    'QA & Testing': 14,
    'Strategy & Consulting': 15,
    'Science & Academics': 16,
    'Logistics & Operations': 17,
    'Mobile Development': 18,
    'Student': 19,
    'Event Management': 20,
    'Community Management': 21,
    'Executive & Management': 22,
    'Customer Success': 23,
    'UX/UI Design': 24,
    'Administrative & Clerical': 25,
    'Retail & Wholesale': 26
}

scraped_at = datetime.now().strftime('%Y-%m-%d %H:%M:%S')

# ----------------------------
# Selenium setup
# ----------------------------
options = Options()
options.add_argument("--headless")  # Run in headless mode
options.add_argument("--no-sandbox")  # Bypass OS security model (penting di VPS)
options.add_argument("--disable-dev-shm-usage")  # Gunakan disk, bukan shared memory (hindari crash)
options.add_argument("--disable-gpu")  # Optional untuk menghindari error rendering
options.add_argument("--window-size=1920,1080")  # Kadang diperlukan untuk element visibility

driver = webdriver.Chrome(options=options)
driver.get("https://www.techinasia.com/jobs/search?country_name[]=Indonesia&country_name[]=Singapore&country_name[]=Malaysia&country_name[]=Vietnam&country_name[]=India&country_name[]=Philippines&country_name[]=Australia&country_name[]=Japan&country_name[]=Korea%2C%20Republic%20of&country_name[]=Thailand&country_name[]=China")
wait = WebDriverWait(driver, 10)
time.sleep(5)

# Simpan data di list
jobs = []
company = []
location = []
function = []
industry = []
compensation_package = []
company_industry = []

seen_job_ids = set()
seen_company_ids = set()
seen_location_ids = set()
seen_function_ids = set()
seen_industry_ids = set()
seen_compensation_ids = set()
seen_company_industry_pairs = set()

max_scroll = 100 # Digunakan untuk menghindari infinite looping halaman akan di-scroll sebanyak maksimum 100 kali (jika job baru masih terus ditemukan).

for scroll_round in range(max_scroll):
    time.sleep(3) # Tunggu sebelum scroll
    driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
    time.sleep(3) # Tunggu supaya konten baru termuat

    job_cards = driver.find_elements(By.CSS_SELECTOR, 'article[data-cy="job-result"]')
    new_job_found = False

    for job in job_cards:
        try:
             # Ambil judul dan link lowongan
            title_elem = job.find_element(By.CSS_SELECTOR, 'a[data-cy="job-title"]')
            title = title_elem.text.strip()
            link = title_elem.get_attribute('href')
            link = f"https://www.techinasia.com{link}" if link.startswith("/") else link

            # Ambil slug untuk jadi ID job
            job_slug = re.search(r'/jobs/([a-z0-9\-]+)', link)
            job_id = job_slug.group(1) if job_slug else get_hashed_id(link)

            # Skip jika sudah pernah dilihat
            if job_id in seen_job_ids:
                continue
            seen_job_ids.add(job_id)
            new_job_found = True

            # Ambil nama perusahaan dan lokasi
            details = job.find_elements(By.CSS_SELECTOR, 'div.details > div')
            company_name = details[1].text.strip() if len(details) > 1 else "N/A"
            raw_location = details[2].text.strip() if len(details) > 2 else "N/A"

            # Split lokasi jadi city dan country
            if "," in raw_location:
                parts = [p.strip() for p in raw_location.split(",")]
                if len(parts) == 2:
                    city, country = parts
                else:
                    city = parts[0]
                    country = parts[-1]
            else:
                city = raw_location
                country = "N/A"

            # Generate hashed ID untuk lokasi dan perusahaan
            location_id = get_hashed_id(f"{city}, {country}", prefix="loc")
            company_id = get_hashed_id(company_name, prefix="comp")

            # Ambil tanggal posting (jika ada), normalisasi format
            try:
                raw_posted = job.find_element(By.CSS_SELECTOR, '.published-at').text.strip()
                posted_date = normalize_posted_date(raw_posted)
            except:
                posted_date = None

            # Ambil gaji (jika ada), default ke N/A
            try:
                compensation_str = job.find_element(By.CSS_SELECTOR, '.compensation').text.strip()
            except:
                compensation_str = "N/A"

            # Normalisasi gaji dan generate ID package
            compensation_pkg = normalize_salary(compensation_str)
            package_key = f"{compensation_pkg['currency']}_{compensation_pkg['min_salary']}_{compensation_pkg['max_salary']}_{int(compensation_pkg['with_equity'])}"
            compensation_id = get_hashed_id(package_key, prefix="pkg")

            # Ambil meta info tambahan: fungsi, industri, tipe kerja
            meta_items = job.find_elements(By.CSS_SELECTOR, '.additional-meta li')
            function_name = meta_items[0].text.strip() if len(meta_items) > 0 else "N/A"
            industry_name = meta_items[1].text.strip() if len(meta_items) > 1 else "N/A"
            job_type = meta_items[2].text.strip() if len(meta_items) > 2 else "N/A"

            # Convert fungsi jadi ID berdasarkan map
            function_id = function_map.get(function_name, -1)
            if function_id == -1:
                continue   # Skip jika fungsi tidak dikenali
            industry_names = [i.strip() for i in industry_name.split(",")]

            # ----------------------------
            # Cek dan simpan data unik ke masing-masing list
            # ----------------------------

            # Simpan company jika belum pernah ditemukan
            if company_id not in seen_company_ids:
                company.append({
                    "company_id": company_id,
                    "company_name": company_name,
                    "scraped_at": scraped_at
                })
                seen_company_ids.add(company_id)

            # Simpan lokasi jika belum pernah ditemukan
            if location_id not in seen_location_ids:
                location.append({
                    "location_id": location_id,
                    "city": city,
                    "country": country,
                    "scraped_at": scraped_at
                })
                seen_location_ids.add(location_id)

            # Simpan function jika belum pernah ditemukan
            if function_id not in seen_function_ids:
                function.append({
                    "function_id": function_id,
                    "function_name": function_name,
                    "scraped_at": scraped_at
                })
                seen_function_ids.add(function_id)

            # Simpan compensation package jika belum pernah ditemukan
            if compensation_id not in seen_compensation_ids:
                compensation_package.append({
                    "compensation_id": compensation_id,
                    "min_salary": compensation_pkg['min_salary'],
                    "max_salary": compensation_pkg['max_salary'],
                    "currency": compensation_pkg['currency'],
                    "with_equity": compensation_pkg['with_equity'],
                    "scraped_at": scraped_at
                })
                seen_compensation_ids.add(compensation_id)

            # Simpan setiap industry (bisa lebih dari satu per job)
            for name in industry_names:
                ind_id = get_hashed_id(name, prefix="ind")

                # Simpan industry jika belum pernah ditemukan
                if ind_id not in seen_industry_ids:
                    industry.append({
                        "industry_id": ind_id,
                        "industry_name": name,
                        "scraped_at": scraped_at
                    })
                    seen_industry_ids.add(ind_id)

                # Simpan relasi company ↔ industry jika belum ada
                pair_key = f"{company_id}_{ind_id}"
                if pair_key not in seen_company_industry_pairs:
                    company_industry.append({
                        "company_id": company_id,
                        "industry_id": ind_id,
                    })
                    seen_company_industry_pairs.add(pair_key)

            # Simpan data job yang ditemukan
            jobs.append({
                "job_id": job_id,
                "title": title,
                "job_type": job_type,
                "link": link,
                "company_id": company_id,
                "function_id": function_id,
                "location_id": location_id,
                "compensation_id": compensation_id,
                "posted_date": posted_date,
                "scraped_at": scraped_at
            })
        # Notice error agar scraping tetap lanjut meski ada satu job error
        except Exception as e:
            print("Error scraping one job:", e)

    # Kalau tidak ada job baru, break scrolling
    if not new_job_found:
        print(f"Scroll ke-{scroll_round+1}: Tidak ada job baru ditemukan. Berhenti.")
        break

# ----------------------------
# Save ke dalam bentuk json
# ----------------------------
# Buat folder berdasarkan tanggal hari ini
today_str = datetime.now().strftime("%Y-%m-%d")
output_dir = os.path.join("Seleksi-2025-Tugas-1", "Data Scraping", "data", today_str)
os.makedirs(output_dir, exist_ok=True)

# Mapping nama file ke data
json_files = {
    "jobs.json": jobs,
    "companies.json": company,
    "functions.json": function,
    "industries.json": industry,
    "locations.json": location,
    "compensation_packages.json": compensation_package,
    "company_industries.json": company_industry
}

# Simpan setiap file JSON
for filename, data in json_files.items():
    filepath = os.path.join(output_dir, filename)
    with open(filepath, "w", encoding="utf-8") as f:
        json.dump(data, f, ensure_ascii=False, indent=2)

print(f"Scraped {len(jobs)} job.")
print("✅ JSON files saved to:", output_dir)

# ----------------------------
# Cleanup
# ----------------------------
driver.quit() # Tutup browser selenium
