import json, mariadb, time, os

# ---------------------------------------------

# tabel:    version
# file:     versions.json
def insert_version(json_file_path):
    conn = None
    try:
        conn = mariadb.connect(
            user=DB_USER, password=DB_PASSWORD, host=DB_HOST,
            port=DB_PORT, database=DB_NAME
        )
        cursor = conn.cursor()

        with open(json_file_path, 'r') as f:
            version_list = json.load(f)

        for version_data in version_list:
            try:
                # gabung tanggal dari json menjadi format tahun-bulan-tanggal
                release_date_str = f"{version_data.get('Year')}-{version_data.get('Month')}-{version_data.get('Date')}"

                version_tuple = (
                    version_data.get("Major Version"),
                    version_data.get("Minor Version"),
                    release_date_str
                )

                query = """
                    INSERT INTO version (major_version, minor_version, date)
                    VALUES (?, ?, ?)
                    ON DUPLICATE KEY UPDATE 
                        date=VALUES(date);
                """
                cursor.execute(query, version_tuple)
                # print(f"Berhasil memproses versi: {version_data.get('Major Version')}.{version_data.get('Minor Version')}")

            except mariadb.Error as e:
                print(f"Gagal memproses data: {e}")
            except (ValueError, TypeError) as e:
                print(f"Error pada data versi: {e}")

        conn.commit()
        print("Semua data versi berhasil diimpor ke dalam tabel version")

    except FileNotFoundError:
        print(f"Error: File '{json_file_path}' tidak ditemukan.")
    except mariadb.Error as e:
        print(f"Error koneksi atau query database: {e}")
    finally:
        if 'conn' in locals():
            cursor.close()
            conn.close()

# tabel:    domain
# file:     domains.json
def insert_domain(json_file_path):
    conn = None
    try:
        conn = mariadb.connect(
            user=DB_USER, password=DB_PASSWORD, host=DB_HOST,
            port=DB_PORT, database=DB_NAME
        )
        cursor = conn.cursor()

        with open(json_file_path, 'r') as f:
            domain_list = json.load(f)

        for domain_data in domain_list:
            try:
                version_str = domain_data.get("Version")
                major, minor = version_str.split('.')
                
                # tentukan id versi dari tabel version
                cursor.execute(
                    "SELECT id FROM version WHERE major_version = ? AND minor_version = ?",
                    (major, minor)
                )
                version_result = cursor.fetchone()
                
                if not version_result:
                    print(f"Peringatan: Versi {version_str} tidak ditemukan untuk domain '{domain_data.get('Name')}'")
                    continue
                
                version_id = version_result[0]

                domain_tuple = (
                    domain_data.get("Name"),
                    domain_data.get("Region"),
                    version_id
                )
                
                domain_query = """
                    INSERT INTO domain (name, region, version_id)
                    VALUES (?, ?, ?)
                    ON DUPLICATE KEY UPDATE region=VALUES(region), version_id=VALUES(version_id);
                """
                cursor.execute(domain_query, domain_tuple)
                # print(f"Berhasil memproses domain: {domain_data.get('Name')}")

            except mariadb.Error as e:
                print(f"Gagal memproses data untuk domain '{domain_data.get('Name')}': {e}")
            except (ValueError, TypeError) as e:
                print(f"Error pada format data domain '{domain_data.get('Name')}': {e}")

        conn.commit()
        print("semua data domain berhasil diimpor ke dalam tabel domain")

    except FileNotFoundError:
        print(f"Error: File '{json_file_path}' tidak ditemukan.")
    except mariadb.Error as e:
        print(f"Error koneksi atau query database: {e}")
    finally:
        if conn:
            cursor.close()
            conn.close()

# tabel:    artifact
# file:     artifacts.json
def insert_artifacts(json_file_path):
    conn = None
    try:
        conn = mariadb.connect(
            user=DB_USER, password=DB_PASSWORD, host=DB_HOST,
            port=DB_PORT, database=DB_NAME
        )
        cursor = conn.cursor()

        with open(json_file_path, 'r', encoding='utf-8') as f:
            artifact_list = json.load(f)

        for artifact_data in artifact_list:
            try:
                artifact_tuple = (
                    artifact_data.get("Name"),
                    artifact_data.get("2-piece Bonus"),
                    artifact_data.get("4-piece Bonus")
                )
                
                query = """
                    INSERT INTO artifact (name, `2-piece bonus`, `4-piece bonus`)
                    VALUES (?, ?, ?)
                    ON DUPLICATE KEY UPDATE 
                        `2-piece bonus`=VALUES(`2-piece bonus`), 
                        `4-piece bonus`=VALUES(`4-piece bonus`);
                """
                cursor.execute(query, artifact_tuple)
                # print(f"Berhasil memproses artefak: {artifact_data.get('Name')}")

            except mariadb.Error as e:
                print(f"Gagal memproses data untuk '{artifact_data.get('Name')}': {e}")
        
        conn.commit()
        print("semua data artefak berhasil diimpor ke dalam tabel artifacts")

    except FileNotFoundError:
        print(f"Error: File '{json_file_path}' tidak ditemukan.")
    except mariadb.Error as e:
        print(f"Error koneksi atau query database: {e}")
    finally:
        if conn:
            cursor.close()
            conn.close()

