![Header](Data%20Warehouse/screenshot/readme_header.png)

<h2 align="center">
  <br>
  Data Scraping, Storing, Warehousing, and Automation of
  <a href="https://dumaofficial.com">Duma Official</a> Fashion Catalog
  <br>
  <br>
</h2>

## Short Description

Duma Official adalah salah satu brand fashion lokal yang menawarkan koleksi pakaian wanita dengan desain elegan dan material berkualitas. Brand ini memiliki website resmi di laman dumaofficial.com yang menampilkan katalog produk lengkap, termasuk detail ukuran, material, variasi warna, dan harga baik harga normal maupun harga diskon. Website ini tidak hanya berfungsi sebagai etalase digital, tetapi juga sebagai sarana penjualan langsung kepada konsumen.

Untuk menyempurnakan pemodelan dari website Duma Official, dalam pembuatan *ETL Project* ini saya menambahkan beberapa tabel yang relevan, yaitu produk normal, produk diskon, kategori, varian, dan ukuran (measurements). Seluruh data diperoleh melalui proses *web scraping* yang memanfaatkan Selenium untuk menangani pemuatan data dinamis, kemudian disimpan dalam format JSON sebelum dimasukkan ke dalam RDBMS PostgreSQL.

Alasan saya memilih website ini sebagai objek dalam *web scraping* adalah karena datanya memiliki tingkat kelengkapan dan konsistensi yang tinggi. Selain itu, situs ini memuat data secara dinamis menggunakan mekanisme AJAX, yang umum digunakan pada platform e-commerce modern sehingga relevan untuk mensimulasikan kondisi nyata pengolahan data web. Data e-commerce seperti ini sangat tepat untuk studi kasus implementasi basis data relasional karena melibatkan banyak entitas yang saling terhubung, seperti produk, kategori, varian, dan ukuran. 

## Program Requirements & Specification

### Requirements
Untuk menjalankan program ini, diperlukan:
- **Bahasa Pemrograman**: Python (versi ≥ 3.9)
- **RDBMS**: PostgreSQL (versi ≥ 14)
- **Browser**: Google Chrome (versi terbaru) + ChromeDriver yang sesuai
- **Library Python**:
  - selenium
  - beautifulsoup4
  - psycopg2
  - pandas
  - json (built-in)
  - re (built-in)
  - time (built-in)
  - os (built-in)

### Specification
Bahasa pemrograman __Python__ digunakan untuk melakukan program, sedangkan __PostgreSQL__ digunakan sebagai RDBMS untuk menyimpan data hasil scraping. Adapun library Python yang digunakan adalah sebagai berikut:

- `Selenium`  
    - __Pertimbangan__ : Website Duma Official memuat data produk secara dinamis melalui AJAX dan memerlukan interaksi seperti *scrolling* untuk memuat seluruh produk. 
- `BeautifulSoup4`  
    - __Pertimbangan__ : Digunakan untuk mem-parsing HTML yang sudah dimuat oleh Selenium. Beautiful Soup lebih ringan untuk memproses *string* HTML.

- `psycopg2`  
    - __Pertimbangan__ : Digunakan untuk membuat koneksi dan mengirimkan query SQL langsung dari Python ke PostgreSQL. Library ini memungkinkan proses *insertion* data dari file JSON hasil scraping ke dalam tabel di database secara otomatis.

- `json`  
    - __Pertimbangan__ : Untuk menyimpan hasil scraping dalam format `.json` yang rapi dan terstruktur, sesuai kriteria output yang diharapkan.

- `re`  
    - __Pertimbangan__ : Digunakan untuk *parsing* string dan ekstraksi pola tertentu, seperti membersihkan teks material dari ukuran, atau memisahkan informasi harga dan varian produk.

- `time`  
    - __Pertimbangan__ : Digunakan untuk memberi jeda (*delay*) selama proses scraping agar halaman atau elemen tertentu sempat dimuat sepenuhnya sebelum data diambil.

