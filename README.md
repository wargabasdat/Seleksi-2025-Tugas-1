# Seleksi Warga Basdat 2025

Repositori ini berisi Hasil tugas 1 untuk seleksi warga basis data ITB 2025.

## AUTHOR
- **Nama**: Matthew Sebastian Kurniawan
- **NIM**: 18223096
- **Jurusan**: Sistem dan Teknologi Informasi

## Deskripsi Singkat Data dan DBMS
Data yang digunakan berasal dari situs LaptopMedia – Top 100 Laptops with the Best Screens. Dataset ini berisi informasi detail mengenai spesifikasi laptop, termasuk skor kualitas layar (warna, kecerahan maksimum, kontras, cakupan DCI-P3, dan keamanan mata), spesifikasi teknis seperti CPU, GPU, RAM, penyimpanan, baterai, dimensi, material bodi, serta fitur konektivitas dan kelengkapan lainnya. DBMS yang digunakan adalah PostgreSQL karena memiliki kemampuan optimasi query yang baik, serta cocok untuk mengelola data relasional dengan kompleksitas hubungan seperti ini.

## Alasan Memilih Topik
Saya memilih topik ini karena menganalisis spesifikasi laptop seperti RAM, layar, dan komponen lainnya merupakan hobi saya. Selain itu, dataset yang digunakan dari situs LaptopMedia memiliki struktur informasi yang detail dan terorganisasi, sehingga sangat cocok untuk diimplementasikan dalam bentuk database relasional. Dengan membuat database ini, proses pencarian dan analisis laptop dapat dilakukan dengan lebih efisien.

## Cara Menggunakan Scraper dan Output-nya

1. Masuk ke folder `Data Scraping/src`.
2. Jalankan script scraper dengan perintah berikut di terminal:
    ```bash
    python scraper.py
    ```
3. Hasil scraping akan otomatis disimpan dalam bentuk file JSON di folder `Data Scraping/data/`.
    - Contoh output: `Laptop.json`, `CPU.json`, `GPU.json`, dst.
4. File JSON hasil scraping dapat langsung digunakan untuk proses data modeling dan data storing pada tahap berikutnya.
**Note:** Pastikan requirements berikut sudah ter-install sebelum menjalankan scraper:

**Requirements:**
- selenium
- beautifulsoup4
- Chrome browser
- ChromeDriver (versi sesuai Chrome browser)

## Penjelasan Struktur File JSON yang Dihasilkan Scraper

Setelah menjalankan scraper, akan dihasilkan beberapa file JSON di folder `Data Scraping/data/`, yaitu:

- `Laptop.json` — berisi data utama laptop
- `CPU.json` — berisi data CPU
- `GPU.json` — berisi data GPU
- `Laptop_Score.json` — berisi skor kualitas layar tiap laptop
- `Laptop_Configuration.json` — berisi konfigurasi RAM, storage, OS, dan harga
- `Laptop_Detailed_Spec.json` — berisi detail spesifikasi fisik laptop
- `CPU_Performance.json` — berisi data performa CPU
- `GPU_Performance.json` — berisi data performa GPU
- `Features.json` — berisi fitur tambahan pada laptop
- `Ports_Connectivity.json` — berisi data port dan konektivitas
- `Laptop_Image.json` — berisi link gambar laptop

Setiap file berisi array of objek, di mana setiap objek merepresentasikan satu entitas (misal: satu laptop, satu CPU, dst). 

# Struktur ERD dan Diagram Relasional RDBMS

**Struktur ERD:**

- **Laptop Scores Laptop_Score**  
    Jenis Relasi: One-to-One (Total Participation)  
    Alasan: Setiap laptop dalam dataset memiliki satu set skor layar yang unik (warna, kecerahan, kontras, cakupan DCI-P3, keamanan mata). Tidak ada laptop tanpa skor, sehingga semua laptop terhubung ke satu Laptop_Score.

- **CPU has_performance CPU_Performance**  
    Jenis Relasi: One-to-One (Partial Participation)  
    Alasan: Satu CPU memiliki satu data performa (ranking, persentase performa, skor benchmark), namun tidak semua CPU di dataset memiliki data performa lengkap.

