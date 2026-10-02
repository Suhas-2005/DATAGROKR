-- ============================================
-- WEEK 4 SQL E-COMMERCE PROJECT
-- SAMPLE DATA
-- ============================================

USE ecommerce_db;

-- ============================================
-- CUSTOMERS
-- ============================================

INSERT INTO customers
(name, email, phone, city)
VALUES
('Rahul Sharma', 'rahul@gmail.com', '9876543210', 'Bangalore'),
('Priya Nair', 'priya@gmail.com', '9876543211', 'Mumbai'),
('Arjun Kumar', 'arjun@gmail.com', NULL, 'Delhi'),
('Sneha Reddy', 'sneha@gmail.com', '9876543213', 'Hyderabad'),
('Karan Singh', 'karan@gmail.com', NULL, 'Chennai'),
('Ananya Das', 'ananya@gmail.com', '9876543215', 'Kolkata'),
('Vikram Rao', 'vikram@gmail.com', '9876543216', 'Pune'),
('Neha Patel', 'neha@gmail.com', NULL, 'Ahmedabad'),
('Rohit Verma', 'rohit@gmail.com', '9876543218', 'Bangalore'),
('Meera Joshi', 'meera@gmail.com', '9876543219', 'Jaipur');

-- ============================================
-- PRODUCTS
-- ============================================

INSERT INTO products
(product_name, category, price, stock)
VALUES
('Laptop', 'Electronics', 55000.00, 10),
('Smartphone', 'Electronics', 30000.00, 20),
('Headphones', 'Electronics', 2500.00, 50),
('Keyboard', 'Accessories', 1500.00, 35),
('Mouse', 'Accessories', 800.00, 60),
('Monitor', 'Electronics', 12000.00, 15),
('Smart Watch', 'Wearables', 5000.00, 25),
('Backpack', 'Accessories', 1800.00, 40),
('Tablet', 'Electronics', 22000.00, 12),
('Power Bank', 'Accessories', 2000.00, 30);

-- ============================================
-- ORDERS
-- ============================================

INSERT INTO orders
(customer_id, order_date, status)
VALUES
(1, '2026-09-01', 'Delivered'),
(2, '2026-09-02', 'Delivered'),
(1, '2026-09-05', 'Delivered'),
(3, '2026-09-07', 'Pending'),
(4, '2026-09-10', 'Shipped'),
(5, '2026-09-12', 'Delivered'),
(6, '2026-09-15', 'Delivered'),
(7, '2026-09-18', 'Pending'),
(9, '2026-09-20', 'Delivered'),
(10, '2026-09-22', 'Shipped'),
(2, '2026-09-25', 'Delivered'),
(4, '2026-09-27', 'Pending');

-- ============================================
-- ORDER ITEMS
-- ============================================

INSERT INTO order_items
(order_id, product_id, quantity)
VALUES
(1, 1, 1),
(1, 3, 2),

(2, 2, 1),
(2, 5, 2),

(3, 6, 1),
(3, 4, 1),

(4, 7, 2),

(5, 1, 1),
(5, 8, 1),

(6, 9, 1),
(6, 3, 1),

(7, 2, 1),
(7, 7, 1),

(8, 10, 2),
(8, 5, 1),

(9, 1, 1),
(9, 6, 1),

(10, 8, 2),
(10, 4, 1),

(11, 2, 1),
(11, 3, 2),

(12, 9, 1),
(12, 10, 1);