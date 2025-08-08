import time
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
from bs4 import BeautifulSoup
import re
import json
import os
from datetime import datetime

# fungsi untuk memulai driver Chrome
def start_driver():
    options = Options()
    options.add_argument("--disable-gpu")
    options.add_argument("--no-sandbox")
    options.add_argument("--disable-dev-shm-usage")
    options.add_argument("--window-size=1920,1080")
    
    service = Service(r"C:\chromedriver\chromedriver.exe")
    driver = webdriver.Chrome(service=service, options=options)
    return driver

# fungsi untuk mengambil data dari halaman kelas
def extract_main_class_data(soup):
    class_data = {}
    class_name_element = soup.select_one('p.Class___StyledTypography-sc-15tkhw-13.hzKWXe.zLSpi.header')
    class_data['name'] = class_name_element.text.strip() if class_name_element else None

    reviews_count_element = soup.select_one('p.Class__StarsText-sc-15tkhw-8.gKuqoV')
    if reviews_count_element:
        reviews_text = reviews_count_element.text.strip()
        try:
            class_data['total_reviews_count'] = int(''.join(filter(str.isdigit, reviews_text)))
        except ValueError:
            class_data['total_reviews_count'] = 0
    else:
        class_data['total_reviews_count'] = None

    duration_element = soup.select_one('div.Class__Fact-sc-15tkhw-4.bFJFVs:nth-child(1) p.gBoydj')
    class_data['duration'] = duration_element.text.strip() if duration_element else None

    difficulty_element = soup.select_one('div.Class__Fact-sc-15tkhw-4.bFJFVs:nth-child(2) p.gBoydj')
    class_data['difficulty_level'] = difficulty_element.text.strip() if difficulty_element else None

    location_element = soup.select_one('div.css-ycbfs2-singleValue')
    class_data['location'] = location_element.text.strip() if location_element else None

    about_class_element = soup.select_one('div#content.HTMLContent__Content-sc-n0pwv2-0.bCEnHR')
    if about_class_element:
        class_data['about_class_description'] = ' '.join(about_class_element.stripped_strings)
    else:
        class_data['about_class_description'] = None

    what_you_need_elements = soup.select('div.grid.grid-cols-2.gap-4 p.font-bold')
    class_data['what_you_need'] = [item.text.strip() for item in what_you_need_elements]

    return class_data

# fungsi untuk mengambil data dari halaman review kelas
def extract_reviews_data(soup):
    reviews_list = []
    review_items = soup.select('div.ReviewsList___StyledDiv-sc-1844wui-0 div.Review__Wrapper-sc-1yio6kz-0')

    for review_item in review_items:
        review = {}
        class_and_reviewer_element = review_item.select_one('p.ReviewsList___StyledP-sc-1844wui-1')
        if class_and_reviewer_element:
            review_class_name = class_and_reviewer_element.find(string=True, recursive=False)
            review['class_name_in_review'] = review_class_name.strip() if review_class_name else None
            reviewer_name_element = class_and_reviewer_element.select_one('span.ReviewsList___StyledSpan-sc-1844wui-2')
            review['reviewer_name'] = reviewer_name_element.text.replace('with ', '').strip() if reviewer_name_element else None
        else:
            review['class_name_in_review'] = None
            review['reviewer_name'] = None

        review_text_element = review_item.select_one('p.text__Typography-sc-ib5z1r-0.Review___StyledTypography-sc-1yio6kz-4')
        review['review_text'] = review_text_element.text.strip() if review_text_element else None

        review_location_element = review_item.select_one('span.Review___StyledSpan-sc-1yio6kz-3')
        review['review_location'] = review_location_element.text.strip() if review_location_element else None

        star_elements = review_item.select('div.Stars__StarWrapper-sc-1bsxfvs-0 svg path[fill="#FFC857"]')
        review['stars_rating'] = len(star_elements)

        reviews_list.append(review)
    return reviews_list

