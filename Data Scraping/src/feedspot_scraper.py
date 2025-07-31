from urllib.request import urlopen, Request
import requests 
from bs4 import BeautifulSoup
import json
import time 
import os
import re

#Convert text angka menjadi integer
def convert_number(text):
    if not text:
        return 0
    text = text.replace(',', '').strip()
    if 'K' in text:
        return int(float(text.replace('K', '')) * 1000)
    elif 'M' in text:
        return int(float(text.replace('M', '')) * 1000000)
    else:
        try:
            return int(text)
        except ValueError:
            return 0 


def scrape_mindfulness_channels(url):
    result = []

    try:
        # Heading untuk request
        headers = {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36',
            'From': '18223029@std.stei.itb.ac.id' 
        }
        
        # Buat objek Request dengan URL dan headers
        req = Request(url, headers=headers)

        page = urlopen(req).read() 
        soup = BeautifulSoup(page, 'html.parser')
        main_content = soup.find('div', id='fsb') 

        if not main_content:
            print("Error: Tidak ditemukan")
            return []

        headings = main_content.find_all('h3', class_='feed_heading')
        
        if not headings:
            print("Tidak ditemukan elemen")
            return []

        for h3_element in headings:
            channel_info = {}

            try:
                #get Youtuber Name
                youtuber_name = h3_element.find('span', {'data-fid': True})
                channel_info['youtuber_name'] = youtuber_name.text.strip() if youtuber_name else "N/A"

                p_container = h3_element.find_next_sibling('p', class_='trow trow-wrap')
                
                if not p_container:
                    print(f"Peringatan: Tidak ditemukan. Melewatkan channel ini.")
                    continue 

                #Get Youtube Channel Link
                youtube_link = p_container.find('a', class_='ext text-blue wb-ba')
                channel_info['youtube_channel_link'] = youtube_link['href'] if youtube_link and 'href' in youtube_link.attrs else "N/A"

                if channel_info['youtube_channel_link'] and not channel_info['youtube_channel_link'].startswith('http'):
                   channel_info['youtube_channel_link'] = 'https://videos.feedspot.com' + channel_info['youtube_channel_link']

                #Get Description
                description_element = p_container.find('span', class_='feed_desc collapsed')
                channel_info['description'] = description_element.text.replace('MORE', '').strip() if description_element else "No description"

                #Ekstraksi Informasi
                fs_topics = p_container.find_all('span', class_='fs-topics')
                for topic_span in fs_topics:
                    strong_label = topic_span.find('strong', class_='eng_lb')
                    span_value = topic_span.find('span', class_='eng_v')

                    if strong_label and span_value:
                        label = strong_label.text.strip().replace(' ', '_').lower() 
                        value = span_value.text.strip()
                        
                        #Get Email
                        if label == 'email' and span_value.find('span', class_='blk-email'):
                            email_obfuscated = span_value.find('span', class_='blk-email').text.strip()
                            channel_info[label] = email_obfuscated
                        else:
                            channel_info[label] = value

                #Get Followers, Type, dan Since
                eng_outer_wrapper = p_container.find('span', class_='eng-outer-wrapper')
                if eng_outer_wrapper:
                    eng_topics = eng_outer_wrapper.find_all('span', class_=re.compile(r'fs-(youtube|facebook|twitter|instagram|type|since)'))
                    for eng_span in eng_topics:
                        strong_label = eng_span.find('strong', class_='eng_lb')
                        span_value = eng_span.find('span', class_='eng_v')

                        if strong_label and span_value:
                            label_raw = strong_label.text.strip()
                            label = re.sub(r'[^a-zA-Z0-9_]', '', label_raw.replace(' ', '_').lower())
                            value = span_value.text.strip()

                            if 'subscribers' in label or 'followers' in label:
                                channel_info[label] = convert_number(value)
                            else:
                                channel_info[label] = value
                
                result.append(channel_info)

            except Exception as e:
                print(f"Error saat mengekstrak data untuk channel '{channel_info.get('youtuber_name', 'UNKNOWN')}': {e}")
                continue 

        return result

    except Exception as e:
        print(f"Error saat melakukan request atau parsing halaman: {e}")
        return []

#Cek output
if __name__ == "__main__":
    target_url = 'https://videos.feedspot.com/mindfulness_youtube_channels/'

    print("Memulai proses scraping...")
    scraped_data = scrape_mindfulness_channels(target_url)

    if scraped_data:
        for i, item in enumerate(scraped_data):
            if i >= 100:
                break
            print(list(item.values()))
        print(f"\nTotal channel yang diekstrak: {len(scraped_data)}.")

        #Menyimpan file dalam bentuk JSON
        output_dir = 'Data Scraping/data'
        output_file_path = os.path.join(output_dir, 'mindfulness_channels.json')
        with open(output_file_path, 'w', encoding='utf-8') as f:
             json.dump(scraped_data, f, ensure_ascii=False, indent=4)
        print(f"Data berhasil disimpan ke {output_file_path}")

    else:
        print("Tidak ada data yang berhasil diekstrak")