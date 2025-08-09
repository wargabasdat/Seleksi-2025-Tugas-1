# MotoGP Race Winners ETL Project

<h1 align="center">
  <br>
  Seleksi Warga Basdat 2025 <br>
  MotoGP Race Winners ETL Project
  <br>
  <br>
</h1>

## Author

**Nama:** Alvin Christopher Santausa  
**NIM:** 13523033  
**Email:** 13523033@std.stei.itb.ac.id

## Deskripsi Project

### Topik dan Motivasi

Project ini mengimplementasikan sistem ETL (Extract, Transform, Load) lengkap untuk data pemenang balapan MotoGP/500cc dari Wikipedia. Saya memilih topik MotoGP karena:

1. **Data yang kaya dan terstruktur**: MotoGP memiliki sejarah panjang dengan data statistik yang komprehensif
2. **Relevansi olahraga**: Sebagai salah satu ajang balap motor paling prestigious di dunia
3. **Kompleksitas data**: Melibatkan berbagai entitas seperti pembalap, negara, konstruktor, dan tim yang memungkinkan desain database yang menarik
4. **Potensi analisis**: Data historis yang memungkinkan analisis tren, performa pembalap, dan dominasi negara tertentu

### DBMS yang Digunakan

- **Database Utama**: MariaDB/MySQL untuk penyimpanan data operasional
- **Data Warehouse**: MariaDB/MySQL dengan skema star schema untuk keperluan analitik
- **Alasan pemilihan**: Kompatibilitas tinggi, performa baik, dan mudah diintegrasikan dengan Python

## Cara Menggunakan

### 1. Data Scraping

```bash
cd "Data Scraping/src"
python main.py
```

**Output yang dihasilkan:**

- `../data/motogp_riders.csv`: Data pembalap dalam format CSV
- `../data/motogp_riders.json`: Data pembalap dalam format JSON
- `../data/motogp_countries.csv`: Data statistik per negara
- `../data/motogp_countries.json`: Data statistik per negara dalam JSON

### 2. Database Setup dan Data Loading

```bash
cd "Data Storing/src"
# Setup database schema
mysql -u root -p < schema.sql

# Load data ke database
python insert_data.py
```

### 3. Data Warehouse ETL

```bash
cd "Data Warehouse/src"
# Manual ETL execution
python processing.py

# Automated scheduling (runs ETL daily at 02:00)
python scheduler.py
```

## Struktur File JSON

### motogp_riders.json

```json
[
  {
    "rank": "1",
    "country_code": "ITA",
    "country_name": "Italy",
    "rider_name": "Giacomo Agostini",
    "rider_link": "https://en.wikipedia.org/wiki/Giacomo_Agostini",
    "wins": 68,
    "seasons_active": "1965–1977",
    "first_win": "1965",
    "last_win": "1976",
    "is_champion": true,
    "is_active_2025": false,
    "row_index": 1
  }
]
```

**Penjelasan field:**

- `rank`: Peringkat pembalap berdasarkan jumlah kemenangan
- `country_code`: Kode negara (3 huruf)
- `country_name`: Nama lengkap negara
- `rider_name`: Nama lengkap pembalap
- `rider_link`: Link Wikipedia pembalap
- `wins`: Jumlah total kemenangan
- `seasons_active`: Periode aktif pembalap
- `first_win`: Tahun kemenangan pertama
- `last_win`: Tahun kemenangan terakhir
- `is_champion`: Apakah pernah menjadi juara dunia
- `is_active_2025`: Status aktif di musim 2025
- `row_index`: Index urutan data

### motogp_countries.json

```json
[
  {
    "rank": "1",
    "country": "Italy",
    "total_wins": 347,
    "number_of_riders": 52
  }
]
```

## Struktur Database

### ERD (Entity Relationship Diagram)

![ERD Data Storing](Data%20Storing/design/ERD.png)

**Entitas utama:**

1. **pembalap**: Data utama pembalap
2. **negara**: Data negara asal pembalap
3. **konstruktor**: Pabrikan motor (Honda, Yamaha, Ducati, dll)
4. **tim**: Tim balap
5. **sponsor**: Sponsor tim/pembalap
6. **balapan**: Data balapan dan pemenang

### Diagram Relasional

![Relational Model Data Storing](Data%20Storing/design/relational-model.png)

**Tabel utama:**

