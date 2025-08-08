import json
import os
from datetime import datetime
import psycopg2

path = 'C:/Users/Velicia/OneDrive/Documents/ITB/SeleksiBasdat/TUGAS_SELEKSI_1_18223085/Data Scraping/data'

def join_pathfile(path, file):
    result = os.path.join(path, file)
    return result

def clean_text(text):
    if not isinstance(text, str):
        return text
    
    replacements = {
        ' – ': ' - ', ' –': ' -', '– ': '- ', '–': '-', '—': '-',
        'â€"': '-', 'â€™': "'", 'â€œ': '"', 'â€': '"', 'â€¦': '...',
        'Â': '', 'ΓÇô': '-',
        'ô': 'o', 
        '\u00A0': ' ', '\u2000': ' ', '\u2001': ' ', '\u2002': ' ', 
        '\u2003': ' ', '\u2004': ' ', '\u2005': ' ', '\u2006': ' ',
        '\u2007': ' ', '\u2008': ' ', '\u2009': ' ', '\u200A': ' ',
        '\u202F': ' ', '\u205F': ' ', '\u3000': ' ',
    }
    
    for old, new in replacements.items():
        text = text.replace(old, new)
    
    return text

# 1. books_price
books_price = join_pathfile(path, 'books_price.json')
with open(books_price, 'r') as f:
    books_price_load = json.load(f)

# 2. books
books = join_pathfile(path, 'books.json')
with open(books, 'r') as f:
    books_load = json.load(f)

# 3. coding_class_info
coding_class_info = join_pathfile(path, 'coding_class_info.json')
with open(coding_class_info, 'r') as f:
    coding_class_info_load = json.load(f)

# 4. kiddo_stem_program
kiddo_stem_program = join_pathfile(path, 'kiddo_stem_program.json')
with open(kiddo_stem_program, 'r') as f:
    kiddo_stem_program_load = json.load(f)

# 5. kinder_coding_package
kinder_coding_package = join_pathfile(path, 'kinder_coding_package.json')
with open(kinder_coding_package, 'r') as f:
    kinder_coding_package_load = json.load(f)

# 6. branch
branch = join_pathfile(path, 'branch.json')
with open(branch, 'r') as f:
    branch_load = json.load(f)

# 7. paud_teacher_training
paud_teacher_training = join_pathfile(path, 'paud_teacher_training.json')
with open(paud_teacher_training, 'r') as f:
    paud_teacher_training_load = json.load(f)

# 8. program
program = join_pathfile(path, 'program.json')
with open(program, 'r') as f:
    program_load = json.load(f)

# 9. school_teacher_training
school_teacher_training = join_pathfile(path, 'school_teacher_training.json')
with open(school_teacher_training, 'r') as f:
    school_teacher_training_load = json.load(f)

# 10. thematic_class
thematic_class = join_pathfile(path, 'thematic_class.json')
with open(thematic_class, 'r') as f:
    thematic_class_load = json.load(f)

# 11. webinar
webinar = join_pathfile(path, 'webinar.json')
with open(webinar, 'r') as f:
    webinar_load = json.load(f)

# 12. zone
zone = join_pathfile(path, 'zone.json')
with open(zone, 'r') as f:
    zone_load = json.load(f)

# 13. book_writer
book_writer = join_pathfile(path, 'book_writer.json')
with open(book_writer, 'r') as f:
    book_writer_load = json.load(f)

# connect to database
hostname = 'localhost'
database = 'kodekiddo'
username = 'postgres'
pwd = 'veli14'
port_id = 5432
conn = None
cur = None

conn = psycopg2.connect(
    host = hostname,
    dbname = database,
    user = username,
    password = pwd,
    port = port_id,
)

cur = conn.cursor()

