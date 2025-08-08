-- Find the Top 5 most common ingredients used across all recipes.
-- This query joins dim_ingredients and dim_recipes to count the occurrences of each ingredient name. This helps identify the most fundamental ingredients in your dataset.
SELECT
  di.name AS ingredient_name,
  COUNT(di.ingredient_id) AS total_recipes_with_ingredient
FROM dim_ingredients AS di
GROUP BY
  ingredient_name
ORDER BY
  total_recipes_with_ingredient DESC
LIMIT 5;


-- Query: Calculate the average total time for recipes in each difficulty level.
-- This query uses a JOIN to link the difficulty_level from dim_recipes to the total_time from fact_recipes and then computes the average. This helps validate if the difficulty classification is meaningful.
SELECT
  dr.difficulty_level,
  AVG(fr.total_time) AS average_total_time_minutes
FROM dim_recipes AS dr
JOIN fact_recipes AS fr
  ON dr.recipe_id = fr.recipe_id
GROUP BY
  dr.difficulty_level;


-- Query: List recipes that use "flour" and have a "Medium" difficulty level.
-- This query combines multiple JOINs and WHERE clauses to filter recipes based on both ingredient and difficulty.
SELECT DISTINCT
  dr.title,
  dr.difficulty_level, di.name AS ingredient_name
FROM dim_recipes AS dr
JOIN dim_ingredients AS di
  ON dr.recipe_id = di.recipe_id
WHERE
  di.name like '%flour%' AND dr.difficulty_level = 'medium';


-- Find the top 3 ingredients that are most commonly used in "Easy" difficulty recipes.
-- This query helps to identify which ingredients are staples in simple, beginner-friendly recipes. It joins the dim_ingredients and dim_recipes tables, filters for recipes with a difficulty level of 'Easy,' and then counts the occurrences of each ingredient name.
SELECT
  di.name AS ingredient_name,
  COUNT(di.ingredient_id) AS total_recipes_with_ingredient
FROM dim_ingredients AS di
JOIN dim_recipes AS dr
  ON di.recipe_id = dr.recipe_id
WHERE
  dr.difficulty_level = 'Easy'
GROUP BY
  ingredient_name
ORDER BY
  total_recipes_with_ingredient DESC
LIMIT 3;


-- List the top 5 ingredients that appear in more than 2 recipes measured in "cup" units, ordered by the average quantity used.
-- This query helps to understand the typical measurements for common ingredients. It filters the dim_ingredients table for a specific unit ('cup'), includes only those ingredients found in more than two recipes, and then calculates the average quantity for each, ordering the results from highest to lowest.
SELECT
  name,
  format(AVG(quantity), 2) AS average_quantity_in_cups
FROM
  dim_ingredients
WHERE
  unit = 'cup'
GROUP BY
  name
HAVING
  COUNT(recipe_id) > 2
ORDER BY
  average_quantity_in_cups DESC
LIMIT 5;