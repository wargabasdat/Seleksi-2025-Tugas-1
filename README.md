<h1 align="center">
  <br>
  Seleksi Warga Basdat 2025 <br>
  ETL Project
  <br>
  <br>
</h1>

<h2 align="center">
  DATA SCRAPING, MODELING, STORING, AND WAREHOUSE
  <br>
  Florecita Natawirya - 
  18223040
  <br>
  <br>
</h2>


## Deskripsi Singkat
__MyAnimeList__ adalah salah satu platform basis data terbesar di dunia untuk komunitas penggemar anime, manga, dan manhwa. Halaman khusus pada situs ini menyajikan daftar 100 judul manhwa dengan peringkat tertinggi berdasarkan skor dan popularitas dari para penggunanya.

Proyek ini bertujuan untuk melakukan ekstraksi data terperinci dari daftar tersebut. Data yang diambil tidak hanya mencakup judul dan peringkat, tetapi juga informasi penting lainnya seperti penulis (author), karakter, genre, dan perusahaan penerbit.

Untuk menyimpan dan mengorganisasi data yang kompleks ini, saya merancang sebuah skema database yang relevan. Alasan utama saya memilih topik ini adalah karena saya gemar membaca manhwa. Namun, akhir-akhir ini, saya kebingungan harus membaca manhwa yang mana yang bagus. Dan saya memilih __MyAnimeList__ sebagai objek *web scraping* adalah karena datanya sangat terstruktur dan konsisten, memungkinkan ekstraksi data yang komprehensif.

Hasil dari proyek ini diharapkan dapat menghasilkan sebuah database yang rapi dan siap untuk dianalisis. Analisis tersebut dapat memberikan wawasan berharga tentang tren manhwa paling populer, korelasi antara skor dengan genre atau penulis, dan menyediakan dataset yang fleksibel untuk berbagai keperluan penelitian atau visualisasi.


## Data Scraping
### 1. Cara Menggunakan Scraper
1. Clone repository
```sh
    $ git clone 
```

2. Intall library di cmd
```sh
    $ pip install beautifulsoup4
    $ pip install requests
```

3. Buka folder hasil cloning
```sh
    $ cd Seleksi-2025-Tugas-1/Data Scraping/src
```

4. Jalankan program 
```sh
    $ author_scraper.py
    $ manhwa_scraper.py
    $ company_scraper.py
    $ genre_scraper.py
    $ character_scraper.py
```
Nanti 5 file .JSON akan terekspor

### 2. Struktur JSON
1. `authors_data.json`
```json
{
        "Author Name": "Go, Yeong-Hun",
        "Given Name": "영훈",
        "Family Name": "고",
        "Birthday": null,
        "Website": "http://nastycat.co.kr/",
        "Member Favorites": "31",
        "Published Manga": [
            "Can't See Can't Hear But Love",
            "Dungeon Architect",
            "Trace",
            "Trace 1.5: Communicator"
        ]
    }
```

2. `characters_data.json`
```json
{
        "Character Name": "Inho Baek",
        "Role": "Main",
        "Mangaography": [
            "Cheese in the Trap Season 1",
            "Cheese in the Trap Season 2",
            "Cheese in the Trap Season 3",
            "Cheese in the Trap Season 4"
        ],
        "Member Favorites": 128,
        "Description": "Age: 26"
    }
```

3. `companies_data.json`
```json
{
        "Company Name": "Naver Webtoon",
        "Total Works": 1578
    }
```

4. `genres_data.json`
```json
{
        "Genre Name": "Romance",
        "Total Works": 19737,
        "Description": "Falling in love and struggling to progress towards—or maintain—a romantic relationship take priority, while other subplots either take backseat or are designed to develop the main love story. The narrative focuses on the thoughts and emotions of the characters, illustrating the connections between them and explaining their reactions to events or conflict. Almost always, the story ends happily and the couple is rewarded for their efforts with lasting love.\n\nRomance stories require significant romantic development leading to some kind of conclusion: either to begin the relationship, continue it, or end it. Open-ended romantic endings are only acceptable when the work is an incomplete adaptation of a Romance source. \"Teasing\" stories which do not narrate significant romantic development but have a conclusion should be tagged Romantic Subplot.\n\nA story can be simply Romance. Since they are plot-driven stories showing humans experiencing romantic struggle, most Romance has some Drama inherently. For both tags, the drama should be focused not only on the relationship but also on the side storylines; for example, one character overcoming the death of a loved one or a drug addiction. Comedy requires Romance narratives to be focused on eliciting laughter, not only using comedy for lightheartedness. Slice of Life and Romance are incompatible by definition."
    }
```

5. `manhwa_data.json`
```json
{
        "Title": "The Greatest Estate Developer",
        "Authors": [
            "Moon, Back-kyung",
            "Kim, Hyunsoo"
        ],
        "Published": [
            "Jul  30",
            "2021 to ?"
        ],
        "Chapters": null,
        "Status": "Publishing",
        "Serialization": [
            "Naver Webtoon"
        ],
        "Genres": [
            "Adventure",
            "Comedy",
            "Fantasy"
        ],
        "Themes": [
            "Isekai",
            "Reincarnation"
        ],
        "Score": "8.84"
    }
```

