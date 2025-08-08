 <h1 align="center">
  <br>
  Seleksi Warga Basdat 2025 <br>
  ETL Project <br>
  Kalm Studios
  <br>
  <br>
</h1>

## Author
**Nama:** Desati Dinda Saraswati

**NIM:** 18223110

## Deskripsi

### System Description
KALM Studios adalah studio pilates dan yoga yang terkenal di area Bekasi. Studio ini dibuka di Summarecon Bekasi pada September 2024 dan dikelola oleh Keiko Indrijani, seorang instruktur bersertifikasi dari Stott Pilates Institute. KALM Studios memiliki website pada laman kalmstudios.id yang menampilkan informasi lengkap tentang lima kategori kelas utama: Yoga, Mat Pilates, Prenatal Yoga, Private Pilates, dan Group Reformer, beserta jadwal, instruktur, review member, dan sistem booking online.

### Database Management System (DBMS)
**DBMS yang Dipilih:** PostgreSQL  
**Database Name:** `kalmstudios`

Database yang dibuat terdiri dari 8 tabel utama:
- **Categories** - Master kategori kelas (Yoga, Mat Pilates, Prenatal Yoga, Private Pilates, Group Reformer)
- **Classes** - Detail informasi setiap kelas dengan durasi, tingkat kesulitan, dan deskripsi
- **Equipment** - Daftar equipment yang dibutuhkan
- **Class_Equipment** - Junction table untuk relasi many-to-many antara kelas dan equipment
- **Instructors** - Data instruktur dengan nama dan role
- **Reviews** - Review kelas dengan composite primary key (weak entity)
- **Related_Classes** - Rekomendasi kelas terkait dengan composite primary key (weak entity)
- **Schedules** - Jadwal kelas harian dengan instruktur dan lokasi

### Alasan Pemilihan Topik
Saya memilih KALM Studios karena website ini menyediakan data yang beragam dan variatif dengan struktur relasional yang menarik untuk database modeling. Data mencakup berbagai entitas yang saling berhubungan seperti kelas, instruktur, reviews, equipment, dan jadwal dengan variasi tipe data yang banyak sehingga memungkinkan implementasi konsep database lanjutan seperti weak entities, junction tables, dan composite primary keys.

## Cara Menggunakan

### Data Scraping
Clone repository
```bash
$ git clone https://github.com/desatidinda/Seleksi-2025-Tugas-1.git
```

Install library di cmd
```bash
$ pip install selenium
$ pip install beautifulsoup4
```

