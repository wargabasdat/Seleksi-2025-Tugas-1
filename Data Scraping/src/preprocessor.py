import json
from datetime import datetime
from collections import defaultdict

# fungsi untuk membuat junction table classes dan equipment
def create_equipment_junction_tables(): 
    # Load data mentah equipment
    with open('../data/raw/kalm_equipment.json', 'r', encoding='utf-8') as f:
        raw_equipment = json.load(f)
    
    # Extract nama equipment yang unik
    unique_equipment = set()
    class_equipment_map = defaultdict(list)
    
    for eq in raw_equipment:
        equipment_name = normalize_equipment_name(eq['equipment_name'])
        unique_equipment.add(equipment_name)
        class_equipment_map[eq['class_id']].append(equipment_name)
    
    # Membuat tabel equipment
    equipment_master = []
    equipment_name_to_id = {}
    
    for i, equipment_name in enumerate(sorted(unique_equipment), 1):
        equipment_record = {
            "equipment_id": i,
            "equipment_name": equipment_name
        }
        equipment_master.append(equipment_record)
        equipment_name_to_id[equipment_name] = i
    
    # Membuat class_equipment juction table
    class_equipment_junction = []
    
    for class_id, equipment_names in class_equipment_map.items():
        for equipment_name in equipment_names:
            normalized_name = normalize_equipment_name(equipment_name)
            equipment_id = equipment_name_to_id[normalized_name]
            
            junction_record = {
                "class_id": class_id,
                "equipment_id": equipment_id
            }
            class_equipment_junction.append(junction_record)

    return equipment_master, class_equipment_junction

# fungsi untuk menormalisasi nama equipment agar seragam
def normalize_equipment_name(equipment_name):
    if not equipment_name:
        return equipment_name
    
    normalizations = {
        'mat': 'Mat',
        'water bottle': 'Water Bottle',
        'small towel': 'Small Towel', 
        'small tower': 'Small Towel',  # Fix typo
        'grip socks': 'Grip Socks'
    }
    
    name_lower = equipment_name.lower().strip()
    return normalizations.get(name_lower, equipment_name.title())

# fungsi untuk mengekstrak integer dari string duration (60 mins -> 60)
def extract_duration_minutes(duration_str):
    if not duration_str:
        return None
    
    import re
    match = re.search(r'(\d+)', duration_str)
    return int(match.group(1)) if match else None

