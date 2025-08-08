import requests, time, json, os, tqdm, concurrent.futures
from bs4 import BeautifulSoup, NavigableString

month_to_number = {
    "January": '1',
    "February": '2',
    "March": '3',
    "April": '4',
    "May": '5',
    "June": '6',
    "July": '7',
    "August": '8',
    "September": '9',
    "October": '10',
    "November": '11',
    "December": '12'
}

# link:         https://genshin-impact.fandom.com/wiki/Characters
# format:       {'Name', 'Rarity', 'Element', 'Weapon Type', 'Region', 'Body Type', 'Gender', 'Birthday Month', 'Birthday Day', 
#                'Version', 'Ascension Stat', 'Base Stats': {'HP', 'ATK', 'DEF'}, 'Burst Cost', 'Boss Drop'}
# output file:  characters.json
def scrape_characters(URL):
    try:
        # mengambil data karakter
        URL += "Characters"
        
        response = requests.get(URL, headers=HEADERS, timeout=10)
        response.raise_for_status()
        print(f"Berhasil mengakses /Characters dengan status code: {response.status_code}")

        soup = BeautifulSoup(response.text, 'html.parser')
        table = soup.find('table', class_="fandom-table")

        # lewati header baris pertama
        rows = table.find_all('tr')[1:]
        
        all_characters_data = []

        # menggunakan threading agar berjalan efisien
        with concurrent.futures.ThreadPoolExecutor(max_workers=10) as executor:
            results = list(tqdm.tqdm(executor.map(process_characters_row, rows), total=len(rows)))

        # filter hasil yang none (baris header, traveler, atau error)
        all_characters_data = [res for res in results if res is not None]

        # print("\n--- HASIL SCRAPING ---")
        # if all_characters_data:
        #     print("Berhasil menemukan karakter:")
        #     for character in all_characters_data:
        #         print(character)
        # else:
        #     print("Tidak dapat menemukan kontainer avatar atau link di dalamnya.")

        with open(os.path.join('..', 'data', 'characters.json'), 'w') as json_file:
            json.dump(all_characters_data, json_file, indent=4)

    except Exception as e:
        raise Exception(f"Terjadi error saat scraping: {e}")

def process_characters_row(row):
    try:
        cells = row.find_all('td')

        name = cells[1].get_text(strip=True)

        # karakter 'Traveler' merupakan main character, memiliki banyak data kosong sehingga diabaikan
        if name == 'Traveler':
            return None
        
        # cleaning: menangani nilai none, menghapus spasi berlebih
        rarity = cells[2].find('span', title=True)['title'][0]
        element = cells[3].get_text(strip=True)
        weapon = cells[4].get_text(strip=True)
        region = cells[5].get_text(strip=True) if cells[5].get_text(strip=True) != 'None' else "N/A"
        
        # parsing: memisah model menjadi body type dan gender
        model = cells[6].get_text(strip=True)
        body_type = model.split(' ')[0]
        gender = model.split(' ')[1]

        URL = "https://genshin-impact.fandom.com/wiki/" + name.replace(" ", "_")
        response = requests.get(URL, headers=HEADERS, timeout=10)
        soup = BeautifulSoup(response.text, 'html.parser')

        # panggil fungsi helper untuk mengambil detail karakter dari page karakter tersebut
        birthday_month, birthday_day, version, asc_stat, base_stats, burst_cost, boss_drop = scrape_characters_details(soup)            
        
        # transformation: mengubah nilai base stats menjadi float 
        base_hp = float(base_stats.get("HP", "0").replace(',', ''))
        base_atk = float(base_stats.get("ATK", "0").replace(',', ''))
        base_def = float(base_stats.get("DEF", "0").replace(',', ''))
        base_stats = {
            "HP": base_hp,
            "ATK": base_atk,
            "DEF": base_def
        }

        character_info = {
            "Name": name,
            "Rarity": rarity,
            "Element": element,
            "Weapon Type": weapon,
            "Region": region,
            "Body Type": body_type,
            "Gender": gender,
            "Birthday Month": birthday_month,
            "Birthday Day": birthday_day,
            "Version": version,
            "Ascension Stat": asc_stat,
            "Base Stats": base_stats,
            "Burst Cost": burst_cost,
            "Boss Drop": boss_drop
        }
        return character_info

    except Exception as e:
        raise Exception(f"Terjadi error saat scraping: {e}")

