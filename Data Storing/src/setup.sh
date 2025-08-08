#!/bin/bash

# BoardGame Database Setup Script
# This script sets up the database and loads the scraped data

echo " BoardGame Database Setup"
echo "================================"

# Check if MySQL is running
if ! command -v mysql &> /dev/null; then
    echo "MySQL is not installed or not in PATH"
    echo "Please install MySQL and try again"
    exit 1
fi

# Install Python requirements
echo "Installing Python requirements..."
pip install -r requirements.txt

# Create database schema
echo "Creating database schema..."
echo "Please enter your MySQL root password when prompted:"
mysql -u root -p < 01_create_schema.sql

if [ $? -eq 0 ]; then
    echo "Database schema created successfully"
else
    echo "Failed to create database schema"
    exit 1
fi

# Load data
echo "Loading scraped data into database..."
python load_data.py

if [ $? -eq 0 ]; then
    echo "Setup completed successfully!"
    echo ""

else
    echo "Data loading failed"
    exit 1
fi