# tabel:    domain-artifact
# file:     domain.json
def insert_domain_artifacts(json_file_path):
    conn = None
    try:
        conn = mariadb.connect(
            user=DB_USER, password=DB_PASSWORD, host=DB_HOST,
            port=DB_PORT, database=DB_NAME
        )
        cursor = conn.cursor()

        with open(json_file_path, 'r', encoding='utf-8') as f:
            domain_list = json.load(f)

        for domain_data in domain_list:
            domain_name = domain_data.get("Name")
            artifacts_list = domain_data.get("Artifacts", [])

            if not domain_name or not artifacts_list:
                continue

            for artifact_name in artifacts_list:
                try:
                    data_tuple = (domain_name, artifact_name)

                    # banyak data berulang --> gunakan ignore untuk menghindari error
                    query = "INSERT IGNORE INTO `domain-artifact` (domain, artifact) VALUES (?, ?)"
                    
                    cursor.execute(query, data_tuple)

                except mariadb.Error as e:
                    print(f"DB Error untuk {domain_name} - {artifact_name}: {e}")
            
            # print(f"Berhasil memproses relasi untuk domain: {domain_name}")

        # Simpan semua perubahan
        conn.commit()
        print("semua data domain-artefak berhasil diimpor ke dalam tabel domain-artifacts")

    except FileNotFoundError:
        print(f"Error: File '{json_file_path}' tidak ditemukan.")
    except mariadb.Error as e:
        print(f"Error koneksi atau query database: {e}")
    finally:
        if conn:
            cursor.close()
            conn.close()

# tabel:    artifact-rarity
# file:     artifact.json
def insert_artifacts_rarity(json_file_path):
    conn = None
    try:
        conn = mariadb.connect(
            user=DB_USER, password=DB_PASSWORD, host=DB_HOST,
            port=DB_PORT, database=DB_NAME
        )
        cursor = conn.cursor()

        with open(json_file_path, 'r', encoding='utf-8') as f:
            artifact_list = json.load(f)

        for artifact_data in artifact_list:
            artifact_name = artifact_data.get("Name")
            rarity_list = artifact_data.get("Rarity", [])

            if not artifact_name or not rarity_list:
                continue

            for rarity_value in rarity_list:
                try:
                    data_tuple = (artifact_name, int(rarity_value))

                    # banyak data berulang --> gunakan ignore untuk menghindari error
                    query = "INSERT IGNORE INTO `artifact-rarity` (name, rarity) VALUES (?, ?)"
                    cursor.execute(query, data_tuple)

                except mariadb.Error as e:
                    print(f"DB Error untuk {artifact_name} - Rarity {rarity_value}: {e}")
                except (ValueError, TypeError):
                    print(f"Data Error: Nilai rarity tidak valid '{rarity_value}' untuk {artifact_name}")

            # print(f"Berhasil memproses rarity untuk: {artifact_name}")

        conn.commit()
        print("semua data rarity artefak berhasil diimpor ke dalam tabel artifact-rarity")

    except FileNotFoundError:
        print(f"Error: File '{json_file_path}' tidak ditemukan.")
    except mariadb.Error as e:
        print(f"Error koneksi atau query database: {e}")
    finally:
        if conn:
            cursor.close()
            conn.close()

