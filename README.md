# ETL Project: Database Spesifikasi CPU - Seleksi Asisten Lab Basis Data 2025

Repositori ini berisi proyek ETL (Extract, Transform, Load) submisi Tahap 2 Seleksi Asisten Laboratorium Basis Data. Proyek ini mencakup proses *data scraping*, pemodelan database, penyimpanan data ke dalam RDBMS, serta implementasi *data warehouse*.

## 👨‍💻 a. Author

- **Nama**: Farrel Athalla Putra
- **NIM**: 13523118

## 📂 b. Deskripsi Proyek

### 📊 Data dan Topik
Proyek ini mengambil data spesifikasi teknis prosesor (CPU) komputer dari **TechPowerUp CPU Specs Database**. Topik ini dipilih karena beberapa alasan:
* **Data Terstruktur**: Data spesifikasi CPU sangat banyak dan terstruktur, sehingga data cocok untuk pemodelan database relasional.
* **Kombinasi Tipe Data**: Terdapat data kuantitatif (misalnya, `cores`, `TDP`, `harga`) dan kualitatif (misalnya, `socket`, `codename`, `features`), yang cocok untuk implementasi RDBMS dan Data Warehouse.
* **Tantangan Preprocessing**: Data mentah seperti tanggal rilis dan daftar fitur memerlukan proses *cleaning* dan transformasi sebelum siap disimpan, sehingga menambah tantangan dalam proses ini.

### 🗄️ DBMS yang Digunakan
Database Management System (DBMS) yang digunakan adalah **MySQL** (atau MariaDB).

## 💻 c. Cara Penggunaan

Proyek ini terdiri dari beberapa skrip utama yang harus dijalankan secara berurutan.

### 1. Prasyarat
Pastikan memiliki Python 3.x dan `pip` terinstal. Kemudian, instal semua *library* yang dibutuhkan dengan menjalankan:
```bash
pip install requests beautifulsoup4 mysql-connector-python
```

### 2. Menjalankan Scraper
Skrip ini akan mengambil semua data dari website per kategori dalam file JSON. Metode ini dilakukan karena website yang rentan terhadap rate limit.
```bash
cd "Data Scraping/src"
python scrap.py
```

### 3. Menggabungkan Data Scrape
Selanjutnya, kita gabungkan data yang telah di scrape menjadi satu file JSON.
```bash
python combine.py
```

### 4. Melakukan preprocessing pada data
Masih terdapat beberapa format data yang belum sesuai dengan SQL. Maka dari itu, dilakukan penyesuaian tipe data.
```bash
python preprocess.py
```

### 5. Load Databases
Pastikan sudah menyesuaikan konfigurasi database (user, password, nama database) di dalam skrip ```load_database.py``` dan ```load_warehouse.py```.
#### Load dan Fill data Database
```bash
cd "Data Storing/src"
python load_database.py
```
#### Load dan Fill data Warehouse
```bash
cd "Data Warehouse/src"
python load_warehouse.py
```

## 🗂️ d. Penjelasan Struktur File JSON
File JSON hasil scraping memiliki struktur sebagai berikut:
```bash
{
  "name": "Intel Core i7-13700K",
  "manufacturer": "Intel",
  "socket": "LGA1700",
  "codename": "Raptor Lake",
  "generation": "13th Gen",
  "release_date": "2022-10-20",
  "cores": 16,
  "threads": 24,
  "frequency_ghz": 3.4,
  "turbo_clock_ghz": 5.4,
  "cache_l1_kb": 1280,
  "cache_l2_kb": 24576,
  "cache_l3_mb": 30,
  "tdp_watts": 125,
  "launch_price_usd": 409,
  "process_size_nm": 10,
  "multiplier_unlocked": true,
  "integrated_graphics": "Intel UHD Graphics 770",
  "memory_support": "DDR5-5600",
  "features": ["Intel Turbo Boost", "Hyper-Threading", "AES-NI"]
}
```
| **Nama**                   | **Keterangan**                                                |
|----------------------------|---------------------------------------------------------------|
| **name**                    | Nama lengkap CPU                                              |
| **manufacturer**            | Produsen CPU (Intel/AMD/Other)                                |
| **socket**                  | Jenis socket motherboard                                      |
| **codename**                | Nama kode arsitektur                                          |
| **generation**              | Generasi CPU                                                  |
| **release_date**            | Tanggal peluncuran (format: YYYY-MM-DD)                       |
| **cores/threads**           | Jumlah core dan thread                                        |
| **frequency_ghz/turbo_clock_ghz** | Kecepatan base dan turbo (GHz)                              |
| **cache_l1_kb/l2_kb/l3_mb**| Ukuran cache berbagai level                                   |
| **tdp_watts**               | Thermal Design Power                                          |
| **launch_price_usd**        | Harga peluncuran dalam USD                                    |
| **process_size_nm**         | Ukuran proses manufaktur (nanometer)                          |
| **multiplier_unlocked**     | Status overclocking                                           |
| **integrated_graphics**     | GPU terintegrasi                                               |
| **memory_support**          | Jenis memori yang didukung                                    |
| **features**                | Array fitur-fitur khusus                                      |

