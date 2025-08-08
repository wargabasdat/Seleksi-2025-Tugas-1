# ETL Project: Data Scraping, Database Modeling, and Data Storing

## Author : Aliya Harta STI'23 (18223081)

## Description
Data yang digunakan adalah Top 100 The Most Beautiful Face 2023 by TC Candler. Penggunaan data ini karena website memberikan data yang cukup terstruktur (ranked list) dimana cocok untuk scrapping dengan BeautifulSoup. Selanjutnya website tidak perlu login dan tidak memerlukan API key. 
Berdasarkan data dapat diproses untuk mendapatkan informasi serta dengan penambahan beberapa informasi eksternal dapat dikembangkan lebih lanjut. Database disimpan dalam 3 tabel yaitu Person (rank, personName), Job(jobsid, jobname), Country(countryid, countryname). 
DMBS yang digunakan adalah Postgree SQL.

## Scrapper
Scrapping diawali dengan request ke website, lalu parsing html, dan ekstrasi data dengan regex, memisahkan nama dan description, job dan country dan menyimpan hasil ke json

## Struktur JSON 
Struktur JSON yang dihasilkan adalah rank, nama, job dan asal. 

## Struktur ERD dan Relasional
Database disimpan dalam 3 tabel yaitu Person (rank, personName), Job(jobsid, jobname), Country(countryid, countryname). 
DMBS yang digunakan adalah Postgree SQL.
Translasi dipetakan dengan mengambil PK dari one yang diberikan ke tabel many.

## Referensi 
https://www.haibunda.com/moms-life/20231230164315-76-325037/daftar-100-perempuan-tercantik-di-dunia-2023-ada-lyodra-hingga-jisoo-blackpink
