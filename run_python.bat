@echo off
REM filepath: C:\Users\Velicia\OneDrive\Documents\ITB\SeleksiBasdat\TUGAS_SELEKSI_1_18223085\run_python.bat

echo KODEKIDDO DATA PIPELINE
echo Start Time: %date% %time%

REM SET WORKING DIRECTORY FIRST
cd /d "C:\Users\Velicia\OneDrive\Documents\ITB\SeleksiBasdat\TUGAS_SELEKSI_1_18223085"
echo Working Directory: %CD%

REM KILL CHROME PROCESSES
echo Killing Chrome...
taskkill /f /im chrome.exe >nul 2>&1
taskkill /f /im chromedriver.exe >nul 2>&1
timeout /t 3 >nul

REM SET ENVIRONMENT
set HEADLESS_MODE=true
set PYTHONUNBUFFERED=1
set PYTHONIOENCODING=utf-8

REM CHECK PYTHON AVAILABILITY
echo Checking Python...
python --version
if %errorlevel% neq 0 (
    echo ERROR: Python not found in PATH!
    exit /b 1
)

REM CHECK CHROMEDRIVER
echo Checking ChromeDriver...
if exist "chromedriver-win64\chromedriver.exe" (
    echo ChromeDriver found
) else (
    echo WARNING: ChromeDriver not found at expected location
)

REM Create logs directory
if not exist "logs" mkdir "logs"

REM Create log file
set TIMESTAMP=%date:~-4,4%%date:~-10,2%%date:~-7,2%_%time:~0,2%%time:~3,2%
set TIMESTAMP=%TIMESTAMP: =0%
set LOG_FILE=logs\pipeline_%TIMESTAMP%.log

echo > "%LOG_FILE%"
echo KODEKIDDO PIPELINE STARTED >> "%LOG_FILE%"
echo Start Time: %date% %time% >> "%LOG_FILE%"
echo Working Directory: %CD% >> "%LOG_FILE%"
echo Python Version: >> "%LOG_FILE%"
python --version >> "%LOG_FILE%" 2>&1
echo >> "%LOG_FILE%"

echo.
echo [1/3] SCRAPING DATA...
cd "Data Scraping\src"
echo Current dir: %CD%
echo Current dir: %CD% >> "..\..\%LOG_FILE%"

python scraping.py >> "..\..\%LOG_FILE%" 2>&1
set SCRAPE_RESULT=%errorlevel%

if %SCRAPE_RESULT% equ 0 (
    echo SUCCESS: SCRAPING COMPLETED
    echo [%time%] SCRAPING: SUCCESS >> "..\..\%LOG_FILE%"
) else (
    echo ERROR: SCRAPING FAILED - Exit Code: %SCRAPE_RESULT%
    echo [%time%] SCRAPING: FAILED (Exit Code: %SCRAPE_RESULT%) >> "..\..\%LOG_FILE%"
)

cd "..\..\"

echo.
echo [2/3] STORING DATA...
cd "Data Storing\src"
echo Current dir: %CD%
python storing.py >> "..\..\%LOG_FILE%" 2>&1
if %errorlevel% equ 0 (
    echo SUCCESS: STORING COMPLETED
    echo [%time%] STORING: SUCCESS >> "..\..\%LOG_FILE%"
) else (
    echo ERROR: STORING FAILED
    echo [%time%] STORING: FAILED (Exit Code: %errorlevel%) >> "..\..\%LOG_FILE%"
)

cd "..\..\"

echo.
echo [3/3] WAREHOUSING DATA...
cd "Data Warehouse\src"
echo Current dir: %CD%
python warehousing.py >> "..\..\%LOG_FILE%" 2>&1
if %errorlevel% equ 0 (
    echo SUCCESS: WAREHOUSING COMPLETED
    echo [%time%] WAREHOUSING: SUCCESS >> "..\..\%LOG_FILE%"
) else (
    echo ERROR: WAREHOUSING FAILED
    echo [%time%] WAREHOUSING: FAILED (Exit Code: %errorlevel%) >> "..\..\%LOG_FILE%"
)

cd "..\..\"

echo >> "%LOG_FILE%"
echo PIPELINE COMPLETED >> "%LOG_FILE%"
echo End Time: %date% %time% >> "%LOG_FILE%"
echo >> "%LOG_FILE%"

echo PIPELINE COMPLETED!
echo End Time: %date% %time%
echo Scraping Result: %SCRAPE_RESULT%
echo Log saved to: %LOG_FILE%

REM Cleanup
taskkill /f /im chrome.exe >nul 2>&1
taskkill /f /im chromedriver.exe >nul 2>&1

exit /b 0