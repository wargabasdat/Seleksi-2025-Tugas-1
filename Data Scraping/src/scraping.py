# %%
# Library yang dibutuhkan

from bs4 import BeautifulSoup # Untuk parsing konten HTML
import requests               # Untuk mengirim HTTP requests
import pandas as pd           # Untuk mengelola dataframe
import unicodedata            # Untuk melakukan normalisasi teks Unicode
import re                     # Untuk menggunakan regex
import json                   # Untuk memproses JSON dan meng-export dataframe ke JSON

# %%
# URL dari web yang akan di-scrape
url = 'https://www.ssbwiki.com/List_of_spirits_(complete_list)'

# Mengirim permintaan HTTP GET ke URL dan menyimpan respons halaman
page = requests.get(url)

# Melakukan parsing HTML dengan BeautifulSoup
soup = BeautifulSoup(page.text, 'html')

# %%
# Mengambil tabel pertama dari halaman yang merupakan daftar spirits
table = soup.find_all('table')[0]

# Mengambil baris kedua yang merupakan header tabel
header_row = table.find_all('tr')[1]

# Mengambil seluruh elemen <th> (judul kolom) dari baris header dan menyimpan teks setiap header dalam list
spirit_titles = header_row.find_all('th')
spirit_table_titles = [title.get_text(strip=True) for title in spirit_titles]

# Mengganti nama kolom pertama menjadi 'ID' yang semula bernama '#'
spirit_table_titles[0] = 'ID'

# Mengolah ulang kolom Min Max yang berulang (dikarenakan kolom menggunakan ikon) menjadi Min Max untuk Power, Attack, dan Defense secara berturut-turut
min_max_indices = [i for i, t in enumerate(spirit_table_titles) if t == 'Min' or t == 'Max']
stat_labels = ['Power', 'Attack', 'Defense']
for i, label in zip(range(0, len(min_max_indices), 2), stat_labels):
    min_idx = min_max_indices[i]
    max_idx = min_max_indices[i + 1]
    spirit_table_titles[min_idx] = f'Min {label}'
    spirit_table_titles[max_idx] = f'Max {label}'

# Menampilkan seluruh kolom tabel untuk data yang akan di-scrape
print(spirit_table_titles)


# %%
# Membuat DataFrame kosong dengan header kolom yang sudah diproses sebelumnya
df = pd.DataFrame(columns=spirit_table_titles)

# Mengambil seluruh baris data setelah header (baris record data mulai tersimpan)
data_rows = table.find_all('tr')[2:]

# Iterasi setiap baris data
for row in data_rows:
    # Ambil semua kolom <td> yang memiliki teks atau elemen penting (img/a)
    cols = [td for td in row.find_all('td') if td.get_text(strip=True) or td.find('img') or td.find('a')]

    row_data = []  # List untuk menyimpan data dari satu baris
    col_idx = 0    # Indeks kolom saat ini

    # ID
    row_data.append(cols[col_idx].get_text(strip=True))
    col_idx += 1

    # Name
    row_data.append(cols[col_idx].get_text(strip=True))
    col_idx += 1

    # Category
    category = cols[col_idx].get_text(strip=True)
    row_data.append(category)
    col_idx += 1

    # Series
    row_data.append(cols[col_idx].get_text(strip=True))
    col_idx += 1

    # Spirit Battle
    row_data.append(cols[col_idx].get_text(strip=True))
    col_idx += 1

    # Logic tergantung category
    if category in ['Fighter', 'Master']:
        # Class sampai Ability kosong untuk Fighter dan Master Spirits
        row_data += [None] * 10  # Class, Type, Slots, Min Power, Max Power, Min Attack, Max Attack, Min Defense, Max Defense, Ability
        # Lanjut ke kolom berikutnya (Spirit Board sampai Present)
        for i in range(col_idx, len(cols)):
            row_data.append(cols[i].get_text(strip=True))

    elif category == 'Support':
        # Ambil Class, Type, Slots
        for i in range(3):
            if col_idx < len(cols):
                if spirit_table_titles[5 + i] == 'Type':
                    # image pada kolom Type diambil bagian title-nya saja
                    img = cols[col_idx].find('img')
                    if img:
                        type_text = img.get('alt') or img.get('title') or img.get('src').split('/')[-1].split('.')[0]
                        row_data.append(type_text.strip())
                    else:
                        row_data.append('')
                else:
                    row_data.append(cols[col_idx].get_text(strip=True))
                col_idx += 1
            else:
                row_data.append(None)
                col_idx += 1
        # Min Power sampai Max Defense kosong
        row_data += [None] * 6
        # Ability
        if col_idx < len(cols):
            row_data.append(cols[col_idx].get_text(strip=True))
            col_idx += 1
        else:
            row_data.append(None)
        # Sisanya, pastikan row_data tidak melebihi jumlah kolom
        while len(row_data) < len(spirit_table_titles):
            if col_idx < len(cols):
                row_data.append(cols[col_idx].get_text(strip=True))
                col_idx += 1
            else:
                row_data.append(None)

    else:  # Primary
        # Ambil semua kolom
        for i in range(col_idx, len(spirit_table_titles)):
            if col_idx >= len(cols):
                row_data.append(None)
            elif spirit_table_titles[i] == 'Type':
                img = cols[col_idx].find('img')
                if img:
                    type_text = img.get('alt') or img.get('title') or img.get('src').split('/')[-1].split('.')[0]
                    row_data.append(type_text.strip())
                else:
                    row_data.append('')
                col_idx += 1
            else:
                row_data.append(cols[col_idx].get_text(strip=True))
                col_idx += 1
    # Pastikan panjang row_data sesuai
    if len(row_data) < len(spirit_table_titles):
        row_data += [None] * (len(spirit_table_titles) - len(row_data))
    elif len(row_data) > len(spirit_table_titles):
        row_data = row_data[:len(spirit_table_titles)]
    df.loc[len(df)] = row_data

