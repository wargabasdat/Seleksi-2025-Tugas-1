# NCIS TV Series ETL Database Project
> Tugas Seleksi Tahap 2 Asisten Basis Data 2025

## Author
| Nama | NIM |
|------|-----|
| Naomi Risaka Sitorus | 13523122 |

## Deskripsi
<p align = justify>Proyek ini merupakan implementasi proses ETL (Extract, Transform, Load) untuk data serial TV NCIS. Topik ini dipilih karena menonton serial NCIS adalah kegiatan yang senang dilakukan author pada waktu luang maupun waktu tidak luang untuk refreshing sejenak. Situs epguides.com dan TVmaze yang digunakan pada proyek ini seringkali author gunakan untuk mencari informasi terkait episode NCIS yang ingin ditonton sebab NCIS merupakan serial televisi detektif dari CBS yang telah berjalan sejak 2003 dan hingga kini telah menyelesaikan 22 season.</p>
<p align = justify>Dalam proyek ini, dilakukan ekstraksi dan pemrosesan awal data terkait episode, orang-orang yang terlibat dalam episode, dan reaksi pengguna situs terhadap episode NCIS dari situs <a href = https://epguides.com/NCIS/>epguides.com</a> dan <a href = https://www.tvmaze.com/shows/60/ncis>TVmaze</a> NCIS yang disimpan dalam bentuk file JSON. Data ini kemudian dimuat ke dalam dua jenis database, yaitu basis data operasional dan data warehouse untuk keperluan analisis. Basis data dalam proyek ini disusun dengan DBMS MariaDB yang dipilih karena fiturnya yang lengkap, modern, dan mudah digunakan sekaligus performanya yang memadai untuk skala proyek ini.</p>

---

## Requirements
- MariaDB Server versi 10.11 atau yang lebih baru
- Python versi 3.7 atau yang lebih baru
- Library Python sebagaimana tercantum dalam file `requirements.txt`: requests, beautifulsoup4, mariadb

## Cara Menggunakan: Manual
### Scraper
Cara menggunakan scraper yang telah dibuat dan menggunakan hasil output-nya.
### Membangun RDBMS

---

## Cara Menggunakan: Automated Scheduling (Bonus)
Use the script

---

## Struktur File JSON
Penjelasan struktur dari file JSON yang dihasilkan scraper.

---

## Struktur ERD RDBMS
Struktur ERD dan diagram relasional RDBMS.
### Data Storing
### Data Warehousing (Bonus)

---

## Translasi ERD Menjadi Diagram Relasional
Penjelasan mengenai proses translasi ERD menjadi diagram relasional.
### Data Storing
### Data Warehousing (Bonus)

---

## Screenshot Hasil Program
Beberapa screenshot dari program yang dijalankan (image di-upload sesuai folder-folder yang tersedia, di README tinggal ditampilkan).
### Data Storing
### Data Warehousing (Bonus)

---

## Referensi 
- [Situs epguides.com NCIS](https://epguides.com/NCIS/)
- [Situs TVmaze NCIS](https://www.tvmaze.com/shows/60/ncis)
- [Dokumentasi MariaDB](https://mariadb.com/docs)
- [Dokumentasi Library Beautiful Soup](https://www.crummy.com/software/BeautifulSoup/bs4/doc/)
- [Dokumentasi Requests](https://requests.readthedocs.io/en/latest/)