<h1 align="center">
  Seleksi Warga Basdat 2025 <br>
  ETL Project
</h1>

<h2 align="center">
  Data Scraping, Storing, Warehousing, and Automated Scheduling from Tech in Asia <br>
  <i>Sendi Putra Alicia - 18223063</i>
</h2>

---

## 📚 Daftar Isi
- [📌 Deskripsi Proyek](#-deskripsi-proyek)
- [⚙️ Cara Menjalankan (How to Use)](#️-cara-menjalankan-how-to-use)
- [📦 Struktur File JSON Hasil Scraping](#-struktur-file-json-hasil-scraping)
- [🧩 Translasi ERD ke Diagram Relasional](#-translasi-erd-ke-diagram-relasional)
- [⏰ Automated Scheduling (Cron)](#-automated-scheduling-cron)

---

## 📌 Deskripsi Proyek

Tech in Asia adalah platform teknologi dan startup yang juga menyediakan listing pekerjaan. Topik ini dipilih karena:
- Data **variatif dan kaya atribut** (job, company, salary, dsb).
- Data bersifat **dinamis** (terus berubah tiap hari).
- Cocok untuk dianalisis dalam bentuk **data warehouse**.
- Mendukung penerapan **automated ETL dan scheduling** untuk update berkala.

---

## ⚙️ Cara Menjalankan (How to Use)

## 🔹 1. Jalankan Scraper Saja

### 1. Clone repo
    $ git clone https://github.com/sendialicia/Seleksi-2025-Tugas-1.git
 
### 2. Install dependency
    $ pip install -r requirements.txt

### 3. Buka folder hasil cloning
    $ cd Seleksi-2024-Tugas-1/Data Scraping/src
    
### 4. Run program
    $ scraper.py

### 🔹 2. Menjalankan dengan cron (Automated-Scheduling)

### 1. Buka terminal, jalankan:
    $ crontab -e
 
### 2. Tentukan waktu eksekusi, disini saya menggunakan automated_scheduling 30 menit sekali:
<img width="691" height="56" alt="Screenshot 2025-08-08 at 19 50 25" src="https://github.com/user-attachments/assets/e32a4e81-75d8-4d9a-86ea-abfd35aac5e2" />

### 3. Pastikan path Python dan file benar
    $ which python3

### 5. Cek hasil log
    <img width="616" height="440" alt="Screenshot 2025-08-08 at 19 54 02" src="https://github.com/user-attachments/assets/a7d87328-0483-48c0-8fcc-52f5a6bde8c2" />

    

## Struktur ERD dan diagram relasional RDBMS
<img width="1301" height="1118" alt="ERD" src="https://github.com/user-attachments/assets/22207416-bf2f-4960-acfa-36dd35ab5400" />

<img width="1166" height="1196" alt="Relational" src="https://github.com/user-attachments/assets/7c8443a8-b093-438b-a476-83da73a85597" />

## Proses Translasi ERD ke Diagram Relasional

- **One-to-One (1:1)**  

Kedua entitas dikonversi menjadi relasi seperti biasa.
Tambahkan foreign key dari salah satu entitas ke entitas lainnya.
Foreign key ini juga dijadikan primary key untuk menjaga constraint 1:1.
Penempatan foreign key tergantung pada sisi yang memiliki total participation.
<img width="991" height="441" alt="One to one" src="https://github.com/user-attachments/assets/0945bb50-dc0f-4fa9-9a1f-591e518b18aa" />

- **One-to-Many (1:N)**  
Kedua entitas dikonversi menjadi relasi seperti biasa. Tambahkan foreign key pada entitas di sisi N yang mereferensikan primary key dari sisi 1. Foreign key ini memungkinkan keterhubungan banyak entitas di sisi N terhadap satu entitas di sisi 1.
<img width="1232" height="268" alt="One to many" src="https://github.com/user-attachments/assets/85ceab7b-4e09-4206-aa39-4f71dd296310" />

- **Many-to-Many (M:N)**  
Kedua entitas dikonversi menjadi relasi seperti biasa. Buat relasi baru (tabel junction) untuk merepresentasikan relationship. Tabel junction ini berisi foreign key dari masing-masing entitas (M dan N), yang juga menjadi primary key gabungan.
<img width="930" height="399" alt="Many to many" src="https://github.com/user-attachments/assets/a4669c58-9613-450a-a530-29aa2ae10d35" />

- **Ternary Relationship**  
Hubungan yang melibatkan tiga entitas sekaligus. Diterjemahkan menjadi tabel baru yang menyimpan foreign key dari ketiga entitas tersebut.
<img width="1682" height="765" alt="Ternary" src="https://github.com/user-attachments/assets/a5a8a206-371f-433d-8d2b-ac3bd7df2210" />

- **Multivalued Attribute**  
Setiap atribut multivalue dikonversi menjadi relasi (tabel) baru. Tabel ini berisi: Primary key dari entitas asal. Atribut multivalue tersebut. Primary key tabel ini biasanya merupakan gabungan dari keduanya.
<img width="591" height="331" alt="Multivalued attribute" src="https://github.com/user-attachments/assets/7628799d-4132-42ca-a1f3-50aac106f40f" />

- **Derived Attribute**  
Atribut yang nilainya dapat dihitung dari atribut lain. Biasanya tidak disimpan di database, tapi dihitung saat query atau diproses dalam ETL.
<img width="751" height="275" alt="Derived attribute" src="https://github.com/user-attachments/assets/15a0c6a2-f0bf-46f2-8bf1-32d683bffa27" />

- **Weak Entity**  
Entitas yang identitasnya bergantung pada entitas lain. Diterjemahkan dengan menyertakan foreign key dari entitas induk sebagai bagian dari primary key.
<img width="1232" height="269" alt="Weak entity" src="https://github.com/user-attachments/assets/d17ba176-65e7-4a00-8478-09c3811b8b10" />

- **Inheritance**  
Pendekatan 1 – Multiple Tables (Relasi Terpisah untuk Setiap Entitas) Buat relasi untuk entitas general dan semua entitas spesifik. Relasi spesifik menyimpan primary key dari relasi general sebagai foreign key.
<img width="1841" height="850" alt="Inheritance" src="https://github.com/user-attachments/assets/78889e01-c4bf-4d93-9fc9-4171c0817905" />

- **Aggregate**  
Konversi semua entitas dalam agregasi menjadi relasi. Konversi entitas yang berhubungan dengan agregasi menjadi relasi. Buat satu relasi untuk relationship agregasi, berisi: Primary key dari semua entitas dalam agregasi. Primary key dari entitas luar agregasi.
<img width="1682" height="765" alt="Aggregate" src="https://github.com/user-attachments/assets/8f1cacc8-2306-477d-b1db-a435445066f5" />

---
## Screenshot program
Program dimulai dengan melakukan setup Selenium WebDriver, yaitu alat dari pustaka Selenium yang memungkinkan kita mengontrol browser secara otomatis layaknya pengguna manusia.
<img width="1014" height="374" alt="ss_setup_driver" src="https://github.com/user-attachments/assets/debd93a4-5569-4f11-9078-bd788287f059" />

Sebelum mulai scraping, program melakukan persiapan scrolling otomatis hingga batas maksimal tertentu, karena data lowongan kerja dimuat secara dinamis saat halaman di-scroll ke bawah. Untuk setiap lowongan kerja yang ditemukan, program akan mengekstrak judul pekerjaan dan link-nya,
<img width="751" height="597" alt="ss_scrape_job_location" src="https://github.com/user-attachments/assets/27b7308a-d067-4eec-ab1d-d2159d050ed2" />

<img width="871" height="361" alt="ss_scrape_compensation_posteddate" src="https://github.com/user-attachments/assets/a8323663-3e7f-4cd3-88bf-10350023a334" />

Selain judul dan link, scraper juga mengambil informasi penting lainnya seperti kompensasi (gaji), yang tidak langsung disimpan, tetapi diproses terlebih dahulu melalui tahapan preprocessing agar format dan nilainya bersih dan terstandarisasi.
<img width="506" height="527" alt="ss_preprocessing_compensation" src="https://github.com/user-attachments/assets/7fa8a684-0e2f-4e6c-b950-5bd7d0efef77" />

Setiap data hasil scraping kemudian di-append satu per satu ke struktur data Python (list of dicts) agar mudah dikumpulkan dan dikelola.
<img width="465" height="477" alt="ss_append_unique_2" src="https://github.com/user-attachments/assets/436d8f38-f2a9-471f-a232-8062a8a13410" />

Terakhir, data JSON yang sudah distandarisasi tersebut akan dikirim dan disimpan ke dalam database PostgreSQL, sehingga bisa dimanfaatkan dalam data warehouse untuk analisis lanjutan atau automasi.
<img width="722" height="416" alt="ss_storing_3" src="https://github.com/user-attachments/assets/9b65645d-21c8-43ad-bfbb-3a4121610071" />

## Penjelasan Library yang Digunakan

Berikut adalah library utama yang digunakan dalam proyek ETL dan web scraping ini beserta fungsi dan pertimbangannya:

---

### 1. Selenium

- **Fungsi:** Automasi browser untuk scraping data dari website dinamis dengan interaksi kompleks seperti klik, input, dan menunggu elemen muncul.
- **Pertimbangan:** Data job listing di Tech In Asia bersifat dinamis dan berubah-ubah setiap hari. Scraping statis menggunakan request biasa kurang efektif karena tidak mengeksekusi JavaScript. Selenium mampu menjalankan rendering halaman penuh sehingga data yang diperoleh lebih akurat.
- **Referensi:** Selenium banyak digunakan untuk web automation dan testing, cocok untuk scraping yang membutuhkan rendering halaman.  
  Contoh referensi: *Selenium with Python - BrowserStack*.

---

### 2. selenium.webdriver.common.by.By

- **Fungsi:** Memudahkan pencarian elemen di halaman dengan strategi berbeda seperti `ID`, `CSS selector`, `XPath`, dll.
- **Pertimbangan:** Menjamin elemen yang dituju ditemukan dengan tepat sehingga scraping berjalan stabil dan tahan perubahan kecil pada DOM.

---

### 3. selenium.webdriver.support.ui.WebDriverWait

- **Fungsi:** Melakukan *explicit wait*, yaitu menunggu kondisi tertentu terpenuhi (misal elemen muncul) sebelum menjalankan perintah selanjutnya.
- **Pertimbangan:** Menghindari error ketika elemen belum siap di halaman, sangat penting saat menghadapi website dengan loading data asinkron.

---

### 4. selenium.webdriver.chrome.options.Options

- **Fungsi:** Mengatur opsi browser Chrome, contohnya menjalankan mode *headless* tanpa tampilan GUI.
- **Pertimbangan:** Mode headless menghemat resource dan cocok untuk scraping yang dijalankan di server tanpa antarmuka grafis.

---

### 5. Standard Python Libraries: `time`, `re`, `datetime`, `timedelta`, `hashlib`, `os`, `json`

- **Fungsi:**
  - `time`: Mengatur jeda atau delay selama scraping.
  - `re`: Ekstraksi dan pembersihan data dengan ekspresi reguler.
  - `datetime`, `timedelta`: Manipulasi tanggal dan waktu, misalnya parsing tanggal posting pekerjaan.
  - `hashlib`: Membuat hash unik, misalnya untuk ID data.
  - `os`: Operasi sistem file dan folder.
  - `json`: Membaca dan menulis data dalam format JSON hasil scraping.
- **Pertimbangan:** Library standar yang sangat umum digunakan dalam pengolahan data dan pengelolaan file.

---

### 6. psycopg2

- **Fungsi:** Driver untuk koneksi dan manipulasi database PostgreSQL dari Python.
- **Pertimbangan:** Untuk menyimpan hasil scraping ke database PostgreSQL dalam proyek ETL ini, `psycopg2` dipilih karena stabil, populer, dan mendukung DB API 2.0 yang lengkap.
- **Referensi:** Driver resmi yang well-documented untuk integrasi Python dan PostgreSQL.

---

### 7. logging dan traceback

- **Fungsi:** Mencatat aktivitas dan error yang terjadi saat scraping dan proses ETL.
- **Pertimbangan:** Sangat membantu dalam debugging dan monitoring terutama saat proses dijalankan secara otomatis (misal dengan cron job).

---

*Dokumentasi lebih lengkap tentang library ini bisa kamu akses di dokumentasi resmi masing-masing library dan sumber pembelajaran Python terkait.*

## Reference
1. link website: https://www.techinasia.com/jobs/search?country_name[]=Indonesia&country_name[]=Singapore&country_name[]=Malaysia&country_name[]=Vietnam&country_name[]=India&country_name[]=Philippines&country_name[]=Australia&country_name[]=Japan&country_name[]=Korea%2C%20Republic%20of&country_name[]=Thailand&country_name[]=China&ref=nav
2. Referensi selenium: https://selenium-python.readthedocs.io/, https://www.browserstack.com/guide/python-selenium-to-run-web-automation-test
3. Referensi psycopg2: https://pypi.org/project/psycopg2/



