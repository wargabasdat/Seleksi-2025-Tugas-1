# 🍰 Cake Recipes Project – Database Operasional & Data Warehouse

## Daftar Isi
1. [Author](#1-author)
2. [Deskripsi Singkat](#2-deskripsi-singkat)
3. [Tools & Teknologi](#3-tools--teknologi)
4. [Cara Menggunakan Scraper & Transformasi Data](#4-cara-menggunakan-scraper--transformasi-data)
5. [Struktur File JSON](#5-struktur-file-json)
6. [Database Operasional](#6-database-operasional)
   - [Struktur Tabel](#struktur-tabel-database-operasional)
   - [ERD & Diagram Relasional](#erd--diagram-relasional)
   - [Translasi ERD ke Diagram Relasional](#translasi-erd-ke-diagram-relasional)
7. [Data Warehouse](#7-data-warehouse)
   - [Struktur Tabel](#struktur-tabel-data-warehouse)
   - [ERD & Star Schema](#erd--star-schema)
   - [Translasi ERD ke Data Warehouse](#translasi-erd-ke-data-warehouse)
8. [Screenshot Program](#8-screenshot-program)
9. [Referensi](#9-referensi)

---

## 1. Author
- **Nama**: Matilda Angelina Sumaryo  
- **NIM**: 18223125  

---

## 2. Deskripsi Singkat
Proyek ini membangun **sistem pengelolaan data resep kue** dengan alur:
1. **Scraping data** dari situs resep kue.
2. **Penyimpanan data** ke **Database Operasional (MySQL)**.
3. **Proses ETL** untuk mentransformasi data ke **Data Warehouse**.
4. **Analisis berbasis Star Schema**.

Topik resep kue dipilih karena:
- Data terstruktur (kategori, bahan, instruksi).
- Cocok untuk latihan **ETL** dan **pemodelan data warehouse**.

**DBMS**: MySQL (untuk database operasional & data warehouse).

---

## 3. Tools & Teknologi
- **Python**: `pandas`, `sqlalchemy`, `pymysql`, `requests`, `BeautifulSoup`
- **MySQL**: Database Operasional & Data Warehouse
- **VSCode**: Pengembangan

---

## 4. Cara Menggunakan Scraper & Transformasi Data
1. Install Python 3.
2. Install library:
   ```bash
   pip install requests beautifulsoup4 pandas sqlalchemy pymysql
   ```
3. Jalankan scraper:
   ```bash
   python "Data Scraping/src/scrape_code.py"
   ```
4. Hasil scraping tersimpan di `Data Scraping/data`:
   - `categories.json`
   - `ingredients.json`
   - `instructions.json`
   - `recipes.json`
5. Masukkan data ke **Database Operasional**:
   - Jalankan `Data Storing/src/create.sql`
   - Jalankan `Data Storing/src/insert_data.py`
6. Bangun **Data Warehouse**:
   - Jalankan `Data Warehouse/src/create.sql`
   - Jalankan `Data Warehouse/src/etl_db_to_dw.py`

---

## 5. Struktur File JSON
### `categories.json`
| Kolom         | Tipe Data | Keterangan |
| ------------- | --------- | ---------- |
| category_id   | integer   | ID kategori unik |
| name          | string    | Nama kategori |
| description   | string    | Deskripsi kategori |

### `ingredients.json`
| Kolom         | Tipe Data | Keterangan |
| ------------- | --------- | ---------- |
| ingredient_id | integer   | ID bahan unik |
| recipe_id     | integer   | ID resep terkait |
| name          | string    | Nama bahan |
| quantity      | string    | Jumlah bahan |
| unit          | string    | Satuan |
| text          | string    | Teks bahan asli |

### `instructions.json`
| Kolom         | Tipe Data | Keterangan |
| ------------- | --------- | ---------- |
| instruction_id| integer   | ID langkah unik |
| recipe_id     | integer   | ID resep terkait |
| step_number   | integer   | Urutan langkah |
| text          | string    | Isi instruksi |

### `recipes.json`
| Kolom         | Tipe Data | Keterangan |
| ------------- | --------- | ---------- |
| recipe_id     | integer   | ID resep unik |
| title         | string    | Nama resep |
| description   | string    | Deskripsi resep |
| author        | string    | Penulis resep |
| url           | string    | Link sumber |
| published_date| string    | Tanggal publikasi |
| image_url     | string    | Link gambar |
| prep_time     | string    | Waktu persiapan |
| cook_time     | string    | Waktu memasak |
| chill_time    | string    | Waktu pendinginan |
| total_time    | string    | Total waktu |
| servings      | string    | Jumlah porsi |
| scraped_at    | string    | Timestamp scraping |
| ingredients_count | integer | Jumlah bahan |
| instructions_count| integer | Jumlah langkah |
| category | string    | Nama kategori |

---

## 6. Database Operasional

### Struktur Tabel Database Operasional
#### `categories`
| Kolom | Tipe Data | Keterangan |
| ----- | --------- | ---------- |
| category_id | int (PK) | ID kategori unik |
| name | varchar | Nama kategori |
| description | text | Deskripsi kategori |

#### `recipes`
| Kolom | Tipe Data | Keterangan |
| ----- | --------- | ---------- |
| recipe_id | int (PK) | ID resep unik |
| title | varchar | Judul resep |
| description | text | Deskripsi resep |
| author | varchar | Penulis resep |
| url | varchar | Link sumber |
| published_date | date | Tanggal publikasi |
| image_url | varchar | Link gambar |
| prep_time | varchar | Waktu persiapan |
| cook_time | varchar | Waktu memasak |
| chill_time | varchar | Waktu pendinginan |
| total_time | varchar | Total waktu |
| servings | varchar | Jumlah porsi |
| scraped_at | timestamp | Timestamp scraping |
| category_id | int (FK) | Kategori resep |

#### `ingredients`
| Kolom | Tipe Data | Keterangan |
| ----- | --------- | ---------- |
| ingredient_id | int (PK) | ID bahan unik |
| recipe_id | int (FK) | Resep terkait |
| quantity | decimal | Jumlah bahan |
| unit | varchar | Satuan |
| name | text | Nama bahan |

#### `instructions`
| Kolom | Tipe Data | Keterangan |
| ----- | --------- | ---------- |
| instruction_id | int (PK) | ID langkah unik |
| recipe_id | int (FK) | Resep terkait |
| step_number | int | Urutan langkah |
| text | text | Isi langkah |

---

### ERD & Diagram Relasional
**ERD:**  
![ERD](Data%20Storing/design/cake_recipes_db-erd.drawio.png)  

**Diagram Relasional:**  
![Relational Model](Data%20Storing/design/cake_recipes_db-model-relational.drawio.png)  

---

### Translasi ERD ke Diagram Relasional
1. Entity → tabel.
2. Attribute → kolom tabel.
3. Primary Key → PK.
4. Relationship → FK.
5. Kardinalitas menentukan apakah perlu tabel tambahan.

---

## 7. Data Warehouse

### Struktur Tabel Data Warehouse
#### Dimensi
- ### `dim_categories`
| Kolom        | Tipe Data                                                          | Keterangan         |
| ------------ | ------------------------------------------------------------------ | ------------------ |
| category\_id | INT (PK, AUTO\_INCREMENT)                                          | ID unik kategori   |
| name         | VARCHAR(100), UNIQUE, NOT NULL                                     | Nama kategori      |
| description  | TEXT                                                               | Deskripsi kategori |
| created\_at  | TIMESTAMP, default CURRENT\_TIMESTAMP                              | Waktu dibuat       |
| updated\_at  | TIMESTAMP, default CURRENT\_TIMESTAMP ON UPDATE CURRENT\_TIMESTAMP | Waktu diperbarui   |

- ### `dim_recipes`
| Kolom               | Tipe Data                                                          | Keterangan                                     |
| ------------------- | ------------------------------------------------------------------ | ---------------------------------------------- |
| recipe\_id          | INT (PK)                                                           | ID unik resep                                  |
| url                 | TEXT                                                               | URL sumber resep                               |
| title               | VARCHAR(255), NOT NULL                                             | Judul resep                                    |
| description         | TEXT                                                               | Deskripsi resep                                |
| scraped\_at         | VARCHAR(128)                                                       | Waktu scraping                                 |
| difficulty\_level   | VARCHAR(50)                                                        | Tingkat kesulitan resep (field tambahan di DW) |
| author              | VARCHAR(100)                                                       | Nama penulis resep                             |
| image\_url          | TEXT                                                               | URL gambar resep                               |
| published\_date     | VARCHAR(128)                                                       | Tanggal publikasi                              |
| ingredients\_count  | INT                                                                | Jumlah bahan                                   |
| instructions\_count | INT                                                                | Jumlah langkah                                 |
| created\_at         | TIMESTAMP, default CURRENT\_TIMESTAMP                              | Waktu dibuat                                   |
| updated\_at         | TIMESTAMP, default CURRENT\_TIMESTAMP ON UPDATE CURRENT\_TIMESTAMP | Waktu diperbarui                               |

- ### `dim_ingredients`
| Kolom          | Tipe Data                                                          | Keterangan       |
| -------------- | ------------------------------------------------------------------ | ---------------- |
| ingredient\_id | INT                                                                | ID unik bahan    |
| recipe\_id     | INT (FK → dim\_recipes.recipe\_id)                                 | ID resep terkait |
| quantity       | DECIMAL(10,2)                                                      | Jumlah bahan     |
| unit           | VARCHAR(50)                                                        | Satuan bahan     |
| name           | TEXT                                                               | Nama bahan       |
| created\_at    | TIMESTAMP, default CURRENT\_TIMESTAMP                              | Waktu dibuat     |
| updated\_at    | TIMESTAMP, default CURRENT\_TIMESTAMP ON UPDATE CURRENT\_TIMESTAMP | Waktu diperbarui |

- ### `fact_recipes`
| Kolom               | Tipe Data                                                          | Keterangan                |
| ------------------- | ------------------------------------------------------------------ | ------------------------- |
| recipe\_id          | INT (PK, FK → dim\_recipes.recipe\_id)                             | ID resep                  |
| category            | VARCHAR(100), FK → dim\_categories.name                            | Nama kategori             |
| chill\_time         | INT                                                                | Waktu pendinginan (menit) |
| prep\_time          | INT                                                                | Waktu persiapan (menit)   |
| cook\_time          | INT                                                                | Waktu memasak (menit)     |
| servings            | INT                                                                | Jumlah porsi              |
| total\_time         | INT                                                                | Total waktu (menit)       |
| ingredients\_count  | INT                                                                | Jumlah bahan              |
| instructions\_count | INT                                                                | Jumlah langkah            |
| created\_at         | TIMESTAMP, default CURRENT\_TIMESTAMP                              | Waktu dibuat              |
| updated\_at         | TIMESTAMP, default CURRENT\_TIMESTAMP ON UPDATE CURRENT\_TIMESTAMP | Waktu diperbarui          |


### ERD & Star Schema
![ERD DW](Data%20Warehouse/design/datawrehouse_erd.png)  
![Star Schema](Data%20Warehouse/design/datawarehouse_star_schema.png)  

---

### Translasi ERD ke Data Warehouse
1. Entity → tabel dimensi/fakta.
2. PK dimensi → FK di fakta.
3. Atribut deskriptif di dimensi.
4. Atribut terukur di fakta.

---

## 8. Screenshot Program
**Database Operasional:**  
![DB Screenshot 1](Data%20Storing/screenshot/Screenshot%202025-08-04%20155512.png)  
![DB Screenshot 2](Data%20Storing/screenshot/Screenshot%202025-08-04%20155611.png)  

**Data Warehouse:**  
![DW Screenshot 1](Data%20Warehouse/screenshot/Screenshot%202025-08-08%20111831.png)  
![DW Screenshot 2](Data%20Warehouse/screenshot/Screenshot%202025-08-08%20111844.png)  

---

## 9. Referensi
- **Library Python**:
  - `requests` → HTTP request
  - `beautifulsoup4` → Parsing HTML
  - `json` untuk menyimpan hasil scraping
  - `sqlalchemy`,`mysql.connector`, `pymysql` → Koneksi MySQL

- **Sumber Data**:
  - [Shugary Sweets](https://www.shugarysweets.com) – sumber resep kue populer
