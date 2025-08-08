-- ============================================================================
-- BoardGame Data Warehouse - Sample Analytical Queries
-- Created: August 7, 2025
-- Description: Sample business intelligence queries for the data warehouse
-- 
-- These queries demonstrate the analytical capabilities of the dimensional
-- model and provide examples for business intelligence applications.
-- ============================================================================

USE boardgame_dw;

-- ============================================================================
-- GAME PERFORMANCE ANALYTICS
-- ============================================================================

-- Query 1: Top 10 Games by Engagement Score
-- Shows games with highest community engagement
SELECT 
    dg.title,
    dg.year_published,
    dg.complexity_category,
    fgm.engagement_score,
    fgm.geek_rating,
    fgm.rank_position,
    fgm.community_owned,
    fgm.fans
FROM fact_game_metrics fgm
JOIN dim_game dg ON fgm.game_key = dg.game_key AND dg.is_current = TRUE
JOIN dim_time dt ON fgm.time_key = dt.time_key
WHERE dt.date_value = (SELECT MAX(date_value) FROM dim_time WHERE date_value <= CURDATE())
ORDER BY fgm.engagement_score DESC
LIMIT 10;

-- Query 2: Games Performance by Complexity Category
-- Analyzes average ratings and community engagement by game complexity
SELECT 
    dg.complexity_category,
    COUNT(*) as game_count,
    AVG(fgm.geek_rating) as avg_rating,
    AVG(fgm.rank_position) as avg_rank,
    AVG(fgm.engagement_score) as avg_engagement,
    SUM(fgm.community_owned) as total_owned,
    AVG(fgm.users_voted) as avg_voters
FROM fact_game_metrics fgm
JOIN dim_game dg ON fgm.game_key = dg.game_key AND dg.is_current = TRUE
JOIN dim_time dt ON fgm.time_key = dt.time_key
WHERE dt.date_value = (SELECT MAX(date_value) FROM dim_time WHERE date_value <= CURDATE())
GROUP BY dg.complexity_category
ORDER BY avg_rating DESC;

-- Query 3: Player Count Preference Analysis
-- Shows which player count ranges are most popular
SELECT 
    dg.player_range,
    COUNT(*) as game_count,
    AVG(fgm.geek_rating) as avg_rating,
    SUM(fgm.community_owned) as total_owned,
    AVG(fgm.rank_position) as avg_rank,
    MIN(dg.min_players) as min_players,
    MAX(dg.max_players) as max_players
FROM fact_game_metrics fgm
JOIN dim_game dg ON fgm.game_key = dg.game_key AND dg.is_current = TRUE
JOIN dim_time dt ON fgm.time_key = dt.time_key
WHERE dt.date_value = (SELECT MAX(date_value) FROM dim_time WHERE date_value <= CURDATE())
GROUP BY dg.player_range
ORDER BY avg_rating DESC;

-- ============================================================================
-- RANKING TREND ANALYSIS
-- ============================================================================

-- Query 4: Biggest Ranking Movers (Last 30 Days)
-- Shows games with the most significant ranking changes
SELECT 
    dg.title,
    fgr.rank_position as current_rank,
    fgr.previous_rank,
    fgr.rank_change,
    fgr.rank_trend,
    fgr.geek_rating,
    dt.date_value as ranking_date
FROM fact_game_rankings fgr
JOIN dim_game dg ON fgr.game_key = dg.game_key AND dg.is_current = TRUE
JOIN dim_time dt ON fgr.time_key = dt.time_key
WHERE dt.date_value >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
AND fgr.rank_change IS NOT NULL
ORDER BY ABS(fgr.rank_change) DESC
LIMIT 15;

-- Query 5: Ranking Consistency Analysis
-- Identifies games with most stable rankings over time
SELECT 
    dg.title,
    COUNT(*) as measurement_count,
    AVG(fgr.rank_position) as avg_rank,
    STDDEV(fgr.rank_position) as rank_volatility,
    MIN(fgr.rank_position) as best_rank,
    MAX(fgr.rank_position) as worst_rank,
    CASE 
        WHEN STDDEV(fgr.rank_position) < 2 THEN 'Very Stable'
        WHEN STDDEV(fgr.rank_position) < 5 THEN 'Stable'
        WHEN STDDEV(fgr.rank_position) < 10 THEN 'Moderate'
        ELSE 'Volatile'
    END as stability_rating
