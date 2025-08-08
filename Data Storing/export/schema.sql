-- ====================================================================
-- Skema Database Blox Fruits
-- RDBMS: PostgreSQL
-- ====================================================================

-- Hapus tabel jika sudah ada untuk memastikan skema yang bersih
DROP TABLE IF EXISTS stock_item;
DROP TABLE IF EXISTS stock_event;
DROP TABLE IF EXISTS update_item;
DROP TABLE IF EXISTS ability;
DROP TABLE IF EXISTS sword;
DROP TABLE IF EXISTS gun;
DROP TABLE IF EXISTS fruit;
DROP TABLE IF EXISTS equipment;
DROP TABLE IF EXISTS update;

-- ====================================================================
-- Tabel Utama
-- ====================================================================

CREATE TABLE update (
    update_id VARCHAR(255) PRIMARY KEY,
    update_title VARCHAR(255) NOT NULL,
    release_date VARCHAR(255),
    timestamp TIMESTAMP
);

CREATE TABLE equipment (
    equipment_id VARCHAR(255) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    url TEXT,
    timestamp TIMESTAMP,
    type VARCHAR(100),
    rarity VARCHAR(100),
    release_date VARCHAR(255) -- Bisa jadi foreign key ke 'update' jika formatnya konsisten
);

CREATE TABLE stock_event (
    stock_event_id VARCHAR(255) PRIMARY KEY,
    timestamp TIMESTAMP,
    stock_start_time VARCHAR(255)
);

-- ====================================================================
-- Tabel Spesialisasi Equipment (ISA)
-- ====================================================================

CREATE TABLE fruit (
    equipment_id VARCHAR(255) PRIMARY KEY REFERENCES equipment(equipment_id) ON DELETE CASCADE,
    fruit_type VARCHAR(100),
    money_price INTEGER,
    robux_price INTEGER,
    can_m1 VARCHAR(10),
    fruit_value INTEGER,
    fruit_demand INTEGER,
    fruit_status VARCHAR(255)
);

CREATE TABLE sword (
    equipment_id VARCHAR(255) PRIMARY KEY REFERENCES equipment(equipment_id) ON DELETE CASCADE
);

CREATE TABLE gun (
    equipment_id VARCHAR(255) PRIMARY KEY REFERENCES equipment(equipment_id) ON DELETE CASCADE
);


-- ====================================================================
-- Tabel Relasi
-- ====================================================================

CREATE TABLE ability (
    ability_id SERIAL PRIMARY KEY,
    equipment_id VARCHAR(255) NOT NULL REFERENCES equipment(equipment_id) ON DELETE CASCADE,
    ability_name VARCHAR(255),
    keybind VARCHAR(50),
    mastery_cost VARCHAR(50),
    fragment_cost INT
);

CREATE TABLE update_item (
    change_history_id SERIAL PRIMARY KEY,
    update_id VARCHAR(255) NOT NULL REFERENCES update(update_id) ON DELETE CASCADE,
    equipment_id VARCHAR(255) NOT NULL REFERENCES equipment(equipment_id) ON DELETE CASCADE,
    change TEXT
);

CREATE TABLE stock_item (
    stock_event_id VARCHAR(255) NOT NULL REFERENCES stock_event(stock_event_id) ON DELETE CASCADE,
    fruit_id VARCHAR(255) NOT NULL REFERENCES fruit(equipment_id) ON DELETE CASCADE,
    -- Menggunakan nama 'fruit_id' agar sesuai ERD, merujuk ke equipment_id di tabel fruit
    PRIMARY KEY (stock_event_id, fruit_id)
);

-- Menambahkan indeks untuk foreign key agar query lebih cepat
CREATE INDEX ON ability (equipment_id);
CREATE INDEX ON update_item (equipment_id);
CREATE INDEX ON update_item (update_id);
CREATE INDEX ON stock_item (fruit_id);