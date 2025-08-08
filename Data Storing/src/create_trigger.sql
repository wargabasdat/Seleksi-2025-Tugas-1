-- Fungsi untuk validasi rating
CREATE OR REPLACE FUNCTION check_rating_range()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.rating IS NOT NULL AND (NEW.rating < 0 OR NEW.rating > 10) THEN
        RAISE EXCEPTION 'Rating must be between 0 and 10';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger diterapkan ke table videogame
CREATE TRIGGER rating_check_trigger
BEFORE INSERT OR UPDATE ON videogame
FOR EACH ROW
EXECUTE FUNCTION check_rating_range();
