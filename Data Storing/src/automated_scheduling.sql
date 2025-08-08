-- AUTOMATED SCHEDULING 
-- Pastikan semua tabel utama memiliki kolom last_updated
ALTER TABLE Laptop ADD COLUMN IF NOT EXISTS last_updated TIMESTAMP;
ALTER TABLE CPU ADD COLUMN IF NOT EXISTS last_updated TIMESTAMP;
ALTER TABLE GPU ADD COLUMN IF NOT EXISTS last_updated TIMESTAMP;
ALTER TABLE Features ADD COLUMN IF NOT EXISTS last_updated TIMESTAMP;
ALTER TABLE Ports_Connectivity ADD COLUMN IF NOT EXISTS last_updated TIMESTAMP;
ALTER TABLE Laptop_Score ADD COLUMN IF NOT EXISTS last_updated TIMESTAMP;
ALTER TABLE Laptop_Detailed_Spec ADD COLUMN IF NOT EXISTS last_updated TIMESTAMP;
ALTER TABLE Laptop_Configuration ADD COLUMN IF NOT EXISTS last_updated TIMESTAMP;
ALTER TABLE Laptop_Image ADD COLUMN IF NOT EXISTS last_updated TIMESTAMP;
ALTER TABLE CPU_Performance ADD COLUMN IF NOT EXISTS last_updated TIMESTAMP;
ALTER TABLE GPU_Performance ADD COLUMN IF NOT EXISTS last_updated TIMESTAMP;

