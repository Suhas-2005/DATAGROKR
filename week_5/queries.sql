USE ecommerce_dw;

-- 1. Scalar Subquery
SELECT product_name, price
FROM dim_product
WHERE price > (SELECT AVG(price) FROM dim_product);


-- 2. Correlated Subquery
SELECT p.product_name, p.price
FROM dim_product p
WHERE p.price > (
    SELECT AVG(p2.price)
    FROM dim_product p2
    WHERE p2.category = p.category
);


-- 3. EXISTS
SELECT c.customer_name
FROM dim_customer c
WHERE EXISTS (
    SELECT 1
    FROM fact_sales f
    WHERE f.customer_key = c.customer_key
);


-- 4. RANK
SELECT
    p.product_name,
    SUM(f.revenue) AS revenue,
    RANK() OVER (ORDER BY SUM(f.revenue) DESC) AS sales_rank
FROM fact_sales f
JOIN dim_product p ON f.product_key = p.product_key
GROUP BY p.product_key, p.product_name;


-- 5. DENSE_RANK by category
SELECT
    p.category,
    p.product_name,
    SUM(f.revenue) AS revenue,
    DENSE_RANK() OVER (
        PARTITION BY p.category
        ORDER BY SUM(f.revenue) DESC
    ) AS category_rank
FROM fact_sales f
JOIN dim_product p ON f.product_key = p.product_key
GROUP BY p.category, p.product_key, p.product_name;


-- 6. LAG
WITH monthly_sales AS (
    SELECT
        d.year_number,
        d.month_number,
        SUM(f.revenue) AS revenue
    FROM fact_sales f
    JOIN dim_date d ON f.date_key = d.date_key
    GROUP BY d.year_number, d.month_number
)
SELECT *,
       LAG(revenue) OVER (
           ORDER BY year_number, month_number
       ) AS previous_month
FROM monthly_sales;


-- 7. LEAD
SELECT
    full_date,
    revenue,
    LEAD(revenue) OVER (ORDER BY full_date) AS next_revenue
FROM (
    SELECT
        d.full_date,
        SUM(f.revenue) AS revenue
    FROM fact_sales f
    JOIN dim_date d ON f.date_key = d.date_key
    GROUP BY d.full_date
) x;


-- 8. NTILE
SELECT
    customer_name,
    total_spending,
    NTILE(4) OVER (ORDER BY total_spending DESC) AS customer_quartile
FROM (
    SELECT
        c.customer_name,
        SUM(f.revenue) AS total_spending
    FROM fact_sales f
    JOIN dim_customer c
        ON f.customer_key = c.customer_key
    GROUP BY c.customer_key, c.customer_name
) x;


-- 9. Month-over-Month Growth
WITH monthly AS (
    SELECT
        d.year_number,
        d.month_number,
        SUM(f.revenue) AS revenue
    FROM fact_sales f
    JOIN dim_date d ON f.date_key = d.date_key
    GROUP BY d.year_number, d.month_number
)
SELECT *,
       revenue - LAG(revenue) OVER (
           ORDER BY year_number, month_number
       ) AS revenue_change
FROM monthly;


-- 10. ROLLUP
SELECT
    p.category,
    SUM(f.revenue) AS total_revenue
FROM fact_sales f
JOIN dim_product p ON f.product_key = p.product_key
GROUP BY p.category WITH ROLLUP;


-- 11. UNION
SELECT customer_name
FROM dim_customer
WHERE customer_segment = 'Premium'
UNION
SELECT customer_name
FROM dim_customer
WHERE customer_segment = 'Regular';


-- 12. VIEW
CREATE OR REPLACE VIEW customer_sales AS
SELECT
    c.customer_name,
    SUM(f.revenue) AS total_revenue
FROM fact_sales f
JOIN dim_customer c
    ON f.customer_key = c.customer_key
GROUP BY c.customer_key, c.customer_name;

SELECT * FROM customer_sales;


-- 13. EXPLAIN
EXPLAIN
SELECT *
FROM fact_sales
WHERE date_key = 20260101;