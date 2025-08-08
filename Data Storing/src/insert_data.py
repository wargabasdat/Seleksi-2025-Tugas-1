import json
import mysql.connector
from faker import Faker
import re
from decimal import Decimal
import random

# Initialize Faker
fake = Faker()

# Database connection
def get_db_connection():
    try:
        connection = mysql.connector.connect(
            host='localhost',
            database='motogp',
            user='root', 
            password='alvin123'
        )
        return connection
    except mysql.connector.Error as error:
        print(f"Failed to connect to database: {error}")
        return None

def load_json_data():
    """Load MotoGP riders data from JSON file"""
    try:
        with open('../../Data Scraping/data/motogp_riders.json', 'r', encoding='utf-8') as file:
            return json.load(file)
    except FileNotFoundError:
        print("JSON file not found. Make sure the path is correct.")
        return None

def parse_race_info(race_string):
    """Parse race string to extract year and race name
    Example: '2000 500cc British Grand Prix' -> (2000, 'British Grand Prix')
    """
    if not race_string:
        return None, None
    
    # Extract year (first 4 digits)
    year_match = re.search(r'(\d{4})', race_string)
    year = int(year_match.group(1)) if year_match else None
    
    # Extract race name (everything after the class like '500cc' or 'MotoGP')
    race_name_match = re.search(r'(?:500cc|MotoGP)\s+(.+)', race_string)
    race_name = race_name_match.group(1) if race_name_match else race_string
    
    return year, race_name

def insert_countries(cursor, riders_data):
    """Insert unique countries from riders data"""
    countries = {}
    country_id = 1
    
    for rider in riders_data:
        if rider.get('country_name') and rider['country_name'] not in countries:
            countries[rider['country_name']] = country_id
            cursor.execute(
                "INSERT INTO negara (id_negara, nama_negara) VALUES (%s, %s)",
                (country_id, rider['country_name'])
            )
            country_id += 1
    
    return countries

def insert_constructors(cursor, num_constructors=10):
    """Insert fake constructor data"""
    constructors = []
    constructor_names = ['Honda', 'Yamaha', 'Ducati', 'Suzuki', 'KTM', 'Aprilia', 'BMW', 'Kawasaki', 'MV Agusta', 'Husqvarna']
    engine_types = ['V4', 'Inline-4', 'V-Twin', 'Single Cylinder', 'Parallel Twin']
    
    for i in range(num_constructors):
        constructor_id = i + 1
        name = constructor_names[i] if i < len(constructor_names) else fake.company()
        engine = random.choice(engine_types)
        
        cursor.execute(
            "INSERT INTO konstruktor (id_konstruktor, nama_konstruktor, jenis_mesin) VALUES (%s, %s, %s)",
            (constructor_id, name, engine)
        )
        constructors.append(constructor_id)
    
    return constructors

def insert_teams(cursor, constructors, num_teams=15):
    """Insert fake team data"""
    teams = []
    team_prefixes = ['Factory', 'Racing', 'Team', 'Squad', 'Pramac', 'LCR', 'Gresini', 'VR46', 'Tech3']
    
    for i in range(num_teams):
        team_id = i + 1
        constructor_id = random.choice(constructors)
        team_name = f"{random.choice(team_prefixes)} {fake.company().split()[0]}"
        
        cursor.execute(
            "INSERT INTO tim_balap (id_tim, nama_tim, id_konstruktor) VALUES (%s, %s, %s)",
            (team_id, team_name, constructor_id)
        )
        teams.append(team_id)
    
    return teams

def insert_riders(cursor, riders_data, countries):
    """Insert riders data from JSON"""
    rider_ids = []
    
    for rider in riders_data:
        if not rider.get('rider_name'):  # Skip empty riders
            continue
            
        country_id = countries.get(rider.get('country_name'))
        wins = rider.get('wins', 0)
        is_champion = rider.get('is_champion', False)
        is_active = rider.get('is_active_2025', False)
        
        cursor.execute("""
            INSERT INTO pembalap (nama, jumlah_kemenangan, is_champion, is_active, id_negara) 
            VALUES (%s, %s, %s, %s, %s)
        """, (rider['rider_name'], wins, is_champion, is_active, country_id))
        
        rider_ids.append(cursor.lastrowid)
    
    return rider_ids

def insert_sponsors(cursor, num_sponsors=20):
    """Insert fake sponsor data"""
    sponsors = []
    sponsor_types = ['Energy Drink', 'Motorcycle', 'Oil', 'Tire', 'Electronics', 'Clothing', 'Insurance', 'Banking']
    
    for i in range(num_sponsors):
        sponsor_id = i + 1
        sponsor_name = f"{fake.company()} {random.choice(sponsor_types)}"
        sponsor_value = Decimal(random.uniform(100000, 50000000))
        
        cursor.execute(
            "INSERT INTO sponsor (id_sponsor, nama_sponsor, nilai_sponsor) VALUES (%s, %s, %s)",
            (sponsor_id, sponsor_name, sponsor_value)
        )
        sponsors.append(sponsor_id)
    
    return sponsors

