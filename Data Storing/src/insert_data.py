import mysql.connector
import json
import os
from mysql.connector import Error

def create_connection():
    """Create a database connection to MySQL server"""
    try:
        connection = mysql.connector.connect(
            host='localhost',          # Change to your MySQL host
            database='books_db',     # Change to your database name
            user='root',               # Change to your MySQL username
            password='' ,              # Change to your MySQL password
            port = 1234                # Change to your MySQL port if necessary
        )

        if connection.is_connected():
            print("Successfully connected to MySQL database")
            return connection
    except Error as e:
        print(f"Error while connecting to MySQL: {e}")
        return None

def load_json_data(file_path):
    """Load JSON data from file"""
    try:
        with open(file_path, 'r', encoding='utf-8') as file:
            return json.load(file)
    except FileNotFoundError:
        print(f"File not found: {file_path}")
        return None
    except json.JSONDecodeError as e:
        print(f"Error decoding JSON from {file_path}: {e}")
        return None

def insert_authors(cursor, authors_data):
    """Insert authors data into Author table"""
    insert_query = """
    INSERT INTO Author (author_id, author_name)
    VALUES (%s, %s)
    ON DUPLICATE KEY UPDATE author_name = VALUES(author_name)
    """
    
    author_records = [(author['author_id'], author['author_name']) for author in authors_data]
    cursor.executemany(insert_query, author_records)
    print(f"Inserted {cursor.rowcount} authors")

def insert_countries(cursor, countries_data):
    """Insert countries data into Country table"""
    insert_query = """
    INSERT INTO Country (country_id, country_name)
    VALUES (%s, %s)
    ON DUPLICATE KEY UPDATE country_name = VALUES(country_name)
    """
    
    country_records = [(country['country_id'], country['country_name']) for country in countries_data]
    cursor.executemany(insert_query, country_records)
    print(f"Inserted {cursor.rowcount} countries")

def insert_languages(cursor, languages_data):
    """Insert languages data into Language table"""
    insert_query = """
    INSERT INTO Language (language_id, language_name)
    VALUES (%s, %s)
    ON DUPLICATE KEY UPDATE language_name = VALUES(language_name)
    """
    
    language_records = [(lang['language_id'], lang['language_name']) for lang in languages_data]
    cursor.executemany(insert_query, language_records)
    print(f"Inserted {cursor.rowcount} languages")

def insert_types(cursor, types_data):
    """Insert types data into Type table"""
    insert_query = """
    INSERT INTO Type (type_id, type_name)
    VALUES (%s, %s)
    ON DUPLICATE KEY UPDATE type_name = VALUES(type_name)
    """
    
    type_records = [(type_item['type_id'], type_item['type_name']) for type_item in types_data]
    cursor.executemany(insert_query, type_records)
    print(f"Inserted {cursor.rowcount} types")

def insert_lengths(cursor, lengths_data):
    """Insert lengths data into Length table"""
    insert_query = """
    INSERT INTO Length (length_id, length_name)
    VALUES (%s, %s)
    ON DUPLICATE KEY UPDATE length_name = VALUES(length_name)
    """
    
    length_records = [(length['length_id'], length['length_name']) for length in lengths_data]
    cursor.executemany(insert_query, length_records)
    print(f"Inserted {cursor.rowcount} lengths")

def insert_genres(cursor, genres_data):
    """Insert genres data into Genre table"""
    insert_query = """
    INSERT INTO Genre (genre_id, genre_name)
    VALUES (%s, %s)
    ON DUPLICATE KEY UPDATE genre_name = VALUES(genre_name)
    """
    
    genre_records = [(genre['genre_id'], genre['genre_name']) for genre in genres_data]
    cursor.executemany(insert_query, genre_records)
    print(f"Inserted {cursor.rowcount} genres")

def insert_subjects(cursor, subjects_data):
    """Insert subjects data into Subject table"""
    insert_query = """
    INSERT INTO Subject (subject_id, subject_name)
    VALUES (%s, %s)
    ON DUPLICATE KEY UPDATE subject_name = VALUES(subject_name)
    """
    
    subject_records = [(subject['subject_id'], subject['subject_name']) for subject in subjects_data]
    cursor.executemany(insert_query, subject_records)
    print(f"Inserted {cursor.rowcount} subjects")

