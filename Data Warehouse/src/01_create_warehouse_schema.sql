-- ============================================================================
-- BoardGame Data Warehouse Schema
-- Created: August 7, 2025
-- Description: Dimensional model schema for BoardGameGeek data analytics
-- 
-- This schema implements a star schema with some snowflake elements for
-- analytical processing and business intelligence operations.
-- ============================================================================

-- Drop existing warehouse database if exists and create new one
DROP DATABASE IF EXISTS boardgame_dw;
CREATE DATABASE boardgame_dw;
USE boardgame_dw;

-- ============================================================================
-- TIME DIMENSION
-- ============================================================================

-- dim_time: Comprehensive time dimension for temporal analysis
CREATE TABLE dim_time (
    time_key INT PRIMARY KEY,
    date_value DATE NOT NULL UNIQUE,
    year SMALLINT NOT NULL,
    quarter TINYINT NOT NULL,
    month TINYINT NOT NULL,
    month_name VARCHAR(20) NOT NULL,
    week_of_year TINYINT NOT NULL,
    day_of_month TINYINT NOT NULL,
    day_of_week TINYINT NOT NULL,
    day_name VARCHAR(20) NOT NULL,
    is_weekend BOOLEAN NOT NULL DEFAULT FALSE,
    is_holiday BOOLEAN NOT NULL DEFAULT FALSE,
    fiscal_year SMALLINT,
    fiscal_quarter TINYINT,
    
    INDEX idx_year (year),
    INDEX idx_quarter (year, quarter),
    INDEX idx_month (year, month),
    INDEX idx_date (date_value)
);

-- ============================================================================
-- CORE DIMENSION TABLES
-- ============================================================================

-- dim_game: Game dimension with slowly changing dimension support
CREATE TABLE dim_game (
    game_key INT AUTO_INCREMENT PRIMARY KEY,
    game_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    bgg_url VARCHAR(500) NOT NULL,
    year_published SMALLINT,
    min_players TINYINT UNSIGNED,
    max_players TINYINT UNSIGNED,
    min_playtime SMALLINT UNSIGNED,
    max_playtime SMALLINT UNSIGNED,
    min_age TINYINT UNSIGNED,
    complexity_rating DECIMAL(3,2),
    
    -- SCD Type 2 fields
    effective_date DATE NOT NULL,
    expiry_date DATE NULL,
    is_current BOOLEAN NOT NULL DEFAULT TRUE,
    record_source VARCHAR(50) NOT NULL DEFAULT 'operational_db',
    
    -- Additional analytical attributes
    complexity_category ENUM('Light', 'Medium-Light', 'Medium', 'Medium-Heavy', 'Heavy') GENERATED ALWAYS AS (
        CASE 
            WHEN complexity_rating < 1.5 THEN 'Light'
            WHEN complexity_rating < 2.5 THEN 'Medium-Light'
            WHEN complexity_rating < 3.5 THEN 'Medium'
            WHEN complexity_rating < 4.5 THEN 'Medium-Heavy'
            ELSE 'Heavy'
        END
    ) STORED,
    
    player_range ENUM('Solo', '2-Player', 'Small Group', 'Large Group', 'Party') GENERATED ALWAYS AS (
        CASE 
            WHEN max_players = 1 THEN 'Solo'
            WHEN max_players = 2 THEN '2-Player'
            WHEN max_players <= 4 THEN 'Small Group'
            WHEN max_players <= 8 THEN 'Large Group'
            ELSE 'Party'
        END
    ) STORED,
    
    playtime_category ENUM('Quick', 'Short', 'Medium', 'Long', 'Epic') GENERATED ALWAYS AS (
        CASE 
            WHEN max_playtime <= 30 THEN 'Quick'
            WHEN max_playtime <= 60 THEN 'Short'
            WHEN max_playtime <= 120 THEN 'Medium'
            WHEN max_playtime <= 240 THEN 'Long'
            ELSE 'Epic'
        END
    ) STORED,
    
    INDEX idx_game_id (game_id),
    INDEX idx_current (is_current),
    INDEX idx_year_published (year_published),
    INDEX idx_complexity (complexity_rating),
    INDEX idx_title (title)
);

