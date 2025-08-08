# Proyek ETL Seleksi Warga Basdat 2025

## Author

- **Nama:** Mochamad Ikhbar Adiwinangun
- **NIM:** 18223050

## Deskripsi Proyek

### Topik
Topik yang saya pilih adalah pengumpulan data game dari situs web yang menyediakan informasi tentang game ps 2, termasuk judul, genre, dan ranking dari game tersebut.
Tidak ada alasan khusus mengapa saya memilih topik ini, hanya karena saya tertarik dengan game ps 2 dan ingin belajar lebih banyak tentang pengumpulan data.

### DBMS
saya menggunakan PostgreSQL sebagai DBMS untuk menyimpan data yang telah di-scrape. PostgreSQL dipilih karena kemampuannya dalam menangani data relasional dan dukungan yang baik untuk operasi analitik.

## 1. Data Scraping

### Cara Menjalankan Scraper
Untuk menjalankan scraper, pastikan telah menginstal semua dependensi yang diperlukan. Dapat menggunakan `pip` untuk menginstal library yang diperlukan. Pastikan juga buat file baru ".env"  yang berisikan kredensial dari koneksi database yang ingin digunakan. Berikut adalah langkah-langkah untuk menjalankan scraper:

**Contoh:**
```bash
# Contoh perintah untuk menjalankan scraper
python "Data Scraping/src/scraper.py"
```

### Struktur Output JSON
Setelah menjalankan scraper, data akan disimpan dalam format JSON. Berikut adalah contoh struktur data yang dihasilkan

**Contoh Struktur:**
```json
[
  {
    "rank": "XX",
    "title": "Nama game",
    "genre": ["Genre1", "Genre2"]
  }
]
```

