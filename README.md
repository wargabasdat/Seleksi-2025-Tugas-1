# Seleksi 1 Lab. Basis Data 2025
![Web Page](Manga%20Villain%20Wiki.png)

## Author
Nama: Rasyid Rizky Susilo Nurdwiputro
<br>
NIM: 18223114
<br>
Email: 18223114@std.stei.itb.ac.id

## Deskripsi Data dan Sistem Manajemen Basis Data (DBMS)
PostgreSQL dipilih sebagai sistem manajemen basis data (DBMS) untuk menyimpan dan mengelola data manga villain yang dikumpulkan dalam penugasan ini. PostgreSQL merupakan sistem basis data relasional yang bersifat open-source, memiliki tingkat keandalan tinggi, serta dilengkapi dengan berbagai fitur canggih yang mendukung kebutuhan pengolahan data secara kompleks.

Sebagai sistem basis data relasional, PostgreSQL menerapkan model relasional dengan data direpresentasikan dalam bentuk tabel dan hubungan antar entitas direpresentasikan melalui penggunaan *foreign keys*. Sistem ini juga mendukung bahasa standar SQL (Structured Query Language) yang memungkinkan proses pengambilan, manipulasi, dan pengelolaan data dilakukan secara efisien dan konsisten.

Pemilihan PostgreSQL dianggap tepat untuk mendukung kebutuhan tugas ini, mengingat kemampuannya dalam menangani struktur data yang kompleks, skalabilitas yang baik, serta kestabilannya dalam lingkungan operasional yang intensif. PostgreSQL memberikan landasan yang kuat untuk penyimpanan dan pengambilan data terstruktur, seperti informasi mengenai nama, *skill*, dan kejahatan yang dilakukan, sehingga mempermudah proses analisis dan manajemen data yang diperlukan.

Pemilihan Halaman Manga Villains pada situs Villains Wiki sebagai sumber utama untuk proses data scraping karena menyediakan kumpulan karakter antagonis dari berbagai judul manga yang disusun secara sistematis dalam satu kategori berbasis abjad. Struktur navigasi alfabetis yang konsisten memudahkan akses ke setiap entri karakter serta memungkinkan ekstraksi data seperti nama, asal, dan atribut lainnya secara efisien, dengan risiko duplikasi data yang minimal. Selain itu, organisasi konten yang tertata rapi mendukung proses klasifikasi karakter berdasarkan jenis villain, seperti individu, keluarga, organisasi, atau spesies. Dengan cakupan yang luas dan penyajian yang terstruktur, halaman ini merupakan sumber yang tepat untuk membangun dataset karakter antagonis yang komprehensif dan terorganisasi untuk keperluan analisis lebih lanjut.

## Spesifikasi Program
Program ini bertujuan untuk mengumpulkan data dari situs Villains Wiki, dengan fokus khusus pada entitas antagonis dalam manga, seperti individu penjahat, organisasi jahat, keluarga antagonis, serta spesies musuh. Perancangan program mempertimbangkan prinsip pengambilan data yang etis, di antaranya dengan menerapkan jeda antar permintaan guna meminimalkan beban pada server dan memastikan keberlangsungan akses yang bertanggung jawab. Data yang dikumpulkan ditujukan untuk keperluan tugas dan analitis, dengan orientasi pada pembangunan dataset komprehensif yang dapat disimpan dan diproses dalam sistem basis data relasional. Dengan demikian, program ini mendukung berbagai bentuk analisis lanjutan, termasuk studi karakter dan analisis struktur naratif.

Program ini disusun secara modular, dengan setiap modul bertanggung jawab untuk menangani pengambilan data dari situs Villains Wiki yang berkaitan dengan berbagai entitas antagonis. Modul seperti **villainService.js** berfungsi untuk mengekstrak daftar karakter berdasarkan inisial nama serta mengambil informasi detail dari halaman individu karakter, termasuk nama, asal, dan atribut tambahan. Informasi tersebut kemudian dikelompokkan ke dalam kategori evil doers (penjahat individu), evil organizations (organisasi jahat), evil families (keluarga antagonis), dan hostile species (spesies musuh).

Skrip utama, **scrap.js**, bertindak sebagai pusat dari keseluruhan proses scraping. Skrip ini mengoordinasikan pemanggilan fungsi-fungsi dari berbagai modul untuk melakukan ekstraksi data secara menyeluruh dan menyimpan hasilnya dalam file JSON yang terstruktur. Program ini mendukung *automated scheduled* melalui integrasi dengan library node-cron yang memungkinkan scraping dilakukan secara periodik berdasarkan konfigurasi pola CRON yang ditentukan dalam berkas **.env**. Selain itu, proses scraping juga dapat dijalankan secara manual, bergantung pada nilai konfigurasi **AUTO_SCHEDULE**.

