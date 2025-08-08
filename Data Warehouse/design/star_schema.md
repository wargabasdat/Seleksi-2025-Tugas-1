# Desain Star Schema untuk Data Warehouse Game PS2

## 1. Tabel Fakta (Fact Table)

Tabel fakta berisi data kuantitatif (measures) yang akan dianalisis.

### `FactGameRank`

Tabel ini menyimpan data peringkat (rank) untuk setiap kombinasi game dan genre. Karena satu game bisa memiliki beberapa genre, satu game bisa muncul beberapa kali di tabel ini, masing-masing dengan `genre_key` yang berbeda.

| Nama Kolom  | Tipe Data | Deskripsi                               |
|-------------|-----------|-----------------------------------------|
| `game_key`  | `INTEGER` | Foreign Key yang merujuk ke `DimGame`.  |
| `genre_key` | `INTEGER` | Foreign Key yang merujuk ke `DimGenre`. |
| `rank`      | `INTEGER` | Ukuran (measure) peringkat dari game.   |

## 2. Tabel Dimensi (Dimension Tables)

Tabel dimensi berisi data deskriptif (atribut) yang memberikan konteks pada tabel fakta.

### `DimGame`

Menyimpan informasi unik untuk setiap game.

| Nama Kolom | Tipe Data     | Deskripsi                           |
|------------|---------------|-------------------------------------|
| `game_key` | `SERIAL`      | Primary Key untuk dimensi game.     |
| `title`    | `VARCHAR(255)`| Judul lengkap dari game.            |

### `DimGenre`

Menyimpan informasi unik untuk setiap genre.

| Nama Kolom   | Tipe Data     | Deskripsi                            |
|--------------|---------------|--------------------------------------|
| `genre_key`  | `SERIAL`      | Primary Key untuk dimensi genre.     |
| `genre_name` | `VARCHAR(100)`| Nama dari genre (misal: "Action", "RPG"). |

## 3. Hubungan Antar Tabel

- Setiap baris di `FactGameRank` terhubung ke satu baris di `DimGame` dan satu baris di `DimGenre`.
- `DimGame` memiliki hubungan **one-to-many** dengan `FactGameRank`.
- `DimGenre` memiliki hubungan **one-to-many** dengan `FactGameRank`.