- `pembalap` (PK: id_pembalap, FK: id_negara)
- `negara` (PK: id_negara)
- `konstruktor` (PK: id_konstruktor)
- `tim` (PK: id_tim, FK: id_konstruktor)
- `sponsor` (PK: id_sponsor)
- `balapan` (PK: id_balapan, FK: id_pembalap_pemenang)
- `pembalap_tim` (Many-to-many relationship)
- `tim_sponsor` (Many-to-many relationship)

## Data Warehouse

### Fact and Dimension Tables

![Fact Table Design](Data%20Warehouse/design/fact%20table.png)

**Skema Star Schema:**

- **Fact Table**: `fact_kemenangan_pembalap`
- **Dimension Tables**:
  - `dim_pembalap`
  - `dim_negara`
  - `dim_waktu`
  - `dim_status_pembalap`

## Proses Translasi ERD ke Diagram Relasional

### 1. Mapping Entitas

- Setiap entitas dalam ERD menjadi tabel dalam diagram relasional
- Atribut entitas menjadi kolom tabel
- Key attributes menjadi primary key
- Lalu juga beberapa relasi ada yang menjadi tabel seperti relasi memenangi, bekerja-sama dll

### 2. Data Warehouse Design

- **Dimensional Modeling**: Menggunakan star schema
- **Fact Table**: Menyimpan metrics (total_kemenangan, win_rate) (karena berfokus pada kemenangan pembalap)
- **Dimension Tables**: Menyimpan descriptive attributes
- **Surrogate Keys**: Auto-increment keys untuk dimension tables

## Automated Scheduling

### Sistem Scheduling

Project ini mengimplementasikan automated scheduling untuk proses ETL menggunakan Python `schedule` library.

**File:** `Data Warehouse/src/scheduler.py`

### Fitur Scheduling:

1. **Daily ETL Execution**: Berjalan setiap hari pukul 02:00
2. **Batch Tracking**: Mencegah redundansi data dengan tracking batch_date
3. **Comprehensive Logging**: Log semua aktivitas untuk monitoring
4. **Error Handling**: Graceful error handling dan recovery
5. **Data Validation**: Quality checks setelah ETL

### Konfigurasi Scheduling:

```python
# Daily execution at 02:00
schedule.every().day.at("02:00").do(run_etl_job)

# Optional: Weekly cleanup at Sunday 03:00
schedule.every().sunday.at("03:00").do(cleanup_old_logs)
```

### Service Management:

```bash
# Start scheduling service
cd "Data Warehouse"
chmod +x etl-service.sh
./etl-service.sh start

# Stop service
./etl-service.sh stop

# Check status
./etl-service.sh status
```

### Batch Tracking System:

- Menggunakan `batch_date` untuk tracking eksekusi harian
- Prevents data duplication pada re-run
- Maintains data lineage dan audit trail

## Screenshots Program

### Data Scraping Results

### Beberapa Database Operations

![Database Query Results](Data%20Storing/screenshot/daftar_semua_pembalap.png)
![Ducati Riders Query](Data%20Storing/screenshot/pembalap_yang_membalap_dengan_konstruktor_ducati.png)

### Beberapa Data Warehouse Analytics

![Top 10 Winners Analysis](Data%20Warehouse/screenshot/Top%2010%20pembalap%20dengan%20kemenangan%20terbanyak.png)
![Country Analysis](Data%20Warehouse/screenshot/Analisis%20kemenangan%20tiap%20negara.png)
![Decade Trends](Data%20Warehouse/screenshot/Tren%20kemenangan%20tiap%20dekade.png)

## Referensi

### Libraries yang Digunakan

- **requests**
- **beautifulsoup4**
- **pandas**
- **mysql-connector-python**
- **faker**
- **schedule**

### Sumber Data

- **Primary Source**: [List of 500cc/MotoGP race winners - Wikipedia](https://en.wikipedia.org/wiki/List_of_500cc/MotoGP_race_winners)
- **Additional Reference**: [MotoGP Official Website](https://www.motogp.com/)

### Tools dan Platform

- **Database**: MariaDB/MySQL
- **Programming Language**: Python 3.9+

### Dependencies

```
requests>=2.28.0
beautifulsoup4>=4.11.0
pandas>=1.5.0
mysql-connector-python>=8.0.0
faker>=19.0.0
schedule>=1.2.0
```

---

**Note**: Project ini dibuat sebagai bagian dari Seleksi Asisten Lab Basis Data 2025, Institut Teknologi Bandung.