# tabel:    boss
# file:     bosses.json
def insert_boss(json_file_path):
    conn = None
    try:
        conn = mariadb.connect(
            user=DB_USER, password=DB_PASSWORD, host=DB_HOST,
            port=DB_PORT, database=DB_NAME
        )
        cursor = conn.cursor()

        with open(json_file_path, 'r', encoding='utf-8') as f:
            boss_list = json.load(f)

        for boss_data in boss_list:
            try:
                version_str = boss_data.get("Version")
                major, minor = version_str.split('.')
                
                # tentukan id versi dari tabel version
                cursor.execute(
                    "SELECT id FROM version WHERE major_version = ? AND minor_version = ?",
                    (major, minor)
                )
                version_result = cursor.fetchone()
                
                if not version_result:
                    print(f"Peringatan: Versi {version_str} tidak ditemukan, bos '{boss_data.get('Name')}' dilewati.")
                    continue
                
                version_id = version_result[0]

                boss_tuple = (
                    boss_data.get("Name"),
                    boss_data.get("Boss Drop"),
                    boss_data.get("Region"),
                    version_id
                )
                
                query = """
                    INSERT INTO boss (name, unique_drop, region, version_id)
                    VALUES (?, ?, ?, ?)
                    ON DUPLICATE KEY UPDATE 
                        unique_drop=VALUES(unique_drop), 
                        region=VALUES(region),
                        version_id=VALUES(version_id);
                """
                cursor.execute(query, boss_tuple)
                # print(f"Berhasil memproses bos: {boss_data.get('Name')}")

            except mariadb.Error as e:
                print(f"Gagal memproses data untuk bos '{boss_data.get('Name')}': {e}")
            except (ValueError, TypeError) as e:
                print(f"Error pada format data bos '{boss_data.get('Name')}': {e}")

        conn.commit()
        print("semua data bos berhasil diimpor ke dalam tabel boss")

    except FileNotFoundError:
        print(f"Error: File '{json_file_path}' tidak ditemukan.")
    except mariadb.Error as e:
        print(f"Error koneksi atau query database: {e}")
    finally:
        if conn:
            cursor.close()
            conn.close()

# tabel:    weapon
# file:     weapons.json
def insert_weapon(json_file_path):
    conn = None
    try:
        conn = mariadb.connect(
            user=DB_USER, password=DB_PASSWORD, host=DB_HOST,
            port=DB_PORT, database=DB_NAME
        )
        cursor = conn.cursor()

        with open(json_file_path, 'r', encoding='utf-8') as f:
            weapon_list = json.load(f)

        for weapon_data in weapon_list:
            try:
                # tentukan id versi dari tabel version
                version_str = weapon_data.get("Version")
                major, minor = version_str.split('.')
                
                cursor.execute(
                    "SELECT id FROM version WHERE major_version = ? AND minor_version = ?",
                    (major, minor)
                )
                version_result = cursor.fetchone()
                
                if not version_result:
                    print(f"Peringatan: Versi {version_str} tidak ditemukan, senjata '{weapon_data.get('Name')}' dilewati.")
                    continue
                
                version_id = version_result[0]

                # ambil data secondary stat
                secondary_stat_obj = weapon_data.get("Secondary Stat", {})
                sec_stat_name = secondary_stat_obj.get("Name")
                sec_stat_value = secondary_stat_obj.get("Value")

                # senjata dengan rarity 1-2 tidak memiliki secondary stat, isi dengan null
                if sec_stat_name == "None" or sec_stat_value == "N/A":
                    final_sec_stat_name = None
                    final_sec_stat_value = None
                else:
                    final_sec_stat_name = sec_stat_name
                    final_sec_stat_value = sec_stat_value

                weapon_tuple = (
                    weapon_data.get("Name"),
                    weapon_data.get("Type"),
                    weapon_data.get("Rarity"),
                    weapon_data.get("Base ATK"),
                    final_sec_stat_name,
                    final_sec_stat_value,
                    version_id
                )
                
                query = """
                    INSERT INTO weapon (name, type, rarity, base_ATK, 
                                      secondary_stat, secondary_stat_value, version_id)
                    VALUES (?, ?, ?, ?, ?, ?, ?)
                    ON DUPLICATE KEY UPDATE 
                        type=VALUES(type), 
                        rarity=VALUES(rarity),
                        base_ATK=VALUES(base_ATK),
                        secondary_stat=VALUES(secondary_stat),
                        secondary_stat_value=VALUES(secondary_stat_value),
                        version_id=VALUES(version_id);
                """
                cursor.execute(query, weapon_tuple)
                # print(f"Berhasil memproses senjata: {weapon_data.get('Name')}")

            except mariadb.Error as e:
                print(f"Gagal memproses data untuk senjata '{weapon_data.get('Name')}': {e}")
            except (ValueError, TypeError) as e:
                print(f"Error pada format data senjata '{weapon_data.get('Name')}': {e}")

        # Simpan semua perubahan
        conn.commit()
        print("semua data senjata berhasil diimpor ke dalam tabel weapon")

    except FileNotFoundError:
        print(f"Error: File '{json_file_path}' tidak ditemukan.")
    except mariadb.Error as e:
        print(f"Error koneksi atau query database: {e}")
    finally:
        if conn:
            cursor.close()
            conn.close()

