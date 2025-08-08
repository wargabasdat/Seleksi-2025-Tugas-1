# Seleksi Warga Basdat 2025 Tahap 2
# Topik: Buah di Blox Fruit

### Deskripsi Data

Pada tahap kedua Seleksi Warga Basdat 2025, saya memili topik mengenai buah di permainan Blox Fruits yang dapat diakses melalui wiki fandom Blox Fruits. Data yang dikumpulkan mencakup informasi penting dari stok toko, buah, senjata, kekuatan, dan update dari wiki fandom Blox Fruits. Data buah dilengkapi dengan permintaan dan nilai tukar buah yang didapat dari website eksternal. Proses pengumpulan data dilakukan dengan metode web scraping dan web crawling. 

Saya memilih topik ini karena konten yang sering berubah dan inkonsistensi pada website yang cukup menantang namun saya memiliki pemahaman yang baik tentang sistem kekuatan di Blox Fruits

---
### Step 1: Data Scraping

#### Technologies Used
- PostgreSQL
- Python Scrapy
- VSCode

#### Menjalankan Program
1. **Aktifkan venv dan instal semua library Python yang dibutuhkan**
- Buat virtual environment (jika belum ada):
```bash
python -m venv .venv
```
- Aktifkan virtual environment
```bash
.venv\Scripts\activate # windows
source .venv/bin/activate # linux/macOS
```
- Instal dependensi
```bash
pip install -r requirements.txt
```
2. **Siapkan database PostgreSQL. Gunakan skema di Data Storing/export/schema.sql untuk membuat semua tabel yang dibutuhkan**
3. **Pergi ke direktori Data Scraping/, lalu jalankan perintah berikut**
```bash
cd 'Data Scraping'
python src/run_scrapy_pipeline.py
```
**Setelah selesai, data akan tersimpan di dalam folder Data Scraping/src/data**


4. **Jalankan perintah untuk Data Storing**
```bash
cd '../Data Storing'
python src/store_data.py
```

#### Struktur JSON
1. fruit_stock.json
stock_event_uid: id stok, timestamp: waktu scraping, stock_start_time: waktu mulai stok,  fruit_name: nama buah yg stok, price: harga buah yg stok
2. fruit_values.json
4. fruits.json
5. guns.json
6. swords.json
7. update_logs.json
   
### Step 2: Data Modeling + Data Storing
#### Struktur ERD
![ERD Database](Data%20Storing/design/ER_Diagram.png)

#### Translasi Struktur ERD ke Diagram Relasional RDBMS
![Relational Diagram Database](Data%20Storing/design/Relational_Diagram.png)
Setiap entitas pada ERD dapat ditranslasikan menjadi tabel di Relational Diagram. Tidak ada tabel tambahan karena tidak ada many-to-many relationship. ERD ditranslasikan menjadi diagram relasional sesuai aturan translasi, seperti menambahkan FK pada sisi entitas yang berpartisipasi total pada relasi, menggunakan PK komposit untuk weak entity, dan cukup mencantumkan PK dan atribut tambahan tanpa atribut turunan untuk entitas turunan
#### Hasil Program
![ability](Data%20Storing/screenshot/ability.png)
![ability](Data%20Storing/screenshot/fruit.png)
![ability](Data%20Storing/screenshot/gun.png)
![ability](Data%20Storing/screenshot/stock_item.png)

### Author
- Ahmad Syafiq - 13523135
