<h1 align="center">
  <br>
  Seleksi Warga Basdat 2024 <br>
  ETL Project
  <br>
  <br>
</h1>

<h2 align="left">
  <br>
  DATA SCRAPING, STORING, AND VISUALIZATION OF MINDFULNESS YOUTUBE CHANNELS BY <a
  href="https://videos.feedspot.com/mindfulness_youtube_channels/">Feedspot</a>
  <br>
  <br>
</h2>



DAFTAR ISI
- System Description
- Program Specification
- How To Use
  - Data Scraping
  - Data Storing
- JSON Structure
- Database Structure
  - Entity Relationship Diagram
  - Relational Diagram
- Screenshot
  - Tampilan *Website*
  - Data Scrapping & Pre-processing
  - Data Storing
- Data Visualization (BONUS)
- Reference
- Author



## System Description
Feedspot adalah sebuah website yang menyediakan kumpulan daftar channel YouTube berdasarkan kategori tertentu. Pada websute feedspot yang saya sraping, menampilkan daftar channel YouTube yang berfokus pada topik mindfulness. Website ini menyajikan berbagai informasi penting mengenai setiap channel dan influencer di dalamnya, termasuk jumlah subscriber dan follower di platform media sosial lainnya.

Untuk menyempurnakan data modeling dari website Feedspot, dalam pembuatan ETL Project ini saya memodelkan data menjadi dua entitas yang relevan, yaitu channels dan youtubers, yang dihubungkan dengan relasi "memiliki".

Alasan saya memilih website ini sebagai objek dalam data scraping adalah data-data channel yang beragam dan sangat variatif, memungkinkan untuk memisahkan entitas menjadi channels dan youtubers. Hasil analisis yang saya lakukan diharapkan bisa memberikan gambaran tentang influencer mindfulness dan channel youtubenya, termasuk karakteristik mereka, seperti gender, tipe influencer, dan hubungannya dengan jumlah followers mereka untuk memahami pasar konten mindfulness yang ada.

## Program Specification
Bahasa pemrograman __Python__ saya gunakan untuk melakukan *Data Scraping* dan *Data Storing* dengan library berikut,
- `urlib.request`
    - __Pertimbangan__ : Library ini digunakan untuk melakukan permintaan GET ke website Feedspot untuk mendapatkan konten HTML. Ini adalah metode yang efisien karena website tidak memiliki elemen yang dinamis dan data yang diperlukan dapat diakses langsung dari sumber HTML-nya.
- `requests`
    - __Pertimbangan__ : Meskipun urllib.request digunakan, requests juga merupakan alternatif yang kuat dan mudah digunakan untuk membuat permintaan HTTP. Dengan requests, saya dapat dengan mudah menyertakan header seperti User-Agent untuk mematuhi etika data scraping.
- `BeautifulSoup4`
    - __Pertimbangan__ : Beautiful Soup relatif ringan dan cepat untuk pemrosesan string HTML. Library ini digunakan untuk mengurai struktur HTML yang didapat dari urllib.request atau requests, dan memungkinkan pengambilan data yang spesifik dan terstruktur dengan menargetkan elemen-elemen HTML berdasarkan tag, kelas, dan atributnya.
- `re`
    - __Pertimbangan__ : Library ini berguna untuk kebutuhan preprocessing data, khususnya untuk membersihkan dan menormalisasi string. Contohnya, digunakan untuk mengubah format angka subscriber dan follower dari 707K menjadi 707000.
- `json`
    - __Pertimbangan__ : Memenuhi kriteria output yang diharapkan dalam format .json. Library ini digunakan untuk menyimpan data hasil scraping ke dalam file JSON.
- `os`
    - __Pertimbangan__ : Library ini digunakan untuk berinteraksi dengan sistem operasi, khususnya untuk memastikan bahwa direktori untuk menyimpan file JSON ada.
- `time`
    - __Pertimbangan__ : Digunakan untuk menunda eksekusi dengan time.sleep(). Ini adalah bagian dari etika data scraping untuk memastikan tidak ada terlalu banyak request dalam waktu singkat yang dapat membebani server target.
