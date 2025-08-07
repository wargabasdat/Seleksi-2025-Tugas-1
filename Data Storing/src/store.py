import json
import os
from datetime import datetime
import psycopg2

print("🔍 STARTING DEBUG MODE...")

# Test path first
path = 'C:/Users/Velicia/OneDrive/Documents/ITB/SeleksiBasdat/TUGAS_SELEKSI_1_18223085/Data Scraping/data'
print(f"📁 Checking path: {path}")
print(f"📁 Path exists: {os.path.exists(path)}")

if os.path.exists(path):
    files = os.listdir(path)
    json_files = [f for f in files if f.endswith('.json')]
    print(f"📁 JSON files found: {json_files}")
else:
    print("❌ PATH NOT FOUND! Check your data directory.")
    exit(1)

def join_pathfile(path, file):
    result = os.path.join(path, file)
    print(f"🔗 Joining: {result}")
    return result

# Load all JSON files with error handling
def load_json_safe(filepath):
    try:
        print(f"📖 Attempting to load: {filepath}")
        print(f"📖 File exists: {os.path.exists(filepath)}")
        
        with open(filepath, 'r', encoding='utf-8') as f:
            data = json.load(f)
        print(f"✅ Loaded {len(data)} records from {os.path.basename(filepath)}")
        return data
    except FileNotFoundError:
        print(f"❌ File not found: {filepath}")
        return []
    except json.JSONDecodeError as e:
        print(f"❌ Invalid JSON in {filepath}: {e}")
        return []
    except Exception as e:
        print(f"❌ Error loading {filepath}: {e}")
        import traceback
        traceback.print_exc()
        return []

print("=== Starting JSON file loading ===")

# Test each file one by one
json_files_to_load = [
    'books_price.json',
    'books.json', 
    'coding_class_info.json',
    'kiddo_stem_program.json',
    'kinder_coding_package.json',
    'branch.json',
    'paud_teacher_training.json',
    'program.json',
    'school_teacher_training.json',
    'thematic_class.json',
    'webinar.json',
    'zone.json',
    'book_writer.json'
]

loaded_data = {}

for filename in json_files_to_load:
    print(f"\n--- Loading {filename} ---")
    filepath = join_pathfile(path, filename)
    data = load_json_safe(filepath)
    loaded_data[filename.replace('.json', '_load')] = data
    
    if filename == 'program.json' and data:
        print(f"🔍 Program JSON structure: {list(data[0].keys())}")
        print(f"🔍 Sample program: {data[0]}")

# Extract individual variables
books_price_load = loaded_data['books_price_load']
books_load = loaded_data['books_load']
coding_class_info_load = loaded_data['coding_class_info_load']
kiddo_stem_program_load = loaded_data['kiddo_stem_program_load']
kinder_coding_package_load = loaded_data['kinder_coding_package_load']
branch_load = loaded_data['branch_load']
paud_teacher_training_load = loaded_data['paud_teacher_training_load']
program_load = loaded_data['program_load']
school_teacher_training_load = loaded_data['school_teacher_training_load']
thematic_class_load = loaded_data['thematic_class_load']
webinar_load = loaded_data['webinar_load']
zone_load = loaded_data['zone_load']
book_writer_load = loaded_data['book_writer_load']

print("=== JSON loading completed ===")
print(f"📊 Data loaded summary:")
for key, data in loaded_data.items():
    print(f"  {key}: {len(data)} records")

# Check if essential data is loaded
if not program_load:
    print("❌ No program data loaded. Cannot proceed.")
    print("🔍 Available files in data directory:")
    for f in os.listdir(path):
        print(f"  - {f}")
    exit(1)

print("✅ All JSON files loaded successfully, proceeding to database...")

