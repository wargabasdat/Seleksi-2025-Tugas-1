import json
import re

with open('c:\\Users\\naura\\OneDrive\\Documents\\ITB\\SMT 5\\Seleksi-2025-Tugas-1\\Data Scraping\\data\\character.json', 'r', encoding='utf-8') as f:
    data = json.load(f)

symbol = r'[☆♡""・]|[\u2600-\u26FF]|[\u2700-\u27BF]|[^\x00-\x7F]+'
translation_fix = {
    r"man'?s co\.?": "",
    r"\bco\.?\b": "",
    r"\bent\b": "friend",
    r"\bs\b": "",
    r"(?<!\w)ry\b": "",
    r"\bmi\b": "",
    r"(?<!\w)ed\b": "",
    r"\bareed\b": "are",
    r"(?<!\w)ro\b": "",
    r"tabe\b": "",
    r"\btotetote\b": "",
    r"\bshinshin\b": "",
    r"\bAwatenbo's\b": "",
    r"\bMimizuku's\b": "",
    r"I have never changed since 100 million years ago\.": "",
    r"CH$": "",
    r"OL$": "!",
    r"\bPappau\b": "Power",
    r"\bPantan\b": "Pan",
    r"a man's house": "a character",
    r"a si of three": "a set of three",
    r"a egg": "an egg",
    r"sy is": "style is",
    r"the bu of tea-eye": "the blue-eyed",
    r"m es of the s": "",
    r"dais of cat": "types of cat",
    r"the der": "the world",
    r"male \(It is said": "male cat (It is said",
    r"The colon is": "Coron is",
    r"str ling": "struggling",
    r"songer": "singer", 
    r"Mel and this": "",
    r"The dream of the future is to be\.": "The dream of the future is to succeed.",
    r"the habit of mouth is\.": "the habit of speaking often.",
    r"It's a dream to save money and open my shop for some time!": "It's a dream to save money and open my own shop someday!",
    r"\bOmurais\b": "Omurice",
    r"\bDanpu-no-Dan\b": "Danpu",
    r"Its a little bit ry": "It's a little bit shy",
    r"blue human mi": "blue hair",
    r"tea-eye": "tea-colored eyes",
    r"a man of dogs": "a dog character",
    r"a fashionable penguin man": "a fashionable penguin",
    r"imoushi": "mouse",
    r"opus \(": "(",
    r"a pink nose and white pattern": "a pink nose and white spots",
    r"abby time": "a busy time",
    r"theboshi bothing": "the world around them"
}

anomaly_friends_name = ["r", "s", "opus", "ing", "Z e Teeth", "No  Goro", "Coco and s"]
cleaned_data = []

for character in data:
    
    name = character.get('name', '').strip()
    name = re.sub(symbol, '', name).strip()

    if "MINNANO" in name:
        name = "MINNANOTABO"
    
    cleaned_character = {
        "name": name,
        "description": None,
        "friends": []
    }
    
    # clean description
    if "description" in character and character["description"]:
        desc = character["description"]
        # ilangin simbol
        desc = re.sub(symbol, '', desc)

        # buat kalimat terpootong
        desc = re.sub(r'to be a\s*\.', 'to be.', desc)
        desc = re.sub(r'is a\s*\.', 'is.', desc)
        desc = re.sub(r'\s+\.', '.', desc)

        # buat spasi
        desc = ' '.join(desc.split())

        # perbaikin kalimat yang diawali lowercase setelah titik
        desc = re.sub(r'\.(\s*)([a-z])', lambda m: f".{m.group(1)}{m.group(2).upper()}", desc)
        if desc.strip():
            cleaned_character["description"] = desc
    
    # clean friends 
    if "friends" in character and character["friends"]:
        non_empty_friends = []
        for friend in character["friends"]:
            if not friend or not friend.strip():
                continue
                
            # ilangin simbol
            cleaned_friend = re.sub(symbol, '', friend).strip()
            
            # skip kalo kosong
            if not cleaned_friend:
                continue

            # skip kalo namanya aneh
            if cleaned_friend in anomaly_friends_name:
                continue

            # perbaikin tutup/buka kurung
            cleaned_friend = re.sub(r'\s*\(\s*\)\)+', '', cleaned_friend)
            cleaned_friend = re.sub(r'\s*\(with.*?\)', '', cleaned_friend)
            cleaned_friend = re.sub(r'\s*\((long|short) hair\)', '', cleaned_friend)

            # skip kalo kepanjangan namanya
            if len(cleaned_friend) > 30:  
                continue
            
            non_empty_friends.append(cleaned_friend)
            
        # menghilangkan duplikasi
        unique_friends = []
        seen = set()
        for friend in non_empty_friends:
            friend_lower = friend.lower()
            if friend_lower not in seen:
                seen.add(friend_lower)
                unique_friends.append(friend)
        
        cleaned_character["friends"] = unique_friends
    
    cleaned_data.append(cleaned_character)


# Save the cleaned data
with open('c:\\Users\\naura\\OneDrive\\Documents\\ITB\\SMT 5\\Seleksi-2025-Tugas-1\\Data Scraping\\data\\character.json', 'w', encoding='utf-8') as f:
    json.dump(cleaned_data, f, ensure_ascii=False, indent=2)
