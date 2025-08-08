import time
import json
import os
import re
from datetime import datetime
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By
from selenium.webdriver.common.action_chains import ActionChains
from bs4 import BeautifulSoup

# fungsi untuk membuat driver Chrome
def create_driver():
    options = Options()
    options.add_argument("--no-sandbox")
    options.add_argument("--disable-dev-shm-usage")
    options.add_argument("--disable-gpu")
    options.add_argument("--window-size=1280,720")
    options.add_argument("--disable-blink-features=AutomationControlled")
    options.add_experimental_option("excludeSwitches", ["enable-automation"])
    options.add_experimental_option('useAutomationExtension', False)
    
    try:
        service = Service(r"C:\chromedriver\chromedriver.exe")
        driver = webdriver.Chrome(service=service, options=options)
        driver.set_page_load_timeout(60)
        driver.implicitly_wait(10)
        driver.execute_script("Object.defineProperty(navigator, 'webdriver', {get: () => undefined})")
        return driver
    except Exception as e:
        print(f"Failed to create driver: {e}")
        return None

# fungsi untuk mengklik elemen
def safe_click(driver, element):
    try:
        ActionChains(driver).move_to_element(element).click().perform()
        return True
    except:
        try:
            driver.execute_script("arguments[0].click();", element)
            return True
        except:
            return False

# fungsi untuk memeriksa apakah driver masih aktif
def check_driver_alive(driver):
    try:
        driver.current_url
        return True
    except:
        return False

# fungsi untuk mengonversi teks tanggal ke format DATE (YYYY-MM-DD)
def convert_to_date(date_text):
    try:
        clean_date = date_text.replace("Today, ", "")
        match = re.search(r'(\w{3}),?\s+(\d{1,2})\s+(\w{3})', clean_date)
        
        if match:
            day_name, day, month_abbr = match.groups()
            
            month_map = {
                'Jan': '01', 'Feb': '02', 'Mar': '03', 'Apr': '04',
                'May': '05', 'Jun': '06', 'Jul': '07', 'Aug': '08', 
                'Sep': '09', 'Oct': '10', 'Nov': '11', 'Dec': '12'
            }
            
            month = month_map.get(month_abbr, '01')
            day = day.zfill(2)
            return f"2025-{month}-{day}"
        
        return None
    except:
        return None

# fungsi untuk memilih kategori dari dropdown
def select_category_filter(driver, category):
    try:
        dropdown_selectors = [
            'div[class*="css-qadvcv-control"]',
            'div[class*="dropdown"]',
            'div[class*="select"]'
        ]
        
        dropdown = None
        for selector in dropdown_selectors:
            try:
                dropdown = driver.find_element(By.CSS_SELECTOR, selector)
                break
            except:
                continue
        
        if not dropdown:
            return False
        
        safe_click(driver, dropdown)
        time.sleep(2)
        
        option_selectors = [
            f"//div[contains(text(), '{category}')]",
            f"//span[contains(text(), '{category}')]", 
            f"//*[contains(text(), '{category}')]"
        ]
        
        for selector in option_selectors:
            try:
                option = driver.find_element(By.XPATH, selector)
                safe_click(driver, option)
                time.sleep(3)
                return True
            except:
                continue
        
        return False
        
    except:
        return False

# fungsi untuk memuat konten kategori
def enhanced_loading_for_category(driver):
    # Extended scrolling
    for scroll_round in range(8):
        scroll_position = (scroll_round + 1) * 600
        driver.execute_script(f"window.scrollTo(0, {scroll_position});")
        time.sleep(1.5)
    
    # Interactive container processing
    try:
        containers = driver.find_elements(By.CSS_SELECTOR, 'div[id*="2025-"]')
        for i, container in enumerate(containers):
            if i % 3 == 0:
                try:
                    driver.execute_script("arguments[0].scrollIntoView({block: 'center'});", container)
                    time.sleep(1)
                    safe_click(driver, container)
                    time.sleep(1)
                except:
                    continue
    except:
        pass
    
    # Final scroll
    driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
    time.sleep(2)
    driver.execute_script("window.scrollTo(0, 0);")
    time.sleep(2)

