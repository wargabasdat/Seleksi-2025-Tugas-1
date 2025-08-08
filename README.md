<div align="center">
  <h1>Seleksi Warga Basdat 2025</h1>
  <h3>ETL Project – Video Game Database</h3>
  <p><em>This project was developed for <strong>Seleksi Warga Basdat 2025</strong></em></p>
  <p>
    <img src="https://img.shields.io/badge/Status-Completed-green?style=flat-square" alt="Status"/>
    <img src="https://img.shields.io/badge/Python-3776AB?style=flat-square&logo=python&logoColor=white" alt="Python"/>
    <img src="https://img.shields.io/badge/PostgreSQL-336791?style=flat-square&logo=postgresql&logoColor=white" alt="PostgreSQL"/>
    <img src="https://img.shields.io/badge/Task_Scheduler-Windows-blue?style=flat-square&logo=windows&logoColor=white" alt="Task Scheduler"/>
  </p>
  <img src="Data Warehouse/design/SchemaDataWarehouse_VideoGames.png" alt="Relational Schema" width="600"/>
</div>


## 👤 Author
- **Nama**: Heleni Gratia Meitrina Tampubolon
- **NIM**: 13523107



## 📘 Deskripsi Proyek

Proyek ini merupakan implementasi ETL (Extract, Transform, Load) dari data video game yang diambil dari web IMDb Video Games. Data mencakup informasi video game seperti judul, tahun rilis, rating, age rating, deskripsi, sutradara, dan aktor. Data kemudian disimpan dalam PostgreSQL dengan desain RDBMS terstruktur.

**Alasan pemilihan topik:**
Topik video game dipilih karena memiliki:
- Struktur data yang memiliki banyak atribut dan cocok untuk relasi antar entitas.
- Popularitas bagi pengguna internet.
- Sumber data terbuka dari IMDb.


## ⚙️ Cara Menjalankan Scraper & Insert Data

### 1. Scraping Data
Scraper mengambil data dari web IMDb menggunakan `DataScraping_VideoGames.ipynb`.

Untuk menjalankan scraper, ikuti langkah berikut:

Buka notebook menggunakan salah satu IDE berikut:
- Jupyter Notebook / Jupyter Lab
- VS Code (dengan extension Jupyter)
- Google Colab (bisa langsung buka file .ipynb)

Lalu jalankan semua sel dengan opsi "Run All" (biasanya di toolbar atas).

### 2. Menyimpan ke Database
Setelah proses scraping selesai, akan dihasilkan tiga file JSON berikut di folder Data Scraping/data/:
- videogames.json
- directors_videogames.json
- stars_videogames.json

File JSON ini nantinya akan digunakan pada proses insert_data.py untuk menyimpan ke dalam database PostgreSQL.
```bash
cd Data Storing/src
python3 create_tables.py
python3 insert_data.py
```
## 📂 Struktur File JSON

#### videogames.json
Berisi daftar video game beserta metadata dan relasinya terhadap sutradara dan pemeran. Setiap elemen di dalam array JSON ini memiliki struktur sebagai berikut:
```bash
{
  "title": "Red Dead Redemption II",
  "year": "2018",
  "age rating": "M",
  "rating": "9.7",
  "description": "Follows outlaw Arthur Morgan and his gang...",
  "directors": [],
  "stars": [1, 2, 3]
}
```
Penjelasan:
- title: Judul dari video game.
- year: Tahun rilis.
- age rating: Rating usia dari game tersebut (misal: M, T, E).
- rating: Skor rating IMDb (dalam format string, akan diubah ke float saat dimasukkan ke DB).
- description: Ringkasan cerita / sinopsis game.
- directors: List berisi ID direktur game (merujuk ke directors_videogames.json).
- stars: List berisi ID aktor / pengisi suara utama (merujuk ke stars_videogames.json).


#### directors_videogames.json
Berisi daftar director/sutradara video game yang muncul dalam videogames.json.
```bash
{
  "id": 1,
  "name": "Neil Druckmann"
}

```
Penjelasan:
- id: ID unik untuk director.
- name: Nama lengkap director.

#### stars_videogames.json
Berisi daftar pemeran utama atau pengisi suara dari video game.
```bash
{
  "id": 1,
  "name": "Benjamin Byron Davis"
}
```
Penjelasan:
- id: ID unik untuk aktor.
- name: Nama lengkap pemeran/pengisi suara.

Struktur ini mencerminkan relasi many-to-many antara entitas videogame - star dan videogame - director, yang kemudian direpresentasikan di RDBMS menggunakan tabel relasi cast_credit dan director_credit.

## 🗂️ Struktur ERD & Diagram Relasional RDBMS

####  Entity-Relationship Diagram (ERD)
<img src="Data Storing/design/ERD_VideoGame.png" alt="Relational Schema" width="600"/>

####  Diagram Relasional
<img src="Data Storing/design/Diagram Relasional_VideoGame.png" alt="Relational Schema" width="600"/>

Penjelasan:

