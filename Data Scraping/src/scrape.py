#import necessary libraries
import requests
from bs4 import BeautifulSoup
import pandas as pd
import re
import os

# UTILITY FUNCTIONS
def extract_table_data(table):
    data = []
    
    for row in table.find_all("tr"):
        row_data = []
        for cell in row.find_all(["td", "th"]):
            if cell.name == "th":
                # For header cells, try to get title attribute from links
                a_tag = cell.find("a", title=True)
                if a_tag:
                    row_data.append(a_tag["title"])
                else:
                    row_data.append(cell.get_text(strip=True))
            else:
                row_data.append(cell.get_text(strip=True))
        
        if row_data:
            data.append(row_data)
    
    return pd.DataFrame(data)


def get_page_content(url, headers=None):
    if headers is None:
        headers = {
            "User-Agent": "Mozilla/5.0 (compatible; MyBot/0.1; +http://yourwebsite.com/bot)"
        }
    
    response = requests.get(url, headers=headers)
    response.raise_for_status()
    return BeautifulSoup(response.content, "html.parser")


# TABLE EXTRACTION FUNCTIONS

# extract multiple tables from a Wikipedia page.
def extract_tables_from_url(url, selected_indices=None, theatre_name=None):
    soup = get_page_content(url)
    tables = soup.find_all("table", class_="wikitable")
    
    # Extract specified tables
    if selected_indices is not None:
        extracted = [extract_table_data(tables[i]) for i in selected_indices if i < len(tables)]
    else:
        extracted = [extract_table_data(table) for table in tables]
    
    # Remove header row from all tables except the first
    for i in range(1, len(extracted)):
        extracted[i] = extracted[i].iloc[1:].reset_index(drop=True)
    
    # Add theatre name column if specified
    if theatre_name is not None:
        for df in extracted:
            df["Theatre"] = theatre_name
    
    # Combine all tables
    if extracted:
        return pd.concat(extracted, ignore_index=True)
    else:
        return pd.DataFrame()


def extract_single_table_from_url(url, selected_index=0, selected_columns=None):
    soup = get_page_content(url)
    tables = soup.find_all("table", class_="wikitable")
    
    if selected_index >= len(tables):
        raise IndexError(f"Table index {selected_index} not available on this page.")
    
    df = extract_table_data(tables[selected_index])
    
    # Filter columns if specified
    if selected_columns is not None:
        valid_cols = [i for i in selected_columns if i < len(df.columns)]
        df = df.iloc[:, valid_cols]
    
    return df


# ARCHITECT EXTRACTION FUNCTIONS

def extract_architect(url, theatre_name="Unknown"):
    # Returns list: List of dictionaries containing theatre and architect info
    response = requests.get(url)
    soup = BeautifulSoup(response.text, "html.parser")
    results = []
    
    # Try to extract from infobox first
    infobox = soup.find("table", class_="infobox")
    if infobox:
        for row in infobox.find_all("tr"):
            header = row.find("th")
            if header and "Architect" in header.text:
                architect_cell = row.find("td")
                if architect_cell:
                    # Extract from links if available
                    links = architect_cell.find_all("a")
                    if links:
                        for link in links:
                            name = link.get_text(strip=True)
                            if name:
                                results.append({"Theatre": theatre_name, "Architect": name})
                    else:
                        # Extract from plain text
                        raw_text = architect_cell.get_text(separator=";", strip=True)
                        names = [name.strip() for name in raw_text.split(";") if name.strip()]
                        for name in names:
                            results.append({"Theatre": theatre_name, "Architect": name})
                break 
    # Return "Not Found" if no architect information found
    if not results:
        results.append({"Theatre": theatre_name, "Architect": "Not Found"})
    
    return results


def extract_architects_from_paragraph_url(url, theatre_name="Unknown"):
    
    response = requests.get(url)
    soup = BeautifulSoup(response.text, "html.parser")
    paragraphs = soup.find_all("p")
    results = []
    
    for para in paragraphs:
        text = para.get_text()
        # Regex pattern to capture two architect names
        pattern = r"designed.*?by\s+(.*?)\s+of.*?in conjunction with\s+([A-Z][a-zA-Z. ]+?)\."
        match = re.search(pattern, text, re.IGNORECASE)
        
        if match:
            name1 = match.group(1).strip()
            name2 = match.group(2).strip()
            results.append({"Theatre": theatre_name, "Architect": name1})
            results.append({"Theatre": theatre_name, "Architect": name2})
            break
    
    if not results:
        results.append({"Theatre": theatre_name, "Architect": "Not Found"})
    
    return results


