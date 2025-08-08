import json
import os

def clean_artists_data(file_path):
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            artists_data = json.load(f)
    except FileNotFoundError:
        print(f"Error: File tidak ditemukan di {file_path}")
        return

    cleaned_data = []
    for artist in artists_data:
        if 'physical_sales' in artist:
            del artist['physical_sales']
        cleaned_data.append(artist)

    with open(file_path, 'w', encoding='utf-8') as f:
        json.dump(cleaned_data, f, ensure_ascii=False, indent=4)
    
    print(f"Pembersihan data selesai untuk {file_path}. Atribut 'physical_sales' telah dihapus.")

def transform_awards_to_normalized_data(file_path, group_song_map_path):
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            awards_data = json.load(f)
    except FileNotFoundError:
        print(f"Error: File awards.json tidak ditemukan di {file_path}")
        return

    unique_group_songs = {}
    next_id = 1
    updated_awards_data = []

    for award in awards_data:
        group_name = award.get("group")
        song_name = award.get("song")
        
        key = (group_name, song_name)

        if key not in unique_group_songs:
            unique_group_songs[key] = next_id
            next_id += 1
        
        song_id = unique_group_songs[key]

        new_award_entry = {
            "show": award.get("show"),
            "week": award.get("week"),
            "year": award.get("year"),
            "song_id": song_id
        }
        updated_awards_data.append(new_award_entry)
        
    group_song_list = [
        {"id": unique_group_songs[key], "group": key[0], "song": key[1]}
        for key in unique_group_songs
    ]
    
    with open(group_song_map_path, 'w', encoding='utf-8') as f:
        json.dump(group_song_list, f, ensure_ascii=False, indent=4)
    
    with open(file_path, 'w', encoding='utf-8') as f:
        json.dump(updated_awards_data, f, ensure_ascii=False, indent=4)

    print(f"Proses ETL tambahan selesai. File 'awards.json' diperbarui dengan ID.")
    print(f"Total {len(group_song_list)} pasangan grup/lagu unik disimpan di '{group_song_map_path}'.")


if __name__ == "__main__":
    base_dir = os.path.join(os.path.dirname(os.path.dirname(__file__)), 'data')
    
    artists_file_path = os.path.join(base_dir, 'artists.json')
    awards_file_path = os.path.join(base_dir, 'awards.json')
    group_song_map_path = os.path.join(base_dir, 'group_song_map.json')
    
    clean_artists_data(artists_file_path)
    print("-" * 50)
    transform_awards_to_normalized_data(awards_file_path, group_song_map_path)