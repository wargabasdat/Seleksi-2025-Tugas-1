from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from bs4 import BeautifulSoup
import json
import os

def scrape_books(url):
    options = Options()
    options.add_argument("--headless=new")
    options.add_argument("--user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.3")

    service = Service()
    driver = webdriver.Chrome(service=service, options=options)

    # Data collections
    # Raw data collected during the scrape
    raw_books = []
    
    # Sets to store unique entities
    authors_set = set()
    countries_set = set()
    languages_set = set()
    types_set = set()
    lengths_set = set()
    genres_set = set()
    subjects_set = set()

    try:
        print("Opening main book list page...")
        driver.get(url)
        WebDriverWait(driver, 20).until(
            EC.presence_of_all_elements_located((By.CSS_SELECTOR, "tr.book-list-item"))
        )

        soup = BeautifulSoup(driver.page_source, "html.parser")
        rows = soup.select("tr.book-list-item")
        base_url = "https://thegreatestbooks.org"
        book_id_counter = 1

        for row in rows:
            cells = row.find_all("td")
            if len(cells) < 6:
                continue

            # Scrape main list
            rank = int(cells[0].text.strip())
            title = cells[1].text.strip()
            author = cells[2].text.strip()
            year = int(cells[3].text.strip())
            country = cells[4].text.strip()
            language_cell = cells[5].text.strip()

            # Split languages by comma and clean them up
            book_languages = []
            if language_cell:
                languages_list = [lang.strip() for lang in language_cell.split(',')]
                for lang in languages_list:
                    if lang:
                        book_languages.append(lang)
                        languages_set.add(lang)
            
            # Add unique items to sets
            authors_set.add(author)
            countries_set.add(country)

            book_data = {
                "id": book_id_counter,
                "rank": rank,
                "title": title,
                "author": author, # Temporary, will be replaced by ID
                "year": year,
                "country": country, # Temporary
                "languages": book_languages, # Temporary Array of Languages
            }

            # Scrape detail page
            title_cell = cells[1].find("a")
            href = title_cell['href'] if title_cell else None
            if href:
                book_url = base_url + href
                # print(f"Scraping detail page for '{title}'...")
                driver.get(book_url)
                WebDriverWait(driver, 10).until(EC.presence_of_element_located((By.CSS_SELECTOR, ".sidebar-content")))
                detail_soup = BeautifulSoup(driver.page_source, "html.parser")
                
                # Scrape details like type, length, pages, rating
                details_list = detail_soup.select("dl.row > dt")
                for dt in details_list:
                    label = dt.text.strip()
                    dd = dt.find_next_sibling("dd")
                    value = dd.get_text(strip=True) if dd else None
                    if label == "Type": 
                        book_data["type"] = value
                        types_set.add(value)
                    elif label == "Length": 
                        book_data["length"] = value
                        lengths_set.add(value)
                    elif label == "Pages": book_data["pages"] = value
                    elif label == "Avg User Rating":
                        rating_span = dd.select_one("span.text-muted")
                        if rating_span:
                            book_data["avg_rating"] = float(rating_span.text.strip().strip("()"))

                # Scrape genres
                book_genres = []
                genre_section = detail_soup.find("h4", string="Genres")
                if genre_section:
                    genre_links = genre_section.find_next("div").find_all("a")
                    for link in genre_links:
                        genre_name = link.text.strip()
                        book_genres.append(genre_name)
                        genres_set.add(genre_name)
                book_data["genres"] = book_genres # Temporary

                # Scrape subjects
                book_subjects = []
                subject_section = detail_soup.find("h4", string="Subjects")
                if subject_section:
                    subject_links = subject_section.find_next("div").find_all("a")
                    for link in subject_links:
                        subject_name = link.text.strip()
                        book_subjects.append(subject_name)
                        subjects_set.add(subject_name)
                book_data["subjects"] = book_subjects # Temporary
            
            raw_books.append(book_data)
            book_id_counter += 1

    finally:
        driver.quit()

    # Process the collected data into normalized structures
    print("Normalizing collected data...")

    # Create master lists with IDs
    author_map = {name: i + 1 for i, name in enumerate(sorted(list(authors_set)))}
    authors = [{"author_id": id, "author_name": name} for name, id in author_map.items()]

    country_map = {name: i + 1 for i, name in enumerate(sorted(list(countries_set)))}
    countries = [{"country_id": id, "country_name": name} for name, id in country_map.items()]

    language_map = {name: i + 1 for i, name in enumerate(sorted(list(languages_set)))}
    languages = [{"language_id": id, "language_name": name} for name, id in language_map.items()]

    type_map = {name: i + 1 for i, name in enumerate(sorted(list(types_set)))}
    types = [{"type_id": id, "type_name": name} for name, id in type_map.items()]

    length_map = {name: i + 1 for i, name in enumerate(sorted(list(lengths_set)))}
    lengths = [{"length_id": id, "length_name": name} for name, id in length_map.items()]

    genre_map = {name: i + 1 for i, name in enumerate(sorted(list(genres_set)))}
    genres = [{"genre_id": id, "genre_name": name} for name, id in genre_map.items()]

    subject_map = {name: i + 1 for i, name in enumerate(sorted(list(subjects_set)))}
    subjects = [{"subject_id": id, "subject_name": name} for name, id in subject_map.items()]

    # Create final books list and linking lists
    final_books = []
    book_languages_relations = []
    book_genres_relations = []
    book_subjects_relations = []

    for book in raw_books:
        # Create linking table entries
        for language_name in book.get("languages", []):
            book_languages_relations.append({"book_id": book["id"], "language_id": language_map[language_name]})

        for genre_name in book.get("genres", []):
            book_genres_relations.append({"book_id": book["id"], "genre_id": genre_map[genre_name]})
        
        for subject_name in book.get("subjects", []):
            book_subjects_relations.append({"book_id": book["id"], "subject_id": subject_map[subject_name]})
            
        # Create final book entry with foreign keys
        final_books.append({
            "id": book["id"],
            "rank": book["rank"],
            "title": book["title"],
            "year": book["year"],
            "pages": book.get("pages"),
            "avg_rating": book.get("avg_rating"),
            "type_id": type_map[book["type"]],
            "length_id": length_map[book["length"]],
            "author_id": author_map[book["author"]],
            "country_id": country_map[book["country"]],
        })

    return {
        "books": final_books,
        "authors": authors,
        "countries": countries,
        "languages": languages,
        "types": types,
        "lengths": lengths,
        "genres": genres,
        "subjects": subjects,
        "book_languages": book_languages_relations,
        "book_genres": book_genres_relations,
        "book_subjects": book_subjects_relations
    }


def save_normalized_data(data, base_path):
    if not os.path.exists(base_path):
        os.makedirs(base_path)

    for key, content in data.items():
        filename = os.path.join(base_path, f"{key}.json")
        with open(filename, "w", encoding="utf-8") as f:
            json.dump(content, f, ensure_ascii=False, indent=4)
        print(f"Saved {len(content)} items to '{filename}'")

def main():
    url = "https://thegreatestbooks.org/v/table"
    all_data = scrape_books(url)

    if all_data:
        save_normalized_data(all_data, "../data")
    else:
        print("No data was scraped.")

if __name__ == "__main__":
    main()