Untuk memastikan praktik pengambilan data yang etis dan tidak membebani server sumber, program ini menyisipkan jeda eksplisit antara setiap permintaan HTTP. Selain itu, skrip juga mengelola hasil ekstraksi dengan menyalin data lama ke direktori cadangan sebelum menyimpan data terbaru untuk menjaga keteraturan struktur data. Pendekatan ini secara keseluruhan memungkinkan pengumpulan data yang sistematis, bertanggung jawab, dan dapat digunakan untuk kepentingan analisis lanjutan.

Data hasil ekstraksi disimpan dalam format JavaScript Object Notation (JSON), yang memudahkan pemrosesan dan analisis lebih lanjut. Setiap kategori villain disimpan dalam berkas JSON yang berbeda sesuai klasifikasinya, yakni **evil_doers.json** untuk penjahat individu, **evil_organizations.json** untuk organisasi jahat, **evil_families.json** untuk keluarga penjahat, dan **hostile_species.json** untuk spesies musuh.

Untuk meningkatkan keandalan, sistem ini telah dilengkapi dengan penanganan kesalahan tertentu. Jika terjadi gangguan selama proses pengambilan atau pemrosesan data, pesan kesalahan akan dicatat ke terminal tanpa menghentikan keseluruhan alur program.

## Cara menggunakan *scraper* dan konversi SQL
**Cara melakukan clone repository:**
1. Buka terminal dan masukkan perintah `git clone https://github.com/rasyidrizky/Seleksi-2025-Tugas-1.git`
2. Navigasi ke direktori hasil clone dengan `cd Seleksi-2025-Tugas-1`

<br>

**Cara menggunakan Scraper & mengonversi JSON menjadi SQL:**
1. Jalankan scraping node dengan masukkan perintah `node "Data Scraping/src/scrap.js"`
2. Konversi file JSON menjadi satu file SQL dengan masukkan perintah `node "Data Storing/src/convertsql.js"`
3. Navigasi ke direktori tempat file SQL dihasilkan dengan menggunakan `cd Data Storing/export`

<br>

**Cara menggunakan file SQL:**
1. Login ke akun PostgreSQL Anda dengan mengetikkan `psql -U <your_user_name>`
2. Buat database bernama “mangaVillain” dengan menjalankan perintah `CREATE DATABASE mangavillain;`
3. Keluar dari PostgreSQL (CTRL+D atau masukkan perintah `\q`), lalu import fike SQL menggunakan `psql -U <your_user_name> -d mangavillain -f .\mangavillain.sql`

## Struktur JSON
**evil_doers**
<br>
![evil_doer JSON Structure](Data%20Scraping/screenshot/evil_doer%20JSON%20Structure.png)

**evil_families**
<br>
![evil_families JSON Structure](Data%20Scraping/screenshot/evil_family%20JSON%20Structure.png)

**evil_organizations**
<br>
![evil_organizations JSON Structure](Data%20Scraping/screenshot/evil_organization%20JSON%20Structure.png)

**hostile_species**
<br>
![hostile_species JSON Structure](Data%20Scraping/screenshot/hostile_species%20JSON%20Structure.png)

<br>

Data yang diperoleh melalui proses scraping disusun dalam format JavaScript Object Notation (JSON) yang terstruktur dan terdokumentasi. Setiap file hasil scraping memuat dua elemen utama, yaitu:
1. `timestamp`, elemen ini menunjukkan waktu pengambilan data dalam format DD/MM/YYYY, HH.MM.SS. Komponen ini berfungsi sebagai penanda temporal untuk mendukung dokumentasi historis dan validasi keterkinian data.

2. `data`, elemen ini merupakan sebuah array yang berisi objek-objek JSON. Setiap objek merepresentasikan satu entitas antagonis, baik berupa **evil_doers**, **evil_organizations**, **evil_families**, maupun **hostile_species**. Objek-objek ini memiliki struktur atribut yang disesuaikan dengan karakteristik masing-masing entitas.

**Atribut Umum**
Setiap entitas pada umumnya memuat atribut-atribut sebagai berikut:
- `name` : Nama utama entitas antagonis.
- `url` : Alamat halaman sumber pada situs Villains Wiki.
- `fullname` : Nama lengkap atau identitas alternatif dari entitas.
- `alias` : Nama samaran atau gelar lain yang dimiliki.
- `origin` : Judul asal manga.

<br>

**Atribut Khusus Berdasarkan Kategori Entitas**
1. Evil-doer
- `occupation` : Pekerjaan atau peran sosial karakter.
- `skills` : Kemampuan atau keterampilan yang dimiliki.
- `goals` : Tujuan tindakan karakter.
- `crimes` : Tindakan kriminal yang tercatat.
- `type_of_villain` : Klasifikasi karakter antagonis.

2. Evil Family
- `home_base_of_operations` : Lokasi pusat aktivitas keluarga.
- `patriarch / matriarch` : Nama kepala keluarga laki-laki dan perempuan.
- `relatives_members` : Daftar anggota keluarga atau hubungan kekerabatan.
- `goals` : Tujuan tindakan keluarga.
- `crimes` : Tindakan kriminal yang tercatat.
- `type_of_villains` : Klasifikasi keluarga antagonis.

