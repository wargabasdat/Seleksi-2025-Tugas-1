DROP TABLE IF EXISTS Playlist_Song;
DROP TABLE IF EXISTS Song_Artist;
DROP TABLE IF EXISTS Song;
DROP TABLE IF EXISTS Album;
DROP TABLE IF EXISTS Playlist;
DROP TABLE IF EXISTS Artist;
DROP TABLE IF EXISTS User;
DROP TABLE IF EXISTS Genre;

-- Base Tables

CREATE TABLE Genre (
    genre_id VARCHAR(255) PRIMARY KEY,
    name VARCHAR(255) NOT NULL CHECK (name != '' AND name IS NOT NULL)
);

CREATE TABLE Artist (
    artist_id VARCHAR(255) PRIMARY KEY,
    name VARCHAR(255) NOT NULL CHECK (name != '' AND name IS NOT NULL),
    status ENUM('Verified', 'Not Verified') DEFAULT 'Not Verified',
    monthly_listeners INT CHECK (monthly_listeners >= 0),
    followers_count INT CHECK (followers_count >= 0)
);

CREATE TABLE User (
    user_id VARCHAR(255) PRIMARY KEY,
    name VARCHAR(255) NOT NULL CHECK (name != '' AND name IS NOT NULL),
    status ENUM('Verified', 'Not Verified') DEFAULT 'Not Verified',
    followers_count INT CHECK (followers_count >= 0),
    following_count INT CHECK (following_count >= 0),
    public_playlist_count INT CHECK (public_playlist_count >= 0)
);

-- Dependent Tables

-- Playlist table (depends on Genre and User)
CREATE TABLE Playlist (
    playlist_id VARCHAR(255) PRIMARY KEY,
    genre_id VARCHAR(255),
    name VARCHAR(255) NOT NULL CHECK (name != '' AND name IS NOT NULL),
    save_count INT CHECK (save_count >= 0),
    song_count INT CHECK (song_count >= 0),
    duration INT CHECK (duration >= 0),
    type ENUM('Public Playlist', 'Private Playlist') NOT NULL,
    description TEXT,
    creator_id VARCHAR(255),
    FOREIGN KEY (genre_id) REFERENCES Genre(genre_id) ON DELETE SET NULL,
    FOREIGN KEY (creator_id) REFERENCES User(user_id) ON DELETE SET NULL
);

-- Album table (depends on Artist)
CREATE TABLE Album (
    album_id VARCHAR(255) PRIMARY KEY,
    artist_id VARCHAR(255),
    title VARCHAR(255) NOT NULL CHECK (title != '' AND title IS NOT NULL),
    release_date DATE,
    song_count INT CHECK (song_count >= 0),
    duration INT CHECK (duration >= 0),
    FOREIGN KEY (artist_id) REFERENCES Artist(artist_id) ON DELETE SET NULL
);

-- Song table (depends on Album) - Weak entity with composite key
CREATE TABLE Song (
    album_id VARCHAR(255),
    track_order INT,
    title VARCHAR(255) NOT NULL CHECK (title != '' AND title IS NOT NULL),
    release_date DATE,
    play_count BIGINT CHECK (play_count >= 0),
    duration INT CHECK (duration >= 0),
    PRIMARY KEY (album_id, track_order),
    FOREIGN KEY (album_id) REFERENCES Album(album_id) ON DELETE CASCADE
);

-- Song_Artist junction table (depends on Song and Artist)
CREATE TABLE Song_Artist (
    artist_id VARCHAR(255),
    album_id VARCHAR(255),
    track_order INT,
    PRIMARY KEY (artist_id, album_id, track_order),
    FOREIGN KEY (artist_id) REFERENCES Artist(artist_id) ON DELETE CASCADE,
    FOREIGN KEY (album_id, track_order) REFERENCES Song(album_id, track_order) ON DELETE CASCADE
);

-- Playlist_Song junction table (depends on Playlist and Song)
CREATE TABLE Playlist_Song (
    playlist_id VARCHAR(255),
    album_id VARCHAR(255),
    track_order INT,
    added_date DATE,
    PRIMARY KEY (playlist_id, album_id, track_order),
    FOREIGN KEY (playlist_id) REFERENCES Playlist(playlist_id) ON DELETE CASCADE,
    FOREIGN KEY (album_id, track_order) REFERENCES Song(album_id, track_order) ON DELETE CASCADE
);

-- Indexes for performance optimization
CREATE INDEX idx_playlist_genre ON Playlist(genre_id);
CREATE INDEX idx_playlist_creator ON Playlist(creator_id);
CREATE INDEX idx_album_artist ON Album(artist_id);
CREATE INDEX idx_song_album ON Song(album_id);
CREATE INDEX idx_song_artist_artist ON Song_Artist(artist_id);
CREATE INDEX idx_song_artist_song ON Song_Artist(album_id, track_order);
CREATE INDEX idx_playlist_song_playlist ON Playlist_Song(playlist_id);
CREATE INDEX idx_playlist_song_song ON Playlist_Song(album_id, track_order);