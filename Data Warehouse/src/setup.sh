#!/bin/bash

# ============================================================================
# BoardGame Data Warehouse Setup Script
# Created: August 7, 2025
# Description: Automated setup script for the data warehouse environment
# ============================================================================

set -e  # Exit on any error

echo "🚀 BoardGame Data Warehouse Setup Starting..."
echo "============================================="

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    local color=$1
    local message=$2
    echo -e "${color}${message}${NC}"
}

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check MySQL connection
check_mysql() {
    mysql -u root -e "SELECT 1;" >/dev/null 2>&1
}

print_status $BLUE "📋 Checking prerequisites..."

# Check MySQL
if command_exists mysql; then
    print_status $GREEN "✅ MySQL client found"
    if check_mysql; then
        print_status $GREEN "✅ MySQL server connection successful"
    else
        print_status $RED "❌ Cannot connect to MySQL server"
        print_status $YELLOW "   Please ensure MySQL server is running and accessible"
        exit 1
    fi
else
    print_status $RED "❌ MySQL client not found"
    print_status $YELLOW "   Please install MySQL client"
    exit 1
fi

# Check Python
if command_exists python3; then
    print_status $GREEN "✅ Python 3 found"
    PYTHON_VERSION=$(python3 --version | cut -d " " -f 2)
    print_status $BLUE "   Version: $PYTHON_VERSION"
else
    print_status $RED "❌ Python 3 not found"
    exit 1
fi

# Check pip
if command_exists pip3; then
    print_status $GREEN "✅ pip3 found"
else
    print_status $RED "❌ pip3 not found"
    exit 1
fi

print_status $BLUE "🐍 Setting up Python environment..."

# Create virtual environment if it doesn't exist
if [ ! -d "../../env" ]; then
    print_status $YELLOW "   Creating virtual environment..."
    python3 -m venv ../../env
    print_status $GREEN "   ✅ Virtual environment created"
else
    print_status $GREEN "   ✅ Virtual environment already exists"
fi

# Activate virtual environment
print_status $YELLOW "   Activating virtual environment..."
source ../../env/bin/activate

# Upgrade pip
print_status $YELLOW "   Upgrading pip..."
pip install --upgrade pip >/dev/null 2>&1

# Install requirements
print_status $YELLOW "   Installing Python dependencies..."
if [ -f "requirements.txt" ]; then
    pip install -r requirements.txt
    print_status $GREEN "   ✅ Dependencies installed successfully"
else
    print_status $RED "   ❌ requirements.txt not found"
    exit 1
fi

print_status $BLUE "🗃️  Setting up data warehouse database..."

# Check if operational database exists
DB_EXISTS=$(mysql -u root -e "SHOW DATABASES LIKE 'boardgame_db';" | grep -c "boardgame_db" || true)
if [ "$DB_EXISTS" -eq 0 ]; then
    print_status $RED "❌ Operational database 'boardgame_db' not found"
    print_status $YELLOW "   Please set up the operational database first"
    exit 1
else
    print_status $GREEN "✅ Operational database 'boardgame_db' found"
fi

# Create data warehouse schema
print_status $YELLOW "   Creating data warehouse schema..."
if [ -f "01_create_warehouse_schema.sql" ]; then
    mysql -u root < 01_create_warehouse_schema.sql
    print_status $GREEN "   ✅ Data warehouse schema created successfully"
else
    print_status $RED "   ❌ Schema file not found"
    exit 1
fi

print_status $BLUE "📊 Running initial ETL load..."

# Run initial ETL
print_status $YELLOW "   Executing initial data load..."
python3 etl_warehouse.py --batch-name "Initial Setup Load"
if [ $? -eq 0 ]; then
    print_status $GREEN "   ✅ Initial ETL completed successfully"
else
    print_status $RED "   ❌ Initial ETL failed"
    exit 1
fi

print_status $BLUE "🔍 Verifying data warehouse setup..."

