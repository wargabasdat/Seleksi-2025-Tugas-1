import datetime
import subprocess
import os
import sys

def run_and_log(script_path, log_file):
    script_name = os.path.basename(script_path)
    timestamp = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    
    # Log start
    with open(log_file, 'a', encoding='utf-8') as f:
        f.write(f"\n{'='*60}\n")
        f.write(f"[{timestamp}] STARTING: {script_name}\n")
        f.write(f"Script path: {script_path}\n")
        f.write(f"File exists: {os.path.exists(script_path)}\n")
    
    try:
        script_directory = os.path.dirname(script_path)
        env = os.environ.copy()
        env['HEADLESS_MODE'] = 'true'
        env['PYTHONPATH'] = script_directory
        env['PYTHONUNBUFFERED'] = '1'

        # Run dengan capture output
        result = subprocess.run([
            sys.executable, script_path
        ], 
        capture_output=True, 
        text=True,
        env=env, 
        cwd=script_directory,
        timeout=600
        )
        
        # Log detailed results
        with open(log_file, 'a', encoding='utf-8') as f:
            f.write(f"Return code: {result.returncode}\n")
            
            if result.returncode == 0:
                f.write(f"STATUS: SUCCESS ✅\n")
            else:
                f.write(f"STATUS: FAILED ❌\n")
            
            if result.stdout:
                f.write(f"STDOUT:\n{result.stdout}\n")
            else:
                f.write("STDOUT: (empty)\n")
                
            if result.stderr:
                f.write(f"STDERR:\n{result.stderr}\n")
            else:
                f.write("STDERR: (empty)\n")
                
        return result.returncode == 0
        
    except subprocess.TimeoutExpired as e:
        with open(log_file, 'a', encoding='utf-8') as f:
            f.write(f"STATUS: TIMEOUT ⏰\n")
        return False
        
    except Exception as e:
        with open(log_file, 'a', encoding='utf-8') as f:
            f.write(f"STATUS: CRASHED 💥\n")
            f.write(f"Exception: {str(e)}\n")
        return False

# Script paths
scraping = r'C:/Users/Velicia/OneDrive/Documents/ITB/SeleksiBasdat/TUGAS_SELEKSI_1_18223085/Data Scraping/src/scraping.py'
storing = r'C:/Users/Velicia/OneDrive/Documents/ITB/SeleksiBasdat/TUGAS_SELEKSI_1_18223085/Data Storing/src/storing.py'
warehousing = r'C:/Users/Velicia/OneDrive/Documents/ITB/SeleksiBasdat/TUGAS_SELEKSI_1_18223085/Data Warehouse/src/warehousing.py'

log_file = r'C:/Users/Velicia/OneDrive/Documents/ITB/SeleksiBasdat/TUGAS_SELEKSI_1_18223085/scheduler_log.txt'

# Clear previous log and start fresh
with open(log_file, 'w', encoding='utf-8') as f:
    f.write(f"KODEKIDDO PIPELINE LOG\n")
    f.write(f"Start time: {datetime.datetime.now()}\n")
    f.write(f"Python executable: {sys.executable}\n")

print("Starting KodeKiddo Pipeline...")

# Run each script
scripts = [
    ("SCRAPING", scraping),
    ("STORING", storing), 
    ("WAREHOUSING", warehousing)
]

success_count = 0
for name, path in scripts:
    print(f"Running {name}...")
    if run_and_log(path, log_file):
        print(f"✅ {name} SUCCESS")
        success_count += 1
    else:
        print(f"❌ {name} FAILED")

# Final summary
with open(log_file, 'a', encoding='utf-8') as f:
    f.write(f"\n{'='*60}\n")
    f.write(f"PIPELINE SUMMARY:\n")
    f.write(f"Success: {success_count}/{len(scripts)}\n")
    f.write(f"End time: {datetime.datetime.now()}\n")

print(f"Pipeline completed: {success_count}/{len(scripts)} successful")
print(f"Check detailed log: {log_file}")