### Halaman Web yang di-Scrape
- **URL:** [https://gamebrott.com/100-game-ps2-terbaik-di-dunia/](https://gamebrott.com/100-game-ps2-terbaik-di-dunia/)

## 2. Data Storing

### Desain Database

#### Entity-Relationship Diagram (ERD)

![ERD](<Data Storing/design/ERD diagram.png>)

terdapat beberapa tabel relevan yang ditambahkan dari data asli hasil scraping, seperti tabel `users`, `user_game_library`, `developers`, `publishers`, dan `regions`. Tabel-tabel ini ditambahkan untuk memberikan konteks yang lebih luas terhadap data game yang di-scrape, memungkinkan analisis yang lebih mendalam terhadap hubungan antara pengguna, game, genre, developer, publisher, dan wilayah rilis (tabel tambahan merupakan tabel kosong tanpa data dummy)

##### Rasionalisasi ERD

1. Hubungan users dan user_game_library
   - **Tipe Hubungan**: One-to-Many (1:N)
   - **Rasionalisasi**: Satu pengguna dapat memiliki banyak game dalam perpustakaan mereka, tetapi setiap game hanya dimiliki oleh satu pengguna.

2. Hubungan user_game_library dan games
   - **Tipe Hubungan**: Many-to-One (N:1)
    - **Rasionalisasi**: Banyak entri dalam perpustakaan pengguna dapat merujuk ke satu game yang sama. Ini memungkinkan pengguna untuk memiliki beberapa entri untuk game yang sama (misalnya, jika mereka memiliki versi berbeda).

3. Hubungan games dan game_genres
   - **Tipe Hubungan**: Many-to-Many (N:M)
   - **Rasionalisasi**: Satu game dapat memiliki beberapa genre, dan satu genre dapat mencakup banyak game. Ini memerlukan tabel penghubung `game_genres` untuk mengelola hubungan ini.

4. Hubungan games dan developers
   - **Tipe Hubungan**: Many-to-Many (N:M)
   - **Rasionalisasi**: Satu game dapat memiliki satu developer, dan satu developer dapat memiliki banyak game

5. Hubungan games dan publishers
   - **Tipe Hubungan**: Many-to-Many (N:M)
   - **Rasionalisasi**: Satu game dapat memiliki satu publisher, dan satu publisher dapat memiliki banyak game

6. Hubungan games dan genres
   - **Tipe Hubungan**: Many-to-Many (N:M)
   - **Rasionalisasi**: Satu game dapat memiliki beberapa genre, dan satu genre dapat mencakup banyak game.

7. Hubungan games dan regional_releases
   - **Tipe Hubungan**: Many-to-Ones (N:1)
   - **Rasionalisasi**: Satu game dapat dirilis di beberapa wilayah, tetapi setiap releases_id hanya terkait dengan satu game.

8. regional_releases dan regions
   - **Tipe Hubungan**: Many-to-One (N:1)
   - **Rasionalisasi**: Banyak rilis regional dapat terkait dengan satu wilayah tertentu. Ini memungkinkan kita untuk mengelompokkan rilis berdasarkan wilayah geografis.

#### Model Relasional

![Model Relasional](<Data Storing/design/Relational Model.png>)

### Proses Translasi ERD ke Model Relasional
Setelah merancang ERD, langkah selanjutnya adalah mentranslasi ERD ke dalam model relasional. Proses ini melibatkan pembuatan tabel-tabel yang sesuai dengan entitas dan hubungan yang telah diidentifikasi dalam ERD. 
Berikut adalah langkah-langkah untuk mentranslasi ERD ke model relasional:
1. **Identifikasi Entitas**: Setiap entitas dalam ERD akan menjadi tabel dalam model relasional. Misalnya, entitas `users`, `games`, `genres`, dll.
2. **Definisikan Atribut**: Setiap atribut dari entitas akan menjadi kolom dalam tabel. Misalnya, atribut `username`, `email` untuk tabel `users`.
3. **Tentukan Kunci Utama**: Setiap tabel harus memiliki kunci utama yang unik untuk mengidentifikasi setiap baris. Misalnya, `user_id` untuk tabel `users`, `game_id` untuk tabel `games`, dll.
4. **Definisikan Kunci Asing**: Untuk hubungan antar tabel, tentukan kunci asing yang menghubungkan tabel-tabel tersebut. Misalnya, `user_id` dalam tabel `user_game_library` yang merujuk ke `user_id` dalam tabel `users`.
5. **Terapkan Normalisasi**:
   - Pastikan tabel-tabel telah dinormalisasi untuk menghindari redundansi data.
   - Pastikan setiap tabel memiliki atribut yang relevan dan tidak ada atribut yang berulang
6. **Buat Tabel Penghubung untuk Hubungan Many-to-Many**: Untuk hubungan many-to-many, buat tabel penghubung yang menghubungkan kedua entitas. Misalnya, tabel `game_genres` untuk menghubungkan `games` dan `genres`.


### Bukti Implementasi

![Bukti Penyimpanan Data](<Data Storing/screenshot/bukti_DBMS_2.png>)

## 3. Data Warehouse (Bonus)

### Desain Star Schema
![star schem](<Data Warehouse/design/star scheme.png>)

### Contoh Query Analitik

```sql
-- Query 1: Menghitung jumlah game untuk setiap genre
SELECT
    dg.genre_name,
    COUNT(fgr.game_key) AS total_games
FROM
    FactGameRank fgr
JOIN
    DimGenre dg ON fgr.genre_key = dg.genre_key
GROUP BY
    dg.genre_name
ORDER BY
    total_games DESC;
```
![q1](<Data Warehouse/src/q1.png>)

```sql
-- Query 2: Menampilkan 10 genre dengan game terbanyak
SELECT
    dg.genre_name,
    COUNT(fgr.game_key) AS total_games
FROM
    FactGameRank fgr
JOIN
    DimGenre dg ON fgr.genre_key = dg.genre_key
GROUP BY
    dg.genre_name
ORDER BY
    total_games DESC
LIMIT 10;
```
![q2](<Data Warehouse/src/q2.png>)

```sql
-- Query 3: Mencari rata-rata peringkat (rank) untuk game bergenre 'RPG'
SELECT
    AVG(fgr.rank) AS average_rank_for_rpg
FROM
    FactGameRank fgr
JOIN
    DimGenre dg ON fgr.genre_key = dg.genre_key
WHERE
    dg.genre_name = 'RPG';

```
![q3](<Data Warehouse/src/q3.png>)

```sql
-- Query 4: Menampilkan semua game yang memiliki genre 'Action'
SELECT
    dga.title,
    fgr.rank
FROM
    FactGameRank fgr
JOIN
    DimGame dga ON fgr.game_key = dga.game_key
JOIN
    DimGenre dge ON fgr.genre_key = dge.genre_key
WHERE
    dge.genre_name = 'Action'
ORDER BY
    fgr.rank ASC;
```
![q4](<Data Warehouse/src/q4.png>)

## 4. Orkestrasi dan Penjadwalan Pipeline

Untuk mengotomatiskan keseluruhan proses ETL (Extract, Transform, Load) dari awal hingga akhir, sebuah skrip orkestrasi telah dibuat untuk memastikan data berjalan mulus dari sumber hingga ke data warehouse.

### Skrip Orkestrator (`pipeline.py`)
- **Lokasi**: `AutoScheduler/pipeline.py`
- **Deskripsi**: Skrip ini berfungsi sebagai "master" yang mengatur alur kerja. Ia akan menjalankan setiap langkah proses ETL secara berurutan. Jika satu langkah gagal, pipeline akan berhenti untuk mencegah kesalahan data.
- **Alur Kerja**:
    1.  **Data Scraping**: Menjalankan `Data Scraping/src/scraper.py` untuk mengambil data game terbaru.
    2.  **Data Storing**: Menjalankan `Data Storing/src/loader.py` untuk memuat dan menstrukturkan data ke dalam database operasional (PostgreSQL).
    3.  **ETL Data Warehouse**: Menjalankan `Data Warehouse/src/etl.py` untuk melakukan transformasi dan memuat data ke dalam Data Warehouse.

### Cara Menjalankan Pipeline
Untuk memicu keseluruhan proses ETL secara manual, Anda dapat menjalankan skrip orkestrator dari direktori utama proyek:
```bash
python AutoScheduler/pipeline.py
```
Setiap eksekusi akan dicatat dalam file `AutoScheduler/pipeline.log`, yang berguna untuk pemantauan dan debugging.

### Penjadwalan Otomatis dengan Windows Task Scheduler
Untuk memastikan data diperbarui secara berkala tanpa intervensi manual, pipeline ini telah dijadwalkan untuk berjalan secara otomatis menggunakan **Windows Task Scheduler**. Tugas ini dikonfigurasi untuk menjalankan skrip `AutoScheduler/pipeline.py` pada interval waktu yang ditentukan, sehingga proses scraping dan pembaruan data warehouse terjadi secara konsisten. Saya menetapkan penjadwalan setiap hari pada pukul 02:00 WIB. Bukti dibawah adalah bukti task scheduler yang di run secara manual.

![taskscheduler](<AutoScheduler/taskscheduler.png>)

![perbedaan timestamp](<AutoScheduler/perbedaan timestamp.png>)


## Referensi

- **Library:**
  - BeautifulSoup
  - requests
  - psycopg2
  - pandas
  - sqlalchemy
  - dotenv
- **Sumber Data:**
  - "https://gamebrott.com/100-game-ps2-terbaik-di-dunia/"
