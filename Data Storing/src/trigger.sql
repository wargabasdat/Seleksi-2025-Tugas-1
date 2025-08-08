DELIMITER //

CREATE TRIGGER validate_track_order_before_insert
BEFORE INSERT ON Song
FOR EACH ROW
BEGIN
    DECLARE max_track INT DEFAULT 0;
    
    IF NEW.track_order <= 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Track order must be greater than 0';
    END IF;
    
    SELECT COALESCE(MAX(track_order), 0) INTO max_track 
    FROM Song 
    WHERE album_id = NEW.album_id;

END//

CREATE TRIGGER update_playlist_song_count_after_insert
AFTER INSERT ON Playlist_Song
FOR EACH ROW
BEGIN
    UPDATE Playlist 
    SET song_count = song_count + 1
    WHERE playlist_id = NEW.playlist_id;
END//

CREATE TRIGGER update_playlist_song_count_after_delete
AFTER DELETE ON Playlist_Song
FOR EACH ROW
BEGIN
    UPDATE Playlist 
    SET song_count = song_count - 1
    WHERE playlist_id = OLD.playlist_id;
END//

CREATE TRIGGER update_album_song_count_after_insert
AFTER INSERT ON Song
FOR EACH ROW
BEGIN
    UPDATE Album 
    SET song_count = song_count + 1,
        duration = duration + NEW.duration
    WHERE album_id = NEW.album_id;
END//

CREATE TRIGGER update_album_song_count_after_delete
AFTER DELETE ON Song
FOR EACH ROW
BEGIN
    UPDATE Album 
    SET song_count = song_count - 1,
        duration = duration - OLD.duration
    WHERE album_id = OLD.album_id;
END//

CREATE TRIGGER update_album_song_count_after_update
AFTER UPDATE ON Song
FOR EACH ROW
BEGIN
    IF OLD.album_id != NEW.album_id THEN
        UPDATE Album 
        SET song_count = song_count - 1,
            duration = duration - OLD.duration
        WHERE album_id = OLD.album_id;
        
        UPDATE Album 
        SET song_count = song_count + 1,
            duration = duration + NEW.duration
        WHERE album_id = NEW.album_id;
    ELSE
        UPDATE Album 
        SET duration = duration - OLD.duration + NEW.duration
        WHERE album_id = NEW.album_id;
    END IF;
END//

CREATE TRIGGER validate_album_release_date
BEFORE INSERT ON Album
FOR EACH ROW
BEGIN
    IF NEW.release_date > CURDATE() THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Album release date cannot be in the future';
    END IF;
END//

CREATE TRIGGER validate_album_release_date_update
BEFORE UPDATE ON Album
FOR EACH ROW
BEGIN
    IF NEW.release_date > CURDATE() THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Album release date cannot be in the future';
    END IF;
END//

CREATE TRIGGER validate_song_release_date
BEFORE INSERT ON Song
FOR EACH ROW
BEGIN
    DECLARE album_release_date DATE;
    
    IF NEW.release_date > CURDATE() THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Song release date cannot be in the future';
    END IF;
    
    SELECT release_date INTO album_release_date 
    FROM Album 
    WHERE album_id = NEW.album_id;
    
    IF NEW.release_date < album_release_date THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Song release date cannot be before album release date';
    END IF;
END//

CREATE TRIGGER validate_song_release_date_update
BEFORE UPDATE ON Song
FOR EACH ROW
BEGIN
    DECLARE album_release_date DATE;
    
    IF NEW.release_date > CURDATE() THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Song release date cannot be in the future';
    END IF;
    
    SELECT release_date INTO album_release_date 
    FROM Album 
    WHERE album_id = NEW.album_id;
    
    IF NEW.release_date < album_release_date THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Song release date cannot be before album release date';
    END IF;
END//

DELIMITER ;