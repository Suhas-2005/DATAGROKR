# Week 4 SQL E-Commerce Project

## Project Overview

This project is an SQL-based E-Commerce database designed to practice
and demonstrate the Week 4 SQL concepts.

The project covers:

- SELECT
- WHERE
- ORDER BY
- LIMIT
- Aliases
- NULL handling
- COALESCE
- NULLIF
- Aggregate functions
- GROUP BY
- HAVING
- INNER JOIN
- LEFT JOIN
- RIGHT JOIN
- FULL OUTER JOIN concept
- CASE WHEN
- String functions
- Date functions
- DDL
- Constraints
- ALTER TABLE
- Customer spending analysis
- Top product analysis
- Order analysis

---

# Project Structure

```text
week_4/
│
├── schema.sql
├── data.sql
├── queries.sql
└── README.md
Database Structure

The database contains four main tables:

customers
    |
    | 1
    |
    | many
  orders
    |
    | 1
    |
    | many
order_items
    |
    | many
    |
    | 1
 products
Tables
1. customers

Stores customer information.

Column	Description
customer_id	Unique customer ID
name	Customer name
email	Customer email
phone	Customer phone number
city	Customer city
created_at	Account creation date
2. products

Stores product information.

Column	Description
product_id	Unique product ID
product_name	Name of product
category	Product category
price	Product price
stock	Available stock
3. orders

Stores customer orders.

Column	Description
order_id	Unique order ID
customer_id	Customer who placed the order
order_date	Date of order
status	Order status
4. order_items

Stores products belonging to each order.

Column	Description
order_item_id	Unique order item ID
order_id	Related order
product_id	Related product
quantity	Quantity purchased
Database Relationships
customers
   |
   | customer_id
   |
   v
orders
   |
   | order_id
   |
   v
order_items
   |
   | product_id
   |
   v
products
Relationships
One customer can place many orders.
One order can contain many order items.
One product can appear in many order items.
Constraints Used

The project demonstrates the following SQL constraints:

PRIMARY KEY

Uniquely identifies each row.

customer_id INT PRIMARY KEY
NOT NULL

Prevents a column from containing NULL values.

name VARCHAR(100) NOT NULL
UNIQUE

Prevents duplicate values.

email VARCHAR(100) UNIQUE
DEFAULT

Provides a default value.

stock INT DEFAULT 0
CHECK

Restricts values based on a condition.

CHECK (price > 0)
FOREIGN KEY

Creates a relationship between tables.

FOREIGN KEY (customer_id)
REFERENCES customers(customer_id)
SQL Concepts Demonstrated
1. SELECT

Used to retrieve data.

SELECT name, city
FROM customers;
2. WHERE

Used to filter rows.

SELECT product_name, price
FROM products
WHERE price > 10000;
3. ORDER BY

Used to sort results.

SELECT product_name, price
FROM products
ORDER BY price DESC;
4. LIMIT

Used to restrict the number of returned rows.

SELECT product_name, price
FROM products
ORDER BY price DESC
LIMIT 3;
5. Aliases

Used to give temporary names to columns or tables.

SELECT
    product_name AS Product,
    price AS Product_Price
FROM products;
NULL Handling
IS NULL

Finds NULL values.

SELECT *
FROM customers
WHERE phone IS NULL;
IS NOT NULL

Finds values that are not NULL.

SELECT *
FROM customers
WHERE phone IS NOT NULL;
COALESCE

Returns the first non-NULL value.

SELECT
    name,
    COALESCE(phone, 'Not Available') AS phone
FROM customers;
NULLIF

Returns NULL when two values are equal.

SELECT
    NULLIF(price, 30000)
FROM products;
Aggregate Functions

The project uses:

COUNT()
SUM()
AVG()
MIN()
MAX()

Example:

SELECT AVG(price)
FROM products;
GROUP BY

Used to group rows before performing aggregate calculations.

Example:

SELECT
    category,
    COUNT(*) AS product_count
FROM products
GROUP BY category;
HAVING

Used to filter groups after GROUP BY.

Example:

SELECT
    category,
    COUNT(*) AS product_count
FROM products
GROUP BY category
HAVING COUNT(*) > 2;
JOINs
INNER JOIN

Returns matching records from both tables.

SELECT
    o.order_id,
    c.name
FROM orders AS o
INNER JOIN customers AS c
    ON o.customer_id = c.customer_id;
LEFT JOIN

Returns all rows from the left table and matching rows from the right table.

SELECT
    c.name,
    o.order_id
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id;
RIGHT JOIN

Returns all rows from the right table and matching rows from the left table.

SELECT
    c.name,
    o.order_id
FROM customers AS c
RIGHT JOIN orders AS o
    ON c.customer_id = o.customer_id;
FULL OUTER JOIN

Returns all matching and non-matching rows from both tables.

MySQL does not directly support FULL OUTER JOIN, so it can be represented using a combination of LEFT JOIN and RIGHT JOIN with UNION.

CASE WHEN

Used to create conditional output.

Example:

SELECT
    product_name,
    price,
    CASE
        WHEN price >= 30000 THEN 'Expensive'
        WHEN price >= 10000 THEN 'Medium'
        ELSE 'Affordable'
    END AS price_category
FROM products;
String Functions

The project demonstrates:

UPPER()
LOWER()
LENGTH()
CONCAT()
SUBSTRING()

Example:

SELECT
    name,
    UPPER(name) AS uppercase_name
FROM customers;
Date Functions

The project demonstrates:

CURRENT_DATE
CURRENT_TIMESTAMP
YEAR()
MONTH()
DAY()

Example:

SELECT
    order_id,
    YEAR(order_date) AS order_year
FROM orders;
Business Analysis

The project performs several e-commerce analyses.

Top Products

Find products with the highest number of units sold.

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
Customer Spending

Calculate the total amount spent by each customer.

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
ORDER BY total_spent DESC;
Order Trends

Count orders by date.

SELECT
    order_date,
    COUNT(*) AS order_count
FROM orders
GROUP BY order_date
ORDER BY order_date;
How to Run the Project
Step 1: Create the database

Run:

schema.sql

This creates the database and tables.

Step 2: Insert the data

Run:

data.sql

This inserts the sample customers, products, orders and order items.

Step 3: Run the queries

Run:

queries.sql

This contains the SQL analysis queries.

Project Learning Outcomes

After completing this project, the following SQL concepts should be familiar:

Retrieving data using SELECT
Filtering data using WHERE
Sorting data using ORDER BY
Limiting results using LIMIT
Using column and table aliases
Handling NULL values
Using COALESCE and NULLIF
Using aggregate functions
Grouping data using GROUP BY
Filtering groups using HAVING
Joining multiple tables
Using INNER JOIN
Using LEFT JOIN
Using RIGHT JOIN
Understanding FULL OUTER JOIN
Using CASE WHEN
Using string functions
Using date functions
Creating tables
Applying SQL constraints
Modifying tables using ALTER TABLE
Performing customer spending analysis
Finding top-selling products
Analyzing order trends
Project Files
schema.sql

Contains:

Database creation
Table creation
Primary keys
Foreign keys
NOT NULL
UNIQUE
DEFAULT
CHECK constraints
data.sql

Contains sample:

Customers
Products
Orders
Order items
queries.sql

Contains the complete Week 4 SQL query practice and e-commerce analysis.

README.md

Contains project documentation and explanation.

Conclusion

This project demonstrates how SQL can be used to create,
manage and analyze an e-commerce database.

It combines basic SQL queries, NULL handling,
aggregation, grouping, joins, conditional expressions,
string/date functions and database constraints
into one practical project.