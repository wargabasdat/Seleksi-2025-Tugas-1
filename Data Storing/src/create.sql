CREATE TABLE country (
    country_id INTEGER PRIMARY KEY,
    country_name TEXT NOT NULL UNIQUE
);

CREATE TABLE city (
    country_id INTEGER NOT NULL,
    city_name TEXT NOT NULL,
    PRIMARY KEY (country_id, city_name),
    FOREIGN KEY (country_id) REFERENCES country(country_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE unicorn (
    unicorn_id BIGSERIAL PRIMARY KEY,
    company_name TEXT NOT NULL,
    valuation NUMERIC(12,2),
    date_joined DATE,
    country_id INTEGER NOT NULL,
    city_name  TEXT NOT NULL,
    industry TEXT,
    selected_investors TEXT,
    FOREIGN KEY (country_id, city_name) REFERENCES city(country_id, city_name) ON DELETE RESTRICT
);