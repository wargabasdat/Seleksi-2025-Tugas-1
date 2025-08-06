# <p align = center>NCIS TV Series ETL Project</p>
> Tugas Seleksi Tahap 2 Asisten Basis Data 2025

## Author
| Nama | NIM |
|------|-----|
| Naomi Risaka Sitorus | 13523122 |

## Daftar Isi
1. [Deskripsi](#deskripsi)
2. [Requirements](#requirements)
3. [Cara Menggunakan: Manual](#cara-menggunakan-manual)
4. [Cara Menggunakan: Automated Scheduling](#cara-menggunakan-automated-scheduling-bonus)
5. [Struktur File JSON](#struktur-file-json)
6. [Struktur ERD RDBMS](#struktur-erd-rdbms)
7. [Translasi ERD Menjadi Diagram Relasional](#translasi-erd-menjadi-diagram-relasional)
8. [Screenshot Hasil Program](#screenshot-hasil-program)
9. [Referensi](#referensi)

## Deskripsi
<p align = justify>Proyek ini merupakan implementasi proses ETL (Extract, Transform, Load) untuk data serial TV NCIS. Topik ini dipilih karena menonton serial NCIS adalah kegiatan yang senang dilakukan author pada waktu luang maupun waktu tidak luang untuk refreshing sejenak. Situs epguides.com dan TVmaze yang digunakan pada proyek ini seringkali author gunakan untuk mencari informasi terkait episode NCIS yang ingin ditonton sebab NCIS merupakan serial televisi detektif dari CBS yang telah berjalan sejak 2003 dan hingga kini telah menyelesaikan 22 season.</p>
<p align = justify>Dalam proyek ini, dilakukan ekstraksi dan pemrosesan awal data terkait episode, orang-orang yang terlibat dalam episode, dan reaksi pengguna situs terhadap episode NCIS dari situs <a href = https://epguides.com/NCIS/>epguides.com</a> dan <a href = https://www.tvmaze.com/shows/60/ncis>TVmaze</a> NCIS yang disimpan dalam bentuk file JSON. Data ini kemudian dimuat ke dalam dua jenis database, yaitu basis data operasional dan data warehouse untuk keperluan analisis. Basis data dalam proyek ini disusun dengan DBMS MariaDB yang dipilih karena fiturnya yang lengkap, modern, dan mudah digunakan sekaligus performanya yang memadai untuk skala proyek ini.</p>

## Requirements
- MariaDB Server versi 10.11 atau yang lebih baru
- Python versi 3.7 atau yang lebih baru
- Library Python sebagaimana tercantum dalam file `requirements.txt`: requests, beautifulsoup4, mariadb

## Cara Menggunakan: Manual
### Persiapan Awal
1. Clone repository ini dengan menjalankan perintah di bawah ini pada terminal IDE:
   ```sh
   https://github.com/naomirisaka/Seleksi-2025-Tugas-1.git
2. Buka folder hasil clone di IDE.
3. Lakukan instalasi library yang dibutuhkan dengan:
   ```sh
   pip install -r requirements.txt
### Scraper
1. Pindah ke direktori untuk melakukan scraping dengan:
   ```sh
   cd "Data Scraping/src"
2. Jalankan scraper untuk menghasilkan file JSON berdasarkan informasi dari situs epguides.com dan TVmaze yang disimpan di folder `Data Scraping/data` dengan:
   ```sh
   python scraper.py
### Membangun RDBMS
1. Pindah ke direktori untuk membangun basis data operasional dengan:
   ```sh
   cd "Data Storing/src"
2. Jalankan program untuk membangun basis data operasional `ncis_db` dengan:
   ```sh
   python db_maker.py
3. Pindah ke direktori untuk membangun data warehouse dengan:
   ```sh
   cd "Data Warehouse/src"
4. Jalankan program untuk membangun data warehouse `ncis_dw` dengan:
   ```sh
   python dw_maker.py
5. Basis data `ncis_db` dan `ncis_dw` yang dibuat dapat diakses melalui MariaDB Server pada terminal.

## Cara Menggunakan: Automated Scheduling (Bonus)
> [!NOTE]
> Pastikan telah melakukan [persiapan awal](#persiapan-awal) untuk mengclone repository serta memasang requirements program sebelum menjalankan automated scheduling.
### Konfigurasi MariaDB
1. Buat file konfigurasi `config.json` untuk MariaDB di `Data Storing/src` dan `Data Warehouse/src`.
2. Isi kredensial MariaDB di masing-masing file `config.json` dengan format sesuai file `config_temp.json` yang tersedia di `Data Storing/src` dan `Data Warehouse/src`.
    ```json
    {
    "db_user": "your_mariadb_username",
    "db_password": "your_mariadb_password"
    }
    ```
### Automated Scheduling: Windows
1. Buka `Task Scheduler` pada Windows.
2. Buat task baru dengan menekan pilihan `Create Task`.
3. Beri nama pada task yang dibuat.
4. Atur frekuensi dijalankannya proyek ETL ini pada bagian `Trigger`, misalnya setiap hari (`Daily`) pada pukul 19.35. 
5. Pada bagian `Action`, atur agar aksi yang dilakukan ialah menjalankan program (`Start a Program`) menggunakan script `run_etl.bat` yang tersedia.
6. Atur agar program hanya dijalankan ketika tersedia koneksi internet dengan mencentang opsi `Start only if the following network connection is available: Any connection` pada bagian `Conditions`. 
7. Simpan task yang dibuat dengan menekan tombol `OK`.
### Automated Scheduling: Linux atau MacOS
1. Buka `Crontab` pada Linux atau MacOS.
2. Buat file penjadwalan cron baru dengan:
   ```sh
   crontab -e
3. Atur frekuensi dijalankannya proyek ETL ini serta path ke script `run_etl.sh` dengan menambahkan baris sesuai format berikut pada bagian bawah editor:
   ```sh
   [menit] [jam] [tanggal] [bulan] [hari_pada_minggu] /absolute/path/to/run_etl.sh
4. Simpan file dan tutup editor.
### Keberjalanan
Program akan berjalan secara otomatis pada waktu yang ditentukan apabila komputer dalam keadaan menyala dan terkoneksi dengan internet. Waktu dijalankannya program tersimpan pada kolom `last_updated` tabel `Episode` pada `ncis_db` dan kolom `last_updated` tabel `FactEpisodePerformance` pada `ncis_dw`.

**Automated Scheduling pada `ncis_db`**</br>
Sebelum
![Automated Scheduling Before](Data%20Storing/screenshot/automated_scheduling_1.png)
Sesudah
![Automated Scheduling After](Data%20Storing/screenshot/automated_scheduling_2.png)

**Automated Scheduling pada `ncis_dw`**</br>
Sebelum
![DW Automated Scheduling Before](Data%20Warehouse/screenshot/automated_scheduling_dw_1.png)
Sesudah
![DW Automated Scheduling After](Data%20Warehouse/screenshot/automated_scheduling_dw_2.png)

## Struktur File JSON
Dihasilkan 4 file JSON dari proses scraping yang tersimpan di `Data Scraping\data`.
### 1. casts.json
Berisi informasi mengenai pemeran (cast) yang terlibat pada suatu episode serta karakter yang diperankannya.
- episode_id: integer
- actor: string
- character: string
- status: string (main/guest)
### 2. crews.json
Berisi informasi mengenai krew (crew) yang terlibat pada suatu episode serta perannya.
- episode_id: integer
- name: string
- role: string
- status: string (main/guest)
### 3. episodes.json
Berisi informasi mengenai episode dari seluruh season NCIS.
- episode_id: integer
- season: integer
- episode_in_season: integer
- title: string
- air_date: string (dalam format YYYY-MM-DD)
- summary: string
- rating_value: float
- rating_count: integer
### 4. comments.json
Berisi informasi mengenai komentar pada suatu episode.
- episode_id: integer
- comment_number: integer
- username: string
- content: string
- upvote_count: integer 
- downvote_count: integer

## Struktur ERD RDBMS
### Data Storing
**Entity-Relationship Diagram (ERD)**
![DB ERD](Data%20Storing/design/ERD.png)

**Diagram Relasional**
![DB Relational Diagram](Data%20Storing/design/Relational%20Diagram.png)

### Data Warehousing (Bonus)
**Entity-Relationship Diagram (ERD)**
![DW ERD](Data%20Warehouse/design/ERD%20DW.png)

**Diagram Relasional**
![DW Relational Diagram](Data%20Warehouse/design/Relational%20Diagram%20DW.png)

## Translasi ERD Menjadi Diagram Relasional
Penjelasan mengenai proses translasi ERD menjadi diagram relasional.
### Data Storing
### Data Warehousing (Bonus)

## Screenshot Hasil Program
Beberapa screenshot dari program yang dijalankan (image di-upload sesuai folder-folder yang tersedia, di README tinggal ditampilkan).
### Data Storing
### Data Warehousing (Bonus)

## Referensi 
- [Situs epguides.com NCIS](https://epguides.com/NCIS/)
- [Situs TVmaze NCIS](https://www.tvmaze.com/shows/60/ncis)
- [Dokumentasi MariaDB](https://mariadb.com/docs)
- [Dokumentasi Library Beautiful Soup](https://www.crummy.com/software/BeautifulSoup/bs4/doc/)
- [Dokumentasi Requests](https://requests.readthedocs.io/en/latest/)