-- 1. Tabel extraction_log
CREATE TABLE extraction_log (
    log_id SERIAL PRIMARY KEY,
    table_name VARCHAR(50),
    record_id INT,
    operation_type VARCHAR(20) DEFAULT 'INSERT',
    extraction_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Membuat Fungsi Trigger untuk Mencatat Timestamp 
CREATE OR REPLACE FUNCTION log_extraction_timestamp() 
RETURNS trigger AS $$
BEGIN
    IF TG_TABLE_NAME = 'laptop' THEN
        INSERT INTO extraction_log (table_name, record_id, operation_type, extraction_timestamp)
        VALUES ('Laptop', NEW.laptop_id, TG_OP, CURRENT_TIMESTAMP);
    ELSIF TG_TABLE_NAME = 'cpu' THEN
        INSERT INTO extraction_log (table_name, record_id, operation_type, extraction_timestamp)
        VALUES ('CPU', NEW.cpu_id, TG_OP, CURRENT_TIMESTAMP);
    ELSIF TG_TABLE_NAME = 'gpu' THEN
        INSERT INTO extraction_log (table_name, record_id, operation_type, extraction_timestamp)
        VALUES ('GPU', NEW.gpu_id, TG_OP, CURRENT_TIMESTAMP);
    ELSIF TG_TABLE_NAME = 'features' THEN
        INSERT INTO extraction_log (table_name, record_id, operation_type, extraction_timestamp)
        VALUES ('Features', NEW.feature_id, TG_OP, CURRENT_TIMESTAMP);
    ELSIF TG_TABLE_NAME = 'ports_connectivity' THEN
        INSERT INTO extraction_log (table_name, record_id, operation_type, extraction_timestamp)
        VALUES ('Ports_Connectivity', NEW.port_id, TG_OP, CURRENT_TIMESTAMP);
    ELSIF TG_TABLE_NAME = 'laptop_score' THEN
        INSERT INTO extraction_log (table_name, record_id, operation_type, extraction_timestamp)
        VALUES ('Laptop_Score', NEW.score_id, TG_OP, CURRENT_TIMESTAMP);
    ELSIF TG_TABLE_NAME = 'laptop_detailed_spec' THEN
        INSERT INTO extraction_log (table_name, record_id, operation_type, extraction_timestamp)
        VALUES ('Laptop_Detailed_Spec', NEW.detail_id, TG_OP, CURRENT_TIMESTAMP);
    ELSIF TG_TABLE_NAME = 'laptop_configuration' THEN
        INSERT INTO extraction_log (table_name, record_id, operation_type, extraction_timestamp)
        VALUES ('Laptop_Configuration', NEW.config_id, TG_OP, CURRENT_TIMESTAMP);
    ELSIF TG_TABLE_NAME = 'laptop_image' THEN
        INSERT INTO extraction_log (table_name, record_id, operation_type, extraction_timestamp)
        VALUES ('Laptop_Image', NEW.laptop_id, TG_OP, CURRENT_TIMESTAMP);
    ELSIF TG_TABLE_NAME = 'cpu_performance' THEN
        INSERT INTO extraction_log (table_name, record_id, operation_type, extraction_timestamp)
        VALUES ('CPU_Performance', NEW.cpu_perf_id, TG_OP, CURRENT_TIMESTAMP);
    ELSIF TG_TABLE_NAME = 'gpu_performance' THEN
        INSERT INTO extraction_log (table_name, record_id, operation_type, extraction_timestamp)
        VALUES ('GPU_Performance', NEW.gpu_perf_id, TG_OP, CURRENT_TIMESTAMP);
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- 4. Buat Trigger 
-- Laptop
CREATE TRIGGER log_laptop_trigger
AFTER INSERT ON Laptop
FOR EACH ROW
EXECUTE FUNCTION log_extraction_timestamp();

-- CPU
CREATE TRIGGER log_cpu_trigger
AFTER INSERT ON CPU
FOR EACH ROW
EXECUTE FUNCTION log_extraction_timestamp();

-- GPU
CREATE TRIGGER log_gpu_trigger
AFTER INSERT ON GPU
FOR EACH ROW
EXECUTE FUNCTION log_extraction_timestamp();

-- Features
CREATE TRIGGER log_features_trigger
AFTER INSERT ON Features
FOR EACH ROW
EXECUTE FUNCTION log_extraction_timestamp();

-- Ports_Connectivity
CREATE TRIGGER log_ports_trigger
AFTER INSERT ON Ports_Connectivity
FOR EACH ROW
EXECUTE FUNCTION log_extraction_timestamp();

-- Laptop_Score
CREATE TRIGGER log_score_trigger
AFTER INSERT ON Laptop_Score
FOR EACH ROW
EXECUTE FUNCTION log_extraction_timestamp();

-- Laptop_Detailed_Spec
CREATE TRIGGER log_spec_trigger
AFTER INSERT ON Laptop_Detailed_Spec
FOR EACH ROW
EXECUTE FUNCTION log_extraction_timestamp();

-- Laptop_Configuration
CREATE TRIGGER log_config_trigger
AFTER INSERT ON Laptop_Configuration
FOR EACH ROW
EXECUTE FUNCTION log_extraction_timestamp();

-- Laptop_Image
CREATE TRIGGER log_image_trigger
AFTER INSERT ON Laptop_Image
FOR EACH ROW
EXECUTE FUNCTION log_extraction_timestamp();

-- CPU_Performance
CREATE TRIGGER log_cpu_perf_trigger
AFTER INSERT ON CPU_Performance
FOR EACH ROW
EXECUTE FUNCTION log_extraction_timestamp();

-- GPU_Performance
CREATE TRIGGER log_gpu_perf_trigger
AFTER INSERT ON GPU_Performance
FOR EACH ROW
EXECUTE FUNCTION log_extraction_timestamp();

-- 5. Buat Fungsi Ekstraksi Data Otomatis
CREATE OR REPLACE FUNCTION extract_and_update_data() 
RETURNS void AS $$
BEGIN
    -- Laptop
    INSERT INTO Laptop (laptop_id, rank, laptop_name, detail_url, screen_size, resolution, display_type, panel_info, color, max_brightness, contrast, dci_p3, eye_safety, last_updated)
    VALUES 
        (99901, 101, 'Apple MacBook Pro M3', NULL, 16.0, '3456x2234', 'IPS', NULL, NULL, NULL, NULL, NULL, NULL, NOW()),
        (99902, 102, 'Dell XPS 13 Plus', NULL, 13.4, '3840x2400', 'OLED', NULL, NULL, NULL, NULL, NULL, NULL, NOW()),
        (99903, 103, 'HP Spectre x360', NULL, 13.5, '3000x2000', 'IPS', NULL, NULL, NULL, NULL, NULL, NULL, NOW());

    -- CPU
    INSERT INTO CPU (cpu_id, cpu_name, laptop_id, last_updated)
    VALUES 
        (99701, 'Apple M3 Pro', 99901, NOW()),
        (99702, 'Intel Core i7-1360P', 99902, NOW()),
        (99703, 'Intel Core i7-1255U', 99903, NOW());

    -- GPU
    INSERT INTO GPU (gpu_id, gpu_name, laptop_id, last_updated)
    VALUES 
        (99801, 'Apple M3 Pro GPU', 99901, NOW()),
        (99802, 'Intel Iris Xe Graphics', 99902, NOW()),
        (99803, 'Intel Iris Xe Graphics', 99903, NOW());

    -- Features
    INSERT INTO Features (feature_id, fingerprint_reader, web_camera, backlit_keyboard, microphone, speakers, security_lock_slot, last_updated)
    VALUES 
        (99601, 'TRUE', 'FaceTime HD', 'TRUE', 'Studio-quality', 'Six-speaker system', 'FALSE', NOW()),
        (99602, 'TRUE', 'FHD IR Camera', 'TRUE', 'Dual microphone', 'Quad speakers', 'TRUE', NOW()),
        (99603, 'TRUE', 'HD IR Camera', 'TRUE', 'Dual microphone', 'Bang & Olufsen', 'TRUE', NOW());

    -- Ports_Connectivity
    INSERT INTO Ports_Connectivity (port_id, usb_type_a, usb_type_c, hdmi, card_reader, ethernet_lan, wifi, bluetooth, audio_jack, last_updated)
    VALUES 
        (99501, NULL, '3x Thunderbolt 4', 'No', 'SDXC', NULL, 'Wi-Fi 6E', 5.3, '3.5mm', NOW()),
        (99502, NULL, '2x Thunderbolt 4', 'No', 'No', NULL, 'Wi-Fi 6E', 5.2, 'No', NOW()),
        (99503, NULL, '2x Thunderbolt 4', 'No', 'microSD', NULL, 'Wi-Fi 6E', 5.3, '3.5mm', NOW());

    -- Laptop_Score
    INSERT INTO Laptop_Score (score_id, color_score, max_brightness_score, contrast_score, dci_p3_score, eye_safety_score, laptop_id, last_updated)
    VALUES 
        (99401, '95.5', '88.2', '92.1', '98.7', '85.3', 99901, NOW()),
        (99402, '92.8', '94.5', '89.3', '95.2', '82.7', 99902, NOW()),
        (99403, '88.9', '86.7', '85.4', '91.8', '84.1', 99903, NOW());

    -- Laptop_Detailed_Spec
    INSERT INTO Laptop_Detailed_Spec (detail_id, storage_spec, storage_type, ram_spec, battery, body_material, dimensions, weight, feature_id, port_id, laptop_id, last_updated)
    VALUES 
        (99301, '512GB', 'SSD', '18GB Unified Memory', '70Wh', 'Aluminum', '35.57×24.81×1.68 cm', '2.14 kg', 99601, 99501, 99901, NOW()),
        (99302, '512GB', 'SSD', '16GB LPDDR5', '55Wh', 'CNC Aluminum', '29.57×19.91×1.57 cm', '1.24 kg', 99602, 99502, 99902, NOW()),
        (99303, '512GB', 'SSD', '16GB LPDDR4x', '66Wh', 'CNC Aluminum', '30.12×21.94×1.69 cm', '1.34 kg', 99603, 99503, 99903, NOW());

    -- Laptop_Configuration
    INSERT INTO Laptop_Configuration (config_id, config_laptop_name, configuration_ranking, ram, storage, os, price, review_url, amazon_url, laptop_specs_url, laptop_id, gpu_id, cpu_id, last_updated)
    VALUES 
        (99201, 'Apple MacBook Pro M3', 101, NULL, NULL, 'macOS Sonoma', NULL, 'https://review.com/macbook-m3', 'https://amazon.com/macbook-m3', 'https://specs.com/macbook-m3', 99901, 99801, 99701, NOW()),
        (99202, 'Dell XPS 13 Plus', 102, NULL, NULL, 'Windows 11 Pro', NULL, 'https://review.com/dell-xps13', 'https://amazon.com/dell-xps13', 'https://specs.com/dell-xps13', 99902, 99802, 99702, NOW()),
        (99203, 'HP Spectre x360', 103, NULL, NULL, 'Windows 11 Home', NULL, 'https://review.com/hp-spectre', 'https://amazon.com/hp-spectre', 'https://specs.com/hp-spectre', 99903, 99803, 99703, NOW());

    -- Laptop_Image
    INSERT INTO Laptop_Image (laptop_id, image_url, last_updated)
    VALUES 
        (99901, 'https://images.com/macbook-m3-1.jpg', NOW()),
        (99901, 'https://images.com/macbook-m3-2.jpg', NOW()),
        (99902, 'https://images.com/dell-xps13-1.jpg', NOW()),
        (99902, 'https://images.com/dell-xps13-2.jpg', NOW()),
        (99903, 'https://images.com/hp-spectre-1.jpg', NOW()),
        (99903, 'https://images.com/hp-spectre-2.jpg', NOW());

    -- CPU_Performance
    INSERT INTO CPU_Performance (cpu_perf_id, cpu_url, cpu_benchmark_score, cpu_performance_percentage, cpu_performance_ranking, cpu_id, last_updated)
    VALUES 
        (99101, 'https://benchmark.com/apple-m3-pro', 28500, 95.8, 15, 99701, NOW()),
        (99102, 'https://benchmark.com/intel-i7-1360p', 22400, 82.3, 45, 99702, NOW()),
        (99103, 'https://benchmark.com/intel-i7-1255u', 19800, 75.6, 78, 99703, NOW());

    -- GPU_Performance
    INSERT INTO GPU_Performance (gpu_perf_id, gpu_url, gpu_benchmark_score, gpu_performance_percentage, gpu_performance_ranking, gpu_id, last_updated)
    VALUES 
        (99001, 'https://gpu-benchmark.com/apple-m3-pro', 18500, 88.7, 25, 99801, NOW()),
        (99002, 'https://gpu-benchmark.com/intel-iris-xe-1360p', 8400, 45.2, 156, 99802, NOW()),
        (99003, 'https://gpu-benchmark.com/intel-iris-xe-1255u', 7800, 42.1, 178, 99803, NOW());
    
END;
$$ LANGUAGE plpgsql;

-- Fungsi untuk Update Semua Tabel 
CREATE OR REPLACE FUNCTION automated_all_tables_update()
RETURNS TEXT AS $$
DECLARE
    start_time TIMESTAMP;
    end_time TIMESTAMP;
    total_updated INT := 0;
    table_stats RECORD;
    update_summary TEXT := '';
BEGIN
    start_time := NOW();
    
    -- 1. Update tabel Features
    UPDATE Features 
    SET last_updated = NOW()
    WHERE last_updated < NOW() - INTERVAL '1 hour';
    GET DIAGNOSTICS table_stats.row_count = ROW_COUNT;
    total_updated := total_updated + table_stats.row_count;
    update_summary := update_summary || 'Features: ' || table_stats.row_count || ' baris; ';
    
    -- 2. Update tabel Ports_Connectivity
    UPDATE Ports_Connectivity 
    SET last_updated = NOW()
    WHERE last_updated < NOW() - INTERVAL '1 hour';
    GET DIAGNOSTICS table_stats.row_count = ROW_COUNT;
    total_updated := total_updated + table_stats.row_count;
    update_summary := update_summary || 'Ports: ' || table_stats.row_count || ' baris; ';
    
    -- 3. Update tabel Laptop
    UPDATE Laptop 
    SET last_updated = NOW()
    WHERE last_updated < NOW() - INTERVAL '1 hour';
    GET DIAGNOSTICS table_stats.row_count = ROW_COUNT;
    total_updated := total_updated + table_stats.row_count;
    update_summary := update_summary || 'Laptop: ' || table_stats.row_count || ' baris; ';
    
    -- 4. Update tabel Laptop_Score
    UPDATE Laptop_Score 
    SET last_updated = NOW()
    WHERE last_updated < NOW() - INTERVAL '1 hour';
    GET DIAGNOSTICS table_stats.row_count = ROW_COUNT;
    total_updated := total_updated + table_stats.row_count;
    update_summary := update_summary || 'Laptop_Score: ' || table_stats.row_count || ' baris; ';
    
    -- 5. Update tabel Laptop_Detailed_Spec
    UPDATE Laptop_Detailed_Spec 
    SET last_updated = NOW()
    WHERE last_updated < NOW() - INTERVAL '1 hour';
    GET DIAGNOSTICS table_stats.row_count = ROW_COUNT;
    total_updated := total_updated + table_stats.row_count;
    update_summary := update_summary || 'Detailed_Spec: ' || table_stats.row_count || ' baris; ';
    
    -- 6. Update tabel CPU
    UPDATE CPU 
    SET last_updated = NOW()
    WHERE last_updated < NOW() - INTERVAL '1 hour';
    GET DIAGNOSTICS table_stats.row_count = ROW_COUNT;
    total_updated := total_updated + table_stats.row_count;
    update_summary := update_summary || 'CPU: ' || table_stats.row_count || ' baris; ';
    
    -- 7. Update tabel CPU_Performance
    UPDATE CPU_Performance 
    SET last_updated = NOW()
    WHERE last_updated < NOW() - INTERVAL '1 hour';
    GET DIAGNOSTICS table_stats.row_count = ROW_COUNT;
    total_updated := total_updated + table_stats.row_count;
    update_summary := update_summary || 'CPU_Performance: ' || table_stats.row_count || ' baris; ';
    
    -- 8. Update tabel GPU
    UPDATE GPU 
    SET last_updated = NOW()
    WHERE last_updated < NOW() - INTERVAL '1 hour';
    GET DIAGNOSTICS table_stats.row_count = ROW_COUNT;
    total_updated := total_updated + table_stats.row_count;
    update_summary := update_summary || 'GPU: ' || table_stats.row_count || ' baris; ';
    
    -- 9. Update tabel GPU_Performance
    UPDATE GPU_Performance 
    SET last_updated = NOW()
    WHERE last_updated < NOW() - INTERVAL '1 hour';
    GET DIAGNOSTICS table_stats.row_count = ROW_COUNT;
    total_updated := total_updated + table_stats.row_count;
    update_summary := update_summary || 'GPU_Performance: ' || table_stats.row_count || ' baris; ';
    
    -- 10. Update tabel Laptop_Configuration
    UPDATE Laptop_Configuration 
    SET last_updated = NOW()
    WHERE last_updated < NOW() - INTERVAL '1 hour';
    GET DIAGNOSTICS table_stats.row_count = ROW_COUNT;
    total_updated := total_updated + table_stats.row_count;
    update_summary := update_summary || 'Configuration: ' || table_stats.row_count || ' baris; ';
    
    -- 11. Update tabel Laptop_Image
    UPDATE Laptop_Image 
    SET last_updated = NOW()
    WHERE last_updated < NOW() - INTERVAL '1 hour';
    GET DIAGNOSTICS table_stats.row_count = ROW_COUNT;
    total_updated := total_updated + table_stats.row_count;
    update_summary := update_summary || 'Images: ' || table_stats.row_count || ' baris; ';
    
    end_time := NOW();
    
    RETURN 'Update SEMUA TABEL selesai dalam ' || 
           EXTRACT(EPOCH FROM (end_time - start_time)) || ' detik. Updated ' || 
           total_updated || ' total record: ' || update_summary;
    
EXCEPTION WHEN OTHERS THEN
    RETURN 'Error dalam update SEMUA TABEL: ' || SQLERRM;
END;
$$ LANGUAGE plpgsql;

-- Fungsi untuk Mencegah Redundansi Data di Semua Tabel
CREATE OR REPLACE FUNCTION check_all_tables_redundancy()
RETURNS TEXT AS $$
DECLARE
    result_summary TEXT := '';
    duplicate_count INT;
    cleaned_count INT;
BEGIN
    -- Cek dan bersihkan redundansi untuk setiap tabel
    
    -- 1. Tabel Laptop (pengecekan utama)
    SELECT COUNT(*) INTO duplicate_count
    FROM (
        SELECT laptop_name, rank, COUNT(*) as cnt
        FROM Laptop 
        GROUP BY laptop_name, rank 
        HAVING COUNT(*) > 1
    ) duplicates;
    
    IF duplicate_count > 0 THEN
        DELETE FROM Laptop a 
        USING Laptop b 
        WHERE a.laptop_id < b.laptop_id 
          AND a.laptop_name = b.laptop_name 
          AND a.rank = b.rank;
        GET DIAGNOSTICS cleaned_count = ROW_COUNT;
        result_summary := result_summary || 'Laptop: menghapus ' || cleaned_count || ' duplikat; ';
    END IF;
    
    -- 2. Tabel CPU
    SELECT COUNT(*) INTO duplicate_count
    FROM (
        SELECT cpu_name, laptop_id, COUNT(*) as cnt
        FROM CPU 
        GROUP BY cpu_name, laptop_id 
        HAVING COUNT(*) > 1
    ) duplicates;
    
    IF duplicate_count > 0 THEN
        DELETE FROM CPU a 
        USING CPU b 
        WHERE a.cpu_id < b.cpu_id 
          AND a.cpu_name = b.cpu_name 
          AND a.laptop_id = b.laptop_id;
        GET DIAGNOSTICS cleaned_count = ROW_COUNT;
        result_summary := result_summary || 'CPU: menghapus ' || cleaned_count || ' duplikat; ';
    END IF;
    
    -- 3. Tabel GPU
    SELECT COUNT(*) INTO duplicate_count
    FROM (
        SELECT gpu_name, laptop_id, COUNT(*) as cnt
        FROM GPU 
        GROUP BY gpu_name, laptop_id 
        HAVING COUNT(*) > 1
    ) duplicates;
    
    IF duplicate_count > 0 THEN
        DELETE FROM GPU a 
        USING GPU b 
        WHERE a.gpu_id < b.gpu_id 
          AND a.gpu_name = b.gpu_name 
          AND a.laptop_id = b.laptop_id;
        GET DIAGNOSTICS cleaned_count = ROW_COUNT;
        result_summary := result_summary || 'GPU: menghapus ' || cleaned_count || ' duplikat; ';
    END IF;
    
    -- 4. Tabel Configuration
    SELECT COUNT(*) INTO duplicate_count
    FROM (
        SELECT config_laptop_name, configuration_ranking, laptop_id, COUNT(*) as cnt
        FROM Laptop_Configuration 
        GROUP BY config_laptop_name, configuration_ranking, laptop_id 
        HAVING COUNT(*) > 1
    ) duplicates;
    
    IF duplicate_count > 0 THEN
        DELETE FROM Laptop_Configuration a 
        USING Laptop_Configuration b 
        WHERE a.config_id < b.config_id 
          AND a.config_laptop_name = b.config_laptop_name 
          AND a.configuration_ranking = b.configuration_ranking
          AND a.laptop_id = b.laptop_id;
        GET DIAGNOSTICS cleaned_count = ROW_COUNT;
        result_summary := result_summary || 'Configuration: menghapus ' || cleaned_count || ' duplikat; ';
    END IF;
    
    -- 5. Tabel Laptop_Image
    SELECT COUNT(*) INTO duplicate_count
    FROM (
        SELECT laptop_id, image_url, COUNT(*) as cnt
        FROM Laptop_Image 
        GROUP BY laptop_id, image_url 
        HAVING COUNT(*) > 1
    ) duplicates;
    
    IF duplicate_count > 0 THEN
        DELETE FROM Laptop_Image a 
        USING Laptop_Image b 
        WHERE a.ctid < b.ctid 
          AND a.laptop_id = b.laptop_id 
          AND a.image_url = b.image_url;
        GET DIAGNOSTICS cleaned_count = ROW_COUNT;
        result_summary := result_summary || 'Images: menghapus ' || cleaned_count || ' duplikat; ';
    END IF;
    
    -- 6. Tabel Features
    SELECT COUNT(*) INTO duplicate_count
    FROM (
        SELECT fingerprint_reader, web_camera, backlit_keyboard, microphone, speakers, security_lock_slot, COUNT(*) as cnt
        FROM Features 
        GROUP BY fingerprint_reader, web_camera, backlit_keyboard, microphone, speakers, security_lock_slot 
        HAVING COUNT(*) > 1
    ) duplicates;
    
    IF duplicate_count > 0 THEN
        DELETE FROM Features a 
        USING Features b 
        WHERE a.feature_id < b.feature_id 
          AND a.fingerprint_reader = b.fingerprint_reader 
          AND a.web_camera = b.web_camera
          AND a.backlit_keyboard = b.backlit_keyboard
          AND a.microphone = b.microphone
          AND a.speakers = b.speakers
          AND a.security_lock_slot = b.security_lock_slot;
        GET DIAGNOSTICS cleaned_count = ROW_COUNT;
        result_summary := result_summary || 'Features: menghapus ' || cleaned_count || ' duplikat; ';
    END IF;
    
    -- 7. Tabel Ports_Connectivity
    SELECT COUNT(*) INTO duplicate_count
    FROM (
        SELECT usb_type_c, hdmi, card_reader, ethernet_lan, wifi, bluetooth, audio_jack, COUNT(*) as cnt
        FROM Ports_Connectivity 
        GROUP BY usb_type_c, hdmi, card_reader, ethernet_lan, wifi, bluetooth, audio_jack 
        HAVING COUNT(*) > 1
    ) duplicates;
    
    IF duplicate_count > 0 THEN
        DELETE FROM Ports_Connectivity a 
        USING Ports_Connectivity b 
        WHERE a.port_id < b.port_id 
          AND a.usb_type_c = b.usb_type_c 
          AND a.hdmi = b.hdmi
          AND a.card_reader = b.card_reader
          AND a.ethernet_lan = b.ethernet_lan
          AND a.wifi = b.wifi
          AND a.bluetooth = b.bluetooth
          AND a.audio_jack = b.audio_jack;
        GET DIAGNOSTICS cleaned_count = ROW_COUNT;
        result_summary := result_summary || 'Ports: menghapus ' || cleaned_count || ' duplikat; ';
    END IF;
    
    -- 8. Tabel Laptop_Score
    SELECT COUNT(*) INTO duplicate_count
    FROM (
        SELECT laptop_id, color_score, max_brightness_score, contrast_score, dci_p3_score, eye_safety_score, COUNT(*) as cnt
        FROM Laptop_Score 
        GROUP BY laptop_id, color_score, max_brightness_score, contrast_score, dci_p3_score, eye_safety_score 
        HAVING COUNT(*) > 1
    ) duplicates;
    
    IF duplicate_count > 0 THEN
        DELETE FROM Laptop_Score a 
        USING Laptop_Score b 
        WHERE a.score_id < b.score_id 
          AND a.laptop_id = b.laptop_id 
          AND a.color_score = b.color_score
          AND a.max_brightness_score = b.max_brightness_score
          AND a.contrast_score = b.contrast_score
          AND a.dci_p3_score = b.dci_p3_score
          AND a.eye_safety_score = b.eye_safety_score;
        GET DIAGNOSTICS cleaned_count = ROW_COUNT;
        result_summary := result_summary || 'Laptop_Score: menghapus ' || cleaned_count || ' duplikat; ';
    END IF;
    
    -- 9. Tabel Laptop_Detailed_Spec
    SELECT COUNT(*) INTO duplicate_count
    FROM (
        SELECT laptop_id, storage_spec, storage_type, ram_spec, battery, body_material, dimensions, weight, COUNT(*) as cnt
        FROM Laptop_Detailed_Spec 
        GROUP BY laptop_id, storage_spec, storage_type, ram_spec, battery, body_material, dimensions, weight 
        HAVING COUNT(*) > 1
    ) duplicates;
    
    IF duplicate_count > 0 THEN
        DELETE FROM Laptop_Detailed_Spec a 
        USING Laptop_Detailed_Spec b 
        WHERE a.detail_id < b.detail_id 
          AND a.laptop_id = b.laptop_id 
          AND a.storage_spec = b.storage_spec
          AND a.storage_type = b.storage_type
          AND a.ram_spec = b.ram_spec
          AND a.battery = b.battery
          AND a.body_material = b.body_material
          AND a.dimensions = b.dimensions
          AND a.weight = b.weight;
        GET DIAGNOSTICS cleaned_count = ROW_COUNT;
        result_summary := result_summary || 'Detailed_Spec: menghapus ' || cleaned_count || ' duplikat; ';
    END IF;
    
    -- 10. Tabel CPU_Performance
    SELECT COUNT(*) INTO duplicate_count
    FROM (
        SELECT cpu_id, cpu_url, cpu_benchmark_score, cpu_performance_percentage, cpu_performance_ranking, COUNT(*) as cnt
        FROM CPU_Performance 
        GROUP BY cpu_id, cpu_url, cpu_benchmark_score, cpu_performance_percentage, cpu_performance_ranking 
        HAVING COUNT(*) > 1
    ) duplicates;
    
    IF duplicate_count > 0 THEN
        DELETE FROM CPU_Performance a 
        USING CPU_Performance b 
        WHERE a.cpu_perf_id < b.cpu_perf_id 
          AND a.cpu_id = b.cpu_id 
          AND a.cpu_url = b.cpu_url
          AND a.cpu_benchmark_score = b.cpu_benchmark_score
          AND a.cpu_performance_percentage = b.cpu_performance_percentage
          AND a.cpu_performance_ranking = b.cpu_performance_ranking;
        GET DIAGNOSTICS cleaned_count = ROW_COUNT;
        result_summary := result_summary || 'CPU_Performance: menghapus ' || cleaned_count || ' duplikat; ';
    END IF;
    
    -- 11. Tabel GPU_Performance
    SELECT COUNT(*) INTO duplicate_count
    FROM (
        SELECT gpu_id, gpu_url, gpu_benchmark_score, gpu_performance_percentage, gpu_performance_ranking, COUNT(*) as cnt
        FROM GPU_Performance 
        GROUP BY gpu_id, gpu_url, gpu_benchmark_score, gpu_performance_percentage, gpu_performance_ranking 
        HAVING COUNT(*) > 1
    ) duplicates;
    
    IF duplicate_count > 0 THEN
        DELETE FROM GPU_Performance a 
        USING GPU_Performance b 
        WHERE a.gpu_perf_id < b.gpu_perf_id 
          AND a.gpu_id = b.gpu_id 
          AND a.gpu_url = b.gpu_url
          AND a.gpu_benchmark_score = b.gpu_benchmark_score
          AND a.gpu_performance_percentage = b.gpu_performance_percentage
          AND a.gpu_performance_ranking = b.gpu_performance_ranking;
        GET DIAGNOSTICS cleaned_count = ROW_COUNT;
        result_summary := result_summary || 'GPU_Performance: menghapus ' || cleaned_count || ' duplikat; ';
    END IF;
    
    IF result_summary = '' THEN
        result_summary := 'Tidak ada duplikat ditemukan di tabel manapun';
    END IF;
    
    RETURN 'Pengecekan redundansi selesai: ' || result_summary;
END;
$$ LANGUAGE plpgsql;


