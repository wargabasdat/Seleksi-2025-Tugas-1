# Seleksi Tahap 2 Asisten Basis Data 2025
# ETL Project: Data Scraping, Database Modeling, and Data Storing

## 1. Author
- **Nama:**  Bryan Ho
- **NIM:** 13523029

---

## 2. Deskripsi Proyek
Proyek ini bertujuan untuk melakukan web scraping data buku-buku terbaik di dunia dari situs **The Greatest Books**. Data yang berhasil dikumpulkan mencakup judul, penulis, tahun terbit, negara asal, genre, subjek, dan atribut lainnya.

Data yang telah dinormalisasi kemudian disimpan dan dikelola menggunakan RDBMS **MariaDB**.

Topik ini dipilih karena data buku memiliki struktur relasional yang kaya dan menarik untuk dimodelkan. Selain itu, topik ini memberikan tantangan dalam menangani relasi many-to-many (antara buku dengan language, genre, dan subjek) serta memberikan wawasan mengenai karya-karya literatur terbaik.

---

## 3. Cara Penggunaan

Berikut adalah panduan untuk menjalankan proyek ini.

### Prasyarat
- Python
- MariaDB
- Library Python yang tercantum dalam file `requirements.txt`.

### Langkah-langkah
1.  **Clone Repositori**
    ```bash
    git clone https://github.com/bry-ho/Seleksi-2025-Tugas-1.git 
    ```

2.  **Install Library yang Dibutuhkan**
    ```bash
    pip install -r requirements.txt
    ```

3.  **Setup Database Operasional**
    - Buat sebuah database baru di RDBMS Anda dengan nama `books_db`.
    - Jalankan script `schema.sql` yang ada di folder `Data Storing/src/` untuk membuat semua tabel dan relasi yang dibutuhkan.

4.  **Menjalankan Scraper**
    - Script ini akan mengambil data dari web dan menyimpannya ke dalam beberapa file JSON di dalam folder `Data Scraping/data/`
    - Pastikan Anda berada di direktori `Data Scraping/src/` sebelum menjalankan script.
    ```bash
    python scraper.py
    ```

5.  **Memasukkan Procedure dan Trigger ke Database**
    - Pada RDBMS Anda, jalankan script `procedure.sql` dan `trigger.sql` yang ada di folder `Data Storing/src/` untuk menambahkan logika bisnis tambahan ke dalam database.

6.  **Memasukkan Data ke Database**
    - Script ini akan membaca file-file JSON dan memasukkan datanya ke dalam database yang telah Anda siapkan.
    - Pastikan Anda berada di direktori `Data Storing/src/` dan sesuaikan koneksi database yang ada di program `Data Storing/src/insert_data.py` sebelum menjalankan script.
    ```bash
    python insert_data.py
    ```

---

## 4. Struktur File JSON
Data hasil scraping dinormalisasi dan dipisahkan ke dalam beberapa file untuk menjaga integritas dan menghindari redundansi. Berikut adalah struktur filenya:
- **`authors.json`**: Daftar semua penulis.
- **`books.json`**: Data utama setiap buku, berisi foreign key ke tabel lain.
- **`genres.json`**: Daftar semua genre.
- **`subjects.json`**: Daftar semua subjek.
- **`languages.json`**: Daftar semua bahasa.
- **`types.json`**: Daftar tipe buku.
- **`lengths.json`**: Daftar kategori panjang buku.
- **`countries.json`**: Daftar negara asal buku ditulis.
- **`book_genres.json`**: Tabel perantara untuk relasi many-to-many antara buku dan genre.
- **`book_subjects.json`**: Tabel perantara untuk relasi many-to-many antara buku dan subjek.
- **`book_languages.json`**: Tabel perantara untuk relasi many-to-many antara buku dan bahasa.

---

## 5. Desain Database (ERD & Diagram Relasional)

### Entity-Relationship Diagram (ERD)
Diagram ini menggambarkan desain konseptual dari database.
![ERD](<Data Storing/design/ERD.png>)

### Diagram Relasional
Diagram ini adalah skema fisik operational database yang diimplementasikan di **MariaDB**.
![Diagram Relasional](<Data Storing/design/relational_diagram.png>)

