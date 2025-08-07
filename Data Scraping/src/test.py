import requests
from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import json
import time
import re

def driver():
    options = Options()
    options.add_argument("--no-sandbox")
    options.add_argument("--disable-dev-shm-usage")
    options.add_argument("--disable-gpu") 
    options.add_argument("--window-size=1920,1080") 
    
    custom_user_agent = (
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
        "(KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36"
    )
    options.add_argument(f"user-agent={custom_user_agent}")
    service = Service(r'C:\Users\Velicia\OneDrive\Documents\ITB\SeleksiBasdat\chromedriver-win64\chromedriver.exe')
    
    driver = webdriver.Chrome(service=service, options=options)
    
    driver.implicitly_wait(10)
    
    return driver

driver = driver()
link = driver.get('https://kodekiddo.com/webinar-dan-workshop/')
html_text = driver.page_source
soup = BeautifulSoup(html_text, 'lxml')

h3 = soup.find_all('h3', class_='uagb-heading-text') # 0-22
i = 0
for h in h3:
    print(f'{i+1}. {h.text}')
    i += 1

para = soup.find_all('p', class_='uagb-heading-text') # 3-25
i = 0
for p in para:
    print(f'{i+1}. {p.text}')
    i += 1