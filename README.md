# Database Roller Coaster yang Dibuka pada Tahun 2025

## Author
**Nama:** *Anella Utari Gunadi*  
**NIM:** *13523078*  

---

## Deskripsi Singkat
Proyek ini merupakan implementasi web scraping menggunakan **Python**, **BeautifulSoup**, dan **Requests** untuk mengumpulkan data roller coaster yang baru dibuka pada tahun 2025 yang diambil dari [rcdb.com](https://rcdb.com/r.htm?order=1&ot=2&op=2025).  
Scraper ini menghasilkan tiga file JSON:  

1. **`roller_coasters.json`** → berisi detail roller coaster seperti nama, park_id, manufacturer_id, jenis, desain, status, dan tanggal dibuka.  
2. **`parks.json`** → berisi nama taman hiburan dan lokasinya.  
3. **`manufacturers.json`** → berisi nama produsen roller coaster beserta lokasinya.  

Topik ini dipilih karena data roller coaster memiliki struktur yang jelas, menarik untuk dianalisis, dan cocok untuk mempraktikkan integrasi antara web scraping, penyimpanan data yang terstruktur, dan pemodelan basis data.

---

## Cara Menggunakan Scraper

1. **Instal dependensi**  
   ```bash
   pip install requests beautifulsoup4

2. **Jalankan scraper**  
   Pastikan Anda berada di direktori `Data Scraping/src` dengan mengetik
   ```bash
   cd Data Scraping/src
   ```
   Kemudian jalankan perintah berikut:  
   ```bash
   python scrape.py
   ```
   Program akan otomatis mengunjungi halaman RCDB, mengambil detail roller coaster, park, dan manufacturer, lalu menyimpannya ke folder `Data Scraping/data/`

3. **Output yang dihasilkan**  
   Setelah proses scraping selesai, hasilnya akan disimpan dalam tiga file JSON di dalam folder `Data Scraping/data/`:
   - `roller_coasters.json`
   - `parks.json`
   - `manufacturers.json`

## Struktur File JSON

- **`roller_coasters.json`**  
    ```json
    [
        {
            "id": 21311,
            "name": "Adrena-Line",
            "park_id": 21275,
            "manufacturer_id": 6836,
            "type": "Steel",
            "design": "Suspended",
            "status": "Under Construction",
            "opened": "2025"
        },
        ...
    ]
    ```
**Keterangan:**
  - `id`: ID unik roller coaster.
  - `name`: Nama roller coaster.
  - `park_id`: ID taman hiburan tempat roller coaster berada.
  - `manufacturer_id`: ID produsen roller coaster.
  - `type`: Jenis konstruksi roller coaster.
  - `design`: Desain kursi roller coaster.
  - `status`: Status operasional roller coaster.
  - `opened`: Tanggal pembukaan roller coaster.

- **`parks.json`**  
    ```json
    [
        {
            "id": 21275,
            "name": "Six Flags Qiddiya City",
            "location": {
            "city": "Al Muzahimiyah",
            "region": "Ar Riyadh",
            "country": "Saudi Arabia"
            }
        },
        ...
    ]
    ```
**Keterangan:**
    - `id`: ID unik taman hiburan.
    - `name`: Nama taman hiburan.
    - `location`: Lokasi taman hiburan yang mencakup:
        - `city`: Kota tempat taman berada.
        - `region`: Wilayah atau provinsi.
        - `country`: Negara tempat taman berada.

- **`manufacturers.json`**  
    ```json
    [
        {
            "id": 6836,
            "name": "Vekoma",
            "location": {
            "city": "Vlodrop",
            "region": "Limburg",
            "country": "Netherlands"
            }
        },
        ...
    ]
    ```
**Keterangan:**
    - `id`: ID unik produsen roller coaster.
    - `name`: Nama produsen roller coaster.
    - `location`: Lokasi produsen yang mencakup:
        - `city`: Kota tempat produsen berada.
        - `region`: Wilayah atau provinsi.
        - `country`: Negara tempat produsen berada.

## Struktur ERD dan Diagram Relasional RDBMS

- **ERD (Entity-Relationship Diagram)**    
![ERD Roller Coaster](https://raw.githubusercontent.com/AnellaUtari/Seleksi-2025-Tugas-1/main/Data%20Storing/design/ERD.jpg)

- **Diagram Relasional RDBMS**  
![Diagram Relasional Roller Coaster](https://raw.githubusercontent.com/AnellaUtari/Seleksi-2025-Tugas-1/main/Data%20Storing/design/Relational_Diagram.jpg)

## Proses Translasi ERD menjadi Diagram Relasional
Dalam ERD terdapat 6 entitas, yaitu `RollerCoaster`, `Park`, `Manufacturer`, `City`, `Region`, dan `Country`.
Seluruh hubungan antar entitas adalah one-to-many, sehingga proses translasi dilakukan dengan cara:
    - Menambahkan foreign key pada entitas yang memiliki hubungan many yang merujuk ke entitas yang memiliki hubungan one.
    - Memastikan setiap entitas memiliki primary key yang unik.
    Contoh:
        - `RoallerCoaster.park_id` -> foreign key ke `Park.park_id`
        - `RollerCoaster.manufacturer_id` -> foreign key ke `Manufacturer.manufacturer_id`
        - dan seterusnya untuk entitas lainnya.

## Screenshot Program



## Referensi

- **Library yang digunakan**  
    - [Requests](https://docs.python-requests.org/en/latest/)
    - [BeautifulSoup](https://www.crummy.com/software/BeautifulSoup/bs4/doc/)

- **Sumber data**  
    - [RCDB - Roller Coaster Database](https://rcdb.com/r.htm?order=1&ot=2&op=2025)