FROM fact_game_rankings fgr
JOIN dim_game dg ON fgr.game_key = dg.game_key AND dg.is_current = TRUE
JOIN dim_time dt ON fgr.time_key = dt.time_key
WHERE dt.date_value >= DATE_SUB(CURDATE(), INTERVAL 90 DAY)
GROUP BY dg.game_key, dg.title
HAVING measurement_count >= 5
ORDER BY rank_volatility ASC
LIMIT 20;

-- ============================================================================
-- CATEGORY AND MECHANISM ANALYSIS
-- ============================================================================

-- Query 6: Most Popular Game Categories
-- Shows category performance and popularity metrics
SELECT 
    dc.category_name,
    acp.total_games,
    acp.avg_rating,
    acp.avg_complexity,
    acp.total_community_owned,
    acp.avg_rank_position,
    acp.rating_trend,
    ROUND(acp.total_community_owned / acp.total_games, 0) as avg_owned_per_game
FROM agg_category_performance acp
JOIN dim_category dc ON acp.category_key = dc.category_key
WHERE acp.total_games >= 2
ORDER BY acp.avg_rating DESC
LIMIT 15;

-- Query 7: Category vs Complexity Analysis
-- Analyzes the relationship between game categories and complexity
SELECT 
    dc.category_name,
    COUNT(*) as game_count,
    AVG(dg.complexity_rating) as avg_complexity,
    CASE 
        WHEN AVG(dg.complexity_rating) < 2.0 THEN 'Light Category'
        WHEN AVG(dg.complexity_rating) < 3.0 THEN 'Medium Category'
        WHEN AVG(dg.complexity_rating) < 4.0 THEN 'Heavy Category'
        ELSE 'Very Heavy Category'
    END as category_complexity,
    AVG(fgm.geek_rating) as avg_rating,
    AVG(fgm.community_owned) as avg_owned
FROM bridge_game_category bgc
JOIN dim_category dc ON bgc.category_key = dc.category_key
JOIN dim_game dg ON bgc.game_key = dg.game_key AND dg.is_current = TRUE
JOIN fact_game_metrics fgm ON dg.game_key = fgm.game_key
JOIN dim_time dt ON fgm.time_key = dt.time_key
WHERE dt.date_value = (SELECT MAX(date_value) FROM dim_time WHERE date_value <= CURDATE())
GROUP BY dc.category_key, dc.category_name
HAVING game_count >= 2
ORDER BY avg_complexity DESC;

-- ============================================================================
-- PUBLISHER AND DESIGNER ANALYSIS
-- ============================================================================

-- Query 8: Top Performing Publishers
-- Shows publishers with highest average game ratings
SELECT 
    dp.publisher_name,
    COUNT(DISTINCT dg.game_key) as game_count,
    AVG(fgm.geek_rating) as avg_game_rating,
    AVG(fgm.rank_position) as avg_rank,
    SUM(fgm.community_owned) as total_community_owned,
    AVG(fgm.engagement_score) as avg_engagement,
    MAX(fgm.geek_rating) as best_game_rating,
    MIN(fgm.rank_position) as best_rank
FROM bridge_game_publisher bgp
JOIN dim_publisher dp ON bgp.publisher_key = dp.publisher_key AND dp.is_current = TRUE
JOIN dim_game dg ON bgp.game_key = dg.game_key AND dg.is_current = TRUE
JOIN fact_game_metrics fgm ON dg.game_key = fgm.game_key
JOIN dim_time dt ON fgm.time_key = dt.time_key
WHERE dt.date_value = (SELECT MAX(date_value) FROM dim_time WHERE date_value <= CURDATE())
GROUP BY dp.publisher_key, dp.publisher_name
HAVING game_count >= 2
ORDER BY avg_game_rating DESC
LIMIT 10;

-- Query 9: Designer Success Analysis
-- Analyzes designer performance and consistency
SELECT 
    dd.designer_name,
    COUNT(DISTINCT dg.game_key) as game_count,
    AVG(fgm.geek_rating) as avg_game_rating,
    STDDEV(fgm.geek_rating) as rating_consistency,
    AVG(fgm.rank_position) as avg_rank,
    SUM(fgm.community_owned) as total_owned,
    MAX(fgm.geek_rating) as highest_rated_game,
    MIN(fgm.rank_position) as best_rank,
    CASE 
        WHEN STDDEV(fgm.geek_rating) < 0.2 THEN 'Very Consistent'
        WHEN STDDEV(fgm.geek_rating) < 0.5 THEN 'Consistent'
        WHEN STDDEV(fgm.geek_rating) < 0.8 THEN 'Moderate'
        ELSE 'Variable'
    END as consistency_rating