- **GPU has_performance GPU_Performance**  
    Jenis Relasi: One-to-One (Partial Participation)  
    Alasan: Satu GPU memiliki satu data performa, namun tidak semua GPU pada dataset memiliki data performa lengkap.


- **Laptop Uses CPU**  
    Jenis Relasi: one-to-Many (Total Participation)  
    Alasan: Satu laptop dapat menggunakan lebih dari satu jenis CPU, dan semua laptop di dataset memiliki setidaknya satu CPU yang tercatat. Begitu juga sebaliknya, satu CPU dapat digunakan oleh banyak laptop.

- **Laptop Uses GPU**  
    Jenis Relasi: one-to-Many (Total Participation)  
    Alasan: Satu laptop dapat menggunakan lebih dari satu jenis GPU, dan satu GPU dapat digunakan oleh banyak laptop. Semua laptop di dataset memiliki setidaknya satu GPU yang tercatat.

- **Laptop specified_by Laptop_Detailed_Spec**  
    Jenis Relasi: One-to-One (Total Participation)  
    Alasan: Setiap laptop memiliki satu detail spesifikasi (RAM, storage, baterai, dimensi, material bodi) yang unik dan wajib ada di dataset.

- **Laptop_Detailed_Spec includes Features**  
    Jenis Relasi: One-to-One (Total Participation)  
    Alasan: Spesifikasi detail dapat mencakup fitur tambahan seperti fingerprint reader, kamera, atau backlit keyboard, dan semua laptop memiliki daftar fitur lengkap.

- **Laptop_Detailed_Spec includes Ports_Connectivity**  
    Jenis Relasi: One-to-One (Total Participation)  
    Alasan: Spesifikasi detail dapat mencakup daftar port & konektivitas seperti USB, HDMI, Wi-Fi, Bluetooth, dan semua laptop memiliki informasi ini.

- **Laptop,cpu,gpu has Laptop_Configuration**  
    Jenis Relasi: One-to-Many (total Participation) (agregation) 
    Alasan: Satu laptop,gpu dan cpu bisa memiliki beberapa konfigurasi (varian RAM, storage, GPU, harga), dan semua laptop,gpu, dan cpu memiliki lebih dari satu varian konfigurasi.

**Struktur diagram relasional:**

Diagram relasional adalah implementasi dari ERD ke dalam bentuk tabel di PostgreSQL. Setiap entitas pada ERD direpresentasikan sebagai tabel dengan primary key masing-masing, dan relasinya diimplementasikan melalui foreign key. Hubungan one-to-one ditempatkan pada tabel yang menyimpan detail unik dari entitas utama, sedangkan hubungan one-to-many diimplementasikan pada tabel anak. Dengan struktur ini, integritas data terjaga dan query pencarian dapat dilakukan dengan efisien melalui operasi JOIN.

## Penjelasan Proses Translasi ERD Menjadi Diagram Relasional

1. **Laptop – Laptop_Detailed_Spec**  
    Jenis Relasi: One-to-One  
    Implementasi: Kolom Laptop_id di tabel Laptop_Detailed_Spec menjadi FK yang mengacu ke Laptop_id di tabel Laptop.  
    Makna: Setiap laptop hanya memiliki satu spesifikasi detail yang unik. Tidak ada laptop yang tercatat tanpa informasi spesifikasi ini.

2. **Laptop – Laptop_Score**  
    Jenis Relasi: One-to-One  
    Implementasi: Kolom Laptop_id di tabel Laptop_Score menjadi FK ke tabel Laptop.  
    Makna: Setiap laptop memiliki satu set skor yang unik (warna, kecerahan, kontras, cakupan DCI-P3, keamanan mata).

3. **Laptop – Laptop_Image**  
    Jenis Relasi: multivariabel atribute
    Implementasi: Kolom Laptop_id di tabel Laptop_Image menjadi FK ke tabel Laptop.  
    Makna: Satu laptop dapat memiliki banyak gambar utama