# DATA PROCESSING FUNCTIONS

def process_active_theatres():
    """Extract and process active Broadway theatres data."""
    print("Extracting active theatres data...")
    
    df_active = extract_single_table_from_url(
        "https://en.wikipedia.org/wiki/List_of_Broadway_theatres",
        selected_index=0,
        selected_columns=[0, 1, 2, 3, 4]
    )
    
    # Remove header rows and set column names
    df_active = df_active.iloc[2:].reset_index(drop=True)
    df_active.columns = ["Theatre_name", "Address", "Opening_year", "Capacity", "Owner"]
    
    return df_active


def process_former_theatres():
    """Extract and process former Broadway theatres data."""
    print("Extracting former theatres data...")
    
    df_former = extract_single_table_from_url(
        "https://en.wikipedia.org/wiki/List_of_Broadway_theatres",
        selected_index=1,
        selected_columns=[0, 1, 2, 3, 4, 5]
    )
    
    # Set column names and process data
    df_former.columns = [
        "Theatre_name", "Address", "Opening_year", 
        "Last_Broadway_Production", "Current_use", "Owner"
    ]
    
    df_former = df_former.iloc[1:].reset_index(drop=True)
    
    # Extract year from Last_Broadway_Production column
    df_former["Last_opened"] = df_former["Last_Broadway_Production"].str.extract(r"(\d{4})")
    df_former["Last_Broadway_Production"] = df_former["Last_Broadway_Production"].str.replace(
        r"^\(?\d{4}\)?", "", regex=True
    ).str.strip()
    df_former = df_former.drop(columns=["Last_Broadway_Production"])
    
    return df_former


def create_master_theatres_list(df_active, df_former):
    """Create a master list combining active and former theatres."""
    print("Creating master theatres list...")
    
    # Select relevant columns from active theatres
    df_active_subset = df_active.iloc[:, [0, 1, 2, 4]].copy()
    df_active_subset.columns = ["Theatre_name", "Address", "Opening_year", "Owner"]
    
    # Select relevant columns from former theatres
    df_former_subset = df_former.iloc[:, [0, 1, 2, 4]].copy()
    df_former_subset.reset_index(drop=True, inplace=True)
    
    # Combine both datasets
    df_master = pd.concat([df_active_subset, df_former_subset], ignore_index=True)
    
    return df_master