Install ChromeDriver
- Install pada halaman [ChromeDriver Downloads](https://chromedriver.chromium.org/downloads)
- Pastikan bahwa Chrome, ChromeDriver, dan Python memiliki versi yang sama (64 bit/ 32 bit)
- Masukkan path ChromeDriver tersebut ke dalam Environment Variables, lalu sesuaikan path pada script scraping

Buka folder hasil cloning
```bash
$ cd Seleksi-2025-Tugas-1/Data\ Scraping/src
```

Jalankan program scraping utama
```bash
$ python scraper.py
```

Jalankan program scraping jadwal
```bash
$ python schedule_scraper.py
```

### Data Preprocessing
Masuk ke folder Data Scraping
```bash
$ cd Seleksi-2025-Tugas-1/Data\ Scraping/src
```

Jalankan preprocessing
```bash
$ python preprocessor.py
```

### Data Storing
Buat database pada PostgreSQL, contoh:
```python
host="localhost",
user="postgres", 
password="your_password",
dbname="kalmstudios",
port=5432
```

Install library di cmd
```bash
$ pip install psycopg2-binary
```

Buka folder hasil cloning
```bash
$ cd Seleksi-2025-Tugas-1/Data\ Storing/src
```

Jalankan program
```bash
$ python storing.py
```

Export database tersebut dalam format SQL
```bash
$ pg_dump -U postgres -d kalmstudios -s > kalmstudios.sql
```

### Data Warehousing
Buat database pada PostgreSQL, contoh:
```python
host="localhost",
user="postgres", 
password="your_password",
dbname="kalmstudios_warehouse",
port=5432
```

Buka folder hasil cloning
```bash
$ cd Seleksi-2025-Tugas-1/Data\ Warehouse/src
```

Jalankan program
```bash
$ python warehousing.py
```

Export database tersebut dalam format SQL
```bash
$ pg_dump -U postgres -d kalmstudios_warehouse -s > kalmstudios_warehouse.sql
```

## Struktur File JSON
### Data Hasil Preprocessing (`data/preprocessed/`)

#### 1. `final_categories.json`
File JSON yang menyimpan data kategori
```json
  {
    "category_id": 1,
    "category_name": "Yoga"
  }
```

#### 2. `final_classes.json`
File JSON yang menyimpan data kelas utama yang di-scrape
```json
  {
    "class_id": "021ec006-09cd-4db7-bc7d-46eec8e047fb",
    "name": "Private Pilates (Mat, Reformer, Cadillac, Chair, Barrel)",
    "category_id": 3,
    "duration": 55,
    "difficulty_level": "Open to all",
    "location": "Summarecon Bekasi",
    "about_class_description": "*THIS CLASS IS NOT SUITABLE FOR PRENATAL / POST-NATAL / SCOLIOSIS CLIENTS*A private Pilates Reformer class offers personalized..."
  }
```

#### 3. `final_equipment.json`
File JSON yang menyimpan data equipment yang di-scrape
```json
  {
    "equipment_id": 1,
    "equipment_name": "Grip Socks"
  }
```

#### 4. `final_class_equipment.json`
File JSON yang menyimpan data junction table antara relasi classes dan equipment yang di-scrape
```json
  {
    "class_id": "021ec006-09cd-4db7-bc7d-46eec8e047fb",
    "equipment_id": 1
  }
```

#### 5. `final_instructors.json`
File JSON yang menyimpan data instruktur yang di-scrape
```json
  {
    "instructor_id": "instructor_1",
    "name": "Keiko Indrijani",
    "role": "Pilates Instructor"
  }
```

#### 6. `final_reviews.json`
File JSON yang menyimpan data review kelas yang di-scrape
```json
  {
    "class_id": "021ec006-09cd-4db7-bc7d-46eec8e047fb",
    "review_order": 1,
    "instructor_reviewed": "Zara Alia",
    "review_text": "suka selalu kelas kak zara pedes2 tapi nagih",
    "review_location": "Summarecon Bekasi",
    "stars_rating": 5
  }
```

#### 7. `final_related_classes.json`
File JSON yang menyimpan data kelas terkait dari kelas utama yang di-scrape
```json
  {
    "main_class_id": "021ec006-09cd-4db7-bc7d-46eec8e047fb",
    "related_order": 1,
    "title": "Private Pilates (Mat & Reformer)",
    "stars_rating": 4.5,
    "duration": 55,
    "difficulty_level": "Open to all",
    "description": "A personalized Pilates session focusing on Mat and Reformer exercises..."
  }
```

#### 8. `final_schedules.json`
File JSON yang menyimpan data jadwal yang di-scrape
```json
  {
    "schedule_id": "schedule_1",
    "class_id": "021ec006-09cd-4db7-bc7d-46eec8e047fb",
    "instructor_id": "instructor_1",
    "date": "2024-12-15",
    "start_time": "10:00:00",
    "duration": 55,
    "location": "Summarecon Bekasi"
  }
```

## Struktur Database

### Entity Relationship Diagram
![ER Diagram](Data%20Storing/design/ER%20Diagram.png)

### Relational Diagram
![Relational Diagram](Data%20Storing/design/Relational%20Diagram.png)

### Penjelasan Proses Translasi
#### 1. Pemetaan entity menjadi relasi
##### a. Strong Entity
Strong Entity adalah entitas yang dapat berdiri sendiri dan memiliki Primary Key sendiri. Pada Strong Entity, atribut yang dimilikinya akan diturunkan menjadi kolom pada tabel di relational diagram. Untuk menjaga konsistensi data, derived attribute yang ada pada ER diagram akan dihapus pada relational diagram.

Classes = (class_id, name, duration, difficulty_level, location, about_class_description)
![Classes Entity](Data%20Storing/design/strongentity%20(1).png)
Categories = (category_id, category_name)
![Categories Entity](Data%20Storing/design/strongentity%20(2).png) 
Equipment = (equipment_id, equipment_name)
![Equipment Entity](Data%20Storing/design/strongentity%20(3).png)
Schedules = (schedule_id, date, start_time, duration, location)
![Schedule Entity](Data%20Storing/design/strongentity%20(4).png)
Instructors = (instructor_id, name, role)
![Instructors Entity](Data%20Storing/design/strongentity%20(5).png)

##### b. Weak Entity
Weak Entity adalah entitas yang keberadaannya bergantung pada strong entity lain dan tidak memiliki Primary Key yang berdiri sendiri.
Pada Weak Entity, identitas uniknya dibentuk dari Primary Key milik strong entity yang menjadi induknya ditambah dengan atribut pembeda (discriminator).

Pada kasus ini, Reviews dan Related_Classes merupakan Weak Entity yang bergantung pada Classes, dengan atribut diskriminator review_order pada Reviews dan related_order pada Related_Classes. Primary Key untuk kedua Weak Entity tersebut berbentuk komposit, yaitu gabungan antara class_id dan atribut diskriminatornya.

Reviews = (review_order, instructor_reviewed, review_text, stars_rating, class_id)
![Reviews Entity](Data%20Storing/design/weakentity%20(1).png)
Related_Classess = (related_order, title, stars_rating, duration, difficulty_level, description, main_class_id)
![Relates_Classes Entity](Data%20Storing/design/weakentity%20(2).png)

#### 2. Pemetaan relationship menjadi relasi
##### a. One-to-Many
Dalam translasi relationship dengan cardinality one-to-many, tidak perlu dibuat tabel relasi baru. Cukup dengan menambahkan Primary Key dari entitas pada sisi one sebagai Foreign Key di entitas pada sisi many untuk menghindari redundansi data dan nilai null. Pada kasus ini, relasi Classes (one) dengan Schedules (many) diterjemahkan dengan menambahkan class_id sebagai Foreign Key di tabel Schedules, relasi Category (one) dengan Classes (many) diterjemahkan dengan menambahkan category_id sebagai Foreign Key di tabel Classes, dan relasi Instructor (one) dengan Schedules (many) diterjemahkan dengan menambahkan instructor_id sebagai Foreign Key di tabel Schedules.

Schedules = (schedule_id, date, start_time, duration, location, class_id)
![One-to-Many: 1](Data%20Storing/design/one-to-many%20(1).png)
Classes = (class_id, name, duration, difficulty_level, location, about_class_description, category_id)
![One-to-Many: 2](Data%20Storing/design/one-to-many%20(2).png)
Schedules = (schedule_id, date, start_time, duration, location, class_id, instructor_id)
![One-to-Many: 3](Data%20Storing/design/one-to-many%20(3).png)

##### a. Many-to-Many
Dalam translasi relationship dengan kardinalitas many-to-many, perlu dibuat tabel relasi baru (junction table) yang berisi Primary Key dari kedua entitas sebagai Primary Key komposit. Pendekatan ini digunakan untuk menghubungkan data tanpa menimbulkan redundansi. Pada kasus ini, relasi Classes (many) dengan Equipment (many) ditranslasikan dengan membuat tabel class_equipment yang memiliki atribut class_id dan equipment_id sebagai Primary Key komposit, di mana masing-masing juga berperan sebagai Foreign Key yang merujuk ke tabel Classes dan Equipment.

Class_Equipment = (class_id, equipment_id)
![Many-to-Many: Classes to Equipment](Data%20Storing/design/many-to-many.png)

## Screenshots

### Data Storing
#### 1. Tabel Categories
![Categories Table](Data%20Storing/screenshot/ss_categories.png)
#### 2. Tabel Classes
![Classes Table](Data%20Storing/screenshot/ss_classes.png)
#### 3. Tabel Equipment
![Equipment Table](Data%20Storing/screenshot/ss_equipment.png)
#### 4. Tabel Class_Equipment
![Class_Equipment Junction](Data%20Storing/screenshot/ss_classequipment.png)
#### 5. Tabel Instructors
![Instructors Table](Data%20Storing/screenshot/ss_instructors.png)
#### 6. Tabel Reviews
![Reviews Table](Data%20Storing/screenshot/ss_reviews.png)
#### 7. Tabel Related_Classes
![Related Classes Table](Data%20Storing/screenshot/ss_relatedclasses.png)
#### 8. Tabel Schedule
![Schedule_Table](Data%20Storing/screenshot/ss_schedules.png)

### Data Warehouse
#### 1. Tabel Dim_Classes
![Dim Classes Table](Data%20Warehouse/screenshot/ss_dimclasses.png)
#### 2. Tabel Dim_Date
![Dim Date Table](Data%20Warehouse/screenshot/ss_dimdate.png)
#### 3. Tabel Dim_Instructor
![Dim Instructor Table](Data%20Warehouse/screenshot/ss_diminstructor.png)
#### 4. Tabel Dim_Location
![Dim Location Table](Data%20Warehouse/screenshot/ss_dimlocation.png)
#### 5. Tabel Fact_Class_Summary
![Fact Class Summary Table](Data%20Warehouse/screenshot/ss_factclasssummary.png)

### Query Examples
#### Query 1: Studio Utilization Overview
![Query Result 1](Data%20Warehouse/screenshot/query1.png)
#### Query 2: Instructor Workload
![Query Result 2](Data%20Warehouse/screenshot/query2.png)
#### Query 3: Daily Schedule Statistics
![Query Result 3](Data%20Warehouse/screenshot/query3.png)

## Data Warehouse

### Star Schema
![Star Schema Diagram](Data%20Warehouse/design/star_schema.png)

## Translasi
Dalam proses translasi dari ERD ke star schema warehouse, dilakukan beberapa transformasi. **fact_class_summary** ditambahkan kolom `class_key`, `instructor_key`, `date_key`, dan `location_key` sebagai foreign key dari sisi many karena adanya relasi many-to-one dengan masing-masing dimension table. **dim_classes** ditambahkan kolom `category_name` sebagai denormalisasi dari relasi one-to-many dengan tabel `categories` untuk menghindari join yang kompleks. Relasi many-to-many antara `classes` dan `equipment` tidak ditranslasi langsung, melainkan diagregasi menjadi kolom `equipment_count` di fact table. **dim_date** dan **dim_location** merupakan dimension table baru yang diekstrak dari data operasional untuk mendukung analisis.

## Referensi

### Library yang Digunakan
- **selenium**: Digunakan untuk automasi web browser dan mengontrol browser secara otomatis untuk melakukan scraping pada konten dari website KalmStudios yang dinamis
- **beautifulsoup4**: Digunakan untuk parsing HTML dan ekstraksi data dari halaman web yang telah di-scrape
- **psycopg2-binary**: Adapter database PostgreSQL untuk Python yang digunakan untuk memasukkan data yang ada di file JSON secara otomatis
- **json**: Library bawaan Python untuk serialisasi dan deserialisasi data JSON
- **re**: Digunakan untuk pemrosesan teks dan pattern matching dalam preprocessing data
- **datetime**: Digunakan untuk penanganan data tanggal dan waktu dalam pemrosesan timestamp
- **collections (defaultdict)**: Digunakan untuk optimisasi preprocessing dengan penghitungan otomatis

### Sumber Data
- **Website**: [KALM Studios](https://kalmstudios.id)
- **Halaman yang Di-scrape**: 
  - Halaman detail kelas: `https://kalmstudios.id/class/[class-id]`
  - Profil instruktur: `https://kalmstudios.id/instructors`
  - Daftar jadwal: `https://kalmstudios.id/schedule`


