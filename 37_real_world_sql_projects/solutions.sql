SQL

```
/*
File: 37_real_world_sql_projects/solutions.sql
Module 37: Real-World SQL Projects

Requires the setup from practice.sql.
*/

-- ============================================================
-- SOLUTION 1: TOTAL COMPLETED REVENUE
-- ============================================================

SELECT
    COALESCE(
        SUM(oi.quantity * oi.unit_price),
        0.00
    ) AS total_revenue
FROM project_orders AS o
JOIN project_order_items AS oi
    ON o.order_id = oi.order_id
WHERE o.status = 'Completed';


-- ============================================================
-- SOLUTION 2: PRODUCT PERFORMANCE
-- Include products with zero completed sales.
-- ============================================================

SELECT
    p.product_id,
    p.product_name,
    COALESCE(SUM(
        CASE
            WHEN o.status = 'Completed'
            THEN oi.quantity
            ELSE 0
        END
    ), 0) AS units_sold,
    COALESCE(SUM(
        CASE
            WHEN o.status = 'Completed'
            THEN oi.quantity * oi.unit_price
            ELSE 0
        END
    ), 0.00) AS total_revenue
FROM project_products AS p
LEFT JOIN project_order_items AS oi
    ON p.product_id = oi.product_id
LEFT JOIN project_orders AS o
    ON oi.order_id = o.order_id
GROUP BY p.product_id, p.product_name
ORDER BY total_revenue DESC, p.product_id;


-- ============================================================
-- SOLUTION 3: CUSTOMER LIFETIME VALUE
-- ============================================================

SELECT
    c.customer_id,
    c.customer_name,
    COUNT(DISTINCT o.order_id) AS completed_orders,
    COALESCE(
        SUM(oi.quantity * oi.unit_price),
        0.00
    ) AS total_spent
FROM project_customers AS c
LEFT JOIN project_orders AS o
    ON c.customer_id = o.customer_id
   AND o.status = 'Completed'
LEFT JOIN project_order_items AS oi
    ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spent DESC, c.customer_id;


-- ============================================================
-- SOLUTION 4: MONTHLY SALES
-- ============================================================

SELECT
    DATE_FORMAT(o.order_date, '%Y-%m') AS sales_month,
    SUM(oi.quantity * oi.unit_price) AS monthly_revenue
FROM project_orders AS o
JOIN project_order_items AS oi
    ON o.order_id = oi.order_id
WHERE o.status = 'Completed'
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY sales_month;


-- ============================================================
-- SOLUTION 5: AVERAGE ORDER VALUE
-- ============================================================

WITH order_totals AS (
    SELECT
        o.order_id,
        SUM(oi.quantity * oi.unit_price) AS order_total
    FROM project_orders AS o
    JOIN project_order_items AS oi
        ON o.order_id = oi.order_id
    WHERE o.status = 'Completed'
    GROUP BY o.order_id
)
SELECT
    COUNT(*) AS completed_orders,
    AVG(order_total) AS average_order_value
FROM order_totals;


-- ============================================================
-- SOLUTION 6: TOP PRODUCT PER CATEGORY
-- Include ties.
-- ============================================================

WITH product_revenue AS (
    SELECT
        p.product_id,
        p.product_name,
        p.category,
        SUM(oi.quantity * oi.unit_price) AS revenue
    FROM project_products AS p
    JOIN project_order_items AS oi
        ON p.product_id = oi.product_id
    JOIN project_orders AS o
        ON oi.order_id = o.order_id
    WHERE o.status = 'Completed'
    GROUP BY
        p.product_id,
        p.product_name,
        p.category
),
ranked_products AS (
    SELECT
        product_id,
        product_name,
        category,
        revenue,
        DENSE_RANK() OVER (
            PARTITION BY category
            ORDER BY revenue DESC
        ) AS revenue_rank
    FROM product_revenue
)
SELECT
    product_name,
    category,
    revenue
FROM ranked_products
WHERE revenue_rank = 1
ORDER BY category, product_name;


-- ============================================================
-- SOLUTION 7: CUSTOMERS WITHOUT COMPLETED ORDERS
-- ============================================================

SELECT
    c.customer_id,
    c.customer_name
FROM project_customers AS c
WHERE NOT EXISTS (
    SELECT 1
    FROM project_orders AS o
    WHERE o.customer_id = c.customer_id
      AND o.status = 'Completed'
)
ORDER BY c.customer_id;


-- ============================================================
-- CLEANUP
-- ============================================================

DROP TEMPORARY TABLE IF EXISTS project_order_items;
DROP TEMPORARY TABLE IF EXISTS project_orders;
DROP TEMPORARY TABLE IF EXISTS project_products;
DROP TEMPORARY TABLE IF EXISTS project_customers;
```