# fungsi untuk mengekstrak data dari kategori yang dipilih
def extract_category_data(driver, category):
    if not check_driver_alive(driver):
        return []
    
    try:
        soup = BeautifulSoup(driver.page_source, 'lxml')
        date_containers = soup.find_all('div', id=re.compile(r'2025-.*'))
    except Exception as e:
        print(f"Failed to parse HTML for {category}: {e}")
        return []
    
    category_entries = []
    
    for container in date_containers:
        try:
            date_element = container.find('p', class_=lambda x: x and 'font-bold' in x)
            if not date_element:
                continue
            
            date_text = date_element.get_text(strip=True)
            formatted_date = convert_to_date(date_text)
            if not formatted_date:
                continue
            
            class_entries = container.find_all('div', class_='head')
            if not class_entries:
                continue
            
            for entry in class_entries:
                try:
                    # Extract time and duration
                    time_li = entry.find('li', class_='col col-1')
                    if not time_li:
                        continue
                    
                    time_element = time_li.find('h3', class_='time')
                    duration_element = time_li.find('p', class_='minute')
                    
                    time_text = time_element.get_text(strip=True) if time_element else None
                    duration_text = duration_element.get_text(strip=True) if duration_element else None
                    
                    # Extract class details
                    details_li = entry.find('li', class_=lambda x: x and 'flex' in x and 'w-full' in x)
                    if not details_li:
                        continue
                    
                    # Extract class name
                    class_name_element = details_li.find('h3', class_=lambda x: x and 'text-base' in x and 'font-bold' in x)
                    class_name = class_name_element.get_text(strip=True) if class_name_element else None
                    
                    # Extract instructor
                    instructor = None
                    content_div = details_li.find('div', class_='content para')
                    if content_div:
                        p_elements = content_div.find_all('p')
                        for p in p_elements:
                            p_text = p.get_text(strip=True)
                            if (len(p_text) > 3 and len(p_text) < 50 and 
                                not any(word in p_text.lower() for word in ['mins', 'studio', 'left', 'waitlist', 'book', 'available', 'spot']) and
                                not re.search(r'\d+', p_text)):
                                instructor = p_text
                                break
                    
                    # Extract location
                    location_div = details_li.find('div', class_='col col-2')
                    location = None
                    studio = None
                    
                    if location_div:
                        location_h3 = location_div.find('h3')
                        studio_p = location_div.find('p')
                        location = location_h3.get_text(strip=True) if location_h3 else None
                        studio = studio_p.get_text(strip=True) if studio_p else None
                    
                    full_location = f"{location} - {studio}" if location and studio else (location or studio or "Unknown")
                    
                    if time_text and class_name:
                        schedule_data = {
                            "schedule_id": f"schedule_{len(category_entries) + 1}",
                            "category": category,
                            "date": formatted_date,
                            "start_time": time_text,
                            "duration": duration_text,
                            "class_name": class_name,
                            "instructor_name": instructor,
                            "location": full_location
                        }
                        
                        category_entries.append(schedule_data)
                    
                except:
                    continue
        
        except:
            continue
    
    return category_entries

# fungsi utama untuk mengumpulkan data dari semua kategori
def scrape_all_categories():
    print("KALM STUDIOS SCHEDULE SCRAPER")
    print("="*50)
    
    categories = [
        "Yoga", 
        "Prenatal Yoga", 
        "Mat Pilates",
        "Private Pilates",
        "Studio Rent",
    ]
    
    driver = create_driver()
    if not driver:
        print("Could not create driver")
        return []
    
    all_entries = []
    successful_categories = []
    
    try:
        for category in categories:
            print(f"\nProcessing: {category}")
            
            if not check_driver_alive(driver):
                driver.quit()
                driver = create_driver()
                if not driver:
                    break
            
            try:
                driver.get("https://kalmstudios.id/timetable")
                time.sleep(8)
                
                if not select_category_filter(driver, category):
                    print(f"Failed to select {category}")
                    continue
                
                enhanced_loading_for_category(driver)
                category_data = extract_category_data(driver, category)
                
                if category_data:
                    print(f"{category}: {len(category_data)} classes")
                    all_entries.extend(category_data)
                    successful_categories.append(category)
                else:
                    print(f"{category}: No data")
                
                time.sleep(3)
                
            except Exception as e:
                print(f"Error processing {category}: {e}")
                continue
        
        # menghapus duplikat berdasarkan tanggal, waktu, nama kelas, dan lokasi
        seen = set()
        unique_entries = []
        
        for entry in all_entries:
            unique_key = f"{entry.get('date')}_{entry.get('start_time')}_{entry.get('class_name')}_{entry.get('location')}"
            
            if unique_key not in seen:
                seen.add(unique_key)
                entry['schedule_id'] = f"schedule_{len(unique_entries) + 1}"
                unique_entries.append(entry)
        
        all_entries = unique_entries
        
        # menyimpan data ke file JSON
        if all_entries:
            output_dir = '../data/raw'
            os.makedirs(output_dir, exist_ok=True)
            
            # Main schedule file
            main_output_file = os.path.join(output_dir, 'kalm_schedules.json')
            with open(main_output_file, 'w', encoding='utf-8') as f:
                json.dump(all_entries, f, indent=2, ensure_ascii=False)
            
            # Categories file
            categories_output_file = os.path.join(output_dir, 'kalm_categories.json')
            simple_categories = {
                "available_categories": successful_categories,
                "total_categories": len(successful_categories),
                "excluded_categories": ["Group Reformer"],
                "scraped_at": datetime.now().isoformat()
            }
            
            with open(categories_output_file, 'w', encoding='utf-8') as f:
                json.dump(simple_categories, f, indent=2, ensure_ascii=False)
            
            print(f"\n{'='*50}")
            print(f"SCRAPING COMPLETED!")
            print(f"Total entries: {len(all_entries)}")
            print(f"Successful categories: {', '.join(successful_categories)}")
            
            # summary stats untuk cek setiap kategori
            category_stats = {}
            for entry in all_entries:
                cat = entry.get('category', 'Unknown')
                category_stats[cat] = category_stats.get(cat, 0) + 1
            
            print(f"\nResults by Category:")
            for cat, count in sorted(category_stats.items()):
                print(f"   {cat}: {count} classes")
            
        else:
            print("No data extracted")
    
    except Exception as e:
        print(f"Major error: {e}")
    
    finally:
        if driver and check_driver_alive(driver):
            try:
                driver.quit()
            except:
                pass
    
    return all_entries

if __name__ == "__main__":
    result = scrape_all_categories()
    if result:
        print(f"\nCreated files with {len(result)} entries")