#!/usr/bin/env python3
"""
MotoGP ETL Automated Scheduler
Runs the complete ETL process on a scheduled basis
Prevents data redundancy and tracks batch timestamps
"""

import schedule
import time
import subprocess
import logging
import os
import sys
from datetime import datetime, timedelta
import mysql.connector
import json

# Setup logging
log_dir = "../logs"
os.makedirs(log_dir, exist_ok=True)

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler(f'{log_dir}/scheduler.log'),
        logging.StreamHandler(sys.stdout)
    ]
)
logger = logging.getLogger(__name__)

class ETLScheduler:
    def __init__(self):
        self.last_run_file = "../logs/last_run.json"
        self.batch_log_file = "../logs/batch_history.json"
        self.is_running = False
        
    def check_database_connection(self):
        """Check if both databases are accessible"""
        try:
            # Test source database
            source_conn = mysql.connector.connect(
                host='localhost',
                database='motogp',
                user='root',
                password='alvin123'
            )
            source_conn.close()
            
            # Test target database  
            target_conn = mysql.connector.connect(
                host='localhost',
                database='motogp_wh',
                user='root',
                password='alvin123'
            )
            target_conn.close()
            
            logger.info("Database connections verified")
            return True
            
        except mysql.connector.Error as error:
            logger.error(f"Database connection failed: {error}")
            return False
    
    def get_last_run_info(self):
        """Get information about the last ETL run"""
        try:
            if os.path.exists(self.last_run_file):
                with open(self.last_run_file, 'r') as f:
                    return json.load(f)
            return None
        except Exception as e:
            logger.warning(f"Could not read last run info: {e}")
            return None
    
    def save_run_info(self, status, start_time, end_time, records_processed=0):
        """Save information about the current run"""
        run_info = {
            'status': status,
            'start_time': start_time.isoformat(),
            'end_time': end_time.isoformat(),
            'duration_seconds': (end_time - start_time).total_seconds(),
            'records_processed': records_processed,
            'batch_date': start_time.date().isoformat()
        }
        
        try:
            # Save last run info
            with open(self.last_run_file, 'w') as f:
                json.dump(run_info, f, indent=2)
            
            # Append to batch history
            batch_history = []
            if os.path.exists(self.batch_log_file):
                with open(self.batch_log_file, 'r') as f:
                    batch_history = json.load(f)
            
            batch_history.append(run_info)
            
            # Keep only last 30 runs
            batch_history = batch_history[-30:]
            
            with open(self.batch_log_file, 'w') as f:
                json.dump(batch_history, f, indent=2)
                
            logger.info(f"Run info saved: {status}")
            
        except Exception as e:
            logger.error(f"Failed to save run info: {e}")
    
    def cleanup_old_data(self):
        """Remove old batch data to prevent redundancy"""
        try:
            connection = mysql.connector.connect(
                host='localhost',
                database='motogp_wh',
                user='root',
                password='alvin123'
            )
            cursor = connection.cursor()
            
            # Keep only last 7 days of data
            cutoff_date = datetime.now().date() - timedelta(days=7)
            
            cursor.execute(
                "DELETE FROM fact_kemenangan_pembalap WHERE batch_date < %s",
                (cutoff_date,)
            )
            
            deleted_rows = cursor.rowcount
            connection.commit()
            connection.close()
            
            if deleted_rows > 0:
                logger.info(f"Cleaned up {deleted_rows} old records (older than {cutoff_date})")
            
        except mysql.connector.Error as error:
            logger.error(f"Cleanup failed: {error}")
    
    def get_record_count(self):
        """Get current record count from warehouse"""
        try:
            connection = mysql.connector.connect(
                host='localhost',
                database='motogp_wh',
                user='root',
                password='alvin123'
            )
            cursor = connection.cursor()
            
            cursor.execute("SELECT COUNT(*) FROM fact_kemenangan_pembalap WHERE batch_date = CURDATE()")
            count = cursor.fetchone()[0]
            
            connection.close()
            return count
            
        except mysql.connector.Error as error:
            logger.error(f"Could not get record count: {error}")
            return 0
    
    def run_etl_process(self):
        """Run the complete ETL process"""
        if self.is_running:
            logger.warning("ETL process already running, skipping this execution")
            return
        
        self.is_running = True
        start_time = datetime.now()
        
        logger.info("Starting scheduled ETL process")
        logger.info(f"Batch timestamp: {start_time}")
        
        try:
            # Check database connectivity
            if not self.check_database_connection():
                raise Exception("Database connection failed")
            
            # Cleanup old data
            self.cleanup_old_data()
            
            # Run the ETL process
            logger.info("Executing ETL processing script...")
            
            # Change to the correct directory and run processing.py
            original_dir = os.getcwd()
            script_dir = os.path.dirname(os.path.abspath(__file__))
            os.chdir(script_dir)
            
            # Run with sudo if needed
            result = subprocess.run(
                ['python3', 'processing.py'],
                capture_output=True,
                text=True,
                timeout=1800  # 30 minute timeout
            )
            
            os.chdir(original_dir)
            
            if result.returncode == 0:
                end_time = datetime.now()
                records_processed = self.get_record_count()
                
                logger.info("ETL process completed successfully")
                logger.info(f"Records processed: {records_processed}")
                logger.info(f"Duration: {(end_time - start_time).total_seconds():.2f} seconds")
                
                self.save_run_info("SUCCESS", start_time, end_time, records_processed)
                
            else:
                end_time = datetime.now()
                logger.error(f"ETL process failed with return code: {result.returncode}")
                logger.error(f"Error output: {result.stderr}")
                
                self.save_run_info("FAILED", start_time, end_time, 0)
                
        except subprocess.TimeoutExpired:
            end_time = datetime.now()
            logger.error("ETL process timed out after 30 minutes")
            self.save_run_info("TIMEOUT", start_time, end_time, 0)
            
        except Exception as e:
            end_time = datetime.now()
            logger.error(f"ETL process failed: {str(e)}")
            self.save_run_info("ERROR", start_time, end_time, 0)
            
        finally:
            self.is_running = False
    
    def show_batch_history(self):
        """Display batch execution history"""
        try:
            if not os.path.exists(self.batch_log_file):
                logger.info("No batch history found")
                return
            
            with open(self.batch_log_file, 'r') as f:
                history = json.load(f)
            
            if not history:
                logger.info("No batch history found")
                return
            
            logger.info("\nBATCH EXECUTION HISTORY")
            logger.info("=" * 80)
            logger.info(f"{'Batch Date':<12} {'Start Time':<20} {'Status':<10} {'Duration':<12} {'Records':<8}")
            logger.info("-" * 80)
            
            for run in history[-10:]:  # Show last 10 runs
                start_time = datetime.fromisoformat(run['start_time'])
                duration = f"{run['duration_seconds']:.1f}s"
                
                logger.info(f"{run['batch_date']:<12} {start_time.strftime('%Y-%m-%d %H:%M:%S'):<20} "
                          f"{run['status']:<10} {duration:<12} {run['records_processed']:<8}")
                
        except Exception as e:
            logger.error(f"Failed to show batch history: {e}")
    
    def start_scheduler(self):
        """Start the automated scheduler"""
        logger.info("MotoGP ETL Scheduler Starting...")
        logger.info("Schedule: Every day at 02:00 AM")
        logger.info("Schedule: Every 6 hours during business hours")
        
        # Schedule daily ETL at 2 AM
        schedule.every().day.at("02:00").do(self.run_etl_process)
        
        # Schedule every 6 hours during business hours (6 AM, 12 PM, 6 PM)
        schedule.every().day.at("06:00").do(self.run_etl_process)
        schedule.every().day.at("12:00").do(self.run_etl_process) 
        schedule.every().day.at("18:00").do(self.run_etl_process)
        
        # Show batch history on startup
        self.show_batch_history()
        
        # Run once immediately for testing
        logger.info("Running initial ETL process...")
        self.run_etl_process()
        
        logger.info("Scheduler is running. Press Ctrl+C to stop.")
        
        try:
            while True:
                schedule.run_pending()
                time.sleep(60)  # Check every minute
                
        except KeyboardInterrupt:
            logger.info("Scheduler stopped by user")
        except Exception as e:
            logger.error(f"Scheduler error: {e}")

def main():
    """Main function to start the scheduler"""
    scheduler = ETLScheduler()
    
    # Check if this is just a status check
    if len(sys.argv) > 1:
        if sys.argv[1] == "status":
            scheduler.show_batch_history()
            return
        elif sys.argv[1] == "run-once":
            scheduler.run_etl_process()
            return
    
    # Start the scheduler
    scheduler.start_scheduler()

if __name__ == "__main__":
    main()
