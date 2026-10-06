-- ============================================================
-- WEEK 5 SQL DIMENSIONAL REPORT
-- MYSQL DATABASE SCHEMA
-- ============================================================

-- Create database
CREATE DATABASE IF NOT EXISTS ecommerce_dw;

USE ecommerce_dw;


-- ============================================================
-- DIMENSION 1: DATE
-- ============================================================

CREATE TABLE dim_date (
    date_key INT PRIMARY KEY,
    full_date DATE NOT NULL UNIQUE,
    day_number INT NOT NULL,
    month_number INT NOT NULL,
    month_name VARCHAR(20) NOT NULL,
    quarter_number INT NOT NULL,
    year_number INT NOT NULL
);


-- ============================================================
-- DIMENSION 2: CUSTOMER
-- ============================================================

CREATE TABLE dim_customer (
    customer_key INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL UNIQUE,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    state VARCHAR(50),
    customer_segment VARCHAR(30)
);


-- ============================================================
-- DIMENSION 3: PRODUCT
-- ============================================================

CREATE TABLE dim_product (
    product_key INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL UNIQUE,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    subcategory VARCHAR(50),
    price DECIMAL(10,2) NOT NULL,
    
    CONSTRAINT chk_product_price
        CHECK (price > 0)
);


-- ============================================================
-- FACT TABLE: SALES
-- ============================================================

CREATE TABLE fact_sales (
    sales_key BIGINT PRIMARY KEY AUTO_INCREMENT,

    date_key INT NOT NULL,
    customer_key INT NOT NULL,
    product_key INT NOT NULL,

    order_id INT NOT NULL,
    order_item_id INT NOT NULL,

    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    discount DECIMAL(10,2) DEFAULT 0.00,
    revenue DECIMAL(12,2) NOT NULL,

    CONSTRAINT fk_sales_date
        FOREIGN KEY (date_key)
        REFERENCES dim_date(date_key),

    CONSTRAINT fk_sales_customer
        FOREIGN KEY (customer_key)
        REFERENCES dim_customer(customer_key),

    CONSTRAINT fk_sales_product
        FOREIGN KEY (product_key)
        REFERENCES dim_product(product_key),

    CONSTRAINT chk_sales_quantity
        CHECK (quantity > 0),

    CONSTRAINT chk_sales_price
        CHECK (unit_price > 0),

    CONSTRAINT chk_sales_discount
        CHECK (discount >= 0),

    CONSTRAINT chk_sales_revenue
        CHECK (revenue >= 0)
);


-- ============================================================
-- INDEXES
-- ============================================================

-- Index for date-based analysis
CREATE INDEX idx_sales_date
ON fact_sales(date_key);


-- Index for customer-based analysis
CREATE INDEX idx_sales_customer
ON fact_sales(customer_key);


-- Index for product-based analysis
CREATE INDEX idx_sales_product
ON fact_sales(product_key);


-- Index for order analysis
CREATE INDEX idx_sales_order
ON fact_sales(order_id);


-- Composite index for common analytical queries
CREATE INDEX idx_sales_date_product
ON fact_sales(date_key, product_key);


-- ============================================================
-- VERIFY TABLES
-- ============================================================

SHOW TABLES;


-- Check table structures
DESCRIBE dim_date;

DESCRIBE dim_customer;

DESCRIBE dim_product;

DESCRIBE fact_sales;