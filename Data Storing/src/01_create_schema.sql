-- Drop existing database if exists and create new one
DROP DATABASE IF EXISTS boardgame_db;
CREATE DATABASE boardgame_db;
USE boardgame_db;

-- ============================================================================
-- CORE ENTITY TABLES
-- ============================================================================

-- Table: boardgames
-- Description: Main table storing board game information
CREATE TABLE boardgames (
    game_id INT AUTO_INCREMENT PRIMARY KEY,
    rank_position INT UNIQUE NOT NULL,
    title VARCHAR(255) NOT NULL,
    bgg_url VARCHAR(500) NOT NULL UNIQUE,
    year_published SMALLINT,
    geek_rating DECIMAL(4,3),
    avg_rating DECIMAL(4,3),
    users_voted INT,
    min_players TINYINT UNSIGNED,
    max_players TINYINT UNSIGNED,
    min_playtime SMALLINT UNSIGNED,
    max_playtime SMALLINT UNSIGNED,
    min_age TINYINT UNSIGNED,
    complexity_rating DECIMAL(3,2),
    community_owned INT UNSIGNED DEFAULT 0,
    community_wishlist INT UNSIGNED DEFAULT 0,
    num_comments INT UNSIGNED DEFAULT 0,
    num_plays INT UNSIGNED DEFAULT 0,
    fans INT UNSIGNED DEFAULT 0,
    
    -- Constraints
    CONSTRAINT chk_rating_range CHECK (geek_rating >= 0 AND geek_rating <= 10),
    CONSTRAINT chk_avg_rating_range CHECK (avg_rating >= 0 AND avg_rating <= 10),
    CONSTRAINT chk_complexity_range CHECK (complexity_rating >= 0 AND complexity_rating <= 5),
    CONSTRAINT chk_players CHECK (min_players <= max_players),
    CONSTRAINT chk_playtime CHECK (min_playtime <= max_playtime),
    CONSTRAINT chk_year CHECK (year_published >= 1800 AND year_published <= 2030)
);

-- Table: designers
-- Description: Game designers information
CREATE TABLE designers (
    designer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE
);

-- Table: artists
-- Description: Game artists information  
CREATE TABLE artists (
    artist_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE
);

-- Table: publishers
-- Description: Game publishers information
CREATE TABLE publishers (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE
);

-- Table: categories
-- Description: Game categories/themes
CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE
);

-- Table: mechanisms
-- Description: Game mechanisms/mechanics
CREATE TABLE mechanisms (
    mechanism_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE
);

-- Table: families
-- Description: Game families/series
CREATE TABLE families (
    family_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE
);

-- Table: awards
-- Description: Game awards and honors
CREATE TABLE awards (
    award_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE
);

-- Table: reimplemented_games
-- Description: Games that are reimplementations of other games
CREATE TABLE reimplemented_games (
    reimplementation_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE
);

-- Table: stores
-- Description: Marketplace stores for pricing
CREATE TABLE stores (
    store_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    website_url VARCHAR(500)
);

-- ============================================================================
-- RELATIONSHIP/JUNCTION TABLES
-- ============================================================================

-- Table: game_designers
-- Description: Many-to-many relationship between games and designers
CREATE TABLE game_designers (
    game_id INT,
    designer_id INT,
    PRIMARY KEY (game_id, designer_id),
    FOREIGN KEY (game_id) REFERENCES boardgames(game_id) ON DELETE CASCADE,
    FOREIGN KEY (designer_id) REFERENCES designers(designer_id) ON DELETE CASCADE
);

-- Table: game_artists
-- Description: Many-to-many relationship between games and artists
CREATE TABLE game_artists (
    game_id INT,
    artist_id INT,
    PRIMARY KEY (game_id, artist_id),
    FOREIGN KEY (game_id) REFERENCES boardgames(game_id) ON DELETE CASCADE,
    FOREIGN KEY (artist_id) REFERENCES artists(artist_id) ON DELETE CASCADE
);

-- Table: game_publishers
-- Description: Many-to-many relationship between games and publishers
CREATE TABLE game_publishers (
    game_id INT,
    publisher_id INT,
    PRIMARY KEY (game_id, publisher_id),
    FOREIGN KEY (game_id) REFERENCES boardgames(game_id) ON DELETE CASCADE,
    FOREIGN KEY (publisher_id) REFERENCES publishers(publisher_id) ON DELETE CASCADE
);