def scrape_characters_details(soup):
    try:
        # ambil birthday karakter
        birthday_month = "N/A"
        birthday_day = "N/A" 

        container = soup.find('div', attrs={'data-source': 'birthday'})
        if container:
            value_div = container.find('div', class_='pi-data-value')

            if value_div:
                birthday = value_div.get_text(strip=True)

                # transformation: mengubah bulan menjadi angka
                # transformation: menghapus akhiran 'th', 'st', 'nd', 'rd' pada hari
                birthday_month = month_to_number[birthday.split(' ')[0]]
                birthday_day = birthday.split(' ')[1][:-2]

        # ambil versi karakter dirilis
        # pengecualian: karakter 'Aloy' diberikan sebagai hadiah, tidak memiliki versi rilis
        version = "N/A"
        table = soup.find('table', class_="article-table sortable tdc1 tdc4")
        if table:
            rows = table.find('tbody').find_all('tr')
            for row in rows:
                cells = row.find_all('a')
                if cells:
                    last_cell = cells[-1]
                    version = last_cell.get_text(strip=True)
                    break
        
        # ambil ascension stat dan base stats karakter
        asc_stat = "N/A"
        base_hp = "N/A"
        base_atk = "N/A"
        base_def = "N/A"

        table = soup.find('table', class_="wikitable ascension-stats")
        if table:
            header_row = table.find('tr')
            if header_row:
                headers = header_row.find_all('th')
                for header in headers:
                    asc_header = header.find('span', title="Characters unlock an additional attribute starting with Ascension Phase 2✦.")
                    if asc_header:
                        asc_stat = asc_header.get_text(strip=True)
                        break

            data_rows = table.find_all('tr')[1:]
            if data_rows:
                last_row = data_rows[len(data_rows) - 1]
                cells = last_row.find_all('td')
                
                if len(cells) >= 4:
                    base_hp = cells[1].get_text(strip=True)
                    base_atk = cells[2].get_text(strip=True)
                    base_def = cells[3].get_text(strip=True)
        
        base_stats = {
            "HP": base_hp,
            "ATK": base_atk,
            "DEF": base_def
        }
            
        # print(f"Ascension Stat: {asc_stat}")
        # print(f"Base HP: {base_hp}")
        # print(f"Base ATK: {base_atk}")
        # print(f"Base DEF: {base_def}")

        # ambil burst energy cost
        burst_energy_cost = "N/A"
        label = soup.find('th', string='Energy Cost')

        if label:
            value_cell = label.find_next_sibling('td')
            if value_cell:
                burst_energy_cost = value_cell.get_text(strip=True)

        # print(f"Energy Cost yang ditemukan: {burst_energy_cost}")

        boss_drop = "N/A"
        total_materials = []
        total_cost_label = soup.find('b', string='Total Cost')

        if total_cost_label:
            parent_p = total_cost_label.find_parent('p')

            if parent_p:
                card_list = parent_p.find_next_sibling('span', class_='card-list-container')

                if card_list:
                    cards = card_list.find_all('div', class_='card-container')
                    
                    for card in cards:
                        caption = card.find('span', class_='card-caption')

                        if caption:
                            material = caption.get_text(strip=True).replace('\u00ad', '').replace('\u2014', '-')
                            total_materials.append(material)
                        
        if total_materials:
            boss_drop = total_materials[1]
        
        # print(f"Boss Drop yang ditemukan: {boss_drop}")

        return birthday_month, birthday_day, version, asc_stat, base_stats, burst_energy_cost, boss_drop

    except Exception as e:
        raise Exception(f"Terjadi error saat scraping detail karakter: {e}")

