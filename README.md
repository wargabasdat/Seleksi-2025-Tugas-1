<div align="center">
  
# Seleksi Tahap 2 Asisten Basis Data 2025
## ETL Project: Data Kinerja Sensor Kamera Digital

</div>

<br>

## 1. Author
- **Nama:** Nazwan Siddqi Muttaqin
- **NIM:** 18223066

<br>

---

## 2. Deskripsi Proyek
> Proyek ini bertujuan untuk melakukan proses Extract, Transform, Load (ETL) secara lengkap, dimulai dari pengambilan data mentah dari web hingga penyimpanan ke dalam database relasional yang terstruktur dan siap untuk dianalisis melalui Data Warehouse.
> 
> **Topik** yang diangkat adalah **"Analisis Data Top 100 Sensor Kamera"** dengan sumber data dari situs **DXOMARK**. Topik ini dipilih karena data yang disajikan sangat terstruktur, kaya akan informasi kuantitatif (skor, harga, spesifikasi) dan kualitatif (merek, format sensor), sehingga sangat ideal untuk mendemonstrasikan proses normalisasi, perancangan skema database yang kompleks, dan implementasi *data warehouse*. Selain itu, topik kamera ini merupakan topik yang sangat saya minati dan tekuni sehingga saya bisa lebih enjoy dan juga mengerti dengan sangat dalam tentang topik ini.
>
> **DBMS** yang digunakan dalam proyek ini adalah **PostgreSQL**, sebuah sistem manajemen basis data relasional yang andal dan banyak digunakan di industri.

<br>

---

## 3. Cara Menggunakan Scraper & Hasil Output
Skrip *scraper* dirancang untuk mengambil, memfilter, dan memproses data kinerja 100 kamera teratas dari DXOMARK, lalu menyimpannya dalam format JSON yang bersih dan terstruktur.

#### **Prasyarat**
- Python 3.x
- Library Python: `requests`, `beautifulsoup4`
  ```bash
  pip install requests beautifulsoup4
  ```

#### **Eksekusi Skrip**
1.  Buka terminal atau *command prompt*.
2.  Navigasi ke direktori `Data Scraping/src/`.
3.  Jalankan skrip `main.py`:
    ```bash
    python main.py
    ```

#### **Output**
Setelah eksekusi berhasil, skrip akan menghasilkan dua file di dalam folder `Data Scraping/data/`:
1.  **`cameras.json`**: Berisi daftar 100 kamera teratas beserta informasi dasarnya.
2.  **`scores.json`**: Berisi daftar skor yang telah ditransformasi untuk setiap kamera.

<br>

---

## 4. Penjelasan Struktur File JSON
Hasil dari *scraper* adalah dua file JSON yang sudah melalui proses *preprocessing* dan transformasi agar siap digunakan untuk *database* relasional.

#### **`cameras.json`**
File ini berisi sebuah *list*, di mana setiap elemennya adalah *object* JSON yang merepresentasikan satu kamera.

| Key | Tipe Data | Deskripsi |
| :--- | :--- | :--- |
| `camera_id` | Integer | ID unik untuk setiap kamera (Primary Key). |
| `name` | String | Nama lengkap komersial kamera. |
| `brand` | String | Merek dari kamera (e.g., "Canon", "Nikon"). |
| `model` | String | Model spesifik dari kamera. |
| `launch_date` | String | Tanggal rilis kamera (format YYYY-MM-DD). |
| `launch_price_usd`| Integer | Harga rilis dalam Dolar AS. |
| `sensor_format` | String | Ukuran atau format sensor (e.g., "Full Frame"). |
| `pixel_depth_mp`| Float | Resolusi sensor dalam Megapiksel. |

#### **`scores.json`**
File ini berisi daftar skor dalam format "panjang" (*long format*), di mana setiap baris adalah satu jenis skor untuk satu kamera.

| Key | Tipe Data | Deskripsi |
| :--- | :--- | :--- |
| `score_id` | Integer | ID unik untuk setiap entri skor (Primary Key). |
| `camera_id` | Integer | ID kamera yang memiliki skor ini (Foreign Key). |
| `score_type` | String | Kategori skor (e.g., "Overall", "Portrait"). |
| `score_value` | Float/Int | Nilai numerik dari skor tersebut. |

