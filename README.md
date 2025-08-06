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
    $ pip install selenium
    $ pip install beutifulsoup4
```

3. Intall ChromeDriver
    - Intall pada halaman (https://chromedriver.chromium.org/downloads)
    - Pastikan bahwa __Chrome, ChromeDriver, dan Python__ memiliki versi yang sama (64 bit/ 32 bit)
    - Masukkan path ChromeDriver tersebut ke dalam *Environment Variables*
    - Ikuti langkah-langkah pada video berikut jika menemui bug : <a href="https://www.youtube.com/watch?v=ijT2sLVdnPM"> Fix Selenium</a>

4. Buka folder hasil cloning
```sh
    $ cd Seleksi-2025-Tugas-1/Data Scraping/src
```

5. Jalankan program 
```sh
    $ scraping.py
```

### Data Storing
1. Buat database pada __PostgreSQL__, contoh:
```sh
    host="localhost",
    user="postgres",
    password="@EgojihJiau02",
    dbname="borma_dago",
    port=5432
```

2. Intall library di cmd
```sh
    $ pip install psycopg2
```

3. Buka folder hasil cloning
```sh
    $ cd Seleksi-2025-Tugas-1/Data Scraping/src
```

4. Jalankan program 
```sh
    $ storing.py
```

5. Export database tersebut dalam formal SQL
```sh
    $ pg_dump -U <username> -d <database_name> -s > <output_file.sql>
```

## JSON Structure
Berikut adalah *6 instance* data JSON yang dihasilkan:
1. `produk.json`
```json
{
    "ID_prod": "8992761136208",
    "nama_prod": "Pulpy Orange",
    "harga_prod": "13600",
    "terjual_prod": "50",
    "kat_prod": "Minuman Rasa Buah",
    "nama_sup": "PT COCA-COLA BOTTLING INDONESIA"
}
```

2. `diskon_prod.json`
```json
{
    "ID_prod": "8995151170042",
    "nama_prod": "Mustika Ratu Gula Asem B",
    "harga_prod_norm": "7100",
    "harga_prod_disc": "4970",
    "terjual_prod": 0,
    "kat_prod": "Minuman Dalam Kemasan",
    "nama_sup": "PT MUSTIKA RATU TBK",
    "nama_prom": "Diskon Produk Sidomuncul Rtd"
}
```

3. `normal_prod.json`
```json
{
    "ID_prod": "089686010947"
}
```

4. `promo.json`
```json
{
    "nama_prom": "Free Ongkir (Min. 300,000)",
    "rentang_prom": "2024-12-31"
}
```

5. `potongan_prom.json`
```json
{
    "nama_prom": "Diskon Produk Ashitaki Mi"
}
```

6. `normal_prom.json`
```json
{
    "nama_prom": "Free Ongkir (Min. 300,000)",
    "sisa_prom": "253",
    "jumlah_prom": "10000",
    "kode_prom": "FREESHIPPING2024"
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
- *Produk* = (__id_prod__, nama_prod, harga_prod, terjual_prod, kat_prod, berat_prod, nama_sup)
- *Pelanggan* = (__id_pel__, nama_pel, nomor_pel, email)
- *Promo* = (__nama_prom__, rentang_prom)
- *Keranjang* = (__id_ker__, date_ker, time_ker)

`one-to-one Relationship`

Cara translasi nya adalah dengan membawa PK dari salah satu sisi sebagai FK di sisi lain yang paling sesuai (bebas)
<div align="center">
  <img src="Data Storing/design/one-to-one.png" width="600"/>
</div>

- *Transaksi* = (__id_tran__, jenis_tran, id_ker)

FK:
- *Transaksi*(id_ker) --> *Keranjang*(id_ker)

b) *Weak Entity*

*Weak Entity* adalah entitas yang tidak bisa berdiri sendiri dan bergantung pada entitas lain, serta memiliki __*diskriminator*__ (contohnya adalah atribut "Urutan" pada tabel "Orders").
<div align="center">
  <img src="Data Storing/design/Weak-Entity.png" width="600"/>
</div>


- *Orders* = (__id_ker__, __urutan__, kuantitas, id_prod)

FK:
- *Orders*(id_ker) --> *Keranjang*(id_ker)
- *Orders*(id_prod) --> *Produk*(id_prod) (*One-to-many*)

#### __2. Pemetaan *relationship* menjadi relasi__

