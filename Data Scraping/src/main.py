"""
Project: Basis Data - Seleksi Asisten 2025
Author: Alvin Christopher Santausa
NIM: 13523033
Email: 13523033@std.stei.itb.ac.id
"""

import requests
from bs4 import BeautifulSoup
import pandas as pd
import json
import csv
from typing import List, Dict, Any
import re
import time
from urllib.parse import urljoin, urlparse


class MotoGPWinnersScraper:
    """Scraper for MotoGP/500cc race winners from Wikipedia"""
    
    def __init__(self):
        self.base_url = "https://en.wikipedia.org"
        self.target_url = "https://en.wikipedia.org/wiki/List_of_500cc/MotoGP_race_winners"
        self.session = requests.Session()
        self.session.headers.update({
            'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'
        })
        
    def get_page_content(self) -> BeautifulSoup:
        """Fetch and parse the Wikipedia page"""
        try:
            print(f"Fetching data from: {self.target_url}")
            response = self.session.get(self.target_url, timeout=30)
            response.raise_for_status()
            
            soup = BeautifulSoup(response.content, 'html.parser')
            print("Page content fetched successfully")
            return soup
            
        except requests.RequestException as e:
            print(f"Error fetching page: {e}")
            raise
    
    def extract_rider_data(self, soup: BeautifulSoup) -> List[Dict[str, Any]]:
        """Extract rider statistics from the main table"""
        riders_data = []
        
        # Find the table with rider statistics
        # Look for the table that contains the rider data under "By rider" section
        tables = soup.find_all('table', class_='wikitable')
        
        rider_table = None
        for table in tables:
            # Check if this table has the expected columns
            header_cells = table.find('tr')
            if header_cells:
                headers = [th.get_text(strip=True) for th in header_cells.find_all(['th', 'td'])]
                if any('Rank' in h for h in headers) and any('Rider' in h for h in headers) and any('Wins' in h for h in headers):
                    rider_table = table
                    break
        
        if not rider_table:
            print("Could not find the main rider statistics table")
            return riders_data
        
        print("Found rider statistics table")
        
        # Extract header information
        header_row = rider_table.find('tr')
        headers = []
        if header_row:
            for th in header_row.find_all(['th', 'td']):
                headers.append(th.get_text(strip=True))
        
        print(f"Table headers: {headers}")
        
        # Process each data row
        rows = rider_table.find_all('tr')[1:]  # Skip header row
        current_rank = ""
        
        for row_idx, row in enumerate(rows):
            cells = row.find_all(['td', 'th'])
            if len(cells) < 6:  # Skip rows that don't have enough data
                continue
                
            try:
                # Check if first cell contains a rank number or country info
                first_cell_text = cells[0].get_text(strip=True) if len(cells) > 0 else ""
                
                # Determine if this is a rank or country cell
                # Rank cells contain only numbers, country cells contain letters/country codes
                is_rank_cell = first_cell_text.isdigit()
                
                if is_rank_cell:
                    # Normal row with rank number
                    current_rank = first_cell_text
                    country_cell = cells[1] if len(cells) > 1 else None
                    rider_cell = cells[2] if len(cells) > 2 else None
                    wins_cell = cells[3].get_text(strip=True) if len(cells) > 3 else ""
                    seasons_cell = cells[4].get_text(strip=True) if len(cells) > 4 else ""
                    first_win_cell = cells[5].get_text(strip=True) if len(cells) > 5 else ""
                    last_win_cell = cells[6].get_text(strip=True) if len(cells) > 6 else ""
                else:
                    # Tied rank row - first cell is country, data shifts left
                    country_cell = cells[0] if len(cells) > 0 else None
                    rider_cell = cells[1] if len(cells) > 1 else None
                    wins_cell = cells[2].get_text(strip=True) if len(cells) > 2 else ""
                    seasons_cell = cells[3].get_text(strip=True) if len(cells) > 3 else ""
                    first_win_cell = cells[4].get_text(strip=True) if len(cells) > 4 else ""
                    last_win_cell = cells[5].get_text(strip=True) if len(cells) > 5 else ""
                
                # Extract country information
                country_code = ""
                country_name = ""
                if country_cell:
                    # Look for country links
                    country_link = country_cell.find('a')
                    if country_link:
                        country_name = country_link.get('title', '')
                        country_code = country_link.get_text(strip=True)
                    else:
                        country_text = country_cell.get_text(strip=True)
                        if country_text:
                            country_code = country_text
                
                # Extract rider information
                rider_name = ""
                rider_link = ""
                is_champion = False
                is_active = False
                
                if rider_cell:
                    # Check for championship indicators
                    rider_text = rider_cell.get_text(strip=True)
                    is_champion = '*' in rider_text or '†' in rider_text
                    is_active = rider_cell.find('b') is not None  # Bold indicates active rider
                    
                    # Get rider name and link
                    rider_link_elem = rider_cell.find('a')
                    if rider_link_elem:
                        rider_name = rider_link_elem.get_text(strip=True)
                        rider_link = urljoin(self.base_url, rider_link_elem.get('href', ''))
                    else:
                        rider_name = rider_text
                    
                    # Clean up rider name (remove symbols)
                    rider_name = re.sub(r'[*†]', '', rider_name).strip()
                
                # Extract wins (may be a link)
                wins = 0
                if wins_cell:
                    # Try to extract number from text or link
                    wins_match = re.search(r'\d+', wins_cell)
                    if wins_match:
                        wins = int(wins_match.group())
                
                # Parse rank (handle tied ranks)
                rank = current_rank if current_rank else str(len(riders_data) + 1)
                
                rider_data = {
                    'rank': rank,
                    'country_code': country_code,
                    'country_name': country_name,
                    'rider_name': rider_name,
                    'rider_link': rider_link,
                    'wins': wins,
                    'seasons_active': seasons_cell,
                    'first_win': first_win_cell,
                    'last_win': last_win_cell,
                    'is_champion': is_champion,
                    'is_active_2025': is_active,
                    'row_index': row_idx + 1
                }
                
                riders_data.append(rider_data)
                print(f"Extracted: Rank {rank} - {rider_name} ({country_code}) - {wins} wins")
                
                # Stop after 100 entries
                if len(riders_data) >= 100:
                    print(f"Reached limit of 100 riders, stopping extraction")
                    break
                
            except Exception as e:
                print(f"Error processing row {row_idx + 1}: {e}")
                continue
        
        print(f"Successfully extracted data for {len(riders_data)} riders")
        return riders_data
    
    def extract_nationality_data(self, soup: BeautifulSoup) -> List[Dict[str, Any]]:
        """Extract nationality statistics"""
        nationality_data = []
        
        # Find the nationality section
        nationality_section = soup.find('span', {'id': 'By_nationality'})
        if not nationality_section:
            print("Could not find nationality section")
            return nationality_data
        
        # Find the table after the nationality section
        table = nationality_section.find_parent().find_next_sibling('table', class_='wikitable')
        
        if not table:
            print("Could not find nationality statistics table")
            return nationality_data
        
        print("Found nationality statistics table")
        
        # Process data rows
        rows = table.find_all('tr')[1:]  # Skip header
        
        for row_idx, row in enumerate(rows):
            cells = row.find_all(['td', 'th'])
            if len(cells) < 3:
                continue
                
            try:
                rank = cells[0].get_text(strip=True)
                country_cell = cells[1]
                wins = cells[2].get_text(strip=True)
                riders_count = cells[3].get_text(strip=True) if len(cells) > 3 else ""
                
                # Extract country info
                country_name = ""
                country_link = country_cell.find('a')
                if country_link:
                    country_name = country_link.get('title', country_link.get_text(strip=True))
                
                wins_num = int(re.search(r'\d+', wins).group()) if re.search(r'\d+', wins) else 0
                riders_num = int(re.search(r'\d+', riders_count).group()) if re.search(r'\d+', riders_count) else 0
                
                nationality_data.append({
                    'rank': rank,
                    'country': country_name,
                    'total_wins': wins_num,
                    'number_of_riders': riders_num
                })
                
            except Exception as e:
                print(f"Error processing nationality row {row_idx + 1}: {e}")
                continue
        
        print(f"Successfully extracted nationality data for {len(nationality_data)} countries")
        return nationality_data
    
    def save_data(self, riders_data: List[Dict], nationality_data: List[Dict], output_dir: str = "../data"):
        """Save extracted data in multiple formats"""
        import os
        
        # Create output directory if it doesn't exist
        os.makedirs(output_dir, exist_ok=True)
        
        # Save riders data
        riders_df = pd.DataFrame(riders_data)
        
        # CSV format
        riders_csv_path = os.path.join(output_dir, "motogp_riders.csv")
        riders_df.to_csv(riders_csv_path, index=False, encoding='utf-8')
        print(f"Riders data saved to: {riders_csv_path}")
        
        # JSON format
        riders_json_path = os.path.join(output_dir, "motogp_riders.json")
        with open(riders_json_path, 'w', encoding='utf-8') as f:
            json.dump(riders_data, f, indent=2, ensure_ascii=False)
        print(f"Riders data saved to: {riders_json_path}")
        
        # Save nationality data
        if nationality_data:
            nationality_df = pd.DataFrame(nationality_data)
            
            nationality_csv_path = os.path.join(output_dir, "motogp_countries.csv")
            nationality_df.to_csv(nationality_csv_path, index=False, encoding='utf-8')
            print(f"Nationality data saved to: {nationality_csv_path}")
            
            nationality_json_path = os.path.join(output_dir, "motogp_countries.json")
            with open(nationality_json_path, 'w', encoding='utf-8') as f:
                json.dump(nationality_data, f, indent=2, ensure_ascii=False)
            print(f"Nationality data saved to: {nationality_json_path}")
        
        return riders_df, nationality_df if nationality_data else None
    
    def run(self):
        """Main execution method"""
        try:
            print("Starting MotoGP Winners Scraper...")
            
            # Fetch page content
            soup = self.get_page_content()
            
            # Extract data
            print("\nExtracting rider data...")
            riders_data = self.extract_rider_data(soup)
            
            print("\nExtracting nationality data...")
            nationality_data = self.extract_nationality_data(soup)
            
            # Save data
            print("\nSaving extracted data...")
            riders_df, nationality_df = self.save_data(riders_data, nationality_data)
            
            print(f"\nScraping completed successfully!")
            print(f"Data saved in '../data/' directory")
            print(f"Extracted {len(riders_data)} riders")
            
            return riders_df, nationality_df
            
        except Exception as e:
            print(f"Error during scraping: {e}")
            raise


def main():
    """Main function to run the scraper"""
    scraper = MotoGPWinnersScraper()
    riders_df, nationality_df = scraper.run()


if __name__ == "__main__":
    main()