## 🖼️ e. Struktur ERD dan Diagram Relasional
### 🧑‍💻 Entity-Relationship Diagram (ERD)
#### Database
<img width="753" height="718" alt="ERD CPU" src="https://github.com/user-attachments/assets/4f8e0201-1a69-454c-83bf-d415b7f61bc6" />

#### Warehouse
<img width="877" height="622" alt="ERD CPU WAREHOUSE" src="https://github.com/user-attachments/assets/09322663-9425-4b57-b3e3-35d07fbb10d8" />

### 🔧 Diagram Relasional
#### Database
<img width="735" height="487" alt="RELATIONAL CPU2" src="https://github.com/user-attachments/assets/921c6e3f-37b5-4b15-943d-ce30109172a0" />

#### Warehouse
<img width="875" height="526" alt="RELATIONAL CPU WAREHOUSE" src="https://github.com/user-attachments/assets/9185a54c-1e37-416a-91b8-422b669aadc4" />

## 🔄 f. Proses Translasi ERD menjadi Diagram Relasional
Proses translasi dari ERD ke diagram relasional mengikuti langkah-langkah berikut:
- Setiap entity di ERD (misalnya, PROCESSOR, MANUFACTURER) diubah menjadi sebuah tabel di dalam database.
- Setiap atribut dari sebuah entiys (misalnya, name, cores) menjadi sebuah kolom di dalam tabel, dengan tipe data yang sesuai (misalnya, VARCHAR, INT).
- Atribut unik dari setiap entitas (misalnya, processor_id) dijadikan Primary Key (PK) pada tabelnya untuk memastikan setiap baris data bersifat unik.
- Hubungan menjadi Foreign Key:
  - Hubungan One-to-Many: Untuk hubungan seperti MANUFACTURER dan PROCESSOR, Primary Key dari sisi "one" (manufacturer_id) ditambahkan sebagai Foreign Key (FK) ke dalam tabel di sisi "many" (processors).
  - Hubungan Many-to-Many: Untuk hubungan seperti PROCESSORS dan FEATURES (satu prosesor punya banyak fitur, satu fitur ada di banyak prosesor), sebuah tabel penghubung (juga disebut junction table) baru dibuat, yaitu processor_features. Tabel ini hanya berisi dua kolom: Foreign Key yang menunjuk ke PK processors (processor_id) dan Foreign Key yang menunjuk ke PK features (feature_id).

## 📸 g. Screenshot Program
## Data Storing
![Query 1 Screenshot](https://github.com/farrelathalla/Seleksi-2025-Tugas-1/blob/main/Data%20Storing/screenshot/Query%201.png)
![Query 2 Screenshot](https://github.com/farrelathalla/Seleksi-2025-Tugas-1/blob/main/Data%20Storing/screenshot/Query%202.png)
![Query 3 Screenshot](https://github.com/farrelathalla/Seleksi-2025-Tugas-1/blob/main/Data%20Storing/screenshot/Query%203.png)
![Query 4 Screenshot](https://github.com/farrelathalla/Seleksi-2025-Tugas-1/blob/main/Data%20Storing/screenshot/Query%204.png)
![Query 5 Screenshot](https://github.com/farrelathalla/Seleksi-2025-Tugas-1/blob/main/Data%20Storing/screenshot/Query%205.png)

## Data Warehouse
![Query 1 Screenshot](https://github.com/farrelathalla/Seleksi-2025-Tugas-1/blob/main/Data%20Warehouse/screenshot/Query%201.png)
![Query 2 Screenshot](https://github.com/farrelathalla/Seleksi-2025-Tugas-1/blob/main/Data%20Warehouse/screenshot/Query%202.png)
![Query 3 Screenshot](https://github.com/farrelathalla/Seleksi-2025-Tugas-1/blob/main/Data%20Warehouse/screenshot/Query%203.png)
![Query 4 Screenshot](https://github.com/farrelathalla/Seleksi-2025-Tugas-1/blob/main/Data%20Warehouse/screenshot/Query%204.png)
![Query 5 Screenshot](https://github.com/farrelathalla/Seleksi-2025-Tugas-1/blob/main/Data%20Warehouse/screenshot/Query%205.png)

## 📚 h. Referensi
🌐 Sumber Data:
TechPowerUp CPU Specs Database: https://www.techpowerup.com/cpu-specs/

📦 Library Python yang Digunakan:
requests: Untuk melakukan permintaan HTTP ke website.

beautifulsoup4: Untuk mem-parsing dokumen HTML.

mysql-connector-python: Untuk menghubungkan dan berinteraksi dengan database MySQL.