Pemetaan relationship menjadi relasi berarti mengubah representasi hubungan antar entitas dalam model data menjadi tabel dalam database relasional.

a) Pemetaan `many-to-many relationship` menjadi relasi

Cara translasi nya adalah dengan membuat relationship antara kedua tabel menjadi entitas baru yang mengandung PK dari kedua belah sisi
<div align="center">
  <img src="Data Storing/design/many-to-many.png" width="600"/>
</div>

- *Digunakan* = (__id_prod__, __nama_prom__)

FK:
- *Digunakan*(id_prod) --> *Produk*(id_prod)
- *Digunakan*(nama_prom) --> *Promo*(nama_prom)

b) Pemetaan *ternary relationship* menjadi relasi

Relasi ternary melibatkan tiga entitas dan direpresentasikan dengan tabel yang mencakup ketiga entitas tersebut. Hubungan antara ketiga entitas tersebut akan dibuat menjadi entitas baru yang memiliki PK dari entitas denngan sisi many dan FK dari ketiga entitas.

<div align="center">
  <img src="Data Storing/design/ternary.png" width="600"/>
</div>

- *Pesanan* = (__id_prod__, __id_ker__, id_pel)

FK:
- *Pesanan*(id_prod) --> *Produk*(id_prod)
- *Pesanan*(id_ker) --> *Keranjang*(id_ker)
- *Pesanan*(id_pel) --> *Pelanggan*(id_pel)

#### __3. Pemetaan *specialization/ generalization* menjadi relasi__

Specialization/generalization adalah konsep di mana entitas dapat dibagi menjadi sub-entitas yang lebih spesifik atau digabungkan menjadi entitas yang lebih umum.

<div align="center">
  <img src="Data Storing/design/specialization.png" width="600"/>
</div>

- *Diskon_prod* = (__id_prod__, nama_prom, harga_disc)
- *Normal_prom* = (__nama_prom__, sisa_prom, jumlah_prom, kode_prom)

`One-To-Many Relationship`

Cara translasi nya adalah dengan membawa PK dari sisi One sebagai FK di sisi Many

<div align="center">
  <img src="Data Storing/design/one-to-many.png" width="600"/>
</div>

- *Normal_prod* = (__id_prod__)
- *Potongan_prom* = (__nama_prom__)

FK:
- *Diskon_prod*(id_prod) --> *Produk*(id_prod)
- *Diskon_prod*(nama_prom) --> *Potongan_prom*(nama_prom) (*One-to-many*)
- *Normal_prod*(id_prod) --> *Produk*(id_prod)
- *Potongan_prom*(nama_prom) --> *Promo*(nama_prom)
- *Normal_prom*(nama_prom) --> *Promo*(nama_prom)

__4. Pemetaan *composit attributes* menjadi relasi__

Atribut multivalued adalah atribut yang dapat memiliki lebih dari satu nilai untuk satu entitas. Dalam database relasional, atribut ini biasanya dipecah menjadi tabel terpisah.

<div align="center">
  <img src="Data Storing/design/composit.png" width="600"/>
</div>

- *Alamat_pel* = (__id_pel__, __al_jalan__, __al_NoR__)

FK:
- *Alamat_pel*(id_pel) --> *Pelanggan*(id_pel)


## Screenshot
### Tampilan *Website*
<div align="center">
  <img src="Data Scraping/screenshot/ss_website.png" width="600"/>
</div>

### Data Scrapping & Pre-processing
`Ekstraksi Data`

Program akan dijalankan dengan menggunakan parameter link website, jumlah *click* yang menentukan banyaknya halaman website yang ingin diambil datanya, dan nama file output yang diinginkan.
<div align="center">
  <img src="Data Scraping/screenshot/ss_running.png" width="600"/>
</div>

Data id dan nama produk bisa didapatkan pada halaman pertama website. untuk mendapatkan informasi tambahan seperti perusahaan dan kategori produk maka kita harus melakukan *click* pada *card* produk yang ingin di lihat (__2 kali *click*__).
<div align="center">
  <img src="Data Scraping/screenshot/ss_scraping_produk.png" width="600"/>
</div>

Selanjutnya, untuk mengakses lebih banyak produk, kita harus menggunakan *button* '__berikutnya__'.
<div align="center">
  <img src="Data Scraping/screenshot/ss_process_produk.png" width="600"/>
</div>

