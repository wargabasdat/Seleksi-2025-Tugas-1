import subprocess
import datetime
import os
import sys

def run_script(path):
    python_executable = sys.executable 
    
    print(f"   -> Running: {os.path.basename(path)}")
    try:
        result = subprocess.run(
            [python_executable, path], 
            capture_output=True, 
            text=True,
            check=False 
        )
        if result.stdout:
            print(result.stdout)
        if result.stderr:
            print("   -> ERROR OUTPUT:", file=sys.stderr)
            print(result.stderr, file=sys.stderr)
    except FileNotFoundError:
        print(f"   -> FATAL ERROR: File not found - {path}", file=sys.stderr)
    except Exception as e:
        print(f"   -> FATAL ERROR running {path}: {e}", file=sys.stderr)

BASE_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), "../../"))

steps = [
    ("[STEP 1] Scraping Products", os.path.join(BASE_DIR, "Data Scraping/src/products.py")),
    ("[STEP 2] Scraping Measurements", os.path.join(BASE_DIR, "Data Scraping/src/measurements.py")),
    ("[STEP 3] Scraping Variants", os.path.join(BASE_DIR, "Data Scraping/src/variants.py")),
    ("[STEP 4] Storing to PostgreSQL", os.path.join(BASE_DIR, "Data Storing/src/scraping_to_storing.py")),
    ("[STEP 5] Load to Data Warehouse", os.path.join(BASE_DIR, "Data Warehouse/src/load_to_warehouse.py")),
]

timestamp_start = datetime.datetime.now().strftime("[%Y-%m-%d %H:%M:%S]")
print(f"============ ETL PIPELINE RUN STARTED {timestamp_start} ============")

for step_name, script_path in steps:
    print(f"\n{step_name}")
    if not os.path.exists(script_path):
        print(f"   -> ERROR: File not found, skipping: {script_path}", file=sys.stderr)
        continue
    run_script(script_path)