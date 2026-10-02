SQL

```
/*
File: 37_real_world_sql_projects/examples.sql
Module 37: Real-World SQL Projects
MySQL Version: 8.0+
*/

-- ============================================================
-- SETUP
-- ============================================================

DROP TEMPORARY TABLE IF EXISTS order_items;
DROP TEMPORARY TABLE IF EXISTS orders;
DROP TEMPORARY TABLE IF EXISTS products;
DROP TEMPORARY TABLE IF EXISTS customers;

CREATE TEMPORARY TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    city VARCHAR(50) NOT NULL
);

CREATE TEMPORARY TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);

CREATE TEMPORARY TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL
);

CREATE TEMPORARY TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL
);

INSERT INTO customers VALUES
    (1, 'Aarav Sharma', 'aarav@example.com', 'Delhi'),
    (2, 'Diya Verma', 'diya@example.com', 'Mumbai'),
    (3, 'Kabir Singh', 'kabir@example.com', 'Delhi'),
    (4, 'Anaya Gupta', 'anaya@example.com', 'Pune'),
    (5, 'Meera Joshi', 'meera@example.com', 'Mumbai');

INSERT INTO products VALUES
    (101, 'Laptop', 'Electronics', 65000.00),
    (102, 'Headphones', 'Electronics', 2500.00),
    (103, 'Office Chair', 'Furniture', 8500.00),
    (104, 'Desk', 'Furniture', 12000.00),
    (105, 'Notebook', 'Stationery', 100.00);

INSERT INTO orders VALUES
    (1001, 1, '2026-01-10', 'Completed'),
    (1002, 2, '2026-01-15', 'Completed'),
    (1003, 1, '2026-02-05', 'Completed'),
    (1004, 3, '2026-02-20', 'Cancelled'),
    (1005, 4, '2026-03-01', 'Completed'),
    (1006, 2, '2026-03-12', 'Pending'),
    (1007, 3, '2026-03-20', 'Completed');

INSERT INTO order_items VALUES
    (1, 1001, 101, 1, 63000.00),
    (2, 1001, 102, 2, 2200.00),
    (3, 1002, 103, 1, 8000.00),
    (4, 1002, 105, 10, 90.00),
    (5, 1003, 102, 1, 2300.00),
    (6, 1003, 104, 1, 11500.00),
    (7, 1004, 101, 1, 65000.00),
    (8, 1005, 103, 2, 8200.00),
    (9, 1006, 102, 2, 2400.00),
    (10, 1007, 105, 20, 95.00);


-- ============================================================
-- REPORT 1: OVERALL SALES SUMMARY
-- ============================================================

SELECT
    COUNT(DISTINCT o.order_id) AS completed_orders,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
WHERE o.status = 'Completed';


-- ============================================================
-- REPORT 2: REVENUE BY PRODUCT
-- ============================================================

SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS units_sold,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM products AS p
JOIN order_items AS oi
    ON p.product_id = oi.product_id
JOIN orders AS o
    ON oi.order_id = o.order_id
WHERE o.status = 'Completed'
GROUP BY p.product_id, p.product_name
ORDER BY total_revenue DESC;


-- ============================================================
-- REPORT 3: CUSTOMER SPENDING
-- Include customers with zero completed orders.
-- ============================================================

SELECT
    c.customer_id,
    c.customer_name,
    COUNT(DISTINCT o.order_id) AS completed_orders,
    COALESCE(
        SUM(oi.quantity * oi.unit_price),
        0.00
    ) AS total_spent
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
   AND o.status = 'Completed'
LEFT JOIN order_items AS oi
    ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spent DESC, c.customer_id;


-- ============================================================
-- REPORT 4: MONTHLY REVENUE
-- ============================================================

SELECT
    DATE_FORMAT(o.order_date, '%Y-%m') AS sales_month,
    SUM(oi.quantity * oi.unit_price) AS monthly_revenue
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
WHERE o.status = 'Completed'
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY sales_month;


-- ============================================================
-- REPORT 5: AVERAGE ORDER VALUE
-- ============================================================

WITH order_totals AS (
    SELECT
        o.order_id,
        SUM(oi.quantity * oi.unit_price) AS order_total
    FROM orders AS o
    JOIN order_items AS oi
        ON o.order_id = oi.order_id
    WHERE o.status = 'Completed'
    GROUP BY o.order_id
)
SELECT
    COUNT(*) AS completed_orders,
    AVG(order_total) AS average_order_value
FROM order_totals;


-- ============================================================
-- REPORT 6: TOP PRODUCT IN EACH CATEGORY
-- Include ties.
-- ============================================================

WITH product_revenue AS (
    SELECT
        p.product_id,
        p.product_name,
        p.category,
        SUM(oi.quantity * oi.unit_price) AS revenue
    FROM products AS p
    JOIN order_items AS oi
        ON p.product_id = oi.product_id
    JOIN orders AS o
        ON oi.order_id = o.order_id
    WHERE o.status = 'Completed'
    GROUP BY p.product_id, p.product_name, p.category
),
ranked_products AS (
    SELECT
        *,
        DENSE_RANK() OVER (
            PARTITION BY category
            ORDER BY revenue DESC
        ) AS category_rank
    FROM product_revenue
)
SELECT
    product_name,
    category,
    revenue
FROM ranked_products
WHERE category_rank = 1
ORDER BY category, product_name;


-- ============================================================
-- REPORT 7: CUSTOMERS WITHOUT COMPLETED ORDERS
-- ============================================================

SELECT
    c.customer_id,
    c.customer_name
FROM customers AS c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders AS o
    WHERE o.customer_id = c.customer_id
      AND o.status = 'Completed'
);


-- ============================================================
-- CLEANUP
-- ============================================================

DROP TEMPORARY TABLE IF EXISTS order_items;
DROP TEMPORARY TABLE IF EXISTS orders;
DROP TEMPORARY TABLE IF EXISTS products;
DROP TEMPORARY TABLE IF EXISTS customers;
```
