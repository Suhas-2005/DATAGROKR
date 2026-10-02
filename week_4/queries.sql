-- ============================================================
-- WEEK 4 SQL E-COMMERCE PROJECT
-- COMPLETE QUERY FILE
-- ============================================================

USE ecommerce_db;


-- ============================================================
-- SECTION 1: SELECT
-- ============================================================

-- 1. Display all customers
SELECT *
FROM customers;

-- 2. Display customer names and cities
SELECT name, city
FROM customers;

-- 3. Display all products
SELECT *
FROM products;

-- 4. Display product name, category and price
SELECT product_name, category, price
FROM products;


-- ============================================================
-- SECTION 2: WHERE
-- ============================================================

-- 5. Products costing more than 10000
SELECT product_name, price
FROM products
WHERE price > 10000;

-- 6. Products costing less than 5000
SELECT product_name, price
FROM products
WHERE price < 5000;

-- 7. Electronics products
SELECT product_name, category
FROM products
WHERE category = 'Electronics';

-- 8. Customers from Bangalore
SELECT name, city
FROM customers
WHERE city = 'Bangalore';

-- 9. Products with stock less than 20
SELECT product_name, stock
FROM products
WHERE stock < 20;

-- 10. Delivered orders
SELECT *
FROM orders
WHERE status = 'Delivered';


-- ============================================================
-- SECTION 3: ORDER BY
-- ============================================================

-- 11. Products from cheapest to most expensive
SELECT product_name, price
FROM products
ORDER BY price ASC;

-- 12. Products from most expensive to cheapest
SELECT product_name, price
FROM products
ORDER BY price DESC;

-- 13. Customers alphabetically
SELECT name, city
FROM customers
ORDER BY name ASC;

-- 14. Products by highest stock
SELECT product_name, stock
FROM products
ORDER BY stock DESC;


-- ============================================================
-- SECTION 4: LIMIT
-- ============================================================

-- 15. Top 3 most expensive products
SELECT product_name, price
FROM products
ORDER BY price DESC
LIMIT 3;

-- 16. Top 5 products by stock
SELECT product_name, stock
FROM products
ORDER BY stock DESC
LIMIT 5;


-- ============================================================
-- SECTION 5: ALIASES
-- ============================================================

-- 17. Rename columns using aliases
SELECT
    product_name AS Product,
    price AS Product_Price
FROM products;

-- 18. Table alias
SELECT
    c.name AS Customer_Name,
    c.city AS Customer_City
FROM customers AS c;


-- ============================================================
-- SECTION 6: NULL HANDLING
-- ============================================================

-- 19. Customers whose phone number is NULL
SELECT name, phone
FROM customers
WHERE phone IS NULL;

-- 20. Customers whose phone number is NOT NULL
SELECT name, phone
FROM customers
WHERE phone IS NOT NULL;

-- 21. Replace NULL phone numbers with 'Not Available'
SELECT
    name,
    COALESCE(phone, 'Not Available') AS phone
FROM customers;

-- 22. Replace NULL phone with city
SELECT
    name,
    COALESCE(phone, city, 'No Contact Information') AS contact
FROM customers;

-- 23. Demonstrate NULLIF
SELECT
    product_name,
    price,
    NULLIF(price, 30000) AS result
FROM products;

-- 24. Avoid division by zero using NULLIF
SELECT
    product_name,
    price / NULLIF(stock, 0) AS price_per_stock_unit
FROM products;


-- ============================================================
-- SECTION 7: AGGREGATE FUNCTIONS
-- ============================================================

-- 25. Count all customers
SELECT COUNT(*) AS total_customers
FROM customers;

-- 26. Count customers having phone numbers
SELECT COUNT(phone) AS customers_with_phone
FROM customers;

-- 27. Count products
SELECT COUNT(*) AS total_products
FROM products;

-- 28. Total value of all products
SELECT SUM(price) AS total_product_value
FROM products;

-- 29. Average product price
SELECT AVG(price) AS average_price
FROM products;

-- 30. Most expensive product price
SELECT MAX(price) AS maximum_price
FROM products;

-- 31. Cheapest product price
SELECT MIN(price) AS minimum_price
FROM products;