FROM bridge_game_designer bgd
JOIN dim_designer dd ON bgd.designer_key = dd.designer_key AND dd.is_current = TRUE
JOIN dim_game dg ON bgd.game_key = dg.game_key AND dg.is_current = TRUE
JOIN fact_game_metrics fgm ON dg.game_key = fgm.game_key
JOIN dim_time dt ON fgm.time_key = dt.time_key
WHERE dt.date_value = (SELECT MAX(date_value) FROM dim_time WHERE date_value <= CURDATE())
GROUP BY dd.designer_key, dd.designer_name
HAVING game_count >= 2
ORDER BY avg_game_rating DESC
LIMIT 15;

-- ============================================================================
-- TIME-BASED ANALYSIS
-- ============================================================================

-- Query 10: Games by Publication Year Performance
-- Shows how games from different years perform
SELECT 
    dg.year_published,
    COUNT(*) as game_count,
    AVG(fgm.geek_rating) as avg_rating,
    AVG(fgm.rank_position) as avg_rank,
    AVG(fgm.complexity_rating) as avg_complexity,
    SUM(fgm.community_owned) as total_owned,
    MAX(fgm.geek_rating) as best_rating
FROM fact_game_metrics fgm
JOIN dim_game dg ON fgm.game_key = dg.game_key AND dg.is_current = TRUE
JOIN dim_time dt ON fgm.time_key = dt.time_key
WHERE dt.date_value = (SELECT MAX(date_value) FROM dim_time WHERE date_value <= CURDATE())
AND dg.year_published IS NOT NULL
AND dg.year_published >= 2000
GROUP BY dg.year_published
HAVING game_count >= 2
ORDER BY dg.year_published DESC;

-- Query 11: Modern vs Classic Games Analysis
-- Compares performance of older vs newer games
SELECT 
    CASE 
        WHEN dg.year_published < 2000 THEN 'Classic (Pre-2000)'
        WHEN dg.year_published < 2010 THEN '2000s Era'
        WHEN dg.year_published < 2020 THEN '2010s Era'
        ELSE 'Modern (2020+)'
    END as era,
    COUNT(*) as game_count,
    AVG(fgm.geek_rating) as avg_rating,
    AVG(fgm.rank_position) as avg_rank,
    AVG(fgm.complexity_rating) as avg_complexity,
    AVG(fgm.community_owned) as avg_owned,
    AVG(fgm.engagement_score) as avg_engagement
FROM fact_game_metrics fgm
JOIN dim_game dg ON fgm.game_key = dg.game_key AND dg.is_current = TRUE
JOIN dim_time dt ON fgm.time_key = dt.time_key
WHERE dt.date_value = (SELECT MAX(date_value) FROM dim_time WHERE date_value <= CURDATE())
AND dg.year_published IS NOT NULL
GROUP BY era
ORDER BY avg_rating DESC;

-- ============================================================================
-- MARKET ANALYSIS QUERIES
-- ============================================================================

-- Query 12: Community Engagement vs Rating Correlation
-- Analyzes correlation between community engagement and ratings
SELECT 
    CASE 
        WHEN fgm.geek_rating >= 8.0 THEN 'Exceptional (8.0+)'
        WHEN fgm.geek_rating >= 7.5 THEN 'Excellent (7.5-7.9)'
        WHEN fgm.geek_rating >= 7.0 THEN 'Very Good (7.0-7.4)'
        WHEN fgm.geek_rating >= 6.5 THEN 'Good (6.5-6.9)'
        ELSE 'Average (<6.5)'
    END as rating_tier,
    COUNT(*) as game_count,
    AVG(fgm.community_owned) as avg_owned,
    AVG(fgm.fans) as avg_fans,
    AVG(fgm.num_plays) as avg_plays,
    AVG(fgm.users_voted) as avg_voters,
    AVG(fgm.engagement_score) as avg_engagement
