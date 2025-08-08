## Rasionalisasi ERD

1. Hubungan users dan user_game_library
   - **Tipe Hubungan**: One-to-Many (1:N)
   - **Rasionalisasi**: Satu pengguna dapat memiliki banyak game dalam perpustakaan mereka, tetapi setiap game hanya dimiliki oleh satu pengguna.

2. Hubungan user_game_library dan games
   - **Tipe Hubungan**: Many-to-One (N:1)
    - **Rasionalisasi**: Banyak entri dalam perpustakaan pengguna dapat merujuk ke satu game yang sama. Ini memungkinkan pengguna untuk memiliki beberapa entri untuk game yang sama (misalnya, jika mereka memiliki versi berbeda).

3. Hubungan games dan game_genres
   - **Tipe Hubungan**: Many-to-Many (N:M)
   - **Rasionalisasi**: Satu game dapat memiliki beberapa genre, dan satu genre dapat mencakup banyak game. Ini memerlukan tabel penghubung `game_genres` untuk mengelola hubungan ini.

4. Hubungan games dan developers
   - **Tipe Hubungan**: Many-to-Many (N:M)
   - **Rasionalisasi**: Satu game dapat memiliki satu developer, dan satu developer dapat memiliki banyak game

5. Hubungan games dan publishers
   - **Tipe Hubungan**: Many-to-Many (N:M)
   - **Rasionalisasi**: Satu game dapat memiliki satu publisher, dan satu publisher dapat memiliki banyak game

6. Hubungan games dan genres
   - **Tipe Hubungan**: Many-to-Many (N:M)
   - **Rasionalisasi**: Satu game dapat memiliki beberapa genre, dan satu genre dapat mencakup banyak game.

7. Hubungan games dan regional_releases
   - **Tipe Hubungan**: Many-to-Ones (N:1)
   - **Rasionalisasi**: Satu game dapat dirilis di beberapa wilayah, tetapi setiap releases_id hanya terkait dengan satu game.

8. regional_releases dan regions
   - **Tipe Hubungan**: Many-to-One (N:1)
   - **Rasionalisasi**: Banyak rilis regional dapat terkait dengan satu wilayah tertentu. Ini memungkinkan kita untuk mengelompokkan rilis berdasarkan wilayah geografis.