# link:         https://genshin-impact.fandom.com/wiki/Character
# format:       {'Version', 'Year', 'Month', 'Date'}
# output file:  versions.json
def scrape_versions(URL):
    try:
        # ambil data versi game dan tanggal rilisnya
        URL += "Character"

        response = requests.get(URL, headers=HEADERS, timeout=10)
        response.raise_for_status()
        print(f"Berhasil mengakses /Character dengan status code: {response.status_code}")

        soup = BeautifulSoup(response.text, 'html.parser')
        version_container = soup.find('div', class_="change-history-content")
        all_versions_data = []
        versions_number = []

        if version_container:
            all_links = version_container.find_all(['p', 'a'])

            for link in all_links:
                link_text = link if link.name == 'a' else link.find('a')
                if link_text and 'Version' in link_text.get_text():
                    version_name = link_text.get_text(strip=True)
                    date_text = "N/A" 

                    details_list = link.find_next('ul')
                    if details_list:
                        date_tag = details_list.find('b')
                        if date_tag:
                            date_text = date_tag.get_text(strip=True)

                    version_name = version_name.split(' ')[1]
                    if version_name in versions_number:
                        continue
                    
                    # parsing: memisah versi menjadi major dan minor
                    # parsing: memisah tanggal rilis versi ke dalam tahun - bulan - tanggal
                    version_info = {
                        "Major Version": version_name[0],
                        "Minor Version": version_name[2],
                        "Year": date_text.split(' ')[2][:-1],
                        "Month": month_to_number[date_text.split(' ')[0]],
                        "Date": date_text.split(' ')[1][:-1],
                    }
                    all_versions_data.append(version_info)
                    versions_number.append(version_name)

        # if all_versions_data:
        #     print("\nDaftar Versi:")
        #     for version in all_versions_data[:10]:
        #         print(version)
        # else:
        #     print("Tidak dapat menemukan daftar versi.")

        with open(os.path.join('..', 'data', 'versions.json'), 'w') as json_file:
            json.dump(all_versions_data, json_file, indent=4)

    except Exception as e:
        raise Exception(f"Terjadi error saat scraping: {e}")

# link:         https://genshin-impact.fandom.com/wiki/Domain
# format:       {'Name', 'Artifacts', 'Region', 'Version'} 
# output file:  domains.json
def scrape_domain(URL):
    try:
        # ambil data domain dan artefak di dalamnya
        URL += "Domain"

        response = requests.get(URL, headers=HEADERS, timeout=10)
        response.raise_for_status()
        print(f"Berhasil mengakses /Domain dengan status code: {response.status_code}")

        domain_container = None

        # website /Domain sering tidak stabil, pastikan kontainer domain ditemukan sebelum melanjutkan
        while domain_container is None:
            soup = BeautifulSoup(response.text, 'html.parser')
            domain_container = soup.find('div', id="gallery-4")

            if domain_container is None:
                # jika tidak ditemukan, tunggu 1 detik dan coba lagi
                print("mengulangi pencarian domain")
                time.sleep(1)
                response = requests.get(URL, headers=HEADERS, timeout=10)

        all_domains_data = []
        all_links = domain_container.find_all('a', title=True)

        for link in all_links:
            domain_name = link['title']
            
            # cleaning: pastikan hanya mengambil domain artefak, bukan domain lain
            if domain_name[-1] == ')':
                continue
            all_domains_data.append(domain_name)

        output = []
        for i in tqdm.tqdm(range(0, len(all_domains_data), 5)):
            domain_name = all_domains_data[i]
            URL = "https://genshin-impact.fandom.com/wiki/" + domain_name.replace(" ", "_")
            response = requests.get(URL, headers=HEADERS, timeout=10)
            soup = BeautifulSoup(response.text, 'html.parser')
            region, version = scrape_artifacts_domain_details(soup)
            
            domain = {
                "Name": domain_name,
                "Artifacts": [all_domains_data[i + j] for j in range(1, 5)],
                "Region": region,
                "Version": version
            }
            output.append(domain)
    
        # if output:
        #     print("\nDaftar Domain:")
        #     for domain in output:
        #         print(domain)
        # else:
        #     print("Tidak dapat menemukan daftar domain.")

        with open(os.path.join('..', 'data', 'domains.json'), 'w') as json_file:
            json.dump(output, json_file, indent=4)

    except Exception as e:
        raise Exception(f"Terjadi error saat scraping: {e}")

