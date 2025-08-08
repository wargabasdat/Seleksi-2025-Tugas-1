CREATE DATABASE IF NOT EXISTS game_revenue;

USE game_revenue;

-- create games table
CREATE TABLE Games (
    game_id INT AUTO_INCREMENT PRIMARY KEY,
    game_name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- create regions table
CREATE TABLE Regions (
    region_id INT AUTO_INCREMENT PRIMARY KEY,
    region_name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- create revenue table
CREATE TABLE Revenue (
    revenue_id INT AUTO_INCREMENT PRIMARY KEY,
    in_id INT NOT NULL,
    month VARCHAR(255) NOT NULL,
    revenue_text VARCHAR(50),
    revenue_value DECIMAL(15,2) DEFAULT 0.00,
    rank_position INT,
    trend_direction ENUM('up', 'down', 'stable', 'new') DEFAULT 'stable',
    trend_value INT,
    currency VARCHAR(3) DEFAULT 'USD',
    scraped_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (in_id) REFERENCES In(in_id) ON DELETE CASCADE,
    UNIQUE KEY unique_game_region_month (in_id, month)
);

CREATE TABLE In (
    in_id INT AUTO_INCREMENT PRIMARY KEY,
    game_id INT NOT NULL,
    region_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY unique_game_region (game_id, region_id),
    FOREIGN KEY (game_id) REFERENCES games(game_id) ON DELETE CASCADE,
    FOREIGN KEY (region_id) REFERENCES regions(region_id) ON DELETE CASCADE,
);