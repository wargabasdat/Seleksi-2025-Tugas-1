import subprocess


print("Scraping...")
subprocess.run(["python3", "Seleksi-2025-Tugas-1/Data Scraping/src/Scrape.py"])

print("Storing Scraping...")
subprocess.run(["python3", "Seleksi-2025-Tugas-1/Data Storing/src/Storing.py"])

print("Storing Warehouse...")
subprocess.run(["python3", "Seleksi-2025-Tugas-1/Data Warehouse/src/Storing.py"])