# tabel:    character
# file:     characters.json
def insert_character(json_file_path):
    conn = None
    try:
        conn = mariadb.connect(
            user=DB_USER, password=DB_PASSWORD, host=DB_HOST,
            port=DB_PORT, database=DB_NAME
        )
        cursor = conn.cursor()

        with open(json_file_path, 'r', encoding='utf-8') as f:
            character_list = json.load(f)

        for char_data in character_list:
            try:
                # tentukan id versi dari tabel version
                version_id = None
                version_str = char_data.get("Version")

                if version_str and version_str != "N/A":      
                    major, minor = version_str.split('.')
                    
                    cursor.execute(
                        "SELECT id FROM version WHERE major_version = ? AND minor_version = ?",
                        (major, minor)
                    )
                    version_result = cursor.fetchone()
                    
                    version_id = version_result[0] if version_result else None
                
                # karakter 'Aloy' tidak memiliki data versi, diisi dengan null
                else:
                    pass

                base_stats = char_data.get("Base Stats", {})
                base_hp = base_stats.get("HP", "0")
                base_atk = base_stats.get("ATK", "0")
                base_def = base_stats.get("DEF", "0")

                character_tuple = (
                    char_data.get("Name"),
                    char_data.get("Rarity"),
                    char_data.get("Element"),
                    char_data.get("Weapon Type"),
                    char_data.get("Region") if char_data.get("Region") != 'N/A' else None,
                    char_data.get("Body Type"),
                    char_data.get("Gender"),
                    char_data.get("Birthday Month") if char_data.get("Birthday Month") != 'N/A' else None,
                    char_data.get("Birthday Day") if char_data.get("Birthday Day") != 'N/A' else None,
                    char_data.get("Ascension Stat"),
                    base_hp,
                    base_atk,
                    base_def,
                    char_data.get("Burst Cost") if char_data.get("Burst Cost") != 'N/A' else None,
                    char_data.get("Boss Drop"),
                    version_id if version_id is not None else None
                )
                
                query = """
                    INSERT INTO `character` (name, rarity, element, weapon_type, region, 
                                           body_type, gender, birthday_month, birthday_day, 
                                           ascension_stat, base_HP, base_ATK, base_DEF, 
                                           burst_cost, ascension_material, version_id)
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                    ON DUPLICATE KEY UPDATE 
                        rarity = VALUES(rarity),
                        element = VALUES(element),
                        weapon_type = VALUES(weapon_type),
                        region = VALUES(region),
                        body_type = VALUES(body_type),
                        gender = VALUES(gender),
                        birthday_month = VALUES(birthday_month),
                        birthday_day = VALUES(birthday_day),
                        ascension_stat = VALUES(ascension_stat),
                        base_HP = VALUES(base_HP),
                        base_ATK = VALUES(base_ATK),
                        base_DEF = VALUES(base_DEF),
                        burst_cost = VALUES(burst_cost),
                        ascension_material = VALUES(ascension_material),
                        version_id = VALUES(version_id);
                """
                cursor.execute(query, character_tuple)
                # print(f"Berhasil memproses karakter: {char_data.get('Name')}")

            except mariadb.Error as e:
                print(f"Gagal memproses data untuk karakter '{char_data.get('Name')}': {e}")
            except (ValueError, TypeError, KeyError) as e:
                print(f"Error pada format data karakter '{char_data.get('Name')}': {e}")

        conn.commit()
        print("semua data karakter berhasil diimpor ke dalam tabel character")

    except FileNotFoundError:
        print(f"Error: File '{json_file_path}' tidak ditemukan.")
    except mariadb.Error as e:
        print(f"Error koneksi atau query database: {e}")
    finally:
        if conn:
            cursor.close()
            conn.close()

def insert_data(folder_data):
    insert_version(os.path.join(folder_data, "versions.json"))
    insert_domain(os.path.join(folder_data, "domains.json"))
    insert_artifacts(os.path.join(folder_data, "artifacts.json"))
    insert_domain_artifacts(os.path.join(folder_data, "domains.json"))
    insert_artifacts_rarity(os.path.join(folder_data, "artifacts.json"))
    insert_boss(os.path.join(folder_data, "bosses.json"))
    insert_weapon(os.path.join(folder_data, "weapons.json"))
    insert_character(os.path.join(folder_data, "characters.json"))
    print("\nsemua data berhasil dimasukkan ke database!")

if __name__ == "__main__":

    # catat waktu saat ini sebagai tanda automasi program berjalan
    timestamp = time.strftime("%Y-%m-%d %H:%M:%S")

    # informasi database
    DB_USER = "root"
    DB_PASSWORD = ""
    DB_HOST = "127.0.0.1"
    DB_PORT = 3306
    DB_NAME = "seleksi_basdat"

    # sesuaikan folder penyimpanan data json
    folder_data = os.path.join('..', '..', 'Data Scraping', 'data')

    insert_data(folder_data)

    with open(os.path.join('..', '..', 'Data Scraping', 'data', 'log.txt'), 'a') as log_file:
        log_file.write(f"insert terakhir: {timestamp}")