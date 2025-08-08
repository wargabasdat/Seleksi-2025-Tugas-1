<h1 align="center">
  <br>
  Seleksi Warga Basdat 2025 <br>
  ETL Project <br>
  Broadway Theatre Database
  <br>
  <br>
</h1>

## Author
Noeriza Aqila Wibawa
<br>
18223095
<br>
Sistem dan Teknologi Informasi
<br>
Institut Teknologi Bandung
<h2 align="left">
  <br>
   Deskripsi Data dan DBMS
  <br>
</h2>

#### Data
Pada proyek ini, scraping dilakukan terhadap halaman-halaman Wikipedia terkait Broadway Theatre, khususnya halaman utama https://en.wikipedia.org/wiki/Broadway_theatre serta halaman individual dari berbagai teater Broadway ternama. Data yang diambil meliputi nama teater, alamat, tahun dibuka, kapasitas (untuk teater aktif), penggunaan saat ini (untuk teater tidak aktif), produksi yang pernah ditampilkan, nama-nama arsitek yang merancang teater, serta nama perusahaan yang memiliki teater.


Saya memilih topik Broadway Theatre karena memiliki ketertarikan pribadi terhadap dunia seni pertunjukan, khususnya teater musikal dan drama yang menjadi ciri khas Broadway. Data yang dikumpulkan dari berbagai halaman Wikipedia ini memberikan wawasan mengenai sejarah teater yang menjadi bagian dari Broadway, serta berbagai produksi terkenal yang pernah ditampilkan di sana.


#### DBMS
Pada proyek ini, data yang diperoleh disimpan dalam DBMS PostgreSQL. PostgreSQL dipilih karena beberapa alasan, seperti kemudahan penggunaan dan konfigurasi, stabilitas yang tinggi, serta kemampuannya dalam menangani skema database yang kompleks.

## Cara menggunakan _scrapper_
1. _Clone repository_ ini ke _directory_ lokal Anda melalui Github atau dengan menjalankan perintah berikut di terminal:
```
$ git clone https://github.com/Snoeriza/Seleksi-2025-Tugas-1.git
```
2. _Install_ semua _library_ yang digunakan dalam menjalankan program ini dengan menjalankan perintah berikut di _Command Prompt (as Administrator)_:
```
$ pip install pandas beautifulsoup4 re psycop
```
3. Masuk ke folder proyek:
``` 
$ cd Seleksi-2025-Tugas-1
```
4. Buka folder "Data Scrapping" dan folder "src"
```
$ cd "Data Scrapping"
$ cd src
```
5. Jalankan kode program _scrapping_
``` 
scrape.py
```
## Cara menggunakan _database_
1. _Clone repository_ ini ke _directory_ lokal Anda melalui Github atau dengan menjalankan perintah berikut di terminal:
```
$ git clone https://github.com/Snoeriza/Seleksi-2025-Tugas-1.git
```
2. Masuk ke folder proyek:
``` 
$ cd Seleksi-2025-Tugas-1
```
4. Buka folder "Data Storing" dan folder "export" 
```
$ cd "Data Storing"
$ cd export
```
5. Download file broadway.sql
6. Buka PostgreSQL dab masukkan password
```
$ psql -U <username>;
```
7. Buat database
```
$ CREATE DATABASE {nama database};
```
8. Import file sql dengan
```
$ psql -U {username} -d {nama database} < broadway.sql
```

## Struktur JSON
Berikut merupakan salah satu contoh struktur dari file JSON yang dihasilkan dari _Data Scraping_ yaitu  `active_theatre`. File ini memuat informasi terkait teater-teater yang saat ini masih beroperasi di Broadway, beserta atribut-atributnya seperti nama teater dan kapasitas
```
[
    {
        "Theatre_name": Nama Teater,
        "Capacity": Kapasitas kursi teater
    }
]
```
Berikut merupakan salah satu contoh tuple
```
[
    {
        "Theatre_name":"Al Hirschfeld Theatre",
        "Capacity":"1,424"
    }
]
```
Struktur `JSON` ini disusun dengan format pasangan _key-value_, di mana key berperan sebagai judul atau nama atribut, sedangkan value berisi data atau nilai yang sesuai dengan judul tersebut.

## Struktur Database
#### ERD (_Entity Relationship Dagram_)
<div align="center">
<img src="Data Storing/design/erd.png" alt="ERD Teater Broadway" width="500">
</div>
<br>

ERD ini terdiri dari beberapa entitas utama. **Organization** memiliki atribut `company_name` sebagai _primary key_ dan `company_type` yang menggambarkan jenis perusahaan. Relasinya dengan Theatre bersifat **one-to-many**, artinya satu organisasi dapat memiliki banyak teater, tetapi setiap teater hanya dimiliki oleh satu organisasi. Architect memiliki atribut `id `sebagai _primary key_  dan `name` sebagai nama arsitek, serta berelasi _many-to-many_ dengan theatre melalui relasi design_work.

