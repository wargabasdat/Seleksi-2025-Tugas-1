<h1 align="center">
  <br>
  Seleksi Warga Basdat 2025 <br>
  ETL Project - Sanrio Character Rankings
  <br>
  <br>
</h1>

## Author
**Nama:** Naura Ayurachmani  
**NIM:** 18223061

## Deskripsi Project

Project ini melakukan proses ETL (Extract, Transform, Load) untuk mengumpulkan dan menyimpan data ranking karakter Sanrio dari website resmi Sanrio. Topik ini dipilih karena:

1. Website Sanrio menyediakan berbagai informasi menarik seperti ranking karakter global, ranking regional, profil karakter, merchandise, dan berita
2. Struktur data yang kompleks

**DBMS yang digunakan:** PostgreSQL  
**Alasan:** PostgreSQL dipilih karena mendukung JSON data types dan memiliki constraint yang kuat

## Step 1: Data Scraping

### Cara Menggunakan Scraper

1. **Instalasi Dependencies:**
   ```bash
   pip install requests beautifulsoup4 selenium webdriver-manager
   ```

2. **Menjalankan Scraper:**
   ```bash
   cd "Data Scraping/src"
   python rank_scraping.py
   python profile_scraping.py
   python data_cleaning.py
   ```
   URL utama akan di-scrape terlebih dahulu dengan *rank_scraping.py* yang berguna untuk mengambil informasi utama dari Sanrio Character Ranking 2025. Kemudian untuk mendapatkan informasi dari setiap karakter, scrape dilakukan dengan *profile_scraping.py* yang telah dilengkapi dengan ArgosTranslate untuk menerjemahkan bahasa jepang ke bahasa inggris. Selanjutnya data akan dirapikan menggunakan *data_cleaning.py* untuk menghapus karakter non-ASCII dan sebagainya

3. **Output:** File JSON akan tersimpan di folder `Data Scraping/data/`

### Target Website
- **URL Utama:** https://www.sanrio.com/
- **Halaman yang di-scrape:**
  - Character profiles dan descriptions
  - Overall rankings (high/low categories)  
  - Regional rankings per negara/wilayah

### Struktur File JSON

#### 1. `character.json`
```json
[
  {
    "name": "Hello Kitty",
    "description": "A cheerful and kind-hearted character...",
    "profile_link": "https://www.sanrio.com/character/hello-kitty",
  }
]
```

#### 2. `overall_ranking.json`
```json
{
  "high_rank": [
    {
      "rank": 1,
      "name": "Hello Kitty",
      "profile_link": "...",
      "vote_count": "150000",
      "comment": "Always #1 in our hearts!"
    }
  ],
  "low_rank": [...],
  "low_rank_under": [...]
}
```

#### 3. `region_ranking.json`
```json
{
  "regions_ranks": {
    "Japan": {
      "high": [
        {
          "rank": 1,
          "name": "Hello Kitty",
          "profile_link": "..."
        }
      ],
      "low": [...]
    },
    "United States": {...}
  }
}
```

## Step 2: Data Modeling & Data Storing

### ERD (Entity Relationship Diagram)
![ERD](Data%20Storing/design/ERD.png)

**Entitas Utama:**
- **Characters**: Menyimpan informasi dasar karakter
- **Regions**: Daftar wilayah/negara
- **Overall_Rankings**: Ranking global karakter
- **Region_Rankings**: Ranking karakter per wilayah
- **Friends**: Teman-teman yang dimiliki karakter
- **Goods, Spots, & News**: Informasi yang dapat diambil ketika melakukan scraping

**Relationship:**
- Characters 1:1 Overall_Rankings
- Characters 1:N Region_Rankings  
- Regions 1:N Region_Rankings
- Characters 1:N Friends 
- Characters 1:1 Goods
- Characters N:N Spots
- Characters N:N News

### Diagram Relasional
![Diagram Relasional](Data%20Storing/design/Relational.png)

### Proses Translasi ERD ke Relasional

1. **Mapping Entitas:** Setiap entitas menjadi tabel dengan primary key
2. **Mapping Atribut:** Atribut sederhana menjadi kolom tabel
3. **Mapping Relationship:**
   - 1:N = Foreign key di tabel "N"
   - N:N = Tabel junction
   - 1:1 = Salah satu PK di salah satu tabel
4. **Constraint Implementation:**
   - PRIMARY KEY untuk setiap tabel
   - FOREIGN KEY untuk menjaga referential integrity
   - UNIQUE constraint untuk nama karakter
   - NOT NULL untuk field wajib

**Contoh Translasi:**
```
Entitas "Characters" → Tabel "characters"
- character_id (PK, SERIAL)
- name (VARCHAR, UNIQUE, NOT NULL)
- description (TEXT)

Relationship "Characters has Rankings" → Foreign Key di tabel "overall_rankings"
- character_id REFERENCES characters(character_id)
```

### Cara Menggunakan Data Storing

1. **Setup Database:**
   ```bash
   # Install PostgreSQL dan buat database
   createdb sanrio_db
   ```

2. **Menjalankan Script:**
   ```bash
   cd "Data Storing/src"
   python storing.py
   ```

3. **Proses yang dilakukan:**
   - Create tables dengan constraints
   - Import data dari JSON files
   - Handle data cleaning (hapus duplikasi ID 93-98)
   - Validate data integrity
     
## Struktur Folder

```
Seleksi-2025-Tugas-1/
├── Data Scraping/
│   ├── src/
│   │   ├── data_cleaning.py
│   │   ├── profile_scraping.py
│   │   └── rank_scraping.py
│   ├── data/
│   │   ├── character.json
│   │   ├── overall_ranking.json
│   │   └── region_ranking.json
|   |   └── region.json
│   
├── Data Storing/
│   ├── design/
│   │   ├── erd.png
│   │   └── relational.png
│   ├── src/
│   │   └── storing.py
│   ├── export/
│   │   └── sanrio_db.sql
│   └── screenshot/
└── README.md
```

## Screenshots Program

### Final Database Tables
![Database Tables](Data%20Storing/screenshot/list_of_tables.png)

### Query Example
![Database Tables](Data%20Storing/screenshot/query_regions_ranking.png)

## Referensi

### Libraries Used:
- `requests` - HTTP requests
- `beautifulsoup4` - HTML parsing
- `selenium` - Browser automation
- `psycopg2` - PostgreSQL adapter
- `json` - JSON data handling
- `argostranslate` - Translator offline

### Website Sources:
- [Sanrio Official Website](https://www.sanrio.com/)
- [Character Rankings](https://www.sanrio.com/ranking/)
- [Character Profiles](https://www.sanrio.com/characters/)

---