def process_architects_data():
    """Extract and process architect information for all theatres."""
    print("Extracting architects data...")
    
    # Map URLs to correct theatre names (consistent with production_configs)
    theatre_url_mapping = [
        ("https://en.wikipedia.org/wiki/Al_Hirschfeld_Theatre", "Al Hirschfeld Theatre"),
        ("https://en.wikipedia.org/wiki/Ambassador_Theatre_(Broadway)", "Ambassador Theatre (Broadway)"),
        ("https://en.wikipedia.org/wiki/August_Wilson_Theatre", "August Wilson Theatre"),
        ("https://en.wikipedia.org/wiki/Belasco_Theatre", "Belasco Theatre (Broadway)"),  # FIXED
        ("https://en.wikipedia.org/wiki/Bernard_B._Jacobs_Theatre", "Bernard B. Jacobs Theatre"),
        ("https://en.wikipedia.org/wiki/Booth_Theatre", "Booth Theatre"),
        ("https://en.wikipedia.org/wiki/Broadhurst_Theatre", "Broadhurst Theatre"),
        ("https://en.wikipedia.org/wiki/Broadway_Theatre_(53rd_Street)", "Broadway Theatre (53rd Street)"),
        ("https://en.wikipedia.org/wiki/Circle_in_the_Square_Theatre", "Circle in the Square Theatre"),
        ("https://en.wikipedia.org/wiki/Ethel_Barrymore_Theatre", "Ethel Barrymore Theatre"),
        ("https://en.wikipedia.org/wiki/Eugene_O%27Neill_Theatre", "Eugene O'Neill Theatre"),  # FIXED URL encoding
        ("https://en.wikipedia.org/wiki/Gerald_Schoenfeld_Theatre", "Gerald Schoenfeld Theatre"),
        ("https://en.wikipedia.org/wiki/Gershwin_Theatre", "Gershwin Theatre"),
        ("https://en.wikipedia.org/wiki/Hayes_Theater", "Hayes Theater"),
        ("https://en.wikipedia.org/wiki/Hudson_Theatre", "Hudson Theatre"),
        ("https://en.wikipedia.org/wiki/Imperial_Theatre", "Imperial Theatre"),
        ("https://en.wikipedia.org/wiki/James_Earl_Jones_Theatre", "James Earl Jones Theatre"),
        ("https://en.wikipedia.org/wiki/John_Golden_Theatre", "John Golden Theatre"),
        ("https://en.wikipedia.org/wiki/Lena_Horne_Theatre", "Lena Horne Theatre"),
        ("https://en.wikipedia.org/wiki/Longacre_Theatre", "Longacre Theatre"),
        ("https://en.wikipedia.org/wiki/Lunt-Fontanne_Theatre", "Lunt-Fontanne Theatre"),
        ("https://en.wikipedia.org/wiki/Lyceum_Theatre_(Broadway)", "Lyceum Theatre (Broadway)"),
        ("https://en.wikipedia.org/wiki/Lyric_Theatre_(New_York_City,_1998)", "Lyric Theatre (New York City, 1998)"),
        ("https://en.wikipedia.org/wiki/Majestic_Theatre_(Broadway)", "Majestic Theatre (Broadway)"),
        ("https://en.wikipedia.org/wiki/Marquis_Theatre", "Marquis Theatre"),
        ("https://en.wikipedia.org/wiki/Minskoff_Theatre", "Minskoff Theatre"),
        ("https://en.wikipedia.org/wiki/Music_Box_Theatre", "Music Box Theatre"),
        ("https://en.wikipedia.org/wiki/Nederlander_Theatre", "Nederlander Theatre"),
        ("https://en.wikipedia.org/wiki/Neil_Simon_Theatre", "Neil Simon Theatre"),
        ("https://en.wikipedia.org/wiki/New_Amsterdam_Theatre", "New Amsterdam Theatre"),
        ("https://en.wikipedia.org/wiki/Palace_Theatre_(New_York_City)", "Palace Theatre (New York City)"),
        ("https://en.wikipedia.org/wiki/Richard_Rodgers_Theatre", "Richard Rodgers Theatre"),
        ("https://en.wikipedia.org/wiki/St._James_Theatre", "St. James Theatre"),
        ("https://en.wikipedia.org/wiki/Samuel_J._Friedman_Theatre", "Samuel J. Friedman Theatre"),
        ("https://en.wikipedia.org/wiki/Shubert_Theatre_(Broadway)", "Shubert Theatre (Broadway)"),
        ("https://en.wikipedia.org/wiki/Stephen_Sondheim_Theatre", "Stephen Sondheim Theatre"),
        ("https://en.wikipedia.org/wiki/Studio_54", "Studio 54"),
        ("https://en.wikipedia.org/wiki/Todd_Haimes_Theatre", "Todd Haimes Theatre"),
        ("https://en.wikipedia.org/wiki/Vivian_Beaumont_Theater", "Vivian Beaumont Theater"),
        ("https://en.wikipedia.org/wiki/Walter_Kerr_Theatre", "Walter Kerr Theatre"),
        ("https://en.wikipedia.org/wiki/Winter_Garden_Theatre", "Winter Garden Theatre")
    ]
    
    # Extract architect information
    all_architects = []
    for url, theatre_name in theatre_url_mapping:
        # Get architect information using the correct theatre name
        result = extract_architect(url, theatre_name)
        all_architects.extend(result)
    
    # Create DataFrame and process
    df_architects = pd.DataFrame(all_architects)
    
    # Clean up data
    df_architects = df_architects[df_architects["Architect"].str.match(r"^[^\[]", na=False)]
    df_architects["Architect"] = df_architects["Architect"].str.split(",")
    df_architects = df_architects.explode("Architect")
    df_architects["Architect"] = df_architects["Architect"].str.strip()
    
    # Remove entries where architect is "Not Found" for Stephen Sondheim Theatre
    df_architects = df_architects[
        ~((df_architects["Theatre"] == "Stephen Sondheim Theatre") & 
          (df_architects["Architect"] == "Not Found"))
    ].reset_index(drop=True)
    
    # Special handling for Stephen Sondheim Theatre
    special_architects = extract_architects_from_paragraph_url(
        "https://en.wikipedia.org/wiki/Stephen_Sondheim_Theatre",
        theatre_name="Stephen Sondheim Theatre"
    )
    df_architects = pd.concat([df_architects, pd.DataFrame(special_architects)], ignore_index=True)
    
    return df_architects