3. Evil Organization
- `headquarters` : Lokasi markas atau pusat kendali organisasi.
- `commanders` : Tokoh-tokoh yang memegang posisi kepemimpinan.
- `agents` : Anggota organisasi.
- `skills` : Kemampuan atau keterampilan yang dimiliki.
- `goals` : Tujuan tindakan organisasi.
- `crimes` : Tindakan kriminal yang tercatat.
- `type_of_villains` : Klasifikasi keluarga antagonis.

4. Hostile Species
- `homeworld` : Dunia asal atau habitat utama spesies.
- `abilities` : Kemampuan atau sifat khas biologis kolektif.
- `members` : Variasi, subspesies, atau tokoh representatif.
- `goals` : Tujuan tindakan spesies.
- `crimes` : Tindakan kriminal yang tercatat.
- `type_of_hostile_species` : Klasifikasi spesies antagonis.

Struktur JSON ini dirancang dengan mengedepankan konsistensi, skalabilitas, dan kompatibilitas terhadap sistem basis data relasional. Nilai-nilai yang disusun dalam bentuk array (seperti `skills`, `goals`, `crimes`) memungkinkan analisis berbasis indeks. Selain itu, penggunaan atribut fleksibel seperti `fullname` yang dapat berupa array mencerminkan keragaman representasi identitas dalam sumber data.

## Struktur ERD dan diagram relasional RDBMS
### Entity Relational Diagram
![Entity Relational Diagram](Data%20Storing/design/Entity%20Relationship%20Diagram.png)

### Relational Diagram
![Relational Diagram](Data%20Storing/design/Relational%20Diagram.png)

## Penjelasan Translasi ERD menjadi Diagram Relasional
Proses translasi dari Entity Relationship Diagram (ERD) ke diagram relasional dilakukan dengan mempertimbangkan kompleksitas data dan hubungan antar relasi. Pada tahap ini, setiap entitas dalam ERD seperti `Villain`, `Evil_Doer`, `Evil_Organization`, `Evil_Family`, dan `Hostile_Species` diubah menjadi tabel dalam model relasional. Atribut-atribut multivalue, seperti `crimes`, `powers`, `agents`, dan `members`, yang sebelumnya direpresentasikan sebagai atribut biasa dalam ERD, dipisahkan ke dalam tabel tersendiri agar memenuhi prinsip normalisasi dan untuk menjaga integritas data. Tabel hasil pemetaan atribut multivalue akan menyimpan *primary key* dari entitas yang berisi *multivalued attribute* tersebut, serta atribut itu sendiri. Selain itu, *specialization* yang digunakan dalam ERD direpresentasikan dalam model relasional melalui pembentukan tabel-tabel turunan yang mengacu pada entitas utama `Villain`, dengan menggunakan *foreign key* yang mengacu *primary key*, yaitu `name` pada tabel induk untuk menjaga keterkaitan dan konsistensi data. Dengan demikian, proses translasi ini memungkinkan struktur konseptual dalam ERD untuk diwujudkan dalam bentuk skema basis data relasional yang terstruktur, efisien, dan siap untuk digunakan dalam penyimpanan serta pengolahan data secara sistematis.

## Screenshot
### Manual Scraping
![Manual Scraping](Data%20Scraping/screenshot/manual_scraping.png)

### Auto Scraping
![Auto Scraping](Data%20Scraping/screenshot/auto_scraping.png)

### Move old data
![Move old data](Data%20Scraping/screenshot/move_old_files.png)

### Convert JSON files to an SQL file
![Convert JSON files to an SQL file](Data%20Scraping/screenshot/convert_json_to_sql.png)

### List of relations
![List of relations](Data%20Storing/screenshot/List%20of%20relations.png)

### Relation villain
![Relation villain](Data%20Storing/screenshot/Relation%20villain.png)

### Relation evil_doer
![Relation evil_doer](Data%20Storing/screenshot/Relation%20evil_doer.png)

### Relation evil_family
![Relation evil_family](Data%20Storing/screenshot/Relation%20evil_family.png)

### Relation evil_organization
![Relation evil_organization](Data%20Storing/screenshot/Relation%20evil_organization.png)

### Relation hostile_species
![Relation hostile_species](Data%20Storing/screenshot/Relation%20hostile_species.png)

## Referensi
**Library / Tools:**
* [Node.js's file system (fs)](https://nodejs.org/api/fs.html)
* [Axios](https://axios-http.com/docs/intro)
* [Cheerio](https://cheerio.js.org/)
* [Node Cron](https://www.npmjs.com/package/node-cron)
* [cRonstrue ](https://www.npmjs.com/package/cronstrue)
* [dotenv](https://www.npmjs.com/package/dotenv)

**Website:**
* [Manga Villains Wiki](https://villains.fandom.com/wiki/Category:Manga_Villains)