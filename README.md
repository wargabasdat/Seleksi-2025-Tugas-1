<h1 align="center">
  <br>
  KodeKiddo Program & Branches
  <br>
  <br>
</h1>

<h2 align="left">
  <br>
  Author
  <br>
</h2>
Name: Velicia Christina Gabriel <br>
NIM : 18223085
  <br>

## Introduction to Data and DBMS
KodeKiddo adalah sebuah tempat kursus belajar _coding_ dan _artificial intelligence_ (AI) yang interaktif untuk anak-anak dari mulai usia TK sampai SMA. Saat ini, KodeKiddo sendiri telah memiliki 32 cabang di seluruh Indonesia. KodeKiddo memiliki program-program unggulan yang terbagi menjadi program berbasis kelas dan non-kelas. Antara lain:
1. Coding & AI Class
2. Thematic Class
3. KinderCoding
4. KiddoSTEM
5. Webinar dan Workshop
6. Pelatihan Guru PAUD
7. Pelatihan Guru SD SMP
8. Kiddo Press (penjualan buku)

Berdasarkan _website_ KodeKiddo, didapatkan sejumlah tabel yang berkaitan dengan Buku, Harga Buku, Penulis Buku, Program, Coding Class, Thematic Class, KiddoSTEM, Kinder Coding, Pelatihan Guru PAUD, Pelatihan Guru SD SMP, dan Cabang. Selain itu, dibuat juga tabel tambahan di luar hasil _scraping_ yang berkaitan dengan Murid. Tabel hasil _scraping_ yang telah disebutkan sebelumnya didapat dalam format JSON. 

_Website_ KodeKiddo dipilih dalam proyek ETL ini karena KodeKiddo memiliki berbagai program yang unik dengan spesifikasi khusus masing-masing program. Kemudian, KodeKiddo juga memiliki berbagai cabang yang datanya dapat diperoleh untuk mendapatkan _insight_ terkait persebaran cabang KodeKiddo. Hasil analisis ini dapat memberikan informasi terkait program dan cabang secara lebih mendalam dan terstruktur.

## Step-by-Step
### Pre-requisite_
Salin _link_ berikut: https://github.com/veliciagabriell/TUGAS_SELEKSI_1_18223085.git dan tuliskan _command_ di bawah ini pada cmd. <br>
``` git clone https://github.com/veliciagabriell/TUGAS_SELEKSI_1_18223085.git ``

### Data Scraping
1. Masuk ke dalam _directory_ untuk melakukan _scraping_
``` bash
cd  C:\Users\Velicia\OneDrive\Documents\ITB\SeleksiBasdat\TUGAS_SELEKSI_1_18223085\Data Scraping\src
```
2. Install Chrome WebDriver
Lakukan instalasi WebDriver sesuai dengan instruksi pada tautan https://developer.chrome.com/docs/chromedriver/get-started. Sesuaikan baris ini pada ```scraping.py``` dengan _path_ hasil instalasi Chrome WebDriver.
``` bash
service = Service(r'C:\Users\Velicia\OneDrive\Documents\ITB\SeleksiBasdat\chromedriver-win64\chromedriver.exe')
```=
3. Jalankan program ```scraping.py```
   ```bash
   python scraping.py
   ```
4. Program akan berjalan dan menyimpan _file_ JSON pada direktori berikut
``` bash
cd  C:\Users\Velicia\OneDrive\Documents\ITB\SeleksiBasdat\TUGAS_SELEKSI_1_18223085\Data Scraping\data
```

### Data Storing
1. Lakukan instalasi DBMS (MariaDB/MySQL/PostgreSQL), pada proyek ini saya menggunakan PostgreSQL<br>
```https://www.postgresql.org/download/```
2. Masuk ke dalam _directory_ untuk melakukan _storing_
``` bash
cd  C:\Users\Velicia\OneDrive\Documents\ITB\SeleksiBasdat\TUGAS_SELEKSI_1_18223085\Data Storing\src
```
3. Buat _database_ ```kodekiddo``` pada DBMS dan sesuaikan blok kode berikut pada ```storing.py``` dengan DBMS Anda
```bash
hostname = 'localhost'
database = 'kodekiddo'
username = 'postgres'
pwd = 'veli14'
port_id = 5432
```
4. Jalankan program ```storing.py```
   ```bash
   python storing.py
   ```