# Verify table creation
TABLE_COUNT=$(mysql -u root -e "USE boardgame_dw; SHOW TABLES;" | wc -l)
if [ "$TABLE_COUNT" -gt 10 ]; then
    print_status $GREEN "✅ Data warehouse tables created ($((TABLE_COUNT-1)) tables)"
else
    print_status $RED "❌ Expected more tables in data warehouse"
fi

# Verify data loading
FACT_COUNT=$(mysql -u root -e "USE boardgame_dw; SELECT COUNT(*) FROM fact_game_metrics;" | tail -1)
if [ "$FACT_COUNT" -gt 0 ]; then
    print_status $GREEN "✅ Fact data loaded ($FACT_COUNT records in fact_game_metrics)"
else
    print_status $YELLOW "⚠️  No fact data loaded - this may be expected for initial setup"
fi

print_status $BLUE "📝 Creating configuration files..."

# Create scheduler configuration
cat > scheduler_config.json << EOF
{
  "database": {
    "host": "localhost",
    "database": "boardgame_dw",
    "user": "root",
    "password": "",
    "charset": "utf8mb4"
  },
  "schedules": {
    "daily_etl": {
      "enabled": true,
      "cron": "0 2 * * *",
      "description": "Daily incremental ETL at 2 AM"
    },
    "weekly_full_refresh": {
      "enabled": true,
      "cron": "0 3 * * 0",
      "description": "Weekly full refresh on Sunday at 3 AM"
    },
    "monthly_maintenance": {
      "enabled": true,
      "cron": "0 4 1 * *",
      "description": "Monthly maintenance on 1st at 4 AM"
    }
  },
  "notifications": {
    "email_enabled": false,
    "smtp_server": "smtp.gmail.com",
    "smtp_port": 587,
    "email_user": "",
    "email_password": "",
    "recipients": []
  },
  "etl_script_path": "./etl_warehouse.py",
  "max_job_history": 1000,
  "retry_failed_jobs": true,
  "max_retries": 3
}
EOF

print_status $GREEN "✅ Scheduler configuration created"

# Create sample dashboard script
cat > run_sample_queries.py << 'EOF'
#!/usr/bin/env python3
"""
Sample queries runner for demonstrating data warehouse capabilities.
"""

import mysql.connector
import sys
from datetime import datetime

def run_sample_queries():
    """Run sample analytical queries and display results."""
    
    config = {
        'host': 'localhost',
        'database': 'boardgame_dw',
        'user': 'root',
        'password': '',
        'charset': 'utf8mb4'
    }
    
    try:
        conn = mysql.connector.connect(**config)
        cursor = conn.cursor(dictionary=True)
        
        print("🎯 BoardGame Data Warehouse - Sample Analytics")
        print("=" * 60)
        
        # Query 1: Top games by engagement
        print("\n📊 Top 5 Games by Engagement Score:")
        print("-" * 40)
        cursor.execute("""
            SELECT 
                dg.title,
                fgm.engagement_score,
                fgm.geek_rating,
                fgm.rank_position
            FROM fact_game_metrics fgm
            JOIN dim_game dg ON fgm.game_key = dg.game_key AND dg.is_current = TRUE
            ORDER BY fgm.engagement_score DESC
            LIMIT 5
        """)
        
        for row in cursor.fetchall():
            print(f"• {row['title'][:30]:30} | Score: {row['engagement_score']:8.0f} | Rating: {row['geek_rating']:.3f} | Rank: #{row['rank_position']}")
        
        # Query 2: Complexity analysis
        print("\n🎲 Games by Complexity Category:")
        print("-" * 40)
        cursor.execute("""
            SELECT 
                dg.complexity_category,
                COUNT(*) as game_count,
                AVG(fgm.geek_rating) as avg_rating
            FROM fact_game_metrics fgm
            JOIN dim_game dg ON fgm.game_key = dg.game_key AND dg.is_current = TRUE
            GROUP BY dg.complexity_category
            ORDER BY avg_rating DESC
        """)
        
        for row in cursor.fetchall():
            print(f"• {row['complexity_category']:15} | Games: {row['game_count']:3} | Avg Rating: {row['avg_rating']:.3f}")
        
        # Query 3: Recent data summary
        print(f"\n📅 Data Warehouse Status (as of {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}):")
        print("-" * 50)
        
        cursor.execute("SELECT COUNT(*) as count FROM fact_game_metrics")
        fact_count = cursor.fetchone()['count']
        
        cursor.execute("SELECT COUNT(*) as count FROM dim_game WHERE is_current = TRUE")
        game_count = cursor.fetchone()['count']
        
        print(f"• Total fact records: {fact_count}")
        print(f"• Current games: {game_count}")
        
        cursor.close()
        conn.close()
        
        print("\n✅ Sample queries completed successfully!")
        print("💡 Run 'mysql -u root boardgame_dw < sample_queries.sql' for more examples")
        
    except Exception as e:
        print(f"❌ Error running queries: {e}")
        sys.exit(1)