-- dim_designer: Designer dimension
CREATE TABLE dim_designer (
    designer_key INT AUTO_INCREMENT PRIMARY KEY,
    designer_id INT NOT NULL,
    designer_name VARCHAR(255) NOT NULL,
    total_games INT DEFAULT 0,
    avg_game_rating DECIMAL(4,3) DEFAULT 0,
    
    -- SCD Type 2 fields
    effective_date DATE NOT NULL,
    expiry_date DATE NULL,
    is_current BOOLEAN NOT NULL DEFAULT TRUE,
    
    INDEX idx_designer_id (designer_id),
    INDEX idx_current (is_current),
    INDEX idx_name (designer_name)
);

-- dim_publisher: Publisher dimension
CREATE TABLE dim_publisher (
    publisher_key INT AUTO_INCREMENT PRIMARY KEY,
    publisher_id INT NOT NULL,
    publisher_name VARCHAR(255) NOT NULL,
    total_games INT DEFAULT 0,
    avg_game_rating DECIMAL(4,3) DEFAULT 0,
    market_focus ENUM('Mass Market', 'Hobby', 'Premium', 'Niche') DEFAULT 'Hobby',
    
    -- SCD Type 2 fields
    effective_date DATE NOT NULL,
    expiry_date DATE NULL,
    is_current BOOLEAN NOT NULL DEFAULT TRUE,
    
    INDEX idx_publisher_id (publisher_id),
    INDEX idx_current (is_current),
    INDEX idx_name (publisher_name)
);

-- dim_category: Category dimension
CREATE TABLE dim_category (
    category_key INT AUTO_INCREMENT PRIMARY KEY,
    category_id INT NOT NULL,
    category_name VARCHAR(255) NOT NULL,
    category_group VARCHAR(100),
    
    INDEX idx_category_id (category_id),
    INDEX idx_name (category_name)
);

-- dim_mechanism: Mechanism dimension
CREATE TABLE dim_mechanism (
    mechanism_key INT AUTO_INCREMENT PRIMARY KEY,
    mechanism_id INT NOT NULL,
    mechanism_name VARCHAR(255) NOT NULL,
    mechanism_type VARCHAR(100),
    complexity_impact ENUM('Low', 'Medium', 'High') DEFAULT 'Medium',
    
    INDEX idx_mechanism_id (mechanism_id),
    INDEX idx_name (mechanism_name)
);

-- dim_store: Store dimension
CREATE TABLE dim_store (
    store_key INT AUTO_INCREMENT PRIMARY KEY,
    store_id INT NOT NULL,
    store_name VARCHAR(100) NOT NULL,
    store_type ENUM('Online', 'Physical', 'Marketplace', 'Auction') DEFAULT 'Online',
    region VARCHAR(100),
    website_url VARCHAR(500),
    
    INDEX idx_store_id (store_id),
    INDEX idx_name (store_name)
);

-- ============================================================================
-- BRIDGE TABLES (Many-to-Many Relationships)
-- ============================================================================

-- bridge_game_designer: Game to Designer many-to-many
CREATE TABLE bridge_game_designer (
    game_key INT,
    designer_key INT,
    weight_factor DECIMAL(3,2) DEFAULT 1.00,
    PRIMARY KEY (game_key, designer_key),
    FOREIGN KEY (game_key) REFERENCES dim_game(game_key),
    FOREIGN KEY (designer_key) REFERENCES dim_designer(designer_key)
);

-- bridge_game_publisher: Game to Publisher many-to-many
CREATE TABLE bridge_game_publisher (
    game_key INT,
    publisher_key INT,
    weight_factor DECIMAL(3,2) DEFAULT 1.00,
    PRIMARY KEY (game_key, publisher_key),
    FOREIGN KEY (game_key) REFERENCES dim_game(game_key),
    FOREIGN KEY (publisher_key) REFERENCES dim_publisher(publisher_key)
);

-- bridge_game_category: Game to Category many-to-many
CREATE TABLE bridge_game_category (
    game_key INT,
    category_key INT,
    weight_factor DECIMAL(3,2) DEFAULT 1.00,
    PRIMARY KEY (game_key, category_key),
    FOREIGN KEY (game_key) REFERENCES dim_game(game_key),
    FOREIGN KEY (category_key) REFERENCES dim_category(category_key)
);