5. Program akan berjalan dan menyimpan data pada _database_ yang telah dibuat
6. Lakukan _dumping_ pada DBMS (PostgreSQL) dengan _command_ berikut
```bash
Format: pg_dump -U <username> -h <hostname> -p <port> <database_name> > <dump_file_name>.sql
Contoh: pg_dump -U postgres -h localhost -p 5432 kodekiddo > kodekiddo.sql
```

### Data Warehouse
1. Masuk ke dalam _directory_ untuk melakukan _storing_
``` bash
cd  C:\Users\Velicia\OneDrive\Documents\ITB\SeleksiBasdat\TUGAS_SELEKSI_1_18223085\Data Warehouse\src
```
2. Buat _database_ ```warehouse_kodekiddo``` pada DBMS dan sesuaikan blok kode berikut pada ```warehouse.py``` dengan DBMS Anda
```bash
**Database saat storing**
init_conn = psycopg2.connect(
    host = 'localhost',
    dbname = 'kodekiddo',
    user = 'postgres',
    password = 'veli14',
    port = 5432,
)

**Database baru untuk warehouse**
wh_conn = psycopg2.connect(
    host = 'localhost',
    dbname = 'warehouse_kodekiddo',
    user = 'postgres',
    password = 'veli14',
    port = 5432,
)
```
3. Jalankan program ```warehousing.py```
   ```bash
   python warehousing.py
```
4. Program akan berjalan dan menyimpan data pada _database_ yang telah dibuat
5. Lakukan _dumping_ pada DBMS (PostgreSQL) dengan _command_ berikut
```bash
Format: pg_dump -U <username> -h <hostname> -p <port> <database_name> > <dump_file_name>.sql
Contoh: pg_dump -U postgres -h localhost -p 5432 warehouse_kodekiddo > warehouse_kodekiddo.sql
```

### Automated Scheduling
Berikut adalah **format JSON** untuk setiap _file_ yang dihasilkan dari _scraping_:
1. Buat _task_ baru pada _Task Scheduling_ (untuk Windows) dan atur _trigger_ sesuai keinginan jadwal dan _action_ 
```bash
Program/Files: C:\Users\Velicia\OneDrive\Documents\ITB\SeleksiBasdat\TUGAS_SELEKSI_1_18223085\run_python.bat
Start in (optional): C:\Users\Velicia\OneDrive\Documents\ITB\SeleksiBasdat\TUGAS_SELEKSI_1_18223085
```
2. ```run_python.bat``` akan berjalan sesuai dengan jadwal yang telah diatur dan menjalankan setiap _file_ ```scraping.py``` ```storing.py``` ```warehousing.py```