untuk data promo, setelah kita *click* promo tersebut, maka harus melakukan langkah yang sama dengan *scrapping* data produk __(3 kali *click*)__.
<div align="center">
  <img src="Data Scraping/screenshot/ss_scraping_potongan_info.png" width="600"/>
</div>

`Preprocessing Data`

Selanjutnya, data yang didapatkan harus dibersihkan agar bisa meng-ekstrak informasi yang dibutuhkan, seperti harga dalam bentuk integer, nama produk, perusahaan, dan kategori produk
<div align="center">
  <img src="Data Scraping/screenshot/ss_data_preprocessing.png" width="600"/>
</div>

`Schema Tuning - Vertical Splitting`

Di *website* Borma terdapat produk yang memiliki diskon dan yang tidak memiliki diskon. Pengguna diasumsikan lebih sering mengakses diskon dengan produk sehingga tidak perlu menyimpan data yang jarang diakses dan untuk meminimalisir *null value* pada atribut __harga_disc__ di tabel __produk__.

Selain itu, di *website* Borma juga terdapat 2 jenis diskon, yaitu normal diskon yang bisa digunakan pada seluruh pembelian dan potongan diskon yang hanya bisa digunakan untuk produk tertentu. Karena normal diskon memiliki lebih banyak atribut daripada potonagn diskon, maka dengan alasan yang sama dengan sebelumnya kedua jenis diskon ini dipisah pada 2 tabel yang berbeda yaitu __potongan_prom__ dan __normal_prom__.
<div align="center">
  <img src="Data Scraping/screenshot/ss_scraping_promo_normal.png" width="600"/>
</div>

`Cleaning Redundancy Tuple`

Ada beberapa produk yang berulang pada data yang saya *scrapping* oleh karena itu saya membersihkannya dengan 2 cara,
1. membersihkan *redudancy* di tabel yang sama
<div align="center">
  <img src="Data Scraping/screenshot/ss_data_cleaning_1.png" width="600"/>
</div>

2. Memastikan foreign key constraint antara __diskon_prod__ dengan __prod__
<div align="center">
  <img src="Data Scraping/screenshot/ss_data_cleaning_2.png" width="600"/>
</div>

### Data Storing

Pada database borma_dago, saya melakukan *create table* dengan menggunakan psycopg2 sebagai berikut
<div align="center">
  <img src="Data Scraping/screenshot/ss_create_table.png" width="600"/>
</div>

informasi produk diskon didapatkan melalui halaman promo. Ketika proses *scrapping*, informasi produk tersebut justru terdapat di file __potongan_promo.json__ padahal seharusnya ada di __produk.json__. Cara saya menyiasatinya adalah ketika melalukan *eksport* ke __SQL__ saya memasukkan beberapa atribut pada dari __potongan_promo.json__ ke __produk.json__
<div align="center">
  <img src="Data Scraping/screenshot/ss_storing.png" width="600"/>
</div>

## Data Visualization (BONUS)

Setelah berhasil mengumpulkan data melalui web scraping, langkah selanjutnya adalah menyajikan informasi tersebut dalam bentuk yang mudah dipahami melalui visualisasi data. Visualisasi data memungkinkan kita untuk mengidentifikasi pola, membandingkan berbagai kategori, dan menyederhanakan data kompleks sehingga lebih mudah dipahami. 

Berikut adalah hasil visualisasi yang didapatkan untuk memenuhi tujuan awal *scraping* website ini yaitu untuk membandingkan hubungan antara promo yang ditawarkan dengan jumlah penjualan produk.
<div align="center">
  <img src="Data Visualization/Visualization/1.png" width="800"/>
</div>

Data yang ada juga memberikan kesimpulan perusahaan mana saja yang paling banyak memberikan diskon, produk paling variatif, dan penjualan produk yang paling tinggi.

<div align="center">
  <img src="Data Visualization/Visualization/2.png" width="800"/>
</div>


## Reference
1. [Borma Dago Website](https://www.bormadago.com/)
2. [Dokumentasi Selenium](https://selenium-python.readthedocs.io/)
3. [Dokumentasi Beautifulsoup4](https://beautiful-soup-4.readthedocs.io/)
4. [Dokumentasi psycopg2](https://pypi.org/project/psycopg2/)
5. [Dokumentasi PostgreSQL](https://www.postgresql.org/)

## Author
Kevin Azra - 18223029
