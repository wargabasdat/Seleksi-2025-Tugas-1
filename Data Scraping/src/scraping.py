import os
import re
import json
import time
import subprocess
from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.common.by import By

def driver():
    try:
        subprocess.run(['taskkill', '/f', '/im', 'chrome.exe'], capture_output=True, check=False)
        subprocess.run(['taskkill', '/f', '/im', 'chromedriver.exe'], capture_output=True, check=False)
        print("Chrome processes killed")
        time.sleep(3)
    except:
        pass
    
    options = Options()
    options.add_argument('--headless=new')
    options.add_argument('--no-sandbox')
    options.add_argument('--disable-dev-shm-usage')
    options.add_argument('--disable-gpu')
    options.add_argument('--disable-web-security')
    options.add_argument('--disable-features=VizDisplayCompositor')
    options.add_argument('--window-size=1920,1080')
    options.add_argument('--incognito')
    options.add_argument('--disable-extensions')
    options.add_argument('--disable-plugins')
    options.add_argument('--max_old_space_size=4096')
    options.add_argument('--disable-background-timer-throttling')
    options.add_argument('--disable-backgrounding-occluded-windows')
    options.add_argument('--disable-renderer-backgrounding')
    options.add_argument('--disable-background-networking')
    options.add_argument('--disable-default-apps')
    options.add_argument('--disable-sync')
    options.add_argument('--no-first-run')
    options.add_argument('--disable-component-update')
    
    try:
        from webdriver_manager.chrome import ChromeDriverManager
        service = Service(ChromeDriverManager().install())
        print("Using ChromeDriverManager")
    except Exception as e:
        print(f"ChromeDriverManager failed: {e}")
        # Use local chromedriver
        service = Service(r'C:\Users\Velicia\OneDrive\Documents\ITB\SeleksiBasdat\chromedriver-win64\chromedriver.exe')
        print("Using local chromedriver")
    
    try:
        driver = webdriver.Chrome(service=service, options=options)
        driver.implicitly_wait(10)
        print("Chrome driver created successfully for Task Scheduler")
        return driver
    except Exception as e:
        print(f"Chrome driver creation failed: {e}")
        raise e


def get_program(html_text, data):
    soup = BeautifulSoup(html_text, 'lxml')
    
    programs = soup.find_all(class_="mega-menu-link")

    try:
        j = 1
        for i in range (22,30):
            data.append({
                'program_id': j,
                'program_name': programs[i].text.strip()
            })
            j += 1
    except Exception as e:
        print({e})

    return data

def extract_first_price(price_string):
    try:
        clean_string = price_string.replace('Rp.', '').replace('Rp', '').strip()
        price_match = re.search(r'([\d.]+)', clean_string)
        
        if price_match:
            first_price = price_match.group(1)
            return int(first_price.replace('.', ''))
        else:
            return 0
            
    except Exception as e:
        print(f"Error extracting price from '{price_string}': {e}")
        return 0
    
def extract_coding_class_details(detail_data, i):
    final_data = {
        'course_materials': '',
        'course_audience': '',
        'course_duration': '',
        'course_enrollment': '',
        'course_tuition': ''
    }

    try:
        if i < len(detail_data):
            final_data['course_materials'] = detail_data[i].text.strip()
        
        if i + 1 < len(detail_data):
            final_data['course_audience'] = detail_data[i + 1].text.strip()

        if i + 2 < len(detail_data):
            final_data['course_duration'] = detail_data[i + 2].text.strip()
        
        if i + 3 < len(detail_data):
            enroll_tuition = detail_data[i+3].text.strip()

            enrollment_match = re.search(r'^(.*?pendaftaran)', enroll_tuition, re.IGNORECASE)
            if enrollment_match:
                clean_enrollment = extract_first_price(enrollment_match.group(1))
                final_data['course_enrollment'] = clean_enrollment

            tuition_match = re.search(r'pendaftaran(.*?/bulan)', enroll_tuition, re.IGNORECASE)
            if tuition_match:
                clean_tuition = extract_first_price(tuition_match.group(1))
                final_data['course_tuition'] = clean_tuition
                
        print("Berhasil extract coding class info")

    except Exception as e:
        print(f"Error extract coding class info: {e}")

    return final_data

