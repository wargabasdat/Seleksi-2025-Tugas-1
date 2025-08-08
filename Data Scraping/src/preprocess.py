import json
import re
import os
from datetime import datetime

def clean_title(title):
    """Remove emojis and special characters, keep only alphanumeric and basic punctuation"""
    cleaned = re.sub(r'[^\w\s\-\.\(\)\[\]\'\"]+', '', title)
    return cleaned.strip()

def parse_number(value):
    """Convert K, M, B format numbers to integers"""
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
    """Convert MM/DD/YYYY to YYYY-MM-DD"""
    try:
        date_obj = datetime.strptime(date_str, '%m/%d/%Y')
        return date_obj.strftime('%Y-%m-%d')
    except:
        return date_str

def load_json(filename):
    path = f'data/raw/{filename}'
    if not os.path.exists(path):
        return []
    with open(path, 'r', encoding='utf-8') as f:
        data = json.load(f)
        return [data] if isinstance(data, dict) else data

def save_json(filename, data):
    os.makedirs('data/preprocessed', exist_ok=True)
    with open(f'data/preprocessed/{filename}', 'w', encoding='utf-8') as f:
        json.dump(data, f, indent=2, ensure_ascii=False)

def process_games_data(games_data):
    processed_games = []
    for game in games_data:
        g = game.copy()
        if 'Title' in g:
            g['Title'] = clean_title(g['Title'])
        for field in ['Total Visits', 'Active Users', 'Favorites', 'Thumbs Up', 'Thumbs Down']:
            if field in g:
                g[field] = parse_number(g[field])
        for field in ['Date Created', 'Last Updated']:
            if field in g:
                g[field] = convert_date(g[field])
        processed_games.append(g)
    return processed_games

def process_community_data(community_data):
    processed = []
    for c in community_data:
        cc = c.copy()
        if 'Members' in cc:
            cc['Members'] = parse_number(cc['Members'])
        processed.append(cc)
    return processed

def create_reference_tables(games_data, community_data, creator_data):
    # ----- GENRE -----
    seen_genres = {}
    for game in games_data:
        val = game.get('Genre')
        if val:
            key = val.strip().lower()
            if key not in seen_genres:
                seen_genres[key] = val.strip()
    genres = list(seen_genres.values())
    genre_table = [{"genre_id": i+1, "genre_name": g} for i, g in enumerate(genres)]
    genre_id_map = {g.lower(): i+1 for i, g in enumerate(genres)}

    # community
    seen_com = {}
    for comm in community_data:
        name = comm.get('Community Name')
        if name:
            key = name.strip().lower()
            if key not in seen_com:
                seen_com[key] = name.strip()
    communities = list(seen_com.values())
    community_table = [{"community_id": i+1, "community_name": c} for i, c in enumerate(communities)]
    community_id_map = {c.lower(): i+1 for i, c in enumerate(communities)}

    # creator
    seen_creator = {}
    for comm in community_data:
        val = comm.get('Creator Name')
        if val:
            key = val.strip().lower()
            if key not in seen_creator:
                seen_creator[key] = val.strip()
    for cr in creator_data:
        val = cr.get('Creator Name')
        if val:
            key = val.strip().lower()
            if key not in seen_creator:
                seen_creator[key] = val.strip()
    creators = list(seen_creator.values())
    creator_table = [{"creator_id": i+1, "creator_name": c} for i, c in enumerate(creators)]
    creator_id_map = {c.lower(): i+1 for i, c in enumerate(creators)}

    # maturity
    seen_mat = {}
    for game in games_data:
        val = game.get('Maturity')
        if val:
            key = val.strip().lower()
            if key not in seen_mat:
                seen_mat[key] = val.strip()
    maturities = list(seen_mat.values())
    maturity_table = [{"maturity_id": i+1, "maturity_level": m} for i, m in enumerate(maturities)]
    maturity_id_map = {m.lower(): i+1 for i, m in enumerate(maturities)}

    return (genre_table, genre_id_map,
            community_table, community_id_map,
            creator_table, creator_id_map,
            maturity_table, maturity_id_map)

def transform_games_with_ids(games_data, genre_id_map, community_id_map, maturity_id_map):
    transformed = []
    for idx, g in enumerate(games_data, 1):
        t = g.copy()
        # genreID
        genre_name = t.pop('Genre', None)
        t['genreID'] = genre_id_map.get(genre_name.strip().lower(), None) if genre_name else None
        # communityID 
        comm_name = t.pop('Community', None)
        t['communityID'] = community_id_map.get(comm_name.strip().lower(), None) if comm_name else None
        # maturity_id
        mat = t.pop('Maturity', None)
        t['maturity_id'] = maturity_id_map.get(mat.strip().lower(), None) if mat else None
        # server_id unik per game
        t.pop('Server Size', None)
        t['server_id'] = idx
        # remove Category
        t.pop('Category', None)
        transformed.append(t)
    return transformed

def transform_community(community_data, creator_id_map, community_id_map):
    transformed = []
    seen = set()
    for c in community_data:
        t = c.copy()
        cname = t.get('Community Name')
        t['communityID'] = community_id_map.get(cname.strip().lower(), None) if cname else None
        cr = t.get('Creator Name')
        t['creatorID'] = creator_id_map.get(cr.strip().lower(), None) if cr else None
        t.pop('Creator Name', None)
        key = tuple(sorted(t.items()))
        if key in seen:
            continue
        seen.add(key)
        transformed.append(t)
    return transformed

def transform_creator_data(creator_data, creator_id_map):
    transformed = []
    seen = set()
    for c in creator_data:
        t = c.copy()
        cname = t.get('Creator Name')
        t['creatorID'] = creator_id_map.get(cname.strip().lower(), None) if cname else None
        key = tuple(sorted(t.items()))
        if key in seen:
            continue
        seen.add(key)
        transformed.append(t)
    return transformed

def main():
    os.makedirs('data', exist_ok=True)
    games = load_json('game.json')
    comms = load_json('community.json')
    creators = load_json('creator.json')
    print(f"Loaded {len(games)} games, {len(comms)} communities, {len(creators)} creators")

    pgames = process_games_data(games)
    pcomms = process_community_data(comms)

    (genre_table, genre_id_map,
     community_table, community_id_map,
     creator_table, creator_id_map,
     maturity_table, maturity_id_map) = create_reference_tables(
        pgames, pcomms, creators
    )

    tg = transform_games_with_ids(pgames, genre_id_map, community_id_map, maturity_id_map)
    tc = transform_community(pcomms, creator_id_map, community_id_map)
    tcr = transform_creator_data(creators, creator_id_map)

    save_json('game_preprocessed.json', tg)
    save_json('community_preprocessed.json', tc)
    save_json('creator_preprocessed.json', tcr)
    save_json('genre_preprocessed.json', genre_table)
    save_json('maturity_preprocessed.json', maturity_table)
    print("Done! Output saved in data/preprocessed/")

if __name__ == "__main__":
    main()