# fungsi untuk mengambil data dari halaman related classes
def extract_related_classes_data(soup):
    related_classes_list = []
    related_class_cards = soup.select('div.Class__RelatedClasses-sc-15tkhw-3 div.ClassCard__Wrapper-sc-7klxqu-4')

    for card in related_class_cards:
        related_class = {}
        title_element = card.select_one('h3.text__Typography-sc-ib5z1r-0.ClassCard___StyledTypography-sc-7klxqu-6')
        related_class['title'] = title_element.text.strip() if title_element else None

        img_element = card.select_one('div.ClassCard__ImgWrapper-sc-7klxqu-2 img')
        related_class['image_url'] = img_element['src'] if img_element and 'src' in img_element.attrs else None

        related_stars_wrapper = card.select_one('div.Stars__StarWrapper-sc-1bsxfvs-0.kmSAgp')
        if related_stars_wrapper:
            filled_stars = related_stars_wrapper.select('svg path[fill="#FFC857"]')
            related_class['stars_rating'] = len(filled_stars)
            reviews_count_text_element = related_stars_wrapper.select_one('p.Class__StarsText-sc-15tkhw-8.gKuqoV')
            if reviews_count_text_element:
                reviews_text = reviews_count_text_element.text.strip()
                try:
                    related_class['reviews_count'] = int(''.join(filter(str.isdigit, reviews_text)))
                except ValueError:
                    related_class['reviews_count'] = 0
            else:
                related_class['reviews_count'] = None
        else:
            related_class['stars_rating'] = None
            related_class['reviews_count'] = None

        duration_rel_element = card.select_one('div.ClassCard__Fact-sc-7klxqu-0.exScmI:nth-child(1) p.cNMFaq')
        related_class['duration'] = duration_rel_element.text.strip() if duration_rel_element else None

        difficulty_rel_element = card.select_one('div.ClassCard__Fact-sc-7klxqu-0.exScmI:nth-child(2) p.cNMFaq')
        related_class['difficulty_level'] = difficulty_rel_element.text.strip() if difficulty_rel_element else None

        description_rel_element = card.select_one('div#content.HTMLContent__Content-sc-n0pwv2-0.bCEnHR.ClassCard___StyledHTMLContent-sc-7klxqu-8')
        if description_rel_element:
            related_class['description'] = ' '.join(description_rel_element.stripped_strings)
        else:
            related_class['description'] = None

        related_classes_list.append(related_class)
    return related_classes_list

# fungsi untuk mengumpulkan URL setiap kelas dari halaman utama
def collect_class_urls_from_current_page(driver):
    class_urls = set()
    
    try:
        page_source = driver.page_source
        soup = BeautifulSoup(page_source, 'lxml')
        
        all_links = soup.find_all('a', href=True)
        for link in all_links:
            href = link.get('href', '')
            if '/class/' in href and len(href.split('/')[-1]) > 15:
                if href.startswith('/'):
                    full_url = f"https://kalmstudios.id{href}"
                else:
                    full_url = href
                class_urls.add(full_url)
        
        original_url = driver.current_url
        driver.get(original_url)
        time.sleep(3)
        
        for scroll in range(5):
            driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
            time.sleep(1)
        
        buttons = driver.find_elements(By.XPATH, "//button[contains(text(), 'View More')]")
        total_buttons = len(buttons)
        
        for attempt in range(total_buttons):
            try:
                driver.get(original_url)
                time.sleep(2)
                
                for scroll in range(3):
                    driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
                    time.sleep(1)
                
                buttons = driver.find_elements(By.XPATH, "//button[contains(text(), 'View More')]")
                
                if attempt < len(buttons):
                    button = buttons[attempt]
                    driver.execute_script("arguments[0].scrollIntoView({block: 'center'});", button)
                    time.sleep(1)
                    
                    current_url = driver.current_url
                    driver.execute_script("arguments[0].click();", button)
                    time.sleep(3)
                    
                    new_url = driver.current_url
                    if new_url != current_url and '/class/' in new_url:
                        class_urls.add(new_url)
                
            except Exception:
                continue
        
    except Exception:
        pass
    
    return class_urls