# uji dengan menampilkan 20 data pertama
df.head(20)

# %%
# Fungsi untuk menormalkan nama (Series atau Name) menjadi format ASCII.
# Menghilangkan karakter spesial/non-ASCII agar lebih bersih untuk disimpan atau diproses.
def normalize_series_name(name):
    if isinstance(name, str):
        return unicodedata.normalize('NFKD', name).encode('ASCII', 'ignore').decode('utf-8')
    return name

# Terapkan normalisasi pada kolom "Series" dan "Name"
df['Series'] = df['Series'].apply(normalize_series_name)
df['Name'] = df['Name'].apply(normalize_series_name)

# %%
# Fungsi untuk membersihkan dataframe dari simbol-simbol spesial agar lebih mudah disimpan dan diproses
def clean_spirit_dataframe(df):
    def clean_column(col):
        col_name = col.name.lower()
        def convert(val):
            if isinstance(val, str):
                val = val.strip()
                # Jika kolom 'name' atau 'series', ganti ✗ → X (bukan boolean)
                if col_name in ['name', 'series']:
                    return val.replace('✗', 'X')
                
                # Jika kolom 'ability', ubah '[none]' menjadi data kosong atau null
                elif col_name.lower() == 'ability' and val.lower() == '[none]':
                    return None

                # Simbol checkmark → boolean
                if re.fullmatch(r'✓(\[\d+\])?', val):
                    return True
                if re.fullmatch(r'✗(\[\d+\])?', val):
                    return False

                # Mengubah ikon-ikon menjadi panjang dari ikon tersebut
                if all(char == '★' for char in val):
                    return len(val)
                if all(char == '⬡' for char in val):
                    return len(val)
                if all(char == '⬢' for char in val):
                    return len(val)

                # Mengubah panah menjadi up atau down
                val = val.replace('↑', 'up').replace('↓', 'down')
            return val
        return col.apply(convert)
    return df.apply(clean_column)

# aplikasikan agar dataframe bersih
df_cleaned = clean_spirit_dataframe(df)

# Pastikan kolom numerik bertipe integer
numerical_cols = [
    'ID', 'Slots', 'Class',
    'Min Power', 'Max Power',
    'Min Attack', 'Max Attack',
    'Min Defense', 'Max Defense'
]
df_cleaned[numerical_cols] = df_cleaned[numerical_cols].apply(pd.to_numeric, errors='coerce').astype('Int64')

# Perbaikan nilai power agar konsisten
df_cleaned['Min Power'] = df_cleaned['Min Attack'] + df_cleaned['Min Defense']
df_cleaned['Max Power'] = df_cleaned['Max Attack'] + df_cleaned['Max Defense']

# %%
# Fungsi untuk export dataframe yang kolomnya sudah di-rename ke JSON
def export_dataframe_to_json(df, filename, rename_map=None):
    if rename_map:
        df = df.rename(columns=rename_map)
    data = df.to_dict(orient='records')
    with open(filename, 'w', encoding='utf-8') as f:
        json.dump(data, f, ensure_ascii=False, indent=4)

# %%
# Untuk series.json
series_df = df_cleaned['Series'].dropna().unique() # mengambil series unik
series_data = [{"series_id": i + 1, "name": name} for i, name in enumerate(series_df)] # menambahkan id untuk setiap series
export_dataframe_to_json(pd.DataFrame(series_data), 'series.json') # Export sesuai model relasional

# %%
# Untuk spirits.json