-- bridge_game_mechanism: Game to Mechanism many-to-many
CREATE TABLE bridge_game_mechanism (
    game_key INT,
    mechanism_key INT,
    weight_factor DECIMAL(3,2) DEFAULT 1.00,
    PRIMARY KEY (game_key, mechanism_key),
    FOREIGN KEY (game_key) REFERENCES dim_game(game_key),
    FOREIGN KEY (mechanism_key) REFERENCES dim_mechanism(mechanism_key)
);

-- ============================================================================
-- FACT TABLES
-- ============================================================================

-- fact_game_metrics: Primary fact table with game performance metrics
CREATE TABLE fact_game_metrics (
    fact_key BIGINT AUTO_INCREMENT PRIMARY KEY,
    game_key INT NOT NULL,
    time_key INT NOT NULL,
    
    -- Additive measures
    users_voted INT UNSIGNED DEFAULT 0,
    community_owned INT UNSIGNED DEFAULT 0,
    community_wishlist INT UNSIGNED DEFAULT 0,
    num_comments INT UNSIGNED DEFAULT 0,
    num_plays INT UNSIGNED DEFAULT 0,
    fans INT UNSIGNED DEFAULT 0,
    
    -- Semi-additive measures
    geek_rating DECIMAL(4,3),
    avg_rating DECIMAL(4,3),
    complexity_rating DECIMAL(3,2),
    
    -- Non-additive measures
    rank_position INT,
    rank_percentile DECIMAL(5,2),
    
    -- Derived measures
    engagement_score DECIMAL(8,2) GENERATED ALWAYS AS (
        (users_voted * 0.3) + (community_owned * 0.25) + (num_plays * 0.2) + 
        (fans * 0.15) + (num_comments * 0.1)
    ) STORED,
    
    popularity_index DECIMAL(6,2) GENERATED ALWAYS AS (
        CASE 
            WHEN rank_position <= 10 THEN 100
            WHEN rank_position <= 50 THEN 90
            WHEN rank_position <= 100 THEN 80
            ELSE 70
        END
    ) STORED,
    
    -- ETL metadata
    batch_id INT NOT NULL,
    load_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (game_key) REFERENCES dim_game(game_key),
    FOREIGN KEY (time_key) REFERENCES dim_time(time_key),
    
    INDEX idx_game_time (game_key, time_key),
    INDEX idx_time (time_key),
    INDEX idx_rank (rank_position),
    INDEX idx_rating (geek_rating),
    INDEX idx_batch (batch_id)
);

-- fact_game_rankings: Historical ranking tracking
CREATE TABLE fact_game_rankings (
    ranking_key BIGINT AUTO_INCREMENT PRIMARY KEY,
    game_key INT NOT NULL,
    time_key INT NOT NULL,
    
    -- Ranking measures
    rank_position INT NOT NULL,
    previous_rank INT,
    rank_change INT GENERATED ALWAYS AS (previous_rank - rank_position) STORED,
    rank_trend ENUM('Rising', 'Falling', 'Stable', 'New Entry') GENERATED ALWAYS AS (
        CASE 
            WHEN previous_rank IS NULL THEN 'New Entry'
            WHEN previous_rank - rank_position > 0 THEN 'Rising'
            WHEN previous_rank - rank_position < 0 THEN 'Falling'
            ELSE 'Stable'
        END
    ) STORED,
    
    -- Performance measures
    geek_rating DECIMAL(4,3),
    rating_change DECIMAL(4,3),
    
    -- ETL metadata
    batch_id INT NOT NULL,
    load_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (game_key) REFERENCES dim_game(game_key),
    FOREIGN KEY (time_key) REFERENCES dim_time(time_key),
    
    UNIQUE KEY uk_game_time (game_key, time_key),
    INDEX idx_rank_position (rank_position),
    INDEX idx_time (time_key),
    INDEX idx_trend (rank_trend)
);