# fungsi untuk mendapatkan semua URL detail kelas
def get_all_class_detail_urls(driver, base_url):
    list_page_url = f"{base_url}/class"
    driver.get(list_page_url)
    time.sleep(5)
    
    class_detail_urls = set()

    last_height = driver.execute_script("return document.body.scrollHeight")
    scroll_attempts = 0
    max_scroll_attempts = 20
    
    while scroll_attempts < max_scroll_attempts:
        driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
        time.sleep(2)
        
        new_height = driver.execute_script("return document.body.scrollHeight")
        if new_height == last_height:
            if scroll_attempts > 8:
                break
        else:
            last_height = new_height
        
        scroll_attempts += 1
    
    final_urls = collect_class_urls_from_current_page(driver)
    class_detail_urls.update(final_urls)
    
    final_urls_list = list(class_detail_urls)
    return final_urls_list

# fungsi untuk mengambil detail kelas dari halaman detail
def scrape_class_detail_page(driver, url):
    try:
        driver.get(url)
        time.sleep(5)
        
        if "404" in driver.title or "not found" in driver.page_source.lower():
            return None
        
        html_content = driver.page_source
        soup = BeautifulSoup(html_content, 'lxml')
        
        main_class_info = extract_main_class_data(soup)
        reviews_info = extract_reviews_data(soup)
        related_classes_info = extract_related_classes_data(soup)
        
        return {
            "url": url,
            "main_class_details": main_class_info,
            "reviews": reviews_info,
            "related_classes": related_classes_info
        }
    except Exception:
        return None

# fungsi untuk mengambil data dari halaman instruktur
def scrape_instructors_page(driver, base_url):
    instructor_url = f"{base_url}/team"
    
    driver.get(instructor_url)
    time.sleep(5)
    
    for i in range(10):
        driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
        time.sleep(2)
    
    instructors = []
    
    try:
        page_source = driver.page_source
        soup = BeautifulSoup(page_source, 'lxml')
        
        team_cards = soup.find_all('div', class_='TeamCard__CardWrapper-sc-1w0ux8t-0')
        
        for i, card in enumerate(team_cards):
            try:
                name_element = card.find('p', class_='TeamCard__CardTitle-sc-1w0ux8t-1')
                name = name_element.get_text(strip=True) if name_element else f"Instructor {i+1}"
                
                desc_element = card.find('p', class_='team-desc')
                specialization = desc_element.get_text(strip=True) if desc_element else "Unknown"
                
                image_url = None
                
                listing_card = card.find('div', class_=lambda x: x and 'TeamListingCard__Wrapper-sc-1slp882-2' in x)
                if listing_card:
                    style_attr = listing_card.get('style', '')
                    if 'background-image' in style_attr:
                        match = re.search(r'url\(["\']?([^"\']+)["\']?\)', style_attr)
                        if match:
                            image_url = match.group(1)
                
                if not image_url:
                    team_details = card.find('div', class_='TeamDetails__MainWrapper-sc-1m81g1t-0')
                    if team_details:
                        img_element = team_details.find('img')
                        if img_element:
                            image_url = img_element.get('src')
                
                instructor_data = {
                    "instructor_id": f"instructor_{i+1}",
                    "name": name,
                    "role": specialization,
                    "image_url": image_url,
                    "scraped_at": datetime.now().isoformat()
                }
                
                instructors.append(instructor_data)
                
            except Exception:
                continue
    
    except Exception:
        pass

    return instructors

