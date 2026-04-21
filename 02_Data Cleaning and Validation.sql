/*
Cleaning and vaidate Data in SQL 
*/
SELECT * 
FROM superstore_sales;

-- DATA CLEANING & VALIDATION
-- 2.1 Check total row count?
SELECT
 COUNT(*) AS total_rows 
FROM superstore_sales;
-- NULL VALUES	
SELECT
	order_id,order_date,ship_date,ship_mode,customer_id,segment,country,city,state,postal_code,region,product_id,category,sub_category,product_name,sales
FROM
superstore_sales
WHERE
	order_id is null
	or order_date is null
	or ship_date is null
	or ship_mode is null
	or customer_id is null
	or segment is null
	or country is null
	or city is null
	or state is null
	or postal_code is null
	or region is null
	or product_id is null
	or category is null
	or sub_category is null
	or product_name is null
	or sales is null;
-- 2.2 Check for NULL or missing values in key columns
SELECT
    SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END)      AS null_order_id,
    SUM(CASE WHEN order_date IS NULL THEN 1 ELSE 0 END)    AS null_order_date,
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END)   AS null_customer_id,
    SUM(CASE WHEN sales IS NULL THEN 1 ELSE 0 END)         AS null_sales,
    SUM(CASE WHEN region IS NULL THEN 1 ELSE 0 END)        AS null_region,
    SUM(CASE WHEN postal_code IS NULL THEN 1 ELSE 0 END)   AS null_postal_code
FROM superstore_sales;

-- 2.3 Check for duplicate Order IDs
SELECT order_id, COUNT(*) AS occurrences
FROM superstore_sales
GROUP BY order_id
HAVING COUNT(*) > 1
ORDER BY occurrences DESC
LIMIT 10;

-- 2.4 Check for zero or negative sales
SELECT COUNT(*) AS zero_or_negative_sales
FROM superstore_sales
WHERE sales <= 0;

-- 2.5 Validate distinct categories
SELECT DISTINCT category FROM superstore_sales ORDER BY category;

-- 2.6 Validate distinct regions
SELECT DISTINCT region FROM superstore_sales ORDER BY region;

-- 2.7 Validate distinct segments
SELECT DISTINCT segment FROM superstore_sales ORDER BY segment;

-- 2.8 Check date range of dataset
SELECT
    MIN(order_date) AS earliest_order,
    MAX(order_date) AS latest_order
FROM superstore_sales;