def scrape_artifacts_domain_details(soup):
    try:
        # ambil region domain berada
        container = soup.find('h3', string='Location')
        location = "N/A"
        
        if container:
            value = container.find_next_sibling('div', class_='pi-data-value')

            if value:
                all_locations = value.find_all('a')

                if all_locations:
                    last_location = all_locations[-1]
                    location = last_location.get_text(strip=True)

        # ambil versi domain dirilis
        container = soup.find('span', id='Change_History')
        version = "N/A"

        if container:
            headline_h2 = container.find_parent('h2')

            if headline_h2:
                history_container = headline_h2.find_next_sibling('div', class_='change-history')

                if history_container:
                    version_tag = history_container.find(lambda tag: tag.name == 'a' and tag.has_attr('title') and 'Version' in tag['title'])

                    if version_tag:
                        version = version_tag.get_text(strip=True)[8:]
        
        return location, version
    
    except Exception as e:
        raise Exception(f"Terjadi error saat scraping detail domain: {e}")

# link:         https://genshin-impact.fandom.com/wiki/Artifact
# format:       {'Name', 'Rarity', '2-piece Bonus', '4-piece Bonus'}
# output file:  artifacts.json
def scrape_artifacts(URL):
    URL += "Artifact"

    # ambil list nama artefak dengan URL link detail
    artifact_list = scrape_artifact_list(URL)

    # menggunakan threading agar berjalan efisien
    with concurrent.futures.ThreadPoolExecutor(max_workers=10) as executor:
        results = list(tqdm.tqdm(executor.map(scrape_single_artifact_details, artifact_list), total=len(artifact_list)))
    
    all_artifacts_data = [res for res in results if res is not None]

    with open(os.path.join('..', 'data', 'artifacts.json'), 'w') as json_file:
        json.dump(all_artifacts_data, json_file, indent=4)

def scrape_artifact_list(URL):
    response = requests.get(URL, headers=HEADERS, timeout=10)
    response.raise_for_status()
    print(f"Berhasil mengakses /Artifact dengan status code: {response.status_code}")

    soup = BeautifulSoup(response.text, 'html.parser')
    artifact_container = soup.find('span', class_="card-list-container")
    
    tasks = []
    if artifact_container:
        cards = artifact_container.find_all('div', class_='card-container')

        for card in cards:
            caption = card.find('span', class_='card-caption')

            if caption:
                artifact_name = caption.get_text(strip=True).replace('\u00ad', '')
                detail_url = "https://genshin-impact.fandom.com/wiki/" + artifact_name.replace(" ", "_")
                
                tasks.append({
                    "Name": artifact_name,
                    "URL": detail_url
                })

    return tasks

def scrape_single_artifact_details(artifact_task):
    try:
        name = artifact_task["Name"]
        url = artifact_task["URL"]
        
        response = requests.get(url, headers=HEADERS, timeout=10)
        soup = BeautifulSoup(response.text, 'html.parser')

        # panggil fungsi helper
        rarities, two_p, four_p = scrape_artifacts_details(soup)
        
        # cleaning: pastikan hanya memasukan artefak dengan bonus 2-piece atau 4-piece
        # (terdapat artefak dengan bonus 1-piece, tapi tidak umum digunakan)
        if two_p == "N/A" and four_p == "N/A":
            return None

        return {
            "Name": name,
            "Rarity": rarities,
            "2-piece Bonus": two_p,
            "4-piece Bonus": four_p
        }

    except Exception as e:
        print(f"\nError saat memproses {artifact_task.get('Name')}: {e}")
        return None

def scrape_artifacts_details(soup):
    try:
        # ambil data rarity artefak
        rarities = []
        header = soup.find('h2', string='How to Obtain')

        if header:
            tab_container = header.find_next_sibling('section', class_='pi-item pi-panel pi-border-color wds-tabber')

            if tab_container:
                labels = tab_container.find_all('div', class_='wds-tabs__tab-label')

                for label in labels:
                    rarity = label.get_text(strip=True)[:1]
                    rarities.append(rarity)
        
        # ambil data bonus artefak
        two_piece_bonus_description = "N/A"
        four_piece_bonus_description = "N/A"

        for i in range(2):
            if i == 0:
                label_tag = soup.find('b', string='2-Piece Bonus')
            else:
                label_tag = soup.find('b', string='4-Piece Bonus')
            
            if label_tag:
                text_pieces = []
                for sibling in label_tag.next_siblings:
                    if hasattr(sibling, 'get_text'):
                        text_pieces.append(sibling.get_text(strip=True))
                    elif isinstance(sibling, NavigableString):
                        text_pieces.append(sibling.strip())   
            
                if text_pieces:
                    # cleaning: menghapus soft hyphen yang tidak diinginkan
                    result = ' '.join(text_pieces).replace('\u00ad', '')
                    if i == 0:
                        two_piece_bonus_description = result[1:]
                    else:
                        four_piece_bonus_description = result[1:]

        return rarities, two_piece_bonus_description, four_piece_bonus_description

    except Exception as e:
        raise Exception(f"Terjadi error saat scraping detail artefak: {e}")