if __name__ == "__main__":
    run_sample_queries()
EOF

chmod +x run_sample_queries.py
print_status $GREEN "✅ Sample queries script created"

print_status $BLUE "📚 Creating documentation..."

# Create quick start guide
cat > QUICK_START.md << 'EOF'
# Data Warehouse Quick Start Guide

## Prerequisites
- Operational database (boardgame_db) must be set up and populated
- MySQL server running locally
- Python 3.7+ installed

## Getting Started

### 1. Run Setup (Already Done)
```bash
./setup.sh
```

### 2. Manual ETL Execution
```bash
# Activate virtual environment
source ../../env/bin/activate

# Run daily ETL
python3 etl_warehouse.py --batch-name "Manual Run"

# Run full refresh
python3 etl_warehouse.py --full-refresh --batch-name "Full Refresh"
```

### 3. Start Automated Scheduler
```bash
# Run scheduler daemon
python3 scheduler.py

# Or run specific job immediately
python3 scheduler.py --run-now daily
```

### 4. Run Sample Analytics
```bash
# Python-based samples
python3 run_sample_queries.py

# SQL-based samples
mysql -u root boardgame_dw < sample_queries.sql
```

## File Structure
- `01_create_warehouse_schema.sql` - Data warehouse schema
- `etl_warehouse.py` - ETL pipeline script
- `scheduler.py` - Automated scheduling system
- `sample_queries.sql` - Analytical query examples
- `scheduler_config.json` - Scheduler configuration

## Configuration
Edit `scheduler_config.json` to:
- Modify ETL schedules
- Enable email notifications
- Adjust retry policies

## Monitoring
Check ETL execution logs in:
- `etl_warehouse_YYYYMMDD_HHMMSS.log`
- `logs/scheduler_YYYYMMDD.log`

## Troubleshooting
1. Check MySQL connectivity
2. Verify operational database has data
3. Review log files for errors
4. Ensure all Python dependencies are installed
EOF

print_status $GREEN "✅ Quick start guide created"

print_status $GREEN "🎉 Data Warehouse Setup Complete!"
print_status $BLUE "================================================"
echo ""
print_status $YELLOW "📋 Next Steps:"
echo "   1. Review configuration in scheduler_config.json"
echo "   2. Run sample queries: python3 run_sample_queries.py"
echo "   3. Start scheduler: python3 scheduler.py"
echo "   4. Check QUICK_START.md for detailed usage instructions"
echo ""
print_status $BLUE "📁 Files Created:"
echo "   • Data warehouse database: boardgame_dw"
echo "   • ETL pipeline: etl_warehouse.py"
echo "   • Scheduler: scheduler.py"
echo "   • Sample queries: sample_queries.sql"
echo "   • Configuration: scheduler_config.json"
echo "   • Quick start guide: QUICK_START.md"
echo ""
print_status $GREEN "✨ Data warehouse is ready for analytical workloads!"

# Deactivate virtual environment
deactivate