# Load mapping dari series.json
with open('../../Data Scraping/data/series.json', 'r', encoding='utf-8') as f:
    series_data = json.load(f)

# Buat dictionary mapping: {series_name: series_id}
series_map = {item['name']: item['series_id'] for item in series_data}

# Tambahkan kolom baru "series_id" ke DataFrame hasil scraping
df_cleaned['series_id'] = df_cleaned['Series'].map(series_map)

# Export sesuai model relasional
export_dataframe_to_json(
    df_cleaned[['ID', 'Name', 'Category', 'Spirit Battle', 'series_id']].copy(),
    'spirits.json',
    rename_map={
        'ID': 'spirits_id',
        'Name': 'name',
        'Category': 'category',
        'Spirit Battle': 'spirit_battle'
    }
)

# %%
# Untuk ability.json
series_df = df_cleaned['Ability'].dropna().unique() # mengambil ability unik
series_data = [{"ability_id": i + 1, "name": name} for i, name in enumerate(series_df)] # menambahkan id untuk setiap ability
export_dataframe_to_json(pd.DataFrame(series_data), 'ability.json') # Export sesuai model relasional

# %%
# Untuk equipable_spirits.json

# Load mapping dari ability.json
with open('../../Data Scraping/data/ability.json', 'r', encoding='utf-8') as f:
    ability_data = json.load(f)

# Buat dictionary mapping: {ability_name: ability_id}
ability_map = {item['name']: item['ability_id'] for item in ability_data}

# Tambahkan kolom "ability_id" ke DataFrame hasil scraping. Pastikan ability_id bertipe int
df_cleaned['ability_id'] = df_cleaned['Ability'].map(ability_map)
df_cleaned['ability_id'] = df_cleaned['ability_id'].astype('Int64')

# Filter hanya yang memiliki Category "Primary" atau "Support"
equipable_df = df_cleaned[df_cleaned['Category'].isin(['Primary', 'Support'])]

# Export sesuai model relasional
export_dataframe_to_json(
    equipable_df[['ID', 'Class', 'ability_id']].copy(),
    'equipable_spirits.json',
    rename_map={
        'ID': 'spirits_id',
        'Class': 'class',
    }
)

# %%
# Untuk primary_spirits.json

# Filter hanya yang memiliki Category "Primary"
primary_df = df_cleaned[df_cleaned['Category'] == 'Primary']

# Export sesuai model relasional
export_dataframe_to_json(
    primary_df[['ID', 'Type', 'Slots', 'Min Power', 'Max Power', 'Min Attack', 'Max Attack', 'Min Defense', 'Max Defense']].copy(),
    'primary_spirits.json',
    rename_map={
        'ID': 'spirits_id',
        'Type': 'type',
        'Slots': 'slot_capacity',
        'Min Power': 'min_power',
        'Max Power': 'max_power',
        'Min Attack': 'min_attack',
        'Max Attack': 'max_attack',
        'Min Defense': 'min_defense',
        'Max Defense': 'max_defense'
    }
)


# %%
# Untuk support_spirits.json

# Filter hanya yang memiliki Category "Support"
support_df = df_cleaned[df_cleaned['Category'] == 'Support']

# Export sesuai model relasional
export_dataframe_to_json(
    support_df[['ID', 'Slots']].copy(),
    'support_spirits.json',
    rename_map={
        'ID': 'spirits_id',
        'Slots': 'slot_cost'
    }
)

# %%
# untuk obtaining_method.json

# Kolom-kolom method
method_columns = [
    "Spirit Board", "World of Light", "Shopping", "Summon",
    "Challenge", "Enhanced", "amiibo", "Present"
]

# Buat DataFrame baru dengan nama method dan ID
obtaining_methods = pd.DataFrame({
    "method_id": range(1, len(method_columns) + 1),
    "name": method_columns
})

# Export sesuai model relasional
export_dataframe_to_json(pd.DataFrame(obtaining_methods), 'obtaining_method.json')

# %%
# untuk kolom spirits_obtain

# Ambil seluruh kolom obtaining method dari spirits
obtain_method_cols = df_cleaned.columns[15:23]  

obtain_data = []

# Iterasi semua kolom metode obtain
for i, col in enumerate(obtain_method_cols):
    method_id = i + 1  # sesuaikan id
    filtered_df = df_cleaned[df_cleaned[col] == True]

    for spirit_id in filtered_df['ID']:
        obtain_data.append({
            'spirits_id': int(spirit_id),
            'method_id': method_id
        })

# Konversi ke DataFrame dan urutkan
spirits_obtain_df = pd.DataFrame(obtain_data).sort_values(by=['spirits_id', 'method_id'])

# Export sesuai model relasional
export_dataframe_to_json(spirits_obtain_df, 'spirits_obtain.json')