## Data Modeling
### 1. Struktur ERD dan Diagram Relasional RDBMS
#### ERD
<div align="center">
  <img src="Data Storing/design/Entity Relationship Diagram Manhwa.png"/>
</div>

#### Diaram Relasional
<div align="center">
  <img src="Data Storing/design/Relational Diagram Manhwa.png"/>
</div>

### 2. Proses Translasi ERD menjadi Diagram Relasional
#### Derived, Multivalued, Composite Attribute
<div align="center">
  <img src="Data Storing/design/derived, multivalued, composite.png"/>
</div>
derived attribute dihapus dan dijadikan view.
composite attributes hanya diambil bagian detailnya saja. 
multivalued attributes dibuat entitas baru yang isinya primary key dari entitas yang lama beserta atribut dirinya.


#### One to Many
<div align="center">
  <img src="Data Storing/design/one to many (1).png"/>
  <img src="Data Storing/design/one to many (2).png"/>
</div>
primary key dari entity yang "one" ditambahkan ke entity yang "many"

#### Many to Many
<div align="center">
  <img src="Data Storing/design/many to many (1).png"/>
  <img src="Data Storing/design/many to many (2).png"/>
  <img src="Data Storing/design/many to many (3).png"/>
</div>
dibuat entity baru yang berisikan primary key dari kedua entity sebelumnya.

#### Unary (One to Many)
<div align="center">
  <img src="Data Storing/design/unary one to many.png"/>
</div>
karena dia unary one to many, maka dibuat atribut baru dari primary key entity tersebut, dimana hal ini entity itu sendiri (self referencing).

#### Relationship Set with Attribute
<div align="center">
  <img src="Data Storing/design/relationship set with attribute.png"/>
</div>
karena many to many, dibuat entity baru yang berisikin primary key dari kedua atribut tersebut dan juga atribut tambahan yang terpisah.

#### Weak Entity
<div align="center">
  <img src="Data Storing/design/weak entity.png"/>
</div>
entity yang weak ditambahkan primary key dari entity yang strong.

#### Specialization
<div align="center">
  <img src="Data Storing/design/specialization.png"/>
</div>
entity "child" ditambahkan primary key dari entity "parent".

## Data Storing
Kelima file .JSON tadi digabungkan di kode python pada file `PSQLexporter.py` yang nantinya akan menghasilkan file .sql pada file `manhwalast.sql`.

1. Buat database pada __PostgreSQL__, contoh:
```sh
    host="localhost",
    user="postgres",
    password="*isi sesuai password masing-masing*",
    dbname="manhwa",
    port=5432
```

2. Intall library di cmd
```sh
    $ pip install psycopg2
```

3. Buka folder hasil cloning
```sh
    $ cd Seleksi-2023-Tugas-1/Data Scraping/src
```

4. Jalankan program 
```sh
    $ PSQLexporter.py
```

5. Export database tersebut dalam formal SQL
```sh
    $ pg_dump -U <username> -d <database_name> -s > <output_file.sql>
```

## Data Warehouse
### 1. Struktur ERD, Diagram Relasional, Fact and Dimension Table

ER dan diagram relasional yang dibuat dikhususkan berdasarkan hasil scraping yang bertujuan untuk menyesuaikan dalam proses pembuatan fact dan dimension table juga memudahkan pembuatan warehouse.

#### ERD
<div align="center">
  <img src="Data Warehouse/design/ER Diagram Manhwa (warehouse).png"/>
</div>

#### Diagram Relasional
<div align="center">
  <img src="Data Warehouse/design/Relational Diagram Manhwa (warehouse).png"/>
</div>

#### Fact and Dimension Table
<div align="center">
  <img src="Data Warehouse/design/Fact and Dimension Table (warehouse).png"/>
</div>

## Automated Scheduling
<div align="center">
  <img src="Data Warehouse/screenshot/Screenshot 2025-08-08 175220.png"/>
  <img src="Data Warehouse/screenshot/Screenshot 2025-08-08 180241.png"/>
  <img src="Data Warehouse/screenshot/Screenshot 2025-08-08 175029.png"/>
  <img src="Data Warehouse/screenshot/Screenshot 2025-08-08 175114.png"/>
  <img src="Data Warehouse/screenshot/Screenshot 2025-08-08 175154.png"/>
  <img src="Data Warehouse/screenshot/Screenshot 2025-08-08 174941.png"/>
</div>

## Lampiran
Selengkapnya dapat dilihat di folder masing-masing.

## Referensi
1. [MyAnimeList](https://myanimelist.net/topmanga.php?type=manhwa&limit=0)
2. [Dokumentasi Beautifulsoup4](https://beautiful-soup-4.readthedocs.io/)
3. [Dokumentasi psycopg2](https://pypi.org/project/psycopg2/)
4. [Dokumentasi PostgreSQL](https://www.postgresql.org/)