# make tables
schema = '''
    DROP TABLE IF EXISTS branch CASCADE;
    DROP TABLE IF EXISTS student CASCADE;
    DROP TABLE IF EXISTS program CASCADE;
    DROP TABLE IF EXISTS student_program CASCADE;
    DROP TABLE IF EXISTS non_class_program CASCADE;
    DROP TABLE IF EXISTS class_program CASCADE;
    DROP TABLE IF EXISTS books CASCADE;
    DROP TABLE IF EXISTS books_price CASCADE;
    DROP TABLE IF EXISTS zone CASCADE;
    DROP TABLE IF EXISTS book_zone CASCADE;
    DROP TABLE IF EXISTS book_writer CASCADE;
    DROP TABLE IF EXISTS paud_teacher_training CASCADE;
    DROP TABLE IF EXISTS school_teacher_training CASCADE;
    DROP TABLE IF EXISTS program_available_at CASCADE;
    DROP TABLE IF EXISTS kiddo_stem_program CASCADE;
    DROP TABLE IF EXISTS kinder_coding_package CASCADE;
    DROP TABLE IF EXISTS thematic_class CASCADE;
    DROP TABLE IF EXISTS coding_class_info CASCADE;
    DROP TABLE IF EXISTS webinar CASCADE;

    CREATE TABLE IF NOT EXISTS branch(
        branch_name VARCHAR(100) PRIMARY KEY,
        address VARCHAR(300) NOT NULL
    );

    CREATE TABLE IF NOT EXISTS student(
        student_id INT PRIMARY KEY,
        student_name VARCHAR(100) NOT NULL,
        branch_name VARCHAR(100) NOT NULL,
        FOREIGN KEY (branch_name) REFERENCES branch(branch_name)
    );

    CREATE TABLE IF NOT EXISTS program(
        program_id INT PRIMARY KEY,
        program_name VARCHAR(50) NOT NULL
    );

    CREATE TABLE IF NOT EXISTS student_program(
        student_id INT,   
        program_id INT,
        PRIMARY KEY (student_id, program_id),
        FOREIGN KEY (student_id) REFERENCES student(student_id),
        FOREIGN KEY (program_id) REFERENCES program(program_id)        
    );

    CREATE TABLE IF NOT EXISTS non_class_program(
        program_id INT PRIMARY KEY,
        FOREIGN KEY (program_id) REFERENCES program(program_id)    
    );

    CREATE TABLE IF NOT EXISTS class_program(
        program_id INT PRIMARY KEY,
        FOREIGN KEY (program_id) REFERENCES program(program_id)    
    );

    CREATE TABLE IF NOT EXISTS books(
        book_id INT PRIMARY KEY,
        program_id INT NOT NULL,
        title VARCHAR(100) NOT NULL,
        subtitle VARCHAR(200),
        isbn VARCHAR(20) NOT NULL,
        translator VARCHAR(50),
        total_pages INT NOT NULL,
        length DECIMAL(10,2) NOT NULL,
        width DECIMAL(10,2) NOT NULL,
        spine DECIMAL(10,2) NOT NULL,
        FOREIGN KEY (program_id) REFERENCES non_class_program(program_id)
    );

    CREATE TABLE IF NOT EXISTS books_price(
        book_id INT PRIMARY KEY,
        price_zone_1 INT NOT NULL,
        price_zone_2 INT NOT NULL,
        price_zone_3 INT NOT NULL,
        price_zone_4 INT NOT NULL,
        price_zone_5 INT NOT NULL,
        price_zone_6 INT NOT NULL,
        FOREIGN KEY (book_id) REFERENCES books(book_id)
    );

    CREATE TABLE IF NOT EXISTS zone(
        zone_id INT PRIMARY KEY,
        details VARCHAR(1000) NOT NULL 
    );

    CREATE TABLE IF NOT EXISTS book_zone(
        book_id INT,
        zone_id INT,
        PRIMARY KEY (book_id, zone_id),
        FOREIGN KEY (book_id) REFERENCES books(book_id),
        FOREIGN KEY (zone_id) REFERENCES zone(zone_id)
    );

    CREATE TABLE IF NOT EXISTS book_writer(
        book_id INT,
        writer_name VARCHAR(100),
        PRIMARY KEY (book_id, writer_name),
        FOREIGN KEY (book_id) REFERENCES books(book_id)            
    );

    CREATE TABLE IF NOT EXISTS paud_teacher_training(
        training_id VARCHAR(10) PRIMARY KEY,
        program_id INT,
        province VARCHAR(20) NOT NULL,
        city VARCHAR(30) NOT NULL,
        number_of_facilitators INT NOT NULL,
        FOREIGN KEY (program_id) REFERENCES non_class_program(program_id)
    );

    CREATE TABLE IF NOT EXISTS school_teacher_training(
        training_id VARCHAR(10) PRIMARY KEY,
        program_id INT, 
        province VARCHAR(20) NOT NULL,
        city VARCHAR(30) NOT NULL,
        class_name VARCHAR(50) NOT NULL,
        target_audience INT NOT NULL,
        lower_bound_price INT NOT NULL,
        upper_bound_price INT NOT NULL,
        training_branch VARCHAR(100) NOT NULL,
        FOREIGN KEY (program_id) REFERENCES non_class_program(program_id)
    );

    CREATE TABLE IF NOT EXISTS program_available_at(
        program_id INT,
        branch_name VARCHAR(100),
        PRIMARY KEY (program_id, branch_name),
        FOREIGN KEY (program_id) REFERENCES program(program_id),
        FOREIGN KEY (branch_name) REFERENCES branch(branch_name)
    );

    CREATE TABLE IF NOT EXISTS kiddo_stem_program(
        class_name VARCHAR(100) PRIMARY KEY,
        age VARCHAR(20) NOT NULL,
        program_id INT NOT NULL,
        FOREIGN KEY (program_id) REFERENCES class_program(program_id)
    );

    CREATE TABLE IF NOT EXISTS kinder_coding_package(
        package_name VARCHAR(20) PRIMARY KEY,
        membership_length VARCHAR(20) NOT NULL,
        total_session INT NOT NULL,
        discount BOOLEAN NOT NULL,
        program_id INT NOT NULL,
        FOREIGN KEY (program_id) REFERENCES class_program(program_id)
    );

    CREATE TABLE IF NOT EXISTS thematic_class(
        topic VARCHAR(100) PRIMARY KEY,
        topic_description VARCHAR(1000),
        program_id INT NOT NULL,
        FOREIGN KEY (program_id) REFERENCES class_program(program_id)            
    );

    CREATE TABLE IF NOT EXISTS coding_class_info(
        course_name VARCHAR(50) PRIMARY KEY,
        course_materials VARCHAR(1000) NOT NULL,
        course_audience VARCHAR(100) NOT NULL,
        course_duration VARCHAR(100) NOT NULL,
        course_enrollment INT NOT NULL,
        course_tuition INT NOT NULL,
        program_id INT NOT NULL,
        FOREIGN KEY (program_id) REFERENCES class_program(program_id)
    );

    CREATE TABLE IF NOT EXISTS webinar(
        webinar_name VARCHAR(100) PRIMARY KEY,
        webinar_date DATE,
        program_id INT NOT NULL,
        FOREIGN KEY (program_id) REFERENCES class_program(program_id)
    );
'''
cur.execute(schema)
conn.commit()
print("Berhasil create all table")

