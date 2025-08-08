<h1 align="center">
  <br>
  Seleksi Warga Basdat 2025 <br>
  Rafen Max Alessandro - 13523031
  <br>
  <br>
</h1>

<h2 align="left">
  <br>
  Description
  <br>
</h2>
Project ini berupa hasil kerja proses ETL (Extract, Transform, Load) yang melakukan tahapan scraping dan storing terhadap data karakter, senjata, dan artefak pada game Genshin Impact ke dalam DBMS MariaDB untuk dibentuk sebagai database. 
Topik game Genshin Impact dipilih atas dasar datanya yang kompleks serta saling berkaitan antar beragam entitas, dan DBMS MariaDB dipilih atas dasar familiaritas penulis dan kemudahan yang diberikan dalam pembentukan database dan penerapan constraint yang mendukung integritas database.
  <br>

## Instalasi dan Prasyarat
1. Pastikan perangkat memiliki Python 3.7 atau lebih tinggi, versi Python dapat diperiksa dengan:  
    ```bash
   python --version
   ```
2. Gunakan pip untuk menginstal pustaka yang diperlukan:
   ```
   pip install requests tqdm beautifulsoup4
   ```
3. Lakukan _clone_ terhadap _repository_:
   ```bash
   git clone https://github.com/rafenmaxxx/TUGAS_SELEKSI_1_13523031.git
   cd "Data Scraping/src"
   ```
4. Jalankan program untuk mulai melakukan _scraping_ ٩(^ᗜ^ )و ´-
   ```bash
   python scraping.py
   ```
Hasil _output_ berupa _file_ JSON pada folder "Data Scraping/data" berisi data-data hasil _scraping_ website [Genshin Impact Fandom Wiki](https://genshin-impact.fandom.com/wiki/Genshin_Impact_Wiki) untuk digunakan sebagai dasar dalam membentuk database (skema dan _file_ SQL).

## Hasil Scraping
Berikut adalah _file_ JSON hasil _scraping_ beserta strukturnya.
### 1. Characters.json
menyimpan data-data yang dimiliki oleh sebuah karakter.
```json
{
    "Name": "Albedo",
    "Rarity": "5",
    "Element": "Geo",
    "Weapon Type": "Sword",
    "Region": "Mondstadt",
    "Body Type": "Medium",
    "Gender": "Male",
    "Birthday Month": "9",
    "Birthday Day": "13",
    "Version": "1.2",
    "Ascension Stat": "Geo DMG Bonus",
    "Base Stats": {
        "HP": 13225.58,
        "ATK": 251.14,
        "DEF": 876.15
    },
    "Burst Cost": "40",
    "Boss Drop": "Basalt Pillar"
},
```
### 2. Versions.json
menyimpan data versi beserta tanggal rilis versi tersebut.
```json
{
    "Major Version": "5",
    "Minor Version": "8",
    "Year": "2025",
    "Month": "7",
    "Date": "30"
},
```
### 3. Domains.json
menyimpan data domain beserta artefak di dalam domain, letak negara, dan versi rilis.
```json
{
    "Name": "City of Gold",
    "Artifacts": [
        "Desert Pavilion Chronicle",
        "Flower of Paradise Lost",
        "Resolution of Sojourner",
        "Brave Heart"
    ],
    "Region": "Sumeru",
    "Version": "3.3"
},
```
### 4. Artifacts.json
menyimpan data nama artifak, rarity, dan bonus set
```json
{
    "Name": "Adventurer",
    "Rarity": [
        "1",
        "2",
        "3"
    ],
    "2-piece Bonus": "Max HP increased by 1000.",
    "4-piece Bonus": "Opening a chest regenerates 30% Max HP over 5s."
},
```
### 5. Weapons.json
menyimpan data-data mengenai sebuah senjata
```json
{
    "Name": "A Thousand Blazing Suns",
    "Type": "Claymore",
    "Rarity": "5",
    "Base ATK": "741",
    "Secondary Stat": {
        "Name": "CRIT Rate %",
        "Value": "11.0"
    },
    "Version": "5.3"
},
```
### 6. Bosses.json
menyimpan data boss beserta _loot drop_, letak negara, dan versi rilis.
```json
{
    "Name": "Anemo Hypostasis",
    "Region": "Mondstadt",
    "Boss Drop": "Hurricane Seed",
    "Version": "1.0"
},
```

## Struktur ERD
![ERD Diagram](Data%20Storing/design/diagram%20ERD.png)

**Entitas Utama:**
- **Character**
- **Weapon**
- **Domain**
- **Artifacts**
- **Version**
- **Boss**
- **Unit**: entitas berupa satu karakter, satu weapon, dan 0-2 set artefak
- **Party**: kumpulan dari 1-4 karakter

dalam mengubah ke dalam diagram relasional, dilakukan tahap-tahapan seperti yang telah dipelajari, meliputi:
- memecah atribut berganda
- mengubah relasi many-to-many menjadi tabel baru
- mengubah relasi many-to-one menjadi atribut dari entitas yang terhubung satu

## Struktur Diagram Relasional
![Relational Diagram](Data%20Storing/design/diagram%20relasional.png)

## Screenshots
Hasil implementasi _database_ ke dalam DBMS terlihat sebagai berikut


![p](Data%20Storing/screenshot/tables.png)


dengan screenshot-screenshot lain terdapat pada folder "Data Storing/screenshot"

## Bonus
dilakukan bonus _automated scheduling_, dijalankan menggunakan task scheduler pada windows dan hasil dinyatakan pada file log.txt


<img width="834" height="357" alt="image" src="https://github.com/user-attachments/assets/83eba7f3-f378-44c4-b0ea-5eec67619366" />
<img width="1015" height="143" alt="image" src="https://github.com/user-attachments/assets/30098cbc-a968-4f71-8800-d33b922ae491" />

## Author
| Nama | NIM |
|------|-----|
| 13523031 | Rafen Max Alessandro |