def scrape_weapons(URL):
    try:
        # ambil data senjata
        URL += "Weapon/List"

        response = requests.get(URL, headers=HEADERS, timeout=10)
        response.raise_for_status()
        print(f"Berhasil mengakses /Weapon/List dengan status code: {response.status_code}")

        soup = BeautifulSoup(response.text, 'html.parser')
        table = soup.find('table', class_="article-table alternating-colors-table sortable mw-collapsible")
        weapon_names = []

        URL = "https://genshin-impact.fandom.com/wiki/Weapon"
        response = requests.get(URL, headers=HEADERS, timeout=10)
        soup = BeautifulSoup(response.text, 'html.parser')

        # panggil fungsi helper untuk mengambil versi rilis senjata
        weapon_version = scrape_weapons_version(soup)

        rows = table.find_all('tr')[1:]

        with concurrent.futures.ThreadPoolExecutor(max_workers=10) as executor:
            results = list(tqdm.tqdm(executor.map(process_weapons_row, rows, [weapon_version]*len(rows)), total=len(rows)))

        all_weapons_data = [res for res in results if res is not None]
        
        # print("\nDaftar Senjata:")
        # if all_weapons_data:
        #     for weapon in all_weapons_data:
        #         print(weapon)
        # else:
        #     print("Tidak dapat menemukan daftar senjata.")

        with open(os.path.join('..', 'data', 'weapons.json'), 'w') as json_file:
            json.dump(all_weapons_data, json_file, indent=4)
        
    except Exception as e:
        raise Exception(f"Terjadi error saat scraping senjata: {e}")


# link:         https://genshin-impact.fandom.com/wiki/Weapon/List
# format:       {'Name', 'Type', 'Rarity', 'Base ATK', 'Secondary Stat': {'Name', 'Value'}, 'Version'}
# output file:  weapons.json
def process_weapons_row(row, weapon_version):
    try:

        cells = row.find_all('td')

        # cleaning: memastikan data sesuai dengan format yang dibutuhkan
        # parsing: memisahkan nama secondary stat dengan nilainya
        # transformation: weapon dengan rarity 1-2 tidak memiliki secondary stat,
        #                 secondary stat value diubah menjadi None (untuk nama) dan "N/A" (untuk value)
        weapon_name = cells[1].find('a').get_text(strip=True)
        rarity = cells[2].find('span', title=True)['title'][0]
        base_atk = cells[3].get_text(strip=True).split('(')[0]
        secondary_stat = cells[4].get_text(strip=True).rsplit(' ', maxsplit=1)
        secondary_stat_name = secondary_stat[0]
        secondary_stat_value = secondary_stat[1].split('(')[0] if len(secondary_stat) > 1 else "N/A"

        if secondary_stat_value.endswith('%'):
            secondary_stat_value = secondary_stat_value[:-1]
            secondary_stat_name += " %"

        weapon_info = {
            "Name": weapon_name,
            # panggil fungsi helper untuk mengambil tipe senjata
            "Type": scrape_weapons_type(weapon_name),
            "Rarity": rarity,
            "Base ATK": base_atk,
            "Secondary Stat": {
                "Name": secondary_stat_name,
                "Value": secondary_stat_value
            },
            "Version": weapon_version.get(weapon_name, "N/A") if weapon_version else "N/A"
        }
        return weapon_info
            
    except Exception as e:
        raise Exception(f"Terjadi error saat scraping senjata: {e}")