def create_architect_lookup_tables(df_architects):
    """Create lookup tables for architects."""
    print("Creating architect lookup tables...")
    
    # Create unique architects list with IDs
    df_list_architects = df_architects[["Architect"]].drop_duplicates().reset_index(drop=True)
    df_list_architects["ID"] = range(1, len(df_list_architects) + 1)
    
    # Map architect names to IDs in the main architects table
    architect_id_map = dict(zip(df_list_architects["Architect"], df_list_architects["ID"]))
    df_architects_mapped = df_architects.copy()
    df_architects_mapped["ID"] = df_architects_mapped["Architect"].map(architect_id_map)
    df_architects_mapped = df_architects_mapped.drop(columns=["Architect"]).reset_index(drop=True)
    
    return df_architects_mapped, df_list_architects


def extract_productions_data():
    """Extract production data from all theatre pages."""
    print("Extracting productions data...")
    
    # Define extraction parameters for each theatre
    production_configs = [
        ("https://en.wikipedia.org/wiki/Al_Hirschfeld_Theatre", [1], "Al Hirschfeld Theatre"),
        ("https://en.wikipedia.org/wiki/Ambassador_Theatre_(Broadway)", [0], "Ambassador Theatre (Broadway)"),
        ("https://en.wikipedia.org/wiki/August_Wilson_Theatre", [2], "August Wilson Theatre"),
        ("https://en.wikipedia.org/wiki/Belasco_Theatre", [0], "Belasco Theatre (Broadway)"),
        ("https://en.wikipedia.org/wiki/Bernard_B._Jacobs_Theatre", [1], "Bernard B. Jacobs Theatre"),
        ("https://en.wikipedia.org/wiki/Booth_Theatre", [0], "Booth Theatre"),
        ("https://en.wikipedia.org/wiki/Broadhurst_Theatre", [0], "Broadhurst Theatre"),
        ("https://en.wikipedia.org/wiki/Broadway_Theatre_(53rd_Street)", [0, 1], "Broadway Theatre (53rd Street)"),
        ("https://en.wikipedia.org/wiki/Circle_in_the_Square_Theatre", [1], "Circle in the Square Theatre"),
        ("https://en.wikipedia.org/wiki/Ethel_Barrymore_Theatre", [0, 1], "Ethel Barrymore Theatre"),
        ("https://en.wikipedia.org/wiki/Eugene_O%27Neill_Theatre", [2], "Eugene O'Neill Theatre"),
        ("https://en.wikipedia.org/wiki/Gerald_Schoenfeld_Theatre", [1], "Gerald Schoenfeld Theatre"),
        ("https://en.wikipedia.org/wiki/Gershwin_Theatre", [1], "Gershwin Theatre"),
        ("https://en.wikipedia.org/wiki/Hayes_Theater", [2], "Hayes Theater"),
        ("https://en.wikipedia.org/wiki/Hudson_Theatre", [0], "Hudson Theatre"),
        ("https://en.wikipedia.org/wiki/Imperial_Theatre", [0], "Imperial Theatre"),
        ("https://en.wikipedia.org/wiki/James_Earl_Jones_Theatre", [0, 1], "James Earl Jones Theatre"),
        ("https://en.wikipedia.org/wiki/John_Golden_Theatre", [0], "John Golden Theatre"),
        ("https://en.wikipedia.org/wiki/Lena_Horne_Theatre", [0], "Lena Horne Theatre"),
        ("https://en.wikipedia.org/wiki/Longacre_Theatre", [0], "Longacre Theatre"),
        ("https://en.wikipedia.org/wiki/Lunt-Fontanne_Theatre", [1], "Lunt-Fontanne Theatre"),
        ("https://en.wikipedia.org/wiki/Lyceum_Theatre_(Broadway)", [0, 1], "Lyceum Theatre (Broadway)"),
        ("https://en.wikipedia.org/wiki/Lyric_Theatre_(New_York_City,_1998)", [0], "Lyric Theatre (New York City, 1998)"),
        ("https://en.wikipedia.org/wiki/Majestic_Theatre_(Broadway)", [0], "Majestic Theatre (Broadway)"),
        ("https://en.wikipedia.org/wiki/Marquis_Theatre", [0], "Marquis Theatre"),
        ("https://en.wikipedia.org/wiki/Minskoff_Theatre", [0], "Minskoff Theatre"),
        ("https://en.wikipedia.org/wiki/Music_Box_Theatre", [0], "Music Box Theatre"),
        ("https://en.wikipedia.org/wiki/Nederlander_Theatre", [2], "Nederlander Theatre"),
        ("https://en.wikipedia.org/wiki/Neil_Simon_Theatre", [1], "Neil Simon Theatre"),
        ("https://en.wikipedia.org/wiki/New_Amsterdam_Theatre", [0], "New Amsterdam Theatre"),
        ("https://en.wikipedia.org/wiki/Palace_Theatre_(New_York_City)", [1], "Palace Theatre (New York City)"),
        ("https://en.wikipedia.org/wiki/Richard_Rodgers_Theatre", [1], "Richard Rodgers Theatre"),
        ("https://en.wikipedia.org/wiki/St._James_Theatre", [0, 1], "St. James Theatre"),
        ("https://en.wikipedia.org/wiki/Samuel_J._Friedman_Theatre", [0, 1], "Samuel J. Friedman Theatre"),
        ("https://en.wikipedia.org/wiki/Shubert_Theatre_(Broadway)", [0], "Shubert Theatre (Broadway)"),
        ("https://en.wikipedia.org/wiki/Stephen_Sondheim_Theatre", [1], "Stephen Sondheim Theatre"),
        ("https://en.wikipedia.org/wiki/Studio_54", [1], "Studio 54"),
        ("https://en.wikipedia.org/wiki/Todd_Haimes_Theatre", [1], "Todd Haimes Theatre"),
        ("https://en.wikipedia.org/wiki/Vivian_Beaumont_Theater", [0], "Vivian Beaumont Theater"),
        ("https://en.wikipedia.org/wiki/Walter_Kerr_Theatre", [1], "Walter Kerr Theatre"),
        ("https://en.wikipedia.org/wiki/Winter_Garden_Theatre", [0], "Winter Garden Theatre")
    ]
    
    # Extract data from all theatres
    all_productions = []
    for url, indices, theatre_name in production_configs:
        try:
            df_theatre = extract_tables_from_url(url, indices, theatre_name)
            all_productions.append(df_theatre)
        except Exception as e:
            print(f"Error extracting data from {theatre_name}: {e}")
            continue
    
    # Combine all production data
    df_productions = pd.concat(all_productions, ignore_index=True)
    
    # DEBUG: Print struktur data untuk analisis
    print("=== DEBUG DATA STRUCTURE ===")
    print("Shape:", df_productions.shape)
    print("First 5 rows:")
    print(df_productions.head())
    print("Columns available:", df_productions.columns.tolist())
    if len(df_productions.columns) > 0:
        print("Sample dari kolom 0:", df_productions.iloc[:3, 0].tolist())
    if len(df_productions.columns) > 1:
        print("Sample dari kolom 1:", df_productions.iloc[:3, 1].tolist())
    if len(df_productions.columns) > 2:
        print("Sample dari kolom 2:", df_productions.iloc[:3, 2].tolist())
    if len(df_productions.columns) > 3:
        print("Sample dari kolom 3:", df_productions.iloc[:3, 3].tolist())
    print("=== END DEBUG ===")
    
    # PERBAIKAN: Remove header row DULU sebelum column selection
    df_productions = df_productions.iloc[1:].reset_index(drop=True)  # Remove header row
    
    # Adjust column selection berdasarkan struktur data
    # Dari debug, tentukan kolom mana yang benar untuk Opening_year, Title, Theatre_name
    if len(df_productions.columns) >= 4:
        # Coba berbagai kombinasi berdasarkan struktur yang umum di Wikipedia
        # Biasanya: Year | Title | Additional Info | Theatre
        df_productions = df_productions.iloc[:, [0, 1, 3]]  # Year, Title, Theatre
    else:
        # Fallback jika kolom kurang
        df_productions = df_productions.iloc[:, :3]
    
    df_productions.columns = ["Opening_year", "Title", "Theatre_name"]
    
    # Clean opening year data
    df_productions["Opening_year"] = df_productions["Opening_year"].apply(
        lambda x: re.split("[,–-]", str(x))[0].strip() if pd.notnull(x) else x
    )
    
    # Clean text encoding
    df_productions["Title"] = df_productions["Title"].str.replace("é", "e")
    df_productions["Theatre_name"] = df_productions["Theatre_name"].str.replace("é", "e")
    
    # Filter out rows where Title or Opening_year contains header-like text
    df_productions = df_productions[
        ~df_productions["Title"].str.contains("Title|Show|Production|Name", case=False, na=False)
    ]
    df_productions = df_productions[
        ~df_productions["Opening_year"].str.contains("Year|Opening|Date", case=False, na=False)
    ]
    
    return df_productions


