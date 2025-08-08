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

1. **`roller_coasters.json`**  
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

2. **`parks.json`**  
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

3. **`manufacturers.json`**  
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

- ### ERD (Entity-Relationship Diagram) ###
![ERD Roller Coaster](https://raw.githubusercontent.com/AnellaUtari/Seleksi-2025-Tugas-1/main/Data%20Storing/design/ERD.jpg)

Terdapat 6 entitas utama dalam ERD ini:
1. **RollerCoaster**
   - Atribut: `coaster_id`, `name`, `type`, `design`, `status`, `opened`
   - Primary Key: `coaster_id`
   - Relasi:
        - **Belongs To** -> `Park`: Many to One,
        yaitu setiap roller coaster berada di tepat satu taman hiburan dan satu taman hiburan dapat memiliki banyak roller coaster.
        - **Made By** -> `Manufacturer`: Many to One,
        yaitu setiap roller coaster dibuat oleh tepat satu produsen dan satu produsen dapat membuat banyak roller coaster.

2. **Park**
    - Atribut: `park_id`, `park_name`
    - Primary Key: `park_id`
    - Relasi:
        - **Belongs To** -> `RollerCoaster`: One to Many,
        yaitu setiap taman hiburan dapat memiliki banyak roller coaster, tetapi setiap roller coaster hanya berada di satu taman hiburan.
        - **Located In** -> `City`: Many to One,
        yaitu setiap taman hiburan berada di tepat satu kota dan satu kota dapat memiliki banyak taman hiburan.

3. **Manufacturer**
    - Atribut: `manufacturer_id`, `manufacturer_name`
    - Primary Key: `manufacturer_id`
    - Relasi:
        - **Made By** -> `RollerCoaster`: One to Many,
        yaitu setiap produsen dapat membuat banyak roller coaster, tetapi setiap roller coaster hanya dibuat oleh satu produsen.
        - **Located In** -> `City`: Many to One,
        yaitu setiap produsen berada di tepat satu kota dan satu kota dapat memiliki banyak produsen.

4. **City**
    - Atribut: `city_id`, `city_name`
    - Primary Key: `city_id`
    - Relasi:
        - **Located In** -> `Park`: One to Many,
        yaitu setiap kota dapat memiliki banyak taman hiburan, tetapi setiap taman hiburan hanya berada di satu kota.
        - **Located In** -> `Manufacturer`: One to Many,
        yaitu setiap kota dapat memiliki banyak produsen, tetapi setiap produsen hanya berada di satu kota
        - **Located In** -> `Region`: Many to One,
        yaitu setiap kota berada di tepat satu wilayah dan satu wilayah dapat memiliki banyak kota.

5. **Region**
    - Atribut: `region_id`, `region_name`
    - Primary Key: `region_id`
    - Relasi:
        - **Located In** -> `City`: One to Many,
        yaitu setiap wilayah dapat memiliki banyak kota, tetapi setiap kota hanya berada di satu wilayah.
        - **Located In** -> `Country`: Many to One,
        yaitu setiap wilayah berada di tepat satu negara dan satu negara dapat memiliki banyak wilayah.

6. **Country**
    - Atribut: `country_id`, `country_name`
    - Primary Key: `country_id`
    - Relasi:
        - **Located In** -> `Region`: One to Many,
        yaitu setiap negara dapat memiliki banyak wilayah, tetapi setiap wilayah hanya berada di satu negara.

- ### Diagram Relasional RDBMS ###
![Diagram Relasional Roller Coaster](https://raw.githubusercontent.com/AnellaUtari/Seleksi-2025-Tugas-1/main/Data%20Storing/design/Relational_Diagram.jpg)

Terdapat 6 tabel dalam diagram relasional ini yang merepresentasikan entitas dalam ERD:
1. **RollerCoaster**
    - Atribut: `coaster_id`, `park_id`, `manufacturer_id`, coaster_name`, coaster_type`, `coaster_design`, `coaster_status`, `opened`
    - Primary Key: `coaster_id`
    - Foreign Key: `park_id` (merujuk ke `Park.park_id`), `manufacturer_id` (merujuk ke `Manufacturer.manufacturer_id`)
    
2. **Park**
    - Atribut: `park_id`, `park_name`, `city_id`
    - Primary Key: `park_id`
    - Foreign Key: `city_id` (merujuk ke `City.city_id`)

3. **Manufacturer**
    - Atribut: `manufacturer_id`, `manufacturer_name`, `city_id`
    - Primary Key: `manufacturer_id`
    - Foreign Key: `city_id` (merujuk ke `City.city_id`)

4. **City**
    - Atribut: `city_id`, `city_name`, `region_id`
    - Primary Key: `city_id`
    - Foreign Key: `region_id` (merujuk ke `Region.region_id`)

5. **Region**
    - Atribut: `region_id`, `region_name`, `country_id`
    - Primary Key: `region_id`
    - Foreign Key: `country_id` (merujuk ke `Country.country_id`)

6. **Country**
    - Atribut: `country_id`, `country_name`
    - Primary Key: `country_id`

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

1. **Hasil insert file SQL ke database**  
![Insert File SQL ke Database](https://raw.githubusercontent.com/AnellaUtari/Seleksi-2025-Tugas-1/main/Data%20Storing/screenshot/insertsql.png)

2. **Hasil show table**
![Show Table](https://raw.githubusercontent.com/AnellaUtari/Seleksi-2025-Tugas-1/main/Data%20Storing/screenshot/showtable.png)

3. **Hasil query untuk melihat data 10 roller coaster pertama**
![Hasil Query 10 Roller Coaster Pertama](https://raw.githubusercontent.com/AnellaUtari/Seleksi-2025-Tugas-1/main/Data%20Storing/screenshot/rollercoaster.png)

4. **Hasil query untuk melihat data 10 roller coaster yang terletak di US**
![Hasil Query 10 Roller Coaster yang Terletak di US](https://raw.githubusercontent.com/AnellaUtari/Seleksi-2025-Tugas-1/main/Data%20Storing/screenshot/rc_in_us.png)

5. **Hasil query untuk melihat data 10 taman hiburan roller coaster yang terletak di China**
![Hasil Query 10 Taman Hiburan Roller Coaster yang Terletak di China](https://raw.githubusercontent.com/AnellaUtari/Seleksi-2025-Tugas-1/main/Data%20Storing/screenshot/park_in_china.png)

6. **Hasil query untuk melihat 10 produsen roller coaster teratas berdasarkan jumlah roller coaster yang mereka buat**
![Hasil Query 10 Produsen Roller Coaster Teratas](https://raw.githubusercontent.com/AnellaUtari/Seleksi-2025-Tugas-1/main/Data%20Storing/screenshot/top_manufacturer.png)

## Referensi

- **Library yang digunakan**  
    - [Requests](https://docs.python-requests.org/en/latest/)
    - [BeautifulSoup](https://www.crummy.com/software/BeautifulSoup/bs4/doc/)

- **Sumber data**  
    - [RCDB - Roller Coaster Database](https://rcdb.com/r.htm?order=1&ot=2&op=2025)
