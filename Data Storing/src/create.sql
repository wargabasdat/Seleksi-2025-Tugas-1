-- Membuat database 
CREATE DATABASE IF NOT EXISTS cake_recipes_db;
USE cake_recipes_db;
DROP TABLE IF EXISTS instructions;
DROP TABLE IF EXISTS ingredients;
DROP TABLE IF EXISTS recipes;
DROP TABLE IF EXISTS categories;
-- Tabel kategori
CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL unique, 
    description TEXT
);

-- Tabel resep
CREATE TABLE recipes (
    recipe_id INT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    author VARCHAR(100),
    url TEXT,
    published_date varchar(128),
    image_url TEXT,
    prep_time INT,
    cook_time INT,
    chill_time INT,
    total_time INT,
    servings INT,
    scraped_at varchar(128),
    ingredients_count INT,
    instructions_count INT,
    category VARCHAR(100),
    FOREIGN KEY (category) REFERENCES categories(name)
);

-- Tabel bahan
CREATE TABLE ingredients (
    ingredient_id INT,
    recipe_id INT,
    PRIMARY KEY (ingredient_id, recipe_id),
    text TEXT,
    quantity INT,
    unit VARCHAR(50),
    name TEXT,
    FOREIGN KEY (recipe_id) REFERENCES recipes(recipe_id) ON DELETE CASCADE
);

-- Tabel instruksi
CREATE TABLE instructions (
    instruction_id INT PRIMARY KEY,
    recipe_id INT,
    step_number INT,
    text TEXT,
    FOREIGN KEY (recipe_id) REFERENCES recipes(recipe_id) ON DELETE CASCADE
);