# fungsi untuk memisahkan data dan menyimpannya ke file JSON
def separate_and_save_all_data(all_classes_data, instructors_data):
    output_dir = '../data/raw'
    os.makedirs(output_dir, exist_ok=True)
    
    classes = []
    reviews = []
    equipment_needs = []
    related_classes = []
    
    for class_item in all_classes_data:
        class_id = class_item["url"].split('/')[-1]
        
        class_info = {
            "class_id": class_id,
            "url": class_item["url"],
            "name": class_item["main_class_details"].get("name"),
            "total_reviews_count": class_item["main_class_details"].get("total_reviews_count"),
            "duration": class_item["main_class_details"].get("duration"),
            "difficulty_level": class_item["main_class_details"].get("difficulty_level"),
            "location": class_item["main_class_details"].get("location"),
            "about_class_description": class_item["main_class_details"].get("about_class_description"),
            "scraped_at": datetime.now().isoformat()
        }
        classes.append(class_info)
        
        for review in class_item["reviews"]:
            if review.get("review_text"):
                review_info = {
                    "review_id": f"{class_id}_{len(reviews)}",
                    "class_id": class_id,
                    "reviewer_name": review.get("reviewer_name"),
                    "review_text": review.get("review_text"),
                    "review_location": review.get("review_location"),
                    "stars_rating": review.get("stars_rating"),
                    "scraped_at": datetime.now().isoformat()
                }
                reviews.append(review_info)
        
        for equipment in class_item["main_class_details"].get("what_you_need", []):
            equipment_info = {
                "equipment_id": f"{class_id}_{equipment.lower().replace(' ', '_')}",
                "class_id": class_id,
                "equipment_name": equipment,
                "scraped_at": datetime.now().isoformat()
            }
            equipment_needs.append(equipment_info)
        
        for related in class_item["related_classes"]:
            related_info = {
                "related_id": f"{class_id}_{len(related_classes)}",
                "main_class_id": class_id,
                "title": related.get("title"),
                "image_url": related.get("image_url"),
                "stars_rating": related.get("stars_rating"),
                "reviews_count": related.get("reviews_count"),
                "duration": related.get("duration"),
                "difficulty_level": related.get("difficulty_level"),
                "description": related.get("description"),
                "scraped_at": datetime.now().isoformat()
            }
            related_classes.append(related_info)
    
    all_data_files = {
        'kalm_classes.json': classes,
        'kalm_reviews.json': reviews,
        'kalm_equipment.json': equipment_needs,
        'kalm_related_classes.json': related_classes,
        'kalm_instructors.json': instructors_data
    }
    
    combined_data = {
        "classes": all_classes_data,
        "instructors": instructors_data,
        "scraped_at": datetime.now().isoformat()
    }
    
    all_data_files['kalm_all_data.json'] = combined_data
    
    for filename, data in all_data_files.items():
        filepath = os.path.join(output_dir, filename)
        with open(filepath, 'w', encoding='utf-8') as f:
            json.dump(data, f, indent=4, ensure_ascii=False)

    return {
        'classes': len(classes),
        'reviews': len(reviews), 
        'equipment': len(equipment_needs),
        'related_classes': len(related_classes),
        'instructors': len(instructors_data)
    }

 # main
if __name__ == "__main__":
    base_website_url = "https://kalmstudios.id"
    
    try:
        print("\nScraping Classes")
        main_driver = start_driver()
        class_urls_to_scrape = get_all_class_detail_urls(main_driver, base_website_url)
        main_driver.quit()
        
        if not class_urls_to_scrape:
            print("No class URLs found")
            exit()
        
        all_scraped_classes = []
        
        for i, url in enumerate(class_urls_to_scrape):
            driver_detail = start_driver() 
            class_detail_data = scrape_class_detail_page(driver_detail, url)
            
            if class_detail_data:
                all_scraped_classes.append(class_detail_data)
            
            driver_detail.quit()
            time.sleep(1)
        
        print("\nScraping Instructors")
        instructor_driver = start_driver()
        instructors_data = scrape_instructors_page(instructor_driver, base_website_url)
        instructor_driver.quit()

        print("\nSaving Data")
        stats = separate_and_save_all_data(all_scraped_classes, instructors_data)
        
        print("\nScraping completed")
        
    except Exception as e:
        print(f"Error: {e}")