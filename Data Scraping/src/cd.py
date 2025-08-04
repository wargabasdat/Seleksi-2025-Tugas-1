import requests
from bs4 import BeautifulSoup
import json
import time
import re
from urllib.parse import urljoin, urlparse
import os
from datetime import datetime

class SugarySweetsRecipeScraper:
    def __init__(self):
        self.base_url = "https://www.shugarysweets.com"
        self.session = requests.Session()
        self.session.headers.update({
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
            'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
            'Accept-Language': 'en-US,en;q=0.5',
            'Accept-Encoding': 'gzip, deflate',
            'Connection': 'keep-alive',
            'Upgrade-Insecure-Requests': '1',
        })
        
        # Data storage
        self.recipes = []
        self.categories = []
        self.ingredients = []
        self.instructions = []
        
        # Create data directory
        os.makedirs('data', exist_ok=True)
    
    def get_recipe_links_from_page(self, page_url):
        """Extract recipe links from a category page"""
        recipe_links = []
        
        try:
            print(f"Fetching page: {page_url}")
            response = self.session.get(page_url, timeout=15)
            response.raise_for_status()
            
            soup = BeautifulSoup(response.content, 'html.parser')
            
            # Multiple strategies to find recipe links
            link_selectors = [
                'article h2 a',  # Common blog post title links
                'article h3 a',  # Alternative title links
                '.entry-title a',  # WordPress entry titles
                '.post-title a',  # Post title links
                'h2.entry-title a',  # Specific entry title
                'h3.entry-title a',  # Alternative entry title
                '.recipe-card a',  # Recipe card links
                'article .entry-header a',  # Entry header links
                'article a[href*="cake"]',  # Links containing "cake"
            ]
            
            found_links = set()  # Avoid duplicates
            
            for selector in link_selectors:
                elements = soup.select(selector)
                for element in elements:
                    href = element.get('href')
                    if href:
                        # Normalize URL
                        full_url = urljoin(self.base_url, href)
                        
                        # Filter for cake recipes only
                        if self.is_cake_recipe_url(full_url):
                            found_links.add(full_url)
                            print(f"Found recipe: {element.get_text().strip()}")
            
            # try to find links in the main content area
            content_area = soup.select_one('.site-main, .content-area, #main, .posts')
            if content_area:
                all_links = content_area.find_all('a', href=True)
                for link in all_links:
                    href = link.get('href')
                    if href:
                        full_url = urljoin(self.base_url, href)
                        if self.is_cake_recipe_url(full_url) and 'recipe' in link.get_text().lower():
                            found_links.add(full_url)
            
            recipe_links = list(found_links)
            print(f"Found {len(recipe_links)} unique recipe links on this page")
            
            # Add delay 
            time.sleep(2)
            
        except requests.RequestException as e:
            print(f"Error fetching page {page_url}: {e}")
        except Exception as e:
            print(f"Unexpected error processing page {page_url}: {e}")
        
        return recipe_links
    
    def is_cake_recipe_url(self, url):
        """Check if URL is likely a cake recipe"""
        url_lower = url.lower()
        
        # Must be from the same domain
        if 'shugarysweets.com' not in url_lower:
            return False
        
        # Should contain cake-related keywords
        cake_keywords = ['cake', 'cupcake', 'frosting', 'pound', 'bundt', 'layer']
        
        # Check if URL contains cake keywords
        has_cake_keyword = any(keyword in url_lower for keyword in cake_keywords)
        
        # Exclude non-recipe pages
        exclude_keywords = ['/category/', '/tag/', '/author/', '/page/', '/search/', 
                          'wp-content', 'wp-admin', '.jpg', '.png', '.pdf']
        is_excluded = any(keyword in url_lower for keyword in exclude_keywords)
        
        return has_cake_keyword and not is_excluded
    
    def scrape_category_pages(self, start_page=2, end_page=16):
        """Scrape recipe links from cake category pages"""
        all_recipe_links = []
        
        print(f"Scraping cake category pages {start_page} to {end_page}")
        
        for page_num in range(start_page, end_page + 1):
            if page_num == 1:
                page_url = f"{self.base_url}/category/cake/"
            else:
                page_url = f"{self.base_url}/category/cake/page/{page_num}/"
            
            print(f"\n--- Processing page {page_num} ---")
            page_links = self.get_recipe_links_from_page(page_url)
            
            if not page_links:
                print(f"No recipe links found on page {page_num}, trying alternative approach...")
                # Try alternative approach - look for any links that might be recipes
                page_links = self.fallback_link_extraction(page_url)
            
            all_recipe_links.extend(page_links)
            
            # Stop links not found for several consecutive pages
            if not page_links and page_num > start_page + 2:
                print(f"No links found on page {page_num}, might have reached the end")
                break
            
            print(f"Total unique links so far: {len(set(all_recipe_links))}")
        
        # Remove duplicates while preserving order
        unique_links = []
        seen = set()
        for link in all_recipe_links:
            if link not in seen:
                unique_links.append(link)
                seen.add(link)
        
        print(f"\nTotal unique recipe links found: {len(unique_links)}")
        return unique_links
    
    def fallback_link_extraction(self, page_url):
        """Fallback method to extract recipe links"""
        recipe_links = []
        
        try:
            response = self.session.get(page_url, timeout=15)
            response.raise_for_status()
            soup = BeautifulSoup(response.content, 'html.parser')
            
            # Look for any links that might lead to recipes
            all_links = soup.find_all('a', href=True)
            
            for link in all_links:
                href = link.get('href')
                link_text = link.get_text().strip().lower()
                
                if href:
                    full_url = urljoin(self.base_url, href)
                    
                    # More aggressive matching for cake recipes
                    if (self.is_cake_recipe_url(full_url) or 
                        any(word in link_text for word in ['cake', 'recipe', 'frosting', 'baking'])):
                        if 'shugarysweets.com' in full_url and full_url not in recipe_links:
                            recipe_links.append(full_url)
                            print(f"Fallback found: {link_text[:50]}...")
            
        except Exception as e:
            print(f"Fallback extraction failed for {page_url}: {e}")
        
        return recipe_links
    
    def clean_text(self, text):
        """Clean and normalize text"""
        if not text:
            return ""
        
        # Remove extra whitespace and normalize
        text = re.sub(r'\s+', ' ', text.strip())
        # Remove special characters that might cause issues
        text = re.sub(r'[^\w\s\-.,!?()/:;°]', '', text)
        return text
    
    def extract_recipe_data(self, recipe_url):
        """Extract detailed recipe data from individual recipe page"""
        try:
            print(f"Scraping recipe: {recipe_url}")
            response = self.session.get(recipe_url, timeout=15)
            response.raise_for_status()
            
            soup = BeautifulSoup(response.content, 'html.parser')
            
            # Extract recipe data
            recipe_data = {
                'url': recipe_url,
                'recipe_id': len(self.recipes) + 1,
                'scraped_at': datetime.now().isoformat()
            }
            
            # Title - try multiple selectors
            title_selectors = ['h1.entry-title', 'h1', '.recipe-title', '.entry-header h1', '.post-title']
            title = ""
            for selector in title_selectors:
                title_elem = soup.select_one(selector)
                if title_elem:
                    title = self.clean_text(title_elem.get_text())
                    if title:  # Only use non-empty titles
                        break
            
            recipe_data['title'] = title or "Unknown Recipe"
            
            # Description - get from first substantial paragraph
            desc_selectors = [
                '.entry-content p',
                '.recipe-summary', 
                '.wp-block-group p',
                '.post-content p',
                'article p'
            ]
            description = ""
            for selector in desc_selectors:
                desc_elems = soup.select(selector)
                for desc_elem in desc_elems:
                    desc_text = self.clean_text(desc_elem.get_text())
                    if len(desc_text) > 100:  # Only use substantial descriptions
                        description = desc_text[:500]  # Limit length
                        break
                if description:
                    break
            
            recipe_data['description'] = description
            
            # Category - always cake for this scraper
            recipe_data['category'] = 'cake'
            
            # Try to find prep/cook time in recipe card or text
            prep_time = self.extract_time_from_content(soup, 'prep')
            cook_time = self.extract_time_from_content(soup, 'cook')
            chill_time = self.extract_time_from_content(soup, 'chill')
            recipe_data['chill_time'] = chill_time  
            recipe_data['prep_time'] = prep_time
            recipe_data['cook_time'] = cook_time
            
            # Servings - look for serving info
            servings = self.extract_servings(soup)
            recipe_data['servings'] = servings
            # Total time: sum of prep, cook, chill (skip None values)
            total_time = sum(t for t in [prep_time, cook_time, chill_time] if t is not None)
            recipe_data['total_time'] = total_time if total_time > 0 else None
            # Author
            author_elem = soup.select_one('.author, .recipe-author, .by-author')
            if author_elem:
                recipe_data['author'] = self.clean_text(author_elem.get_text())
            else:
                recipe_data['author'] = "Shugary Sweets"
            
            # Image URL - find main recipe image
            img_selectors = [
                '.recipe-card img', 
                '.entry-content img', 
                '.wp-post-image',
                '.featured-image img',
                'article img'
            ]
            image_url = ""
            for selector in img_selectors:
                img_elem = soup.select_one(selector)
                if img_elem and img_elem.get('src'):
                    src = img_elem.get('src')
                    if ('shugarysweets.com' in src and 
                        not src.endswith('.svg') and 
                        'data:image' not in src):
                        image_url = src
                        break
            
            recipe_data['image_url'] = image_url
            
            # Published date - look for time tags or date info
            date_elem = soup.select_one('time, .published, .date')
            published_date = ""
            if date_elem:
                published_date = date_elem.get('datetime', '') or date_elem.get_text()
            
            recipe_data['published_date'] = published_date
            
            # Extract ingredients
            ingredients = self.extract_ingredients(soup, recipe_data['recipe_id'])
            recipe_data['ingredients_count'] = len(ingredients)
            
            # Extract instructions
            instructions = self.extract_instructions(soup, recipe_data['recipe_id'])
            recipe_data['instructions_count'] = len(instructions)
            
            self.recipes.append(recipe_data)
            
            # Add category if not exists
            category_name = recipe_data['category']
            if not any(cat['name'] == category_name for cat in self.categories):
                category = {
                    'category_id': len(self.categories) + 1,
                    'name': category_name,
                    'description': f"Best {category_name} recipes from Shugary Sweets"
                }
                self.categories.append(category)
            
            time.sleep(2)  # rspect
            return recipe_data
            
        except Exception as e:
            print(f"Error scraping recipe {recipe_url}: {e}")
            return None
    
    def extract_time_from_content(self, soup, time_type):
        """Extract prep/cook/chill time from content"""
        # Look for structured data first
        script_tags = soup.find_all('script', type='application/ld+json')
        for script in script_tags:
            try:
                data = json.loads(script.string)
                if isinstance(data, dict):
                    if time_type == 'prep' and 'prepTime' in data:
                        return self.parse_duration(data['prepTime'])
                    elif time_type == 'cook' and 'cookTime' in data:
                        return self.parse_duration(data['cookTime'])
                    elif time_type == 'chill' and 'chillTime' in data:
                        return self.parse_duration(data['chillTime'])
                    
            except:
                continue
        
        # Look for WPRM time elements first
        wprm_time_selectors = [
            f'.wprm-recipe-{time_type}-time-container',
            f'.wprm-recipe-{time_type}_time',
            f'.wprm-recipe-{time_type}time'
        ]
        
        for selector in wprm_time_selectors:
            time_elem = soup.select_one(selector)
            if time_elem:
                time_text = time_elem.get_text().lower()
                parsed_time = self.parse_time_text(time_text)
                if parsed_time:
                    return parsed_time
        
        # Look for time patterns 
        time_patterns = [
            # Hours and minutes combined
            rf'{time_type}\s*time[:\s]*(\d+)\s*(?:hours?|hrs?|h)\s*(?:and\s*)?(\d+)\s*(?:minutes?|mins?|m)',
            rf'{time_type}[:\s]*(\d+)\s*(?:hours?|hrs?|h)\s*(?:and\s*)?(\d+)\s*(?:minutes?|mins?|m)',
            rf'(\d+)\s*(?:hours?|hrs?|h)\s*(?:and\s*)?(\d+)\s*(?:minutes?|mins?|m).*{time_type}',
            
            # Hours only
            rf'{time_type}\s*time[:\s]*(\d+)\s*(?:hours?|hrs?|h)',
            rf'{time_type}[:\s]*(\d+)\s*(?:hours?|hrs?|h)',
            rf'(\d+)\s*(?:hours?|hrs?|h).*{time_type}',
            
            # Minutes only
            rf'{time_type}\s*time[:\s]*(\d+)\s*(?:minutes?|mins?|m)',
            rf'{time_type}[:\s]*(\d+)\s*(?:minutes?|mins?|m)',
            rf'(\d+)\s*(?:minutes?|mins?|m).*{time_type}',
        ]
        
        text_content = soup.get_text().lower()
        
        for pattern in time_patterns:
            match = re.search(pattern, text_content)
            if match:
                groups = match.groups()
                if len(groups) == 2 and groups[1]:  # Hours and minutes
                    hours = int(groups[0])
                    minutes = int(groups[1])
                    return hours * 60 + minutes
                elif len(groups) == 1:  # Single value
                    time_value = int(groups[0])
                    if 'hour' in pattern or 'hr' in pattern:
                        time_value *= 60  # Convert to minutes
                    return time_value
        
        return None
    
    def parse_time_text(self, time_text):
        """Parse time text like '1 hour 30 minutes' or '45 minutes'"""
        total_minutes = 0
        
        # Look for hours
        hour_match = re.search(r'(\d+)\s*(?:hours?|hrs?|h)', time_text)
        if hour_match:
            total_minutes += int(hour_match.group(1)) * 60
        
        # Look for minutes
        minute_match = re.search(r'(\d+)\s*(?:minutes?|mins?|m)', time_text)
        if minute_match:
            total_minutes += int(minute_match.group(1))
        
        return total_minutes if total_minutes > 0 else None
    
    def parse_duration(self, duration_str):
        """Parse ISO 8601 duration (PT15M) to minutes"""
        if not duration_str:
            return None
        
        
        match = re.search(r'PT(?:(\d+)H)?(?:(\d+)M)?', duration_str)
        if match:
            hours = int(match.group(1) or 0)
            minutes = int(match.group(2) or 0)
            return hours * 60 + minutes
        
        return None
    
    def extract_servings(self, soup):
        """Extract serving information"""
        
        script_tags = soup.find_all('script', type='application/ld+json')
        for script in script_tags:
            try:
                data = json.loads(script.string)
                if isinstance(data, dict) and 'recipeYield' in data:
                    yield_value = data['recipeYield']
                    if isinstance(yield_value, list):
                        yield_value = yield_value[0]
                    
                    match = re.search(r'(\d+)', str(yield_value))
                    if match:
                        return int(match.group(1))
            except:
                continue
        
        servings_patterns = [
            r'serves?\s*(\d+)',
            r'yield[:\s]*(\d+)',
            r'(\d+)\s*serving',
            r'makes\s*(\d+)',
            r'(\d+)\s*slices?',         # Match "8 slices", "12 slice", etc.
            r'makes\s*(\d+)\s*slices?', # Match "makes 12 slices"
            r'yield[:\s]*(\d+)\s*slices?'
        ]

        
        text_content = soup.get_text().lower()
        
        for pattern in servings_patterns:
            match = re.search(pattern, text_content)
            if match:
                return int(match.group(1))
        
        return None
    
    def extract_ingredients(self, soup, recipe_id):
        """Extract ingredients from recipe using WPRM-specific selectors"""
        ingredients = []
        
        # Method 1: Look for structured data (JSON-LD) first
        script_tags = soup.find_all('script', type='application/ld+json')
        for script in script_tags:
            try:
                data = json.loads(script.string)
                if isinstance(data, dict) and 'recipeIngredient' in data:
                    for i, ing_text in enumerate(data['recipeIngredient'], 1):
                        ingredient = self.create_ingredient_object(ing_text, recipe_id, i)
                        ingredients.append(ingredient)
                        self.ingredients.append(ingredient)
                    return ingredients  # Return early if found structured data
            except:
                continue
        
        # Method 2: Look for WPRM (WP Recipe Maker) specific ingredient containers
        wprm_ingredient_selectors = [
            '.wprm-recipe-ingredients ul.wprm-recipe-ingredients li',
            '.wprm-recipe-ingredient-group ul.wprm-recipe-ingredients li',
            '.wprm-recipe-ingredients-container ul li',
            '.wprm-recipe-ingredients li'
        ]
        
        for selector in wprm_ingredient_selectors:
            ingredient_elements = soup.select(selector)
            if ingredient_elements:
                print(f"Found {len(ingredient_elements)} ingredients using WPRM selector: {selector}")
                for i, element in enumerate(ingredient_elements, 1):
                    # Get the ingredient text, avoiding any nested elements like amounts or notes
                    ingredient_text = self.extract_ingredient_text_from_wprm(element)
                    if ingredient_text and len(ingredient_text) > 3:
                        ingredient = self.create_ingredient_object(ingredient_text, recipe_id, i)
                        ingredients.append(ingredient)
                        self.ingredients.append(ingredient)
                return ingredients  # Return early if found WPRM ingredients
        
        # Method 3: Generic recipe ingredient selectors (fallback)
        generic_ingredient_selectors = [
            '.recipe-ingredients ul li',
            '.recipe-ingredients ol li',
            '.ingredients ul li',
            '.ingredients ol li',
            '.recipe-card .ingredients li',
            'ul.recipe-ingredients li',
            'ol.recipe-ingredients li'
        ]
        
        for selector in generic_ingredient_selectors:
            ingredient_elements = soup.select(selector)
            if ingredient_elements:
                print(f"Found {len(ingredient_elements)} ingredients using generic selector: {selector}")
                for i, element in enumerate(ingredient_elements, 1):
                    ingredient_text = self.clean_text(element.get_text())
                    if ingredient_text and len(ingredient_text) > 3:
                        ingredient = self.create_ingredient_object(ingredient_text, recipe_id, i)
                        ingredients.append(ingredient)
                        self.ingredients.append(ingredient)
                return ingredients  # Return early if found generic ingredients
        
        print("No ingredients found using any selector method")
        return ingredients
    
    def extract_ingredient_text_from_wprm(self, element):
        """Extract clean ingredient text from WPRM ingredient element"""
        # WPRM often has nested spans for amounts, units, and ingredient names
        # Try to get the full text but clean it properly
        
        # First try to get individual components if they exist
        amount_elem = element.select_one('.wprm-recipe-ingredient-amount')
        unit_elem = element.select_one('.wprm-recipe-ingredient-unit')
        name_elem = element.select_one('.wprm-recipe-ingredient-name')
        notes_elem = element.select_one('.wprm-recipe-ingredient-notes')
        
        if name_elem:
            # Build ingredient text from components
            parts = []
            if amount_elem:
                parts.append(self.clean_text(amount_elem.get_text()))
            if unit_elem:
                parts.append(self.clean_text(unit_elem.get_text()))
            parts.append(self.clean_text(name_elem.get_text()))
            if notes_elem:
                notes_text = self.clean_text(notes_elem.get_text())
                if notes_text:
                    parts.append(f"({notes_text})")
            
            return " ".join(parts)
        else:
            # Fallback to full element text
            return self.clean_text(element.get_text())
    
    def create_ingredient_object(self, ingredient_text, recipe_id, index):
        """Create ingredient object from text"""
        return {
            'ingredient_id': len(self.ingredients) + index,
            'recipe_id': recipe_id,
            'text': ingredient_text,
            'quantity': self.extract_quantity(ingredient_text),
            'unit': self.extract_unit(ingredient_text),
            'name': self.extract_ingredient_name(ingredient_text)
        }
    
    def extract_instructions(self, soup, recipe_id):
        """Extract cooking instructions using WPRM-specific selectors"""
        instructions = []
        
        # Method 1: Look for structured data (JSON-LD) first
        script_tags = soup.find_all('script', type='application/ld+json')
        for script in script_tags:
            try:
                data = json.loads(script.string)
                if isinstance(data, dict) and 'recipeInstructions' in data:
                    for i, inst in enumerate(data['recipeInstructions'], 1):
                        instruction_text = ""
                        if isinstance(inst, dict):
                            instruction_text = inst.get('text', '')
                        elif isinstance(inst, str):
                            instruction_text = inst
                        
                        if instruction_text:
                            instruction = {
                                'instruction_id': len(self.instructions) + 1,
                                'recipe_id': recipe_id,
                                'step_number': i,
                                'text': self.clean_text(instruction_text)
                            }
                            instructions.append(instruction)
                            self.instructions.append(instruction)
                    return instructions  # Return early if found structured data
            except:
                continue
        
        # Method 2: Look for WPRM (WP Recipe Maker) specific instruction containers
        wprm_instruction_selectors = [
            '.wprm-recipe-instructions ul.wprm-recipe-instructions li',
            '.wprm-recipe-instruction-group ul.wprm-recipe-instructions li',
            '.wprm-recipe-instructions-container ul li',
            '.wprm-recipe-instructions li'
        ]
        
        for selector in wprm_instruction_selectors:
            instruction_elements = soup.select(selector)
            if instruction_elements:
                print(f"Found {len(instruction_elements)} instructions using WPRM selector: {selector}")
                for i, element in enumerate(instruction_elements, 1):
                    # Get the instruction text, avoiding any nested elements
                    instruction_text = self.extract_instruction_text_from_wprm(element)
                    if instruction_text and len(instruction_text) > 10:
                        instruction = {
                            'instruction_id': len(self.instructions) + 1,
                            'recipe_id': recipe_id,
                            'step_number': i,
                            'text': instruction_text
                        }
                        instructions.append(instruction)
                        self.instructions.append(instruction)
                return instructions  # Return early if found WPRM instructions
        
        # Method 3: Generic recipe instruction selectors (fallback)
        generic_instruction_selectors = [
            '.recipe-instructions ol li',
            '.recipe-instructions ul li',
            '.instructions ol li',
            '.instructions ul li',
            '.recipe-card .instructions li',
            'ol.recipe-instructions li',
            '.directions ol li',
            '.directions ul li'
        ]
        
        for selector in generic_instruction_selectors:
            instruction_elements = soup.select(selector)
            if instruction_elements:
                print(f"Found {len(instruction_elements)} instructions using generic selector: {selector}")
                for i, element in enumerate(instruction_elements, 1):
                    instruction_text = self.clean_text(element.get_text())
                    if instruction_text and len(instruction_text) > 10:
                        instruction = {
                            'instruction_id': len(self.instructions) + 1,
                            'recipe_id': recipe_id,
                            'step_number': i,
                            'text': instruction_text
                        }
                        instructions.append(instruction)
                        self.instructions.append(instruction)
                return instructions  # Return early if found generic instructions
        
        print("No instructions found using any selector method")
        return instructions
    
    def extract_instruction_text_from_wprm(self, element):
        """Extract clean instruction text from WPRM instruction element"""
        # WPRM might have nested elements for instruction text
        text_elem = element.select_one('.wprm-recipe-instruction-text')
        
        if text_elem:
            return self.clean_text(text_elem.get_text())
        else:
            # Fallback to full element text
            return self.clean_text(element.get_text())
    
    def normalize_fraction_symbols(self, text):
        """Normalize common fraction symbols in ingredient text"""
        # Replace common fraction symbols with standard ones
        replacements = {
            'Ω': '2/3',
            '½': '1/2',
            '⅓': '1/3', 'Öì': '1/3',
            '¼': '1/4', 'º': '1/4',
            '⅔': '2/3', 'Öî': '2/3',
            '⅛': '1/8',
            '¾': '3/4', 'æ': '3/4',
            '⅖': '2/5',
            '⅗': '3/5',
            '⅚': '5/6',
            '⅞': '7/8',
            '⅕': '1/5', 'Ö': '1/5',
            '⅘': '4/5', 'Öí': '4/5',
            '⅙': '1/6', 'Öð': '1/6',
                        
        }
        for old, new in replacements.items():
            text = text.replace(old, new)
        return text  



    def extract_quantity(self, ingredient_text):
        """Extract quantity from ingredient text"""
        # Handle escaped slashes first
        ingredient_text = ingredient_text.replace('\\/', '/')
        ingredient_text = self.normalize_fraction_symbols(ingredient_text) 

        quantity_patterns = [
            r'^(\d+\s+\d+/\d+)',  # 1 1/2, 2 3/4
            r'^(\d+/\d+)',        # 1/2, 3/4
            r'^(\d+\.\d+)',       # 1.5, 2.25
            r'^(\d+)',            # 1, 2, 10
        ]
        
        for pattern in quantity_patterns:
            match = re.search(pattern, ingredient_text.strip())
            if match:
                return match.group(1)
        return None
    
    def extract_unit(self, ingredient_text):
        """Extract unit from ingredient text"""
        units = [
            'cup', 'cups', 'tablespoon', 'tablespoons', 'tbsp', 'teaspoon', 'teaspoons', 'tsp', 
            'pound', 'pounds', 'lb', 'lbs', 'ounce', 'ounces', 'oz', 'gram', 'grams', 'g',
            'large', 'medium', 'small', 'clove', 'cloves', 'package', 'packages', 'can', 'cans'
        ]
        
        text_lower = ingredient_text.lower()
        for unit in units:
            if re.search(rf'\b{unit}s?\b', text_lower):
                return unit
        return None
    
    def extract_ingredient_name(self, ingredient_text):
        """Extract main ingredient name from text"""
        # Remove quantity and unit, keep the main ingredient
        text = re.sub(r'^[\d\s/.-]+', '', ingredient_text)  # Remove leading numbers
        
        # Remove common units
        units = ['cup', 'tablespoon', 'teaspoon', 'pound', 'ounce', 'gram', 'tbsp', 'tsp', 'lb', 'oz', 'g',
                'large', 'medium', 'small', 'clove', 'package', 'can']
        
        for unit in units:
            text = re.sub(rf'\b{unit}s?\b', '', text, flags=re.IGNORECASE)
        
        # Clean up extra spaces and punctuation
        text = re.sub(r'\s+', ' ', text).strip()
        text = re.sub(r'^[,\s-]+', '', text)
        
        return text
    
    def save_data(self):
        """Save scraped data to JSON files"""
        
        # Save recipes
        with open('../data/recipes.json', 'w', encoding='utf-8') as f:
            json.dump(self.recipes, f, indent=2, ensure_ascii=False)
        
        # Save categories
        with open('../data/categories.json', 'w', encoding='utf-8') as f:
            json.dump(self.categories, f, indent=2, ensure_ascii=False)
        
        # Save ingredients
        with open('../data/ingredients.json', 'w', encoding='utf-8') as f:
            json.dump(self.ingredients, f, indent=2, ensure_ascii=False)
        
        # Save instructions
        with open('../data/instructions.json', 'w', encoding='utf-8') as f:
            json.dump(self.instructions, f, indent=2, ensure_ascii=False)
        
        print(f"\n=== SCRAPING SUMMARY ===")
        print(f"- {len(self.recipes)} recipes")
        print(f"- {len(self.categories)} categories") 
        print(f"- {len(self.ingredients)} ingredients")
        print(f"- {len(self.instructions)} instructions")
    
    def run_scraper(self, start_page=2, end_page=16, max_recipes=110):
        """Main scraper function"""
        print("Starting Shugary Sweets Best Cake Recipe Scraper...")
        print(f"Scraping pages {start_page} to {end_page}")
        print(f"Maximum recipes to scrape: {max_recipes}")
        
        # Get all recipe links from category pages
        recipe_links = self.scrape_category_pages(start_page, end_page)
        
        if not recipe_links:
            print("No recipe links found! Check if the website structure has changed.")
            return
        
        # Limit number of recipes to scrape
        recipe_links = recipe_links[:max_recipes]
        
        print(f"\nStarting to scrape {len(recipe_links)} cake recipes...")
        
        # Scrape individual recipes
        successful_scrapes = 0
        failed_scrapes = 0
        
        for i, recipe_url in enumerate(recipe_links, 1):
            print(f"\n--- Progress: {i}/{len(recipe_links)} ---")
            result = self.extract_recipe_data(recipe_url)
            if result:
                successful_scrapes += 1
                print(f"Successfully scraped: {result['title']}")
            else:
                failed_scrapes += 1
                print(f"Failed to scrape: {recipe_url}")
        
        print(f"\n=== FINAL RESULTS ===")
        print(f"Successfully scraped: {successful_scrapes} recipes")
        print(f"Failed to scrape: {failed_scrapes} recipes")
        print(f"Success rate: {(successful_scrapes/(successful_scrapes+failed_scrapes)*100):.1f}%")
        
        # Save all data
        self.save_data()
        print("\nScraping completed! Check the 'data' folder for JSON files.")

if __name__ == "__main__":
    scraper = SugarySweetsRecipeScraper()
    
    # Run scraper for pages 2-16, maximum 100 recipes
    scraper.run_scraper(start_page=2, end_page=16, max_recipes=110)