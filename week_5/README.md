# Week 5 - SQL Dimensional Report

## 📌 Project Overview

This project focuses on advanced SQL concepts using a small e-commerce
dimensional database.

The database follows a **Star Schema**, where a central fact table stores
sales transactions and dimension tables provide information about dates,
customers, and products.

The project demonstrates how SQL can be used for analytical reporting,
ranking, monthly analysis, aggregation, and query optimization.

---

## 🎯 Objectives

The main objectives of this project are:

- Understand dimensional modelling and Star Schema.
- Work with fact and dimension tables.
- Use subqueries and correlated subqueries.
- Use `EXISTS` for checking related records.
- Perform ranking using window functions.
- Compare current and previous records using `LAG()`.
- Compare current and next records using `LEAD()`.
- Divide records into groups using `NTILE()`.
- Use CTEs for structured queries.
- Calculate month-over-month revenue changes.
- Perform aggregation using `ROLLUP`.
- Combine query results using `UNION`.
- Create SQL views.
- Analyze query execution using `EXPLAIN`.

---

# 🏗️ Database Design

The database is named:

```sql
ecommerce_dw

The project contains four main tables.
1. dim_date
Stores information about dates.
Important columns:
- date_key
- full_date
- day_number
- month_number
- month_name
- quarter_number
- year_number
2. dim_customer
Stores customer information.
Important columns:
- customer_key
- customer_id
- customer_name
- city
- state
- customer_segment
3. dim_product
Stores product information.
Important columns:
- product_key
- product_id
- product_name
- category
- subcategory
- price
4. fact_sales
The central fact table containing sales transactions.
Important columns:
- sales_key
- date_key
- customer_key
- product_key
- order_id
- quantity
- unit_price
- discount
- revenue
The foreign keys connect the fact table with the dimension tables.
⭐ Star Schema
The database follows a Star Schema:
                    dim_date
                       |
                       |
                       |
dim_customer ---- fact_sales ---- dim_product

fact_sales is the central table, while the three dimension tables provide
descriptive information about each sale.
📂 Project Structure
week_5/
│
├── schema.sql
├── data.sql
├── queries.sql
└── README.md

schema.sql
Creates the database, tables, constraints, and indexes.
data.sql
Inserts sample dates, customers, products, and sales transactions.
queries.sql
Contains the analytical SQL queries used to demonstrate Week 5 concepts.
README.md
Contains the project documentation and instructions.
🧠 SQL Concepts Demonstrated
1. Subqueries
Subqueries are used to compare values against calculated results.
Example:
SELECT product_name, price
FROM dim_product
WHERE price > (
    SELECT AVG(price)
    FROM dim_product
);

This finds products whose price is greater than the average product price.
2. Correlated Subquery
A correlated subquery uses values from the outer query.
It can be used to compare a product against the average price of products
in the same category.
3. EXISTS
EXISTS checks whether a related record exists.
For example, it can be used to find customers who have made at least one
purchase.
4. Window Functions
Window functions perform calculations across related rows without
combining those rows into a single result.
The project demonstrates:
- RANK()
- DENSE_RANK()
- LAG()
- LEAD()
- NTILE()
Example:
RANK() OVER (
    ORDER BY SUM(f.revenue) DESC
)

This ranks products based on their total revenue.
5. CTE
A Common Table Expression (WITH) makes complex queries easier to
understand and organize.
Example:
WITH monthly AS (
    SELECT ...
)
SELECT *
FROM monthly;

6. Month-over-Month Analysis
The project uses LAG() with a CTE to compare monthly revenue with the
previous month's revenue.
This helps identify whether revenue increased or decreased between months.
7. NTILE
NTILE(4) divides customers into four groups based on their spending.
This can be used to identify different customer spending levels.
8. ROLLUP
ROLLUP produces summary rows along with grouped results.
Example:
GROUP BY p.category WITH ROLLUP;

This provides category-level totals and an overall total.
9. Views
A view is created to simplify access to customer sales information.
Example:
CREATE OR REPLACE VIEW customer_sales AS
SELECT ...

The view can then be queried like a normal table.
10. EXPLAIN
EXPLAIN is used to understand how MySQL executes a query.
It helps analyze:
- Table access
- Index usage
- Join operations
- Query execution strategy
Example:
EXPLAIN
SELECT *
FROM fact_sales
WHERE date_key = 20260101;

▶️ How to Run
Make sure MySQL is installed and running.
Execute the SQL files in the following order:
Step 1 - Create Database and Tables
Run:
schema.sql

Step 2 - Insert Data
Run:
data.sql

Step 3 - Run Analytical Queries
Run:
queries.sql

The order is important because the queries depend on the tables and data
created by the first two files.
📊 Expected Analysis
After running the queries, the project can answer questions such as:
- Which products generate the highest revenue?
- How are products ranked within their categories?
- Which customers have the highest spending?
- What was the previous month's revenue?
- What is the change in revenue between months?
- Which customer belongs to each spending quartile?
- What is the total revenue for each category?
- Which customers have made purchases?
- How does MySQL execute a particular query?
🛠️ Technologies Used
- Database: MySQL
- Language: SQL
- Concept: Dimensional Modelling / Star Schema
- Tools: MySQL Workbench / MySQL CLI
📚 Learning Outcomes
After completing this project, I gained practical experience with:
- Designing a dimensional database.
- Working with fact and dimension tables.
- Writing advanced SQL queries.
- Using window functions for analytical reports.
- Using CTEs for complex queries.
- Performing month-over-month analysis.
- Generating summaries using ROLLUP.
- Creating reusable SQL views.
- Understanding basic query optimization using EXPLAIN.