def get_coding_class_info(html_text, data): #https://kodekiddo.com/about/
    soup = BeautifulSoup(html_text, 'lxml')

    classes_name = soup.find_all('h3', class_='uagb-heading-text')
    all_p_elements = soup.find_all('p', class_='uagb-heading-text')

    i = 2
    j = 0
    try:
        while i < 23 and j < 5:
            detail_data = extract_coding_class_details(all_p_elements, i)
            data.append({
                'course_name': classes_name[j].text.strip(),
                'course_materials': detail_data['course_materials'],
                'course_audience': detail_data['course_audience'],
                'course_duration': detail_data['course_duration'],
                'course_enrollment': detail_data['course_enrollment'],
                'course_tuition': detail_data['course_tuition'],
                'program_id': 1
            })
            i += 4
            j += 1

    except Exception as e:
        print("Error dalam scraping coding class info")

    return data

def get_thematic_class(html_text, data):
    soup = BeautifulSoup(html_text, 'lxml')

    all_p_elements = soup.find_all('p', class_='uagb-heading-text')

    try:
        for i in range (2,28,2):
            curr = i
            topic = all_p_elements[curr].text
            curr += 1
            topic_desc = all_p_elements[curr].text  

            data.append({
                'topic': topic,
                'topic_description': topic_desc,
                'program_id': 2
            })  
    except Exception as e:
        print("Error dalam scraping thematic class")

    return data

def get_kiddo_stem_program(html_text, data): # https://kodekiddo.com/kiddostem/
    soup = BeautifulSoup(html_text, 'lxml')

    all_h3_elements = soup.find_all('h3', class_='uagb-heading-text')
    all_h4_elements = soup.find_all('h4', class_='uagb-heading-text')

    try:
        curr = 0
        for i in range (1,4):
            class_name = all_h3_elements[curr].text.lower()
            age = all_h4_elements[i].text.replace('for ','').replace('–', '-')
            curr += 1

            data.append({
                'class_name': class_name,
                'age': age,
                'program_id':4
            })
    except Exception as e:
        print("Error dalam scraping student classification")

    return data

def get_kinder_coding_packages (html_text, data): #https://kodekiddo.com/kindercoding/
    soup = BeautifulSoup(html_text, 'lxml')

    all_h3_elements = soup.find_all('h3', class_='uagb-heading-text')
    package_descriptions = soup.find_all('span', class_='uagb-icon-list__label')

    num = 0
    i = 7
    j = 0
    try:
        while num < 2:
            membership_length = package_descriptions[j].text.strip().lower().replace(' basis', '')
            j += 1
            num_of_session = package_descriptions[j].text.strip().lower().replace('for total ', '')
            clean_session = num_of_session.replace(' session', '')
            j += 1
            match_discount = package_descriptions[j].text.strip()
            if (match_discount == 'Siblings Discount'):
                discount = True
            else:
                discount = False

            data.append({
                'package_name': all_h3_elements[i].text.strip(),
                'membership_length': membership_length,
                'total_session': clean_session,
                'discount': discount,
                'program_id': 3
            })
            i += 1
            j += 1
            num += 1
    except Exception as e:
        print("Error scrape kinder coding package")
    
    return data

