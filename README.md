# Tugas 1 - Seleksi Lab Basis Data  

## Author  
- **Nama:** Mayla Yaffa Ludmilla
- **NIM:** 13523050

---

## Deskripsi Singkat  
Proyek ini bertujuan untuk membangun basis data karya seni lukis berdasarkan data dari situs TOPofART (https://www.topofart.com), yaitu situs yang menjul reproduksi karya lukis terkenal di dunia.  
Data yang dikumpulkan mencakup **informasi seniman**, **gaya seni (art styles)**, **subjek seni (art subjects)**, **museum**, dan **lukisan** beserta harga reproduksinya.  

Saya memilih topik ini karena saya terkadang suka melukis dan suka belajar mengenai lukisan dan topik ini memiliki relasi yang dapat diimplementasikan dengan baik di RDBMS.   

DBMS yang digunakan adalah **MariaDB / MySQL** karena mendukung tipe data yang dibutuhkan dan saya pernah menggunakannya dengan Python, bahasa yang saya pilih untuk web-scrape.

---

## Cara Menggunakan Scraper  

1. **Clone repository & masuk ke folder proyek**
    ```bash
    git clone "https://github.com/maymilla/Seleksi-Basdat-2025-Tugas-1.git"
    cd Seleksi-Basdat-2025-Tugas-1
    ```

2. **Aktifkan Virtual Environment** (opsional, tetapi disarankan)  
    ```bash
    python -m venv .venv
    .venv\Scripts\activate   # Windows
    source .venv/bin/activate  # Mac/Linux
    ```

3. **Install dependencies**
    ```bash
    pip install -r requirements.txt
    ```

4. **Jalankan scraper**  
    Scraper utama terdapat di folder `Data Scraping/src/`:
    ```bash
    python Data\ Scraping/src/scrape_artists.py
    python Data\ Scraping/src/scrape_art_mvt.py
    python Data\ Scraping/src/scrape_paintings.py
    ```
    Output akan disimpan ke folder `Data Scraping/data/` dalam format JSON.

5. **Gunakan hasil output untuk populate database**  
    Jalankan script `Data Storing/src/store_top_paintings.py`:
    ```bash
    python Data\ Storing/src/store_data.py
    ```
    Pastikan `DB_CONFIG` di script sudah sesuai dengan konfigurasi database lokal kamu.

---

## Struktur File JSON  

### 1. artists.json 
```json
{
  "name": "Vincent van Gogh",
  "url": "https://www.topofart.com/artists/Vincent-van-Gogh/",
  "birth_year": "1853",
  "death_year": "1890",
  "nationality": "Dutch",
  "art_style": "Post-Impressionist",
  "biography": "...",
  "total_pages": 18,
  "paintings": [
    {
      "title": "Starry Night",
      "year": "1889",
      "artist": "Vincent van Gogh",
      "oil_price_euro": "836",
      "canvas_price_euro": "58.32",
      "sku": "VVG-1101",
      "original_size": "73.7 x 92.1 cm",
      "museum": "Museum of Modern Art",
      "city": "New York",
      "country": "USA"
    }
  ]
}
```
### 2. art_styles.json

```json
{ "name": "High Renaissance" }
```

### 3. art_subjects.json
```json
{ "name": "Landscapes" }
```

### 4. museums.json
```json
{
  "name": "Museum of Modern Art",
  "city_name": "New York",
  "country": "USA"
}
```

### cities.json
```json
{ "name": "New York", "country": "USA" }
```

### 6. countries.json
```json
{ "name": "USA" }
```
# ER Diagram
<img width="1351" height="721" alt="ER Diagram" src="https://github.com/user-attachments/assets/21262484-d9c0-4483-ac49-848d009687f0" /><img width="1511" height="541" alt="ER Diagram" src="https://github.com/user-attachments/assets/a46d6cac-c0aa-4a6f-a8e8-461ddb365d3b" />

# Relational Diagram
<img width="1511" height="541" alt="Relational Diagram" src="https://github.com/user-attachments/assets/2cb812bd-bdf3-4b0d-b708-ead90639a39a" />

## Translasi ER Diagram ke Relational Diagram
- Setiap entitas pada ERD menjadi tabel di RDBMS.
- Setiap hubungan many-to-many (contoh: Artist ↔ Art_Style) diubah menjadi tabel penghubung (Artist_Style)).
- Untuk setiap hubungan many-to-one, tabel yang memiliki kardinalitas many ditambah atribut primary key dari tabel yang memiliki kardinalitas satu (contoh: Museum ↔ City, tabel museum ditambah 1 atribut yaitu id_city).
- Foreign key digunakan untuk menjaga referensial antar tabel.

# Screenshots
<img src="Data Storing/screenshot/painting.png" width="500">
<img src="Data Storing/screenshot/museum(1).png" width="500">
<img src="Data Storing/screenshot/art_subject.png" width="500">

# Library
### Library yang Digunakan
* requests – HTTP requests untuk scraping.
* beautifulsoup4 – Parsing HTML.
* re – Ekstraksi pola teks dengan regex.
* mysql-connector-python – Koneksi Python ke MySQL/MariaDB.
* json – Membaca/menulis file JSON.

### Sumber Data
topofart.com