-- Table: game_categories
-- Description: Many-to-many relationship between games and categories
CREATE TABLE game_categories (
    game_id INT,
    category_id INT,
    PRIMARY KEY (game_id, category_id),
    FOREIGN KEY (game_id) REFERENCES boardgames(game_id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES categories(category_id) ON DELETE CASCADE
);

-- Table: game_mechanisms
-- Description: Many-to-many relationship between games and mechanisms
CREATE TABLE game_mechanisms (
    game_id INT,
    mechanism_id INT,
    PRIMARY KEY (game_id, mechanism_id),
    FOREIGN KEY (game_id) REFERENCES boardgames(game_id) ON DELETE CASCADE,
    FOREIGN KEY (mechanism_id) REFERENCES mechanisms(mechanism_id) ON DELETE CASCADE
);

-- Table: game_families
-- Description: Many-to-many relationship between games and families
CREATE TABLE game_families (
    game_id INT,
    family_id INT,
    PRIMARY KEY (game_id, family_id),
    FOREIGN KEY (game_id) REFERENCES boardgames(game_id) ON DELETE CASCADE,
    FOREIGN KEY (family_id) REFERENCES families(family_id) ON DELETE CASCADE
);

-- Table: game_awards
-- Description: Many-to-many relationship between games and awards
CREATE TABLE game_awards (
    game_id INT,
    award_id INT,
    year_awarded YEAR,
    PRIMARY KEY (game_id, award_id),
    FOREIGN KEY (game_id) REFERENCES boardgames(game_id) ON DELETE CASCADE,
    FOREIGN KEY (award_id) REFERENCES awards(award_id) ON DELETE CASCADE
);

-- Table: game_reimplementations
-- Description: Relationship between games and their reimplementations
CREATE TABLE game_reimplementations (
    game_id INT,
    reimplementation_id INT,
    PRIMARY KEY (game_id, reimplementation_id),
    FOREIGN KEY (game_id) REFERENCES boardgames(game_id) ON DELETE CASCADE,
    FOREIGN KEY (reimplementation_id) REFERENCES reimplemented_games(reimplementation_id) ON DELETE CASCADE
);

-- Table: game_prices
-- Description: Pricing information for games from various stores
CREATE TABLE game_prices (
    price_id INT AUTO_INCREMENT PRIMARY KEY,
    game_id INT NOT NULL,
    store_id INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    currency VARCHAR(3) DEFAULT 'USD',
    condition_type ENUM('New', 'Like New', 'Very Good', 'Good', 'Acceptable', 'Poor', 'Unknown') DEFAULT 'Unknown',
    location VARCHAR(100),
    price_date DATE DEFAULT '2025-08-07',
    
    FOREIGN KEY (game_id) REFERENCES boardgames(game_id) ON DELETE CASCADE,
    FOREIGN KEY (store_id) REFERENCES stores(store_id) ON DELETE CASCADE,
    
    CONSTRAINT chk_positive_price CHECK (price > 0),
    INDEX idx_game_store (game_id, store_id),
    INDEX idx_price_date (price_date)
);

-- ============================================================================
-- INDEXES FOR PERFORMANCE
-- ============================================================================

-- Indexes on boardgames table for common queries
CREATE INDEX idx_boardgames_rank ON boardgames(rank_position);
CREATE INDEX idx_boardgames_year ON boardgames(year_published);
CREATE INDEX idx_boardgames_rating ON boardgames(geek_rating);
CREATE INDEX idx_boardgames_complexity ON boardgames(complexity_rating);
CREATE INDEX idx_boardgames_players ON boardgames(min_players, max_players);

-- Full-text search index for game titles
CREATE FULLTEXT INDEX ft_boardgames_title ON boardgames(title);

-- Composite indexes for relationship tables
CREATE INDEX idx_game_designers_designer ON game_designers(designer_id);
CREATE INDEX idx_game_artists_artist ON game_artists(artist_id);
CREATE INDEX idx_game_publishers_publisher ON game_publishers(publisher_id);
CREATE INDEX idx_game_categories_category ON game_categories(category_id);
CREATE INDEX idx_game_mechanisms_mechanism ON game_mechanisms(mechanism_id);

-- ============================================================================
-- ============================================================================
-- -- VIEWS FOR COMMON QUERIES
-- ============================================================================

-- View: Game details with all related information
CREATE VIEW v_game_details AS
SELECT 
    bg.game_id,
    bg.rank_position,
    bg.title,
    bg.year_published,
    bg.geek_rating,
    bg.avg_rating,
    bg.users_voted,
    bg.min_players,
    bg.max_players,
    bg.min_playtime,
    bg.max_playtime,
    bg.min_age,
    bg.complexity_rating,
    bg.community_owned,
    bg.community_wishlist,
    bg.num_comments,
    bg.num_plays,
    bg.fans,
    GROUP_CONCAT(DISTINCT d.name SEPARATOR ', ') as designers,
    GROUP_CONCAT(DISTINCT a.name SEPARATOR ', ') as artists,
    GROUP_CONCAT(DISTINCT p.name SEPARATOR ', ') as publishers,
    GROUP_CONCAT(DISTINCT c.name SEPARATOR ', ') as categories,
    GROUP_CONCAT(DISTINCT m.name SEPARATOR ', ') as mechanisms
FROM boardgames bg
LEFT JOIN game_designers gd ON bg.game_id = gd.game_id
LEFT JOIN designers d ON gd.designer_id = d.designer_id
LEFT JOIN game_artists ga ON bg.game_id = ga.game_id
LEFT JOIN artists a ON ga.artist_id = a.artist_id
LEFT JOIN game_publishers gp ON bg.game_id = gp.game_id
LEFT JOIN publishers p ON gp.publisher_id = p.publisher_id
LEFT JOIN game_categories gc ON bg.game_id = gc.game_id
LEFT JOIN categories c ON gc.category_id = c.category_id
LEFT JOIN game_mechanisms gm ON bg.game_id = gm.game_id
LEFT JOIN mechanisms m ON gm.mechanism_id = m.mechanism_id
GROUP BY bg.game_id;

-- View: Game pricing summary
CREATE VIEW v_game_pricing AS
SELECT 
    bg.game_id,
    bg.title,
    bg.rank_position,
    COUNT(gp.price_id) as price_count,
    MIN(gp.price) as min_price,
    MAX(gp.price) as max_price,
    AVG(gp.price) as avg_price,
    GROUP_CONCAT(DISTINCT s.name SEPARATOR ', ') as available_stores
FROM boardgames bg
LEFT JOIN game_prices gp ON bg.game_id = gp.game_id
LEFT JOIN stores s ON gp.store_id = s.store_id
GROUP BY bg.game_id;

-- ============================================================================
-- SAMPLE DATA INSERTION FOR STORES
-- ============================================================================

-- Insert common marketplace stores
INSERT INTO stores (name, description, website_url) VALUES
('GeekMarket', 'BoardGameGeek official marketplace', 'https://boardgamegeek.com/geekmarket'),
('GeekMarket API', 'BoardGameGeek marketplace via API', 'https://boardgamegeek.com/api/geekmarket'),
('GeekMarket Section', 'BoardGameGeek marketplace section', 'https://boardgamegeek.com/geekmarket'),
('GeekMarket JS', 'BoardGameGeek marketplace JavaScript', 'https://boardgamegeek.com/geekmarket'),
('Community Marketplace', 'Community-driven marketplace', NULL);

-- ============================================================================
-- GRANT PERMISSIONS
-- ============================================================================

-- Create application user with limited permissions
-- CREATE USER 'boardgame_app'@'localhost' IDENTIFIED BY 'secure_password';
-- GRANT SELECT, INSERT, UPDATE ON boardgame_db.* TO 'boardgame_app'@'localhost';
-- GRANT DELETE ON boardgame_db.game_prices TO 'boardgame_app'@'localhost';
-- GRANT DELETE ON boardgame_db.user_collections TO 'boardgame_app'@'localhost';
-- GRANT DELETE ON boardgame_db.game_reviews TO 'boardgame_app'@'localhost';
-- GRANT DELETE ON boardgame_db.game_sessions TO 'boardgame_app'@'localhost';

-- ============================================================================
-- END OF SCHEMA
-- ============================================================================

-- Show created tables
SHOW TABLES;

-- Display table structure for verification
DESCRIBE boardgames;
