DELIMITER //

-- Trigger to prevent direct INSERT into Book table
CREATE TRIGGER prevent_direct_book_insert
    BEFORE INSERT ON Book
    FOR EACH ROW
BEGIN
    -- Check if we're inside the procedure by looking for a session variable
    IF @allow_book_insert IS NULL OR @allow_book_insert != 1 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Direct INSERT into Book table is not allowed. Use CreateNewBook procedure instead.';
    END IF;
END //

DELIMITER ;

DELIMITER //

-- Trigger to validate rank is a positive integer
CREATE TRIGGER validate_book_rank
    BEFORE INSERT ON Book
    FOR EACH ROW
BEGIN
    -- Validate rank is a positive integer
    IF NEW.rank <= 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Rank must be a positive integer.';
    END IF;

END //

DELIMITER ;

DELIMITER //

-- Trigger to validate year is not in the future
CREATE TRIGGER validate_book_year
    BEFORE INSERT ON Book
    FOR EACH ROW
BEGIN
    -- Validate year is not in the future
    IF NEW.year > YEAR(CURDATE()) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Year cannot be greater than current year.';
    END IF;
    
END //

DELIMITER ;

DELIMITER //

-- Trigger to validate avg_rating is between 0 and 5
CREATE TRIGGER validate_book_avg_rating
    BEFORE INSERT ON Book
    FOR EACH ROW
BEGIN
    -- Validate avg_rating is between 0 and 5
    IF NEW.avg_rating < 0 OR NEW.avg_rating > 5 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Average rating must be between 0 and 5.';
    END IF;

END //

DELIMITER ;