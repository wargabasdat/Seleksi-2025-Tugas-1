<h1 align="center">
  <br>
  Seleksi Warga Basdat 2025 <br>
  ETL Project
  <br>
  -- Gacha Game Revenue --
  <br>
</h1>

## Author
Bertha Soliany Frandi - 13523026

## Overview
Repositori ini adalah repositori hasil pengerjaan dari seleksi Laboratorium Basdat 2025. Terdapat data scraping, data modeling, dan data scraping yang dilakukan. Topik yang dibawakan adalah revenue untuk gacha game. Data diambil dari (Gacha Revenue Tracker)[https://revenue.ennead.cc/revenue]. Scraping dilakukan dengan python menggunakan selenium dan DBMS yang digunakan adalah MariaDB. Topik dipilih dikarenakan ketertarikan pembuat pada gacha game yang dimana gacha game semakin lama semakin digemari oleh masyarakat, menjadikannya topik yang menarik untuk ditelusuri.

## Prerequisites
1. Python
2. MariaDB

## How To Run
1. Clone repositori
```bash
git clone https://github.com/BerthaSoliany/Seleksi-2025-Tugas-1.git
cd Seleksi-2025-Tugas-1
```
2. Install prerequisites
3. Buat virtual environment
```bash
python -m venv venv
```
4. Aktifkan venv
```bash
.\venv\Scripts\activate
```
5. Install requirement
```bash
pip install -r requirements.txt
```
6. (Scrape data)[#scraping]
7. (Setup database dan masukan data hasil scraping ke database)[#database]

### Scraping
1. Pergi ke directory data scraping
```bash
cd "Data Scraping/src"
```
2. Jalankan perintah berikut
```bash
python scraper.py
```
3. Tunggu program selesai berjalan dan selamat melihat datanya!
4. Data ada berada pada folder data. Terdapat 4 file, yaitu games.json, metadata.json, regions.json, dan revenue.json

### Database
1. Pergi ke directory data storing
```bash
cd "Data Storing"
```
2. Setup database
```bash
mysql -u root -p < src/tables.sql
```
3. Jalankan importer.py
```bash
python "src/importer.py"
```
4. Lihat data dengan masuk ke MariaDB
```bash
mysql -u root -p
```
> [!NOTE]
> Jika ditanya password, langsung saja tekan tombol spasi karena password tidak di set.

## Struktur JSON
### games.json
JSON ini adalah untuk menyimpan data mengenai nama game. Diberikan id untuk masing-masing game agar mempermudah dalam mengambil referensi di file JSON lainnya.
```json
[
    {
        "game_id": 1,
        "game_name": "Honkai: Star Rail"
    },
]
```

### regions.json
JSON ini menyimpan data mengenai region yang dimiliki oleh game-game yang didapat dari hasil scraping.
```json
[
    {
        "region_id": 1,
        "region_name": "GLOBAL"
    },
]
```

### revenue.json
JSON ini menyimpan data mengenai suatu revenue per bulannya.
```json
[
    {
        "revenue_id": 1,
        "game_id": 1,
        "region_id": 1,
        "month": "Jul_2025",
        "revenue_text": "$92,450,000",
        "revenue_value": 92450000.0,
        "rank": 1,
        "trend_direction": "up",
        "trend_value": 14,
        "currency": "USD",
        "scraped_at": "2025-08-08T17:04:23.580824Z"
    }
]
```

### metadata.json
```json
[
    {
        "scraped_at": "2025-08-08T17:33:47.910753",
        "source_url": "https://revenue.ennead.cc/revenue",
        "total_games": 139,
        "total_regions": 5,
        "total_revenue_records": 1712,
        "months_extracted": ["Jan_2025", "Feb_2025", ..., "Jul_2025"],
        "files_created": ["games.json", "regions.json", "revenue.json", "metadata.json"]
    }
]
```

## Entity Relationship Diagram (ERD)
<img width="451" height="567" alt="erd_seleksi_basdat drawio" src="https://github.com/user-attachments/assets/924e0ae8-51d8-48ca-ac7c-8f058940edab" />


## Diagram pada DBMS
```sql
-- create games table
CREATE TABLE Games (
    game_id INT AUTO_INCREMENT PRIMARY KEY,
    game_name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- create regions table
CREATE TABLE Regions (
    region_id INT AUTO_INCREMENT PRIMARY KEY,
    region_name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- create revenue table
CREATE TABLE Revenue (
    revenue_id INT AUTO_INCREMENT PRIMARY KEY,
    in_id INT NOT NULL,
    month VARCHAR(255) NOT NULL,
    revenue_text VARCHAR(50),
    revenue_value DECIMAL(15,2) DEFAULT 0.00,
    rank_position INT,
    trend_direction ENUM('up', 'down', 'stable', 'new') DEFAULT 'stable',
    trend_value INT,
    currency VARCHAR(3) DEFAULT 'USD',
    scraped_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (in_id) REFERENCES In(in_id) ON DELETE CASCADE,
    UNIQUE KEY unique_game_region_month (in_id, month)
);

CREATE TABLE In (
    in_id INT AUTO_INCREMENT PRIMARY KEY,
    game_id INT NOT NULL,
    region_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY unique_game_region (game_id, region_id)
    FOREIGN KEY (game_id) REFERENCES games(game_id) ON DELETE CASCADE,
    FOREIGN KEY (region_id) REFERENCES regions(region_id) ON DELETE CASCADE,
);
```

## Proses translasi
Translasi dilakukan dengan membuat tiap entitas terlebih dahulu. Setelah itu, dilihat pada relasi yang dimiliki setiap entitas, apakah ada yang many-to-many. Jika ya, maka relasi tersebut akan menjadi entitas tersendiri. Berlanjut kepada pendataan atribut untuk setiap entitas. Untuk entitas yang memiliki hubungan one-to-many atau many-to-one, PK pada entitas yang berperan sebagai one akan dimiliki oleh entitas yang berperan sebagai many sebagai FK. Setelah itu ubah menjadi syntax SQL (create table dan sebagainya).

## Screenshot
<img width="1294" height="466" alt="Screenshot 2025-08-08 192300" src="https://github.com/user-attachments/assets/01b86f51-7353-4bf4-af6c-06ce70601b05" />
<img width="758" height="473" alt="Screenshot 2025-08-08 192323" src="https://github.com/user-attachments/assets/2756d56c-ac22-4c81-92bc-e5c6b090708d" />
<img width="997" height="693" alt="Screenshot 2025-08-08 193142" src="https://github.com/user-attachments/assets/1988146e-ee48-4ba3-818b-f02b0f0f29cf" />
<img width="1176" height="963" alt="Screenshot 2025-08-08 193202" src="https://github.com/user-attachments/assets/5fff0a30-3694-4e1c-828e-56c3764cbd31" />
<img width="1185" height="963" alt="Screenshot 2025-08-08 192404" src="https://github.com/user-attachments/assets/dfa2bd6e-b372-4323-845e-382dd0e4036e" />

## Referensi
1. (selenium)[http://selenium.dev/]
2. (gacharevenue)[https://revenue.ennead.cc/revenue]
