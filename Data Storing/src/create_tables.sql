-- Hapus tabel jika sudah ada
DROP TABLE IF EXISTS Laptop_Score CASCADE;
DROP TABLE IF EXISTS Laptop_Image CASCADE;
DROP TABLE IF EXISTS Laptop_Configuration CASCADE;
DROP TABLE IF EXISTS GPU CASCADE;
DROP TABLE IF EXISTS CPU CASCADE;
DROP TABLE IF EXISTS GPU_Performance CASCADE;
DROP TABLE IF EXISTS CPU_Performance CASCADE;
DROP TABLE IF EXISTS Laptop CASCADE;
DROP TABLE IF EXISTS Laptop_Detailed_Spec CASCADE;
DROP TABLE IF EXISTS Ports_Connectivity CASCADE;
DROP TABLE IF EXISTS Features CASCADE;

-- Table: Features
CREATE TABLE Features (
    feature_id SERIAL PRIMARY KEY,
    fingerprint_reader VARCHAR(50),
    web_camera TEXT,
    backlit_keyboard VARCHAR(50),
    microphone TEXT,
    speakers TEXT,
    security_lock_slot VARCHAR(50)
);

-- Table: Ports_Connectivity
CREATE TABLE Ports_Connectivity (
    port_id SERIAL PRIMARY KEY,
    usb_type_a TEXT,
    usb_type_c TEXT,
    hdmi VARCHAR(50),
    card_reader VARCHAR(50),
    ethernet_lan VARCHAR(50),
    wifi VARCHAR(50),
    bluetooth REAL,
    audio_jack TEXT
);

-- Table: Laptop 
CREATE TABLE Laptop (
    laptop_id SERIAL PRIMARY KEY,
    rank INT,
    laptop_name VARCHAR(50),
    detail_url TEXT,
    screen_size REAL,
    resolution VARCHAR(50),
    display_type VARCHAR(20),
    panel_info TEXT,
    color REAL,
    max_brightness INT,
    contrast VARCHAR(20),
    dci_p3 REAL,
    eye_safety VARCHAR(20)
);

-- Table: Laptop_Score
CREATE TABLE Laptop_Score (
    score_id SERIAL PRIMARY KEY,
    color_score VARCHAR(20),
    max_brightness_score VARCHAR(20),
    contrast_score VARCHAR(20),
    dci_p3_score VARCHAR(20),
    eye_safety_score VARCHAR(20),
    laptop_id INT REFERENCES Laptop(laptop_id)
);

-- Table: Laptop_Detailed_Spec
CREATE TABLE Laptop_Detailed_Spec (
    detail_id SERIAL PRIMARY KEY,
    storage_spec TEXT,
    storage_type TEXT,
    ram_spec TEXT,
    battery TEXT,
    body_material TEXT,
    dimensions TEXT,
    weight VARCHAR(50),
    feature_id INT REFERENCES Features(feature_id),
    port_id INT REFERENCES Ports_Connectivity(port_id),
    laptop_id INT REFERENCES Laptop(laptop_id)
);

-- Table: CPU
CREATE TABLE CPU (
    cpu_id SERIAL PRIMARY KEY,
    cpu_name VARCHAR(100),
    laptop_id INT REFERENCES Laptop(laptop_id)
);

-- Table: CPU_Performance
CREATE TABLE CPU_Performance (
    cpu_perf_id SERIAL PRIMARY KEY,
    cpu_url TEXT,
    cpu_benchmark_score INT,
    cpu_performance_percentage REAL,
    cpu_performance_ranking INT,
    cpu_id INT REFERENCES CPU(cpu_id)
);

-- Table: GPU
CREATE TABLE GPU (
    gpu_id SERIAL PRIMARY KEY,
    gpu_name VARCHAR(100),
    laptop_id INT REFERENCES Laptop(laptop_id)
);

-- Table: GPU_Performance
CREATE TABLE GPU_Performance (
    gpu_perf_id SERIAL PRIMARY KEY,
    gpu_url TEXT,
    gpu_benchmark_score INT,
    gpu_performance_percentage REAL,
    gpu_performance_ranking INT,
    gpu_id INT REFERENCES GPU(gpu_id)
);

-- Table: Laptop_Configuration
CREATE TABLE Laptop_Configuration (
    config_id SERIAL PRIMARY KEY,
    config_laptop_name VARCHAR(50),
    configuration_ranking INT,
    ram INT,
    storage INT,
    os TEXT,
    price NUMERIC(10,2),
    review_url TEXT,
    amazon_url TEXT,
    laptop_specs_url TEXT,
    laptop_id INT REFERENCES Laptop(laptop_id),
    gpu_id INT REFERENCES GPU(gpu_id),
    cpu_id INT REFERENCES CPU(cpu_id)
);

-- Table: Laptop_Image
CREATE TABLE Laptop_Image (
    laptop_id INT REFERENCES Laptop(laptop_id),
    image_url TEXT,
    PRIMARY KEY (laptop_id, image_url)
);


-- Menambahkan Index untuk meningkatkan performa
CREATE INDEX idx_laptop_rank ON Laptop(rank);
CREATE INDEX idx_laptop_name ON Laptop(laptop_name);
CREATE INDEX idx_laptop_score_laptop_id ON Laptop_Score(laptop_id);
CREATE INDEX idx_cpu_name ON CPU(cpu_name);
CREATE INDEX idx_gpu_name ON GPU(gpu_name);
CREATE INDEX idx_config_ranking ON Laptop_Configuration(configuration_ranking);

-- Menambahkan comment untuk dokumentasi
COMMENT ON TABLE Features IS 'Fitur dalam laptop';
COMMENT ON TABLE Ports_Connectivity IS 'Port dan opsi konektivitas';
COMMENT ON TABLE Laptop_Detailed_Spec IS 'Spesifikasi laptop';
COMMENT ON TABLE Laptop IS 'Informasi utama laptop dari Top 100 Laptops with the Best Screens';
COMMENT ON TABLE Laptop_Score IS 'Skor dan rating layar laptop';
COMMENT ON TABLE CPU_Performance IS 'performa CPU';
COMMENT ON TABLE CPU IS 'Informasi CPU dari laptop';
COMMENT ON TABLE GPU_Performance IS 'performa GPU';
COMMENT ON TABLE GPU IS 'Informasi GPU dari laptop';
COMMENT ON TABLE Laptop_Configuration IS 'Konfigurasi laptop';
COMMENT ON TABLE Laptop_Image IS 'Gambar produk laptop';