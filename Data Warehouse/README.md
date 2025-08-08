# BoardGame Data Warehouse

This directory contains the data warehouse design and implementation for analytical processing of BoardGameGeek data.

## 📁 Directory Structure

```
Data Warehouse/
├── design/          # ERD and dimensional model diagrams (PNG files)
├── src/            # ETL scripts and warehouse schema
├── export/         # Data warehouse export files (SQL)
└── screenshot/     # Screenshots of warehouse operations
```

## 🎯 Data Warehouse Overview

### Purpose
The data warehouse is designed to support analytical queries and business intelligence operations on board game data. It transforms the normalized operational database into a dimensional model optimized for OLAP (Online Analytical Processing) operations.

### Architecture
- **Schema Type**: Star Schema with some Snowflake elements
- **Primary Fact Table**: `fact_game_metrics` - Central table containing game performance metrics
- **Dimension Tables**: Time, Game, Designer, Publisher, Category, etc.
- **Aggregation Tables**: Pre-calculated summaries for common queries

### Key Design Principles
1. **Historical Data**: Maintains historical snapshots of game rankings and metrics
2. **Denormalization**: Optimized for query performance over storage efficiency
3. **Time Dimension**: Supports time-based analysis and trending
4. **Slowly Changing Dimensions**: Handles changes in game attributes over time

## 🏗️ Dimensional Model

### Fact Tables

#### 1. fact_game_metrics (Primary Fact Table)
Central fact table containing quantitative measures about board games:
- **Measures**: geek_rating, avg_rating, users_voted, community_owned, num_plays, fans
- **Dimensions**: game_key, time_key, publisher_key, designer_key, category_key
- **Grain**: One row per game per time period

#### 2. fact_game_rankings (Time-series Fact Table)
Historical tracking of game rankings over time:
- **Measures**: rank_position, ranking_change, percentile_ranking
- **Dimensions**: game_key, time_key
- **Grain**: One row per game per ranking period

#### 3. fact_pricing (Transactional Fact Table)
Game pricing information across different stores:
- **Measures**: price, currency_rate, normalized_price
- **Dimensions**: game_key, store_key, time_key
- **Grain**: One row per price listing

### Dimension Tables

#### 1. dim_game (Game Dimension)
Complete game information with attributes:
- Game details, complexity, player counts, playtime
- Slowly Changing Dimension Type 2 for historical tracking

#### 2. dim_time (Time Dimension)
Comprehensive time dimension supporting various time-based analyses:
- Date, month, quarter, year, day_of_week, is_weekend, etc.

#### 3. dim_designer (Designer Dimension)
Game designer information with aggregated metrics

#### 4. dim_publisher (Publisher Dimension)  
Publisher information with business metrics

#### 5. dim_category (Category Dimension)
Game categories and themes

#### 6. dim_mechanism (Mechanism Dimension)
Game mechanics and mechanisms

#### 7. dim_store (Store Dimension)
Marketplace store information

### Bridge Tables (for Many-to-Many Relationships)
- `bridge_game_designer`: Links games to multiple designers
- `bridge_game_category`: Links games to multiple categories
- `bridge_game_mechanism`: Links games to multiple mechanisms

## 📊 Analytical Capabilities

### Sample Analytics Queries

1. **Top Performing Games by Category**
```sql
SELECT 
    dc.category_name,
    dg.title,
    AVG(fgm.geek_rating) as avg_rating,
    SUM(fgm.community_owned) as total_owned
FROM fact_game_metrics fgm
JOIN dim_game dg ON fgm.game_key = dg.game_key
JOIN bridge_game_category bgc ON dg.game_key = bgc.game_key  
JOIN dim_category dc ON bgc.category_key = dc.category_key
GROUP BY dc.category_name, dg.title
ORDER BY avg_rating DESC;
```

2. **Ranking Trends Over Time**
```sql
SELECT 
    dt.year,
    dt.month,
    dg.title,
    fgr.rank_position,
    LAG(fgr.rank_position) OVER (PARTITION BY dg.game_key ORDER BY dt.date_key) as prev_rank
FROM fact_game_rankings fgr
JOIN dim_game dg ON fgr.game_key = dg.game_key
JOIN dim_time dt ON fgr.time_key = dt.time_key
WHERE dg.title IN ('Brass: Birmingham', 'Gloomhaven', 'Ark Nova')
ORDER BY dt.date_key, fgr.rank_position;
```

3. **Publisher Performance Analysis**
```sql
SELECT 
    dp.publisher_name,
    COUNT(DISTINCT dg.game_key) as game_count,
    AVG(fgm.geek_rating) as avg_game_rating,
    SUM(fgm.community_owned) as total_community_owned
FROM fact_game_metrics fgm
JOIN dim_game dg ON fgm.game_key = dg.game_key
JOIN bridge_game_publisher bgp ON dg.game_key = bgp.game_key
JOIN dim_publisher dp ON bgp.publisher_key = dp.publisher_key
GROUP BY dp.publisher_name
HAVING game_count >= 2
ORDER BY avg_game_rating DESC;
```

## 🔄 ETL Process

### Extract Phase
- Source: Operational `boardgame_db` database
- Incremental extraction based on timestamps
- Change Data Capture (CDC) for modified records

### Transform Phase
- Data cleansing and validation
- Surrogate key generation
- Slowly Changing Dimension processing
- Fact table aggregation and calculation
- Data quality checks

### Load Phase
- Dimension table loading (SCD Type 2)
- Fact table loading with proper key resolution
- Index creation and statistics update
- Data validation and reconciliation

## 📅 Automated Scheduling

### Batch Processing Schedule
- **Daily ETL**: Updates fact tables with latest operational data
- **Weekly Full Refresh**: Complete dimension table refresh
- **Monthly Aggregation**: Pre-calculated summary tables
- **Quarterly Archive**: Historical data archiving

### Implementation
- **Tool**: Python + APScheduler for job scheduling
- **Monitoring**: Comprehensive logging and error handling
- **Recovery**: Automatic retry logic and failure notifications

## 🚀 Performance Optimization

### Indexing Strategy
- Clustered indexes on time dimensions
- Bitmap indexes on categorical dimensions
- Composite indexes on frequently joined columns

### Partitioning
- Time-based partitioning on fact tables
- Hash partitioning on large dimension tables

### Aggregation Tables
- Pre-calculated monthly/quarterly summaries
- Materialized views for common queries

## 📈 Business Intelligence Use Cases

1. **Game Performance Tracking**: Monitor game ratings and community engagement over time
2. **Market Analysis**: Analyze pricing trends across different marketplaces
3. **Publisher Insights**: Evaluate publisher performance and market share
4. **Category Trends**: Identify popular game categories and mechanisms
5. **Predictive Analytics**: Forecast game success based on attributes

## 🔧 Technical Specifications

- **Database**: MySQL 8.0+ (can be migrated to specialized DW systems)
- **ETL Tool**: Python-based custom ETL framework
- **Scheduler**: APScheduler with cron-like functionality
- **Monitoring**: Python logging with file and database outputs
- **Data Quality**: Automated validation rules and alerts

This data warehouse enables comprehensive analysis of board game trends, market dynamics, and community preferences through a well-structured dimensional model optimized for analytical workloads.