# def insert_books(cursor, books_data):
#     """Insert books data into Book table"""
#     insert_query = """
#     INSERT INTO Book (book_id, rank, title, year, pages, avg_rating, type_id, length_id, author_id, country_id)
#     VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
#     ON DUPLICATE KEY UPDATE 
#         rank = VALUES(rank),
#         title = VALUES(title),
#         year = VALUES(year),
#         pages = VALUES(pages),
#         avg_rating = VALUES(avg_rating),
#         type_id = VALUES(type_id),
#         length_id = VALUES(length_id),
#         author_id = VALUES(author_id),
#         country_id = VALUES(country_id)
#     """
    
#     book_records = [
#         (
#             book['id'],
#             book['rank'],
#             book['title'],
#             book['year'],
#             book.get('pages'),
#             book.get('avg_rating'),
#             book['type_id'],
#             book['length_id'],
#             book['author_id'],
#             book['country_id'],
#         )
#         for book in books_data
#     ]
#     cursor.executemany(insert_query, book_records)
#     print(f"Inserted {cursor.rowcount} books")

def insert_books_with_procedure(cursor, books_data, book_languages_data, book_genres_data, book_subjects_data):
    """Insert books data using UpsertBook procedure with relationships"""
    
    # Create lookup dictionaries for relationships
    book_languages_map = {}
    for rel in book_languages_data:
        book_id = rel['book_id']
        if book_id not in book_languages_map:
            book_languages_map[book_id] = []
        book_languages_map[book_id].append(rel['language_id'])
    
    book_genres_map = {}
    for rel in book_genres_data:
        book_id = rel['book_id']
        if book_id not in book_genres_map:
            book_genres_map[book_id] = []
        book_genres_map[book_id].append(rel['genre_id'])
    
    book_subjects_map = {}
    for rel in book_subjects_data:
        book_id = rel['book_id']
        if book_id not in book_subjects_map:
            book_subjects_map[book_id] = []
        book_subjects_map[book_id].append(rel['subject_id'])
    
    inserted_count = 0
    
    for book in books_data:
        try:
            book_id = book['id']
            
            # Get relationship IDs for book
            language_ids = book_languages_map.get(book_id, [])
            genre_ids = book_genres_map.get(book_id, [])
            subject_ids = book_subjects_map.get(book_id, [])
            
            # Convert lists to comma-separated strings
            language_ids_str = ','.join(map(str, language_ids)) if language_ids else ''
            genre_ids_str = ','.join(map(str, genre_ids)) if genre_ids else ''
            subject_ids_str = ','.join(map(str, subject_ids)) if subject_ids else ''
            
            # Call the stored procedure
            cursor.callproc('UpsertBook', [
                book['rank'],
                book['title'],
                book['year'],
                book.get('pages', ''),
                book.get('avg_rating', 0.0),
                book.get('type_id'),
                book.get('length_id'),
                book['author_id'],
                book['country_id'],
                language_ids_str,
                genre_ids_str,
                subject_ids_str
            ])
            
            inserted_count += 1
            
        except Exception as e:
            print(f"Error inserting book '{book['title']}': {e}")
            continue
    
    print(f"Inserted {inserted_count} books using UpsertBook procedure")

def insert_book_languages(cursor, book_languages_data):
    """Insert book-language relationships into BookLanguages table"""
    insert_query = """
    INSERT IGNORE INTO BookLanguages (book_id, language_id)
    VALUES (%s, %s)
    """
    
    book_language_records = [(bl['book_id'], bl['language_id']) for bl in book_languages_data]
    cursor.executemany(insert_query, book_language_records)
    print(f"Processed {cursor.rowcount} book-language relationships")

def insert_book_genres(cursor, book_genres_data):
    """Insert book-genre relationships into BookGenres table"""
    insert_query = """
    INSERT IGNORE INTO BookGenres (book_id, genre_id)
    VALUES (%s, %s)
    """
    
    book_genre_records = [(bg['book_id'], bg['genre_id']) for bg in book_genres_data]
    cursor.executemany(insert_query, book_genre_records)
    print(f"Processed {cursor.rowcount} book-genre relationships")

