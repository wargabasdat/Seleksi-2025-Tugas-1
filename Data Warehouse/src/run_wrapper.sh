#!/bin/zsh

cd "$(dirname "$0")"

LOG_FILE="/Users/allodyaq/Seleksi-2025-Tugas-1/etl_log.txt"

echo "\n==================================================" >> "$LOG_FILE"
echo "Wrapper script started at: $(date)" >> "$LOG_FILE"
echo "==================================================\n" >> "$LOG_FILE"

export PATH=/Applications/Postgres.app/Contents/Versions/17/bin:/opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home/bin:/Applications/XAMPP/xamppfiles/bin:/Users/allodyaq/Downloads/google-cloud-sdk/google-cloud-sdk/bin:/Users/allodyaq/.nvm/versions/node/v22.17.0/bin:/Users/allodyaq/.cabal/bin:/Users/allodyaq/.ghcup/bin:/Users/allodyaq/anaconda3/bin:/Users/allodyaq/anaconda3/condabin:/opt/homebrew/bin:/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin:/Applications/Visual Studio Code.app/Contents/Resources/app/bin:/Applications/Visual Studio Code.app/Contents/Resources/app/bin

echo "--> Starting run_etl.py..." >> "$LOG_FILE"
"/Users/allodyaq/anaconda3/bin/python" "run_etl.py" >> "$LOG_FILE" 2>&1
echo "--> Finished run_etl.py." >> "$LOG_FILE"

echo "\n==================================================" >> "$LOG_FILE"
echo "Wrapper script finished at: $(date)" >> "$LOG_FILE"
echo "====================================================" >> "$LOG_FILE"