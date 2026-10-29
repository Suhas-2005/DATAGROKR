
-- DataGrokr Week 6 Mini Project
-- Simple Sales Data Engineering Pipeline
-- MySQL 8.0.19+

CREATE DATABASE IF NOT EXISTS week_6;
USE week_6;

-- 1. CLEAN UP OLD PROJECT OBJECTS
DROP PROCEDURE IF EXISTS GetSales;
DROP TABLE IF EXISTS sales_audit;
DROP TABLE IF EXISTS sales_staging;
DROP TABLE IF EXISTS sales;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS dim_customer;

-- 2. CREATE PRODUCT TABLE
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    price DECIMAL(10,2),
    details JSON
);

-- 3. CREATE PARTITIONED SALES TABLE
CREATE TABLE sales (
    sale_id INT NOT NULL,
    product_id INT NOT NULL,
    sale_date DATE NOT NULL,
    quantity INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (sale_id, sale_date)
)
PARTITION BY RANGE (YEAR(sale_date)) (
    PARTITION p2025 VALUES LESS THAN (2026),
    PARTITION p2026 VALUES LESS THAN (2027),
    PARTITION p2027 VALUES LESS THAN (2028),
    PARTITION p_future VALUES LESS THAN MAXVALUE
);

-- 4. INSERT SAMPLE PRODUCTS
INSERT INTO products (product_id, product_name, price)
VALUES
(101, 'Laptop', 50000.00),
(102, 'Mouse', 500.00),
(103, 'Keyboard', 1200.00),
(104, 'Monitor', 10000.00);

-- 5. UPSERT: INSERT OR UPDATE PRODUCTS
INSERT INTO products (product_id, product_name, price)
VALUES
(101, 'Laptop Pro', 55000.00),
(105, 'Headphones', 2000.00) AS new
ON DUPLICATE KEY UPDATE
    product_name = new.product_name,
    price = new.price;

-- 6. STAGING TABLE FOR BULK LOADING
CREATE TABLE sales_staging (
    sale_id INT,
    product_id INT,
    sale_date DATE,
    quantity INT,
    amount DECIMAL(10,2)
);

-- Optional CSV bulk load:
-- Replace the path with the actual full path to sales.csv.
-- If using this command, do not also insert the sample rows below.
--
-- LOAD DATA LOCAL INFILE 'C:/YOUR_PATH/week_6/sales.csv'
-- INTO TABLE sales_staging
-- FIELDS TERMINATED BY ','
-- OPTIONALLY ENCLOSED BY '"'
-- LINES TERMINATED BY '\n'
-- IGNORE 1 ROWS
-- (sale_id, product_id, sale_date, quantity, amount);

-- Sample staging data; works without loading the CSV
INSERT INTO sales_staging
    (sale_id, product_id, sale_date, quantity, amount)
VALUES
(1, 101, '2026-01-10', 2, 100000.00),
(2, 102, '2026-01-15', 5, 2500.00),
(3, 103, '2026-02-05', 3, 3600.00),
(4, 104, '2026-02-20', 1, 10000.00),
(5, 101, '2026-03-12', 1, 50000.00);

-- 7. CREATE AUDIT TABLE
CREATE TABLE sales_audit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    sale_id INT,
    action_type VARCHAR(20),
    action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 8. TRIGGER: RECORD NEW SALES
DELIMITER //

CREATE TRIGGER after_sales_insert
AFTER INSERT ON sales
FOR EACH ROW
BEGIN
    INSERT INTO sales_audit (sale_id, action_type)
    VALUES (NEW.sale_id, 'INSERT');
END //

DELIMITER ;

-- 9. TRANSFER STAGING DATA TO SALES
-- The trigger records each inserted sale.
INSERT INTO sales
    (sale_id, product_id, sale_date, quantity, amount)
SELECT
    sale_id, product_id, sale_date, quantity, amount
FROM sales_staging;

-- 10. COMPOSITE INDEX
CREATE INDEX idx_product_date
ON sales (product_id, sale_date);

-- 11. TRANSACTION AND ROLLBACK
START TRANSACTION;

UPDATE products
SET price = price + 100
WHERE product_id = 102;

ROLLBACK;

-- 12. STORED PROCEDURE
DELIMITER //

CREATE PROCEDURE GetSales()
BEGIN
    SELECT * FROM sales;
END //

DELIMITER ;

-- 13. JSON DATA
UPDATE products
SET details = JSON_OBJECT(
    'category', 'Electronics',
    'available', TRUE
)
WHERE product_id = 101;

SELECT
    product_id,
    product_name,
    details->>'$.category' AS category
FROM products;

-- 14. SCD TYPE 1, TYPE 2 AND TYPE 3
-- Type 1: overwrite; Type 2: preserve history;
-- Type 3: retain the previous value.

CREATE TABLE dim_customer (
    customer_key INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    customer_name VARCHAR(50),
    city VARCHAR(50),
    previous_city VARCHAR(50),
    start_date DATE,
    end_date DATE,
    is_current BOOLEAN
);

INSERT INTO dim_customer
    (customer_id, customer_name, city, previous_city,
     start_date, end_date, is_current)
VALUES
(1, 'Rahul', 'Bengaluru', NULL,
 '2026-01-01', NULL, TRUE);

-- Type 1: overwrite the customer name
UPDATE dim_customer
SET customer_name = 'Rahul Kumar'
WHERE customer_id = 1 AND is_current = TRUE;

-- Type 2: close the old record and add a new version
UPDATE dim_customer
SET end_date = '2026-06-30',
    is_current = FALSE
WHERE customer_id = 1 AND is_current = TRUE;

INSERT INTO dim_customer
    (customer_id, customer_name, city, previous_city,
     start_date, end_date, is_current)
VALUES
(1, 'Rahul Kumar', 'Mysuru', NULL,
 '2026-07-01', NULL, TRUE);

-- Type 3: keep the previous city in a separate column
UPDATE dim_customer
SET previous_city = city,
    city = 'Hubballi'
WHERE customer_id = 1 AND is_current = TRUE;

-- 15. MONTHLY SALES REPORT
SELECT
    YEAR(sale_date) AS sales_year,
    MONTH(sale_date) AS sales_month,
    SUM(amount) AS total_sales
FROM sales
GROUP BY YEAR(sale_date), MONTH(sale_date)
ORDER BY sales_year, sales_month;

-- 16. PRODUCT SALES REPORT
SELECT
    p.product_name,
    SUM(s.quantity) AS total_quantity,
    SUM(s.amount) AS total_revenue
FROM products p
JOIN sales s ON p.product_id = s.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_revenue DESC;

-- 17. CALL THE STORED PROCEDURE
CALL GetSales();

-- 18. VIEW AUDIT RECORDS
SELECT * FROM sales_audit;

-- 19. QUERY EXECUTION PLAN
EXPLAIN
SELECT *
FROM sales
WHERE product_id = 101
  AND sale_date >= '2026-01-01'
  AND sale_date < '2027-01-01';

-- 20. VIEW PARTITION INFORMATION
SELECT
    PARTITION_NAME,
    PARTITION_METHOD
FROM INFORMATION_SCHEMA.PARTITIONS
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'sales';

-- END OF WEEK 6 PROJECT
