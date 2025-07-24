import json
import re
import os
from datetime import datetime

def clean_title(title):
    # Remove emojis and special characters, keep only alphanumeric and basic punctuation
    cleaned = re.sub(r'[^\w\s\-\.\(\)\[\]\'\"]+', '', title)
    return cleaned.strip()

def parse_number(value):
    # Convert K, M format numbers to integers
    if isinstance(value, (int, float)):
        return int(value)
    
    value_str = str(value).replace(',', '').replace('+', '').strip()
    
    if value_str.lower().endswith('k'):
        return int(float(value_str[:-1]) * 1000)
    elif value_str.lower().endswith('m'):
        return int(float(value_str[:-1]) * 1000000)
    elif value_str.lower().endswith('b'):
        return int(float(value_str[:-1]) * 1000000000)
    else:
        try:
            return int(float(value_str))
        except:
            return 0

def convert_date(date_str):
    # Convert MM/DD/YYYY to YYYY-MM-DD
    try:
        # Parse MM/DD/YYYY format
        date_obj = datetime.strptime(date_str, '%m/%d/%Y')
        # Return YYYY-MM-DD format
        return date_obj.strftime('%Y-%m-%d')
    except:
        return date_str

def load_json(filename):
    try:
        with open(f'data/raw/{filename}', 'r', encoding='utf-8') as f:
            data = json.load(f)
            if isinstance(data, dict):
                return [data]
            return data
    except FileNotFoundError:
        return []

def save_json(filename, data):
    os.makedirs('data', exist_ok=True)
    
    with open(f'data/preprocessed/{filename}', 'w', encoding='utf-8') as f:
        json.dump(data, f, indent=2, ensure_ascii=False)

def process_games_data(games_data):
    processed_games = []
    for game in games_data:
        processed_game = game.copy()
        
        # Clean title
        if 'Title' in processed_game:
            processed_game['Title'] = clean_title(processed_game['Title'])
        
        # Parse numbers
        number_fields = ['Total Visits', 'Active Users', 'Favorites', 'Thumbs Up', 'Thumbs Down']
        for field in number_fields:
            if field in processed_game:
                processed_game[field] = parse_number(processed_game[field])
        
        # Convert dates
        date_fields = ['Date Created', 'Last Updated']
        for field in date_fields:
            if field in processed_game:
                processed_game[field] = convert_date(processed_game[field])
        
        processed_games.append(processed_game)
    
    return processed_games

def process_community_data(community_data):
    processed_communities = []
    
    for community in community_data:
        processed_community = community.copy()
        
        # Parse members number
        if 'Members' in processed_community:
            processed_community['Members'] = parse_number(processed_community['Members'])
        
        processed_communities.append(processed_community)
    
    return processed_communities

def create_reference_tables(games_data, community_data, creator_data):
    # Extract unique genres from games data (preserve order of first occurrence)
    genres = []
    seen_genres = set()
    for game in games_data:
        if 'Genre' in game and game['Genre'] and game['Genre'].strip():
            genre = game['Genre'].strip()
            if genre not in seen_genres:
                genres.append(genre)
                seen_genres.add(genre)
    
    genre_table = []
    genre_id_map = {}
    for i, genre in enumerate(genres, 1):  # Auto increment from 1
        genre_table.append({
            'genre_id': i,
            'genre_name': genre
        })
        genre_id_map[genre] = i
    
    # Extract unique communities (preserve order of first occurrence)
    communities = []
    seen_communities = set()
    
    # First from games data
    for game in games_data:
        if 'Community' in game and game['Community'] and game['Community'].strip():
            community = game['Community'].strip()
            if community not in seen_communities:
                communities.append(community)
                seen_communities.add(community)
    
    # Then from community.json
    for community in community_data:
        if 'Community Name' in community and community['Community Name'] and community['Community Name'].strip():
            community_name = community['Community Name'].strip()
            if community_name not in seen_communities:
                communities.append(community_name)
                seen_communities.add(community_name)
    
    community_table = []
    community_id_map = {}
    for i, community in enumerate(communities, 1):  # Auto increment from 1
        community_table.append({
            'community_id': i,
            'community_name': community
        })
        community_id_map[community] = i
    
    # Extract unique creators (preserve order of first occurrence)
    creators = []
    seen_creators = set()
    
    # First from community data
    for community in community_data:
        if 'Creator Name' in community and community['Creator Name'] and community['Creator Name'].strip():
            creator = community['Creator Name'].strip()
            if creator not in seen_creators:
                creators.append(creator)
                seen_creators.add(creator)
    
    # Then from creator.json
    for creator in creator_data:
        if 'Creator Name' in creator and creator['Creator Name'] and creator['Creator Name'].strip():
            creator_name = creator['Creator Name'].strip()
            if creator_name not in seen_creators:
                creators.append(creator_name)
                seen_creators.add(creator_name)
    
    creator_table = []
    creator_id_map = {}
    for i, creator in enumerate(creators, 1):  # Auto increment from 1
        creator_table.append({
            'creator_id': i,
            'creator_name': creator
        })
        creator_id_map[creator] = i
    
    return (genre_table, genre_id_map, 
            community_table, community_id_map,
            creator_table, creator_id_map)