def extract_book_details (detail_data):
    final_data = {
        'writer': '',
        'translator':'',
        'total_pages':'',
        'length':'',
        'width':'',
        'spine':''
    }

    try:
        penulis_match = re.search(r'Penulis\s*:\s*(.*?)(?=\s*Penerjemah|\s*Jumlah|$)', detail_data, re.DOTALL | re.IGNORECASE)
        if penulis_match:
            final_data['writer'] = penulis_match.group(1).strip()
            print(final_data['writer'])        
        
        penerjemah_match = re.search(r'Penerjemah\s*:\s*(.*?)(?=\s*Jumlah\s+Halaman|$)', detail_data, re.DOTALL | re.IGNORECASE)
        if penerjemah_match:
            final_data['translator'] = penerjemah_match.group(1).strip()
            print(final_data['translator'])

        halaman_match = re.search(r'Jumlah\s+Halaman\s*:\s*(\d+)\s*hal', detail_data, re.IGNORECASE)
        if halaman_match:
            final_data['total_pages'] = halaman_match.group(1).strip()
            print(final_data['total_pages'])

        dimensi_match = re.search(r'P\s*x\s*L\s*:\s*(\d+(?:\.\d+)?)\s*cm\s*x\s*(\d+(?:\.\d+)?)\s*cm', detail_data, re.IGNORECASE)
        if dimensi_match:
            final_data['length'] = dimensi_match.group(1).strip()
            final_data['width'] = dimensi_match.group(2).strip()
            print(f"P: {final_data['length']}, L: {final_data['width']}")

        punggung_match = re.search(r'(\d+(?:\.\d+)?)\s*cm\s*x\s*(\d+(?:\.\d+)?)\s*cm', detail_data)
        if punggung_match:
            final_data['spine'] = punggung_match.group(1).strip()
            print(final_data['spine'])
    
        print("Berhasil extract book details")
        return final_data
    
    except Exception as e:
        print("Error extract book details")
        return None

def get_book (html_text, data): #https://kodekiddo.com/kiddo-press/
    soup = BeautifulSoup(html_text, 'lxml')
    
    all_h1_elements = soup.find_all('h1', class_='uagb-heading-text') # judul buku
    all_h3_elements = soup.find_all('h3', class_='uagb-heading-text') # subjudul buku
    all_p_elements = soup.find_all('p', class_='uagb-heading-text') #isbn 6,10,15,19,24 || detail buku xx, 14, 18, 23, 27
    detail_buku_1 = soup.find_all('p', class_='has-custom-gray-0-text-color') # detail buku lain ada di p
    
    extracting = True
    idx_title = 2
    idx_subtitle = 0
    idx_isbn = 6
    idx_detail = 14
    
    try:
        i = 0
        writer_data = []
        while (extracting):
            if (idx_title == 2):
                clean_isbn = all_p_elements[idx_isbn].text.strip().replace('ISBN: ','')
                details = detail_buku_1[0].text.strip()
                parsed_details = extract_book_details(details)
                data.append({
                    'book_id': i+1,
                    'program_id': 8,
                    'title': all_h1_elements[idx_title].text.strip(),
                    'subtitle': all_h3_elements[idx_subtitle].text.strip(),
                    'isbn': clean_isbn,
                    'writer': parsed_details['writer'],
                    'translator': parsed_details['translator'],
                    'total_pages': parsed_details['total_pages'], 
                    'length': parsed_details['length'],
                    'width': parsed_details['width'],
                    'spine': parsed_details['spine']
                })

                split_writer = parsed_details['writer'].split(', ')
                for writer in split_writer:
                    clean_writer = writer.strip()
                    writer_data.append({
                        'book_id': i+1,
                        'writer_name': clean_writer
                    })

                idx_title += 1
                idx_subtitle += 1
                i += 1

            elif (idx_title % 2 == 1):
                idx_isbn += 4
                clean_isbn = all_p_elements[idx_isbn].text.strip().replace('ISBN: ','')
                details = all_p_elements[idx_detail].text.strip()
                parsed_details = extract_book_details(details)
                data.append({
                    'book_id': i+1,
                    'program_id': 8,
                    'title': all_h1_elements[idx_title].text.strip(),
                    'subtitle': all_h3_elements[idx_subtitle].text.strip(),
                    'isbn': clean_isbn,
                    'writer': parsed_details['writer'],
                    'translator': parsed_details['translator'],
                    'total_pages': parsed_details['total_pages'], 
                    'length': parsed_details['length'],
                    'width': parsed_details['width'],
                    'spine': parsed_details['spine']
                })

                split_writer = parsed_details['writer'].split(',')
                for writer in split_writer:
                    clean_writer = writer.strip()
                    writer_data.append({
                        'book_id': i+1,
                        'writer_name': clean_writer
                    })

                idx_detail += 4
                idx_title += 1
                idx_subtitle += 1
                i += 1
            elif (idx_title % 2 == 0):
                idx_isbn += 5
                if (idx_title==6):
                    clean_isbn = all_p_elements[idx_isbn].text.strip().replace('ISBN : ','')
                else:
                    clean_isbn = all_p_elements[idx_isbn].text.strip().replace('ISBN: ','')
                details =  all_p_elements[idx_detail].text.strip()
                parsed_details = extract_book_details(details)
                data.append({
                    'book_id': i+1,
                    'program_id': 8,
                    'title': all_h1_elements[idx_title].text.strip(),
                    'subtitle': all_h3_elements[idx_subtitle].text.strip(),
                    'isbn': clean_isbn,
                    'writer': parsed_details['writer'],
                    'translator': parsed_details['translator'],
                    'total_pages': parsed_details['total_pages'], 
                    'length': parsed_details['length'],
                    'width': parsed_details['width'],
                    'spine': parsed_details['spine']
                })

                split_writer = parsed_details['writer'].split(',')
                for writer in split_writer:
                    clean_writer = writer.strip()
                    writer_data.append({
                        'book_id': i+1,
                        'writer_name': clean_writer
                    })

                idx_detail += 5
                idx_title += 1
                idx_subtitle += 1
                i += 1
            
            if (idx_title == 7):
                extracting = False

    except Exception as e:
        print("Error scraping book data")

    return data, writer_data

