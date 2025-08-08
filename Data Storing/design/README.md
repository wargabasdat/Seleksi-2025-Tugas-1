## Key Constraints

### Primary Keys
- All tables have auto-increment integer primary keys

### Foreign Keys
- All junction tables reference appropriate parent tables
- CASCADE DELETE for data consistency

### Unique Constraints
- BOARDGAMES: rank_position, bgg_url
- All entity tables: name
- Junction tables: combination of foreign keys (composite primary keys)

### Check Constraints
- Ratings: 0 ≤ geek_rating ≤ 10, 0 ≤ avg_rating ≤ 10
- Complexity: 0 ≤ complexity_rating ≤ 5
- Players: min_players ≤ max_players
- Playtime: min_playtime ≤ max_playtime
- Year: 1800 ≤ year_published ≤ 2030
- Price: price > 0

### Indexes
- Primary keys (automatic)
- Foreign keys (automatic)
- Performance indexes: rank_position, year_published, geek_rating, complexity_rating, players
- Full-text index on title for search functionality
- Composite indexes on junction tables for relationship queries

### Views
- v_game_details: Comprehensive game information with all related entities
- v_game_pricing: Game pricing summary with min/max/avg prices and available stores