# link:         https://genshin-impact.fandom.com/wiki/Weapon
def scrape_weapons_version(soup):
    try:
        # ambil data versi rilis senjata
        version_release_data = {}

        # ambil semua container besar
        all_containers = soup.find_all('div', class_='change-history-content')

        for container in all_containers:
            # cari semua tag versi di container ini
            version_tags = container.find_all('a', title=lambda t: t and 'Version' in t)

            for i, version_tag in enumerate(version_tags):
                version_number = version_tag.get_text(strip=True).split(' ')[-1]

                # tentukan batas: sampai versi berikutnya atau habis
                if i + 1 < len(version_tags):
                    stop_tag = version_tags[i + 1]
                else:
                    stop_tag = None

                # mulai dari tag versi sekarang, iterasi ke depan di container
                for element in version_tag.parent.next_elements:
                    if stop_tag and element == stop_tag:
                        break
                    if getattr(element, "name", None) == "span" and "item-text" in element.get("class", []):
                        weapon_name = element.get_text(strip=True).replace('\u00ad', '').replace('\\', '')
                        if weapon_name and weapon_name not in version_release_data:
                            version_release_data[weapon_name] = version_number


        # print("\nDaftar Versi Senjata:")
        # for weapon_name, version in version_release_data.items():
        #     print(f" - {weapon_name}: {version}")

        return version_release_data

    except Exception as e:
        raise Exception(f"Terjadi error saat scraping detail senjata: {e}")

# link:         https://genshin-impact.fandom.com/wiki/{weapon_name}
def scrape_weapons_type(weapon_name):
    try:
        # ambil tipe senjata
        URL = "https://genshin-impact.fandom.com/wiki/" + weapon_name.replace(" ", "_")
        response = requests.get(URL, headers=HEADERS, timeout=10)
        soup = BeautifulSoup(response.text, 'html.parser')

        weapon_type = "N/A"
        header = soup.find('h3', class_='pi-data-label', string='Weapon Type')

        if header:
            value_div = header.find_next_sibling('div', class_='pi-data-value')
            
            if value_div:
                link_tag = value_div.find('span', class_='no-wrap')

                if link_tag:
                    weapon_type = link_tag.get_text(strip=True)
        
        # print(f"Tipe Senjata yang ditemukan: {weapon_type}")
    
        return weapon_type

    except Exception as e:
        raise Exception(f"Terjadi error saat scraping tipe senjata: {e}")

# link:         https://genshin-impact.fandom.com/wiki/Normal_Boss
# format:       {'Name', 'Region', 'Boss Drop', 'Version'}
# output file:  bosses.json
def scrape_bosses(URL):
    try:
        # ambil data boss
        URL += "Normal_Boss"

        response = requests.get(URL, headers=HEADERS, timeout=10)
        response.raise_for_status()
        print(f"Berhasil mengakses /Normal_Boss dengan status code: {response.status_code}")

        soup = BeautifulSoup(response.text, 'html.parser')
        # panggil fungsi helper untuk mengambil data boss berdasarkan region
        bosses_data = scrape_boss_regions(soup)
        output = []
        
        all_boss_tasks = []
        for region, bosses in bosses_data.items():
            for boss in bosses:
                all_boss_tasks.append({
                    "Name": boss,
                    "Region": region
                })
        
        for task in tqdm.tqdm(all_boss_tasks):
            boss = task["Name"]
            region = task["Region"]
            URL = "https://genshin-impact.fandom.com/wiki/" + boss.replace(" ", "_")
            response = requests.get(URL, headers=HEADERS, timeout=10)
            soup = BeautifulSoup(response.text, 'html.parser')

            drop = "N/A"
            header = soup.find('h3', class_='pi-data-label', string='Unique Drops')

            if header:
                container = header.find_next_sibling('div', class_='pi-data-value')

                if container:
                    caption = container.find('span', class_='card-caption')

                    if caption:
                        # cleaning: menghapus karakter yang tidak diinginkan (soft hyphen dan em dash)
                        drop = caption.get_text(strip=True).replace('\u00ad', '').replace('\u2014', '-')

            version = "N/A"
            container = soup.find('div', class_='change-history')

            if container:
                version_link = container.find('a')

                if version_link:
                    version = version_link.get_text(strip=True)[8:]
            
            boss_info = {
                "Name": boss,
                "Region": region,
                "Boss Drop": drop,
                "Version": version
            }
            output.append(boss_info)

        with open(os.path.join('..', 'data', 'bosses.json'), 'w') as json_file:
            json.dump(output, json_file, indent=4)

    except:
        raise Exception("Terjadi error saat scraping boss.")