Theatre memiliki atribut `theatre_name` sebagai _primary key_ , `address`, dan `opening_year`. Selain relasi kepemilikan dengan Organization dan hubungan perancangan dengan Architect, Theatre juga memiliki relasi **one-to-many** dengan Production melalui hubungan hosted, di mana satu teater dapat menjadi tempat bagi banyak produksi, tapi satu produksi hanya bertempat di satu teater. Theatre merupakan **entitas generalisasi** yang terbagi menjadi dua subtipe secara *disjoint*: active yang memiliki atribut tambahan `capacity`, dan `former_existing` yang memiliki atribut `last_opened` serta `current_use`.

**Broadway_show** memiliki atribut `title` sebagai _primary key_ , composer, writer, lyricist, dan show_type. Relasinya dengan **Production** adalah **one-to-many** melalui hubungan *is\_performed*, artinya satu show dapat memiliki banyak produksi berbeda, tetapi satu produksi hanya terkait dengan satu pertunjukan.

**Production** sendiri berperan sebagai **weak entity** karena keberadaannya bergantung pada kombinasi hubungan dengan **Broadway\_show** dan **Theatre**. Setiap produksi memiliki atribut `opening_year`, tetapi _primary key_ dibentuk dari gabungan identitas show dan teater yang menaunginya. Hal ini mencerminkan bahwa sebuah produksi tidak bisa berdiri sendiri tanpa referensi ke broadway_show dan teater tempatnya berlangsung.
## Transformasi dari ERD ke Diagram Relasional
Berikut merupakan langkah-langkah translasi ERD ke Relational Diagram.
#### Pemetaan _entity_ menjadi relasi
1. Strong Entity<br>
Untuk setiap strong entity dilakukan pemetaan dengan membuat tabel (relasi) berisi seluruh atribut, dengan salah satu atribut menjadi primary key.
    - architect(<u>id</u>, name)
    - organization(<u>company_name</u>, company_type)
    - theatre(<u>theatre_name</u>, address, opening_year, _company_name_)
    - broadway_show(<u>title</u>, composer, writer, lyricist, show_type)
2. Weak Entity
Untuk setiap weak entity, dilakukan pemetaan dengan membuat tabel (relasi) berisi seluruh atribut, dengan dua atribut primary key, yaitu primary key dari weak entity tersebut, dan primary key dari strong entity yang berelasi dengannya.
    - production(<u>show_title</u>, <u>theatre_name</u>, <u>opening_year</u>) <br>
     **Foreign Key**<br>
     production(theatre_name) → theatre(theatre_name)<br>
     production(show_title) → broadway_show(title)

#### Pemetaan relationship menjadi relasi<br>
1. One-to-many relationship and many-to-one relationship
    Untuk setiap relationship one-to-many dan many-to-one, akan ditambahkan atribut primary key dari sisi "one" ke sisi "many".
    - theatre(<u>theatre_name</u>, address, opening_year, company_name)<br>
    **Foreign Key**<br>
    theatre(company_name) → organization(company_name)

2. Many-to-many relationship<br>
    Untuk setiap relationship bertipe many-to-many, hubungan tersebut akan ditranslasikan menjadi sebuah relasi (tabel) tersendiri. Relasi ini akan memiliki primary key yang dibentuk dari kombinasi primary key milik kedua entitas yang terlibat, serta dapat memiliki atribut tambahan bila diperlukan.
    - design_work(<u>architect_id</u>, <u>theatre_name</u>) <br>
    **Foreign Key**<br>
    design_work(architect_id) → architect(id) <br>
    design_work(theatre_name) → theatre(theatre_name)
#### Pemetaan Generalisasi
Untuk setiap generalisasi (ISA relationship), entitas supertipe direpresentasikan sebagai tabel yang memuat atribut umum, sedangkan setiap entitas subtipe direpresentasikan sebagai tabel terpisah yang memiliki primary key yang sama dengan supertipe sekaligus menjadi foreign key yang mereferensikan supertipe tersebut.
- theatre(<u>theatre_name</u>, address, opening_year, company_name)
- active_theatre(<u>theatre_name</u>, capacity)
- former_existing_theatre(<u>theatre_name</u>, last_opened, current_use)<br>
**Foreign Key**<br>
active_theatre(theatre_name) → theatre(theatre_name) <br>
former_existing_theatre(theatre_name) → theatre(theatre_name)


## _Relational Diagram_
Berikut merupakan Relational Diagram yang diperoleh dari hasil translasi ERD basis data yang telah dirancang.
<div align="center">
<img src="Data Storing/design/relational diagram.png" alt="Relational Diagram Teater Broadway" width="500">
</div>


## Screenshot program
#### Data Scraping
- Library yang digunakan
<div align="center">
<img src="Data Scraping/screenshot/library_scrape.png" alt="library" width="500">
</div>