## JSON Format
1. book_writer.json
```bash
{
  "book_id": 1,
  "writer_name": "Pankaj Kumar Verma"
}
```
2. books_price.json
```bash
{
  "book_id": 1,
  "price_zone_1": "44000",
  "price_zone_2": "45800",
  "price_zone_3": "47700",
  "price_zone_4": "69600",
  "price_zone_5": "73300",
  "price_zone_6": "91600"
}
```
3. books.json
``` bash
{
  "book_id": 1,
  "program_id": 8,
  "title": "Cendekia Digital",
  "subtitle": "Belajar Koding, Kecerdasan Artifisial & Teknologi dengan MenyenangkanKelas 5",
  "isbn": "978-634-04-0983-3",
  "writer": "Pankaj Kumar Verma, Drupal R. Shah, Khushbu Chauhan, Devi M.",
  "translator": "Meilani Hendrawidjaja",
  "total_pages": "121",
  "length": "27",
  "width": "21.6",
  "spine": "27"
}
```
4. branch.json
```bash
{
  "branch_name": "Gading Serpong",
  "address": "Ruko Golden 8 Blok C no.2Jl. Ki Hajar DewantaraSummarecon Gading SerpongSerpong Banten Indonesia"
}
```
5. coding_class_info.json
```bash
{
  "course_name": "Introduction to Coding",
  "course_materials": "Ditujukan untuk mereka yang belum memiliki pengalaman programming sebelumnya.Memperkenalkan konsep dasar programming Menggunakan visual programming languages dan online platforms. Mengerjakan simple software-hardware projects dengan robot Sphero, BB8, Dash.",
  "course_audience": "SD",
  "course_duration": "90 mins – 1x seminggu",
  "course_enrollment": 150000,
  "course_tuition": 350000,
  "program_id": 1
}
```
6. kiddo_stem_program.json
```bash
{
  "class_name": "discoverer",
  "age": "TK - SD 2",
  "program_id": 4
}
```
7. kinder_coding_package.json
```bash
{
  "package_name": "Monthly Regular",
  "membership_length": "monthly",
  "total_session": "4",
  "discount": true,
  "program_id": 3
}
```
8. paud_teacher_training.json
```bash
{
  "training_id": "paud1",
  "program_id": 6,
  "province": "Jakarta",
  "city": "Kota Jakarta Utara",
  "number_of_facilitators": "12"
}
```
9. program.json
```bash
{
  "program_id": 1,
  "program_name": "Coding & AI Class"
}
```
10. school_teacher_training.json
```bash
{
  "training_id": "school1",
  "program_id": 7,
  "province": "Banten",
  "city": "Kota Serang",
  "class_name": "SD Kota Serang 4",
  "target_audience": "22",
  "lower_bound_price": "3500000",
  "upper_bound_price": "4500000",
  "training_branch": "UPT Dinas Pendidikan Kec. Cipocok"
}
```
11. thematic_class.json
```bash
{
  "topic": "Roblox Game Creation with Code Kingdoms",
  "topic_description": "Jika kiddos suka bermain Roblox, di kelas ini kiddos TIDAK hanya bermain, tapi belajar MEMBUAT berbagai game Roblox dengan coding. Kiddos akan menggunakan Roblox Studio dan CodeKingdom untuk membuat game dan belajar konsep Object-Oriented Visual Programming. Dengan opsi dan tutorial yang menarik untuk berbagai jenis project, kiddos dapat belajar bahasa pemograman Lua dengan model drag & drop (cocok untuk pemula) atau dengan model text based programming (untuk intermediate).",
  "program_id": 2
}
```
12. webinar.json
```bash
{
  "webinar_name": "Coding & AI di Sekolah",
  "webinar_date": "2023-05-27",
  "program_id": 5
}
```
13. zone.json
```bash
{
  "zone_id": 1,
  "details": "Jawa Barat, Jawa Tengah, Jawa Timur, Daerah Istimewa Yogyakarta, DKI Jakarta, dan Banten."
}
```

## Struktur ERD dan Relasional DBMS
1. Entity-Relationship Diagram
  <img width="1531" height="1298" alt="ERD" src="https://github.com/user-attachments/assets/816b5931-213a-4806-b41b-bf33a88a8f13" />
2. Diagram Relasional
   <img width="1165" height="1428" alt="RelationalDiagram" src="https://github.com/user-attachments/assets/fd534d1a-77b8-49ca-99dc-12cf3ac7a19c" />
3. Entity-Relationship Diagram Data Warehouse
  <img width="1011" height="672" alt="ERDWarehouse" src="https://github.com/user-attachments/assets/107e77cd-0617-4c1e-b7fc-a85823f40aa1" />
4. Diagram Relasional Data Warehouse - Snowflake Schema
<img width="751" height="642" alt="SnowflakeSchema" src="https://github.com/user-attachments/assets/e768e1ed-a9da-4d19-9b56-026ed2ad0d6d" />