-- fact_pricing: Game pricing across different stores
CREATE TABLE fact_pricing (
    pricing_key BIGINT AUTO_INCREMENT PRIMARY KEY,
    game_key INT NOT NULL,
    store_key INT NOT NULL,
    time_key INT NOT NULL,
    
    -- Price measures
    price DECIMAL(10,2) NOT NULL,
    currency VARCHAR(3) NOT NULL DEFAULT 'USD',
    normalized_price_usd DECIMAL(10,2),
    condition_type ENUM('New', 'Like New', 'Very Good', 'Good', 'Acceptable') DEFAULT 'New',
    
    -- Market measures
    market_price_index DECIMAL(6,2), -- Relative to average market price
    store_competitiveness DECIMAL(5,2), -- Price position vs competitors
    
    -- Source metadata
    location VARCHAR(100),
    source_url VARCHAR(500),
    
    -- ETL metadata
    batch_id INT NOT NULL,
    load_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (game_key) REFERENCES dim_game(game_key),
    FOREIGN KEY (store_key) REFERENCES dim_store(store_key),
    FOREIGN KEY (time_key) REFERENCES dim_time(time_key),
    
    INDEX idx_game_store_time (game_key, store_key, time_key),
    INDEX idx_price (price),
    INDEX idx_time (time_key)
);

-- ============================================================================
-- AGGREGATE TABLES
-- ============================================================================

-- agg_monthly_game_metrics: Pre-calculated monthly aggregations
CREATE TABLE agg_monthly_game_metrics (
    agg_key INT AUTO_INCREMENT PRIMARY KEY,
    game_key INT NOT NULL,
    year SMALLINT NOT NULL,
    month TINYINT NOT NULL,
    
    -- Aggregated measures
    avg_geek_rating DECIMAL(4,3),
    avg_rank_position DECIMAL(8,2),
    total_new_fans INT,
    total_new_plays INT,
    rating_volatility DECIMAL(4,3),
    
    -- ETL metadata
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (game_key) REFERENCES dim_game(game_key),
    UNIQUE KEY uk_game_month (game_key, year, month),
    INDEX idx_year_month (year, month)
);

-- agg_category_performance: Category-level performance metrics
CREATE TABLE agg_category_performance (
    category_key INT PRIMARY KEY,
    total_games INT DEFAULT 0,
    avg_rating DECIMAL(4,3),
    avg_complexity DECIMAL(3,2),
    total_community_owned BIGINT DEFAULT 0,
    avg_rank_position DECIMAL(8,2),
    
    -- Trending metrics
    games_added_last_year INT DEFAULT 0,
    rating_trend ENUM('Rising', 'Falling', 'Stable') DEFAULT 'Stable',
    
    -- ETL metadata
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (category_key) REFERENCES dim_category(category_key)
);

-- ============================================================================
-- ETL CONTROL TABLES
-- ============================================================================

-- etl_batch_log: ETL execution tracking
CREATE TABLE etl_batch_log (
    batch_id INT AUTO_INCREMENT PRIMARY KEY,
    batch_name VARCHAR(100) NOT NULL,
    start_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    end_time TIMESTAMP NULL,
    status ENUM('Running', 'Success', 'Failed', 'Cancelled') DEFAULT 'Running',
    records_processed INT DEFAULT 0,
    records_inserted INT DEFAULT 0,
    records_updated INT DEFAULT 0,
    records_failed INT DEFAULT 0,
    error_message TEXT,
    
    INDEX idx_batch_name (batch_name),
    INDEX idx_start_time (start_time),
    INDEX idx_status (status)
);

-- etl_data_lineage: Data lineage tracking
CREATE TABLE etl_data_lineage (
    lineage_id INT AUTO_INCREMENT PRIMARY KEY,
    batch_id INT NOT NULL,
    source_table VARCHAR(100) NOT NULL,
    target_table VARCHAR(100) NOT NULL,
    extraction_timestamp TIMESTAMP NOT NULL,
    records_extracted INT NOT NULL,
    
    FOREIGN KEY (batch_id) REFERENCES etl_batch_log(batch_id),
    INDEX idx_batch (batch_id),
    INDEX idx_source (source_table),
    INDEX idx_target (target_table)
);

-- ============================================================================
-- ANALYTICAL VIEWS
-- ============================================================================

-- v_game_performance_summary: Comprehensive game performance view
CREATE VIEW v_game_performance_summary AS
SELECT 
    dg.title,
    dg.year_published,
    dg.complexity_category,
    dg.player_range,
    dg.playtime_category,
    fgm.geek_rating,
    fgm.rank_position,
    fgm.engagement_score,
    fgm.popularity_index,
    fgm.users_voted,
    fgm.community_owned,
    fgm.fans,
    dt.year as metric_year,
    dt.month as metric_month
