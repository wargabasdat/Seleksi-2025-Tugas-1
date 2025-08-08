import requests
import re
import json
from bs4 import BeautifulSoup
import os


# === Scraping Data Kamera dari DXOMARK ===
def scrape_camera_data():
    headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'
    }
    try:
        response = requests.get('https://www.dxomark.com/camera-sensors/', headers=headers)
        response.raise_for_status()
        html_content = response.text
    except requests.RequestException as e:
        print(f"Error fetching data: {e}")
        return None
    
    soup = BeautifulSoup(html_content, 'html.parser')
    scripts = soup.find_all('script')

    camera_data = None
    for script in scripts:
        if 'var cameraSensorsAsJson' in script.text:
            script_content = script.text
            match = re.search(r'var cameraSensorsAsJson = (\[.*?\]);', script_content, re.DOTALL)
            if match:
                json_string = match.group(1)
                try:
                    camera_data = json.loads(json_string)
                    break
                except json.JSONDecodeError as e:
                    print(f"Error decoding JSON: {e}")
                    return None
            else :
                print("No camera data found in script.")
                return None
    return camera_data

# === Fungsi untuk Mengurutkan dan Mengambil 100 Kamera Teratas ===
def get_top_100_cameras(all_cameras_data):
    if not all_cameras_data:
        return []

    sorted_by_date = sorted(all_cameras_data, key=lambda item: item['launch_date'], reverse=True)
    sorted_by_brand = sorted(sorted_by_date, key=lambda item: item['brand'])
    final_sorted_data = sorted(sorted_by_brand, key=lambda item: item['rankDxoScore'], reverse=True)
    
    top_100 = final_sorted_data[:100]
    
    return top_100

# === Fungsi untuk Preprocessing Data ===
def preprocess_data(top_100_data):
    cleaned_cameras = []
    transformed_scores = []
    
    score_mapping = {
        'rankDxoScore': 'Overall',
        'rankColorScore': 'Portrait (Color Depth)',
        'rankDynScore': 'Landscape (Dynamic Range)',
        'rankLlnScore': 'Sports (Low-Light ISO)'
    }
    
    for index, camera in enumerate(top_100_data):
        camera_id = index + 1

        cleaned_camera_data = {
            'camera_id': camera_id,
            'name': camera.get('name'),
            'brand': camera.get('brand'),
            'model': camera.get('model'),
            'launch_date': camera.get('launch_date'),
            'launch_price_usd': camera.get('launch_price'),
            'sensor_format': camera.get('sensorFormat'),
            'pixel_depth_mp': camera.get('pixelDepth')
        }
        cleaned_cameras.append(cleaned_camera_data)

        for raw_score_name, descriptive_name in score_mapping.items():
            if raw_score_name in camera:
                score_entry = {
                    'score_id': len(transformed_scores) + 1,
                    'camera_id': camera_id,
                    'score_type': descriptive_name,
                    'score_value': camera.get(raw_score_name)
                }
                transformed_scores.append(score_entry)
                
    return cleaned_cameras, transformed_scores

# === Main Execution ===
if __name__ == "__main__":
    all_camera_data = scrape_camera_data()
    
    if all_camera_data:
        print(f"\nTotal kamera mentah yang ditemukan: {len(all_camera_data)}")
        
        top_100_data = get_top_100_cameras(all_camera_data)
        final_cameras, final_scores = preprocess_data(top_100_data)
        
        current_dir = os.path.dirname(__file__)
        data_dir = os.path.join(current_dir, '..', 'data')
        camera_file_path = os.path.join(data_dir, 'cameras.json')
        score_file_path = os.path.join(data_dir, 'scores.json')

        try:
            with open(camera_file_path, 'w') as f:
                json.dump(final_cameras, f, indent=4)
            print(f"✅ Data kamera bersih berhasil disimpan ke '{camera_file_path}'")

            with open(score_file_path, 'w') as f:
                json.dump(final_scores, f, indent=4)
            print(f"✅ Data skor yang ditransformasi berhasil disimpan ke '{score_file_path}'")

            # Menampilkan contoh hasil akhir
            print("\nContoh data dari 'cameras.json':")
            print(json.dumps(final_cameras[0], indent=2))
            
            print("\nContoh data dari 'scores.json' untuk kamera pertama:")
            print(json.dumps([s for s in final_scores if s['camera_id'] == 1], indent=2))

        except IOError as e:
            print(f"Error saat menyimpan file: {e}")