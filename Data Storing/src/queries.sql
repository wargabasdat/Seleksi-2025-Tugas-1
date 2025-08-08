-- TUGAS_SELEKSI_1_18223125/Data Storing/src/queries.sql

-- Retrieve 5 ingredients with a specific quantity.
-- This query selects the top 5 rows from the ingredients table where the quantity column is exactly '2/3'.
select * from ingredients where quantity = '2/3' limit 5;

-- Find recipes that take less than 30 minutes.
-- This query filters the recipes table to find all recipes where the total_time is less than 30.
select * from recipes where total_time < 30;

-- List all available categories.
-- This query retrieves every row and column from the categories table.
select * from categories;

-- Find instructions that mention "stiff peaks".
-- This query searches the instructions table for any text that includes the phrase "stiff peaks".
select * from instructions where text like '%stiff peaks%';

-- Find recipes that contain the word "chocolate" in their title.
-- This query searches the recipes table for titles that include the word "chocolate".
select * from recipes where title like '%chocolate%';