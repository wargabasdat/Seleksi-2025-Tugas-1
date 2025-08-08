import mysql.connector
import pandas as pd
from datetime import datetime
import logging
from typing import Optional, Dict, Any

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

class CakeRecipeETL:
    def __init__(self, source_config: Dict[str, Any], target_config: Dict[str, Any]):
        self.source_config = source_config
        self.target_config = target_config
        self.source_conn = None
        self.target_conn = None
    
    def connect_databases(self):
        try:
            self.source_conn = mysql.connector.connect(**self.source_config)
            self.target_conn = mysql.connector.connect(**self.target_config)
            logger.info("Database connections established successfully")
        except Exception as e:
            logger.error(f"Failed to connect to databases: {e}")
            raise
    
    def close_connections(self):
        if self.source_conn:
            self.source_conn.close()
        if self.target_conn:
            self.target_conn.close()
        logger.info("Database connections closed")
    
    def get_table_schema(self, table_name: str, connection) -> Dict[str, str]:
        cursor = connection.cursor()
        cursor.execute(f"DESCRIBE {table_name}")
        schema = {row[0]: row[1] for row in cursor.fetchall()}
        cursor.close()
        return schema
    
    def diagnose_schema_mismatch(self, table_name: str, df: pd.DataFrame):
        try:
            target_schema = self.get_table_schema(table_name, self.target_conn)
            df_columns = set(df.columns)
            target_columns = set(target_schema.keys())
            
            logger.info(f"=== SCHEMA DIAGNOSIS for {table_name} ===")
            logger.info(f"DataFrame columns: {sorted(df_columns)}")
            logger.info(f"Target table columns: {sorted(target_columns)}")
            
            if len(df.columns) != len(set(df.columns)):
                duplicates = [col for col in df.columns if list(df.columns).count(col) > 1]
                logger.error(f"DUPLICATE COLUMNS FOUND: {set(duplicates)}")
            
        except Exception as e:
            logger.error(f"Failed to diagnose schema for {table_name}: {e}")
    
    def extract_categories(self) -> pd.DataFrame:
        query = "SELECT * FROM categories"
        df = pd.read_sql(query, self.source_conn)
        logger.info(f"Extracted {len(df)} categories")
        return df
    
    def extract_recipes(self) -> pd.DataFrame:
        query = "SELECT * FROM recipes"
        df = pd.read_sql(query, self.source_conn)
        logger.info(f"Extracted {len(df)} recipes")
        return df
    
    def extract_ingredients(self) -> pd.DataFrame:
        query = "SELECT * FROM ingredients"
        df = pd.read_sql(query, self.source_conn)
        logger.info(f"Extracted {len(df)} ingredients")
        return df
    
    def transform_categories(self, df: pd.DataFrame) -> pd.DataFrame:
        target_schema = self.get_table_schema('dim_categories', self.target_conn)
        
        column_mapping = {}
        if 'category_id' in df.columns:
            column_mapping['category_id'] = 'category_id'
        if 'name' in df.columns:
            column_mapping['name'] = 'name'
        if 'description' in df.columns:
            column_mapping['description'] = 'description'
        
        transformed = df.rename(columns=column_mapping)
        
        target_columns = list(target_schema.keys())
        existing_columns = [col for col in target_columns if col in transformed.columns]
        transformed = transformed[existing_columns]
        
        for col in target_columns:
            if col not in transformed.columns:
                if col in ['created_at', 'updated_at']:
                    transformed[col] = datetime.now()
                else:
                    transformed[col] = ''
        
        transformed = transformed.fillna('')
        logger.info(f"Transformed {len(transformed)} categories")
        return transformed
    
    def transform_recipes_dim(self, df: pd.DataFrame) -> pd.DataFrame:
        target_schema = self.get_table_schema('dim_recipes', self.target_conn)
        
        potential_columns = [
            'recipe_id', 'url', 'title', 'description', 'scraped_at', 
            'author', 'image_url', 'published_date', 'ingredients_count', 
            'instructions_count'
        ]
        
        available_columns = [col for col in potential_columns if col in df.columns]
        transformed = df[available_columns].copy()
        
        if 'difficulty_level' in target_schema:
            transformed['difficulty_level'] = 'Medium'
        
        target_columns = list(target_schema.keys())
        existing_columns = [col for col in target_columns if col in transformed.columns]
        transformed = transformed[existing_columns]
        
        for col in target_columns:
            if col not in transformed.columns:
                if col in ['ingredients_count', 'instructions_count']:
                    transformed[col] = 0
                elif col in ['created_at', 'updated_at']:
                    transformed[col] = datetime.now()
                else:
                    transformed[col] = ''
        
        transformed = transformed.fillna('')
        logger.info(f"Transformed {len(transformed)} recipes for dimension table")
        return transformed
    
    def transform_recipes_fact(self, df: pd.DataFrame) -> pd.DataFrame:
        target_schema = self.get_table_schema('fact_recipes', self.target_conn)
        
        potential_columns = [
            'recipe_id', 'category', 'chill_time', 'prep_time', 
            'cook_time', 'servings', 'total_time', 'ingredients_count', 
            'instructions_count'
        ]
        
        available_columns = [col for col in potential_columns if col in df.columns]
        transformed = df[available_columns].copy()
        
        target_columns = list(target_schema.keys())
        existing_columns = [col for col in target_columns if col in transformed.columns]
        transformed = transformed[existing_columns]
        
        for col in target_columns:
            if col not in transformed.columns:
                if col in ['chill_time', 'prep_time', 'cook_time', 'servings', 
                          'total_time', 'ingredients_count', 'instructions_count']:
                    transformed[col] = 0
                elif col == 'category':
                    transformed[col] = 'Uncategorized'
                elif col in ['created_at', 'updated_at']:
                    transformed[col] = datetime.now()
                else:
                    transformed[col] = ''
        
        numeric_columns = ['chill_time', 'prep_time', 'cook_time', 'servings', 
                          'total_time', 'ingredients_count', 'instructions_count']
        for col in numeric_columns:
            if col in transformed.columns:
                transformed[col] = transformed[col].fillna(0)
        
        if 'category' in transformed.columns:
            transformed['category'] = transformed['category'].fillna('Uncategorized')
        
        logger.info(f"Transformed {len(transformed)} recipes for fact table")
        return transformed
    
    def parse_quantity_from_text(self, text: str) -> tuple:
        import re
        
        if pd.isna(text) or text == '':
            return 0, ''
        
        text = str(text).strip()
        
        fraction_map = {
            '½': 0.5, '1/2': 0.5,
            '⅓': 0.333, '1/3': 0.333,
            '⅔': 0.667, '2/3': 0.667,
            '¼': 0.25, '1/4': 0.25,
            '¾': 0.75, '3/4': 0.75,
            '⅛': 0.125, '1/8': 0.125,
            '⅜': 0.375, '3/8': 0.375,
            '⅝': 0.625, '5/8': 0.625,
            '⅞': 0.875, '7/8': 0.875
        }
        
        pattern = r'^(\d+)?\s*([½⅓⅔¼¾⅛⅜⅝⅞]|\d+/\d+)?\s*([a-zA-Z]+)?'
        match = re.search(pattern, text)
        
        if not match:
            return 0, ''
        
        whole_num = match.group(1)
        fraction = match.group(2)  
        unit = match.group(3)
        
        total_quantity = 0
        
        if whole_num:
            total_quantity += float(whole_num)
        
        if fraction:
            if fraction in fraction_map:
                total_quantity += fraction_map[fraction]
            elif '/' in fraction:
                try:
                    parts = fraction.split('/')
                    total_quantity += float(parts[0]) / float(parts[1])
                except:
                    pass
        
        if unit:
            unit = unit.lower()
            unit_map = {
                'cups': 'cup', 'c': 'cup',
                'tablespoons': 'tbsp', 'tablespoon': 'tbsp', 'tbs': 'tbsp',
                'teaspoons': 'tsp', 'teaspoon': 'tsp',
                'pounds': 'lb', 'pound': 'lb', 'lbs': 'lb',
                'ounces': 'oz', 'ounce': 'oz',
                'grams': 'g', 'gram': 'g',
                'milliliters': 'ml', 'milliliter': 'ml',
                'liters': 'l', 'liter': 'l'
            }
            unit = unit_map.get(unit, unit)
        else:
            unit = ''
        
        return total_quantity, unit

    def parse_ingredient_name_from_text(self, text: str) -> str:
        import re
        
        if pd.isna(text) or text == '':
            return ''
        
        text = str(text).strip()
        
        quantity_patterns = [
            r'^\s*\d+(\.\d+)?\s*',
            r'^\s*\d+\s+\d+/\d+\s*',
            r'^\s*\d+/\d+\s*',
            r'^\s*[½⅓⅔¼¾⅛⅜⅝⅞]\s*',
        ]
        
        cleaned_text = text
        for pattern in quantity_patterns:
            cleaned_text = re.sub(pattern, '', cleaned_text).strip()
        
        unit_patterns = [
            r'^\s*(cups?|cup|c)\s+',
            r'^\s*(tablespoons?|tbsp|tbs)\s+',
            r'^\s*(teaspoons?|tsp)\s+',
            r'^\s*(pounds?|lbs?|lb)\s+',
            r'^\s*(ounces?|oz)\s+',
            r'^\s*(grams?|g)\s+',
            r'^\s*(milliliters?|ml)\s+',
            r'^\s*(liters?|l)\s+',
            r'^\s*(pieces?|pcs?)\s+',
            r'^\s*(slices?|slice)\s+',
            r'^\s*(cloves?|clove)\s+',
            r'^\s*(stalks?|stalk)\s+',
            r'^\s*(bunches?|bunch)\s+',
            r'^\s*(packages?|pkg)\s+',
            r'^\s*(containers?|container)\s+',
            r'^\s*(cans?|can)\s+',
            r'^\s*(jars?|jar)\s+',
            r'^\s*(bottles?|bottle)\s+',
            r'^\s*(bags?|bag)\s+',
            r'^\s*(boxes?|box)\s+'
        ]
        
        for pattern in unit_patterns:
            cleaned_text = re.sub(pattern, '', cleaned_text, flags=re.IGNORECASE).strip()
        
        article_patterns = [
            r'^\s*[aæ]\s+',
            r'^\s*?\s+',
            r'^\s*a\s+',
            r'^\s*an\s+',
            r'^\s*the\s+',
            r'^\s*of\s+',
            r'^\s*,\s*',
            r'^\s*-\s*',
            r'^\s*\+\s*',
        ]
        
        for pattern in article_patterns:
            cleaned_text = re.sub(pattern, '', cleaned_text, flags=re.IGNORECASE).strip()
        
        size_pattern = r'\s*\(\s*\d+\s*(ounce|oz|gram|g|lb|pound|ml|liter|l)\s*\)\s*'
        cleaned_text = re.sub(size_pattern, '', cleaned_text, flags=re.IGNORECASE).strip()
        
        cleaned_text = re.sub(r',\s*(undrained|drained|chopped|sliced|etc\.?).*$', '', cleaned_text, flags=re.IGNORECASE)
        
        if not cleaned_text:
            cleaned_text = text
            
        cleaned_text = ' '.join(cleaned_text.split())
        
        if cleaned_text:
            cleaned_text = cleaned_text.lower()
            cleaned_text = cleaned_text.replace('-', ' ')
            cleaned_text = ' '.join(cleaned_text.split())
        
        return cleaned_text

    def normalize_fraction_symbols(self, text):
        if pd.isna(text) or text == '':
            return ''
        
        text = str(text)
        
        replacements = {
            '½': '1/2',
            '⅓': '1/3',
            '¼': '1/4',
            '⅔': '2/3',
            '¾': '3/4',
            '⅛': '1/8',
            '⅜': '3/8',
            '⅝': '5/8',
            '⅞': '7/8',
            '⅕': '1/5',
            '⅖': '2/5',
            '⅗': '3/5',
            '⅘': '4/5',
            '⅙': '1/6',
            '⅚': '5/6',
            'Ω': '2/3',
            'æ': '3/4',
            'Öì': '1/3',
            'º': '1/4',
            'Öî': '2/3',
            'Ö': '1/5',
            'Öí': '4/5',
            'Öð': '1/6',
            '¦': '1/2',
            '§': '1/3',
            '©': '1/4',
            'ª': '2/3',
            '«': '3/4',
            '¬': '1/8',
            '®': '3/8',
            '¯': '5/8',
            '°': '7/8',
            '±': '1/5',
            '²': '2/5',
            '³': '3/5',
            '´': '4/5',
            'µ': '1/6',
            '¶': '5/6',
            '?': '',
            '¿': '',
            '¡': '',
            '‰': '',
            '‱': '',
            '¢': '',
            '£': '',
            '¥': '',
            '€': '',
            '¤': '',
            '×': '',
            '÷': '',
            '±': '',
            '≤': '',
            '≥': '',
            '≠': '',
            '≈': '',
            'þ': '',
            'ÿ': '',
            'ß': '',
            'à': '',
            'á': '',
            'â': '',
            'ã': '',
            'ä': '',
            'å': '',
            'ç': '',
            'è': '',
            'é': '',
            'ê': '',
            'ë': '',
            'ì': '',
            'í': '',
            'î': '',
            'ï': '',
            'ð': '',
            'ñ': '',
            'ò': '',
            'ó': '',
            'ô': '',
            'õ': '',
            'ö': '',
            'ø': '',
            'ù': '',
            'ú': '',
            'û': '',
            'ü': '',
            'ý': '',
        }
        
        for old, new in replacements.items():
            text = text.replace(old, new)
        
        return text

    def clean_ingredient_name(self, text: str) -> str:
        import re
        
        if pd.isna(text) or text == '':
            return ''
        
        text = str(text).strip()
        text = self.normalize_fraction_symbols(text)
        text = re.sub(r'[^\x00-\x7F]+', '', text)
        
        quantity_patterns = [
            r'^\s*\d+(\.\d+)?\s*',
            r'^\s*\d+\s+\d+/\d+\s*',
            r'^\s*\d+/\d+\s*',
            r'^\s*/\d+\s*',
            r'^\s*\d+/\s*',
        ]
        
        for _ in range(3):
            original_text = text
            for pattern in quantity_patterns:
                text = re.sub(pattern, '', text).strip()
            if text == original_text:
                break
        
        unit_patterns = [
            r'^\s*(cups?|cup|c)\s+',
            r'^\s*(tablespoons?|tbsp|tbs|tablespoon)\s+',
            r'^\s*(teaspoons?|tsp|teaspoon)\s+',
            r'^\s*(pounds?|lbs?|lb|pound)\s+',
            r'^\s*(ounces?|oz|ounce)\s+',
            r'^\s*(grams?|g|gram)\s+',
            r'^\s*(kilograms?|kg|kilogram)\s+',
            r'^\s*(milliliters?|ml|milliliter)\s+',
            r'^\s*(liters?|l|liter)\s+',
            r'^\s*(pints?|pt|pint)\s+',
            r'^\s*(quarts?|qt|quart)\s+',
            r'^\s*(gallons?|gal|gallon)\s+',
            r'^\s*(pieces?|pcs?|piece)\s+',
            r'^\s*(slices?|slice)\s+',
            r'^\s*(cloves?|clove)\s+',
            r'^\s*(stalks?|stalk)\s+',
            r'^\s*(bunches?|bunch)\s+',
            r'^\s*(packages?|pkg|package)\s+',
            r'^\s*(containers?|container)\s+',
            r'^\s*(cans?|can)\s+',
            r'^\s*(jars?|jar)\s+',
            r'^\s*(bottles?|bottle)\s+',
            r'^\s*(bags?|bag)\s+',
            r'^\s*(boxes?|box)\s+'
        ]
        
        for pattern in unit_patterns:
            text = re.sub(pattern, '', text, flags=re.IGNORECASE).strip()
        
        article_patterns = [
            r'^\s*a\s+',
            r'^\s*an\s+',
            r'^\s*the\s+',
            r'^\s*of\s+',
            r'^\s*,\s*',
            r'^\s*-\s*',
            r'^\s*\+\s*',
            r'^\s*/\s*',
            r'^\s*\d+\s*',
        ]
        
        for _ in range(2):
            original_text = text
            for pattern in article_patterns:
                text = re.sub(pattern, '', text, flags=re.IGNORECASE).strip()
            if text == original_text:
                break
        
        size_pattern = r'\s*\(\s*\d+\s*(ounce|oz|gram|g|lb|pound|ml|liter|l)\s*\)\s*'
        text = re.sub(size_pattern, '', text, flags=re.IGNORECASE).strip()
        
        text = re.sub(r',\s*(undrained|drained|chopped|sliced|etc\.?).*$', '', text, flags=re.IGNORECASE)
        text = ' '.join(text.split())
        
        if text:
            text = text.lower()
            text = text.replace('-', ' ')
            text = ' '.join(text.split())
            text = re.sub(r'^\s*[0-9/]\s*', '', text).strip()
        
        problematic_patterns = [
            r'^\s*/\d*\s*',
            r'^\s*\d+\s*',
            r'^\s*[^a-zA-Z]\s*',
        ]
        
        for pattern in problematic_patterns:
            text = re.sub(pattern, '', text).strip()
        
        if not text or not text.strip():
            return 'unknown ingredient'
            
        return text

    def parse_existing_quantity(self, quantity_str) -> float:
        if pd.isna(quantity_str):
            return 0
        
        quantity_str = str(quantity_str).strip()
        if quantity_str == '' or quantity_str == '0':
            return 0
        
        quantity_str = self.normalize_fraction_symbols(quantity_str)
            
        try:
            return float(quantity_str)
        except:
            pass
        
        import re
        
        fraction_map = {
            '½': 0.5, '1/2': 0.5,
            '⅓': 0.333, '1/3': 0.333,
            '⅔': 0.667, '2/3': 0.667,
            '¼': 0.25, '1/4': 0.25,
            '¾': 0.75, '3/4': 0.75,
            '⅛': 0.125, '1/8': 0.125,
            '⅜': 0.375, '3/8': 0.375,
            '⅝': 0.625, '5/8': 0.625,
            '⅞': 0.875, '7/8': 0.875
        }
        
        mixed_pattern = r'^(\d+)\s+(\d+/\d+|[½⅓⅔¼¾⅛⅜⅝⅞])'
        match = re.match(mixed_pattern, quantity_str)
        
        if match:
            whole = int(match.group(1))
            fraction_part = match.group(2)
            
            if fraction_part in fraction_map:
                return whole + fraction_map[fraction_part]
            elif '/' in fraction_part:
                try:
                    parts = fraction_part.split('/')
                    return whole + (float(parts[0]) / float(parts[1]))
                except:
                    return whole
            return whole
        
        if quantity_str in fraction_map:
            return fraction_map[quantity_str]
        
        if '/' in quantity_str:
            try:
                parts = quantity_str.split('/')
                return float(parts[0]) / float(parts[1])
            except:
                return 0
        
        return 0

    def transform_ingredients(self, df: pd.DataFrame) -> pd.DataFrame:
        target_schema = self.get_table_schema('dim_ingredients', self.target_conn)
        transformed = df.copy()
        
        if 'quantity' in transformed.columns:
            transformed['quantity'] = transformed['quantity'].apply(self.parse_existing_quantity)
        
        if 'name' in transformed.columns:
            ingredient_names = transformed['name'].apply(self.clean_ingredient_name)
        elif 'text' in transformed.columns:
            ingredient_names = transformed['text'].apply(self.clean_ingredient_name)
        else:
            ingredient_names = pd.Series(['unknown ingredient'] * len(transformed))

        target_columns = list(target_schema.keys())
        final_df = pd.DataFrame()
        
        if 'ingredient_id' in transformed.columns and 'ingredient_id' in target_columns:
            final_df['ingredient_id'] = transformed['ingredient_id']
        
        if 'recipe_id' in transformed.columns and 'recipe_id' in target_columns:
            final_df['recipe_id'] = transformed['recipe_id']
        
        if 'quantity' in transformed.columns and 'quantity' in target_columns:
            final_df['quantity'] = transformed['quantity']
        
        if 'unit' in transformed.columns and 'unit' in target_columns:
            final_df['unit'] = transformed['unit']
        
        if 'name' in target_columns:
            final_df['name'] = ingredient_names
        
        for col in target_columns:
            if col not in final_df.columns:
                if col == 'quantity':
                    final_df[col] = 0
                elif col in ['created_at', 'updated_at']:
                    final_df[col] = datetime.now()
                else:
                    final_df[col] = ''
        
        final_df = final_df[target_columns]
        
        if 'quantity' in final_df.columns:
            final_df['quantity'] = pd.to_numeric(final_df['quantity'], errors='coerce').fillna(0)
            final_df['quantity'] = final_df['quantity'].round(3)
        
        if 'unit' in final_df.columns:
            final_df['unit'] = final_df['unit'].fillna('').astype(str)
        if 'name' in final_df.columns:
            final_df['name'] = final_df['name'].fillna('unknown ingredient').astype(str)
        
        logger.info(f"Transformed {len(final_df)} ingredients")
        return final_df
        
    def clear_all_tables(self):
        try:
            cursor = self.target_conn.cursor()
            cursor.execute("SET FOREIGN_KEY_CHECKS = 0")
            
            tables_to_clear = ['fact_recipes', 'dim_ingredients', 'dim_recipes', 'dim_categories']
            
            for table in tables_to_clear:
                try:
                    cursor.execute(f"DELETE FROM {table}")
                except Exception as e:
                    logger.warning(f"Could not clear {table}: {e}")
            
            cursor.execute("SET FOREIGN_KEY_CHECKS = 1")
            self.target_conn.commit()
            cursor.close()
            logger.info("Successfully cleared all tables")
            
        except Exception as e:
            logger.error(f"Failed to clear tables: {e}")
            self.target_conn.rollback()
            raise

    def load_to_warehouse(self, table_name: str, df: pd.DataFrame):
        try:
            self.diagnose_schema_mismatch(table_name, df)
            
            cursor = self.target_conn.cursor()
            
            columns = ', '.join(df.columns)
            placeholders = ', '.join(['%s'] * len(df.columns))
            insert_query = f"INSERT INTO {table_name} ({columns}) VALUES ({placeholders})"
            
            data_tuples = [tuple(row) for row in df.itertuples(index=False, name=None)]
            cursor.executemany(insert_query, data_tuples)
            
            self.target_conn.commit()
            cursor.close()
            
            logger.info(f"Successfully loaded {len(df)} rows to {table_name}")
            
        except Exception as e:
            logger.error(f"Failed to load data to {table_name}: {e}")
            self.target_conn.rollback()
            raise
    
    def update_difficulty_levels(self):
        try:
            cursor = self.target_conn.cursor()
            
            cursor.execute("SHOW COLUMNS FROM dim_recipes LIKE 'difficulty_level'")
            has_difficulty = cursor.fetchone() is not None
            
            cursor.execute("SHOW COLUMNS FROM fact_recipes LIKE 'total_time'")
            has_total_time = cursor.fetchone() is not None
            
            if has_difficulty and has_total_time:
                update_query = """
                UPDATE dim_recipes dr
                JOIN fact_recipes fr ON dr.recipe_id = fr.recipe_id
                SET dr.difficulty_level = CASE 
                    WHEN fr.total_time <= 30 THEN 'Easy'
                    WHEN fr.total_time <= 60 THEN 'Medium'
                    ELSE 'Hard'
                END
                """
                
                cursor.execute(update_query)
                self.target_conn.commit()
                logger.info("Successfully updated difficulty levels")
            else:
                logger.info("Skipping difficulty level update - required columns not found")
            
            cursor.close()
            
        except Exception as e:
            logger.error(f"Failed to update difficulty levels: {e}")
    
    def run_etl(self):
        try:
            logger.info("Starting ETL pipeline...")
            
            self.connect_databases()
            
            logger.info("=== EXTRACTION PHASE ===")
            categories_df = self.extract_categories()
            recipes_df = self.extract_recipes()
            ingredients_df = self.extract_ingredients()
            
            logger.info("=== TRANSFORMATION PHASE ===")
            categories_transformed = self.transform_categories(categories_df)
            recipes_dim_transformed = self.transform_recipes_dim(recipes_df)
            recipes_fact_transformed = self.transform_recipes_fact(recipes_df)
            ingredients_transformed = self.transform_ingredients(ingredients_df)
            
            logger.info("=== LOADING PHASE ===")
            
            self.clear_all_tables()
            
            self.load_to_warehouse('dim_categories', categories_transformed)
            self.load_to_warehouse('dim_recipes', recipes_dim_transformed)
            self.load_to_warehouse('fact_recipes', recipes_fact_transformed)
            self.load_to_warehouse('dim_ingredients', ingredients_transformed)
            
            self.update_difficulty_levels()
            
            logger.info("ETL pipeline completed successfully!")
            
        except Exception as e:
            logger.error(f"ETL pipeline failed: {e}")
            raise
        finally:
            self.close_connections()

def main():
    source_config = {
        'host': 'localhost',
        'user': 'root',
        'password': '12345678',
        'database': 'cake_recipes_db',
        'charset': 'utf8mb4'
    }
    
    target_config = {
        'host': 'localhost',
        'user': 'pino',
        'password': '12345678',
        'database': 'cake_recipes_dw',
        'charset': 'utf8mb4'
    }
    
    etl = CakeRecipeETL(source_config, target_config)
    etl.run_etl()

if __name__ == "__main__":
    main()