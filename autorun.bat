@echo off
echo ================================================
echo    Spotify Data Extraction and Loading (ETL)
echo ================================================
echo Start Time: %date% %time%

echo [INFO] Checking Docker status...
docker version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Docker is not running or not installed
    echo Please start Docker Desktop and try again
    pause
    exit /b 1
)

echo [INFO] Starting Docker services...
docker-compose up -d
if errorlevel 1 (
    echo [ERROR] Failed to start Docker services
    pause
    exit /b 1
)

echo [INFO] Waiting for database to be ready...
timeout /t 30 /nobreak >nul

echo [INFO] Starting data scraping...
uv run -m "Data Scraping.src.main"
if errorlevel 1 (
    echo [ERROR] Data scraping failed
    pause
    exit /b 1
)

echo [INFO] Finding latest data folder...
for /f "delims=" %%i in ('dir "Data Scraping\data" /b /ad /o-n ^| findstr /r "^[0-9][0-9][0-9][0-9]_[0-9][0-9]_[0-9][0-9]_[0-9][0-9]_[0-9][0-9]_[0-9][0-9]$"') do (
    set LATEST_FOLDER=%%i
    goto :found
)

:found
if "%LATEST_FOLDER%"=="" (
    echo [ERROR] No timestamped data folder found
    pause
    exit /b 1
)

echo [INFO] Using data folder: %LATEST_FOLDER%

echo [INFO] Preparing data for database insertion...
xcopy "Data Scraping\data\%LATEST_FOLDER%\*" "Data Scraping\data\" /Y /Q

echo [INFO] Loading data into operational database...
uv run -m "Data Storing.src.connection"
if errorlevel 1 (
    echo [ERROR] Database loading failed
    pause
    exit /b 1
)

echo [INFO] Generating data warehouse...
uv run -m "Data Warehouse.src.generate_dw"
if errorlevel 1 (
    echo [ERROR] Data warehouse generation failed
    pause
    exit /b 1
)

echo [SUCCESS] ETL process completed successfully!
echo End Time: %date% %time%
echo Latest data folder: %LATEST_FOLDER%
echo Access phpMyAdmin at: http://localhost:8080
echo Closing this window will stop the Docker containers.
echo ================================================
pause

echo [INFO] Stopping Docker services...
docker-compose down -v