def get_zona (html_text, data):
    soup = BeautifulSoup(html_text, 'lxml')
    all_p_elements = soup.find_all('p', class_='uagb-heading-text')

    try:
        i = 1
        for p in all_p_elements:
            if ('Barat' in p.text):
                data.append({
                    'zone_id': i,
                    'details': p.text.strip()
                })
                i += 1
    except Exception as e:
        print(f"Error dalam scraping zona: {e}")

    return data

def get_book_price (html_text, data):
    soup = BeautifulSoup(html_text, 'lxml')

    #all_books = soup.find_all(class_='column-1')    
    price_1 = soup.find_all(class_='column-2')   
    price_2 = soup.find_all(class_='column-3')   
    price_3 = soup.find_all(class_='column-4')   
    price_4 = soup.find_all(class_='column-5')   
    price_5 = soup.find_all(class_='column-6') 
    price_6 = soup.find_all(class_='column-7')     

    try:
        for i in range (2,7):
            curr = i - 1
            data.append({
                'book_id': curr,
                'price_zone_1': price_1[i].text.replace('*','').replace(',',''),
                'price_zone_2': price_2[i].text.replace('*','').replace(',',''),
                'price_zone_3': price_3[i].text.replace('*','').replace(',',''),
                'price_zone_4': price_4[i].text.replace('*','').replace(',',''),
                'price_zone_5': price_5[i].text.replace('*','').replace(',',''),
                'price_zone_6': price_6[i].text.replace('*','').replace(',','')
            })
    except Exception as e:
        print("Error dalam scraping book price")
    
    return data

def get_branch(html_text, data):  #https://kodekiddo.com/our-center-locations/
    soup = BeautifulSoup(html_text, 'lxml')
    all_links = soup.find_all('a', href=True)

    try:
        for link in all_links:
            href = link.get('href')
            if href and ('center' in href.lower() and ('center-locations' not in href.lower())):
                data.append(href)
                print(href)
    except Exception as e:
        print("Error dalam scraping branch")
    
    return data

def get_data_per_branch(html_text, data):
    soup = BeautifulSoup(html_text, 'lxml')
    branch_name = soup.find('h3', class_='uagb-heading-text').text.strip()    
    p_elements = soup.find_all('p', class_='uagb-heading-text')
    branch_address = p_elements[1].text.strip()

    try:
        data.append({
            'branch_name': branch_name.replace('–', '-'),
            'address': branch_address
        })
    except Exception as e:
        print("Error dalam scraping data fix branch")

    return data

