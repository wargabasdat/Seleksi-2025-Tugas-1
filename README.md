# TUGAS SELEKSI 1 - Proyek ETL K-Pop Awards

## Author

**Nama:** \Qodri Azkarayan
**NIM:** \13523010

---

## Deskripsi Proyek

Proyek ini merupakan implementasi proses **ETL (Extract, Transform, Load)** yang berfokus pada data penghargaan mingguan dari acara musik K-pop. Data mentah diekstrak dari situs web [soridata.com](https://soridata.com) menggunakan web scraper kustom. Data yang dikumpulkan kemudian dinormalisasi dan disimpan ke dalam sistem basis data relasional (**RDBMS**) menggunakan MySQL.

Topik ini dipilih karena aku suka kpop hwehwehwe. Selain itu struktur data di website yang aku pilih sangat tersusun dengan baik sehingga memudahkan aku untuk melakukan scraping

---

## Cara Menggunakan Scraper

Ikuti langkah-langkah berikut untuk menjalankan scraper dan memproses data:

### 1. Ekstraksi Data Penghargaan

```bash
cd "Data Scraping/src"
python scraping_awards.py
```

Data akan disimpan di `Data Scraping/data/awards.json`.

### 2. Ekstraksi Data Artis

```bash
python scraping_artist.py
```

Data akan disimpan di `Data Scraping/data/artists.json`.

### 3. Transformasi Data

```bash
python transform_data.py
```

Proses ini akan menghasilkan `show.json` dan `song.json` yang sudah dinormalisasi.

### 4. Memuat Data ke Database

```bash
cd "../../Data Storing/src"
python storing.py
```

> **Catatan:** Pastikan konfigurasi koneksi database di `storing.py` sudah sesuai.

---

## Struktur File JSON

### awards.json

```json
[
  {
    "show": "nama_acara",
    "week": 1,
    "year": 2024,
    "group_song_id": "id_lagu_pemenang"
  }
]
```

### artists.json

```json
[
  {
    "name": "nama_artis",
    "debut_date": "tanggal_debut",
    "views": "jumlah_views_youtube"
  }
]
```

### show\.json

```json
[
  {
    "name": "nama_acara",
    "schedule": "jadwal_tayang",
    "episode": 123,
    "station": "stasiun_tv"
  }
]
```

### song.json

```json
[
  {
    "id": "id_lagu_unik",
    "group": "nama_grup",
    "song": "judul_lagu",
    "artist_name": "nama_artis_terkait"
  }
]
```

---

## Struktur ERD dan Diagram Relasional

1. **Entitas menjadi Tabel** → Show, Artist, Song, Award.
2. **Atribut menjadi Kolom** → Contoh: `name`, `schedule`, `episode`.
3. **Primary Key** → `name` untuk Show/Artist, `(show_name, year, week)` untuk Award.
4. **Foreign Key** →

   * Song.artist\_name → Artist.name
   * Award.show\_name → Show\.name
   * Award.song\_id → Song.id

---

## Screenshot Program

![Tampilan data JSON](Data%20Storing/screenshot/Screenshot%20\(1126\).png)

![Tabel di MySQL](Data%20Storing/screenshot/Screenshot%20\(1123\).png)

---

## Referensi

**Library Python:**

* requests
* BeautifulSoup4
* mysql-connector-python
* json
* os

**Sumber Data:**

* [soridata.com](https://soridata.com)

