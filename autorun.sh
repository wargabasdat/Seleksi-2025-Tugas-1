#!/bin/bash

echo "================================================"
echo "   Spotify Data Extraction and Loading (ETL)"
echo "================================================"
echo "Start Time: $(date)"

echo "[INFO] Checking Docker status..."
if ! docker version >/dev/null 2>&1; then
    echo "[ERROR] Docker is not running or not installed"
    echo "Please start Docker and try again"
    exit 1
fi

echo "[INFO] Starting Docker services..."
if ! docker-compose up -d; then
    echo "[ERROR] Failed to start Docker services"
    exit 1
fi

echo "[INFO] Waiting for database to be ready..."
sleep 30

echo "[INFO] Starting data scraping..."
if ! uv run -m "Data Scraping.src.main"; then
    echo "[ERROR] Data scraping failed"
    exit 1
fi

echo "[INFO] Finding latest data folder..."
LATEST_FOLDER=$(ls -1 "Data Scraping/data/" | grep -E '^[0-9]{4}_[0-9]{2}_[0-9]{2}_[0-9]{2}_[0-9]{2}_[0-9]{2}$' | sort -r | head -n1)

if [ -z "$LATEST_FOLDER" ]; then
    echo "[ERROR] No timestamped data folder found"
    exit 1
fi

echo "[INFO] Using data folder: $LATEST_FOLDER"

echo "[INFO] Preparing data for database insertion..."
cp "Data Scraping/data/$LATEST_FOLDER"/* "Data Scraping/data/"

echo "[INFO] Loading data into operational database..."
if ! uv run -m "Data Storing.src.connection"; then
    echo "[ERROR] Database loading failed"
    exit 1
fi

echo "[INFO] Generating data warehouse..."
if ! uv run -m "Data Warehouse.src.generate_dw"; then
    echo "[ERROR] Data warehouse generation failed"
    exit 1
fi

echo "[SUCCESS] ETL process completed successfully!"
echo "End Time: $(date)"
echo "Latest data folder: $LATEST_FOLDER"
echo "Access phpMyAdmin at: http://localhost:8080"
echo "Closing this terminal will stop the Docker containers."
echo "================================================"
pause

echo "[INFO] Stopping Docker services..."
docker-compose down -v