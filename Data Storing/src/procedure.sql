DELIMITER //

CREATE PROCEDURE UpsertBook (
    IN p_rank INT,
    IN p_title VARCHAR(255),
    IN p_year INT,
    IN p_pages VARCHAR(255),
    IN p_avg_rating FLOAT,
    IN p_type_id INT,
    IN p_length_id INT,
    IN p_author_id INT,
    IN p_country_id INT,
    IN p_language_ids VARCHAR(255),
    IN p_genre_ids VARCHAR(255),
    IN p_subject_ids VARCHAR(255)
)
BEGIN
    DECLARE v_book_id INT;
    DECLARE current_id INT;
    DECLARE remaining_ids TEXT;
    DECLARE comma_pos INT;
    
    -- Error handler for the transaction
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SET @allow_book_insert = NULL; 
        ROLLBACK;
        RESIGNAL;
    END;

    -- Check if a book with this title and author already exists
    SELECT book_id INTO v_book_id
    FROM Book
    WHERE title = p_title AND author_id = p_author_id
    LIMIT 1;

    START TRANSACTION;

    IF v_book_id IS NOT NULL THEN
        -- UPDATE IF BOOK EXISTS
        UPDATE Book
        SET 
            rank = p_rank,
            year = p_year,
            pages = p_pages,
            avg_rating = p_avg_rating,
            type_id = p_type_id,
            length_id = p_length_id,
            country_id = p_country_id
        WHERE book_id = v_book_id;

        -- Clear out old many-to-many relationships to replace them
        DELETE FROM BookLanguages WHERE book_id = v_book_id;
        DELETE FROM BookGenres WHERE book_id = v_book_id;
        DELETE FROM BookSubjects WHERE book_id = v_book_id;

    ELSE
        -- INSERT IF BOOK DOES NOT EXIST
        SET @allow_book_insert = 1;

        INSERT INTO Book(rank, title, year, pages, avg_rating, type_id, length_id, author_id, country_id)
        VALUES(p_rank, p_title, p_year, p_pages, p_avg_rating, p_type_id, p_length_id, p_author_id, p_country_id);
        
        SET @allow_book_insert = NULL;
        
        SET v_book_id = LAST_INSERT_ID();
    END IF;
    -- Insert languages
    IF p_language_ids IS NOT NULL AND p_language_ids != '' THEN
        SET remaining_ids = CONCAT(p_language_ids, ',');
        WHILE LENGTH(remaining_ids) > 0 DO
            SET comma_pos = LOCATE(',', remaining_ids);
            IF comma_pos > 0 THEN
                SET current_id = CAST(TRIM(SUBSTRING(remaining_ids, 1, comma_pos - 1)) AS UNSIGNED);
                IF current_id > 0 THEN
                    INSERT INTO BookLanguages(book_id, language_id) VALUES(v_book_id, current_id);
                END IF;
                SET remaining_ids = SUBSTRING(remaining_ids, comma_pos + 1);
            ELSE
                SET remaining_ids = '';
            END IF;
        END WHILE;
    END IF;

    -- Insert genres
    IF p_genre_ids IS NOT NULL AND p_genre_ids != '' THEN
        SET remaining_ids = CONCAT(p_genre_ids, ',');
        WHILE LENGTH(remaining_ids) > 0 DO
            SET comma_pos = LOCATE(',', remaining_ids);
            IF comma_pos > 0 THEN
                SET current_id = CAST(TRIM(SUBSTRING(remaining_ids, 1, comma_pos - 1)) AS UNSIGNED);
                IF current_id > 0 THEN
                    INSERT INTO BookGenres(book_id, genre_id) VALUES(v_book_id, current_id);
                END IF;
                SET remaining_ids = SUBSTRING(remaining_ids, comma_pos + 1);
            ELSE
                SET remaining_ids = '';
            END IF;
        END WHILE;
    END IF;
    
    -- Insert subjects
    IF p_subject_ids IS NOT NULL AND p_subject_ids != '' THEN
        SET remaining_ids = CONCAT(p_subject_ids, ',');
        WHILE LENGTH(remaining_ids) > 0 DO
            SET comma_pos = LOCATE(',', remaining_ids);
            IF comma_pos > 0 THEN
                SET current_id = CAST(TRIM(SUBSTRING(remaining_ids, 1, comma_pos - 1)) AS UNSIGNED);
                IF current_id > 0 THEN
                    INSERT INTO BookSubjects(book_id, subject_id) VALUES(v_book_id, current_id);
                END IF;
                SET remaining_ids = SUBSTRING(remaining_ids, comma_pos + 1);
            ELSE
                SET remaining_ids = '';
            END IF;
        END WHILE;
    END IF;

    COMMIT;
END //

DELIMITER ;