---

## 6. Proses Translasi ERD ke Diagram Relasional
Proses translasi dari ERD menjadi skema relasional fisik dilakukan melalui langkah-langkah berikut:
1.  **Entitas menjadi Tabel**: Setiap entitas pada ERD (seperti `Book`, `Author`, `Genre`, dll) diubah menjadi sebuah tabel di database.
2.  **Atribut menjadi Kolom**: Setiap atribut dari entitas (seperti `title` pada `Book` atau `author_name` pada `Author`) diubah menjadi kolom pada tabel yang bersangkutan dengan tipe data yang sesuai (`VARCHAR`, `INT`, `FLOAT`, dll.).
3.  **Identifier menjadi Primary Key**: Atribut unik dari setiap entitas (seperti `book_id` atau `author_id`) dijadikan **Primary Key** pada tabelnya.
4.  **Relasi One-to-Many**: Relasi ini diimplementasikan dengan menambahkan **Foreign Key** pada tabel di sisi "many". Contohnya, `author_id` ditambahkan di tabel `Book` untuk merujuk ke tabel `Author`.
5.  **Relasi Many-to-Many**: Relasi ini diimplementasikan dengan membuat **tabel perantara (junction table)** baru. Contohnya, relasi antara `Book` dan `Genre` diimplementasikan dengan membuat tabel `BookGenres` yang berisi `book_id` dan `genre_id` sebagai foreign key.

---

## 7. Bonus
### Setup dan Load Data Warehouse
- Buat sebuah database baru di RDBMS Anda dengan nama `books_dw`.
- Jalankan script `schema.sql` yang ada di folder `Data Warehouse/src/` untuk membuat semua dimension table dan fact table.
- Jalankan script ETL yang berada di folder `Data Warehouse/src/` untuk memindahkan dan mentransformasi data dari books_db ke books_dw.
```bash
python load_data.py
```

### Desain Data Warehouse (Star Schema)
Diagram ini adalah skema fisik data warehouse yang diimplementasikan di **MariaDB**.
![Star Schema](<Data Warehouse/design/star_schema.png>)

### Automated Scheduling
Untuk menjaga agar data selalu ter-update, keseluruhan proses dari scraping hingga loading data warehouse dapat diotomatisasi menggunakan penjadwal tugas. Proses otomasi ini menggabungkan semua langkah (scraping, data storing, dan ETL data warehouse) ke dalam satu script utama yang kemudian dijalankan secara berkala oleh **Windows Task Scheduler**.

Berikut adalah bukti bahwa pipeline telah berjalan pada dua waktu yang berbeda.
![Automated Scheduling](<Data Warehouse/screenshot/automated_scheduling_timestamp.png>)

---

## 8. Screenshot Program

### Proses Scraping
![Proses Scraping](<Data Scraping/screenshot/scraping_process.png>)

### Proses Memasukkan Data ke Database
![Proses Insert Data](<Data Storing/screenshot/insert_data_process.png>)

### Proses Mentransformasikan Data ke Data Warehouse
![Proses Load Data](<Data Warehouse/screenshot/load_data_process.png>)

### Bukti Data di RDBMS (Contoh Query)
Berikut adalah bukti bahwa data berhasil disimpan dan dapat di-query dari database.
1. Operational Database
- Top 10 highest rated books
![Query SELECT FROM WHERE](<Data Storing/screenshot/query_highest_rated_books.png>)
- Authors with multiple books
![Query SELECT FROM WHERE](<Data Storing/screenshot/query_author_with_multiple_books.png>)

2. Data Warehouse
- Average rating of books per country
![Query SELECT FROM WHERE](<Data Warehouse/screenshot/query_average_rating_books_per_country.png>)
- Top 5 genres with the highest average rank
![Query SELECT FROM WHERE](<Data Warehouse/screenshot/query_genres_with_the_highest_average_rank.png>)
---

## 9. Referensi
- **Sumber Data:** [The Greatest Books](https://thegreatestbooks.org/v/table)
- **Library Python:**
  - `selenium`
  - `beautifulsoup4`
  - `mysql-connector-python` 
- **Tools:**
  - MariaDB