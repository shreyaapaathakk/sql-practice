SQL

```
/*
File: 37_real_world_sql_projects/practice.sql
Module 37: Real-World SQL Projects

Run this setup before solving the questions in solutions.sql.
*/

-- ============================================================
-- SETUP
-- ============================================================

DROP TEMPORARY TABLE IF EXISTS project_order_items;
DROP TEMPORARY TABLE IF EXISTS project_orders;
DROP TEMPORARY TABLE IF EXISTS project_products;
DROP TEMPORARY TABLE IF EXISTS project_customers;

CREATE TEMPORARY TABLE project_customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL
);

CREATE TEMPORARY TABLE project_products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);

CREATE TEMPORARY TABLE project_orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL
);

CREATE TEMPORARY TABLE project_order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL
);

INSERT INTO project_customers VALUES
    (1, 'Aarav', 'Delhi'),
    (2, 'Diya', 'Mumbai'),
    (3, 'Kabir', 'Delhi'),
    (4, 'Anaya', 'Pune'),
    (5, 'Meera', 'Mumbai');

INSERT INTO project_products VALUES
    (101, 'Laptop', 'Electronics', 60000.00),
    (102, 'Mouse', 'Electronics', 1000.00),
    (103, 'Chair', 'Furniture', 7000.00),
    (104, 'Desk', 'Furniture', 10000.00);

INSERT INTO project_orders VALUES
    (201, 1, '2026-01-10', 'Completed'),
    (202, 2, '2026-01-15', 'Completed'),
    (203, 1, '2026-02-05', 'Completed'),
    (204, 3, '2026-02-20', 'Cancelled'),
    (205, 4, '2026-03-01', 'Completed'),
    (206, 2, '2026-03-12', 'Pending'),
    (207, 3, '2026-03-20', 'Completed');

INSERT INTO project_order_items VALUES
    (1, 201, 101, 1, 58000.00),
    (2, 201, 102, 2, 900.00),
    (3, 202, 103, 1, 6500.00),
    (4, 203, 102, 3, 950.00),
    (5, 203, 104, 1, 9500.00),
    (6, 204, 101, 1, 60000.00),
    (7, 205, 103, 2, 6800.00),
    (8, 206, 102, 2, 1000.00),
    (9, 207, 104, 1, 9000.00);


-- ============================================================
-- TASK 1: TOTAL COMPLETED REVENUE
-- ============================================================

/*
Return total revenue from Completed orders only.

Output:
- total_revenue
*/


-- ============================================================
-- TASK 2: PRODUCT PERFORMANCE
-- ============================================================

/*
For each product, return:
- product_id
- product_name
- units_sold
- total_revenue

Include only completed orders.
Sort by total_revenue descending.
*/


-- ============================================================
-- TASK 3: CUSTOMER LIFETIME VALUE
-- ============================================================

/*
For every customer, return:
- customer_id
- customer_name
- completed_orders
- total_spent

Include customers with no completed orders.
Represent missing totals as zero.
*/


-- ============================================================
-- TASK 4: MONTHLY SALES
-- ============================================================

/*
Return revenue by month for completed orders.

Output:
- sales_month (YYYY-MM)
- monthly_revenue

Sort chronologically.
*/


-- ============================================================
-- TASK 5: AVERAGE ORDER VALUE
-- ============================================================

/*
Calculate average order value using completed orders.

First calculate the total for each order, then average
those order totals.

Return:
- completed_orders
- average_order_value
*/


-- ============================================================
-- TASK 6: TOP PRODUCT PER CATEGORY
-- ============================================================

/*
Find the product or products with the highest completed
sales revenue in each category.

Requirements:
- Use a CTE.
- Use DENSE_RANK().
- Include ties.
- Return product_name, category, revenue.
*/


-- ============================================================
-- TASK 7: CUSTOMERS WITHOUT COMPLETED ORDERS
-- ============================================================

/*
Find customers who have no completed orders.

A customer with only Pending or Cancelled orders
should be included.

Return customer_id and customer_name.
*/


-- ============================================================
-- CLEANUP
-- ============================================================

/*
DROP TEMPORARY TABLE IF EXISTS project_order_items;
DROP TEMPORARY TABLE IF EXISTS project_orders;
DROP TEMPORARY TABLE IF EXISTS project_products;
DROP TEMPORARY TABLE IF EXISTS project_customers;
*/
```