def insert_sponsor_collaborations(cursor, rider_ids, sponsors):
    """Insert fake sponsor collaboration data"""
    for rider_id in rider_ids:
        # Each rider has 1-3 sponsors
        num_sponsors = random.randint(1, 3)
        rider_sponsors = random.sample(sponsors, min(num_sponsors, len(sponsors)))
        
        for sponsor_id in rider_sponsors:
            years = random.randint(1, 5)
            cursor.execute(
                "INSERT INTO kerjasama_sponsor (id_pembalap, id_sponsor, lama_tahun) VALUES (%s, %s, %s)",
                (rider_id, sponsor_id, years)
            )

def insert_rider_teams(cursor, rider_ids, teams):
    """Insert fake rider-team relationships"""
    for rider_id in rider_ids:
        # Each rider is in 1-2 teams over their career
        num_teams = random.randint(1, 2)
        rider_teams = random.sample(teams, min(num_teams, len(teams)))
        
        base_year = random.randint(2000, 2024)
        for i, team_id in enumerate(rider_teams):
            year = base_year + i * random.randint(2, 5)
            cursor.execute(
                "INSERT INTO pembalap_tim (id_pembalap, id_tim, tahun) VALUES (%s, %s, %s)",
                (rider_id, team_id, year)
            )

def insert_races(cursor, riders_data, rider_ids):
    """Insert race data from first_win and last_win information"""
    race_id = 1
    processed_races = set()  # To avoid duplicate races
    
    for i, rider in enumerate(riders_data):
        if not rider.get('rider_name'):  # Skip empty riders
            continue
            
        rider_id = rider_ids[i] if i < len(rider_ids) else None
        if not rider_id:
            continue
        
        # Process first_win
        if rider.get('first_win'):
            year, race_name = parse_race_info(rider['first_win'])
            if year and race_name:
                race_key = (year, race_name)
                if race_key not in processed_races:
                    cursor.execute(
                        "INSERT INTO balapan (id_balapan, tahun, nama_balapan, id_pembalap_pemenang) VALUES (%s, %s, %s, %s)",
                        (race_id, year, race_name, rider_id)
                    )
                    processed_races.add(race_key)
                    race_id += 1
        
        # Process last_win
        if rider.get('last_win') and rider['last_win'] != rider.get('first_win'):
            year, race_name = parse_race_info(rider['last_win'])
            if year and race_name:
                race_key = (year, race_name)
                if race_key not in processed_races:
                    cursor.execute(
                        "INSERT INTO balapan (id_balapan, tahun, nama_balapan, id_pembalap_pemenang) VALUES (%s, %s, %s, %s)",
                        (race_id, year, race_name, rider_id)
                    )
                    processed_races.add(race_key)
                    race_id += 1

def main():
    # Load JSON data
    riders_data = load_json_data()
    if not riders_data:
        return
    
    # Connect to database
    connection = get_db_connection()
    if not connection:
        return
    
    cursor = connection.cursor()
    
    try:
        print("Starting data insertion...")
        
        # Insert countries
        print("Inserting countries...")
        countries = insert_countries(cursor, riders_data)
        print(f"Inserted {len(countries)} countries")
        
        # Insert constructors
        print("Inserting constructors...")
        constructors = insert_constructors(cursor)
        print(f"Inserted {len(constructors)} constructors")
        
        # Insert teams
        print("Inserting teams...")
        teams = insert_teams(cursor, constructors)
        print(f"Inserted {len(teams)} teams")
        
        # Insert riders
        print("Inserting riders...")
        rider_ids = insert_riders(cursor, riders_data, countries)
        print(f"Inserted {len(rider_ids)} riders")
        
        # Insert sponsors
        print("Inserting sponsors...")
        sponsors = insert_sponsors(cursor)
        print(f"Inserted {len(sponsors)} sponsors")
        
        # Insert sponsor collaborations
        print("Inserting sponsor collaborations...")
        insert_sponsor_collaborations(cursor, rider_ids, sponsors)
        print("Inserted sponsor collaborations")
        
        # Insert rider-team relationships
        print("Inserting rider-team relationships...")
        insert_rider_teams(cursor, rider_ids, teams)
        print("Inserted rider-team relationships")
        
        # Insert races
        print("Inserting races...")
        insert_races(cursor, riders_data, rider_ids)
        print("Inserted races")
        
        # Commit all changes
        connection.commit()
        print("All data inserted successfully!")
        
    except mysql.connector.Error as error:
        print(f"Error inserting data: {error}")
        connection.rollback()
    
    finally:
        cursor.close()
        connection.close()

if __name__ == "__main__":
    main()