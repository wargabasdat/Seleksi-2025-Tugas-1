-- Data Warehouse Triggers for real-time updates from operational tables

DELIMITER //

CREATE TRIGGER sync_artist_update
AFTER UPDATE ON Artist
FOR EACH ROW
BEGIN
    UPDATE FactSpotify 
    SET monthly_listeners = NEW.monthly_listeners,
        followers_count = NEW.followers_count
    WHERE artist_key = (SELECT artist_key FROM DimArtist WHERE artist_id = NEW.artist_id);
END//

CREATE TRIGGER sync_song_update
AFTER UPDATE ON Song
FOR EACH ROW
BEGIN
    UPDATE FactSpotify 
    SET play_count = NEW.play_count,
        duration = NEW.duration
    WHERE song_key = (SELECT song_key FROM DimSong WHERE album_id = NEW.album_id AND track_order = NEW.track_order);
END//

CREATE TRIGGER sync_playlist_update
AFTER UPDATE ON Playlist
FOR EACH ROW
BEGIN
    UPDATE FactSpotify 
    SET save_count = NEW.save_count,
        song_count = NEW.song_count
    WHERE playlist_key = (SELECT playlist_key FROM DimPlaylist WHERE playlist_id = NEW.playlist_id);
END//

CREATE TRIGGER sync_artist_dimension_update
AFTER UPDATE ON Artist
FOR EACH ROW
BEGIN
    UPDATE DimArtist 
    SET name = NEW.name, status = NEW.status
    WHERE artist_id = NEW.artist_id;
END//

CREATE TRIGGER sync_playlist_dimension_update
AFTER UPDATE ON Playlist
FOR EACH ROW
BEGIN
    UPDATE DimPlaylist 
    SET name = NEW.name, type = NEW.type
    WHERE playlist_id = NEW.playlist_id;
END//

CREATE TRIGGER sync_song_dimension_update
AFTER UPDATE ON Song
FOR EACH ROW
BEGIN
    UPDATE DimSong 
    SET title = NEW.title
    WHERE album_id = NEW.album_id AND track_order = NEW.track_order;
END//

CREATE TRIGGER validate_fact_measures
BEFORE INSERT ON FactSpotify
FOR EACH ROW
BEGIN
    -- Ensure date_key is valid format (YYYYMMDD)
    IF NEW.date_key IS NOT NULL AND (NEW.date_key < 19700101 OR NEW.date_key > 21001231) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Invalid date_key format. Must be YYYYMMDD between 1970-2100';
    END IF;
    
    IF NEW.save_count < 0 OR NEW.song_count < 0 OR NEW.followers_count < 0 OR 
       NEW.monthly_listeners < 0 OR NEW.play_count < 0 OR NEW.duration < 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Measures cannot be negative';
    END IF;
END//

CREATE TRIGGER prevent_genre_delete
BEFORE DELETE ON DimGenre
FOR EACH ROW
BEGIN
    DECLARE fact_count INT DEFAULT 0;
    
    SELECT COUNT(*) INTO fact_count 
    FROM FactSpotify 
    WHERE genre_key = OLD.genre_key;
    
    IF fact_count > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Cannot delete genre - referenced by fact records';
    END IF;
END//

CREATE TRIGGER prevent_artist_delete
BEFORE DELETE ON DimArtist
FOR EACH ROW
BEGIN
    DECLARE fact_count INT DEFAULT 0;
    
    SELECT COUNT(*) INTO fact_count 
    FROM FactSpotify 
    WHERE artist_key = OLD.artist_key;
    
    IF fact_count > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Cannot delete artist - referenced by fact records';
    END IF;
END//

CREATE TRIGGER prevent_album_delete
BEFORE DELETE ON DimAlbum
FOR EACH ROW
BEGIN
    DECLARE fact_count INT DEFAULT 0;
    
    SELECT COUNT(*) INTO fact_count 
    FROM FactSpotify 
    WHERE album_key = OLD.album_key;
    
    IF fact_count > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Cannot delete album - referenced by fact records';
    END IF;
END//

CREATE TRIGGER prevent_song_delete
BEFORE DELETE ON DimSong
FOR EACH ROW
BEGIN
    DECLARE fact_count INT DEFAULT 0;
    
    SELECT COUNT(*) INTO fact_count 
    FROM FactSpotify 
    WHERE song_key = OLD.song_key;
    
    IF fact_count > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Cannot delete song - referenced by fact records';
    END IF;
END//

CREATE TRIGGER prevent_playlist_delete
BEFORE DELETE ON DimPlaylist
FOR EACH ROW
BEGIN
    DECLARE fact_count INT DEFAULT 0;
    
    SELECT COUNT(*) INTO fact_count 
    FROM FactSpotify 
    WHERE playlist_key = OLD.playlist_key;
    
    IF fact_count > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Cannot delete playlist - referenced by fact records';
    END IF;
END//

CREATE TRIGGER prevent_user_delete
BEFORE DELETE ON DimUser
FOR EACH ROW
BEGIN
    DECLARE fact_count INT DEFAULT 0;
    
    SELECT COUNT(*) INTO fact_count 
    FROM FactSpotify 
    WHERE user_key = OLD.user_key;
    
    IF fact_count > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Cannot delete user - referenced by fact records';
    END IF;
END//

DELIMITER ;