-- 32. Total stock
SELECT SUM(stock) AS total_stock
FROM products;


-- ============================================================
-- SECTION 8: GROUP BY
-- ============================================================

-- 33. Number of products in each category
SELECT
    category,
    COUNT(*) AS product_count
FROM products
GROUP BY category;

-- 34. Average price of each category
SELECT
    category,
    AVG(price) AS average_price
FROM products
GROUP BY category;

-- 35. Total stock in each category
SELECT
    category,
    SUM(stock) AS total_stock
FROM products
GROUP BY category;

-- 36. Number of customers in each city
SELECT
    city,
    COUNT(*) AS customer_count
FROM customers
GROUP BY city;


-- ============================================================
-- SECTION 9: HAVING
-- ============================================================

-- 37. Categories having more than 2 products
SELECT
    category,
    COUNT(*) AS product_count
FROM products
GROUP BY category
HAVING COUNT(*) > 2;

-- 38. Categories whose average price is greater than 5000
SELECT
    category,
    AVG(price) AS average_price
FROM products
GROUP BY category
HAVING AVG(price) > 5000;

-- 39. Cities having more than 1 customer
SELECT
    city,
    COUNT(*) AS customer_count
FROM customers
GROUP BY city
HAVING COUNT(*) > 1;


-- ============================================================
-- SECTION 10: INNER JOIN
-- ============================================================

-- 40. Display orders with customer names
SELECT
    o.order_id,
    c.name,
    o.order_date,
    o.status
FROM orders AS o
INNER JOIN customers AS c
    ON o.customer_id = c.customer_id;

-- 41. Display order items with product names
SELECT
    oi.order_id,
    p.product_name,
    oi.quantity
FROM order_items AS oi
INNER JOIN products AS p
    ON oi.product_id = p.product_id;

-- 42. Display complete order details
SELECT
    o.order_id,
    c.name AS customer_name,
    p.product_name,
    oi.quantity,
    p.price
FROM orders AS o
INNER JOIN customers AS c
    ON o.customer_id = c.customer_id
INNER JOIN order_items AS oi
    ON o.order_id = oi.order_id
INNER JOIN products AS p
    ON oi.product_id = p.product_id;


-- ============================================================
-- SECTION 11: LEFT JOIN
-- ============================================================

-- 43. Display all customers and their orders
SELECT
    c.customer_id,
    c.name,
    o.order_id,
    o.order_date
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id;

-- 44. Find customers who have never placed an order
SELECT
    c.customer_id,
    c.name
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;


-- ============================================================
-- SECTION 12: RIGHT JOIN
-- ============================================================

-- 45. Display all orders and matching customers
SELECT
    c.name,
    o.order_id,
    o.order_date
FROM customers AS c
RIGHT JOIN orders AS o
    ON c.customer_id = o.customer_id;


-- ============================================================
-- SECTION 13: FULL OUTER JOIN
-- ============================================================

-- MySQL does not directly support FULL OUTER JOIN.
-- The following combines LEFT JOIN and RIGHT JOIN.

SELECT
    c.customer_id,
    c.name,
    o.order_id
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id

UNION

SELECT
    c.customer_id,
    c.name,
    o.order_id
FROM customers AS c
RIGHT JOIN orders AS o
    ON c.customer_id = o.customer_id;


-- ============================================================
-- SECTION 14: CUSTOMER SPENDING
-- ============================================================

-- 46. Calculate spending for every order
SELECT
    o.order_id,
    c.name AS customer_name,
    SUM(p.price * oi.quantity) AS order_total
FROM orders AS o
INNER JOIN customers AS c
    ON o.customer_id = c.customer_id
INNER JOIN order_items AS oi
    ON o.order_id = oi.order_id
INNER JOIN products AS p
    ON oi.product_id = p.product_id
GROUP BY
    o.order_id,
    c.name;


-- 47. Total spending by each customer
SELECT
    c.customer_id,
    c.name,
    SUM(p.price * oi.quantity) AS total_spent
FROM customers AS c
INNER JOIN orders AS o
    ON c.customer_id = o.customer_id
INNER JOIN order_items AS oi
    ON o.order_id = oi.order_id