- `psycopg2`
    - __Pertimbangan__ : Library ini berguna agar bisa menciptakan koneksi dan memasukkan data yang ada di file JSON ke database PostgreSQL secara otomatis. 
- `datetime`
    - __Pertimbangan__ : Digunakan untuk memproses dan mengonversi string tanggal dari data hasil scraping (misalnya "Apr 2009") menjadi objek tanggal yang dapat diformat dan disimpan dengan benar dalam kolom DATE di database relasional.


## How To Use
### Data Scraping
1. Clone repository
```sh
    $ git clone 
```

2. Intall library di cmd
```sh
    $ pip install request
    $ pip install beutifulsoup4
```

3. Intall ChromeDriver
    - Intall pada halaman (https://chromedriver.chromium.org/downloads)
    - Pastikan bahwa __Chrome, ChromeDriver, dan Python__ memiliki versi yang sama (64 bit/ 32 bit)
    - Masukkan path ChromeDriver tersebut ke dalam *Environment Variables*

4. Buka folder hasil cloning
```sh
    $ cd Seleksi-2025-Tugas-1/Data Scraping/src
```

5. Jalankan program 
```sh
    $ feedspot_scraper.py
```

### Data Storing
1. Buat database pada __PostgreSQL__, contoh:
```sh
      dbname='mindfulness_db',
      user='kevinazrazzz',
      password='Azra1203@',
      host='localhost',
      port='5432'
```

2. Intall library di cmd
```sh
    $ pip install psycopg2
```

3. Buka folder hasil cloning
```sh
    $ cd Seleksi-2025-Tugas-1/Data Storing/src
```

4. Jalankan program 
```sh
    $ insert_data.py
```

5. Export database tersebut dalam formal SQL
```sh
    $ pg_dump -U <username> -d <database_name> -s > <output_file.sql>
```

## JSON Structure
Berikut adalah *2 instance* data JSON yang dihasilkan:
1. `channels.json`
```json
{
    "youtube_channel_link": "https://www.youtube.com/channel/UCbuENEBzQ69QKmfX2iumnFA/videos",
    "channel_name": "Yogapalooza with Bari Koral",
    "youtuber_name": "Bari Koral",
    "type_of_channel": "Influencer",
    "since": "Apr 2009",
    "description": "Discover a wonderful world of beloved songs and magical activities that make it easy to teach yoga and mindfulness to children through music. Bari Koral                     is a widely recognized kids yoga expert and popular recording artist.ABOUT BARI KORALEvery day, thousands of children, parents and teachers around the                       world are learning and enjoying the benefits of yoga and mindfulness with Bari. Bari's songs and approachable yoga and mindfulness curriculum are used                       on a regular basis around the world. She is considered a pioneer in the world of kids yoga. To date, she has presented to over 100,000..."
}
```

2. `youtubers.json`
```json
{
    "youtuber_name": "Bari Koral",
    "gender": "Female",
    "email": "****@gmail.com",
    "youtube_subscribers": 707000,
    "facebook_followers": 3400,
    "instagram_followers": 6300,
    "type": "Macro"
}
```


## Database Structure
### Entity Relationship Diagram
<div align="center">
  <img src="Data Storing/design/ERD.png" width="600"/>
</div>

### Relational Diagram
<div align="center">
  <img src="Data Storing/design/Diagram Relational.png" width="600"/>
</div>

### Convertion Explanation
#### __1. Pemetaan *entity* menjadi relasi__

Pemetaan entitas menjadi relasi berarti mengubah representasi entitas dalam model data menjadi tabel dalam database relasional.

a) *Strong Entity*

*Strong Entity* adalah entitas yang bisa berdiri sendiri dan memiliki *Primary Key* sendiri.
- *youtubers* = (__youtuber_name__, gender, email, youtube_subscribers, facebook_followers, instagram_followers, type)
- *channels* = (__youtube_channel_link__, channel_name, description, type_of_channel, since)

#### __2. Pemetaan *relationship* menjadi relasi__

Pemetaan relationship menjadi relasi berarti mengubah representasi hubungan antar entitas dalam model data menjadi tabel dalam database relasional.

a) Pemetaan `one-to-one relationship` menjadi relasi

