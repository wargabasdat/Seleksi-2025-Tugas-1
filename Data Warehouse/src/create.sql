-- Membuat database data warehouse
CREATE DATABASE IF NOT EXISTS cake_recipes_dw;
USE cake_recipes_dw;

-- Drop tables jika sudah ada (urutan terbalik karena foreign key constraints)
DROP TABLE IF EXISTS dim_ingredients;
DROP TABLE IF EXISTS fact_recipes;
DROP TABLE IF EXISTS dim_categories;
DROP TABLE IF EXISTS dim_recipes;

-- Tabel dimensi categories
CREATE TABLE dim_categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tabel dimensi recipes
CREATE TABLE dim_recipes (
    recipe_id INT PRIMARY KEY,
    url TEXT,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    scraped_at VARCHAR(128),
    difficulty_level VARCHAR(50), -- Field baru yang terlihat di diagram
    author VARCHAR(100),
    image_url TEXT,
    published_date VARCHAR(128),
    ingredients_count INT,
    instructions_count INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tabel fact recipes (fact table utama)
CREATE TABLE fact_recipes (
    recipe_id INT PRIMARY KEY,
    category VARCHAR(100),
    chill_time INT,
    prep_time INT,
    cook_time INT,
    servings INT,
    total_time INT,
    ingredients_count INT,
    instructions_count INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (recipe_id) REFERENCES dim_recipes(recipe_id) ON DELETE CASCADE,
    FOREIGN KEY (category) REFERENCES dim_categories(name) ON UPDATE CASCADE
);

-- Tabel dimensi ingredients
CREATE TABLE dim_ingredients (
    ingredient_id INT,
    recipe_id INT,
    quantity decimal(10, 2),
    unit VARCHAR(50),
    name TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (ingredient_id, recipe_id),
    FOREIGN KEY (recipe_id) REFERENCES dim_recipes(recipe_id) ON DELETE CASCADE
);

-- Index untuk performa yang lebih baik
CREATE INDEX idx_fact_recipes_category ON fact_recipes(category);
CREATE INDEX idx_fact_recipes_prep_time ON fact_recipes(prep_time);
CREATE INDEX idx_fact_recipes_cook_time ON fact_recipes(cook_time);
CREATE INDEX idx_fact_recipes_total_time ON fact_recipes(total_time);
CREATE INDEX idx_dim_ingredients_name ON dim_ingredients(name(255));
CREATE INDEX idx_dim_recipes_title ON dim_recipes(title);
CREATE INDEX idx_dim_recipes_author ON dim_recipes(author);