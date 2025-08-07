import re
from datetime import datetime

def parse_date_to_standard_format(date_string):
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
            
        # selain itu:
        return "2000-01-01"  
        
    except Exception as e:
        print(f"Error parsing date '{date_string}': {e}")
        return "2000-01-01"

# Test dengan data Anda
test_dates = [
    "27 Mei 2023",
    "23 Oktober 2022", 
    "15 May 2022",
    "4 & 5 Jul 2020",
    "25 & 30 Mei 2020",
    "1,2,3 Mei 2020",
    "Nov 2020 – Jan 2021"
]

for date_str in test_dates:
    converted = parse_date_to_standard_format(date_str)
    print(f"'{date_str}' -> '{converted}'")