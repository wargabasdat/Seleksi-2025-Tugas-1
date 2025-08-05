-- Create Table youtubers
CREATE TABLE youtubers (
    youtuber_name VARCHAR(100) PRIMARY KEY, 
    gender VARCHAR(10),
    email VARCHAR(255) UNIQUE,
    youtube_subscribers INTEGER,
    facebook_followers INTEGER,
    instagram_followers INTEGER,
    "type" VARCHAR(10)
);

-- Create Table channels
CREATE TABLE channels (
    youtube_channel_link VARCHAR(255) PRIMARY KEY, 
    channel_name VARCHAR(255) NOT NULL, 
    "description" TEXT,
    type_of_channel VARCHAR(50), 
    since DATE,
    
    -- Foreign Key yang menghubungkan ke tabel youtubers
    youtuber_name VARCHAR(100) NOT NULL, 
    CONSTRAINT fk_youtuber_name
        FOREIGN KEY (youtuber_name)
        REFERENCES youtubers(youtuber_name)
        ON DELETE CASCADE 
        ON UPDATE CASCADE 
);

-- Indeks untuk searching lebih cepat pada Foreign Key
CREATE INDEX idx_youtuber_name_fk ON channels (youtuber_name);

-- Trigger untuk memastikan followers dan subscribers tidak kurang dari 0
CREATE OR REPLACE FUNCTION ensure_positive_followers()
RETURNS TRIGGER AS $$
BEGIN
    -- Untuk youtube_subscribers
    IF NEW.youtube_subscribers < 0 THEN
        RAISE EXCEPTION 'Jumlah YouTube subscribers tidak boleh kurang dari 0.';
    END IF;

    -- Untuk instagram_followers
    IF NEW.instagram_followers < 0 THEN
        RAISE EXCEPTION 'Jumlah Instagram followers tidak boleh kurang dari 0.';
    END IF;

    -- Untuk facebook_followers
    IF NEW.facebook_followers < 0 THEN
        RAISE EXCEPTION 'Jumlah Facebook followers tidak boleh kurang dari 0.';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- CREATE TRIGGER check_subscribers_before_insert_update
BEFORE INSERT OR UPDATE ON youtubers
FOR EACH ROW
EXECUTE FUNCTION ensure_positive_subscribers();