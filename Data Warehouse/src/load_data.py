import mysql.connector
from mysql.connector import Error
from datetime import datetime

def connect_to_operational_db():
    """Create a connection to the operational database (source)"""
    try:
        connection = mysql.connector.connect(
            host='localhost',
            database='books_db',  # Your original database
            user='root',
            password='',
            port=1234
        )
        print("Successfully connected to Operational DB (books_db)")
        return connection
    except Error as e:
        print(f"Error connecting to Operational DB: {e}")
        return None

def connect_to_data_warehouse():
    """Create a connection to the data warehouse database (destination)"""
    try:
        connection = mysql.connector.connect(
            host='localhost',
            database='books_dw',  # Your new data warehouse DB
            user='root',
            password='',
            port=1234
        )
        print("Successfully connected to Data Warehouse DB (books_dw)")
        return connection
    except Error as e:
        print(f"Error connecting to Data Warehouse DB: {e}")
        return None

def extract_from_op_db(op_conn):
    """Extracts all necessary data from the operational database."""
    op_cursor = op_conn.cursor(dictionary=True)
    print("\nExtracting data from operational database...")
    
    op_cursor.execute("""
        SELECT b.book_id, b.rank, b.title, b.year, b.pages, b.avg_rating,
               a.author_name, c.country_name, t.type_name, l.length_name
        FROM Book b
        JOIN Author a ON b.author_id = a.author_id
        JOIN Country c ON b.country_id = c.country_id
        LEFT JOIN Type t ON b.type_id = t.type_id
        LEFT JOIN Length l ON b.length_id = l.length_id
    """)
    books_data = op_cursor.fetchall()

    op_cursor.execute("SELECT bl.book_id, l.language_name FROM BookLanguages bl JOIN Language l ON bl.language_id = l.language_id")
    languages_rel = op_cursor.fetchall()
    
    op_cursor.execute("SELECT bg.book_id, g.genre_name FROM BookGenres bg JOIN Genre g ON bg.genre_id = g.genre_id")
    genres_rel = op_cursor.fetchall()
    
    op_cursor.execute("SELECT bs.book_id, s.subject_name FROM BookSubjects bs JOIN Subject s ON bs.subject_id = s.subject_id")
    subjects_rel = op_cursor.fetchall()
    
    op_cursor.close()
    print("Extraction complete.")
    return books_data, languages_rel, genres_rel, subjects_rel

def transform_data(books_data, languages_rel, genres_rel, subjects_rel, existing_dims):
    """Transforms raw data into dimension and fact table records."""
    print("\nTransforming data for data warehouse...")

    # Create maps for many-to-many relationships (taking the first one found)
    book_to_language = {row['book_id']: row['language_name'] for row in reversed(languages_rel)}
    book_to_genre = {row['book_id']: row['genre_name'] for row in reversed(genres_rel)}
    book_to_subject = {row['book_id']: row['subject_name'] for row in reversed(subjects_rel)}
    
    # Prepare Dimension Data
    new_dims = {name: set() for name in existing_dims.keys()}
    
    for book in books_data:
        if book['author_name'] and book['author_name'] not in existing_dims['author']: 
            new_dims['author'].add(book['author_name'])
        if book['country_name'] and book['country_name'] not in existing_dims['country']: 
            new_dims['country'].add(book['country_name'])
        if book['type_name'] and book['type_name'] not in existing_dims['type']: 
            new_dims['type'].add(book['type_name'])
        if book['length_name'] and book['length_name'] not in existing_dims['length']: 
            new_dims['length'].add(book['length_name'])
        
        lang = book_to_language.get(book['book_id'])
        if lang and lang not in existing_dims['language']: 
            new_dims['language'].add(lang)
        
        genre = book_to_genre.get(book['book_id'])
        if genre and genre not in existing_dims['genre']: 
            new_dims['genre'].add(genre)
        
        subject = book_to_subject.get(book['book_id'])
        if subject and subject not in existing_dims['subject']: 
            new_dims['subject'].add(subject)

    # Prepare Fact Table Data
    # Combine existing and new dimension maps for lookup
    full_dim_maps = {}
    for name, existing_map in existing_dims.items():
        max_key = max(existing_map.values()) if existing_map else 0
        new_map = {val: i + max_key + 1 for i, val in enumerate(sorted(new_dims[name]))}
        full_dim_maps[name] = {**existing_map, **new_map}

    # Prepare Date and Book dimension data
    today = datetime.now()
    date_id = int(today.strftime('%Y%m%d'))
    dim_date_data = [(date_id, today.month, today.year)]
    dim_book_data = [(book['book_id'], book['title'], book['year'], book.get('pages', '')) for book in books_data]

    fact_book_records = []
    for book in books_data:
        record = (
            book['book_id'],
            book['rank'], 
            book.get('avg_rating', 0.0),
            full_dim_maps['author'].get(book['author_name']),
            full_dim_maps['country'].get(book['country_name']),
            full_dim_maps['type'].get(book['type_name']),
            full_dim_maps['length'].get(book['length_name']),
            full_dim_maps['language'].get(book_to_language.get(book['book_id'])),
            full_dim_maps['genre'].get(book_to_genre.get(book['book_id'])),
            full_dim_maps['subject'].get(book_to_subject.get(book['book_id'])),
            date_id
        )
        fact_book_records.append(record)

    print("Transformation complete.")
    return new_dims, dim_date_data, dim_book_data, fact_book_records

