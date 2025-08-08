# Scraping TV Tropes

## Author
Nama | NIM |
--|--|
Muhammad Faiz Alfikrona | 18223009 |

## Deskripsi Singkat

![TVTropes Logo](https://tvtropes.org/images/logo-white-big.png)

TVTropes adalah sebuah wiki yang mengoleksi tropes dari berbagai tipe media. Trope adalah sebuah alat narasi yang digunakan dalam storytelling sebuah karya kreatif.

Contoh dari trope yang umum dijumpai (dan mungkin baru disadari) adalah [Chekhov's Gun](https://tvtropes.org/pmwiki/pmwiki.php/Main/ChekhovsGun): kecenderungan penulis untuk menyebutkan suatu objek atau detail yang tampaknya tidak penting, tetapi kemudian ternyata memiliki peran krusial di akhir cerita.

Contoh lainnya adalah [Tsundere](https://tvtropes.org/pmwiki/pmwiki.php/Main/Tsundere), di mana karakter awalnya bersikap kasar, sinis, cuek, atau pemarah seiring waktu mulai menunjukkan [sisi lembutnya](https://open.spotify.com/track/2ECbN3xQ7M6B7AI9BhhCy7).

![xkcd comic](https://imgs.xkcd.com/comics/tab_explosion.png)

Saya memilih TVTropes karena data tentang trope-trope di dalamnya merupakan ladang emas, baik untuk hiburan pribadi maupun bagi industri hiburan.

Jika dipadukan dengan data popularitas atau data finansial, informasi dari TVTropes dapat membuka peluang emas untuk menciptakan karya baru yang menggunakan trope-trope populer. Production house dapat memanfaatkan data ini untuk mengurangi risiko dengan mengadopsi trope yang terbukti sukses dan sering digunakan.

### Data dan DBMS

Data yang diambil pada proyek ini adalah data index, series (TV Shows), dan trope yang ada pada tiap series.

## Scraper
### Cara Menggunakan
Cara menggunakan scrapernya adalah dengan menjalankan main.py pada folder `Data Scraping/src/main.py`

Jalankan menggunakan perintah `python3 main.py`

### Hasil Output

Hasil output akan muncul pada folder `Data Scraping/data` berupa NDJSON (Newline delimited JSON) yang dipilih karena dapat digunakan dalam async programming (tidak perlu menunggu semua data muncul, tiap baris merupakan objek tersendiri)

Format file `series.ndjson`:
```
{
  "series_name": str,
  "series_link": str,
  "series_tropes": [
    {
      "trope_name": str,
      "trope_usage": str
    },
  ],
  "series_indexes": [
    {
      "index_name": str,
      "index_link": str}
  ]
}
```

Format file `tropes.ndjson`:
```
{
  "trope_name": str,
  "trope_link": str,
  "trope_description": str
}

```

## Struktur ERD dan Diagram Relasional RDBMS

### Struktur ERD
![Struktur ERD](/Data%20Storing/design/TV%20Tropes%20Series%20ERD%20Diagram.png)

![Struktur Relasional](![Diagram](./Data%20Storing/design/TV%20Tropes%20Series%20Relational%20Diagram.png)
)

## Penjelasan Translasi

Translasi cukup straightforward untuk dilakukan karena semua relationship bernilai many-to-many tanpa syarat khusus.

## Screenshot

1. Hasil
![Table Trope](./Data%20Storing/screenshot/table_trope.png)

2. Program scraping
![Program Scraping](./Data%20Storing/screenshot/program_scraping.png)


## Referensi
### Library yang Digunakan
1. BeautifulSoup
2. Asyncio
3. Typing
4. JSON
5. psycopg2

### Halaman Web yang Di-Scrape
1. [https://tvtropes.org/pmwiki/pagelist_having_pagetype_in_namespace.php?n=Series&t=work](https://tvtropes.org/pmwiki/pagelist_having_pagetype_in_namespace.php?n=Series&t=work).
2. Beberapa dari namespace [Series](https://tvtropes.org/pmwiki/pmwiki.php/Series/).
3. Beberapa dari namespace [Main (untuk Index dan Tropes)](https://tvtropes.org/pmwiki/pmwiki.php/Main/).
4. Beberapa dari namespace yang lain.