def transform_games_with_ids(games_data, genre_id_map, community_id_map):
    transformed_games = []
    
    for game in games_data:
        transformed_game = game.copy()
        
        # Replace Genre with genreID
        if 'Genre' in transformed_game:
            genre_name = transformed_game['Genre'].strip() if transformed_game['Genre'] else None
            if genre_name:
                transformed_game['genreID'] = genre_id_map.get(genre_name, None)
            else:
                transformed_game['genreID'] = None
            del transformed_game['Genre']
        
        # Replace Community with communityID
        if 'Community' in transformed_game:
            community_name = transformed_game['Community'].strip() if transformed_game['Community'] else None
            if community_name:
                transformed_game['communityID'] = community_id_map.get(community_name, None)
            else:
                transformed_game['communityID'] = None
            del transformed_game['Community']
        
        # Delete Category field
        if 'Category' in transformed_game:
            del transformed_game['Category']
        
        transformed_games.append(transformed_game)
    
    return transformed_games

def transform_community(community_data, creator_id_map, community_id_map):
    transformed_communities = []
    
    for community in community_data:
        transformed_community = community.copy()
        
        # Add communityID based on Community Name
        if 'Community Name' in transformed_community:
            community_name = transformed_community['Community Name'].strip() if transformed_community['Community Name'] else None
            if community_name:
                transformed_community['communityID'] = community_id_map.get(community_name, None)
            else:
                transformed_community['communityID'] = None
        
        # Replace Creator Name with creatorID
        if 'Creator Name' in transformed_community:
            creator_name = transformed_community['Creator Name'].strip() if transformed_community['Creator Name'] else None
            if creator_name:
                transformed_community['creatorID'] = creator_id_map.get(creator_name, None)
            else:
                transformed_community['creatorID'] = None
            del transformed_community['Creator Name']
        
        transformed_communities.append(transformed_community)
    
    return transformed_communities

def transform_creator_data(creator_data, creator_id_map):
    transformed_creators = []
    
    for creator in creator_data:
        transformed_creator = creator.copy()
        
        # Add creatorID based on Creator Name
        if 'Creator Name' in transformed_creator:
            creator_name = transformed_creator['Creator Name'].strip() if transformed_creator['Creator Name'] else None
            if creator_name:
                transformed_creator['creatorID'] = creator_id_map.get(creator_name, None)
            else:
                transformed_creator['creatorID'] = None
        
        transformed_creators.append(transformed_creator)
    
    return transformed_creators

def main():

    if not os.path.exists('data'):
        os.makedirs('data', exist_ok=True)

    required_files = ['game.json', 'community.json', 'creator.json']
    missing_files = []
    
    for file in required_files:
        if not os.path.exists(f'data/raw/{file}'):
            missing_files.append(file)
    
    # Load data
    games_data = load_json('game.json')
    community_data = load_json('community.json')
    creator_data = load_json('creator.json')
    
    # Process data
    processed_games = process_games_data(games_data)
    processed_communities = process_community_data(community_data)
    
    # Create reference tables
    (genre_table, genre_id_map, 
     community_table, community_id_map,
     creator_table, creator_id_map) = create_reference_tables(
        processed_games, processed_communities, creator_data
    )
    
    # Transform data with IDs
    transformed_games = transform_games_with_ids(processed_games, genre_id_map, community_id_map)
    transformed_communities = transform_community(processed_communities, creator_id_map, community_id_map)
    transformed_creators = transform_creator_data(creator_data, creator_id_map)
    
    # Save results
    save_json('game_preprocessed.json', transformed_games)
    save_json('community_preprocessed.json', transformed_communities)
    save_json('creator_preprocessed.json', transformed_creators)
    save_json('genre_preprocessed.json', genre_table)
    
if __name__ == "__main__":
    main()