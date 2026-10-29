# Week 6 — SQL Data Engineering Pipeline

## Project Overview
This project demonstrates advanced SQL concepts using MySQL. It simulates a simple sales data pipeline involving product management, sales transactions, data loading, and query optimization.

## Technologies Used
- MySQL
- SQL
- CSV

## Project Files
- `week_6.sql` — SQL script containing database setup, sample data, UPSERT, partitioning, indexing, transactions, stored procedures, triggers, JSON operations, and sales reports.
- `sales.csv` — Sample sales data for bulk loading.

## Concepts Covered
1. INSERT, UPDATE, and DELETE
2. UPSERT using `INSERT ... ON DUPLICATE KEY UPDATE`
3. CSV bulk loading
4. Range partitioning
5. Composite indexes and `EXPLAIN`
6. Transactions and ACID concepts
7. Stored procedures and triggers
8. JSON queries
9. Monthly sales and product revenue reports
10. Fact and dimension table concepts

## How to Run
1. Install MySQL Server and open MySQL Workbench.
2. Open `week_6.sql`.
3. Ensure `sales.csv` is accessible and local file loading is configured.
4. Execute the SQL script in the intended order.
5. Review the resulting tables, audit records, and sales reports.

**Note:** This is an educational project. Some SQL statements may require adjustments depending on your MySQL version and configuration.

## Expected Outcome
A small sales database demonstrating data manipulation, data loading, partitioning, indexing, and analytical reporting using MySQL.