def get_paud_training (html_text, data): #https://kodekiddo.com/pelatihan-paud/
    soup = BeautifulSoup(html_text, 'lxml')
    all_column1 = soup.find_all('td', class_='column-1')
    all_column2 = soup.find_all('td', class_='column-2')
    all_column3 = soup.find_all('td', class_='column-3')

    for i in range (0,19):
        data.append({
            'training_id': f'paud{i+1}',
            'program_id': 6,
            'province': all_column1[i].text.strip(),
            'city': all_column2[i].text.strip(),
            'number_of_facilitators': all_column3[i].text.strip()
        })
    return data

def get_school_training(html_text, data, driver):
    page = 1
    
    while page < 3:
        try:
            soup = BeautifulSoup(html_text, 'lxml')
            all_column1 = soup.find_all('td', class_='column-1') 
            all_column2 = soup.find_all('td', class_='column-2')
            all_column3 = soup.find_all('td', class_='column-3')
            all_column4 = soup.find_all('td', class_='column-4')
            all_column5 = soup.find_all('td', class_='column-5')
            all_column6 = soup.find_all('td', class_='column-6')
            all_column7 = soup.find_all('td', class_='column-7')
            
            num_rows = min(len(all_column1),19)
            for i in range (num_rows):
                data.append({
                    'training_id': f'school{i+1}',
                    'program_id': 7,
                    'province': all_column1[i].text.strip(),
                    'city': all_column2[i].text.strip(),
                    'class_name': all_column3[i].text.strip(),
                    'target_audience': all_column4[i].text.strip(),
                    'lower_bound_price': all_column5[i].text.strip().replace(',',''),
                    'upper_bound_price': all_column6[i].text.strip().replace(',',''),
                    'training_branch': all_column7[i].text.strip()
                })

            try:
                next_button = driver.find_element(By.CSS_SELECTOR, 'button.dt-paging-button.next:not(.disabled)')
                driver.execute_script("arguments[0].click();", next_button)
                time.sleep(3)
                html_text = driver.page_source 
                page += 1
            except:
                print("Data school training sudah discrape semua")
                break
        except:
            print("Error scraping school training")

        return data

def parse_string_to_date(date_string):
    month_mapping = {
        'jan': '01', 'januari': '01',
        'feb': '02', 'februari': '02',
        'mar': '03', 'maret': '03',
        'apr': '04', 'april': '04',
        'mei': '05',
        'jun': '06', 'juni': '06',
        'jul': '07', 'jul': '07',
        'agu': '08', 'agustus': '08', 
        'sep': '09', 'september': '09',
        'okt': '10', 'oktober': '10',
        'nov': '11', 'november': '11',
        'des': '12', 'desember': '12',
    }
    
    date_string = date_string.strip().lower()
    
    try:
        # Pattern 1, contoh: Nov 2020 - Jan 2021 (ambil tanggal pertama pelaksanaan)
        range_pattern = r'(\w+)\s+(\d{4})\s*[–-]\s*(\w+)\s+(\d{4})'
        range_match = re.match(range_pattern, date_string)
        if range_match:
            start_month, start_year, end_month, end_year = range_match.groups()
            start_month_num = month_mapping.get(start_month, '01')
            return f"{start_year}-{start_month_num}-01" 
        
        # Pattern 2, contoh: 1,2,3 Mei 2020 (ambil tanggal pertama pelaksanaan)
        comma_pattern = r'([\d,\s&]+)\s+(\w+)\s+(\d{4})'
        comma_match = re.match(comma_pattern, date_string)
        if comma_match:
            dates_part, month, year = comma_match.groups()
            first_date = re.findall(r'\d+', dates_part)[0]
            month_num = month_mapping.get(month, '01')
            return f"{year}-{month_num}-{first_date.zfill(2)}"
        
        # Pattern 3, contoh: 15 & 16 Mei 2020 (ambil tanggal pertama pelaksanaan)
        and_pattern = r'(\d+)\s*&\s*(\d+)\s+(\w+)\s+(\d{4})'
        and_match = re.match(and_pattern, date_string)
        if and_match:
            first_date, second_date, month, year = and_match.groups()
            month_num = month_mapping.get(month, '01')
            return f"{year}-{month_num}-{first_date.zfill(2)}"
        
        # Pattern 4, contoh: 21 Mei 2020
        simple_pattern = r'(\d+)\s+(\w+)\s+(\d{4})'
        simple_match = re.match(simple_pattern, date_string)
        if simple_match:
            day, month, year = simple_match.groups()
            month_num = month_mapping.get(month, '01')
            return f"{year}-{month_num}-{day.zfill(2)}"
            
        # else:
        return "2000-01-01"  
        
    except Exception as e:
        print(f"Error parsing date '{date_string}': {e}")
        return "2000-01-01"
    
