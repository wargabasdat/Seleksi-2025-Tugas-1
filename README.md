# Spotify ETL
> Database Lab Assistant Recruitment 2025.

<div align="center">
  <h3 align="center"> Tech Stacks </h3>

  <p align="center">
    
![MySQL](https://img.shields.io/badge/mysql-4479A1.svg?style=for-the-badge&logo=mysql&logoColor=white)
![Python](https://img.shields.io/badge/python-3670A0?style=for-the-badge&logo=python&logoColor=ffdd54)
  
  </p>
</div>

---

### Table of Contents <a name="table-of-contents"></a>

- [Contributors](#contributors)
- [About](#about)
---

### Contributors <a name="contributors"></a>

<!-- CONTRIBUTOR -->
 <div align="center" id="contributor">
   <strong>
     <table align="center">
       <tr align="center">
         <td>NIM</td>
         <td>Name</td>
         <td>GitHub</td>
       </tr>
       <tr align="center">
         <td>13523004</td>
         <td>Razi Rachman Widyadhana</td>
         <td align="center" >
           <div style="margin-right: 20px;">
           <a href="https://github.com/zirachw" ><img src="https://avatars.githubusercontent.com/u/148220821?v=4" width="48px;" alt=""/> 
             <br/> <sub><b> @zirachw </b></sub></a><br/>
           </div>
         </td>
       </tr>
     </table>
   </strong>
 </div>

<br>

---

<!-- ABOUT -->
### About <a name="about"></a>

Spotify adalah salah satu platform streaming musik terbesar di dunia dengan jutaan pengguna dan koleksi musik yang sangat luas. Platform ini menyediakan berbagai genre musik, playlist yang dikuratori, album, dan data tentang artis dengan berbagai metrik seperti monthly listeners, followers, dan play counts. 

Proyek ETL ini bertujuan untuk mengekstrak, mentransformasi, dan memuat data Spotify ke dalam sistem basis data yang terstruktur. Data yang dikumpulkan meliputi:
1. Genre musik dan kategorinya
2. Playlist beserta metadata lengkap
3. Lagu-lagu dengan informasi detail
4. Hubungan playlist-song 
5. Informasi artis dan monthly listeners
6. Data album dengan tanggal rilis
7. Hubungan song-artist 
8. Data pengguna pembuat playlist

Spotify dipilih dalam proyek ETL ini karena memiliki struktur data yang kompleks dengan berbagai entitas yang saling berhubungan, memungkinkan implementasi sistem basis data relasional yang komprehensif. Platform ini juga menyediakan data real-time yang dapat digunakan untuk analisis trend musik, popularitas artis, dan preferensi pengguna secara mendalam.

## Step-by-Step
### Pre-requisite
Salin _repository_ berikut dan kloning ke komputer Anda:
```bash
git clone https://github.com/zirachw/Seleksi-2025-Tugas-1
cd Seleksi-2025-Tugas-1
```

Install dependencies yang diperlukan:
```bash
uv sync
```

### Data Scraping
1. Masuk ke dalam _directory_ untuk melakukan _scraping_
```bash
cd "Data Scraping/src"
```

2. Install Chrome WebDriver
Lakukan instalasi WebDriver sesuai dengan instruksi pada tautan https://developer.chrome.com/docs/chromedriver/get-started. 

3. Buat file `.env` di root directory dengan konfigurasi berikut:
```env
CHROME_PATH=C:\Program Files\Google\Chrome\Application\chrome.exe
CHROMEDRIVER_PATH=C:\chromedriver\chromedriver.exe
SPOTIFY_URL=https://open.spotify.com/search
```

4. Jalankan program scraping
```bash
uv run -m "Data Scraping.src.main"
```

5. Program akan membuat folder dengan timestamp dan menyimpan file JSON:
```
Data Scraping/data/YYYY_MM_DD_HH_MM_SS/
├── genre.json
├── playlist.json  
├── song.json
├── artist.json
├── album.json
├── user.json
├── playlist_song.json
├── song_artist.json
└── summary.txt
```

### Data Storing
1. Setup Docker untuk MySQL database:
```bash
docker-compose up -d
```

2. Buat file `.env` dengan konfigurasi database:
```env
MYSQL_HOST=localhost
MYSQL_PORT=3306
MYSQL_USER=root
MYSQL_PASSWORD=password
MYSQL_DATABASE=spotify_db
```

3. Masuk ke dalam _directory_ untuk melakukan _storing_
```bash
cd "Data Storing/src"
```

4. Jalankan script untuk membuat schema database:
```bash
docker exec -i mysql_container mysql -uroot -ppassword spotify_db < schema.sql
docker exec -i mysql_container mysql -uroot -ppassword spotify_db < trigger.sql
```

5. Jalankan program untuk load data ke database:
```bash
uv run -m "Data Storing.src.connection"
```

6. Akses phpMyAdmin untuk verifikasi data:
```
http://localhost:8080
```

### Data Warehouse
1. Masuk ke dalam _directory_ Data Warehouse
```bash
cd "Data Warehouse/src"
```

2. Setup schema data warehouse:
```bash
docker exec -i mysql_container mysql -uroot -ppassword spotify_db < schema_dw.sql
docker exec -i mysql_container mysql -uroot -ppassword spotify_db < trigger-dw.sql
```

3. Jalankan program untuk generate data warehouse:
```bash
uv run -m "Data Warehouse.src.generate_dw"
```

4. Data warehouse akan memiliki struktur star schema:
   - **Fact Table**: FactSpotify (dengan measures: save_count, song_count, followers_count, monthly_listeners, play_count, duration)
   - **Dimension Tables**: DimDate, DimGenre, DimArtist, DimAlbum, DimPlaylist, DimSong

### Automated Scheduling
1. **Windows (Task Scheduler)**
   - Buka Task Scheduler (`taskschd.msc`)
   - Buat task baru "Spotify ETL Pipeline"
   - Set trigger untuk daily execution
   - Action: jalankan `run_etl.bat`
   - Start in: project root directory

2. **Linux/macOS (Cron)**
```bash
# Edit crontab
crontab -e

# Tambahkan entry untuk daily execution di 19:35
35 19 * * * /absolute/path/to/run_etl.sh >> /var/log/spotify_etl.log 2>&1
```

3. **Manual Execution**
```bash
# Windows
run_etl.bat

# Linux/macOS  
./run_etl.sh
```

## JSON Format
Berikut adalah **format JSON** untuk setiap _file_ yang dihasilkan dari _scraping_:

1. **genre.json**
```json
{
  "genre_id": "pop",
  "name": "Pop"
}
```

2. **playlist.json**
```json
{
  "playlist_id": "37i9dQZF1DXcBWIGoYBM5M",
  "genre_id": "pop", 
  "name": "Today's Top Hits",
  "save_count": 32500000,
  "song_count": 50,
  "duration": 180000,
  "type": "Spotify Playlist",
  "description": "The biggest songs of the moment",
  "creator_id": "spotify"
}
```

3. **song.json**
```json
{
  "album_id": "4UlGauD7ROb3YbVOFMgW5u",
  "track_order": 1,
  "title": "Flowers",
  "release_date": "2023-01-13",
  "play_count": 2800000000,
  "duration": 200520
}
```

4. **artist.json**
```json
{
  "artist_id": "4gzpq5DPGxSnKTe4SA8HAU",
  "name": "Miley Cyrus",
  "status": "Verified",
  "monthly_listeners": 82500000,
  "followers_count": 15800000
}
```

5. **album.json**
```json
{
  "album_id": "4UlGauD7ROb3YbVOFMgW5u",
  "artist_id": "4gzpq5DPGxSnKTe4SA8HAU",
  "title": "Endless Summer Vacation",
  "release_date": "2023-03-10",
  "song_count": 12,
  "duration": 2880000
}
```

6. **user.json**
```json
{
  "user_id": "spotify",
  "name": "Spotify",
  "status": "Verified",
  "followers_count": 120000000,
  "following_count": 0,
  "public_playlist_count": 5000
}
```

7. **playlist_song.json**
```json
{
  "playlist_id": "37i9dQZF1DXcBWIGoYBM5M",
  "album_id": "4UlGauD7ROb3YbVOFMgW5u", 
  "track_order": 1,
  "added_date": "2023-01-15"
}
```

8. **song_artist.json**
```json
{
  "artist_id": "4gzpq5DPGxSnKTe4SA8HAU",
  "album_id": "4UlGauD7ROb3YbVOFMgW5u",
  "track_order": 1
}
```

## Struktur ERD dan Relasional DBMS
1. **Entity-Relationship Diagram Operational Database**  <br>
   <img width="800" alt="ERD" src="Data Storing/design/ER_model_diagram.png" />
   <br><br>

2. **Diagram Relasional Operational Database**  <br>
   <img width="800" alt="RelationalDiagram" src="Data Storing/design/relational_model_diagram.png" />
   <br><br>

3. **Data Warehouse Star Schema Diagram**  <br>
   <img width="800" alt="WarehouseDiagram" src="Data Warehouse/design/warehouse_diagram.png" />
   <br><br>

## ERD to Relational Diagram Translation
**1. One-to-many**  <br>
Hubungan _one-to-many_ pada ERD dapat terlihat pada hubungan Genre-Playlist, Artist-Album, User-Playlist, dan Album-Song. Hubungan ini ditranslasikan ke dalam diagram relasional dengan menambahkan kolom _foreign key_ dari tabel _one_ ke dalam tabel _many_.

**2. Many-to-many** <br>
Hubungan _many-to-many_ pada ERD terlihat pada hubungan Playlist-Song dan Song-Artist. Hubungan ini ditranslasikan dengan membuat tabel junction (Playlist_Song dan Song_Artist) yang berisi _foreign keys_ dari kedua tabel yang berhubungan.

**3. Weak Entity** <br>
Entitas Song merupakan weak entity yang bergantung pada Album, dengan composite primary key (album_id, track_order).

## Documentation

### RDBMS Hasil Storing (Operational Database)

1. **Genre Table**
   <br><img width="600" alt="Genre" src="Data Storing/screenshot/genre.png" /><br><br>

2. **Artist Table**
   <br><img width="600" alt="Artist" src="Data Storing/screenshot/artist.png" /><br><br>

3. **User Table**
   <br><img width="600" alt="User" src="Data Storing/screenshot/user.png" /><br><br>

4. **Album Table**
   <br><img width="600" alt="Album" src="Data Storing/screenshot/album.png" /><br><br>

5. **Song Table**
   <br><img width="600" alt="Song" src="Data Storing/screenshot/song.png" /><br><br>

6. **Playlist Table**
   <br><img width="600" alt="Playlist" src="Data Storing/screenshot/playlist.png" /><br><br>

7. **Song_Artist Table**
   <br><img width="600" alt="Song_Artist" src="Data Storing/screenshot/song_artist.png" /><br><br>

8. **Playlist_Song Table**
   <br><img width="600" alt="Playlist_Song" src="Data Storing/screenshot/playlist_song.png" /><br><br>

### RDBMS Data Warehouse (Star Schema)

1. **DimGenre**
   <br><img width="600" alt="DimGenre" src="Data Warehouse/screenshot/DimGenre.png" /><br><br>

2. **DimArtist** 
   <br><img width="600" alt="DimArtist" src="Data Warehouse/screenshot/DimArtist.png" /><br><br>

3. **DimUser**
   <br><img width="600" alt="DimUser" src="Data Warehouse/screenshot/DimUser.png" /><br><br>

4. **DimAlbum**
   <br><img width="600" alt="DimAlbum" src="Data Warehouse/screenshot/DimAlbum.png" /><br><br>

5. **DimSong**
   <br><img width="600" alt="DimSong" src="Data Warehouse/screenshot/DimSong.png" /><br><br>

6. **DimPlaylist**
   <br><img width="600" alt="DimPlaylist" src="Data Warehouse/screenshot/DimPlaylist.png" /><br><br>

7. **DimDate**
   <br><img width="600" alt="DimDate" src="Data Warehouse/screenshot/DimDate.png" /><br><br>

8. **FactSpotify**
   <br><img width="600" alt="FactSpotify" src="Data Warehouse/screenshot/FactSpotify.png" /><br><br>

### Analytical Queries Data Warehouse

1. **Query: Top Artists by Monthly Listeners**
   <br><img width="800" alt="Query1" src="Data Warehouse/screenshot/FactSpotify-query-1.png" /><br><br>

2. **Query: Playlist Analysis by Genre** 
   <br><img width="800" alt="Query2" src="Data Warehouse/screenshot/FactSpotify-query-2.png" /><br><br>

### Database Triggers Implementation

1. **Song Count Trigger**
   <br><img width="600" alt="Song-Trigger" src="Data Storing/screenshot/song-trigger.png" /><br><br>

2. **Album Trigger**
   <br><img width="600" alt="Album-Trigger" src="Data Storing/screenshot/album-trigger.png" /><br><br>

3. **Playlist Song Trigger**
   <br><img width="600" alt="Playlist-Song-Trigger" src="Data Storing/screenshot/playlist_song-trigger.png" /><br><br>

### Database Schema Features
- **Primary Key Constraints**: Mencegah duplikasi record
- **Foreign Key Constraints**: Menjaga integritas referensial  
- **Triggers**: Update otomatis untuk measures seperti song_count dan duration
- **Timestamped Data**: Setiap extraction disimpan dalam folder berlabel waktu

### Data Warehouse Star Schema
- **FactSpotify**: Tabel fakta dengan measures kuantitatif
- **Dimension Tables**: DimDate, DimGenre, DimArtist, DimAlbum, DimPlaylist, DimSong
- **Real-time Sync**: Triggers otomatis sinkronisasi data operasional ke warehouse

### Performance Optimization
- **Smart Data Reuse**: Menggunakan data default untuk playlist besar
- **Incremental Updates**: Trigger database untuk update incremental
- **Indexed Queries**: Optimasi query dengan proper indexing

### Automated ETL Pipeline
- **Timestamped Extraction**: Format YYYY_MM_DD_HH_MM_SS
- **Error Handling**: Transaction rollback pada kegagalan
- **Cross-platform Support**: Windows (.bat) dan Linux/macOS (.sh)
- **Monitoring**: Comprehensive logging dan error tracking

### Analytical Queries Example
```sql
-- Top 10 most followed artists by monthly listeners
SELECT name, monthly_listeners, followers_count
FROM Artist 
WHERE monthly_listeners IS NOT NULL
ORDER BY monthly_listeners DESC 
LIMIT 10;

-- Most popular playlists by save count
SELECT p.name, p.save_count, g.name as genre
FROM Playlist p
JOIN Genre g ON p.genre_id = g.genre_id
ORDER BY p.save_count DESC
LIMIT 10;

-- Data warehouse analytics
SELECT 
    dg.name as genre,
    AVG(f.song_count) as avg_songs,
    AVG(f.duration) as avg_duration,
    COUNT(*) as total_playlists
FROM FactSpotify f
JOIN DimGenre dg ON f.genre_key = dg.genre_key
GROUP BY dg.name
ORDER BY avg_songs DESC;
```

## Reference
**1. Libraries** <br>
[BeautifulSoup4](https://pypi.org/project/beautifulsoup4/) - HTML parsing<br>
[Selenium](https://www.selenium.dev/) - Web automation<br>
[PyMySQL](https://pypi.org/project/PyMySQL/) - MySQL connection<br>
[Python-dotenv](https://pypi.org/project/python-dotenv/) - Environment variables<br>

**2. Tools & Infrastructure**<br>
[Docker](https://www.docker.com/) - Containerization<br>
[MySQL](https://www.mysql.com/) - Relational Database<br>
[phpMyAdmin](https://www.phpmyadmin.net/) - Database administration<br>
Task Scheduler (Windows) / Cron (Linux/macOS) - Job scheduling<br>

**3. Data Source**<br>
[Spotify Web Player](https://open.spotify.com/) - Music streaming platform<br>

**4. Development Environment**<br>
[uv](https://github.com/astral-sh/uv) - Python package manager<br>
