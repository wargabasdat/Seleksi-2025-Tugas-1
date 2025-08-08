# Top 100 Boardgames Database

**Author:** Henrycus Hugatama Risaldy - 18223008


## Deskripsi Singkat

Topik yang saya angkat adalah 100 board game terpopuler dan detail board game berdasarkan data dari situs BoardGameGeek, salah satu direktori terbesar dan paling terpercaya untuk permainan papan di seluruh dunia. Data yang saya scraping mencakup judul, tahun rilis, rating komunitas, jumlah pemain, kategori, mekanik permainan, publisher, dan perancang game.
Data ini menurut saya menarik karena memiliki struktur kompleks dan relasional alami (satu game bisa punya banyak designer, publisher, kategori, dsb), sehingga cocok untuk diubah ke dalam relational database bermanfaat untuk analisis seperti: tren genre populer, hubungan antara tahun rilis dan rating, atau komparasi antar publisher.

Untuk pengelolaan data, saya menggunakan MySQL sebagai DBMS karena kompatibel dengan sistem lokal saya (macOS), memiliki dokumentasi kuat dan community support luas, mendukung semua fitur RDBMS yang saya butuhkan (foreign key, constraint, join, indexing).

### Database Management System
- **RDBMS**: MySQL 8.0+
- **Design**: Fully normalized relational database
- **Tables**: 18 tables (10 entities + 8 relationships)
- **Records**: 1,400+ records with complete referential integrity

## Cara Menggunakan Scraper

### Prerequisites
```bash
pip install beautifulsoup4 requests
```

### Menjalankan Scraper
```bash
cd "Data Scraping/src"
python scrape.py
```

### Output
Scraper akan menghasilkan 12 file JSON di folder `Data Scraping/data/`:
- Data entities (10 files)
- Relationship data (2 files)

## Struktur File JSON

### Entity Files
1. **boardgames.json** - Game utama dengan attribut lengkap
2. **designers.json** - Designer games 
3. **artists.json** - Artist games
4. **publishers.json** - Publisher games
5. **categories.json** - Kategori games
6. **mechanisms.json** - Mekanisme gameplay
7. **families.json** - Family/series games
8. **awards.json** - Award dan penghargaan
9. **reimplemented_games.json** - Game reimplementations
10. **stores.json** - Store availability
11. **geekmarket_prices.json** - Pricing data

### Relationship Files
- **relationships.json** - Junction table data untuk semua relasi many-to-many

### Format JSON Structure
```json
{
  "entity_name": [
    {
      "id": "unique_identifier",
      "attribute1": "value1",
      "attribute2": "value2"
    }
  ]
}
```

## Struktur ERD dan Diagram Relasional

### Entity Relationship Diagram
- **10 Entities**: boardgames, designers, artists, publishers, categories, mechanisms, families, awards, reimplemented_games, stores
- **8 Relationships**: Many-to-many relationships between entities
- **Primary Keys**: Auto-incrementing integers untuk semua entities
- **Foreign Keys**: Complete referential integrity



## Proses Translasi ERD ke Diagram Relasional

### 1. Entity Mapping
- Setiap entity dalam ERD menjadi table
- Attributes menjadi columns dengan data types yang sesuai
- Primary keys didefinisikan untuk setiap table

### 2. Relationship Handling
- **Many-to-Many**: Junction tables dengan composite primary keys
- **Foreign Keys**: Referential integrity dengan cascade options
- **Constraints**: Check constraints untuk data validation

### 3. Optimization
- **Indexing**: Indexes pada foreign keys dan commonly queried fields
- **Data Types**: Optimized types (TINYINT, SMALLINT, DECIMAL)
- **Normalization**: 3NF compliance untuk minimize redundancy

## Screenshots Program

### Data Scraping
Screenshots tersedia di: `Data Scraping/screenshot/`
- Scraping process execution
- Data validation steps
- JSON file generation

### Data Storing  
Screenshots tersedia di: `Data Storing/screenshot/`
- Database schema creation
- Data loading process
- Query execution results

## Bonus Implementation: Data Warehouse

Full data warehouse implementation dengan:
- Star schema design
- ETL pipeline
- Analytical queries
- Comprehensive testing

Detail implementasi: `Data Warehouse/README.md`

## Referensi

### Libraries Used
- **BeautifulSoup4**: HTML parsing dan web scraping
- **Requests**: HTTP requests untuk web scraping  
- **MySQL Connector**: Database connectivity
- **JSON**: Data serialization
- **Re**: Regular expressions untuk data cleaning

### Data Sources
- **Primary**: [BoardGameGeek Top 100](https://boardgamegeek.com/browse/boardgame)
- **Secondary**: Individual game pages untuk detailed information
- **Market Data**: GeekMarket pricing information

### Tools & Technologies
- **Python 3.9+**: Primary development language
- **MySQL 8.0+**: Relational database system
- **Git**: Version control
- **VS Code**: Development environment




