-- 1. Rata-rata rating video game per tahun
SELECT y.year_id AS year, ROUND(AVG(f.rating), 2) AS average_rating
FROM fact_videogame_rating f
JOIN dim_year y ON f.year_id = y.year_id
GROUP BY y.year_id
ORDER BY y.year_id;

-- 2. Jumlah game disutradarai oleh masing-masing director per tahun
SELECT d.director_name, y.year_id AS year, COUNT(*) AS total_games
FROM fact_director_credit f
JOIN dim_director d ON f.director_id = d.director_id
JOIN dim_year y ON f.year_id = y.year_id
GROUP BY d.director_name, y.year_id
ORDER BY d.director_name, y.year_id;

-- 3. Tren rating game yang disutradarai oleh director
SELECT d.director_name, y.year_id AS year, ROUND(AVG(r.rating), 2) AS avg_rating
FROM fact_director_credit f
JOIN dim_director d ON f.director_id = d.director_id
JOIN dim_year y ON f.year_id = y.year_id
JOIN fact_videogame_rating r ON f.videogame_id = r.videogame_id AND f.year_id = r.year_id
GROUP BY d.director_name, y.year_id
ORDER BY d.director_name, y.year_id;

-- 4.  Sutradara dengan Rata-Rata Rating Tertinggi
SELECT d.director_name, ROUND(AVG(r.rating), 2) AS avg_rating
FROM fact_director_credit f
JOIN dim_director d ON f.director_id = d.director_id
JOIN fact_videogame_rating r ON f.videogame_id = r.videogame_id AND f.year_id = r.year_id
GROUP BY d.director_name
ORDER BY avg_rating DESC
LIMIT 10;