def insert_book_subjects(cursor, book_subjects_data):
    """Insert book-subject relationships into BookSubjects table"""
    insert_query = """
    INSERT IGNORE INTO BookSubjects (book_id, subject_id)
    VALUES (%s, %s)
    """
    
    book_subject_records = [(bs['book_id'], bs['subject_id']) for bs in book_subjects_data]
    cursor.executemany(insert_query, book_subject_records)
    print(f"Processed {cursor.rowcount} book-subject relationships")

def main():
    # Database connection
    connection = create_connection()
    if not connection:
        return
    
    cursor = connection.cursor()
    
    try:
        data_path = "../../Data Scraping/data"
        
        # Load all JSON files
        print("Loading JSON data...")
        authors_data = load_json_data(os.path.join(data_path, "authors.json"))
        countries_data = load_json_data(os.path.join(data_path, "countries.json"))
        languages_data = load_json_data(os.path.join(data_path, "languages.json"))
        types_data = load_json_data(os.path.join(data_path, "types.json"))
        lengths_data = load_json_data(os.path.join(data_path, "lengths.json"))
        genres_data = load_json_data(os.path.join(data_path, "genres.json"))
        subjects_data = load_json_data(os.path.join(data_path, "subjects.json"))
        books_data = load_json_data(os.path.join(data_path, "books.json"))
        book_languages_data = load_json_data(os.path.join(data_path, "book_languages.json"))
        book_genres_data = load_json_data(os.path.join(data_path, "book_genres.json"))
        book_subjects_data = load_json_data(os.path.join(data_path, "book_subjects.json"))
        
        # Insert data in order of dependencies
        print("\nInserting data into database...")
        
        # Insert reference tables (no foreign key dependencies)
        if authors_data:
            insert_authors(cursor, authors_data)
        
        if countries_data:
            insert_countries(cursor, countries_data)
        
        if languages_data:
            insert_languages(cursor, languages_data)
        
        if types_data:
            insert_types(cursor, types_data)
        
        if lengths_data:
            insert_lengths(cursor, lengths_data)
        
        if genres_data:
            insert_genres(cursor, genres_data)
        
        if subjects_data:
            insert_subjects(cursor, subjects_data)
        
        # # Insert books (depends on authors, countries, types, lengths)
        # if books_data:
        #     insert_books(cursor, books_data)
        
        # # Insert relationship tables (depends on books, languages, genres, subjects)
        # if book_languages_data:
        #     insert_book_languages(cursor, book_languages_data)

        # if book_genres_data:
        #     insert_book_genres(cursor, book_genres_data)
        
        # if book_subjects_data:
        #     insert_book_subjects(cursor, book_subjects_data)

        # Insert books using procedure (this will also handle relationships)
        if books_data and book_languages_data and book_genres_data and book_subjects_data:
            insert_books_with_procedure(cursor, books_data, book_languages_data, book_genres_data, book_subjects_data)
            
        connection.commit()
        print("\nAll data inserted successfully!")
        
        # Show statistics
        cursor.execute("SELECT COUNT(*) FROM Book")
        book_count = cursor.fetchone()[0]
        
        cursor.execute("SELECT COUNT(*) FROM Author")
        author_count = cursor.fetchone()[0]
        
        cursor.execute("SELECT COUNT(*) FROM BookLanguages")
        book_languages_count = cursor.fetchone()[0] 
        
        cursor.execute("SELECT COUNT(*) FROM BookGenres")
        book_genres_count = cursor.fetchone()[0]
        
        cursor.execute("SELECT COUNT(*) FROM BookSubjects")
        book_subjects_count = cursor.fetchone()[0]
        
        print(f"\nDatabase Statistics:")
        print(f"- Books: {book_count}")
        print(f"- Authors: {author_count}")
        print(f"- Book-Language relationships: {book_languages_count}")
        print(f"- Book-Genre relationships: {book_genres_count}")
        print(f"- Book-Subject relationships: {book_subjects_count}")
        
    except Error as e:
        print(f"Error during database operation: {e}")
        connection.rollback()
    
    finally:
        cursor.close()
        connection.close()
        print("\nDatabase connection closed.")

if __name__ == "__main__":
    main()
