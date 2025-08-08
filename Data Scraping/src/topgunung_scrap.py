import requests
from bs4 import BeautifulSoup
import time
import json
import re
import os

def ubah_koordinat_ke_desimal(teks_koordinat, nama_gunung, log_file):
    """
    Mengubah koordinat dalam format derajat-menit ke format desimal.
    Saat koordinat tidak valid, return None dan catat di log.
    """
    try:
        if not teks_koordinat or teks_koordinat.strip() == '—':
            with open(log_file, 'a', encoding='utf-8') as f:
                f.write(f"Koordinat kosong untuk gunung {nama_gunung}: {teks_koordinat}\n")
            return None, None
        
        # lintang dan bujur dipisahkan
        parts = teks_koordinat.split()
        lintang = parts[0].replace('°', ' ').replace('′', ' ').replace('″', ' ').replace('N', '').replace('S', '-')
        bujur = parts[1].replace('°', ' ').replace('′', ' ').replace('″', ' ').replace('E', '').replace('W', '-')
        
        lintang_parts = lintang.split()
        bujur_parts = bujur.split()
        
        lintang_desimal = float(lintang_parts[0]) + (float(lintang_parts[1]) / 60 if len(lintang_parts) > 1 else 0)
        bujur_desimal = float(bujur_parts[0]) + (float(bujur_parts[1]) / 60 if len(bujur_parts) > 1 else 0)

        # Validasi koordinat
        if not (-90 <= lintang_desimal <= 90) or not (-180 <= bujur_desimal <= 180):
            with open(log_file, 'a', encoding='utf-8') as f:
                f.write(f"Koordinat tidak valid untuk gunung {nama_gunung}: {lintang_desimal}, {bujur_desimal}\n")
            return None, None

        return lintang_desimal, bujur_desimal
    # Debug log
    except Exception as e:
        with open(log_file, 'a', encoding='utf-8') as f:
            f.write(f"Gagal parsing koordinat untuk gunung {nama_gunung}: {teks_koordinat}, Error: {str(e)}\n")
        return None, None


def bersihkan_ketinggian_prominensi(teks, nama_gunung, log_file):
    """
    Mengekstrak nilai integer dari string ketinggian/prominensi
    """
    cocok = re.search(r'\d{1,3}(,\d{3})*', teks)
    if cocok:
        nilai = int(cocok.group().replace(',', ''))
        if nilai <= 0:
            with open(log_file, 'a', encoding='utf-8') as f:
                f.write(f"Ketinggian/prominensi tidak valid untuk gunung {nama_gunung}: {nilai}\n")
            return None
        return nilai
    else:
        with open(log_file, 'a', encoding='utf-8') as f:
            f.write(f"Gagal parsing ketinggian/prominensi untuk gunung {nama_gunung}: {teks}\n")
        return None


def pisah_nama_gunung(nama, log_file):
    """
    Memisahkan nama gunung yang kompleks berdasarkan pola kode dan camel case.
    """
    nama = nama.strip()
    nama_list = []
    pola_kode = r'(K\d+[a-zA-Z]?)'
    parts = re.split(pola_kode, nama)
    current_name = ""

    for part in parts:
        part = part.strip()
        if re.match(pola_kode, part):
            if current_name:
                sub_parts = re.split(r'(?<=[a-z])(?=[A-Z][a-z])', current_name)
                nama_list.extend([p.strip() for p in sub_parts if p.strip()])
                current_name = ""
            nama_list.append(part)
        else:
            current_name += part

    if current_name:
        sub_parts = re.split(r'(?<=[a-z])(?=[A-Z][a-z])', current_name)
        nama_list.extend([p.strip() for p in sub_parts if p.strip()])

    with open(log_file, 'a', encoding='utf-8') as f:
        f.write(f"Pisah nama gunung '{nama}' menjadi {nama_list}\n")

    return nama_list if nama_list else [nama]


# Headers
headers = {
    'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64); Amudi Purba/18223049@std.stei.itb.ac.id'
}
url = 'https://en.wikipedia.org/wiki/List_of_highest_mountains_on_Earth'

time.sleep(2)

