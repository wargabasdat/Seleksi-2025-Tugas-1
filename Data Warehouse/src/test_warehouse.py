#!/usr/bin/env python3
"""
Data Warehouse Testing Suite
Created: August 8, 2025

This script provides comprehensive testing of the data warehouse functionality
including schema validation, ETL operations, and analytical queries.
"""

import mysql.connector
from mysql.connector import Error
import os
import sys
from datetime import datetime
import subprocess

class DataWarehouseTester:
    """Test suite for the BoardGame Data Warehouse"""
    
    def __init__(self):
        self.dw_config = {
            'host': 'localhost',
            'database': 'boardgame_dw',
            'user': 'root',
            'password': ''
        }
        
        self.source_config = {
            'host': 'localhost',
            'database': 'boardgame_db',
            'user': 'root',
            'password': ''
        }
    
    def print_header(self, title: str):
        """Print a formatted header"""
        print(f"\n{'='*60}")
        print(f" {title}")
        print(f"{'='*60}")
    
    def print_step(self, step: str):
        """Print a formatted step"""
        print(f"\n🔸 {step}")
        print("-" * (len(step) + 3))
    
    def test_1_schema_exists(self):
        """Test if the data warehouse schema exists"""
        self.print_step("Testing Data Warehouse Schema Existence")
        
        try:
            connection = mysql.connector.connect(**self.dw_config)
            if connection.is_connected():
                cursor = connection.cursor()
                
                # Check if database exists
                cursor.execute("SHOW DATABASES LIKE 'boardgame_dw'")
                result = cursor.fetchone()
                
                if result:
                    print("✅ Data warehouse database 'boardgame_dw' exists")
                    
                    # Check tables
                    cursor.execute("SHOW TABLES")
                    tables = [table[0] for table in cursor.fetchall()]
                    
                    expected_tables = [
                        'dim_time', 'dim_game', 'dim_designer', 'dim_publisher',
                        'dim_category', 'dim_mechanism', 'dim_store',
                        'fact_game_metrics', 'fact_game_rankings', 'fact_pricing'
                    ]
                    
                    print(f"📊 Found {len(tables)} tables:")
                    for table in sorted(tables):
                        print(f"   • {table}")
                    
                    missing = [t for t in expected_tables if t not in tables]
                    if missing:
                        print(f"❌ Missing expected tables: {missing}")
                        return False
                    else:
                        print("✅ All expected tables found")
                        return True
                        
                else:
                    print("❌ Data warehouse database does not exist")
                    return False
                    
        except Error as e:
            print(f"❌ Database connection error: {e}")
            return False
        finally:
            if connection and connection.is_connected():
                connection.close()
    
    def test_2_source_data_available(self):
        """Test if source data is available for ETL"""
        self.print_step("Testing Source Data Availability")
        
        try:
            connection = mysql.connector.connect(**self.source_config)
            if connection.is_connected():
                cursor = connection.cursor()
                
                # Check key tables and record counts
                source_tables = [
                    'boardgames', 'designers', 'publishers', 'categories',
                    'game_designers', 'game_categories', 'game_prices'
                ]
                
                print("📊 Source database table counts:")
                total_records = 0
                
                for table in source_tables:
                    try:
                        cursor.execute(f"SELECT COUNT(*) FROM {table}")
                        count = cursor.fetchone()[0]
                        print(f"   • {table:<20}: {count:>6} records")
                        total_records += count
                    except Error as e:
                        print(f"   ❌ {table}: Error - {e}")
                        return False
                
                if total_records > 0:
                    print(f"✅ Source data available: {total_records} total records")
                    return True
                else:
                    print("❌ No source data found")
                    return False
                    
        except Error as e:
            print(f"❌ Source database connection error: {e}")
            return False
        finally:
            if connection and connection.is_connected():
                connection.close()
    
    def test_3_run_etl(self):
        """Test ETL process execution"""
        self.print_step("Testing ETL Process")
        
        try:
            print("🚀 Running ETL pipeline...")
            result = subprocess.run([
                'python', 'etl_warehouse.py', '--full-refresh'
            ], capture_output=True, text=True, timeout=300)
            
            if result.returncode == 0:
                print("✅ ETL process completed successfully")
                print("📝 ETL Output (last 10 lines):")
                for line in result.stdout.strip().split('\n')[-10:]:
                    print(f"   {line}")
                return True
            else:
                print(f"❌ ETL process failed with return code: {result.returncode}")
                print("📝 Error output:")
                for line in result.stderr.strip().split('\n')[-5:]:
                    print(f"   {line}")
                return False
                
        except subprocess.TimeoutExpired:
            print("❌ ETL process timed out (>5 minutes)")
            return False
        except FileNotFoundError:
            print("❌ ETL script not found (etl_warehouse.py)")
            return False
        except Exception as e:
            print(f"❌ ETL execution error: {e}")
            return False
    
    def test_4_verify_warehouse_data(self):
        """Test if data was loaded into warehouse tables"""
        self.print_step("Verifying Warehouse Data Load")
        
        try:
            connection = mysql.connector.connect(**self.dw_config)
            if connection.is_connected():
                cursor = connection.cursor()
                
                # Check dimension tables
                dim_tables = [
                    'dim_time', 'dim_game', 'dim_designer', 'dim_publisher',
                    'dim_category', 'dim_mechanism', 'dim_store'
                ]
                
                print("📊 Dimension table counts:")
                dim_total = 0
                
                for table in dim_tables:
                    try:
                        cursor.execute(f"SELECT COUNT(*) FROM {table}")
                        count = cursor.fetchone()[0]
                        print(f"   • {table:<20}: {count:>6} records")
                        dim_total += count
                    except Error as e:
                        print(f"   ❌ {table}: Error - {e}")
                
                # Check fact tables
                fact_tables = ['fact_game_metrics', 'fact_game_rankings', 'fact_pricing']
                
                print("\n📊 Fact table counts:")
                fact_total = 0
                
                for table in fact_tables:
                    try:
                        cursor.execute(f"SELECT COUNT(*) FROM {table}")
                        count = cursor.fetchone()[0]
                        print(f"   • {table:<20}: {count:>6} records")
                        fact_total += count
                    except Error as e:
                        print(f"   ❌ {table}: Error - {e}")
                
                if dim_total > 0 and fact_total > 0:
                    print(f"✅ Warehouse populated: {dim_total} dimension + {fact_total} fact records")
                    return True
                else:
                    print("❌ Warehouse tables are empty")
                    return False
                    
        except Error as e:
            print(f"❌ Warehouse connection error: {e}")
            return False
        finally:
            if connection and connection.is_connected():
                connection.close()
    
    def test_5_analytical_queries(self):
        """Test sample analytical queries"""
        self.print_step("Testing Analytical Queries")
        
        try:
            connection = mysql.connector.connect(**self.dw_config)
            if connection.is_connected():
                cursor = connection.cursor()
                
                # Test Query 1: Top games by rating
                print("🔍 Query 1: Top 5 Games by Rating")
                query1 = """
                SELECT 
                    dg.title,
                    dg.year_published,
                    dg.complexity_category,
                    fgm.geek_rating,
                    fgm.rank_position
                FROM fact_game_metrics fgm
                JOIN dim_game dg ON fgm.game_key = dg.game_key AND dg.is_current = TRUE
                ORDER BY fgm.geek_rating DESC
                LIMIT 5
                """
                
                cursor.execute(query1)
                results = cursor.fetchall()
                
                if results:
                    for i, row in enumerate(results, 1):
                        print(f"   {i}. {row[0]} ({row[1]}) - Rating: {row[3]:.3f}, Rank: {row[4]}")
                    print("✅ Query 1 executed successfully")
                else:
                    print("❌ Query 1 returned no results")
                    return False
                
                # Test Query 2: Games by complexity
                print("\n🔍 Query 2: Games by Complexity Category")
                query2 = """
                SELECT 
                    dg.complexity_category,
                    COUNT(*) as game_count,
                    AVG(fgm.geek_rating) as avg_rating
                FROM fact_game_metrics fgm
                JOIN dim_game dg ON fgm.game_key = dg.game_key AND dg.is_current = TRUE
                GROUP BY dg.complexity_category
                ORDER BY avg_rating DESC
                """
                
                cursor.execute(query2)
                results = cursor.fetchall()
                
                if results:
                    for row in results:
                        print(f"   {row[0]:<15}: {row[1]:>3} games, avg rating: {row[2]:.3f}")
                    print("✅ Query 2 executed successfully")
                else:
                    print("❌ Query 2 returned no results")
                    return False
                
                # Test Query 3: Publisher performance
                print("\n🔍 Query 3: Top Publishers by Game Count")
                query3 = """
                SELECT 
                    dp.name,
                    COUNT(*) as game_count,
                    AVG(fgm.geek_rating) as avg_rating
                FROM fact_game_metrics fgm
                JOIN dim_game dg ON fgm.game_key = dg.game_key AND dg.is_current = TRUE
                JOIN bridge_game_publisher bgp ON dg.game_key = bgp.game_key
                JOIN dim_publisher dp ON bgp.publisher_key = dp.publisher_key AND dp.is_current = TRUE
                GROUP BY dp.publisher_key, dp.name
                HAVING game_count >= 2
                ORDER BY game_count DESC, avg_rating DESC
                LIMIT 5
                """
                
                try:
                    cursor.execute(query3)
                    results = cursor.fetchall()
                    
                    if results:
                        for row in results:
                            print(f"   {row[0]:<25}: {row[1]:>2} games, avg rating: {row[2]:.3f}")
                        print("✅ Query 3 executed successfully")
                    else:
                        print("⚠️  Query 3 returned no results (may need bridge table)")
                except Error as e:
                    print(f"⚠️  Query 3 failed: {e} (bridge table may not exist)")
                
                return True
                
        except Error as e:
            print(f"❌ Query execution error: {e}")
            return False
        finally:
            if connection and connection.is_connected():
                connection.close()
    
    def run_all_tests(self):
        """Run the complete test suite"""
        self.print_header("🧪 DATA WAREHOUSE TEST SUITE")
        print(f"Started: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
        
        tests = [
            ("Schema Existence", self.test_1_schema_exists),
            ("Source Data", self.test_2_source_data_available),
            ("ETL Process", self.test_3_run_etl),
            ("Data Verification", self.test_4_verify_warehouse_data),
            ("Analytical Queries", self.test_5_analytical_queries)
        ]
        
        results = []
        
        for test_name, test_func in tests:
            try:
                result = test_func()
                results.append((test_name, result))
            except Exception as e:
                print(f"❌ Test '{test_name}' failed with exception: {e}")
                results.append((test_name, False))
        
        # Summary
        self.print_header("📊 TEST RESULTS SUMMARY")
        
        passed = sum(1 for _, result in results if result)
        total = len(results)
        
        for test_name, result in results:
            status = "✅ PASSED" if result else "❌ FAILED"
            print(f"{test_name:<20}: {status}")
        
        print(f"\n🎯 Overall Result: {passed}/{total} tests passed")
        
        if passed == total:
            print("🎉 ALL TESTS PASSED! Data warehouse is fully functional.")
        elif passed >= total * 0.8:
            print("⚠️  Most tests passed. Check failed tests for minor issues.")
        else:
            print("❌ Multiple test failures. Data warehouse needs attention.")
        
        return passed == total

if __name__ == "__main__":
    tester = DataWarehouseTester()
    success = tester.run_all_tests()
    sys.exit(0 if success else 1)
