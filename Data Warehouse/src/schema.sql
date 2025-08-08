DROP TABLE IF EXISTS fact_catalog CASCADE;
DROP TABLE IF EXISTS dim_products CASCADE;
DROP TABLE IF EXISTS dim_categories CASCADE;
DROP TABLE IF EXISTS dim_variants CASCADE;
DROP TABLE IF EXISTS dim_measurements CASCADE;
DROP TABLE IF EXISTS dim_discounts CASCADE;

CREATE TABLE dim_products (
    product_id VARCHAR PRIMARY KEY,
    name TEXT,
    material TEXT,
    description TEXT
);

CREATE TABLE dim_categories (
    category_id VARCHAR PRIMARY KEY,
    name TEXT
);

CREATE TABLE dim_variants (
    variant_id VARCHAR PRIMARY KEY,
    product_id VARCHAR,
    size TEXT,
    color TEXT,
    status TEXT,
    FOREIGN KEY (product_id) REFERENCES dim_products(product_id)
);

CREATE TABLE dim_measurements (
    measurement_id VARCHAR PRIMARY KEY,
    product_id VARCHAR,
    size_name TEXT,
    detail TEXT,
    FOREIGN KEY (product_id) REFERENCES dim_products(product_id)
);

CREATE TABLE dim_discounts (
    product_id VARCHAR PRIMARY KEY,
    normal_price INTEGER,
    discount_price INTEGER,
    FOREIGN KEY (product_id) REFERENCES dim_products(product_id)
);

CREATE TABLE fact_catalog (
    product_id VARCHAR,
    category_id VARCHAR,
    price INTEGER,
    variant_id VARCHAR,
    measurement_id VARCHAR,
    discount_applied BOOLEAN,
    FOREIGN KEY (product_id) REFERENCES dim_products(product_id),
    FOREIGN KEY (category_id) REFERENCES dim_categories(category_id),
    FOREIGN KEY (variant_id) REFERENCES dim_variants(variant_id),
    FOREIGN KEY (measurement_id) REFERENCES dim_measurements(measurement_id)
);