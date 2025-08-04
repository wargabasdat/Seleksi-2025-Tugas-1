CREATE TABLE Type (
    type_id INT NOT NULL AUTO_INCREMENT,
    type_name VARCHAR(255) NOT NULL,
    PRIMARY KEY (type_id)
);

CREATE TABLE Length (
    length_id INT NOT NULL AUTO_INCREMENT,
    length_name VARCHAR(255) NOT NULL,
    PRIMARY KEY (length_id)
);

CREATE TABLE Author (
    author_id INT NOT NULL AUTO_INCREMENT,
    author_name VARCHAR(255) NOT NULL,
    PRIMARY KEY (author_id)
);

CREATE TABLE Country (
    country_id INT NOT NULL AUTO_INCREMENT,
    country_name VARCHAR(255) NOT NULL,
    PRIMARY KEY (country_id)
);

CREATE TABLE Language (
    language_id INT NOT NULL AUTO_INCREMENT,
    language_name VARCHAR(255) NOT NULL,
    PRIMARY KEY (language_id)
);

CREATE TABLE Genre (
    genre_id INT NOT NULL AUTO_INCREMENT,
    genre_name VARCHAR(255) NOT NULL,
    PRIMARY KEY (genre_id)
);

CREATE TABLE Subject (
    subject_id INT NOT NULL AUTO_INCREMENT,
    subject_name VARCHAR(255) NOT NULL,
    PRIMARY KEY (subject_id)
);

CREATE TABLE Book (
    book_id INT NOT NULL AUTO_INCREMENT,
    rank INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    year INT NOT NULL,
    pages VARCHAR(255) NOT NULL,
    avg_rating FLOAT NOT NULL,
    type_id INT NOT NULL,
    length_id INT NOT NULL,
    author_id INT NOT NULL,
    country_id INT NOT NULL,
    PRIMARY KEY (book_id),
    FOREIGN KEY (type_id) REFERENCES Type(type_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    FOREIGN KEY (length_id) REFERENCES Length(length_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    FOREIGN KEY (author_id) REFERENCES Author(author_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    FOREIGN KEY (country_id) REFERENCES Country(country_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE BookLanguages (
    book_id INT NOT NULL,
    language_id INT NOT NULL,
    PRIMARY KEY (book_id, language_id),
    FOREIGN KEY (book_id) REFERENCES Book(book_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    FOREIGN KEY (language_id) REFERENCES Language(language_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE BookGenres (
    book_id INT NOT NULL,
    genre_id INT NOT NULL,
    PRIMARY KEY (book_id, genre_id),
    FOREIGN KEY (book_id) REFERENCES Book(book_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    FOREIGN KEY (genre_id) REFERENCES Genre(genre_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE BookSubjects (
    book_id INT NOT NULL,
    subject_id INT NOT NULL,
    PRIMARY KEY (book_id, subject_id),
    FOREIGN KEY (book_id) REFERENCES Book(book_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    FOREIGN KEY (subject_id) REFERENCES Subject(subject_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);