# insert loaded data to sql
insert_program = 'INSERT INTO program(program_id, program_name) VALUES (%s, %s)'
for i in program_load:
    insert_values = (
        i['program_id'], clean_text(i['program_name'])
    )
    cur.execute(insert_program, insert_values)
print("Berhasil menambahkan data program")

insert_non_class_program = 'INSERT INTO non_class_program(program_id) VALUES (%s)'
for i in range (6,9):
    cur.execute(insert_non_class_program, (i,))
print("Berhasil menambahkan data non_class_program")

insert_class_program = 'INSERT INTO class_program(program_id) VALUES (%s)'
# insert_values = [1, 2, 3, 4, 5]
for i in range (1,6):
    cur.execute(insert_class_program, (i,))
print("Berhasil menambahkan data class_program")

insert_books = 'INSERT INTO books(book_id, program_id, title, subtitle, isbn, translator, total_pages, length, width, spine) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)'
for i in books_load:
    insert_values = (
        i['book_id'], i['program_id'], i['title'],
        clean_text(i['subtitle']), i['isbn'], i.get('translator', ''),
        i['total_pages'], i['length'], i['width'], i['spine']
    )
    cur.execute(insert_books, insert_values)
print("Berhasil menambahkan data books")

insert_books_price = 'INSERT INTO books_price(book_id, price_zone_1, price_zone_2, price_zone_3, price_zone_4, price_zone_5, price_zone_6) VALUES (%s, %s, %s, %s, %s, %s, %s)'
for i in books_price_load:
    insert_values = (
        i['book_id'], i['price_zone_1'],
        i['price_zone_2'], i['price_zone_3'],
        i['price_zone_4'], i['price_zone_5'], i['price_zone_6']
    )
    cur.execute(insert_books_price, insert_values)
print("Berhasil menambahkan data books_price")

insert_zone = 'INSERT INTO zone(zone_id, details) VALUES (%s, %s)'
for i in zone_load:
    insert_values = (
        i['zone_id'], clean_text(i['details'])
    )
    cur.execute(insert_zone, insert_values)
print("Berhasil menambahkan data zone")

insert_book_zone = 'INSERT INTO book_zone(book_id, zone_id) VALUES (%s, %s)'
for i in books_load:
    for j in zone_load:
        insert_values = (
            i['book_id'], j['zone_id']
        )
        cur.execute(insert_book_zone, insert_values)
print("Berhasil menambahkan data book_zone")