def load_into_dw(dw_conn, new_dims, dim_date_data, dim_book_data, fact_book_records):
    """Loads transformed data into the data warehouse, handling duplicates."""
    dw_cursor = dw_conn.cursor()
    print("\nLoading data into data warehouse...")
    
    try:
        # Load only new dimension values
        for dim_name, new_values in new_dims.items():
            if new_values:
                records_to_insert = [(name,) for name in new_values]
                query = f"INSERT INTO dim_{dim_name} ({dim_name}_name) VALUES (%s)"
                dw_cursor.executemany(query, records_to_insert)
                print(f"Inserted {len(records_to_insert)} new records into dim_{dim_name}.")

        # Upsert Date and Book dimensions
        date_key = dim_date_data[0][0]
        dw_cursor.execute("INSERT INTO dim_date (date_id, month, year) VALUES (%s, %s, %s) ON DUPLICATE KEY UPDATE month=VALUES(month), year=VALUES(year)", dim_date_data[0])
        dw_cursor.executemany("INSERT INTO dim_book (book_id, title, year, pages) VALUES (%s, %s, %s, %s) ON DUPLICATE KEY UPDATE title=VALUES(title), year=VALUES(year), pages=VALUES(pages)", dim_book_data)

        # Clear out facts for today's snapshot only before inserting the new ones
        # Use fact_top_books to match schema
        dw_cursor.execute("DELETE FROM fact_top_books WHERE date_id = %s", (date_key,))
        
        # Load Fact table
        insert_fact_query = """
            INSERT INTO fact_top_books (book_id, rank, avg_rating, author_id, country_id, type_id, length_id, language_id, genre_id, subject_id, date_id)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """
        dw_cursor.executemany(insert_fact_query, fact_book_records)
        print(f"Fact table loaded with {len(fact_book_records)} records for date {date_key}.")
        
        dw_conn.commit()
        print("\nETL process completed successfully!")
    except Error as e:
        print(f"Error during load operation: {e}")
        dw_conn.rollback()
        raise
    finally:
        dw_cursor.close()

def get_existing_dims(dw_cursor):
    """Fetches existing dimension values from the DW to prevent duplicates."""
    dims = {}
    dim_tables = ['author', 'country', 'type', 'length', 'language', 'genre', 'subject']
    for table_name in dim_tables:
        dw_cursor.execute(f"SELECT {table_name}_id, {table_name}_name FROM dim_{table_name}")
        dims[table_name] = {row[f'{table_name}_name']: row[f'{table_name}_id'] for row in dw_cursor.fetchall()}
    return dims

def main():
    op_conn = connect_to_operational_db()
    dw_conn = connect_to_data_warehouse()
    if not op_conn or not dw_conn:
        return

    try:
        # Get existing dimension data from DW to avoid duplicates
        dw_cursor = dw_conn.cursor(dictionary=True)
        existing_dims = get_existing_dims(dw_cursor)
        dw_cursor.close()
        
        # EXTRACT
        books_data, languages_rel, genres_rel, subjects_rel = extract_from_op_db(op_conn)
        
        # TRANSFORM
        new_dims, dim_date, dim_book, facts = transform_data(books_data, languages_rel, genres_rel, subjects_rel, existing_dims)
        
        # LOAD
        load_into_dw(dw_conn, new_dims, dim_date, dim_book, facts)

    except Error as e:
        print(f"A critical error occurred: {e}")
    finally:
        if op_conn and op_conn.is_connected():
            op_conn.close()
            print("\nOperational DB connection closed.")
        if dw_conn and dw_conn.is_connected():
            dw_conn.close()
            print("Data Warehouse connection closed.")

if __name__ == "__main__":
    main()