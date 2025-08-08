-- Data Warehouse Star Schema for Spotify Analytics
-- Drop existing DW tables
DROP TABLE IF EXISTS FactSpotify;
DROP TABLE IF EXISTS DimDate;
DROP TABLE IF EXISTS DimGenre;
DROP TABLE IF EXISTS DimArtist;
DROP TABLE IF EXISTS DimSong;
DROP TABLE IF EXISTS DimAlbum;
DROP TABLE IF EXISTS DimPlaylist;
DROP TABLE IF EXISTS DimUser;

-- Dimension Tables

CREATE TABLE DimDate (
    date_key INT PRIMARY KEY,
    year INT NOT NULL,
    month INT NOT NULL,
    day INT NOT NULL
);

CREATE TABLE DimGenre (
    genre_key INT AUTO_INCREMENT PRIMARY KEY,
    genre_id VARCHAR(255) UNIQUE NOT NULL,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE DimArtist (
    artist_key INT AUTO_INCREMENT PRIMARY KEY,
    artist_id VARCHAR(255) UNIQUE NOT NULL,
    name VARCHAR(255) NOT NULL,
    status ENUM('Verified', 'Not Verified') DEFAULT 'Not Verified'
);

CREATE TABLE DimUser (
    user_key INT AUTO_INCREMENT PRIMARY KEY,
    user_id VARCHAR(255) UNIQUE NOT NULL,
    name VARCHAR(255) NOT NULL,
    status ENUM('Verified', 'Not Verified') DEFAULT 'Not Verified'
);

CREATE TABLE DimAlbum (
    album_key INT AUTO_INCREMENT PRIMARY KEY,
    album_id VARCHAR(255) UNIQUE NOT NULL,
    title VARCHAR(255) NOT NULL,
    artist_key INT,
    FOREIGN KEY (artist_key) REFERENCES DimArtist(artist_key)
);

CREATE TABLE DimSong (
    song_key INT AUTO_INCREMENT PRIMARY KEY,
    album_id VARCHAR(255) NOT NULL,
    track_order INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    album_key INT,
    UNIQUE KEY unique_song (album_id, track_order),
    FOREIGN KEY (album_key) REFERENCES DimAlbum(album_key)
);

CREATE TABLE DimPlaylist (
    playlist_key INT AUTO_INCREMENT PRIMARY KEY,
    playlist_id VARCHAR(255) UNIQUE NOT NULL,
    name VARCHAR(255) NOT NULL,
    type ENUM('Public Playlist', 'Private Playlist'),
    genre_key INT,
    user_key INT,
    FOREIGN KEY (genre_key) REFERENCES DimGenre(genre_key),
    FOREIGN KEY (user_key) REFERENCES DimUser(user_key)
);

-- Fact Table
CREATE TABLE FactSpotify (
    fact_key BIGINT AUTO_INCREMENT PRIMARY KEY,
    
    -- Foreign Keys to Dimensions
    date_key INT,
    genre_key INT,
    artist_key INT,
    album_key INT,
    song_key INT,
    playlist_key INT,
    user_key INT,
    
    -- Measures
    save_count INT DEFAULT 0,
    song_count INT DEFAULT 0,
    followers_count INT DEFAULT 0,
    monthly_listeners INT DEFAULT 0,
    play_count BIGINT DEFAULT 0,
    duration INT DEFAULT 0,
    
    -- Foreign Key Constraints
    FOREIGN KEY (date_key) REFERENCES DimDate(date_key),
    FOREIGN KEY (genre_key) REFERENCES DimGenre(genre_key),
    FOREIGN KEY (artist_key) REFERENCES DimArtist(artist_key),
    FOREIGN KEY (album_key) REFERENCES DimAlbum(album_key),
    FOREIGN KEY (song_key) REFERENCES DimSong(song_key),
    FOREIGN KEY (playlist_key) REFERENCES DimPlaylist(playlist_key),
    FOREIGN KEY (user_key) REFERENCES DimUser(user_key)
);

-- Indexes for performance optimization
CREATE INDEX idx_fact_date ON FactSpotify(date_key);
CREATE INDEX idx_fact_genre ON FactSpotify(genre_key);
CREATE INDEX idx_fact_artist ON FactSpotify(artist_key);
CREATE INDEX idx_fact_album ON FactSpotify(album_key);
CREATE INDEX idx_fact_song ON FactSpotify(song_key);
CREATE INDEX idx_fact_playlist ON FactSpotify(playlist_key);
CREATE INDEX idx_fact_user ON FactSpotify(user_key);