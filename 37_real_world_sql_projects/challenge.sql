SQL

```
/*
File: 37_real_world_sql_projects/challenge.sql
Module 37: Real-World SQL Projects

Project: E-commerce Analytics Dashboard
MySQL Version: 8.0+

Business rules:
- Only Completed orders count toward revenue.
- Revenue = quantity * unit_price.
- Historical unit_price is used for sales calculations.
- Pending and Cancelled orders are excluded from sales.
- Customers with no completed orders must remain
  visible in customer-level reports.
*/

-- ============================================================
-- SECTION 1: DATABASE SETUP
-- ============================================================

DROP TEMPORARY TABLE IF EXISTS dashboard_order_items;
DROP TEMPORARY TABLE IF EXISTS dashboard_orders;
DROP TEMPORARY TABLE IF EXISTS dashboard_products;
DROP TEMPORARY TABLE IF EXISTS dashboard_customers;

CREATE TEMPORARY TABLE dashboard_customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    city VARCHAR(50) NOT NULL
);

CREATE TEMPORARY TABLE dashboard_products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    current_price DECIMAL(10, 2) NOT NULL
);

CREATE TEMPORARY TABLE dashboard_orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL
);

CREATE TEMPORARY TABLE dashboard_order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL
);

INSERT INTO dashboard_customers VALUES
    (1, 'Aarav Sharma', 'aarav@example.com', 'Delhi'),
    (2, 'Diya Verma', 'diya@example.com', 'Mumbai'),
    (3, 'Kabir Singh', 'kabir@example.com', 'Delhi'),
    (4, 'Anaya Gupta', 'anaya@example.com', 'Pune'),
    (5, 'Meera Joshi', 'meera@example.com', 'Mumbai'),
    (6, 'Rohan Das', 'rohan@example.com', 'Bengaluru');

INSERT INTO dashboard_products VALUES
    (101, 'Laptop', 'Electronics', 65000.00),
    (102, 'Headphones', 'Electronics', 3000.00),
    (103, 'Office Chair', 'Furniture', 9000.00),
    (104, 'Desk', 'Furniture', 12500.00),
    (105, 'Notebook', 'Stationery', 120.00),
    (106, 'Monitor', 'Electronics', 18000.00);

INSERT INTO dashboard_orders VALUES
    (1001, 1, '2026-01-10', 'Completed'),
    (1002, 2, '2026-01-15', 'Completed'),
    (1003, 1, '2026-02-05', 'Completed'),
    (1004, 3, '2026-02-20', 'Cancelled'),
    (1005, 4, '2026-03-01', 'Completed'),
    (1006, 2, '2026-03-12', 'Pending'),
    (1007, 3, '2026-03-20', 'Completed'),
    (1008, 1, '2026-04-05', 'Completed'),
    (1009, 5, '2026-04-12', 'Completed'),
    (1010, 4, '2026-04-20', 'Completed');

INSERT INTO dashboard_order_items VALUES
    (1, 1001, 101, 1, 63000.00),
    (2, 1001, 102, 2, 2500.00),
    (3, 1002, 103, 1, 8500.00),
    (4, 1002, 105, 10, 100.00),
    (5, 1003, 102, 1, 2300.00),
    (6, 1003, 104, 1, 11500.00),
    (7, 1004, 101, 1, 65000.00),
    (8, 1005, 103, 2, 8200.00),
    (9, 1006, 102, 2, 2400.00),
    (10, 1007, 105, 20, 95.00),
    (11, 1008, 106, 1, 17500.00),
    (12, 1008, 102, 1, 2500.00),
    (13, 1009, 104, 1, 12000.00),
    (14, 1010, 101, 1, 62000.00);


-- ============================================================
-- SECTION 2: REQUIRED BUSINESS REPORTS
-- ============================================================

/*
REPORT 1: EXECUTIVE SALES SUMMARY

Return:
- completed_orders
- total_revenue
- units_sold
- average_order_value

Calculate average_order_value from order totals,
not from individual order items.


REPORT 2: PRODUCT PERFORMANCE

For every product, return:
- product_id
- product_name
- category
- units_sold
- total_revenue

Include products with no completed sales.
Sort by total_revenue descending.


REPORT 3: CUSTOMER LIFETIME VALUE

For every customer, return:
- customer_id
- customer_name
- city
- completed_orders
- total_spent

Include customers with no completed orders.

Rank customers by total_spent within their city.
Use DENSE_RANK() and include ties.


REPORT 4: MONTHLY SALES TRENDS

Return:
- sales_month
- monthly_revenue
- previous_month_revenue
- revenue_change

Use a CTE and LAG().

For this report, compare each month with the
previous available month in the result set.


REPORT 5: CATEGORY PERFORMANCE

For each product category, calculate:
- category
- units_sold
- total_revenue
- percentage_of_total_revenue

Use completed orders only.

The percentage should represent the category's share
of all completed-order revenue.


REPORT 6: TOP PRODUCTS

Find the top two products by revenue within each
category.

Requirements:
- Use a CTE.
- Use DENSE_RANK().
- Include ties at the second rank.
- Exclude products with no completed sales.


REPORT 7: CUSTOMER RETENTION SIGNALS

Identify customers who placed completed orders
in at least two different calendar months.

Return:
- customer_id
- customer_name
- active_order_months
- total_spent

Count distinct calendar months, not individual orders.


REPORT 8: DATA QUALITY REVIEW

Write queries to identify:

- Orders without any order items.
- Products without completed sales.
- Customers without completed orders.
- Order items with zero or negative quantities.
- Order items with negative unit prices.

Explain which issues should be prevented by database
constraints and which require business-level validation.
*/


-- ============================================================
-- SECTION 3: VALIDATION CHECKS
-- ============================================================

/*
Use these checks to validate your reports.

1. Count completed orders:

SELECT COUNT(*) AS completed_orders
FROM dashboard_orders
WHERE status = 'Completed';

Expected: 8


2. Calculate total completed revenue:

SELECT SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM dashboard_orders AS o
JOIN dashboard_order_items AS oi
    ON o.order_id = oi.order_id
WHERE o.status = 'Completed';

Expected: 153390.00


3. Count units sold in completed orders:

SELECT SUM(oi.quantity) AS units_sold
FROM dashboard_orders AS o
JOIN dashboard_order_items AS oi
    ON o.order_id = oi.order_id
WHERE o.status = 'Completed';

Expected: 21


4. Verify that Pending and Cancelled orders
   are excluded from revenue.


5. Verify that all six customers appear in the
   customer lifetime value report.


6. Verify that the category revenue percentages
   sum to approximately 100%, allowing for rounding.


7. Verify that product rankings restart for
   each category.


8. Verify that the source data has not been modified.
*/


-- ============================================================
-- SECTION 4: OPTIONAL EXTENSIONS
-- ============================================================

/*
Extend the project with one or more of these features:

1. Create a permanent database and permanent tables
   instead of temporary tables.

2. Add foreign keys and CHECK constraints.

3. Add indexes based on report query patterns.

4. Use EXPLAIN to inspect a report query.

5. Create a VIEW for a reusable sales summary.

6. Create a stored procedure that accepts a date range.

7. Add discounts, refunds, shipping costs, or taxes
   and clearly define how they affect revenue.

8. Export report results for a portfolio dashboard.
*/


-- ============================================================
-- CLEANUP
-- ============================================================

/*
Run after completing and validating the project.

DROP TEMPORARY TABLE IF EXISTS dashboard_order_items;
DROP TEMPORARY TABLE IF EXISTS dashboard_orders;
DROP TEMPORARY TABLE IF EXISTS dashboard_products;
DROP TEMPORARY TABLE IF EXISTS dashboard_customers;
*/
```