<br>

---

## 5. Struktur ERD dan Diagram Relasional RDBMS

#### **Entity Relationship Diagram (ERD)**
ERD ini menunjukkan model konseptual dari semua entitas data dan bagaimana mereka saling berhubungan, termasuk tabel tambahan yang relevan. Pada ERD ini saya memisahkan atribut brand dan sensor_format dari tabel cameras yang ada di json karena isi dari brand dan sensor_format memiliki nilai yang bersifat repetitif dan secara konseptual merupakan entitas tersendiri. Pemisahan ini bertujuan untuk mengurangi redundansi dan menjaga integritas data.
![ERD Proyek Kamera](https://github.com/NazwanSM/Seleksi-2025-Tugas-1/blob/main/Data%20Storing/design/ERD.png)

#### **Diagram Relasional**
Diagram ini adalah cetak biru teknis dari ERD yang mendefinisikan setiap tabel, kolom, dan *constraints* (`Primary Key` & `Foreign Key`) yang diimplementasikan dalam database.
![Diagram Relasional Proyek Kamera](https://github.com/NazwanSM/Seleksi-2025-Tugas-1/blob/main/Data%20Storing/design/Relational%20Diagram.png)

<br>

---

## 6. Penjelasan Proses Translasi ERD menjadi Diagram Relasional
Proses translasi dari ERD (model konseptual) ke Diagram Relasional (model fisik) melibatkan beberapa langkah konkret untuk memastikan desain dapat diimplementasikan secara efisien di RDBMS:
1.  **Pemetaan Entitas ke Tabel**: Setiap entitas pada ERD (`cameras`, `brands`, dll.) diubah menjadi sebuah tabel dalam diagram relasional.
2.  **Pemetaan Atribut ke Kolom**: Setiap atribut dari entitas menjadi sebuah kolom di tabelnya masing-masing.
3.  **Implementasi *Primary Key***: Atribut unik dari setiap entitas (`camera_id`, `brand_id`) ditetapkan sebagai `PRIMARY KEY` untuk memastikan setiap baris data bersifat unik.
4.  **Implementasi Hubungan (Relationship)**:
    * **One-to-Many**: Hubungan seperti antara `brands` dan `cameras` diimplementasikan dengan menambahkan kolom *Foreign Key* (`brand_id`) di sisi "Many" (`cameras`) yang merujuk ke *Primary Key* di sisi "One" (`brands`).
    * **Many-to-Many**: Hubungan antara `cameras` dan `video_resolutions` diimplementasikan dengan membuat **tabel perantara (junction table)** baru, yaitu `camera_video_capabilities`. Tabel ini berisi *Foreign Key* dari kedua tabel yang dihubungkannya.

<br>

---

## 7. Screenshot Program Dijalankan

#### **Proses Data Scraping**
![Screenshot Eksekusi Scraper](https://github.com/NazwanSM/Seleksi-2025-Tugas-1/blob/main/Data%20Scraping/screenshot/image.png)

#### **Proses Data Storing**
![Skrip Data Storing](https://github.com/NazwanSM/Seleksi-2025-Tugas-1/blob/main/Data%20Storing/screenshot/Hasil%20Python%201.png)

#### **Bukti Data di dalam Database**
* **Tabel `cameras`:**
    ![Data Tabel Kameras](https://github.com/NazwanSM/Seleksi-2025-Tugas-1/blob/main/Data%20Storing/screenshot/SELECT%20cameras.png)
* **Tabel `scores`:**
    ![Data Tabel Skor](https://github.com/NazwanSM/Seleksi-2025-Tugas-1/blob/main/Data%20Storing/screenshot/SELECT%20scores.png)
* **Tabel Hasil Normalisasi (`brands` & `sensor_formats`):**
    ![Data Tabel Normalisasi](https://github.com/NazwanSM/Seleksi-2025-Tugas-1/blob/main/Data%20Storing/screenshot/SELECT%20brands%2C%20sensor_formats.png)
* **Tabel Tambahan (Dibiarkan Kosong):**
    ![Data Tabel Tambahan Kosong](https://github.com/NazwanSM/Seleksi-2025-Tugas-1/blob/main/Data%20Storing/screenshot/SELECT%20camera_video_capabilities%2C%20video_resolutions%2C%20lens_mounts%2C%20lenses.png)

<br>

---

## Bonus: Implementasi Data Warehouse

Bagian bonus ini mengimplementasikan *Data Warehouse* (DWH) menggunakan pendekatan **Star Schema**. Tujuannya adalah mentransformasi data operasional menjadi model yang dioptimalkan untuk kueri analitik.

- ### A. Desain Skema (ERD & Diagram Relasional)

    Desain DWH ini berfokus pada analisis fakta-fakta kuantitatif dari sebuah kamera, seperti harga dan skor, yang dijelaskan oleh berbagai dimensi seperti merek, format sensor, dan waktu.

    #### **Struktur Star Schema:**
    -   **Fact Table**: `fact_camera_performance`
    -   **Dimension Tables**: `dim_cameras`, `dim_brands`, `dim_sensor_formats`, `dim_time`

    #### **Diagram Relasional DWH**
    Berikut adalah visualisasi dari skema Data Warehouse yang diimplementasikan.
    ![Star Schema](https://github.com/NazwanSM/Seleksi-2025-Tugas-1/blob/main/Data%20Warehouse/design/Star%20Schema.png)
---
- ### B. Skrip ETL & Cara Penggunaan

    Proses *Extract, Transform, Load* (ETL) untuk memindahkan dan membentuk data dari database operasional ke *Data Warehouse* dilakukan oleh skrip Python yang berada di `Data Warehouse/src/main.py`.

    #### **Prasyarat**
    1.  Pastikan Anda telah menjalankan skrip `Data Storing/src/main.py` terlebih dahulu sehingga database operasional `seleksi_asisten_basdat` sudah terisi.
    2.  Pastikan library `psycopg2-binary` sudah terinstal.
        ```bash
        pip install psycopg2-binary
        ```

    #### **Eksekusi Skrip**
    1.  Buka terminal atau *command prompt*.
    2.  Navigasi ke direktori `Data Warehouse/src/`.
    3.  Jalankan skrip `main.py`:
        ```bash
        python main.py
        ```
    Skrip akan secara otomatis membuat skema DWH dan melakukan proses ETL dari tabel-tabel operasional.
---
- ### C. Contoh Query Analitik

    *Data Warehouse* ini dirancang untuk menjawab pertanyaan-pertanyaan analitis yang kompleks. Berikut adalah contoh *query* untuk mendapatkan *insight* dari data yang ada:

    **Analisis:** "Menampilkan rata-rata skor Overall dan harga per tahun untuk kamera Full Frame"

    ```sql
    SELECT
        dt.year,
        dsf.format_name,
        COUNT(DISTINCT fcp.camera_key) AS jumlah_kamera,
        AVG(fcp.overall_score)::DECIMAL(10,2) AS avg_overall_score,
        AVG(fcp.launch_price_usd)::DECIMAL(10,2) AS avg_price_usd
    FROM fact_camera_performance fcp
    JOIN dim_time dt ON fcp.time_key = dt.time_key
    JOIN dim_sensor_formats dsf ON fcp.format_key = dsf.format_key
    WHERE dsf.format_name = 'Full Frame'
    GROUP BY dt.year, dsf.format_name
    ORDER BY dt.year DESC;
    ```
    **Hasil:**
    ![Hasil Query Analisis](https://github.com/NazwanSM/Seleksi-2025-Tugas-1/blob/main/Data%20Warehouse/screenshot/QUERY%20menampilkan%20rata-rata%20skor%20Overall%20dan%20Harga%20per%20tahun%20untuk%20kamera%20full%20frame.png)

## 8. Referensi
* **Sumber Data**: [DXOMARK - Camera Sensor Rankings](https://www.dxomark.com/camera-sensors/)
* **Library Python**:
    * `requests` (untuk HTTP request)
    * `beautifulsoup4` (untuk parsing HTML)
    * `psycopg2-binary` (untuk koneksi ke PostgreSQL)
* **DBMS**: PostgreSQL
* **Tools Desain**: diagrams.net (draw.io)