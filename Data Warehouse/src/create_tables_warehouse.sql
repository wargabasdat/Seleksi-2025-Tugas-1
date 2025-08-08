-- Table: dim_laptop
CREATE TABLE dim_laptop (
    laptop_id INT PRIMARY KEY,
    laptop_name VARCHAR(50),
    start_price NUMERIC(10,2)
);

-- Table: dim_cpu
CREATE TABLE dim_cpu (
    cpu_id INT PRIMARY KEY,
    cpu_name VARCHAR(100),
    cpu_rank INT
);

-- Table: dim_gpu
CREATE TABLE dim_gpu (
    gpu_id INT PRIMARY KEY,
    gpu_name VARCHAR(100),
    gpu_rank INT
);

-- Table: dim_config
CREATE TABLE dim_config (
    config_id INT PRIMARY KEY,
    ram_size INT,
    storage_size INT,
    operating_system TEXT
);

-- Table: fact_laptop_performance
CREATE TABLE fact_laptop_performance (
    laptop_id INT REFERENCES dim_laptop(laptop_id),
    cpu_id INT REFERENCES dim_cpu(cpu_id),
    gpu_id INT REFERENCES dim_gpu(gpu_id),
    config_id INT REFERENCES dim_config(config_id),
    color_score VARCHAR(20),
    brightness_score VARCHAR(20),
    contrast_score VARCHAR(20),
    dci_p3_score VARCHAR(20),
    eye_safety_score VARCHAR(20),
    cpu_benchmark_score INT,
    total_score VARCHAR(20),
    laptop_ranking INT,
    PRIMARY KEY (laptop_id, cpu_id, gpu_id, config_id)
);


-- Index

CREATE INDEX idx_fact_laptop ON fact_laptop_performance(laptop_id);
CREATE INDEX idx_fact_cpu ON fact_laptop_performance(cpu_id);
CREATE INDEX idx_fact_gpu ON fact_laptop_performance(gpu_id);