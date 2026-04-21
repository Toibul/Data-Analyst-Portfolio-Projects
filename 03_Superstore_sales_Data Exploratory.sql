-- Superstore Slaes Data Exploration
----------------------------------------------------------------------------------------------------------------------------------------------------
-- F1. Top 10 Customers by Total Revenue
SELECT
    customer_id,
    customer_name,
    segment,
    state,
    region,
    COUNT(DISTINCT order_id)  AS total_orders,
    ROUND(SUM(sales), 2)      AS total_revenue,
    ROUND(AVG(sales), 2)      AS avg_order_value
FROM superstore_sales
GROUP BY customer_id, customer_name, segment, state, region
ORDER BY total_revenue DESC
LIMIT 10;

-- F2. Customer purchase frequency distribution
SELECT
    order_count_bucket,
    COUNT(*) AS number_of_customers
FROM (
    SELECT
        customer_id,
        COUNT(DISTINCT order_id) AS total_orders,
        CASE
            WHEN COUNT(DISTINCT order_id) = 1  THEN '1 Order (One-time)'
            WHEN COUNT(DISTINCT order_id) <= 3 THEN '2-3 Orders'
            WHEN COUNT(DISTINCT order_id) <= 6 THEN '4-6 Orders'
            ELSE '7+ Orders (Loyal)'
        END AS order_count_bucket
    FROM superstore_sales
    GROUP BY customer_id
) bucket_table
GROUP BY order_count_bucket
ORDER BY MIN(CASE order_count_bucket
    WHEN '1 Order (One-time)' THEN 1
    WHEN '2-3 Orders'         THEN 2
    WHEN '4-6 Orders'         THEN 3
    ELSE 4
END);
----------------------------------------------------------------------------------------------------------------------------------------------------
-- G1. Calculate RFM base values per customer
SELECT
    customer_id,
    customer_name,
    segment,
    DATEDIFF('2018-12-31', MAX(order_date))   AS recency_days,
    COUNT(DISTINCT order_id)                   AS frequency,
    ROUND(SUM(sales), 2)                       AS monetary_value
FROM superstore_sales
GROUP BY customer_id, customer_name, segment
ORDER BY monetary_value DESC
LIMIT 20;
-- =====================================================================================================================================================
-- FILE 2: Core Sales Analysis Queries

-- A1. Total Revenue, Orders, and Customers
SELECT
    COUNT(DISTINCT order_id)     AS total_orders,
    COUNT(DISTINCT customer_id)  AS total_customers,
    ROUND(SUM(sales), 2)         AS total_revenue,
    ROUND(AVG(sales), 2)         AS avg_order_line_value,
    ROUND(MAX(sales), 2)         AS highest_single_sale
FROM superstore_sales;

-- A2. Revenue by Year (Annual Trend)
SELECT
    YEAR(order_date)         AS order_year,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(sales), 2)     AS total_revenue,
    ROUND(AVG(sales), 2)     AS avg_sale_value
FROM superstore_sales
GROUP BY YEAR(order_date)
ORDER BY order_year;

-- A3. Revenue by Month (Monthly Trend - all years combined)
SELECT
    MONTH(order_date)        AS month_number,
    MONTHNAME(order_date)    AS month_name,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(sales), 2)     AS total_revenue
FROM superstore_sales
GROUP BY MONTH(order_date), MONTHNAME(order_date)
ORDER BY month_number;

---------------------------------------------------------------------------------------------------------------------------------------------------
-- SECTION B: REGIONAL PERFORMANCE

-- B1. Sales by Region
SELECT
    region,
    COUNT(DISTINCT order_id)                                           AS total_orders,
    ROUND(SUM(sales), 2)                                               AS total_revenue,
    ROUND(AVG(sales), 2)                                               AS avg_sale,
    ROUND(SUM(sales) * 100.0 / SUM(SUM(sales)) OVER (), 2)            AS revenue_share_pct
FROM superstore_sales
GROUP BY region
ORDER BY total_revenue DESC;

-- B2. Top 10 States by Revenue
SELECT
    state,
    region,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(sales), 2)     AS total_revenue
FROM superstore_sales
GROUP BY state, region
ORDER BY total_revenue DESC
LIMIT 10;

-- B3. Bottom 5 States by Revenue (underperformers)
SELECT
    state,
    region,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(sales), 2)     AS total_revenue
FROM superstore_sales
GROUP BY state, region
ORDER BY total_revenue ASC
LIMIT 5;

-- B4. Top 10 Cities by Revenue
SELECT
    city,
    state,
    region,
    ROUND(SUM(sales), 2) AS total_revenue
FROM superstore_sales
GROUP BY city, state, region
ORDER BY total_revenue DESC
LIMIT 10;

----------------------------------------------------------------------------------------------------------------------------------------------------
-- C1. Sales by Category
SELECT
    category,
    COUNT(DISTINCT order_id)                                        AS total_orders,
    ROUND(SUM(sales), 2)                                            AS total_revenue,
    ROUND(AVG(sales), 2)                                            AS avg_sale,
    ROUND(SUM(sales) * 100.0 / SUM(SUM(sales)) OVER (), 2)         AS revenue_share_pct
FROM superstore_sales
GROUP BY category
ORDER BY total_revenue DESC;

-- C2. Sales by Sub-Category (Top 10)
SELECT
    category,
    sub_category,
    ROUND(SUM(sales), 2)     AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders
FROM superstore_sales
GROUP BY category, sub_category
ORDER BY total_revenue DESC
LIMIT 10;