def scrape_boss_regions(soup):
    try:
        # ambil data boss berdasarkan region
        bosses_by_region = {}
        main_header_span = soup.find('span', id='List_of_Normal_Bosses')

        if main_header_span:
            main_header = main_header_span.find_parent('h2')

            for region_h3 in main_header.find_next_siblings('h3'):
                region_span = region_h3.find('span', class_='mw-headline')

                if region_span:
                    region_name = region_span.get_text(strip=True)
                    
                    bosses_in_region = []
                    boss_table = region_h3.find_next_sibling('table', class_='wikitable')

                    if boss_table:
                        for row in boss_table.find_all('tr')[1:]:
                            boss_cell = row.find('td')
                            
                            if boss_cell:
                                card = boss_cell.find('div', class_='card-container')

                                if card:
                                    boss_name = card.get_text(strip=True)[1:]
                                    bosses_in_region.append(boss_name)
                    
                    if bosses_in_region:
                        bosses_by_region[region_name] = bosses_in_region

        return bosses_by_region
    
    except Exception as e:
        raise Exception(f"Terjadi error saat scraping musuh boss: {e}")

# fungsi utama untuk melakukan scraping data
def scrape_data(URL):
    try:
        time_start = time.time()
        scrape_characters(URL)
        time_end = time.time()
        print(f"yang dibutuhkan untuk scraping karakter: {time_end - time_start:.2f} detik")
        print("hasil scraping karakter disimpan di data/characters.json\n")

        time_start = time.time()
        scrape_versions(URL)
        time_end = time.time()
        print(f"Waktu yang dibutuhkan untuk scraping versi: {time_end - time_start:.2f} detik")
        print("hasil scraping versi disimpan di data/versions.json\n")

        time_start = time.time()
        scrape_domain(URL)
        time_end = time.time()
        print(f"Waktu yang dibutuhkan untuk scraping domain artefak: {time_end - time_start:.2f} detik")
        print("hasil scraping domain disimpan di data/domains.json\n")

        time_start = time.time()
        scrape_artifacts(URL)
        time_end = time.time()
        print(f"Waktu yang dibutuhkan untuk scraping artefak: {time_end - time_start:.2f} detik")
        print("hasil scraping artefak disimpan di data/artifacts.json\n")
        
        time_start = time.time()
        scrape_weapons(URL)
        time_end = time.time()
        print(f"Waktu yang dibutuhkan untuk scraping senjata: {time_end - time_start:.2f} detik")
        print("hasil scraping senjata disimpan di data/weapons.json\n")

        time_start = time.time()
        scrape_bosses(URL)
        time_end = time.time()
        print(f"Waktu yang dibutuhkan untuk scraping boss: {time_end - time_start:.2f} detik")
        print("hasil scraping boss disimpan di data/bosses.json\n")

    except Exception as e:
        raise Exception(f"Terjadi error saat scraping data: {e}")

if __name__ == "__main__":
    try:
        # catat waktu program dijalankan sebagai tanda automasi program berjalan
        timestamp = time.strftime("%Y-%m-%d %H:%M:%S")

        # URL dari website yang akan di-scrape
        URL = "https://genshin-impact.fandom.com/wiki/"

        # Header User-Agent (best practice)
        HEADERS = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'}

        time_start = time.time()
        scrape_data(URL)
        time_end = time.time()
        print(f"Waktu total yang dibutuhkan untuk scraping seluruh data: {time_end - time_start:.2f} detik\n")

        with open(os.path.join('..', 'data', 'log.txt'), 'w') as log_file:
            log_file.write(f"Scraping terakhir: {timestamp} dengan lama waktu: {time_end - time_start:.2f} detik\n")

    except requests.exceptions.RequestException as e:
        raise Exception(f"Gagal terhubung ke website: {e}")
    
    except Exception as e:
        raise Exception(f"{e}")