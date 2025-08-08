import psycopg2

# Koneksi ke PostgreSQL
conn = psycopg2.connect(
    host="localhost",
    database="videogames_db", 
    user="postgres",
    password="1234"  
)

cur = conn.cursor()

# Drop table terlebih dahulu jika sudah ada (sehingga dapat dijalankan ulang saat testing atau dev)
drop_statements = [
    "DROP TABLE IF EXISTS videogame_genre, videogame_platform, cast_credit, director_credit CASCADE;",
    "DROP TABLE IF EXISTS videogame, genre, platform, star, director, country CASCADE;"
]

# Create table statements sesuai dengan diagram relasional
create_statements = [

    # Star
    """
    CREATE TABLE star (
        id SERIAL PRIMARY KEY,
        star_name VARCHAR(255) UNIQUE NOT NULL
    );
    """,

    # Director
    """
    CREATE TABLE director (
        id SERIAL PRIMARY KEY,
        director_name VARCHAR(255) UNIQUE NOT NULL
    );
    """,

    # Country
    """
    CREATE TABLE country (
        id SERIAL PRIMARY KEY,
        country_name VARCHAR(100) UNIQUE NOT NULL
    );
    """,

    # Videogame
    """
    CREATE TABLE videogame (
        id SERIAL PRIMARY KEY,
        title VARCHAR(255) NOT NULL,
        year INT,
        age_rating VARCHAR(20),
        rating FLOAT,
        description TEXT,
        country_id INTEGER REFERENCES country(id),
        extracted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );
    """,

    # Genre
    """
    CREATE TABLE genre (
        id SERIAL PRIMARY KEY,
        genre_name VARCHAR(100) UNIQUE NOT NULL
    );
    """,

    # Platform
    """
    CREATE TABLE platform (
        id SERIAL PRIMARY KEY,
        platform_name VARCHAR(100) UNIQUE NOT NULL
    );
    """,

    # Many-to-many tables
    """
    CREATE TABLE videogame_genre (
        videogame_id INT REFERENCES videogame(id) ON DELETE CASCADE,
        genre_id INT REFERENCES genre(id) ON DELETE CASCADE,
        PRIMARY KEY (videogame_id, genre_id)
    );
    """,

    """
    CREATE TABLE videogame_platform (
        videogame_id INT REFERENCES videogame(id) ON DELETE CASCADE,
        platform_id INT REFERENCES platform(id) ON DELETE CASCADE,
        PRIMARY KEY (videogame_id, platform_id)
    );
    """,

    """
    CREATE TABLE cast_credit (
        videogame_id INT REFERENCES videogame(id) ON DELETE CASCADE,
        star_id INT REFERENCES star(id) ON DELETE CASCADE,
        PRIMARY KEY (videogame_id, star_id)
    );
    """,

    """
    CREATE TABLE director_credit (
        videogame_id INT REFERENCES videogame(id) ON DELETE CASCADE,
        director_id INT REFERENCES director(id) ON DELETE CASCADE,
        PRIMARY KEY (videogame_id, director_id)
    );
    """
]

for query in drop_statements + create_statements:
    cur.execute(query)
    print("Executed:\n", query.strip().split('\n')[0])

# Simpan perubahan dan tutup koneksi
conn.commit()
cur.close()
conn.close()
print("\nSemua tabel sudah berhasil dibuat.")