- `os`  
    - __Pertimbangan__ : Digunakan untuk memastikan direktori penyimpanan file JSON ada, dan membuatnya jika belum ada.

- `pandas` 
    - __Pertimbangan__ : Membantu dalam proses konversi JSON menjadi CSV/TSV untuk mempermudah proses *bulk insert* ke PostgreSQL menggunakan perintah `COPY`.

## How to Use

Berikut adalah panduan langkah demi langkah untuk menjalankan scraper, menghasilkan file output, dan memuat data tersebut ke dalam database PostgreSQL.

### Bagian 1: Data Scraping (Menghasilkan File JSON)

Langkah ini bertujuan untuk mengambil data mentah dari website `dumaofficial.com` dan menyimpannya sebagai file `.json`.

1.  **Clone Repository**  
    Buka terminal, lalu clone repository ini.
    ```sh
    git clone [URL_REPOSITORY]
    cd [NAMA_FOLDER_PROYEK]
    ```

3.  **Install Library Python**  
    Install semua library yang dibutuhkan untuk scraper melalui `pip` di terminal.
    ```sh
    pip install -U pip
    pip install selenium beautifulsoup4 
    ```

3.  **Install Chrome Driver**
    - Install pada halaman (https://chromedriver.chromium.org/downloads)
    
4.  **Jalankan Skrip Scraper**  
    Pindah ke direktori skrip scraper dan jalankan. Proses ini mungkin memakan waktu beberapa menit.
    ```sh
    cd "Data Scraping/src"
    python products.py
    python variants.py
    python measurements.py
    ```
    Setelah selesai, Anda akan menemukan file `.json` (misalnya `products.json`, `variants.json`) di dalam folder `Data Scraping/data`. Ini adalah **hasil output** dari scraper.

### Bagian 2: Data Storing (Storing ke Database)

Langkah ini bertujuan untuk membaca file-file `.json` tersebut dan memasukkannya ke dalam database PostgreSQL yang terstruktur.

1.  **Siapkan Database PostgreSQL**
    * Buat sebuah database baru, misalnya dengan nama `duma_website`.
    * Buat semua tabel yang diperlukan dengan menjalankan file skema SQL yang telah disediakan. Ganti `[USERNAME_ANDA]` dengan username PostgreSQL Anda.
    ```sh
    createdb duma_website 
    psql -U postgres -d duma_website -f "Data Storing/src/schema.sql"
    ```

2.  **Install Library Database**  
    Install library Python yang dibutuhkan untuk menghubungkan skrip dengan PostgreSQL.
    ```sh
    pip install psycopg2-binary
    ```

3.  **Jalankan Skrip Penyimpanan (Loader)**  
    Pindah ke direktori skrip *storing* dan jalankan. Skrip ini akan membaca semua file `.json` dan memasukkan datanya ke dalam tabel-tabel di database `duma_website`.  
    ```sh
    cd "Data Storing/src"
    python scraping_to_storing.py
    ```
    Setelah langkah ini selesai, database `duma_website` Anda akan terisi dengan data produk yang telah di-scrape. 

4.  **Export database tersebut dalam format SQL**  
    Dump data yang sudah dimasukkan ke dalam file SQL.
    ```sh
    pg_dump -U <username> -d <database_name> -s > <output_file.sql>
    ```

### Bagian 3 (Bonus): Data Warehousing 

Langkah ini bertujuan untuk memindahkan data dari database operasional (OLTP) ke **database Data Warehouse** (OLAP) yang terstruktur untuk analisis. Proses ini dikenal sebagai ETL (Extract, Transform, Load).

1.  **Siapkan Database Data Warehouse**  
    Buat database baru yang terpisah khusus untuk Data Warehouse, lalu jalankan skrip SQL untuk membuat skema tabel dimensi dan fakta.
    ```sh
    # Buat database baru bernama duma_dw
    createdb duma_dw

    # Jalankan skema untuk membuat tabel-tabel di dalam duma_dwh
    psql -U [USERNAME_ANDA] -d duma_dw -f "Data Warehouse/src/schema.sql"
    ```

3.  **Load Data dari Data Storing ke Data Warehouse**  
    Jalankan skrip Python yang telah disiapkan untuk melakukan proses ETL. Skrip ini akan membaca data dari database OLTP, mentransformasikannya, dan memuatnya ke dalam database warehouse.
    ```sh
    # Pindah ke direktori yang benar
    cd "Data Warehouse/src"

    # Jalankan skrip ETL
    python load_to_warehouse.py
    ```

5.  **Verifikasi Tabel di Data Warehouse**  
   Setelah proses ETL selesai, periksa apakah tabel-tabel dimensi dan fakta di database `duma_dw` sudah terisi dengan benar.
    ```sh
    # Menampilkan semua tabel di database duma_dwh
    psql -U [USERNAME_ANDA] -d duma_dwh -c "\dt"

6.  **Export Database Data Warehouse**  
    Untuk keperluan submisi atau backup, *dump* struktur dan data dari Data Warehouse ke dalam sebuah file `.sql`.
    ```sh
    pg_dump -U [USERNAME_ANDA] -d duma_dwh > duma_dwh_dump.sql
    ```

### Bagian 4 (Bonus): Automated Scheduling 

Tahap ini mengotomatisasi keseluruhan proses, mulai dari *scraping*, *storing* ke database OLTP, hingga proses ETL ke *Data Warehouse*, agar dapat berjalan secara berkala sesuai jadwal yang ditentukan.

Pipeline data dijalankan melalui sebuah *wrapper script* lalu dijadwalkan secara otomatis menggunakan **cron** (untuk macOS/Linux).

1. **Menjalankan Pipeline Secara Manual**  
   Untuk menjalankan seluruh alur kerja (scraping → storing → warehousing) sekali waktu, 
   ```sh
    # Pindah ke direktori yang benar
    cd "Data Warehouse/src"

    # Jalankan skrip wrapper
    python run_wrapper.sh
    ```

2. **Menjadwalkan dengan cron**  
   Buka Editor `crontab`
   ```sh
   crontab -e
   ```
   Untuk menjaga data tetap terbarui secara otomatis, proses ini dapat dijadwalkan pada waktu tertentu. Berikut adalah contoh konfigurasi di dalam crontab setiap 10 menit sekali:  
   ```sh
   # Menjalankan pipeline data lengkap 10 menit sekali
   */10 * * * * /Users/allodyaq/Seleksi-2025-Tugas-1/Data\ Warehouse/src/run_wrapper.sh 
   ```
3. **Simpan dan keluar dari editor**  
   Untuk menyimpan perubahan pada editor `nano`:
    * Tekan **`Control + O`** (untuk "Write Out" atau Simpan).
    * Tekan **`Enter`** untuk mengonfirmasi nama file.
    * Tekan **`Control + X`** untuk keluar.
   Akan ada pesan `crontab: installing new crontab` yang menandakan jadwal baru berhasil dipasang.

4.  **Verifikasi Jadwal (Opsional)**
    Untuk memastikan jadwal Anda sudah tersimpan dengan benar, bisa melihat daftar semua jadwal aktif dengan perintah berikut:
    ```sh
    crontab -l
    ```  
    Pastikan baris yang baru saja ditambahkan sudah muncul di sana. Setelah ini, pipeline akan berjalan otomatis sesuai jadwal dan hasilnya akan tercatat di `etl_log.txt`.

## JSON Structure

Scraper menghasilkan 6 berkas JSON terstruktur pada folder `data/`:

- `products.json`
- `discount_products.json`
- `normal_products.json`
- `variants.json`
- `measurements.json`
- `categories.json`

Berikut adalah struktur dan contoh data untuk masing-masing file:

1.  **products.json**  
    Menyimpan informasi detail untuk setiap produk utama yang ditemukan di website.
    ```json
    {
        "product_id": "8252031893743",
        "name": "Ruby Top Red",
        "category_id": "C003",
        "description": "Cut and sewn from our all time favorite premium Japanese polyester fabric, we put a tweak to a simple tanktop by giving a puffed peplum panels on the side. Playful yet still simple, perfect to throw on for simple events or night out with friends!Model : 175 cm",
        "material": "100% Japanese made Premium Polyester",
        "size": "1, 2",
        "image_url": "[http://dumaofficial.com/cdn/shop/files/RubyTopRed.jpg?v=1706001577](http://dumaofficial.com/cdn/shop/files/RubyTopRed.jpg?v=1706001577)",
        "price": 595000.0
    }
    ```

2.  **variants.json**  
    Menyimpan informasi untuk setiap varian dari sebuah produk (misalnya berdasarkan ketersediaan atau warna).
    ```json
    {
        "variant_id": 46573587529967,
        "product_id": "9000439841007",
        "variant_name": "Size 2 / Black",
        "availability": "InStock",
        "color": "Black"
    }
    ```

3.  **measurements.json**  
    Menyimpan detail pengukuran (lingkar dada, panjang, dll.) untuk setiap ukuran yang tersedia pada suatu produk. `details` adalah objek JSON.
    ```json
    {
        "product_id": "8196303847663",
        "size_name": "ALL SIZE",
        "details": {
          "bust": "84-100 cm",
          "waist": "80-100 cm",
          "length": "115 cm",
          "armhole": "45 cm"
        }
    }
    ```

4.  **categories.json**  
    Menyimpan daftar kategori produk yang ada di website untuk relasi.
    ```json
    {
        "category_id": "C001",
        "name": "Dress"
    }
    ```

5.  **normal_products.json**  
    Berisi daftar `product_id` dari produk yang dijual dengan harga normal (tidak diskon). Digunakan untuk spesialisasi.
    ```json
    {
        "product_id": "8252031893743"
    }
    ```

6.  **discount_products.json**  
    Berisi daftar `product_id` dari produk yang sedang diskon, beserta harga normalnya sebelum diskon. Digunakan untuk spesialisasi.
    ```json
    {
        "product_id": "8843368071407",
        "normal_price": 750000.0
    }
    ```

## Database Structure

## Struktur Database (ERD & Diagram Relasional)

Bagian ini menampilkan desain struktur database untuk kedua sistem yang dibangun: database operasional (OLTP) untuk *data storing* dan data warehouse (OLAP) untuk analisis.

### 1. Database Operasional (OLTP) - Data Storing

#### Entity Relationship Diagram (ERD)
<div align="center">
  <img src="Data Storing/design/ERD.png" alt="ERD Database Operasional"/>
</div>

#### Diagram Relasional
<div align="center">
   <img src="Data Storing/design/relational_diagram.png" alt="Diagram Relasional"/>
</div>

### Penjelasan Translasi ERD ke Relasional

Berikut adalah penjelasan mengenai proses dan aturan yang digunakan untuk mentranslasikan desain ERD menjadi skema database relasional (tabel-tabel).

1.  **Setiap Entitas Dijadikan Relasi (Tabel)**
    * Semua *strong entity* seperti `Account`, `Products`, `Cart`, dan lainnya langsung diubah menjadi tabel.
    * Masing-masing entitas memiliki *primary key* yang jelas, misalnya: `account_email`, `product_id`, `cart_id`, dst.
    * *Weak entity* seperti `Measurements` ditranslasi dengan menambahkan *foreign key* dari *strong entity*-nya (`product_id`), yang sekaligus menjadi bagian dari *primary key* tabel *weak entity* tersebut.

2.  **Relasi One-to-Many (1:N) Ditranslasi dengan Menambahkan Foreign Key**
    Pada sisi 'many', ditambahkan sebuah kolom *foreign key* yang merujuk pada *primary key* di sisi 'one'.
    * **Contoh (`Products` dan `Variants`):** Satu produk bisa punya banyak varian, maka tabel `Variants` menyimpan `product_id` sebagai *foreign key*.
  
3.  **Relasi One-to-One (1:1) Ditranslasi dengan Menambahkan Foreign Key di Salah Satu Tabel**
    Pada salah satu tabel, ditambahkan sebuah kolom *foreign key* yang merujuk pada *primary key* dari tabel lainnya.
    * **Contoh (`Order` dan `Payment`):** Satu order memiliki satu pembayaran, maka tabel `Payment` menyimpan `order_id` sebagai *foreign key*.

4.  **Relasi Many-to-Many (M:N) Ditranslasi Menjadi Tabel Penghubung**
    Sebuah tabel perantara (*junction table*) baru dibuat yang berisi *foreign key* ke kedua tabel yang dihubungkan. Gabungan dari kedua *foreign key* ini seringkali menjadi *composite primary key* untuk tabel perantara.
    * **Contoh (`Cart` dan `Products`):** Satu keranjang bisa berisi banyak produk, dan satu produk bisa ada di banyak keranjang. Maka dibuat tabel perantara `Contains` dengan *composite primary key* (`cart_id`, `product_id`).

5.  **Generalization / Inheritance Ditangani dengan Pendekatan `IS A` (Table per Subclass)**
    Entitas *superclass* menjadi tabel utama, dan setiap *subclass* menjadi tabel terpisah yang mewarisi *primary key* dari *superclass*.
    * **Contoh:** Entitas `Products` memiliki dua *subclass*: `Normal_Products` dan `Discount_Products`. Keduanya menggunakan `product_id` sebagai *primary key* mereka sendiri, yang juga berfungsi sebagai *foreign key* yang merujuk ke tabel `Products`.

6.  **Atribut Multivalued Ditangani Sebagai Entitas Terpisah**
    Atribut yang dapat memiliki lebih dari satu nilai untuk satu entitas tidak disimpan sebagai array, melainkan dijadikan tabel terpisah.
    * **Contoh:** `Account` dapat memiliki banyak `phone_number`. Atribut ini dijadikan tabel terpisah (`Account_Phone`) dengan *composite primary key* (`account_email`, `phone_number`).

7.  **Atribut Komposit Ditangani dengan Membuat Kolom Terpisah**
    Atribut yang terdiri dari beberapa komponen dipecah menjadi kolom-kolom terpisah dalam satu tabel.
    * **Contoh:** Alamat pada `Account_Address` disimpan sebagai kolom-kolom terpisah: `street`, `district`, `city`, `province`, `zip_code`, dan `country`.

---

### 2. Data Warehouse (OLAP) - Data Warehousing

Skema ini dirancang menggunakan pendekatan **Star Schema** yang di-denormalisasi. Tujuannya adalah untuk mengoptimalkan performa query analitik yang kompleks (agregasi, *slicing*, dan *dicing* data).

#### Entity Relationship Diagram (ERD)
<div align="center">
  <img src="Data Warehouse/design/ERD.png" alt="ERD Data Warehouse"/>
</div>

#### Diagram Relasional
<div align="center">
  <img src="Data Warehouse/design/star_schema.png" alt="Diagram Relasional DW"/>
</div>

### Penjelasan Translasi ERD ke Relational Schema (Star Schema)

Proses translasi untuk Data Warehouse berbeda dengan database operasional. Tujuannya adalah untuk menciptakan **Star Schema** yang dioptimalkan untuk kecepatan query dan analisis data. Berikut adalah prinsip-prinsip utama yang digunakan:

1.  **Pembagian Menjadi Tabel Dimensi dan Tabel Fakta**
    * **Tabel Dimensi:** Setiap entitas yang mendeskripsikan data (konteks "who, what, where, when") dijadikan tabel dimensi. Tabel ini berisi atribut-atribut deskriptif.
        * Contoh: `Dim_Products`, `Dim_Variants`, `Dim_Category`, dan `Dim_Measurements` dijadikan tabel dimensi dengan *primary key* masing-masing.
    * **Tabel Fakta:** Sebuah tabel fakta (`Fact_Catalog`) dibentuk di tengah-tengah skema. Tabel ini tidak menyimpan banyak data deskriptif, melainkan berfokus pada:
        * **Ukuran (Measures):** Data numerik yang akan dianalisis (misalnya `price`).
        * **Foreign Keys:** Kunci-kunci yang menghubungkan ke setiap tabel dimensi.

2.  **Setiap Relasi Menjadi Foreign Key dari Fakta ke Dimensi**
    Inti dari Star Schema adalah hubungan *many-to-one* dari tabel fakta ke setiap tabel dimensi. Ini berarti satu baris di tabel fakta hanya berhubungan dengan satu baris di setiap tabel dimensi.
    * `Fact_Catalog` menyimpan *foreign key* yang merujuk ke *primary key* di setiap tabel dimensi:
        * `product_id` (FK) → `Dim_Products(product_id)`
        * `variant_id` (FK) → `Dim_Variants(variant_id)`
        * `category_id` (FK) → `Dim_Category(category_id)`
        * `measurement_id` (FK) → `Dim_Measurements(measurement_id)`

3.  **Mendefinisikan *Grain* dari Tabel Fakta**
    * *Grain* (butiran) dari tabel fakta adalah tingkat detail yang direpresentasikan oleh setiap barisnya.
    * Dalam kasus ini, *grain* dari `Fact_Catalog` adalah **satu catatan unik untuk setiap kombinasi produk, varian, kategori, dan ukuran**, beserta harga spesifiknya pada saat itu.

Pendekatan ini sengaja dibuat tidak ternormalisasi (denormalized) untuk menghindari `JOIN` yang kompleks dan mahal saat melakukan query analitik, sehingga proses agregasi data menjadi jauh lebih cepat.

## Screenshot

### 1. Tampilan Website
<div align="center">
  <img src="Data Scraping/screenshot/ss_website.png" alt="SS Website"/>
</div>

### 2. Data Scraping 
<div align="left">
  <img src="Data Scraping/screenshot/ss_scraping-1.png" alt="Scraping 1"/>
</div>

<div align="left">
  <img src="Data Scraping/screenshot/ss_scraping-2.png" alt="Scraping 2"/>
</div>

<div align="left">
  <img src="Data Scraping/screenshot/ss_scraping-2.png" alt="Scraping 3"/>
</div>

### 3. Data Storing

#### Tabel pada Database
<div align="left">
  <img src="Data Storing/screenshot/data_storing_table.png" alt="Tabel Database" width="400"/>
</div>

#### Tabel Categories
<div align="left">
  <img src="Data Storing/screenshot/categories.png" alt="Categories"/>
</div>

#### Tabel Products
<div align="left">
  <img src="Data Storing/screenshot/products-1.png" alt="Products 1"/>
</div>

<div align="left">
  <img src="Data Storing/screenshot/products-2.png" alt="Products 2"/>
</div>

<div align="left">
  <img src="Data Storing/screenshot/products-3.png" alt="Products 3"/>
</div>

<div align="left">
  <img src="Data Storing/screenshot/products-4.png" alt="Products 4"/>
</div>

#### Tabel Normal Products
<div align="left">
  <img src="Data Storing/screenshot/normal_products-1.png" alt="Normal Products 1"/>
</div>

<div align="left">
  <img src="Data Storing/screenshot/normal_products-2.png" alt="Normal Products 2"/>
</div>

#### Tabel Discount Products
<div align="left">
  <img src="Data Storing/screenshot/discount_products-1.png" alt="Discount Products 1"/>
</div>

<div align="left">
  <img src="Data Storing/screenshot/discount_products-2.png" alt="Discount Products 2"/>
</div>

#### Tabel Variants
<div align="left">
  <img src="Data Storing/screenshot/variants-1.png" alt="Variants 1"/>
</div>

<div align="left">
  <img src="Data Storing/screenshot/variants-2.png" alt="Variants 2"/>
</div>

#### Tabel Measurements
<div align="left">
  <img src="Data Storing/screenshot/measurements-1.png" alt="Measurements 1"/>
</div>

<div align="left">
  <img src="Data Storing/screenshot/measurements-2.png" alt="Measurements 2"/>
</div>

### 4. Data Warehouse

#### Tabel pada Database
<div align="left">
  <img src="Data Warehouse/screenshot/data_warehouse_table.png" alt="DW Table" width="300"/>
</div>

#### Tabel Dim Products
<div align="left">
  <img src="Data Warehouse/screenshot/dim_products-1.png" alt="Dim Products 1"/>
</div>
<div align="left">
  <img src="Data Warehouse/screenshot/dim_products-2.png" alt="Dim Products 2"/>
</div>

#### Tabel Dim Measurements
<div align="left">
  <img src="Data Warehouse/screenshot/dim_measurements-1.png" alt="Dim Measurements 1"/>
</div>
<div align="left">
  <img src="Data Warehouse/screenshot/dim_measurements-2.png" alt="Dim Measurements 2"/>
</div>

#### Tabel Dim Category
<div align="left">
  <img src="Data Warehouse/screenshot/dim_category.png" alt="Dim Category"/>
</div>

#### Tabel Dim Variants
<div align="left">
  <img src="Data Warehouse/screenshot/dim_variants-1.png" alt="Dim Variants 1"/>
</div>
<div align="left">
  <img src="Data Warehouse/screenshot/dim_variants-2.png" alt="Dim Variants 2"/>
</div>

#### Tabel Fact Catalog
<div align="left">
  <img src="Data Warehouse/screenshot/fact_catalog-1.png" alt="Fact Catalog 1"/>
</div>
<div align="left">
  <img src="Data Warehouse/screenshot/fact_catalog-2.png" alt="Fact Catalog 2"/>
</div>

#### Query Rata-Rata Harga per Kategori
<div align="left">
  <img src="Data Warehouse/screenshot/query_avg_price_per_category.png" alt="Query 1"/>
</div>

#### Query Jumlah Produk Terbanyak per Kategori
<div align="left">
  <img src="Data Warehouse/screenshot/query_max_product_based_on_category.png" alt="Query 2"/>
</div>

#### Query 5 Produk Termahal vs 5 Produk Termurah
<div align="left">
  <img src="Data Warehouse/screenshot/query_most_expensive_products_vs_cheapest_products.png" alt="Query 3"/>
</div>

### 5. Automated Scheduling
#### Hasil TXT Automated Scheduling
<div align="left">
  <img src="Data Warehouse/screenshot/automated_scheduling_proof.png" alt="Automated Scheduling Proof"/>
</div>

### crontab 
<div align="left">
  <img src="Data Warehouse/screenshot/ss_crontab-1.png" alt="Crontab 1"/>
</div>
<div align="left">
  <img src="Data Warehouse/screenshot/ss_crontab-2.png" alt="Crontab 2"/>
</div>

## Referensi
1.  **[Duma Official - All Products](https://dumaofficial.com/collections/all)** 
2.  **[Dokumentasi PostgreSQL](https://www.postgresql.org/)** 
3.  **[Dokumentasi Selenium](https://pypi.org/project/selenium/)** 
4.  **[Dokumentasi Beautiful Soup 4](https://pypi.org/project/beautifulsoup4/)**
5.  **[Dokumentasi psycopg2](https://pypi.org/project/psycopg2-binary/)** 
6.  **[Dokumentasi pandas](https://pandas.pydata.org/)**
7.  **[Dokumentasi cron](https://man7.org/linux/man-pages/man5/crontab.5.html)**
   
## Author
Allodya Qonnita Arofa - 18223054