def create_shows_list(df_productions):
    """Create a unique list of shows."""
    print("Creating shows list...")
    
    df_shows = df_productions[["Title"]].drop_duplicates().reset_index(drop=True)
    df_shows.columns = ["Show"]
    
    return df_shows


def create_organizations_list(df_master_theatres):
    """Create a unique list of theatre organizations/owners."""
    print("Creating organizations list...")
    
    df_organizations = df_master_theatres[["Owner"]].drop_duplicates().reset_index(drop=True)
    
    return df_organizations


def create_normalized_tables(df_active, df_former):
    """Create normalized versions of active and former theatres tables."""
    print("Creating normalized tables...")
    
    # Normalized active theatres (only name and capacity)
    df_active_normalized = df_active[["Theatre_name", "Capacity"]].copy()
    
    # Normalized former theatres (only name, current use, and last opened)
    df_former_normalized = df_former[["Theatre_name", "Current_use", "Last_opened"]].copy()
    
    return df_active_normalized, df_former_normalized


# MAIN 
print("Starting Broadway Theatres Data Extraction...")
print("=" * 60)
try:
    # Create data directory if it doesn't exist
    data_dir = "Seleksi-2025-Tugas-1/Data Scraping/data"
    os.makedirs(data_dir, exist_ok=True)
        
    # Extract basic theatre data
    df_active_theatres = process_active_theatres()
    df_former_theatres = process_former_theatres()
        
    # Create master theatres list
    df_master_theatres = create_master_theatres_list(df_active_theatres, df_former_theatres)
        
    # Create normalized tables
    df_active_normalized, df_former_normalized = create_normalized_tables(df_active_theatres, df_former_theatres)
        
    # Extract architect data
    df_architects_raw = process_architects_data()
    df_architects, df_list_architects = create_architect_lookup_tables(df_architects_raw)
        
    # Extract production data
    df_productions = extract_productions_data()
    df_shows = create_shows_list(df_productions)
        
    # Create organizations list
    df_organizations = create_organizations_list(df_master_theatres)
        
    # Export all data to JSON files
    print("\nExporting data to JSON files...")
        
    export_configs = [
        (df_master_theatres, f"{data_dir}/theatres.json"),
        (df_active_normalized, f"{data_dir}/active_theatres.json"),
        (df_former_normalized, f"{data_dir}/former_existing_theatres.json"),
        (df_productions, f"{data_dir}/productions.json"),
        (df_architects, f"{data_dir}/architects.json"),
        (df_list_architects, f"{data_dir}/list_architects.json"),
        (df_organizations, f"{data_dir}/organizations.json"),
        (df_shows, f"{data_dir}/shows.json")  
    ]
        
    for df, filename in export_configs:
        df.to_json(filename, force_ascii=False, orient="records", indent=4)
        print(f"Exported: {filename}")
        
        print("\n" + "=" * 60)
        print("Data extraction completed successfully!")
        print(f"Total theatres processed: {len(df_master_theatres)}")
        print(f"Total productions extracted: {len(df_productions)}")
        print(f"Total unique shows: {len(df_shows)}")
        print(f"Total architects: {len(df_list_architects)}")
        print(f"Total organizations: {len(df_organizations)}")
        
except Exception as e:
    print(f"An error occurred during execution: {e}")
    raise
