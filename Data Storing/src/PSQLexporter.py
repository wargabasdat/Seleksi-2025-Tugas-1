import json
import os

def clean_data(data, is_json=False):

    if data is None:
        return '"null"' if is_json else 'NULL'
    elif isinstance(data, str):
        cleaned_text = data.encode("utf-8", "ignore").decode("utf-8")
        return f"'{cleaned_text.replace("'", "''")}'"
    elif isinstance(data, list):
        json_string = json.dumps(data, ensure_ascii=False)
        cleaned_json = json_string.encode("utf-8", "ignore").decode("utf-8")
        return f"'{cleaned_json.replace("'", "''")}'"
    else:
        return str(data)

def main():
    DATA_DIR = os.path.join(os.pardir, os.pardir, 'Data Scraping', 'data')

    required_files = {
        "companies_data.json": os.path.join(DATA_DIR, "companies_data.json"),
        "new_authors_data.json": os.path.join(DATA_DIR, "new_authors_data.json"),
        "manhwa_data.json": os.path.join(DATA_DIR, "manhwa_data.json"),
        "genres_data.json": os.path.join(DATA_DIR, "genres_data.json"),
        "characters_data.json": os.path.join(DATA_DIR, "characters_data.json")
    }

    loaded_data = {}
    try:
        for name, path in required_files.items():
            if not os.path.exists(path):
                print(f"ERROR: File tidak ditemukan: {path}. Mohon periksa kembali jalur file Anda. Pastikan skrip ini dijalankan dari folder 'src'.")
                return
            with open(path, 'r', encoding='utf-8') as f:
                loaded_data[name] = json.load(f)
    except Exception as e:
        print(f"ERROR saat memuat file JSON: {e}")
        return

    table_definitions = {
        "Company": {
            "columns": {"id_company": "SERIAL PRIMARY KEY", "company_name": "VARCHAR(255)"},
            "file_key": "companies_data.json"
        },
        "Author": {
            "columns": {"id_author": "SERIAL PRIMARY KEY", "given_name": "VARCHAR(255)", "family_name": "VARCHAR(255)", "birthday": "VARCHAR(255)", "website": "VARCHAR(255)", "member_favorites": "INT", "published_manga": "JSON", "id_company": "INT", "id_mentor": "INT"},
            "file_key": "new_authors_data.json"
        },
        "Illustrator": {
            "columns": {"id_author": "INT PRIMARY KEY", "art_style": "VARCHAR(255)", "software_tools": "VARCHAR(255)", "portfolio_url": "VARCHAR(255)"},
            "file_key": None
        },
        "Writer": {
            "columns": {"id_author": "INT PRIMARY KEY", "writing_style": "VARCHAR(255)", "dominant_genre": "VARCHAR(255)"},
            "file_key": None
        },
        "Author_Phone": {
            "columns": {"id_author": "INT", "phone_number": "VARCHAR(255) PRIMARY KEY"},
            "file_key": None
        },
        "Manhwa": {
            "columns": {"id_manhwa": "SERIAL PRIMARY KEY", "title": "VARCHAR(255)", "status": "VARCHAR(255)", "serialization": "JSON", "themes": "JSON", "id_company": "INT"},
            "file_key": "manhwa_data.json"
        },
        "Genre": {
            "columns": {"id_genre": "SERIAL PRIMARY KEY", "genre_name": "VARCHAR(255)", "description": "TEXT"},
            "file_key": "genres_data.json"
        },
        "User": {
            "columns": {"id_user": "SERIAL PRIMARY KEY", "username": "VARCHAR(255)", "email": "VARCHAR(255)", "gender": "VARCHAR(255)", "birthday": "VARCHAR(255)"},
            "file_key": None
        },
        "Character": {
            "columns": {"id_character": "SERIAL PRIMARY KEY", "character_name": "VARCHAR(255)", "role": "VARCHAR(255)", "mangaography": "JSON", "member_favorites": "INT", "description": "TEXT"},
            "file_key": "characters_data.json"
        },
        "Episode": {
            "columns": {"id_episode": "SERIAL PRIMARY KEY", "id_manhwa": "INT", "no_episode": "INT", "title_episode": "VARCHAR(255)", "release_date": "VARCHAR(255)"},
            "file_key": None
        },
        "Menulis": {
            "columns": {"id_manhwa": "INT", "id_author": "INT"},
            "file_key": None
        },
        "Kategori": {
            "columns": {"id_manhwa": "INT", "id_genre": "INT"},
            "file_key": None
        },
        "Peran": {
            "columns": {"id_manhwa": "INT", "id_character": "INT"},
            "file_key": None
        },
        "Rating": {
            "columns": {"id_user": "INT", "id_manhwa": "INT", "rating": "DECIMAL(3, 2)", "date_rating": "VARCHAR(255)"},
            "file_key": None
        }
    }
    
    sql_output = []
    
    sql_output.append("-- Menonaktifkan pemeriksaan kunci asing untuk mencegah kesalahan penyisipan karena ketergantungan")
    sql_output.append("SET session_replication_role = 'replica';")
    sql_output.append("\n-- Hapus tabel yang ada untuk memastikan dasar yang bersih")
    for table_name in reversed(table_definitions.keys()):
        sql_output.append(f"DROP TABLE IF EXISTS \"{table_name}\" CASCADE;")
    sql_output.append("\n-- Buat tabel\n")

    for table_name, definition in table_definitions.items():
        columns = ", ".join([f"\"{col}\" {col_type}" for col, col_type in definition["columns"].items()])
        sql_output.append(f"CREATE TABLE \"{table_name}\" ({columns});")

    companies_data = loaded_data["companies_data.json"]
    authors_data = loaded_data["new_authors_data.json"]
    manhwa_data = loaded_data["manhwa_data.json"]
    characters_data = loaded_data["characters_data.json"]
    genres_data = loaded_data["genres_data.json"]
    
    company_name_to_id = {c["Company Name"]: i + 1 for i, c in enumerate(companies_data)}
    author_name_to_id = {a['Given Name']: i + 1 for i, a in enumerate(authors_data)}
    manhwa_title_to_id = {m['Title']: i + 1 for i, m in enumerate(manhwa_data)}
    character_name_to_id = {c['Character Name']: i + 1 for i, c in enumerate(characters_data) if c.get('Character Name')}
    genre_name_to_id = {g['Genre Name']: i + 1 for i, g in enumerate(genres_data) if g.get('Genre Name')}

    for table_name in ["Company", "Author", "Manhwa", "Genre", "Character"]:
        definition = table_definitions[table_name]
        sql_output.append(f"\n-- Data untuk tabel {table_name} --\n")
        
        if definition["file_key"]:
            data = loaded_data[definition["file_key"]]
            values_list_batch = []
            
            insert_columns = []
            
            for i, item in enumerate(data, 1):
                insert_values = []

                if table_name == "Company":
                    insert_values.append(i) # id_company
                    insert_values.append(item.get("Company Name"))
                    insert_columns = ["\"id_company\"", "\"company_name\""]
                
                elif table_name == "Author":
                    insert_values.append(i) # id_author
                    insert_values.append(item.get("Given Name"))
                    insert_values.append(item.get("Family Name"))
                    insert_values.append(item.get("Birthday"))
                    insert_values.append(item.get("Website"))
                    insert_values.append(item.get("Member Favorites"))
                    insert_values.append(item.get("Published Manga"))
                    insert_values.append(None) # id_company
                    insert_values.append(None) # id_mentor
                    insert_columns = ["\"id_author\"", "\"given_name\"", "\"family_name\"", "\"birthday\"", "\"website\"", "\"member_favorites\"", "\"published_manga\"", "\"id_company\"", "\"id_mentor\""]
                
                elif table_name == "Manhwa":
                    serialization_list = item.get("Serialization", [])
                    id_company = None
                    if serialization_list and isinstance(serialization_list, list) and serialization_list[0] in company_name_to_id:
                        id_company = company_name_to_id[serialization_list[0]]
                    
                    insert_values.append(i) # id_manhwa
                    insert_values.append(item.get("Title"))
                    insert_values.append(item.get("Status"))
                    insert_values.append(item.get("Serialization"))
                    insert_values.append(item.get("Themes"))
                    insert_values.append(id_company)
                    insert_columns = ["\"id_manhwa\"", "\"title\"", "\"status\"", "\"serialization\"", "\"themes\"", "\"id_company\""]
                    
                elif table_name == "Genre":
                    insert_values.append(i) # id_genre
                    insert_values.append(item.get("Genre Name"))
                    insert_values.append(item.get("Description"))
                    insert_columns = ["\"id_genre\"", "\"genre_name\"", "\"description\""]

                elif table_name == "Character":
                    insert_values.append(i) # id_character
                    insert_values.append(item.get("Character Name"))
                    insert_values.append(item.get("Role"))
                    insert_values.append(item.get("Mangaography"))
                    insert_values.append(item.get("Member Favorites"))
                    insert_values.append(item.get("Description"))
                    insert_columns = ["\"id_character\"", "\"character_name\"", "\"role\"", "\"mangaography\"", "\"member_favorites\"", "\"description\""]
                
                values_tuple = ", ".join([clean_data(v) for v in insert_values])
                values_list_batch.append(f"({values_tuple})")

            if values_list_batch:
                overriding = " OVERRIDING SYSTEM VALUE"
                if table_name in ["Company", "Author", "Manhwa", "Genre", "Character"]:
                     sql = f"INSERT INTO \"{table_name}\" ({', '.join(insert_columns)}){overriding} VALUES\n" + ",\n".join(values_list_batch) + ";"
                else:
                     sql = f"INSERT INTO \"{table_name}\" ({', '.join(insert_columns)}) VALUES\n" + ",\n".join(values_list_batch) + ";"
                sql_output.append(sql)

    sql_output.append("\n-- Data untuk tabel penghubung --\n")
    
    sql_output.append("\n-- Data untuk tabel Menulis --\n")
    menulis_values = []
    for manhwa_id, manhwa in enumerate(manhwa_data, 1):
        for author_name in manhwa.get("Authors", []):
            author_id = author_name_to_id.get(author_name)
            if author_id:
                menulis_values.append(f"({manhwa_id}, {author_id})")
    
    if menulis_values:
        sql_output.append(f"INSERT INTO \"Menulis\" (\"id_manhwa\", \"id_author\") VALUES\n" + ",\n".join(menulis_values) + ";")

    sql_output.append("\n-- Data untuk tabel Kategori --\n")
    kategori_values = []
    for manhwa_id, manhwa in enumerate(manhwa_data, 1):
        for genre_name in manhwa.get("Genres", []):
            genre_id = genre_name_to_id.get(genre_name)
            if genre_id:
                kategori_values.append(f"({manhwa_id}, {genre_id})")
    
    if kategori_values:
        sql_output.append(f"INSERT INTO \"Kategori\" (\"id_manhwa\", \"id_genre\") VALUES\n" + ",\n".join(kategori_values) + ";")

    sql_output.append("\n-- Data untuk tabel Peran --\n")
    peran_values = []
    for char_id, character in enumerate(characters_data, 1):
        mangaography_list = character.get("Mangaography")
        if isinstance(mangaography_list, list):
            for manhwa_title in mangaography_list:
                manhwa_id = manhwa_title_to_id.get(manhwa_title)
                if manhwa_id:
                    peran_values.append(f"({manhwa_id}, {char_id})")
    
    if peran_values:
        sql_output.append(f"INSERT INTO \"Peran\" (\"id_manhwa\", \"id_character\") VALUES\n" + ",\n".join(peran_values) + ";")
    
    sql_output.append("\n-- Tambahkan batasan kunci asing --\n")
    sql_output.append("ALTER TABLE \"Author\" ADD FOREIGN KEY (\"id_company\") REFERENCES \"Company\" (\"id_company\");")
    sql_output.append("ALTER TABLE \"Author\" ADD FOREIGN KEY (\"id_mentor\") REFERENCES \"Author\" (\"id_author\");")
    sql_output.append("ALTER TABLE \"Illustrator\" ADD FOREIGN KEY (\"id_author\") REFERENCES \"Author\" (\"id_author\");")
    sql_output.append("ALTER TABLE \"Writer\" ADD FOREIGN KEY (\"id_author\") REFERENCES \"Author\" (\"id_author\");")
    sql_output.append("ALTER TABLE \"Author_Phone\" ADD FOREIGN KEY (\"id_author\") REFERENCES \"Author\" (\"id_author\");")
    sql_output.append("ALTER TABLE \"Manhwa\" ADD FOREIGN KEY (\"id_company\") REFERENCES \"Company\" (\"id_company\");")
    sql_output.append("ALTER TABLE \"Episode\" ADD FOREIGN KEY (\"id_manhwa\") REFERENCES \"Manhwa\" (\"id_manhwa\");")
    sql_output.append("ALTER TABLE \"Menulis\" ADD FOREIGN KEY (\"id_manhwa\") REFERENCES \"Manhwa\" (\"id_manhwa\");")
    sql_output.append("ALTER TABLE \"Menulis\" ADD FOREIGN KEY (\"id_author\") REFERENCES \"Author\" (\"id_author\");")
    sql_output.append("ALTER TABLE \"Kategori\" ADD FOREIGN KEY (\"id_manhwa\") REFERENCES \"Manhwa\" (\"id_manhwa\");")
    sql_output.append("ALTER TABLE \"Kategori\" ADD FOREIGN KEY (\"id_genre\") REFERENCES \"Genre\" (\"id_genre\");")
    sql_output.append("ALTER TABLE \"Peran\" ADD FOREIGN KEY (\"id_manhwa\") REFERENCES \"Manhwa\" (\"id_manhwa\");")
    sql_output.append("ALTER TABLE \"Peran\" ADD FOREIGN KEY (\"id_character\") REFERENCES \"Character\" (\"id_character\");")
    sql_output.append("ALTER TABLE \"Rating\" ADD FOREIGN KEY (\"id_user\") REFERENCES \"User\" (\"id_user\");")
    sql_output.append("ALTER TABLE \"Rating\" ADD FOREIGN KEY (\"id_manhwa\") REFERENCES \"Manhwa\" (\"id_manhwa\");")

    sql_output.append("\n-- Mengaktifkan kembali pemeriksaan kunci asing --")
    sql_output.append("SET session_replication_role = 'origin';")
    
    output_path = os.path.join(os.pardir, 'manhwalast.sql')
    with open(output_path, 'w', encoding='utf-8') as f:
        f.write("\n".join(sql_output))

    print(f"File SQL PostgreSQL 'manhwalast.sql' berhasil dibuat di: {output_path}")

if __name__ == "__main__":
    main()