def get_webinar(html_text, data):
    soup = BeautifulSoup(html_text, 'lxml')

    all_h3_elements = soup.find_all('h3', class_='uagb-heading-text')
    all_p_elements = soup.find_all('p', class_='uagb-heading-text')

    for i in range (0, 22):
        curr = i
        date = all_p_elements[curr+3].text.strip()
        data.append({
            'webinar_name': all_h3_elements[i].text.strip(),
            'webinar_date': parse_string_to_date(date),
            'program_id': 5
        })
    return data

def write_json(data, filename):
    base_path = r'C:\Users\Velicia\OneDrive\Documents\ITB\SeleksiBasdat\TUGAS_SELEKSI_1_18223085\Data Scraping\data'
    
    file = os.path.basename(filename)
    full_path = os.path.join(base_path, file)
    
    # Create directory if not exists
    os.makedirs(base_path, exist_ok=True)
    
    try:
        with open(full_path, 'w', encoding='utf-8') as f:
            json.dump(data, f, indent=2, ensure_ascii=False)
        
        print(f"JSON saved: {full_path}")
        return True
        
    except Exception as e:
        print(f"Error saving {full_path}: {e}")
        return False

def main():
    # all data container
    all_data = {
        'program': [],
        'coding_class_info': [],
        'thematic_class': [],
        'kiddo_stem_program': [],
        'kinder_coding_package': [],
        'books': [],
        'book_writer': [],
        'books_price': [],
        'zone': [],
        'branch': [],
        'paud_teacher_training': [],
        'school_teacher_training': [],
        'webinar': []
    }

    # 1. Scrape Program 
    web_driver = driver()
    web_driver.get('https://kodekiddo.com/')
    html_text = web_driver.page_source
    try:
        all_data['program'] = get_program(html_text, [])
        print("Berhasil scrape program")
        write_json(all_data['program'], 'program.json')
        time.sleep(3)
    except Exception as e:
        print("Error dalam scraping program")

    # 2. Scrape Coding Class Info
    try:
        web_driver.get('https://kodekiddo.com/about/')
        time.sleep(3)
        html_text = web_driver.page_source
        all_data['coding_class_info'] = get_coding_class_info(html_text, [])
        print("Berhasil scrape coding class info")
        write_json(all_data['coding_class_info'], 'coding_class_info.json')
    except Exception as e:
        print("Error dalam scraping coding class info")

    # 3. Scrape Thematic Class
    try:
        web_driver.get('https://kodekiddo.com/thematic-class/')
        time.sleep(3)
        html_text = web_driver.page_source
        all_data['thematic_class'] = get_thematic_class(html_text, [])
        print("Berhasil scrape thematic class")
        write_json(all_data['thematic_class'], 'thematic_class.json')
    except Exception as e:
        print("Error dalam scraping thematic class")   

    # 4. Scrape Kiddo STEM Program
    try:
        web_driver.get('https://kodekiddo.com/kiddostem/')
        time.sleep(3)
        html_text = web_driver.page_source
        all_data['kiddo_stem_program'] = get_kiddo_stem_program(html_text, [])
        print("Berhasil scrape kiddo stem")
        write_json(all_data['kiddo_stem_program'], 'kiddo_stem_program.json')
        time.sleep(3)
    except Exception as e:
        print("Error dalam scraping kiddo stem")    

    # 5. Scrape Kinder Coding Package
    try:
        web_driver.get('https://kodekiddo.com/kindercoding/')
        html_text = web_driver.page_source
        all_data['kinder_coding_package'] = get_kinder_coding_packages(html_text, [])
        print("Berhasil scrape kinder coding package")
        write_json(all_data['kinder_coding_package'], 'kinder_coding_package.json')
        time.sleep(3)
    except Exception as e:
        print("Error scrape kinder coding package")

    try:
        web_driver.get('https://kodekiddo.com/kiddo-press/')
        time.sleep(3)
        html_text = web_driver.page_source
        # 7. Scrape Book
        try:
            all_data['books'], all_data['book_writer'] = get_book(html_text, [])
            print("Berhasil scrape book")
            write_json(all_data['books'], 'books.json')
            write_json(all_data['book_writer'], 'book_writer.json')
            time.sleep(3)
        except Exception as e:
            print("Error dalam scraping book")  

        # 8. Scrape Book Price
        try:
            all_data['books_price'] = get_book_price(html_text, [])
            print("Berhasil scrape book price")
            write_json(all_data['books_price'], 'books_price.json')
            time.sleep(3)
        except Exception as e:
            print("Error dalam scraping book price") 

        # 6. Scrape Zone
        try:
            all_data['zone'] = get_zona(html_text, [])
            print("Berhasil scrape zone")
            write_json(all_data['zone'], 'zone.json')
            time.sleep(3)
        except Exception as e:
            print("Error dalam scraping zone")  

    except Exception as e:
        print("Error dalam buka website kiddo press")
    finally:
        print("Selesai KIDDO PRESS")

    # 9. Scrape Branch
    try:
        web_driver.get('https://kodekiddo.com/our-center-locations/')
        time.sleep(3)
        html_text = web_driver.page_source
        
        links_of_branch = get_branch(html_text, [])
        print("Berhasil dapat semua link branch")
        
        for link in links_of_branch:
            try:
                print(f"Scraping branch: {link}")
                web_driver.get(link) 
                time.sleep(3)  
                branch_html = web_driver.page_source 
                
                branch_data = get_data_per_branch(branch_html, [])
                all_data['branch'].extend(branch_data)  
                
            except Exception as e:
                print(f"Error scrape branch {link}: {e}")
        
        print("Berhasil scrape branch")
        write_json(all_data['branch'], 'branch.json')
        
    except Exception as e:
        print(f"Error dalam scraping branch: {e}")  
    finally:
        if web_driver:
            print("Selesai BRANCH")
    
    # 10. Scrape Paud Teacher Training
    try:
        web_driver.get('https://kodekiddo.com/pelatihan-paud/')
        html_text = web_driver.page_source
        all_data['paud_teacher_training'] = get_paud_training(html_text, [])
        print("Berhasil scrape paud teacher training")
        write_json(all_data['paud_teacher_training'], 'paud_teacher_training.json')
        time.sleep(3)
    except Exception as e:
        print("Error scrape paud training")

    # 11. Scrape School Teacher Training
    try:
        web_driver.get('https://kodekiddo.com/pelatihan-guru/')
        html_text = web_driver.page_source
        all_data['school_teacher_training'] = get_school_training(html_text, [], web_driver)
        print("Berhasil scrape school teacher training")
        write_json(all_data['school_teacher_training'], 'school_teacher_training.json')
        time.sleep(3)
    except Exception as e:
        print("Error scrape school teacher training")

    # 12. Scrape Webinar
    try:
        web_driver.get('https://kodekiddo.com/webinar-dan-workshop/')
        html_text = web_driver.page_source
        all_data['webinar'] = get_webinar(html_text, [])
        print("Berhasil scrape webinar")
        write_json(all_data['webinar'], 'webinar.json')
        time.sleep(3)
    except Exception as e:
        print("Error scrape webinar")

    if (web_driver):
        print("TUTUP WEB DRIVER")
        web_driver.quit()

if __name__ == "__main__":
    main()