- videogame: Entitas utama yang berisi informasi seputar video game seperti judul, tahun rilis, deskripsi, rating, dan sebagainya.
- director dan star: Entitas yang menyimpan data individu yang berperan sebagai sutradara dan pemeran utama.
- director_credit dan cast_credit: Tabel relasi many-to-many yang menghubungkan video game dengan para sutradara (director) dan pemeran (star).
Relasi:
- Satu video game bisa memiliki banyak star dan director, dan sebaliknya satu star/director bisa terlibat di banyak videogame.
Oleh karena itu, digunakan dua tabel penghubung (cast_credit dan director_credit) untuk menyimpan relasi many-to-many.

## 🔄 Proses Translasi ERD ke Diagram Relasional
Proses translasi dari ERD (Entity Relationship Diagram) ke model relasional dilakukan melalui langkah-langkah berikut:
1. Entitas menjadi Tabel

Setiap entitas dalam ERD seperti Videogame, Director, dan Star diterjemahkan menjadi tabel dalam basis data relasional dengan nama yang sama.

2. Setiap atribut dalam entitas menjadi kolom di tabel. 

Seperti atribut title, year, dan rating pada entitas Videogame menjadi kolom title, year, rating dalam tabel videogame.

3. Primary Key

Masing-masing tabel diberikan primary key, seperti id pada tabel videogame, director, dan star.

4. Relasi Many-to-Many

Relasi many-to-many antara Videogame dan Director, serta antara Videogame dan Star, tidak bisa langsung direpresentasikan di RDBMS. Oleh karena itu, dibentuk tabel relasi:
- director_credit(videogame_id, director_id)
- cast_credit(videogame_id, star_id)
Setiap tabel relasi ini menyimpan pasangan foreign key yang menunjuk ke primary key di masing-masing entitas yang terhubung.

5. Foreign Key

Kolom foreign key digunakan untuk menjaga integritas data antar tabel:

- director_credit.director_id mengacu ke director.id

- cast_credit.star_id mengacu ke star.id

- director_credit.videogame_id dan cast_credit.videogame_id mengacu ke videogame.id

6. Normalisasi

Struktur data dinormalisasi minimal hingga 3NF (Third Normal Form) untuk menghindari redundansi data dan menjaga integritas.Seperti, informasi direktur dan aktor dipisah dalam tabel tersendiri sehingga tidak perlu diulang pada setiap entri game.

## 📸 Screenshots

<div align="center">
  <table>
    <tr>
      <td align="center">
        <img src="Data Storing/screenshot/director_credit_first.png" alt=" Director Credit " width="300"/>
        <br><b>Director Credit Table</b>
      </td>
      <td align="center">
        <img src="Data Storing/screenshot/star_first.png" alt="Star" width="300"/>
        <br><b>Star Table</b>
      </td>
      <td align="center">
        <img src="Data Warehouse/screenshot/top_directors_by_avg_rating.png.png" alt="Top Director" width="300"/>
        <br><b>Top Directors by Average Rating</b>
      </td>
    </tr>
  </table>
</div>

## ⏰ Penjadwalan Otomatis
Untuk mendukung pembaruan data secara berkala, proses insert/update data ke database dijadwalkan secara otomatis menggunakan Task Scheduler di Windows. Hal ini memastikan data selalu diperbarui tanpa perlu menjalankan skrip secara manual.

Menjalankan di Windows:
1. Buka Task Scheduler di Windows.
2. Klik Create Task.
Beri nama dan deskripsi task (misalnya: Update VideoGame Database).
3. Pilih Daily sebagai frekuensi di section Trigger. Pilih juga jam kapan task dijalankan.
4. Pada bagian Action, pilih Start a program.
5. Klik Browse, lalu pilih file automatic.bat yang terletak pada:
```bash
Data Warehouse/src/automatic.bat
```
6. Isikan path dari folder tempat file .bat berada di bagian Start in (optional).
7. Klik OK untuk menyelesaikan pembuatan task.
8. Verifikasi Task
Task akan muncul di daftar Task Scheduler Library.
9. Klik kanan pada task, kemudian Run untuk mengetes apakah proses berjalan lancar.
10. Data di database seharusnya terupdate tanpa menimbulkan redundansi.

<div align="center">
  <table>
    <tr>
      <td align="center">
        <img src="Data Warehouse/screenshot/task_scheduler.png" alt=" Director Credit " width="300"/>
        <br><b>Task Scheduler</b>
      </td>
      <td align="center">
        <img src="Data Warehouse/screenshot/scheduler.png" alt="Star" width="300"/>
        <br><b>At Database (using dummy data added to json file)</b>
      </td>
    </tr>
  </table>
</div>

Dengan proses ini, pembaruan data dilakukan secara otomatis dan efisien tanpa perlu intervensi manual. Timestamp pada kolom extracted_at juga mencatat waktu ekstraksi terbaru untuk setiap data yang diperbarui.

## 📚 Referensi
📦 Library yang Digunakan
- selenium: untuk melakukan web scraping berbasis browser.

- bs4 / BeautifulSoup: untuk parsing konten HTML dari halaman web.

- requests: untuk melakukan permintaan HTTP ke situs web.

- re: untuk pencocokan dan pembersihan teks menggunakan regex.

- json: untuk manipulasi dan penyimpanan data JSON.

- time: untuk penundaan dalam scraping.

- datetime: untuk mencatat waktu ekstraksi data.

- psycopg2: untuk koneksi dan interaksi dengan database PostgreSQL.

- os: untuk navigasi sistem file.

🌐 Sumber Data

IMDb List: https://www.imdb.com/list/ls507147151/