Cara translasi ini adalah dengan membawa PK dari sisi "one" (satu) ke sisi "one" (satu) sebagai FK. Dalam kasus ini, satu youtuber hanya dapat memiliki satu channels. Maka, youtuber_name yang merupakan PK dari youtubers akan menjadi FK di channels.

- *channels* = (youtube_channel_link (PK), channel_name, description, type_of_channel, since, youtuber_name (FK))
- *youtubers* = (youtuber_name (PK), gender, email, youtube_subscribers, facebook_followers, instagram_followers, type)



## Screenshot
### Tampilan *Website*
<div align="center">
  <img width="1917" height="878" alt="image" src="https://github.com/user-attachments/assets/d138bcc2-3a82-4d8d-8e4e-857dbd48cc82" />
</div>

### Data Scrapping & Pre-processing
`Ekstraksi Data`

Mengirimkan permintaan GET ke URL target untuk mendapatkan konten HTML. Untuk mematuhi etika data scraping, saya menyertakan header User-Agent yang mengidentifikasi skrip saya kepada server.
<div align="center">
  <img width="1357" height="419" alt="image" src="https://github.com/user-attachments/assets/5144088f-d275-4e06-b146-3a3968e4d4eb" />
</div>

Setelah mendapatkan konten HTML, saya menggunakan library Beautiful Soup untuk menguraikannya. Langkah pertama adalah menemukan elemen HTML yang menjadi kontainer utama dari seluruh daftar channel (yaitu, <div id="fsb">) dan kemudian mencari blok-blok informasi setiap channel di dalamnya
<div align="center">
  <img width="1263" height="776" alt="image" src="https://github.com/user-attachments/assets/4bae67c4-1640-4159-8042-74ea5c4f7c15" />
</div>

Di dalam setiap kontainer channel, saya menargetkan elemen-elemen spesifik untuk mengekstrak data yang dibutuhkan. Contohnya, nama YouTuber diambil dari tag <span> dengan atribut data-fid
<div align="center">
  <img width="1241" height="802" alt="image" src="https://github.com/user-attachments/assets/0f93aaf3-0116-4386-afee-d5ccbcb61740" />
</div>

Semua data yang diekstrak untuk setiap channel dikumpulkan dan disimpan dalam sebuah dictionary kemudian ditambahkan ke dalam sebuah list besar.
<div align="center">
  <img width="1004" height="645" alt="image" src="https://github.com/user-attachments/assets/774849f6-4681-4a2b-b9d9-92cabd905537" />
</div>

`Preprocessing Data`

Selanjutnya, metode .strip() digunakan untuk menghapus spasi ekstra di awal atau akhir teks.
<div align="center">
  <img width="1157" height="402" alt="image" src="https://github.com/user-attachments/assets/34a984bf-94e8-4d9a-b920-498ecb79697b" />
</div>

Data seperti "707K" atau "3.4K" dikonversi menjadi nilai integer menjadi 707000 dan 3400) menggunakan fungsi kustom dengan bantuan library re.
<div align="center">
  <img width="1349" height="413" alt="image" src="https://github.com/user-attachments/assets/b09958e3-08b9-4df2-b599-7f9d8dbd0be9" />
</div>


### Data Storing

Pada database mindfulness_db, saya melakukan *create table* dengan menggunakan psycopg2 sebagai berikut
<div align="center">
  <img width="828" height="740" alt="image" src="https://github.com/user-attachments/assets/e21d449b-b1ca-4686-8fdb-06b97d8f3692" />
</div>

Saya juga membuat indeks dan trigger agar data yang masuk lebih akurat dan sesuai dengan yang diinginkan
<div align="center">
  <img width="1126" height="819" alt="image" src="https://github.com/user-attachments/assets/214c0089-240e-49ee-b54f-8dfea5bc794d" />
</div>

## Data Warehouse (BONUS)



## Reference
1. [Feedspot Website](https://videos.feedspot.com/mindfulness_youtube_channels/)
2. [Dokumentasi Beautifulsoup4](https://beautiful-soup-4.readthedocs.io/)
3. [Dokumentasi psycopg2](https://pypi.org/project/psycopg2/)
4. [Dokumentasi PostgreSQL](https://www.postgresql.org/)

## Author
Kevin Azra - 18223029
