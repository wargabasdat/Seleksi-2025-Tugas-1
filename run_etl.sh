#!/bin/bash
cd "$(dirname "$0")"

echo ""
cd "Data Scraping/src"
python3 scraper.py
echo "Data scraping completed."
cd ../..

echo ""
cd "Data Storing/src"
python3 db_maker.py --auto
echo "Data storing completed."
cd ../..

echo ""
cd "Data Warehouse/src"
python3 dw_maker.py --auto
echo "Data warehousing completed."
cd ../..

echo ""
echo "ETL process completed."