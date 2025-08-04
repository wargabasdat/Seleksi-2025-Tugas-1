
import json
import os
import mysql.connector
from mysql.connector import Error

# Database configuration
DB_CONFIG = {
    'host': 'localhost',
    'user': 'root',
    'password': '12345678',
    'database': 'cake_recipes_db'
}

# JSON files path
DATA_PATH = '../../Data Scraping/data'

def get_db_connection():
    """Create and return database connection"""
    try:
        conn = mysql.connector.connect(**DB_CONFIG)
        return conn
    except Error as e:
        print(f"Error connecting to MySQL: {e}")
        return None

def clear_existing_data(cursor):
    """Clear existing data from all tables in correct order"""
    try:
        cursor.execute("SET FOREIGN_KEY_CHECKS=0;")
        # Clear in reverse dependency order
        tables = ['instructions', 'ingredients', 'recipes', 'categories']
        for table in tables:
            cursor.execute(f"DELETE FROM {table};")
            print(f"Cleared {table} table")
        cursor.execute("SET FOREIGN_KEY_CHECKS=1;")
        print("All existing data cleared successfully")
    except Error as e:
        print(f"Error clearing data: {e}")
        raise

def load_json_file(filename):
    """Load and return JSON data from file"""
    file_path = os.path.join(DATA_PATH, filename)
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            return json.load(f)
    except FileNotFoundError:
        print(f"File not found: {file_path}")
        return []
    except json.JSONDecodeError as e:
        print(f"Error parsing JSON file {filename}: {e}")
        return []

def insert_categories(cursor):
    """Insert categories data"""
    categories = load_json_file('categories.json')
    if not categories:
        return
    
    # Use INSERT IGNORE to skip duplicates
    query = """
        INSERT IGNORE INTO categories (category_id, name, description)
        VALUES (%s, %s, %s)
    """
    
    try:
        inserted_count = 0
        for cat in categories:
            cursor.execute(query, (
                cat.get('category_id'),
                cat.get('name'),
                cat.get('description')
            ))
            if cursor.rowcount > 0:
                inserted_count += 1
                
        skipped = len(categories) - inserted_count
        print(f"Inserted {inserted_count} categories" + 
              (f" (skipped {skipped} duplicates)" if skipped > 0 else ""))
    except Error as e:
        print(f"Error inserting categories: {e}")
        raise

def insert_recipes(cursor):
    """Insert recipes data"""
    recipes = load_json_file('recipes.json')
    if not recipes:
        return
    
    # Use INSERT IGNORE to skip duplicates
    query = """
        INSERT IGNORE INTO recipes (
            recipe_id, title, description, author, url, published_date,
            image_url, prep_time, cook_time, chill_time, total_time,
            servings, scraped_at, category, ingredients_count, instructions_count
        ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
    """
    
    try:
        inserted_count = 0
        for recipe in recipes:
            # Validate category exists
            category_query = "SELECT name FROM categories WHERE name = %s LIMIT 1"
            cursor.execute(category_query, (recipe.get('category'),))
            result = cursor.fetchone()
            category = result[0] if result else recipe.get('category')
            
            cursor.execute(query, (
                recipe.get('recipe_id'),
                recipe.get('title'),
                recipe.get('description'),
                recipe.get('author'),
                recipe.get('url'),
                recipe.get('published_date'),
                recipe.get('image_url'),
                recipe.get('prep_time'),
                recipe.get('cook_time'),
                recipe.get('chill_time'),
                recipe.get('total_time'),
                recipe.get('servings'),
                recipe.get('scraped_at'),
                category,
                recipe.get('ingredients_count'),
                recipe.get('instructions_count')
            ))
            if cursor.rowcount > 0:
                inserted_count += 1
                
        skipped = len(recipes) - inserted_count
        print(f"Inserted {inserted_count} recipes" + 
              (f" (skipped {skipped} duplicates)" if skipped > 0 else ""))
    except Error as e:
        print(f"Error inserting recipes: {e}")
        raise

def insert_ingredients(cursor):
    """Insert ingredients data with composite primary key handling"""
    ingredients = load_json_file('ingredients.json')
    if not ingredients:
        return
    
    # Use INSERT IGNORE to skip duplicates (ingredient_id + recipe_id combination)
    query = """
        INSERT IGNORE INTO ingredients (ingredient_id, recipe_id, text, quantity, unit, name)
        VALUES (%s, %s, %s, %s, %s, %s)
    """
    
    try:
        inserted_count = 0
        duplicate_combinations = []
        
        for ingredient in ingredients:
            ingredient_id = ingredient.get('ingredient_id')
            recipe_id = ingredient.get('recipe_id')
            
            cursor.execute(query, (
                ingredient_id,
                recipe_id,
                ingredient.get('text'),
                ingredient.get('quantity'),
                ingredient.get('unit'),
                ingredient.get('name')
            ))
            
            if cursor.rowcount > 0:
                inserted_count += 1
            else:
                duplicate_combinations.append(f"({ingredient_id}, {recipe_id})")
        
        skipped = len(ingredients) - inserted_count
        print(f"Inserted {inserted_count} ingredients" + 
              (f" (skipped {skipped} duplicate combinations)" if skipped > 0 else ""))
        
        if duplicate_combinations and len(duplicate_combinations) <= 10:
            print(f"  Duplicate (ingredient_id, recipe_id): {', '.join(duplicate_combinations[:10])}")
        elif len(duplicate_combinations) > 10:
            print(f"  Duplicate (ingredient_id, recipe_id): {', '.join(duplicate_combinations[:10])}... and {len(duplicate_combinations)-10} more")
            
    except Error as e:
        print(f"Error inserting ingredients: {e}")
        raise

def insert_instructions(cursor):
    """Insert instructions data"""
    instructions = load_json_file('instructions.json')
    if not instructions:
        return
    
    # Use INSERT IGNORE to skip duplicates
    query = """
        INSERT IGNORE INTO instructions (instruction_id, recipe_id, step_number, text)
        VALUES (%s, %s, %s, %s)
    """
    
    try:
        inserted_count = 0
        for instruction in instructions:
            cursor.execute(query, (
                instruction.get('instruction_id'),
                instruction.get('recipe_id'),
                instruction.get('step_number'),
                instruction.get('text')
            ))
            if cursor.rowcount > 0:
                inserted_count += 1
                
        skipped = len(instructions) - inserted_count
        print(f"Inserted {inserted_count} instructions" + 
              (f" (skipped {skipped} duplicates)" if skipped > 0 else ""))
    except Error as e:
        print(f"Error inserting instructions: {e}")
        raise

def main():
    """Main function to execute data import"""
    conn = get_db_connection()
    if not conn:
        return
    
    cursor = conn.cursor()
    
    try:
        print("Starting data import process...")
        
        # Clear existing data
        clear_existing_data(cursor)
        
        # Insert data in correct order 
        insert_categories(cursor)
        conn.commit()
        
        insert_recipes(cursor)
        conn.commit()
        
        insert_ingredients(cursor)
        conn.commit()
        
        insert_instructions(cursor)
        conn.commit()
        
        print("All data imported successfully!")
        
    except Exception as e:
        print(f"Error during import: {e}")
        conn.rollback()
        
    finally:
        cursor.close()
        conn.close()
        print("Database connection closed.")

if __name__ == "__main__":
    main()