FROM fact_game_metrics fgm
JOIN dim_game dg ON fgm.game_key = dg.game_key AND dg.is_current = TRUE
JOIN dim_time dt ON fgm.time_key = dt.time_key;

-- v_category_trends: Category trending analysis
CREATE VIEW v_category_trends AS
SELECT 
    dc.category_name,
    acp.total_games,
    acp.avg_rating,
    acp.avg_complexity,
    acp.total_community_owned,
    acp.avg_rank_position,
    acp.rating_trend,
    acp.games_added_last_year
FROM agg_category_performance acp
JOIN dim_category dc ON acp.category_key = dc.category_key
ORDER BY acp.avg_rating DESC;

-- v_ranking_changes: Recent ranking movements
CREATE VIEW v_ranking_changes AS
SELECT 
    dg.title,
    fgr.rank_position as current_rank,
    fgr.previous_rank,
    fgr.rank_change,
    fgr.rank_trend,
    fgr.geek_rating,
    fgr.rating_change,
    dt.date_value as ranking_date
FROM fact_game_rankings fgr
JOIN dim_game dg ON fgr.game_key = dg.game_key AND dg.is_current = TRUE
JOIN dim_time dt ON fgr.time_key = dt.time_key
WHERE dt.date_value >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
ORDER BY ABS(fgr.rank_change) DESC;

-- ============================================================================
-- SAMPLE DATA POPULATION
-- ============================================================================

-- Populate time dimension with next 5 years of dates
DELIMITER //
CREATE PROCEDURE PopulateTimeDimension()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE current_date_var DATE DEFAULT '2023-01-01';
    DECLARE end_date_var DATE DEFAULT '2030-12-31';
    
    WHILE current_date_var <= end_date_var DO
        INSERT IGNORE INTO dim_time (
            time_key,
            date_value,
            year,
            quarter,
            month,
            month_name,
            week_of_year,
            day_of_month,
            day_of_week,
            day_name,
            is_weekend,
            fiscal_year,
            fiscal_quarter
        ) VALUES (
            DATE_FORMAT(current_date_var, '%Y%m%d'),
            current_date_var,
            YEAR(current_date_var),
            QUARTER(current_date_var),
            MONTH(current_date_var),
            MONTHNAME(current_date_var),
            WEEK(current_date_var),
            DAY(current_date_var),
            DAYOFWEEK(current_date_var),
            DAYNAME(current_date_var),
            DAYOFWEEK(current_date_var) IN (1, 7),
            CASE 
                WHEN MONTH(current_date_var) >= 7 THEN YEAR(current_date_var) + 1
                ELSE YEAR(current_date_var)
            END,
            CASE 
                WHEN MONTH(current_date_var) BETWEEN 7 AND 9 THEN 1
                WHEN MONTH(current_date_var) BETWEEN 10 AND 12 THEN 2
                WHEN MONTH(current_date_var) BETWEEN 1 AND 3 THEN 3
                ELSE 4
            END
        );
        
        SET current_date_var = DATE_ADD(current_date_var, INTERVAL 1 DAY);
    END WHILE;
END //
DELIMITER ;

-- Execute time dimension population
CALL PopulateTimeDimension();

-- ============================================================================
-- INDEXES FOR PERFORMANCE
-- ============================================================================

-- Additional performance indexes
CREATE INDEX idx_fact_metrics_composite ON fact_game_metrics(time_key, rank_position, geek_rating);
CREATE INDEX idx_fact_rankings_composite ON fact_game_rankings(time_key, rank_position, rank_trend);
CREATE INDEX idx_fact_pricing_composite ON fact_pricing(time_key, normalized_price_usd);

-- Full-text search indexes
ALTER TABLE dim_game ADD FULLTEXT(title);
ALTER TABLE dim_designer ADD FULLTEXT(designer_name);
ALTER TABLE dim_publisher ADD FULLTEXT(publisher_name);

-- ============================================================================
-- END OF SCHEMA
-- ============================================================================

SHOW TABLES;
SELECT 'Data Warehouse schema created successfully!' as Status;
