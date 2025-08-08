# Gunakan image Python resmi sebagai dasar
FROM python:3.11-slim

# Tetapkan direktori kerja di dalam container
WORKDIR /app

# Salin file requirements terlebih dahulu untuk caching
COPY "requirements.txt" .

# Install semua library yang dibutuhkan
RUN pip install --no-cache-dir -r requirements.txt

# Salin semua folder proyek ke dalam direktori kerja di container
COPY . .

# Perintah ini tidak dieksekusi langsung, tapi bisa digunakan sebagai default
CMD ["echo", "Image aplikasi siap digunakan. Jalankan dengan docker-compose."]