def preprocess_with_junction_tables():   
    # Load semua data mentah
    with open('../data/raw/kalm_classes.json', 'r', encoding='utf-8') as f:
        raw_classes = json.load(f)
    
    with open('../data/raw/kalm_reviews.json', 'r', encoding='utf-8') as f:
        raw_reviews = json.load(f)
    
    with open('../data/raw/kalm_related_classes.json', 'r', encoding='utf-8') as f:
        raw_related = json.load(f)
    
    with open('../data/raw/kalm_instructors.json', 'r', encoding='utf-8') as f:
        raw_instructors = json.load(f)
    
    with open('../data/raw/kalm_schedules.json', 'r', encoding='utf-8') as f:
        raw_schedules = json.load(f)
    
    # Membuat kategori
    categories = [
        {"category_id": 1, "category_name": "Yoga"},
        {"category_id": 2, "category_name": "Prenatal Yoga"},
        {"category_id": 3, "category_name": "Mat Pilates"},
        {"category_id": 4, "category_name": "Private Pilates"},
        {"category_id": 5, "category_name": "Group Reformer"}
    ]
    
    # Proses Classes
    classes = []
    class_name_to_id = {}
    
    for cls in raw_classes:
        category_id = categorize_class(cls['name'])
        
        cleaned_class = {
            "class_id": cls['class_id'],
            "name": cls['name'],
            "category_id": category_id,
            "duration": extract_duration_minutes(cls['duration']),
            "difficulty_level": cls['difficulty_level'],
            "location": cls['location'],
            "about_class_description": cls['about_class_description']
        }
        classes.append(cleaned_class)
        class_name_to_id[cls['name']] = cls['class_id']
    
    # Buat junction table
    equipment_master, class_equipment_junction = create_equipment_junction_tables()

    # Proses Reviews
    reviews = []
    review_counter_by_class = defaultdict(int)
    for review in raw_reviews:
        class_id = review['class_id']
        review_counter_by_class[class_id] += 1

        cleaned_review = {
            "review_order": review_counter_by_class[class_id],
            "class_id": review['class_id'],
            "instructor_reviewed": review['reviewer_name'],
            "review_text": review['review_text'],
            "review_location": review['review_location'],
            "stars_rating": review['stars_rating']
        }
        reviews.append(cleaned_review)
    
    # Proses Related Classes
    related_classes = []
    related_counter_by_class = defaultdict(int)

    for related in raw_related:
        main_class_id = related['main_class_id']
        related_counter_by_class[main_class_id] += 1

        cleaned_related = {
            "related_order": related_counter_by_class[main_class_id],
            "main_class_id": related['main_class_id'],
            "title": related['title'],
            "stars_rating": round(float(related['stars_rating'])) if related['stars_rating'] else None,
            "duration": extract_duration_minutes(related['duration']),
            "difficulty_level": related['difficulty_level'],
            "description": related['description']
        }
        related_classes.append(cleaned_related)

    # Proses Instructors
    instructors = []
    instructor_name_to_id = {}
    
    for instructor in raw_instructors:
        cleaned_instructor = {
            "instructor_id": instructor['instructor_id'],
            "name": instructor['name'],
            "role": instructor['role'],
        }
        instructors.append(cleaned_instructor)
        instructor_name_to_id[instructor['name']] = instructor['instructor_id']
    
    schedule_instructors = set()
    for schedule in raw_schedules:
        if schedule.get('instructor_name'):
            schedule_instructors.add(schedule['instructor_name'].strip())
    
    missing_instructors = schedule_instructors - set(instructor_name_to_id.keys())
    instructor_counter = len(instructors) + 1
    
    for name in missing_instructors:
        new_instructor = {
            "instructor_id": f"instructor_{instructor_counter}",
            "name": name,
            "role": "Instructor",
        }
        instructors.append(new_instructor)
        instructor_name_to_id[name] = f"instructor_{instructor_counter}"
        instructor_counter += 1

    # Proses Schedules
    schedules = []
    for schedule in raw_schedules:
        class_name = schedule.get('class_name', '').strip()
        instructor_name = schedule.get('instructor_name', '').strip()
        
        cleaned_schedule = {
            "schedule_id": schedule['schedule_id'],
            "class_id": class_name_to_id.get(class_name),
            "instructor_id": instructor_name_to_id.get(instructor_name),
            "date": schedule['date'],
            "start_time": schedule['start_time'],
            "duration": extract_duration_minutes(schedule['duration']),
            "location": schedule['location']
        }
        schedules.append(cleaned_schedule)
    
    # Save semua file final yang telah diproses
    final_files = {
        'final_categories.json': categories,
        'final_classes.json': classes,
        'final_equipment.json': equipment_master,
        'final_class_equipment.json': class_equipment_junction,
        'final_reviews.json': reviews,
        'final_related_classes.json': related_classes,
        'final_instructors.json': instructors,
        'final_schedules.json': schedules
    }
    
    for filename, data in final_files.items():
        with open(f'../data/preprocessed/{filename}', 'w', encoding='utf-8') as f:
            json.dump(data, f, indent=2, ensure_ascii=False)

    return final_files

# fungsi untuk mengkategorikan tiap kelas
def categorize_class(class_name):
    name_lower = class_name.lower()
    
    if any(pattern in name_lower for pattern in ['private pilates', 'private reformer']):
        return 4  # Private Pilates
    
    if 'mat pilates' in name_lower:
        return 3  # Mat Pilates
    
    if 'prenatal' in name_lower:
        return 2  # Prenatal Yoga
    
    if any(pattern in name_lower for pattern in [
        'strength & flow reformer', 'total body reformer', 'reformer 101', 
        'tower only', 'reformer / tower', 'reformer/tower'
    ]):
        return 5  # Group Reformer
    
    return 1  # Yoga (default)

# main
if __name__ == "__main__": 
    final_files = preprocess_with_junction_tables()
    print("Preprocessing completed yay")
    