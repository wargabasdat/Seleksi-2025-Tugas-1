@echo OFF
cd /d "%~dp0"

echo.
cd "Data Scraping\src"
python scraper.py
echo Data scraping completed.
cd ..\..

echo.
cd "Data Storing\src"
python db_maker.py --auto
echo Data storing completed.
cd ..\..

echo.
cd "Data Warehouse\src"
python dw_maker.py --auto
echo Data warehousing completed.
cd ..\..

echo.
echo ETL process completed.