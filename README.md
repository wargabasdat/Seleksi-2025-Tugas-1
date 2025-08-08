TUGAS SELEKSI 1 - Proyek ETL K-Pop Awards
Author
Nama: [Isi Nama Anda di sini]

NIM: [Isi NIM Anda di sini]

Deskripsi Proyek
Proyek ini merupakan implementasi proses ETL (Extract, Transform, Load) yang berfokus pada data penghargaan mingguan dari acara musik K-pop. Data mentah diekstrak dari situs web soridata.com menggunakan web scraper kustom. Data yang dikumpulkan kemudian dinormalisasi dan disimpan ke dalam sistem basis data relasional (RDBMS) menggunakan MySQL.

Topik ini dipilih karena data penghargaan K-pop sangat terstruktur dan konsisten, menjadikannya sumber yang ideal untuk mempraktikkan teknik web scraping dan perancangan database. Strukturnya yang jelas memudahkan proses normalisasi dan perancangan skema database yang logis.

Cara Menggunakan Scraper
Untuk menjalankan scraper dan memproses data, ikuti langkah-langkah berikut secara berurutan:

Ekstraksi Data Penghargaan:
Jalankan skrip scraping_awards.py untuk mengumpulkan data penghargaan mingguan dari soridata.com dan menyimpannya ke Data Scraping/data/awards.json.

cd "Data Scraping/src"
python scraping_awards.py

Ekstraksi Data Artis:
Jalankan skrip scraping_artist.py untuk mengekstrak informasi detail artis dari tautan yang ditemukan di awards.json dan menyimpannya ke Data Scraping/data/artists.json.

python scraping_artist.py

Transformasi Data:
Jalankan skrip transform_data.py untuk membersihkan dan menormalisasi data dari file JSON yang telah dibuat. Skrip ini juga akan menghasilkan show.json dan song.json yang lebih terstruktur.

python transform_data.py

Memuat Data ke Database:
Jalankan skrip storing.py untuk membuat skema database di MySQL dan memuat semua data yang telah diubah ke dalam tabel-tabel yang sesuai. Pastikan Anda telah mengonfigurasi koneksi database di dalam skrip ini.

cd "../../Data Storing/src"
python storing.py

Struktur File JSON
Berikut adalah deskripsi struktur file JSON yang dihasilkan oleh scraper:

awards.json: Berisi daftar penghargaan yang dinormalisasi. Setiap objek merepresentasikan satu penghargaan dan terhubung ke tabel lain melalui ID.

[
  {
    "show": "nama_acara",
    "week": 1,
    "year": 2024,
    "group_song_id": "id_lagu_pemenang"
  }
]

artists.json: Berisi informasi detail tentang artis, termasuk tanggal debut dan tampilan YouTube.

[
  {
    "name": "nama_artis",
    "debut_date": "tanggal_debut",
    "views": "jumlah_views_youtube"
  }
]

show.json: Berisi daftar acara musik dengan informasi tambahan seperti stasiun TV.

[
  {
    "name": "nama_acara",
    "schedule": "jadwal_tayang",
    "episode": 123,
    "station": "stasiun_tv"
  }
]

song.json: Berisi daftar lagu, terhubung dengan artis yang menyanyikannya.

[
  {
    "id": "id_lagu_unik",
    "group": "nama_grup",
    "song": "judul_lagu",
    "artist_name": "nama_artis_terkait"
  }
]

Struktur ERD dan Diagram Relasional RDBMS
Entity-Relationship Diagram (ERD)
Diagram Relasional
Translasi ERD ke Diagram Relasional
Proses translasi dari ERD ke diagram relasional mengikuti langkah-langkah standar:

Entitas menjadi Tabel: Setiap entitas utama dalam ERD (Show, Artist, Song, Award) diubah menjadi tabel terpisah dalam RDBMS.

Atribut menjadi Kolom: Setiap atribut dari entitas diubah menjadi kolom dalam tabel yang sesuai.

Kunci Primer (Primary Key): Kunci unik diidentifikasi untuk setiap tabel. Misalnya, name menjadi PRIMARY KEY untuk Show dan Artist. Untuk Award, kombinasi show_name, year, dan week digunakan sebagai PRIMARY KEY.

Hubungan menjadi Kunci Asing (Foreign Key): Relasi antar entitas direpresentasikan melalui FOREIGN KEY.

Tabel Song memiliki artist_name sebagai FOREIGN KEY yang mereferensikan Artist.name, karena satu artis bisa memiliki banyak lagu (hubungan one-to-many).

Tabel Award memiliki show_name yang mereferensikan Show.name dan song_id yang mereferensikan Song.id, karena satu acara atau lagu bisa memiliki banyak penghargaan (hubungan one-to-many).

Screenshot Program
Berikut adalah beberapa tangkapan layar dari hasil scraping dan database:

Tampilan Data JSON Hasil Scraper:
![Tampilan data JSON](Data Storing/screenshot/Screenshot%20(1126).png)

Koneksi ke Database MySQL:
![Koneksi MySQL](Data Storing/screenshot/Screenshot%20(1122).png)

Tampilan Tabel di MySQL:
![Tabel di MySQL](Data Storing/screenshot/Screenshot%20(1123).png)

Tampilan Data di Tabel:
![Data di Tabel](Data Storing/screenshot/Screenshot%20(1124).png)

Referensi
Library Python:

requests: Untuk membuat permintaan HTTP ke situs web.

BeautifulSoup4: Untuk mem-parsing HTML.

mysql-connector-python: Untuk terhubung dan berinteraksi dengan database MySQL.

json: Untuk membaca dan menulis data dalam format JSON.

os: Untuk berinteraksi dengan sistem file.

Sumber Data:

https://soridata.com: Situs web tempat data penghargaan K-pop di-scrape.
