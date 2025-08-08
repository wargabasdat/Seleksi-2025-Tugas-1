from urllib.request import urlopen, Request 
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
    #list untuk entity channel dan youtuber
    channels_data = []
    youtubers_data = []

    try:
        #HTTP Request         
        headers = {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36',
            'From': '18223029@std.stei.itb.ac.id'
        }
        req = Request(url, headers=headers)
        page = urlopen(req).read() 
        soup = BeautifulSoup(page, 'html.parser')
        main_content = soup.find('div', id='fsb') 

        if not main_content:
            print("Error: Kontainer utama tidak ditemukan.")
            return [], [] 

        headings = main_content.find_all('h3', class_='feed_heading')
        
        if not headings:
            print("Tidak ditemukan elemen.")
            return [], [] 

        for h3_element in headings:
            # channel_info untuk temporary dictionary untuk semua data
            temp_channel_info = {} 

            try:
                #get Youtuber Name 
                youtuber_name_span = h3_element.find('span', {'data-fid': True})
                temp_channel_info['youtuber_name'] = youtuber_name_span.text.strip() if youtuber_name_span else "N/A"

                p_container = h3_element.find_next_sibling('p', class_='trow trow-wrap')
                
                if not p_container:
                    print(f"Tidak ditemukan")
                    continue 

                #get Youtube Channel Link
                youtube_link_element = p_container.find('a', class_='ext text-blue wb-ba')
                temp_channel_info['youtube_channel_link'] = youtube_link_element['href'] if youtube_link_element and 'href' in youtube_link_element.attrs else "N/A"
                if temp_channel_info['youtube_channel_link'] and not temp_channel_info['youtube_channel_link'].startswith('http'):
                   temp_channel_info['youtube_channel_link'] = 'https://videos.feedspot.com' + temp_channel_info['youtube_channel_link']

                #get Description
                description_element = p_container.find('span', class_='feed_desc collapsed')
                temp_channel_info['description'] = description_element.text.replace('MORE', '').strip() if description_element else "No description"

                #Ekstraksi
                fs_topics = p_container.find_all('span', class_='fs-topics')
                for topic_span in fs_topics:
                    strong_label = topic_span.find('strong', class_='eng_lb')
                    span_value = topic_span.find('span', class_='eng_v')

                    if strong_label and span_value:
                        label = strong_label.text.strip().replace(' ', '_').lower() 
                        value = span_value.text.strip()
                        #get email
                        if label == 'email' and span_value.find('span', class_='blk-email'):
                            email_obfuscated = span_value.find('span', class_='blk-email').text.strip()
                            temp_channel_info[label] = email_obfuscated
                        else:
                            temp_channel_info[label] = value

                #get Followers, Type, dan Since
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
                            #get subscribers
                            if 'subscribers' in label or 'followers' in label:
                                temp_channel_info[label] = convert_number(value)
                            else:
                                temp_channel_info[label] = value
        
                
                #entity channel
                channel_entity = {
                    'youtube_channel_link': temp_channel_info.get('youtube_channel_link'),
                    'channel_name': temp_channel_info.get('channel_name'),
                    'youtuber_name': temp_channel_info.get('youtuber_name'), 
                    'type_of_channel': temp_channel_info.get('type_of_channel', temp_channel_info.get('type')),
                    'since': temp_channel_info.get('since'),
                    'description': temp_channel_info.get('description') 
                }
                channels_data.append(channel_entity)

                #entity youtuber
                youtuber_entity = {
                    'youtuber_name': temp_channel_info.get('youtuber_name'),
                    'gender': temp_channel_info.get('gender'),
                    'email': temp_channel_info.get('email'),
                    'youtube_subscribers': temp_channel_info.get('youtube_subscribers'),
                    'facebook_followers': temp_channel_info.get('facebook_followers'),
                    'instagram_followers': temp_channel_info.get('instagram_followers'),
                    'type': temp_channel_info.get('type') 
                }
                youtubers_data.append(youtuber_entity)

            except Exception as e:
                print(f"Error saat mengekstrak data : {e}")
                continue 

        return channels_data, youtubers_data

    except Exception as e:
        print(f"Error saat melakukan request atau parsing halaman: {e}")
        return [], [] 

#cek output
if __name__ == "__main__":
    target_url = 'https://videos.feedspot.com/mindfulness_youtube_channels/'

    print("Memulai proses scraping...")
    scraped_channels_data, scraped_youtubers_data = scrape_mindfulness_channels(target_url)

    #data channel
    if scraped_channels_data:
        print("\n Data entity channel")
        for i, item in enumerate(scraped_channels_data):
            if i >= 100: 
                break
            print(list(item.values())) 
        
        #menyimpan file ke JSON
        output_dir = 'Data Scraping/data'
        os.makedirs(output_dir, exist_ok=True)
        channels_file_path = os.path.join(output_dir, 'channels.json')
        with open(channels_file_path, 'w', encoding='utf-8') as f:
            json.dump(scraped_channels_data, f, ensure_ascii=False, indent=4)
    else:
        print("Gagal mengekstrak data")

    #data youtuber
    if scraped_youtubers_data:
        print("\n Data entity youtuber")
        for i, item in enumerate(scraped_youtubers_data):
            if i >= 100: 
                break
            print(list(item.values()))
        
        # Menyimpan file ke JSON
        output_dir = 'Data Scraping/data'
        youtubers_file_path = os.path.join(output_dir, 'youtubers.json')
        with open(youtubers_file_path, 'w', encoding='utf-8') as f:
            json.dump(scraped_youtubers_data, f, ensure_ascii=False, indent=4)
    else:
        print("Gagal mengekstrak data")