## ERD to Relational Diagram Translation
**1. One-to-many**
Hubungan _one-to-many_ pada ERD dapat terlihat seperti pada hubungan paud_teacher, school_teacher, produce, kiddo_stem, thematic_class, coding_class, kinder_coding. Sedangkan, pada ERD Warehouse dapat terlihat pada class_enrolled, books_needed, dan zone. Pada hubungan-hubungan tersebut, terdapat hubungan **_total-partial one-to-many_**. Hubungan ini ditranslasikan ke dalam diagram relasional dengan cara menambahkan kolom berisi _primary key_ dari tabel _one_ ke dalam tabel _many_ sehingga kolom tersebut _foreign key_ dari _many_ ke _one_.
**2. One-to-one**
Hubungan _one-to-one_ pada ERD dapat terlihat pada hubungan enrolled_at. Untuk mentranslasikan hubungan ini ke dalam diagram relasional, salah satu _primary key_ pada hubungan ini akan menjadi salah satu kolom di tabel yang lainnya. Kolom tersebut akan _foreign key_ ke _primary key_ di tabel aslinya.
**3. Many-to-many**
Hubungan _many-to-many_ pada ERD dan ERD Warehouse dapat terlihat pada hubungan book_zone dengan **_total-partial many-to-many_**. Selain itu, terdapat hubungan **_total-total many-to-many_** pada hubungan available_at. Hubungan ini ditranslasikan ke dalam diagram relasional dengan membuat tabel baru berisi _primary key_ dari masing-masing tabel yang berhubungan dan setiap _primary key_ menjadi _primary key_ pada tabel baru tersebut. Kemudian, setiap kolom akan _foreign key_ ke _primary key_ terkait.

## Documentation
### RDBMS Hasil Storing
1. book_writer
<img width="731" height="622" alt="book_writer" src="https://github.com/user-attachments/assets/4b6bc2cc-1249-47ca-8ab6-ac760e6fd6cf" />
2. book_zone
<img width="387" height="660" alt="book_zone" src="https://github.com/user-attachments/assets/4451bdc2-36cc-441c-a73d-2c3c5221a6ee" />
3. books
<img width="1914" height="166" alt="books" src="https://github.com/user-attachments/assets/9991838b-494e-43a6-89a2-86d4df69b97a" />
4. books_price
<img width="1401" height="265" alt="books_price" src="https://github.com/user-attachments/assets/207ae066-55bf-42a5-b80c-9128d889a0d1" />
5. branch
<img width="1452" height="643" alt="branch" src="https://github.com/user-attachments/assets/471eab4b-102e-408d-8533-8617015dee2a" />
6. class_program
<img width="536" height="238" alt="class_program" src="https://github.com/user-attachments/assets/227638d0-ea62-405c-ba34-692a807c9971" />
7. coding_class_info
<img width="1918" height="582" alt="coding_class_info" src="https://github.com/user-attachments/assets/2970f639-547c-4cf9-bce6-fa6da5e9b13a" />
8. kiddo_stem_program
<img width="453" height="148" alt="kiddo_stem_program" src="https://github.com/user-attachments/assets/01262567-432c-42c8-b76b-daf4226de63f" />
9. kinder_coding_program
<img width="731" height="128" alt="kinder_coding_program" src="https://github.com/user-attachments/assets/362f1ee3-0fdc-46bd-9db5-2facd173d82f" />
10. non_class_program
<img width="596" height="193" alt="non_class_program" src="https://github.com/user-attachments/assets/6b805294-31db-4609-aae3-3695b8062813" />
11. paud_teacher_training
<img width="832" height="453" alt="paud_teacher_training" src="https://github.com/user-attachments/assets/67133069-566e-4c48-8081-c6e7075f55b1" />
12. program
<img width="381" height="240" alt="program" src="https://github.com/user-attachments/assets/e26285e4-a782-402b-bcd9-50fa6e12d2d8" />
13. program_available_at
<img width="767" height="372" alt="program_available_at" src="https://github.com/user-attachments/assets/fe40316c-0e7a-43bf-92b2-d8b4e0cc831e" />
14. school_teacher_training
<img width="1600" height="453" alt="school_teacher_training" src="https://github.com/user-attachments/assets/a6c1f53d-d5a0-4c79-96f4-9a64a58a1dbe" />
15. student
<img width="639" height="117" alt="student" src="https://github.com/user-attachments/assets/8614972d-443d-4ebd-832b-13afd9ae536e" />
16. student_program
<img width="594" height="123" alt="student_program" src="https://github.com/user-attachments/assets/cf072c57-ecbb-4bee-a564-606c689137a4" />
17. thematic_class
<img width="1738" height="753" alt="thematic_class" src="https://github.com/user-attachments/assets/18e24d6b-2bdd-40b7-a862-366a439b5549" />
18. webinar
<img width="928" height="566" alt="webinar" src="https://github.com/user-attachments/assets/bbfb4877-51be-401c-8a1d-b1b6c37aba62" />
19. zone
<img width="1715" height="501" alt="zone" src="https://github.com/user-attachments/assets/773546d6-477e-4b5b-b725-91fb981e227d" />

