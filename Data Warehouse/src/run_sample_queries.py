#!/usr/bin/env python3
"""
BoardGame Data Warehouse - Sample Query Runner
Created: August 7, 2025

This script runs sample analytical queries against the data warehouse
and displays the results for demonstration purposes.
"""

import mysql.connector
from mysql.connector import Error
from datetime import datetime
import os

class WarehouseQueryRunner:
    """Class to run and display sample warehouse queries."""
    
    def __init__(self):
        """Initialize database connection."""
        self.connection = None
        self.cursor = None
        
    def connect(self):
        """Connect to the data warehouse."""
        try:
            self.connection = mysql.connector.connect(
                host='localhost',
                user='root',
                password='',
                database='boardgame_dw',
                autocommit=True
            )
            self.cursor = self.connection.cursor(dictionary=True)
            print("✅ Connected to BoardGame Data Warehouse")
            
        except Error as e:
            print(f"❌ Error connecting to warehouse: {e}")
            return False
        return True
    
    def run_query(self, query, title):
        """Run a query and display results."""
        print(f"\n{'='*80}")
        print(f"📊 {title}")
        print(f"{'='*80}")
        
        try:
            self.cursor.execute(query)
            results = self.cursor.fetchall()
            
            if not results:
                print("No data found.")
                return
                
            # Display results in a simple table format
            if results:
                # Print column headers
                headers = list(results[0].keys())
                col_widths = [max(len(str(header)), max(len(str(row.get(header, ''))) for row in results)) for header in headers]
                
                # Print header row
                header_row = " | ".join(header.ljust(width) for header, width in zip(headers, col_widths))
                print(header_row)
                print("-" * len(header_row))
                
                # Print data rows
                for row in results:
                    data_row = " | ".join(str(row.get(header, '')).ljust(width) for header, width in zip(headers, col_widths))
                    print(data_row)
            
            return results
            
        except Error as e:
            print(f"❌ Error running query: {e}")
            return None
    
    def run_all_sample_queries(self):
        """Run all sample analytical queries."""
        print("🚀 Running BoardGame Data Warehouse Sample Queries")
        print(f"Execution Time: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
        
        # Query 1: Top 10 Ranked Games
        query1 = """
        SELECT 
            dg.title as 'Game Title',
            dg.year_published as 'Year',
            fgr.rank_position as 'Rank',
            ROUND(fgr.geek_rating, 2) as 'Rating',
            fgr.rank_trend as 'Trend'
        FROM fact_game_rankings fgr 
        JOIN dim_game dg ON fgr.game_key = dg.game_key 
        JOIN dim_time dt ON fgr.time_key = dt.time_key 
        WHERE dt.date_value = (SELECT MAX(date_value) FROM dim_time)
        ORDER BY fgr.rank_position 
        LIMIT 10
        """
        self.run_query(query1, "Top 10 Ranked Board Games")
        
        # Query 2: Category Performance Analysis
        query2 = """
        SELECT 
            dc.category_name as 'Category',
            COUNT(DISTINCT dg.game_key) as 'Games',
            ROUND(AVG(fgr.geek_rating), 2) as 'Avg Rating'
        FROM fact_game_rankings fgr 
        JOIN dim_game dg ON fgr.game_key = dg.game_key 
        JOIN bridge_game_category bgc ON dg.game_key = bgc.game_key 
        JOIN dim_category dc ON bgc.category_key = dc.category_key 
        GROUP BY dc.category_name 
        HAVING COUNT(DISTINCT dg.game_key) >= 3
        ORDER BY AVG(fgr.geek_rating) DESC 
        LIMIT 10
        """
        self.run_query(query2, "Top Game Categories by Average Rating")
        
        # Query 3: Designer Performance
        query3 = """
        SELECT 
            dd.designer_name as 'Designer',
            COUNT(DISTINCT dg.game_key) as 'Games',
            ROUND(AVG(fgr.geek_rating), 2) as 'Avg Rating',
            MIN(fgr.rank_position) as 'Best Rank'
        FROM fact_game_rankings fgr 
        JOIN dim_game dg ON fgr.game_key = dg.game_key 
        JOIN bridge_game_designer bgd ON dg.game_key = bgd.game_key 
        JOIN dim_designer dd ON bgd.designer_key = dd.designer_key 
        GROUP BY dd.designer_name 
        HAVING COUNT(DISTINCT dg.game_key) >= 2
        ORDER BY AVG(fgr.geek_rating) DESC 
        LIMIT 10
        """
        self.run_query(query3, "Top Game Designers by Average Rating")
        
        # Query 4: Games by Complexity and Year
        query4 = """
        SELECT 
            dg.complexity_category as 'Complexity',
            CASE 
                WHEN dg.year_published >= 2020 THEN '2020-2025'
                WHEN dg.year_published >= 2015 THEN '2015-2019'
                WHEN dg.year_published >= 2010 THEN '2010-2014'
                ELSE 'Before 2010'
            END as 'Era',
            COUNT(*) as 'Games',
            ROUND(AVG(fgr.geek_rating), 2) as 'Avg Rating'
        FROM fact_game_rankings fgr 
        JOIN dim_game dg ON fgr.game_key = dg.game_key 
        WHERE dg.year_published IS NOT NULL
        GROUP BY dg.complexity_category, 
                 CASE 
                     WHEN dg.year_published >= 2020 THEN '2020-2025'
                     WHEN dg.year_published >= 2015 THEN '2015-2019'
                     WHEN dg.year_published >= 2010 THEN '2010-2014'
                     ELSE 'Before 2010'
                 END
        ORDER BY dg.complexity_category, 
                 CASE 
                     WHEN dg.year_published >= 2020 THEN '2020-2025'
                     WHEN dg.year_published >= 2015 THEN '2015-2019'
                     WHEN dg.year_published >= 2010 THEN '2010-2014'
                     ELSE 'Before 2010'
                 END
        """
        self.run_query(query4, "Games by Complexity and Era")
        
        # Query 5: Data Warehouse Statistics
        query5 = """
        SELECT 
            'Games' as 'Table',
            COUNT(*) as 'Records'
        FROM dim_game
        UNION ALL
        SELECT 'Designers', COUNT(*) FROM dim_designer
        UNION ALL
        SELECT 'Categories', COUNT(*) FROM dim_category
        UNION ALL
        SELECT 'Mechanisms', COUNT(*) FROM dim_mechanism
        UNION ALL
        SELECT 'Game Rankings', COUNT(*) FROM fact_game_rankings
        UNION ALL
        SELECT 'Game Metrics', COUNT(*) FROM fact_game_metrics
        """
        self.run_query(query5, "Data Warehouse Statistics")
        
        # Query 6: ETL Batch History
        query6 = """
        SELECT 
            batch_id as 'Batch ID',
            batch_name as 'Batch Name',
            DATE_FORMAT(start_time, '%Y-%m-%d %H:%i:%s') as 'Start Time',
            DATE_FORMAT(end_time, '%Y-%m-%d %H:%i:%s') as 'End Time',
            status as 'Status',
            TIMESTAMPDIFF(SECOND, start_time, end_time) as 'Duration (sec)'
        FROM etl_batch_log 
        ORDER BY batch_id DESC 
        LIMIT 10
        """
        self.run_query(query6, "ETL Batch Execution History")
        
    def close(self):
        """Close database connection."""
        if self.cursor:
            self.cursor.close()
        if self.connection:
            self.connection.close()
        print("\n🔌 Database connection closed")

def main():
    """Main function to run sample queries."""
    runner = WarehouseQueryRunner()
    
    if runner.connect():
        runner.run_all_sample_queries()
        runner.close()
    else:
        print("Failed to connect to warehouse")

if __name__ == "__main__":
    main()