-- C3. Category performance by Region (pivot-style)
SELECT
    region,
    ROUND(SUM(CASE WHEN category = 'Technology'       THEN sales ELSE 0 END), 2) AS technology_sales,
    ROUND(SUM(CASE WHEN category = 'Furniture'        THEN sales ELSE 0 END), 2) AS furniture_sales,
    ROUND(SUM(CASE WHEN category = 'Office Supplies'  THEN sales ELSE 0 END), 2) AS office_supplies_sales,
    ROUND(SUM(sales), 2)                                                          AS total_sales
FROM superstore_sales
GROUP BY region
ORDER BY total_sales DESC;
---------------------------------------------------------------------------------------------------------------------------------------------
-- SECTION D: CUSTOMER SEGMENT ANALYSIS

-- D1. Revenue by Segment
SELECT
    segment,
    COUNT(DISTINCT customer_id)                                     AS unique_customers,
    COUNT(DISTINCT order_id)                                        AS total_orders,
    ROUND(SUM(sales), 2)                                            AS total_revenue,
    ROUND(AVG(sales), 2)                                            AS avg_order_value,
    ROUND(SUM(sales) * 100.0 / SUM(SUM(sales)) OVER (), 2)         AS revenue_share_pct
FROM superstore_sales
GROUP BY segment
ORDER BY total_revenue DESC;

-- D2. Segment performance by Region
SELECT
    region,
    segment,
    ROUND(SUM(sales), 2)     AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders
FROM superstore_sales
GROUP BY region, segment
ORDER BY region, total_revenue DESC;

----------------------------------------------------------------------------------------------------------------------------------------------------
-- SECTION E: SHIPPING ANALYSIS

-- E1. Orders and Revenue by Ship Mode
SELECT
    ship_mode,
    COUNT(DISTINCT order_id)                                        AS total_orders,
    ROUND(SUM(sales), 2)                                            AS total_revenue,
    ROUND(SUM(sales) * 100.0 / SUM(SUM(sales)) OVER (), 2)         AS revenue_share_pct
FROM superstore_sales
GROUP BY ship_mode
ORDER BY total_revenue DESC;

-- E2. Average shipping delay (days between order and ship)
SELECT
    ship_mode,
    ROUND(AVG(DATEDIFF(ship_date, order_date)), 1) AS avg_ship_days,
    MIN(DATEDIFF(ship_date, order_date))           AS min_ship_days,
    MAX(DATEDIFF(ship_date, order_date))           AS max_ship_days
FROM superstore_sales
GROUP BY ship_mode
ORDER BY avg_ship_days;

-----------------------------------------------------------------------------------------------------------------------------------------------------
-- FILE 4: Advanced Business Insights

-- H1. Master KPI Summary
SELECT
    'Total Revenue' AS kpi_name, 
    ROUND(SUM(sales), 2) AS kpi_value 
FROM superstore_sales
UNION ALL
SELECT 'Total Orders',
        COUNT(DISTINCT order_id)
FROM superstore_sales
UNION ALL
SELECT 'Total Customers',
     COUNT(DISTINCT customer_id)                  
FROM superstore_sales
UNION ALL
SELECT 'Avg Sale Value',      
	ROUND(AVG(sales), 2)                        
FROM superstore_sales
UNION ALL
SELECT 'Max Single Sale',     
	ROUND(MAX(sales), 2)                         
FROM superstore_sales
UNION ALL
SELECT 'Total Products Sold', 
	COUNT(DISTINCT product_id)                   
FROM superstore_sales;
----------------------------------------------------------------------------------------------------------------------------------------------------
-- SECTION J: PRODUCT PERFORMANCE

-- J1. Top 10 Best-Selling Products
SELECT
    product_id,
    product_name,
    category,
    sub_category,
    COUNT(*) AS times_ordered,
    ROUND(SUM(sales), 2) AS total_revenue,
    ROUND(AVG(sales), 2) AS avg_sale_price
FROM superstore_sales
GROUP BY product_id, product_name, category, sub_category
ORDER BY total_revenue DESC
LIMIT 10;

-- J2. Bottom 10 Slowest Products (potential dead stock)
SELECT
    product_name,
    category,
    sub_category,
    COUNT(*) AS times_ordered,
    ROUND(SUM(sales), 2) AS total_revenue
FROM superstore_sales
GROUP BY product_name, category, sub_category
ORDER BY total_revenue ASC
LIMIT 10;

----------------------------------------------------------------------------------------------------------------------------------------------------
-- SECTION K: BUSINESS INSIGHT

-- K1. Which segment + region combo generates the most revenue?
SELECT
    segment,
    region,
    ROUND(SUM(sales), 2)     AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders
FROM superstore_sales
GROUP BY segment, region
ORDER BY total_revenue DESC
LIMIT 10;

-- K2. What is the most popular ship mode per segment?
SELECT
    segment,
    ship_mode,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(sales), 2)     AS total_revenue
FROM superstore_sales
GROUP BY segment, ship_mode
ORDER BY segment, total_orders DESC;

-- K3. Which category dominates each region?
SELECT
    region,
    category,
    ROUND(SUM(sales), 2) AS total_revenue,
    RANK() OVER (PARTITION BY region ORDER BY SUM(sales) DESC) AS rank_in_region
FROM superstore_sales
GROUP BY region, category
ORDER BY region, rank_in_region;

-- K4. Monthly sales trend (best and worst months)
SELECT
    MONTHNAME(order_date) AS month_name,
    MONTH(order_date)     AS month_num,
    ROUND(SUM(sales), 2)  AS total_revenue,
    COUNT(DISTINCT order_id) AS orders
FROM superstore_sales
GROUP BY MONTHNAME(order_date), MONTH(order_date)
ORDER BY total_revenue DESC;