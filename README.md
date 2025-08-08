# ETL Project Seleksi 1 Basdat - Super Smash Bros. Ultimate Spirits

## 👤 Author
- **Nama**: Ahmad Evander Ruizhi Xavier
- **NIM**: 18223064

---

## 📌 Deskripsi Proyek
Proyek ini bertujuan untuk melakukan *web scraping* terhadap data *Spirits* dari game **Super Smash Bros. Ultimate**, kemudian menyimpannya dalam format terstruktur (JSON) dan memasukkannya ke dalam **Relational Database Management System (RDBMS)** menggunakan PostgreSQL. Spirits pada game Super Smash Bros. Ultimate merupakan komponen penting dalam game yang memuat seluruh karakter (baik yang bisa dimainkan maupun yang hanya menjadi pendukung) dari berbagai serial yang terdapat dalam game.

Topik ini dipilih karena author memiliki pengetahuan yang cukup dalam mengenai informasi game dan struktur data spirits yang cukup kompleks. Selain itu, web refrensi menampilkan data yang tersusun dengan kurang rapi dan tidak konsisten sehingga cocok untuk dijadikan proyek ETL.

---

## 🕹️ Cara Menggunakan Scraper dan Output-nya
1. Clone atau unduh repository ini
2. Buka terminal dari direktori:  
   ```bash
   ../Data Scraping/src/
3. Jalankan program dengan perintah berikut (atau disesuaikan dengan virtual environment yang digunakan):
    ```bash
    python scraping.py
4. Seluruh file JSON yang diperlukan akan didapat dan disimpan pada direktori yang sama. File output yang dihasilkan adalah:
    - ability.json
    - equipable_spirits.json
    - obtaining_method.json
    - primary_spirits.json
    - series.json
    - spirits_obtain.json
    - spirits.json
    - support_spirits.json
5. Seluruh file JSON output dipindahkan ke direktori:
   ```bash
   ../Data Scraping/data/
6. Pindah ke direktori:
   ```bash
   ../Data Storing/src/
7. Jalankan program untuk melakukan storing data ke RDBMS. Pastikan RDBMS menggunakan parameter global yang tertera pada kode, dan seluruh tabel yang diperlukan sudah dibuat:
    ```bash
    python storing.py
## Penjelasan Struktur File JSON yang Dihasilkan *Scraper*
