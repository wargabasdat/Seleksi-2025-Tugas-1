CREATE TABLE dim_book (
    book_id INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    year INT NOT NULL,
    pages VARCHAR(255) NOT NULL,
    PRIMARY KEY (book_id)
);

CREATE TABLE dim_type (
    type_id INT NOT NULL AUTO_INCREMENT,
    type_name VARCHAR(255) NOT NULL,
    PRIMARY KEY (type_id)
);

CREATE TABLE dim_length (
    length_id INT NOT NULL AUTO_INCREMENT,
    length_name VARCHAR(255) NOT NULL,
    PRIMARY KEY (length_id)
);

CREATE TABLE dim_author (
    author_id INT NOT NULL AUTO_INCREMENT,
    author_name VARCHAR(255) NOT NULL,
    PRIMARY KEY (author_id)
);

CREATE TABLE dim_country (
    country_id INT NOT NULL AUTO_INCREMENT,
    country_name VARCHAR(255) NOT NULL,
    PRIMARY KEY (country_id)
);

CREATE TABLE dim_language (
    language_id INT NOT NULL AUTO_INCREMENT,
    language_name VARCHAR(255) NOT NULL,
    PRIMARY KEY (language_id)
);

CREATE TABLE dim_genre (
    genre_id INT NOT NULL AUTO_INCREMENT,
    genre_name VARCHAR(255) NOT NULL,
    PRIMARY KEY (genre_id)
);

CREATE TABLE dim_subject (
    subject_id INT NOT NULL AUTO_INCREMENT,
    subject_name VARCHAR(255) NOT NULL,
    PRIMARY KEY (subject_id)
);

CREATE TABLE dim_date (
    date_id INT NOT NULL,
    month INT NOT NULL,
    year INT NOT NULL,
    PRIMARY KEY (date_id)
);

CREATE TABLE fact_top_books (
    book_id INT,
    type_id INT,
    length_id INT,  
    author_id INT,
    country_id INT,
    language_id INT,
    genre_id INT, -- 
    subject_id INT, -- 
    date_id INT,

    -- Measures
    rank INT,
    avg_rating FLOAT,

    PRIMARY KEY (book_id, date_id),
    FOREIGN KEY (book_id) REFERENCES dim_book(book_id),
    FOREIGN KEY (type_id) REFERENCES dim_type(type_id),
    FOREIGN KEY (length_id) REFERENCES dim_length(length_id),
    FOREIGN KEY (author_id) REFERENCES dim_author(author_id),
    FOREIGN KEY (country_id) REFERENCES dim_country(country_id),
    FOREIGN KEY (language_id) REFERENCES dim_language(language_id),
    FOREIGN KEY (genre_id) REFERENCES dim_genre(genre_id),
    FOREIGN KEY (subject_id) REFERENCES dim_subject(subject_id),
    FOREIGN KEY (date_id) REFERENCES dim_date(date_id)
);