### RDBMS Data Warehouse
1. dim_book_zone
<img width="639" height="728" alt="dim_book_zone" src="https://github.com/user-attachments/assets/23e5b3fd-4dde-46fc-86fb-7e4b531b7f3c" />
2. dim_books
<img width="1919" height="352" alt="dim_books" src="https://github.com/user-attachments/assets/4e13cc87-67a2-408d-b75d-15eb8a2dd1ea" />
3. dim_class
<img width="1919" height="786" alt="dim_class" src="https://github.com/user-attachments/assets/fb6e9e01-a2e2-4edc-abd3-adabdb31e5ba" />
4. dim_price
<img width="1181" height="228" alt="dim_price" src="https://github.com/user-attachments/assets/56474d7f-b8ad-4180-a7e5-b894c68a33a7" />
5. dim_zone
<img width="1916" height="536" alt="dim_zone" src="https://github.com/user-attachments/assets/4b6601ce-eb8d-482e-bdd7-73cc188c05eb" />
6. fact_initial_payment
<img width="691" height="857" alt="fact_initial_payment" src="https://github.com/user-attachments/assets/70abafdd-3cc8-428e-ad3a-dc61403dd831" />

### Analytical Query Data Warehouse
1. Rata-rata harga awal yang harus dibayarkan murid dari setiap zona ketika ingin mendaftar ke coding class di Kodekiddo
<img width="1210" height="761" alt="query1_avg_price" src="https://github.com/user-attachments/assets/2794904f-7b8d-4ad8-a2ff-e081f41bde4a" />
2. Harga paling murah dan harga paling mahal dari setiap course
<img width="1209" height="265" alt="query2_min_max_price" src="https://github.com/user-attachments/assets/77b3a060-a681-4539-a0fb-900b7195b57a" />

### Automated Scheduling
1. Schedule for Testing
<img width="1238" height="93" alt="scheduling_testing" src="https://github.com/user-attachments/assets/e121c763-4933-474e-9021-a5e057e56bf2" />
Untuk _testing_, dilakukan _scheduling_ pada pukul 15.50 setiap harinya dan diulang setiap 1 jam khusus tanggal 8 Agustus 2025. Selebihnya, akan dilakukan sesuai jadwal (pukul 15.50). Terlihat pada gambar bahwa program telah dijalankan pada pukul 16.50 dan akan dijalankan kembali satu jam kemudian.
2. Schedule Final
<img width="1227" height="88" alt="scheduling_final" src="https://github.com/user-attachments/assets/d2827418-3f07-40c5-9aa9-36ec2e40b134" />
_Schedule_ yang sebenarnya adalah pukul 15.50 setiap harinya dan program akan dijalankan kembali pada pukul 15.50 keesokan harinya.
3. Scheduling Log Result (15.50)
<img width="1352" height="319" alt="scheduled_15 50" src="https://github.com/user-attachments/assets/bddba482-0bc8-4b0e-b51e-f4bdcd935d20" />
4. Scheduling Log Result (16.50)
<img width="1365" height="295" alt="scheduled_16 50" src="https://github.com/user-attachments/assets/f79dcda5-aba6-44fc-b06e-fe5891a2ce07" />

## Reference
1. Library
[BeautifulSoup4]([url](https://pypi.org/project/beautifulsoup4/))
[Selenium]([url](https://www.selenium.dev/))
[JSON]([url](https://www.json.org/json-en.html))
[Python]([url](https://www.python.org/))
2. Third-party Application
Task Scheduler (on Windows)
VSCode (IDE)
3. Website Source
[KodeKiddo]([url](https://kodekiddo.com/))
4. Videos
[Web Scraping Tutorial]([url](https://youtu.be/XVv6mJpFOb0?si=fkwsSaJzfMIC0OyX))
[Automated Scheduling]([url](https://youtu.be/F6o6cuPEIAs?si=WKIvb3iWghr9Av4c))