4. **CPU – CPU_Performance**  
    Jenis Relasi: One-to-One  
    Implementasi: Kolom cpu_id di tabel CPU_Performance menjadi FK ke tabel CPU.  
    Makna: Satu CPU memiliki data performa unik (benchmark, ranking, persentase performa).

5. **GPU – GPU_Performance**  
    Jenis Relasi: One-to-One  
    Implementasi: Kolom gpu_id di tabel GPU_Performance menjadi FK ke tabel GPU.  
    Makna: Satu GPU memiliki data performa unik seperti halnya CPU.

6. **Laptop – CPU**  
    Jenis Relasi: One-to-many 
    Implementasi: Kolom Laptop_id di tabel CPU menjadi FK ke tabel Laptop.  
    Makna: Setiap laptop dapat memiliki lebih dari satu jenis CPU.

7. **Laptop – GPU**  
    Jenis Relasi: One-to-many 
    Implementasi: Kolom Laptop_id di tabel GPU menjadi FK ke tabel Laptop.  
    Makna: Setiap laptop dapat memiliki lebih dari satu jenis GPU.

8. **Laptop,cpu, dan gpu – Laptop_Configuration**  
    Jenis Relasi: One-to-Many (agregation) 
    Implementasi: Kolom Laptop_id, gpu_id, dan cpu_id di tabel Laptop_Configuration menjadi FK ke tabel Laptop.  
    Makna: Satu laptop,gpu, dan cpu bisa memiliki beberapa konfigurasi (RAM, storage, OS, harga).

9. **Laptop_Detailed_Spec – Features**  
    Jenis Relasi: One-to-One (Optional)  
    Implementasi: Kolom feature_id di tabel Laptop_Detailed_Spec menjadi FK ke tabel Features.  
    Makna: Satu spesifikasi detail bisa mencantumkan fitur tambahan seperti fingerprint reader, kamera, dll.

10. **Laptop_Detailed_Spec – Ports_Connectivity**  
    Jenis Relasi: One-to-One (Optional)  
    Implementasi: Kolom port_id di tabel Laptop_Detailed_Spec menjadi FK ke tabel Ports_Connectivity.  
    Makna: Satu spesifikasi detail dapat mencantumkan daftar port seperti USB, HDMI, Wi-Fi, dan lainnya.

## Screenshot Hasil Program dan Query

Berikut adalah beberapa screenshot hasil program dan query yang dijalankan. File screenshot di-upload di folder yang sesuai:

### Hasil Query Data Storing

**Query 1**
![Query 1](Data%20Storing/screenshot/query%201.png)

**Query 2**
![Query 2](Data%20Storing/screenshot/query%202.png)

**Query 3**
![Query 3](Data%20Storing/screenshot/query%203.png)

**Query 4**
![Query 4](Data%20Storing/screenshot/query%204.png)

**Query 5**
![Query 5](Data%20Storing/screenshot/query%205.png)

**Query 6**
![Query 6](Data%20Storing/screenshot/query%206.png)

## Referensi

- **Library Python:**
    - selenium
    - beautifulsoup4
    - psycopg2

- **Halaman web yang di-scrape:**
    - https://laptopmedia.com/top-100-laptops-with-the-best-screens/

- **Dokumentasi & Tools:**
    - PostgreSQL: https://www.postgresql.org/docs/
    - pgAdmin: https://www.pgadmin.org/

#### **Windows Terminal + UTF-8 Setup (OLTP) (untuk menampilkan simbol seperti infinity, danlainnya)**
```cmd
wt
chcp 65001
set PGCLIENTENCODING=UTF8
psql -U postgres -d top100_laptop_screen
```
## Bonus: Automated Scheduling

Berikut adalah implementasi dan monitoring automated scheduling pada database aku:

**Gambar 1: Monitoring Scheduling (pgAgent/pg_cron)**
![Scheduling 1](Data%20Storing/screenshot/scheduling%201.png)

**Gambar 2: Hasil Log Scheduling**
![Scheduling 2](Data%20Storing/screenshot/scheduling%202.png)