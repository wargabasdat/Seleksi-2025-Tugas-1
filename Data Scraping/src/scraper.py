from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.wait import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.chrome.options import Options
import json
import time

# Header perkenalan
chrome_options = Options()
user_agent = "Mozilla/5.0"
chrome_options.add_argument(f'user-agent={user_agent}')

# Inisialisasi WebDriver
driver = webdriver.Chrome(options=chrome_options)
driver.get("https://www.cgv.id")

#List kontainer data
all_cities = []
all_cinemas = []
all_auditorium = []
auditorium_idx = 0

# Masuk ke page cinemas
cinemas = driver.find_element(By.LINK_TEXT, "CINEMAS")
cinemas.click()

# Mengambil daftar kota
city_list = driver.find_elements(By.CLASS_NAME, "city")

# Iterasi data tiap kota
for city_idx in range(len(city_list)):
    city_list = driver.find_elements(By.CLASS_NAME, "city")
    city = city_list[city_idx]
    city_element = city.find_element(By.TAG_NAME, 'a')
    city_name = city_element.text # Ambil nama kota
    city_id = city_element.get_attribute("id") # Ambil ID kota
    print(f"Scraping cinemas in {city_name} data")
    
    # Membuat dictionary kota
    city_data = {
        'CityID' : city_id,
        'CityName' : city_name
    }
    # Masukkan ke list dictionaries kota
    all_cities.append(city_data)

    # Tekan kota untuk mengubah page agar bisa mengambil data bioskop di kota tersebut
    city.click()

    # Inisialisasi
    cinema_list = city.find_elements(By.CLASS_NAME, "cinema_fav")
    cinema_links = [] # List kontainer link bioskop
    cinema_ids = [] # List kontainer ID bioskop
    cinema_idx = 0
    
# Ambil link dan id bioskop
    for cinema in cinema_list:
        cinema_links.append(cinema.get_attribute("href")) # Link tiap bioskop di-save dulu 
        cinema_ids.append(cinema.get_attribute("id")) # Masukkan ID bioskop-bioskop di kota ini ke list

# Ambil data bioskop
    for link in cinema_links:
        # Redirect ke page bioskop
        driver.get(link)

        # Ambil id dan nama bioskop
        cinema_id = driver.find_element(By.ID, cinema_ids[cinema_idx]).get_attribute("id")
        cinema_name = driver.find_element(By.ID, cinema_ids[cinema_idx]).text

        # Tunggu data lengkap bioskop ke-load
        WebDriverWait(driver, 10).until(EC.presence_of_element_located((By.CLASS_NAME, "col-info-cinema-sch")))

        # Ambil alamat bioskop
        cinema_raw_address = driver.find_element(By.CLASS_NAME, "col-info-cinema-sch").text.split('\n')
        cinema_address = cinema_raw_address[1].strip()

        # Ambil auditorium
        audi_list = [] # List kontainer jenis auditorium di bioskop ini
        audi_raw_list = driver.find_elements(By.CLASS_NAME, "audi_image")
        for audi in audi_raw_list:
            img = audi.find_element(By.TAG_NAME, "img").get_attribute("alt").split(' ')
            audi_type = img[1].strip()
            audi_list.append(audi_type)
            # Ambil data unik jenis auditorium
            if not any(auditorium['name'] == audi_type for auditorium in all_auditorium):
                # Buat dictionary audi
                auditorium_data = {
                    'id' : auditorium_idx,
                    'name' : audi_type
                }
                all_auditorium.append(auditorium_data)
                auditorium_idx += 1

        # Buat dictionary bioskop
        cinema_data = {
            'CityID' : city_id,
            'CinemaID' : cinema_id,
            'CinemaName' : cinema_name,
            'CinemaAddress' : cinema_address,
            'auditoriumTypes' : audi_list
        }
        all_cinemas.append(cinema_data)

        # city_data['Cinemas'].append(cinema_data)
        # print(f"    {audi_list}")


        time.sleep(0.25) # Beri jeda sebentar supaya ga terlalu ngebut
        # WebDriverWait(driver, 10).until(EC.presence_of_element_located((By.CLASS_NAME, "cinema_fav")))
        cinema_idx += 1
    # scraped_data.append(city_data)


# Buka file dalam mode write dan simpan data ke masing-masing json
with open('data/city.json', 'w', encoding='utf-8') as f:
    json.dump(all_cities, f, ensure_ascii=False, indent=4)

with open('data/cinema.json', 'w', encoding='utf-8') as f:
    json.dump(all_cinemas, f, ensure_ascii=False, indent=4)

with open('data/auditorium.json', 'w', encoding='utf-8') as f:
    json.dump(all_auditorium, f, ensure_ascii=False, indent=4)

print(f"Data berhasil disimpan ke masing-masing path")

input("Enter to close the tab..")
driver.quit()