response = requests.get(url, headers=headers)
soup = BeautifulSoup(response.text, 'html.parser')
tabel_gunung = soup.find('table', {'class': 'wikitable sortable'})

# Siapkan folder & variabel
os.makedirs('../data', exist_ok=True)
log_file = '../data/log_preprocessing.txt'
with open(log_file, 'w', encoding='utf-8') as f:
    f.write(f"Log Preprocessing Data Scraping - {time.strftime('%Y-%m-%d %H:%M:%S')}\n")

daftar_gunung = []
daftar_negara = []
daftar_pegunungan = []
id_berikutnya = 1

# Ekstrak Data
baris_tabel = tabel_gunung.find_all('tr')[1:]
for baris in baris_tabel:
    kolom = baris.find_all('td')
    if len(kolom) >= 9:
        try:
            peringkat = kolom[0].text.strip()
            if not peringkat.isdigit():
                continue

            # Penanganan nama gunung
            nama_gunung_list = []
            ul_element = kolom[1].find('ul', class_='cslist')
            if ul_element:
                for li in ul_element.find_all('li'):
                    nama = li.get_text(strip=True).split('[')[0].strip()
                    if nama:
                        nama_gunung_list.append(nama)
            else:
                nama_mentah = kolom[1].text.strip().split('[')[0].strip()
                nama_gunung_list = pisah_nama_gunung(nama_mentah, log_file)

            ketinggian = bersihkan_ketinggian_prominensi(
                kolom[2].text.strip(), nama_gunung_list[0], log_file
            )
            nama_pegunungan = kolom[4].text.strip()
            koordinat = kolom[5].text.strip()

            negara_mentah = re.sub(r'\[.*?\]', '', kolom[8].text.strip())
            nama_negara = [n.strip() for n in re.split(r'[\/,]|(?<=[a-z])(?=[A-Z])', negara_mentah) if n.strip()]

            lintang, bujur = ubah_koordinat_ke_desimal(koordinat, nama_gunung_list[0], log_file)

            for nama in nama_gunung_list:
                gunung_data = {
                    'id': id_berikutnya,
                    'peringkat': peringkat,
                    'nama': nama,
                    'ketinggian_m': ketinggian,
                    'id_pegunungan': None,
                    'lintang': lintang,
                    'bujur': bujur,
                    'id_negara': []
                }

                # Tambah negara
                for negara in nama_negara:
                    if negara not in [d['nama'] for d in daftar_negara]:
                        daftar_negara.append({'id': len(daftar_negara) + 1, 'nama': negara})
                    gunung_data['id_negara'].append(
                        next(d['id'] for d in daftar_negara if d['nama'] == negara)
                    )

                # Tambah pegunungan
                if nama_pegunungan:
                    existing = next((p for p in daftar_pegunungan if p['nama'] == nama_pegunungan), None)
                    if existing:
                        existing['jumlah_gunung'] += 1
                        gunung_data['id_pegunungan'] = existing['id']
                    else:
                        new_id = len(daftar_pegunungan) + 1
                        daftar_pegunungan.append({
                            'id': new_id,
                            'nama': nama_pegunungan,
                            'jumlah_gunung': 1
                        })
                        gunung_data['id_pegunungan'] = new_id

                if lintang is not None and bujur is not None:
                    daftar_gunung.append(gunung_data)

                id_berikutnya += 1

            time.sleep(0.5)

        except Exception as e:
            with open(log_file, 'a', encoding='utf-8') as f:
                f.write(f"Kesalahan saat memproses baris: {str(e)}\n")

# Simpan JSON 
with open('../data/daftar_gunung.json', 'w', encoding='utf-8') as f:
    json.dump(daftar_gunung, f, indent=4, ensure_ascii=False)

with open('../data/daftar_negara.json', 'w', encoding='utf-8') as f:
    json.dump(daftar_negara, f, indent=4, ensure_ascii=False)

with open('../data/daftar_pegunungan.json', 'w', encoding='utf-8') as f:
    json.dump(daftar_pegunungan, f, indent=4, ensure_ascii=False)

print("Scraping selesai.")