insert_book_writer = 'INSERT INTO book_writer(book_id, writer_name) VALUES (%s, %s)'
for i in book_writer_load:
    insert_values = (
        i['book_id'], i['writer_name']
    )
    cur.execute(insert_book_writer, insert_values)
print("Berhasil menambahkan data book_writer")

insert_paud_teacher_training = 'INSERT INTO paud_teacher_training(training_id, program_id, province, city, number_of_facilitators) VALUES (%s, %s, %s, %s, %s)'
for i in paud_teacher_training_load:
    insert_values = (
        i['training_id'], i['program_id'], i['province'],
        i['city'], i['number_of_facilitators']
    )
    cur.execute(insert_paud_teacher_training, insert_values)
print("Berhasil menambahkan data paud_teacher_training")

insert_school_teacher_training = 'INSERT INTO school_teacher_training(training_id, program_id, province, city, class_name, target_audience, lower_bound_price, upper_bound_price, training_branch) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)'    
for i in school_teacher_training_load:
    insert_values = (
        i['training_id'], i['program_id'], i['province'],
        i['city'], i['class_name'], i['target_audience'],
        i['lower_bound_price'], i['upper_bound_price'], i['training_branch']
    )
    cur.execute(insert_school_teacher_training, insert_values)
print("Berhasil menambahkan data school_teacher_training")

insert_branch = 'INSERT INTO branch(branch_name, address) VALUES (%s, %s)'
for i in branch_load:
    insert_values = (
        clean_text(i['branch_name']), clean_text(i['address'])
    )    
    cur.execute(insert_branch, insert_values)
print("Berhasil menambahkan data branch")

insert_program_available_at = 'INSERT INTO program_available_at(program_id, branch_name) VALUES (%s, %s)'
for i in program_load:
    for j in branch_load:
        insert_values = (
            i['program_id'], j['branch_name']
        )
        cur.execute(insert_program_available_at, insert_values)
print("Berhasil menambahkan data program_available_at")

insert_kiddo_stem_program = 'INSERT INTO kiddo_stem_program(class_name, age, program_id) VALUES (%s, %s, %s)'
for i in kiddo_stem_program_load:
    insert_values = (
        i['class_name'], clean_text(i['age']), i['program_id']
    )
    cur.execute(insert_kiddo_stem_program, insert_values)
print("Berhasil menambahkan data kiddo_stem_program")

insert_kinder_coding_package = 'INSERT INTO kinder_coding_package(package_name, membership_length, total_session, discount, program_id) VALUES (%s, %s, %s, %s, %s)'
for i in kinder_coding_package_load:
    insert_values = (
        i['package_name'], i['membership_length'], i['total_session'],
        i['discount'], i['program_id']
    )
    cur.execute(insert_kinder_coding_package, insert_values)
print("Berhasil menambahkan data kinder_cosing_package")

insert_thematic_class = 'INSERT INTO thematic_class(topic, topic_description, program_id) VALUES (%s, %s, %s)'
for i in thematic_class_load:
    insert_values = (
        i['topic'], clean_text(i['topic_description']), i['program_id']
    )
    cur.execute(insert_thematic_class, insert_values)
print("Berhasil menambahkan data thematic_class")

insert_coding_class_info = 'INSERT INTO coding_class_info(course_name, course_materials, course_audience, course_duration, course_enrollment, course_tuition, program_id) VALUES (%s, %s, %s, %s, %s, %s, %s)'
for i in coding_class_info_load:
    insert_values = (
        i['course_name'], i['course_materials'], i['course_audience'],
        i['course_duration'], i['course_enrollment'], i['course_tuition'], i['program_id']
    )
    cur.execute(insert_coding_class_info, insert_values)
print("Berhasil menambahkan data coding_class_info")

insert_webinar = 'INSERT INTO webinar(webinar_name, webinar_date, program_id) VALUES (%s, %s, %s)'
for i in webinar_load:
    webinar_date = datetime.strptime(i['webinar_date'], '%Y-%m-%d').date()  # pastikan format cocok
    insert_values = (
        i['webinar_name'], webinar_date, i['program_id']
    )
    cur.execute(insert_webinar, insert_values)
print("Berhasil menambahkan data webinar")

# commit all transaction
conn.commit()
print("Berhasil membuat database kodekiddo pada SQL")

if cur is not None:
    cur.close()
if conn is not None:
    conn.close()

# make dump to export to sql
# pg_dump -U <username> -h <hostname> -p <port> <database_name> > <dump_file_name>.sql
# pg_dump -U postgres -h localhost -p 5432 kodekiddo > kodekiddo.sqlLast ran storing.py 
