# TUGAS_SELEKSI_1_[NIM]

## Author
- **Nama**: Amudi Marchel Purba
- **NIM**: 18223049

---

## 📌 Deskripsi Singkat

Proyek ini merupakan implementasi dari **ETL Project** (Extract, Transform, Load) dalam rangka **Seleksi Tahap 2 Asisten Basis Data 2025**.  
Topik yang saya pilih mencakup topik terkait **"Daftar Gunung Tertinggi di Dunia"** dengan sumber data berasal dari:  
- Wikipedia: [List of Highest Mountains on Earth](https://en.wikipedia.org/wiki/List_of_highest_mountains_on_Earth)

Data yang diambil mencakup informasi seperti:
- **Nama Gunung**
- **Peringkat Ketinggian**
- **Ketinggian dalam meter**
- **Koordinat (Lintang & Bujur)**
- **Nama Pegunungan**
- **Negara tempat gunung berada**

Topik ini sangat cocok untuk tahap awal pengembangan analis data. Adapun fokus dari tugas saya ini adalah untuk mempersiapkan data yang dapat diolah untuk analisis geografis dengan distribusi per negara dan cluster lokasi.

DBMS yang digunakan: **PostgreSQL**  

**Alasan pemilihan topik**:
- Memiliki struktur data yang kaya relasi (M:N, 1:N) sehingga cocok untuk latihan desain ERD dan implementasi RDBMS.
- Data bersifat publik, mudah diakses, dan beragam sehingga bisa diuji dengan berbagai query SQL.
- Cocok untuk pembelajaran query lanjutan seperti `JOIN`, `GROUP BY`.
- Tema yang masih relevan dengan saya, sehingga bisa lebih mudah dalam memahami saat proses pengerjaan.
---

## Cara Menggunakan Scraper

1. **Instalasi Library yang Dibutuhkan**
    pip install requests beautifulsoup4 psycopg2

2. **Jalankan Script Scraper**
    cd "Data Scraping/src"
    python topgunung_scrap.py
    Script ini akan menghasilkan file JSON pada folder "Data Storing/data":
    a. daftar_gunung.json
    b. daftar_negara.json
    c. daftar_pegunungan.json
    d. log_preprocessing.txt 

## Struktur File JSON yang Dihasilkan
- **`daftar_gunung.json`**:
  - Array objek dengan atribut: `id`, `peringkat`, `nama`, `ketinggian_m`, `lintang`, `bujur`, `id_pegunungan`, `id_negara`.
- **`daftar_negara.json`**:
  - Array objek dengan atribut: `id`, `nama`.
- **`daftar_pegunungan.json`**:
  - Array objek dengan atribut: `id`, `nama`, `jumlah_gunung`.

Contoh:
    {
        "id": 1,
        "peringkat": "1",
        "nama": "Everest",
        "ketinggian_m": 8848,
        "lintang": 27.9881,
        "bujur": 86.9250,
        "id_pegunungan": 1,
        "id_negara": [1, 2]
    }

## Struktur ERD dan Diagram Relasional RDBMS
**ERD**
Entitas:

- Pegunungan (id_pegunungan, nama, jumlah_gunung)
- Gunung (id_gunung, peringkat, nama_gunung, ketinggian_m, lintang, bujur, id_pegunungan)
- Negara (id_negara, nama_negara)
- Region (id_region, nama_wilayah)
- Pendakian (id_pendakian, tahun, nama_tim, jalur)
- Iklim (id_iklim, deskripsi, kecepatan_angin, suhu_terendah)
- Kategori (nama_kategori)

Kategori adalah weak entity yang bergantung pada Gunung.

Relasi:
- Pegunungan has Gunung (1:N)
- Negara belongs to Country (N:1)
- Gunung has climate Iklim (N:N)
- Gunung located in Negara (N:N)
- Gunung classified as Kategori (N:N)
- Gunung has expedition Pendakian (1:N)

**Diagram Relasional**
- Iklim (id_iklim, deskripsi, kecepatan_angin, suhu_terendah)
- Pendakian (id_pendakian, id_gunung, tahun, nama_tim, jalur)
- Pegunungan (id_pegunungan, nama, jumlah_gunung)
- Iklim Gunung (id_iklim, id_gunung)
- Gunung (id_gunung, peringkat, nama_gunung, ketinggian_m, lintang, bujur, id_pegunungan)
- Kategori (id_gunung, nama_kategori)
- Region (id_region, nama_wilayah)
- Negara (id_negara, id_region, nama_negara)
- Lokasi Gunung (id_negara, id_gunung)

## Translasi ERD ke Diagram Relasional
Tahap diawali dengan membuat semua entitas menjadi tabel dengan atribut nya masing-masing. Setiap relasi 1:N akan dihubungkan dengan foreign key merujuk ke primary key di tabel lain. Sedangkan relasi N:N akan mengakibatkan muncul tabel baru dengan atribut foreign key merujuk ke masing-masing primary key.

- Entitas Gunung → tabel gunung (PK: id_gunung)
- Entitas Negara → tabel negara (PK: id_negara)
- Relasi located in (many-to-many) → (PK: id_negara, id_gunung)
- Entitas Kategori → tabel kategori (PK: id_gunung, nama_kategori)
- Entitas Iklim → tabel iklim (PK: id_iklim)
- Relasi has climate → tabel iklim gunung (PK: id_iklim, id_gunung)
- Entitas Pendakian → tabel pendakian (PK: id_pendakian)
- Entitas Region → tabel region (PK: id_region)
- Entitas Pegunungan → tabel pegunungan (PK: id_pegunungan)

## Screenshots Program

### 1. Scraper Berjalan
[Scraper Berjalan](/Data%20Storing/screenshot/scraping.png)

### 2. Hasil Insert di PostgreSQL
[Hasil Insert](/Data%20Storing/screenshot/storing.png)

### 3. Query Data di PostgreSQL
![Query Data](/Data%20Storing/screenshot/query.png)

## Referensi

**Library**
- `requests` HTTP request
- `beautifulsoup4` parsing HTML
- `json` menyimpan data ke JSON
- `time` delay antar request
- `os` manajemen folder & file
- `re` pencocokan dan pemrosesan pola teks
- `psycopg2` koneksi dan eksekusi query pada PostgreSQL

**Web**
- Wikipedia: [List of Highest Mountains on Earth](https://en.wikipedia.org/wiki/List_of_highest_mountains_on_Earth)