FROM fact_game_metrics fgm
JOIN dim_game dg ON fgm.game_key = dg.game_key AND dg.is_current = TRUE
JOIN dim_time dt ON fgm.time_key = dt.time_key
WHERE dt.date_value = (SELECT MAX(date_value) FROM dim_time WHERE date_value <= CURDATE())
AND fgm.geek_rating IS NOT NULL
GROUP BY rating_tier
ORDER BY AVG(fgm.geek_rating) DESC;

-- Query 13: Complexity vs Popularity Analysis
-- Shows relationship between game complexity and popularity
SELECT 
    dg.complexity_category,
    COUNT(*) as game_count,
    AVG(fgm.geek_rating) as avg_rating,
    AVG(fgm.community_owned) as avg_owned,
    AVG(fgm.users_voted) as avg_voters,
    AVG(dg.complexity_rating) as avg_complexity_score,
    ROUND(SUM(fgm.community_owned) / COUNT(*), 0) as owned_per_game
FROM fact_game_metrics fgm
JOIN dim_game dg ON fgm.game_key = dg.game_key AND dg.is_current = TRUE
JOIN dim_time dt ON fgm.time_key = dt.time_key
WHERE dt.date_value = (SELECT MAX(date_value) FROM dim_time WHERE date_value <= CURDATE())
GROUP BY dg.complexity_category, dg.complexity_category
ORDER BY avg_rating DESC;

-- ============================================================================
-- SUMMARY DASHBOARD QUERIES
-- ============================================================================

-- Query 14: Executive Dashboard Summary
-- High-level metrics for executive reporting
SELECT 
    'Total Games' as metric,
    COUNT(*) as value,
    NULL as additional_info
FROM fact_game_metrics fgm
JOIN dim_time dt ON fgm.time_key = dt.time_key
WHERE dt.date_value = (SELECT MAX(date_value) FROM dim_time WHERE date_value <= CURDATE())

UNION ALL

SELECT 
    'Average Rating' as metric,
    ROUND(AVG(fgm.geek_rating), 3) as value,
    'Across all games' as additional_info
FROM fact_game_metrics fgm
JOIN dim_time dt ON fgm.time_key = dt.time_key
WHERE dt.date_value = (SELECT MAX(date_value) FROM dim_time WHERE date_value <= CURDATE())

UNION ALL

SELECT 
    'Total Community Owned' as metric,
    SUM(fgm.community_owned) as value,
    'All games combined' as additional_info
FROM fact_game_metrics fgm
JOIN dim_time dt ON fgm.time_key = dt.time_key
WHERE dt.date_value = (SELECT MAX(date_value) FROM dim_time WHERE date_value <= CURDATE())

UNION ALL

SELECT 
    'Most Popular Complexity' as metric,
    NULL as value,
    dg.complexity_category as additional_info
FROM fact_game_metrics fgm
JOIN dim_game dg ON fgm.game_key = dg.game_key AND dg.is_current = TRUE
JOIN dim_time dt ON fgm.time_key = dt.time_key
WHERE dt.date_value = (SELECT MAX(date_value) FROM dim_time WHERE date_value <= CURDATE())
GROUP BY dg.complexity_category
ORDER BY SUM(fgm.community_owned) DESC
LIMIT 1;

-- Query 15: Data Freshness Check
-- Shows when data was last updated
SELECT 
    'Last ETL Batch' as metric,
    ebl.batch_name as batch_info,
    ebl.start_time as last_update,
    ebl.status,
    ebl.records_processed
FROM etl_batch_log ebl
WHERE ebl.status = 'Success'
ORDER BY ebl.end_time DESC
LIMIT 1;

-- ============================================================================
-- NOTES AND USAGE INSTRUCTIONS
-- ============================================================================

/*
USAGE INSTRUCTIONS:

1. These queries are designed for analytical purposes and business intelligence
2. Most queries filter for the most recent date to show current state
3. Some queries require multiple runs over time to show trends
4. Modify date filters as needed for historical analysis
5. Add indexes on frequently queried columns for better performance

PERFORMANCE TIPS:

1. Use appropriate date ranges to limit result sets
2. Consider creating materialized views for frequently-run queries
3. Update table statistics regularly for optimal query plans
4. Monitor query execution times and optimize as needed

CUSTOMIZATION:

1. Adjust rating thresholds based on your analysis needs
2. Modify grouping categories for different perspectives
3. Add filters for specific publishers, designers, or categories
4. Combine queries for more complex analysis

*/