INNER JOIN products AS p
    ON oi.product_id = p.product_id
GROUP BY
    c.customer_id,
    c.name
ORDER BY total_spent DESC;


-- 48. Customers who spent more than 50000
SELECT
    c.name,
    SUM(p.price * oi.quantity) AS total_spent
FROM customers AS c
INNER JOIN orders AS o
    ON c.customer_id = o.customer_id
INNER JOIN order_items AS oi
    ON o.order_id = oi.order_id
INNER JOIN products AS p
    ON oi.product_id = p.product_id
GROUP BY
    c.customer_id,
    c.name
HAVING SUM(p.price * oi.quantity) > 50000;


-- ============================================================
-- SECTION 15: TOP PRODUCTS
-- ============================================================

-- 49. Total quantity sold for each product
SELECT
    p.product_name,
    SUM(oi.quantity) AS total_sold
FROM products AS p
INNER JOIN order_items AS oi
    ON p.product_id = oi.product_id
GROUP BY
    p.product_id,
    p.product_name
ORDER BY total_sold DESC;

-- 50. Top 3 best-selling products
SELECT
    p.product_name,
    SUM(oi.quantity) AS total_sold
FROM products AS p
INNER JOIN order_items AS oi
    ON p.product_id = oi.product_id
GROUP BY
    p.product_id,
    p.product_name
ORDER BY total_sold DESC
LIMIT 3;


-- ============================================================
-- SECTION 16: CASE WHEN
-- ============================================================

-- 51. Categorize products based on price
SELECT
    product_name,
    price,
    CASE
        WHEN price >= 30000 THEN 'Expensive'
        WHEN price >= 10000 THEN 'Medium'
        ELSE 'Affordable'
    END AS price_category
FROM products;


-- 52. Categorize stock levels
SELECT
    product_name,
    stock,
    CASE
        WHEN stock = 0 THEN 'Out of Stock'
        WHEN stock < 20 THEN 'Low Stock'
        WHEN stock <= 40 THEN 'Medium Stock'
        ELSE 'High Stock'
    END AS stock_status
FROM products;


-- 53. Categorize customer contact status
SELECT
    name,
    CASE
        WHEN phone IS NULL THEN 'Missing'
        ELSE 'Available'
    END AS contact_status
FROM customers;


-- ============================================================
-- SECTION 17: STRING FUNCTIONS
-- ============================================================

-- 54. Convert customer names to uppercase
SELECT
    name,
    UPPER(name) AS uppercase_name
FROM customers;

-- 55. Convert customer names to lowercase
SELECT
    name,
    LOWER(name) AS lowercase_name
FROM customers;

-- 56. Find length of customer names
SELECT
    name,
    LENGTH(name) AS name_length
FROM customers;

-- 57. Combine customer name and city
SELECT
    CONCAT(name, ' - ', city) AS customer_details
FROM customers;

-- 58. Extract first 5 characters of product names
SELECT
    product_name,
    SUBSTRING(product_name, 1, 5) AS short_name
FROM products;


-- ============================================================
-- SECTION 18: DATE FUNCTIONS
-- ============================================================

-- 59. Display order dates
SELECT
    order_id,
    order_date
FROM orders;

-- 60. Extract year from order date
SELECT
    order_id,
    YEAR(order_date) AS order_year
FROM orders;

-- 61. Extract month from order date
SELECT
    order_id,
    MONTH(order_date) AS order_month
FROM orders;

-- 62. Extract day from order date
SELECT
    order_id,
    DAY(order_date) AS order_day
FROM orders;

-- 63. Display current date
SELECT CURRENT_DATE AS today;

-- 64. Display current date and time
SELECT CURRENT_TIMESTAMP AS current_datetime;


-- ============================================================
-- SECTION 19: ORDER ANALYSIS
-- ============================================================

-- 65. Count orders for each customer
SELECT
    c.name,
    COUNT(o.order_id) AS order_count
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.name;

-- 66. Number of orders by status
SELECT
    status,
    COUNT(*) AS order_count
FROM orders
GROUP BY status;

-- 67. Number of orders per day
SELECT
    order_date,
    COUNT(*) AS order_count
FROM orders
GROUP BY order_date
ORDER BY order_date;


