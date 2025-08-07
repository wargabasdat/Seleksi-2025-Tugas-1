import json
import os
import psycopg2

#Untuk terhubung ke database
def get_db_connection():
    return psycopg2.connect(
         dbname='mindfulness_db',
         user='kevinazrazzz',
         password='Azra1203@',
         host='localhost',
         port='5432'
    )
    pass

#file JSON
data_folder = 'Data Scraping/data'
channels_file = os.path.join(data_folder, 'channels.json')
youtubers_file = os.path.join(data_folder, 'youtubers.json')

try:
    with open(youtubers_file, 'r', encoding='utf-8') as f:
        youtubers_data = json.load(f)

    with open(channels_file, 'r', encoding='utf-8') as f:
        channels_data = json.load(f)

    conn = get_db_connection()
    cursor = conn.cursor()

    # Memasukkan data ke tabel youtubers
    print("Memasukkan data ke tabel youtubers...")
    for youtuber in youtubers_data:
        cursor.execute(
            "INSERT INTO youtubers (youtuber_name, gender, email, youtube_subscribers, facebook_followers, instagram_followers, type) VALUES (%s, %s, %s, %s, %s, %s, %s)",
            (youtuber.get('youtuber_name'), youtuber.get('gender'), youtuber.get('email'), youtuber.get('youtube_subscribers'), youtuber.get('facebook_followers'), youtuber.get('instagram_followers'), youtuber.get('type'))
        )

    # Memasukkan data ke tabel channels
    print("Memasukkan data ke tabel channels...")
    for channel in channels_data:
        cursor.execute(
            "INSERT INTO channels (youtube_channel_link, channel_name, youtuber_name, type_of_channel, since, description) VALUES (%s, %s, %s, %s, %s, %s)",
            (channel.get('youtube_channel_link'), channel.get('channel_name'), channel.get('youtuber_name'), channel.get('type_of_channel'), channel.get('since'), channel.get('description'))
        )

    conn.commit()
    cursor.close()
    conn.close()
    print("Data berhasil dimasukkan ke database.")

except Exception as e:
    print(f"Error saat memasukkan data ke database: {e}")