- Fungsi ekstraksi
<div align="center">
<img src="Data Scraping/screenshot/extraction_function.png" alt="fungsi ekstraksi" width="500">
</div>

- Pre-processing data
<div align="center">
<img src="Data Scraping/screenshot/preprocessing.png" alt="data pre-processing" width="500">
</div>

- Menjalankan fungsi ekstraksi, pre-process,  dan konversi data ke json
<div align="center">
<img src="Data Scraping/screenshot/main.png" alt="main programe" width="500">
</div>

#### Data Storing
- Library yang digunakan
<div align="center">
<img src="Data Scraping/screenshot/librarystore.png" alt="storing library" width="500">
</div>

- Query show table pada database
<div align="center">
<img src="Data Storing/screenshot/daftar_tabel.png" alt="list of table" width="500">
</div>

- Describe table
<div align="center">
<img src="Data Storing/screenshot/table_describe.png" alt="table description" width="500">
</div>
<div align="center">
<img src="Data Storing/screenshot/table_describe_1.png" alt="table description" width="500">
</div>

- Query SELECT FROM WHERE
<div align="center">
<img src="Data Storing/screenshot/select_query.png" alt="query select" width="500">
</div>
<div align="center">
<img src="Data Storing/screenshot/select_query_1.png" alt="query select" width="500">
</div>

## Referensi
#### Website yang digunakan:
- https://en.wikipedia.org/wiki/Broadway_theatre (untuk mengambil halaman-halaman lain)
- https://en.wikipedia.org/wiki/List_of_Broadway_theatres (daftar teater)
- https://en.wikipedia.org/wiki/Al_Hirschfeld_Theatre   - https://en.wikipedia.org/wiki/Ambassador_Theat(Broadway)  
- https://en.wikipedia.org/wiki/August_Wilson_Theatre   
- https://en.wikipedia.org/wiki/Belasco_Theatre  
- https://en.wikipedia.org/wiki/Bernard_B._Jacobs_Theatre   
- https://en.wikipedia.org/wiki/Booth_Theatre   
- https://en.wikipedia.org/wiki/Broadhurst_Theatre   
- https://en.wikipedia.org/wiki/Broadway_Theatre_(53rd_Street)   
- https://en.wikipedia.org/wiki/Circle_in_the_Square_Theatre   
- https://en.wikipedia.org/wiki/Ethel_Barrymore_Theatre   
- https://en.wikipedia.org/wiki/-Eugene_O%27Neill_Theatre   
- https://en.wikipedia.org/wiki/Gerald_Schoenfeld_Theatre   
- https://en.wikipedia.org/wiki/Gershwin_Theatre   
- https://en.wikipedia.org/wiki/Hayes_Theater   
- https://en.wikipedia.org/wiki/Hudson_Theatre   
- https://en.wikipedia.org/wiki/Imperial_Theatre   
- https://en.wikipedia.org/wiki/James_Earl_Jones_Theatre   
- https://en.wikipedia.org/wiki/John_Golden_Theatre   
- https://en.wikipedia.org/wiki/Lena_Horne_Theatre   
- https://en.wikipedia.org/wiki/Longacre_Theatre   
- https://en.wikipedia.org/wiki/Lunt-Fontanne_Theatre  
https://en.wikipedia.org/wiki/Lyceum_Theatre_(Broadway)   
- https://en.wikipedia.org/wiki/Lyric_Theatre_(New_York_City,_1998)   
- https://en.wikipedia.org/wiki/Majestic_Theatre(Broadway)   
- https://en.wikipedia.org/wiki/Marquis_Theatre  
- https://en.wikipedia.org/wiki/Minskoff_Theatre   
- https://en.wikipedia.org/wiki/Music_Box_Theatre   
- https://en.wikipedia.org/wiki/Nederlander_Theatre   
- https://en.wikipedia.org/wiki/Neil_Simon_Theatre  
- https://en.wikipedia.org/wiki/New_Amsterdam_Theatre   
- https://en.wikipedia.org/wiki/Palace_Theatre(New_York_City)  
- https://en.wikipedia.org/wiki/Richard_Rodgers_Theatre   
- https://en.wikipedia.org/wiki/St._James_Theatre  
- https://en.wikipedia.org/wiki/Samuel_J._Friedman_Theatre   
- https://en.wikipedia.org/wiki/Shubert_Theatre(Broadway)   
- https://en.wikipedia.org/wiki/Stephen_Sondheim_Theatre   
- https://en.wikipedia.org/wiki/Studio_54   
- https://en.wikipedia.org/wiki/Todd_Haimes_Theatre   
- https://en.wikipedia.org/wiki/Vivian_Beaumont_Theater   
- https://en.wikipedia.org/wiki/Walter_Kerr_Theatre   
- https://en.wikipedia.org/wiki/Winter_Garden_Theatre 

#### Library
- json
- os
- urllib.parse
- psycopg2
- subprocess
- shlex
- pandas
- request
- beautifulsoup