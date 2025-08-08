#!/usr/bin/env python3
"""
BoardGame Data Warehouse Automated Scheduler
Created: August 7, 2025

This script provides automated scheduling for the data warehouse ETL pipeline
with configurable intervals and comprehensive monitoring.

Features:
- Cron-like scheduling using APScheduler
- Multiple ETL job types (daily, weekly, monthly)
- Email notifications for job failures
- Comprehensive logging and monitoring
- Graceful shutdown handling

Requirements:
- APScheduler library
- Data warehouse ETL pipeline
- SMTP configuration for notifications (optional)

Usage:
    python scheduler.py [--config config.json]

Author: Board Game Database Project
"""

import json
import logging
import signal
import sys
import time
from datetime import datetime, timedelta
from typing import Dict, Any, Optional
import subprocess
import os
import smtplib
from email.mime.text import MimeText
from email.mime.multipart import MimeMultipart

from apscheduler.schedulers.blocking import BlockingScheduler
from apscheduler.events import EVENT_JOB_EXECUTED, EVENT_JOB_ERROR
from apscheduler.jobstores.sqlalchemy import SQLAlchemyJobStore
import mysql.connector

class DataWarehouseScheduler:
    """
    Automated scheduler for data warehouse ETL operations.
    """
    
    def __init__(self, config_file: str = "scheduler_config.json"):
        """
        Initialize the scheduler with configuration.
        
        Args:
            config_file: Path to configuration file
        """
        self.config = self.load_config(config_file)
        self.scheduler = None
        self.setup_logging()
        self.setup_scheduler()
        
        # Job tracking
        self.job_history = []
        self.failed_jobs = []
        
    def load_config(self, config_file: str) -> Dict[str, Any]:
        """
        Load scheduler configuration from JSON file.
        
        Args:
            config_file: Path to configuration file
            
        Returns:
            Configuration dictionary
        """
        default_config = {
            "database": {
                "host": "localhost",
                "database": "boardgame_dw",
                "user": "root",
                "password": "",
                "charset": "utf8mb4"
            },
            "schedules": {
                "daily_etl": {
                    "enabled": True,
                    "cron": "0 2 * * *",  # Daily at 2 AM
                    "description": "Daily incremental ETL"
                },
                "weekly_full_refresh": {
                    "enabled": True,
                    "cron": "0 3 * * 0",  # Weekly on Sunday at 3 AM
                    "description": "Weekly full data refresh"
                },
                "monthly_maintenance": {
                    "enabled": True,
                    "cron": "0 4 1 * *",  # Monthly on 1st at 4 AM
                    "description": "Monthly maintenance and cleanup"
                }
            },
            "notifications": {
                "email_enabled": False,
                "smtp_server": "smtp.gmail.com",
                "smtp_port": 587,
                "email_user": "",
                "email_password": "",
                "recipients": []
            },
            "etl_script_path": "./etl_warehouse.py",
            "max_job_history": 1000,
            "retry_failed_jobs": True,
            "max_retries": 3
        }
        
        try:
            if os.path.exists(config_file):
                with open(config_file, 'r') as f:
                    user_config = json.load(f)
                    # Merge with defaults
                    for key, value in user_config.items():
                        if isinstance(value, dict) and key in default_config:
                            default_config[key].update(value)
                        else:
                            default_config[key] = value
            else:
                # Create default config file
                with open(config_file, 'w') as f:
                    json.dump(default_config, f, indent=2)
                print(f"📝 Created default configuration file: {config_file}")
                
            return default_config
            
        except Exception as e:
            print(f"❌ Error loading config: {e}")
            return default_config
    
    def setup_logging(self):
        """Setup comprehensive logging for the scheduler."""
        log_format = '%(asctime)s - %(name)s - %(levelname)s - %(message)s'
        
        # Create logs directory if it doesn't exist
        os.makedirs('logs', exist_ok=True)
        
        logging.basicConfig(
            level=logging.INFO,
            format=log_format,
            handlers=[
                logging.FileHandler(f'logs/scheduler_{datetime.now().strftime("%Y%m%d")}.log'),
                logging.StreamHandler(sys.stdout)
            ]
        )
        self.logger = logging.getLogger(__name__)
        
    def setup_scheduler(self):
        """Setup APScheduler with database job store."""
        try:
            # Configure job store to persist jobs in database
            db_url = (f"mysql+pymysql://{self.config['database']['user']}:"
                     f"{self.config['database']['password']}@"
                     f"{self.config['database']['host']}/"
                     f"{self.config['database']['database']}")
            
            jobstores = {
                'default': SQLAlchemyJobStore(url=db_url, tablename='scheduler_jobs')
            }
            
            job_defaults = {
                'coalesce': False,
                'max_instances': 1,
                'misfire_grace_time': 30 * 60  # 30 minutes
            }
            
            self.scheduler = BlockingScheduler(
                jobstores=jobstores,
                job_defaults=job_defaults
            )
            
            # Add event listeners
            self.scheduler.add_listener(
                self.job_executed_listener,
                EVENT_JOB_EXECUTED | EVENT_JOB_ERROR
            )
            
            self.logger.info("✅ Scheduler initialized successfully")
            
        except Exception as e:
            self.logger.error(f"❌ Failed to setup scheduler: {e}")
            raise
    
    def job_executed_listener(self, event):
        """
        Event listener for job execution events.
        
        Args:
            event: APScheduler event object
        """
        job_info = {
            'job_id': event.job_id,
            'scheduled_run_time': event.scheduled_run_time,
            'timestamp': datetime.now(),
            'success': event.exception is None
        }
        
        if event.exception:
            job_info['error'] = str(event.exception)
            self.failed_jobs.append(job_info)
            self.logger.error(f"❌ Job {event.job_id} failed: {event.exception}")
            
            # Send notification if enabled
            if self.config['notifications']['email_enabled']:
                self.send_failure_notification(job_info)
                
            # Schedule retry if enabled
            if self.config['retry_failed_jobs']:
                self.schedule_retry(event.job_id)
        else:
            self.logger.info(f"✅ Job {event.job_id} completed successfully")
        
        # Add to history
        self.job_history.append(job_info)
        
        # Cleanup old history
        if len(self.job_history) > self.config['max_job_history']:
            self.job_history = self.job_history[-self.config['max_job_history']:]
    
    def schedule_retry(self, job_id: str):
        """
        Schedule a retry for a failed job.
        
        Args:
            job_id: ID of the failed job
        """
        try:
            # Count existing retries
            retry_count = sum(1 for job in self.failed_jobs 
                            if job['job_id'].startswith(job_id))
            
            if retry_count < self.config['max_retries']:
                retry_time = datetime.now() + timedelta(minutes=15)  # Retry in 15 minutes
                retry_job_id = f"{job_id}_retry_{retry_count + 1}"
                
                # Determine job type and schedule retry
                if 'daily' in job_id:
                    self.scheduler.add_job(
                        self.run_daily_etl,
                        'date',
                        run_date=retry_time,
                        id=retry_job_id
                    )
                elif 'weekly' in job_id:
                    self.scheduler.add_job(
                        self.run_weekly_full_refresh,
                        'date',
                        run_date=retry_time,
                        id=retry_job_id
                    )
                
                self.logger.info(f"🔄 Scheduled retry {retry_count + 1} for {job_id} at {retry_time}")
                
        except Exception as e:
            self.logger.error(f"❌ Failed to schedule retry for {job_id}: {e}")
    
    def send_failure_notification(self, job_info: Dict[str, Any]):
        """
        Send email notification for job failure.
        
        Args:
            job_info: Dictionary containing job failure information
        """
        try:
            if not self.config['notifications']['recipients']:
                return
                
            # Create email content
            subject = f"ETL Job Failure: {job_info['job_id']}"
            
            body = f"""
            ETL Job Failure Notification
            
            Job ID: {job_info['job_id']}
            Scheduled Time: {job_info['scheduled_run_time']}
            Failure Time: {job_info['timestamp']}
            Error: {job_info.get('error', 'Unknown error')}
            
            Please check the logs for more details.
            
            Best regards,
            BoardGame Data Warehouse Scheduler
            """
            
            # Send email
            msg = MimeMultipart()
            msg['From'] = self.config['notifications']['email_user']
            msg['Subject'] = subject
            msg.attach(MimeText(body, 'plain'))
            
            server = smtplib.SMTP(
                self.config['notifications']['smtp_server'],
                self.config['notifications']['smtp_port']
            )
            server.starttls()
            server.login(
                self.config['notifications']['email_user'],
                self.config['notifications']['email_password']
            )
            
            for recipient in self.config['notifications']['recipients']:
                msg['To'] = recipient
                server.send_message(msg)
                
            server.quit()
            self.logger.info(f"📧 Failure notification sent for job {job_info['job_id']}")
            
        except Exception as e:
            self.logger.error(f"❌ Failed to send notification: {e}")
    
    def run_etl_command(self, args: list) -> bool:
        """
        Execute ETL command with given arguments.
        
        Args:
            args: List of command line arguments for ETL script
            
        Returns:
            True if successful, False otherwise
        """
        try:
            script_path = self.config['etl_script_path']
            
            # Build command
            cmd = ['python3', script_path] + args
            
            self.logger.info(f"🚀 Executing ETL command: {' '.join(cmd)}")
            
            # Execute command
            result = subprocess.run(
                cmd,
                capture_output=True,
                text=True,
                timeout=3600  # 1 hour timeout
            )
            
            if result.returncode == 0:
                self.logger.info("✅ ETL command completed successfully")
                if result.stdout:
                    self.logger.info(f"ETL Output: {result.stdout}")
                return True
            else:
                self.logger.error(f"❌ ETL command failed with return code {result.returncode}")
                if result.stderr:
                    self.logger.error(f"ETL Error: {result.stderr}")
                return False
                
        except subprocess.TimeoutExpired:
            self.logger.error("❌ ETL command timed out")
            return False
        except Exception as e:
            self.logger.error(f"❌ Error executing ETL command: {e}")
            return False
    
    def run_daily_etl(self):
        """Execute daily incremental ETL."""
        self.logger.info("📅 Starting daily incremental ETL")
        
        timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        batch_name = f"Daily ETL - {timestamp}"
        
        success = self.run_etl_command(['--batch-name', batch_name])
        
        if not success:
            raise Exception("Daily ETL failed")
    
    def run_weekly_full_refresh(self):
        """Execute weekly full data refresh."""
        self.logger.info("📅 Starting weekly full data refresh")
        
        timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        batch_name = f"Weekly Full Refresh - {timestamp}"
        
        success = self.run_etl_command(['--full-refresh', '--batch-name', batch_name])
        
        if not success:
            raise Exception("Weekly full refresh failed")
    
    def run_monthly_maintenance(self):
        """Execute monthly maintenance tasks."""
        self.logger.info("📅 Starting monthly maintenance")
        
        try:
            # Database maintenance tasks
            conn = mysql.connector.connect(**self.config['database'])
            cursor = conn.cursor()
            
            # Optimize tables
            maintenance_queries = [
                "OPTIMIZE TABLE fact_game_metrics",
                "OPTIMIZE TABLE fact_game_rankings", 
                "OPTIMIZE TABLE fact_pricing",
                "ANALYZE TABLE fact_game_metrics",
                "ANALYZE TABLE fact_game_rankings",
                "ANALYZE TABLE fact_pricing"
            ]
            
            for query in maintenance_queries:
                self.logger.info(f"🔧 Executing: {query}")
                cursor.execute(query)
            
            # Archive old batch logs (keep last 6 months)
            archive_query = """
                DELETE FROM etl_batch_log 
                WHERE start_time < DATE_SUB(NOW(), INTERVAL 6 MONTH)
            """
            cursor.execute(archive_query)
            
            conn.commit()
            cursor.close()
            conn.close()
            
            self.logger.info("✅ Monthly maintenance completed")
            
        except Exception as e:
            self.logger.error(f"❌ Monthly maintenance failed: {e}")
            raise
    
    def schedule_jobs(self):
        """Schedule all configured ETL jobs."""
        schedules = self.config['schedules']
        
        # Daily ETL
        if schedules['daily_etl']['enabled']:
            self.scheduler.add_job(
                self.run_daily_etl,
                'cron',
                **self.parse_cron(schedules['daily_etl']['cron']),
                id='daily_etl',
                replace_existing=True
            )
            self.logger.info(f"📅 Scheduled daily ETL: {schedules['daily_etl']['cron']}")
        
        # Weekly full refresh
        if schedules['weekly_full_refresh']['enabled']:
            self.scheduler.add_job(
                self.run_weekly_full_refresh,
                'cron',
                **self.parse_cron(schedules['weekly_full_refresh']['cron']),
                id='weekly_full_refresh',
                replace_existing=True
            )
            self.logger.info(f"📅 Scheduled weekly refresh: {schedules['weekly_full_refresh']['cron']}")
        
        # Monthly maintenance
        if schedules['monthly_maintenance']['enabled']:
            self.scheduler.add_job(
                self.run_monthly_maintenance,
                'cron',
                **self.parse_cron(schedules['monthly_maintenance']['cron']),
                id='monthly_maintenance',
                replace_existing=True
            )
            self.logger.info(f"📅 Scheduled monthly maintenance: {schedules['monthly_maintenance']['cron']}")
    
    def parse_cron(self, cron_string: str) -> Dict[str, str]:
        """
        Parse cron string into APScheduler format.
        
        Args:
            cron_string: Cron expression string
            
        Returns:
            Dictionary of cron parameters
        """
        parts = cron_string.split()
        if len(parts) != 5:
            raise ValueError(f"Invalid cron expression: {cron_string}")
        
        return {
            'minute': parts[0],
            'hour': parts[1],
            'day': parts[2],
            'month': parts[3],
            'day_of_week': parts[4]
        }
    
    def signal_handler(self, signum, frame):
        """Handle shutdown signals gracefully."""
        self.logger.info(f"🛑 Received signal {signum}, shutting down scheduler...")
        
        if self.scheduler and self.scheduler.running:
            self.scheduler.shutdown(wait=False)
        
        sys.exit(0)
    
    def start(self):
        """Start the scheduler."""
        try:
            # Setup signal handlers
            signal.signal(signal.SIGINT, self.signal_handler)
            signal.signal(signal.SIGTERM, self.signal_handler)
            
            # Schedule jobs
            self.schedule_jobs()
            
            # Print next job runs
            self.print_scheduled_jobs()
            
            # Start scheduler
            self.logger.info("🚀 Starting BoardGame Data Warehouse Scheduler")
            self.logger.info("   Press Ctrl+C to stop the scheduler")
            
            self.scheduler.start()
            
        except Exception as e:
            self.logger.error(f"❌ Failed to start scheduler: {e}")
            raise
    
    def print_scheduled_jobs(self):
        """Print information about scheduled jobs."""
        jobs = self.scheduler.get_jobs()
        
        if jobs:
            self.logger.info("📋 Scheduled Jobs:")
            for job in jobs:
                next_run = job.next_run_time.strftime("%Y-%m-%d %H:%M:%S") if job.next_run_time else "None"
                self.logger.info(f"   • {job.id}: Next run at {next_run}")
        else:
            self.logger.info("📋 No jobs scheduled")

def main():
    """Main execution function."""
    import argparse
    
    parser = argparse.ArgumentParser(description='BoardGame Data Warehouse Scheduler')
    parser.add_argument('--config', type=str, default='scheduler_config.json',
                       help='Path to configuration file')
    parser.add_argument('--run-now', type=str, choices=['daily', 'weekly', 'monthly'],
                       help='Run a specific job immediately and exit')
    
    args = parser.parse_args()
    
    scheduler = DataWarehouseScheduler(args.config)
    
    if args.run_now:
        # Run specific job immediately
        if args.run_now == 'daily':
            scheduler.run_daily_etl()
        elif args.run_now == 'weekly':
            scheduler.run_weekly_full_refresh()
        elif args.run_now == 'monthly':
            scheduler.run_monthly_maintenance()
    else:
        # Start scheduler daemon
        scheduler.start()

if __name__ == "__main__":
    main()
