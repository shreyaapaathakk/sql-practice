USE sales_analysis;

-- ============================================================
-- SALES ANALYSIS PROJECT
-- File: queries.sql
-- Description: Business-focused SQL queries
-- SQL Dialect: MySQL 8.0+
-- ============================================================


-- ============================================================
-- 1. BASIC SALES KPIs
-- ============================================================

-- 1.1 Total number of orders
SELECT
    COUNT(*) AS total_orders
FROM sales_orders;


-- 1.2 Total completed orders
SELECT
    COUNT(*) AS completed_orders
FROM sales_orders
WHERE order_status = 'Completed';


-- 1.3 Total pending orders
SELECT
    COUNT(*) AS pending_orders
FROM sales_orders
WHERE order_status = 'Pending';


-- 1.4 Total cancelled orders
SELECT
    COUNT(*) AS cancelled_orders
FROM sales_orders
WHERE order_status = 'Cancelled';


-- 1.5 Total units sold from completed orders
SELECT
    SUM(oi.quantity) AS total_units_sold
FROM sales_order_items oi
JOIN sales_orders o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'Completed';


-- 1.6 Total revenue from completed orders
SELECT
    ROUND(
        SUM(
            oi.quantity * oi.unit_price
            * (1 - oi.discount_percent / 100)
        ),
        2
    ) AS total_revenue
FROM sales_order_items oi
JOIN sales_orders o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'Completed';


-- 1.7 Average order value
WITH order_totals AS (
    SELECT
        o.order_id,
        SUM(
            oi.quantity * oi.unit_price
            * (1 - oi.discount_percent / 100)
        ) AS order_value
    FROM sales_orders o
    JOIN sales_order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'Completed'
    GROUP BY o.order_id
)
SELECT
    ROUND(AVG(order_value), 2) AS average_order_value
FROM order_totals;


-- ============================================================
-- 2. ORDER STATUS ANALYSIS
-- ============================================================

-- 2.1 Order count by status
SELECT
    order_status,
    COUNT(*) AS order_count
FROM sales_orders
GROUP BY order_status
ORDER BY order_count DESC;


-- 2.2 Order status percentages
SELECT
    order_status,
    COUNT(*) AS order_count,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS percentage_of_orders
FROM sales_orders
GROUP BY order_status
ORDER BY order_count DESC;


-- ============================================================
-- 3. PRODUCT PERFORMANCE
-- ============================================================

-- 3.1 Top-selling products by units sold
SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS units_sold
FROM products p
JOIN sales_order_items oi
    ON p.product_id = oi.product_id
JOIN sales_orders o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'Completed'
GROUP BY
    p.product_id,
    p.product_name
ORDER BY units_sold DESC;


-- 3.2 Top products by revenue
SELECT
    p.product_id,
    p.product_name,
    ROUND(
        SUM(
            oi.quantity * oi.unit_price
            * (1 - oi.discount_percent / 100)
        ),
        2
    ) AS revenue
FROM products p
JOIN sales_order_items oi
    ON p.product_id = oi.product_id
JOIN sales_orders o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'Completed'
GROUP BY
    p.product_id,
    p.product_name
ORDER BY revenue DESC;


-- 3.3 Top 5 products by revenue
SELECT
    p.product_id,
    p.product_name,
    ROUND(
        SUM(
            oi.quantity * oi.unit_price
            * (1 - oi.discount_percent / 100)
        ),
        2
    ) AS revenue
FROM products p
JOIN sales_order_items oi
    ON p.product_id = oi.product_id
JOIN sales_orders o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'Completed'
GROUP BY
    p.product_id,
    p.product_name
ORDER BY revenue DESC
LIMIT 5;


-- 3.4 Products that have never been sold
SELECT
    p.product_id,
    p.product_name,
    p.stock_quantity
FROM products p
LEFT JOIN sales_order_items oi
    ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL
ORDER BY p.product_id;


-- ============================================================
-- 4. CATEGORY PERFORMANCE
-- ============================================================

-- 4.1 Revenue by category
SELECT
    c.category_id,
    c.category_name,
    ROUND(
        SUM(
            oi.quantity * oi.unit_price
            * (1 - oi.discount_percent / 100)
        ),
        2
    ) AS revenue
FROM categories c
JOIN products p
    ON c.category_id = p.category_id
JOIN sales_order_items oi
    ON p.product_id = oi.product_id
JOIN sales_orders o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'Completed'
GROUP BY
    c.category_id,
    c.category_name
ORDER BY revenue DESC;


-- 4.2 Units sold by category
SELECT
    c.category_name,
    SUM(oi.quantity) AS units_sold
FROM categories c
JOIN products p
    ON c.category_id = p.category_id
JOIN sales_order_items oi
    ON p.product_id = oi.product_id
JOIN sales_orders o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'Completed'
GROUP BY c.category_name
ORDER BY units_sold DESC;


-- 4.3 Average product price by category
SELECT
    c.category_name,
    ROUND(AVG(p.unit_price), 2) AS average_product_price
FROM categories c
JOIN products p
    ON c.category_id = p.category_id
GROUP BY c.category_name
ORDER BY average_product_price DESC;


-- ============================================================
-- 5. CUSTOMER ANALYSIS
-- ============================================================

-- 5.1 Customer spending
SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    ROUND(
        SUM(
            oi.quantity * oi.unit_price
            * (1 - oi.discount_percent / 100)
        ),
        2
    ) AS total_spent
FROM customers c
JOIN sales_orders o
    ON c.customer_id = o.customer_id
JOIN sales_order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'Completed'
GROUP BY
    c.customer_id,
    customer_name
ORDER BY total_spent DESC;


-- 5.2 Top 10 customers by spending
SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(DISTINCT o.order_id) AS completed_orders,
    ROUND(
        SUM(
            oi.quantity * oi.unit_price
            * (1 - oi.discount_percent / 100)
        ),
        2
    ) AS total_spent
FROM customers c
JOIN sales_orders o
    ON c.customer_id = o.customer_id
JOIN sales_order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'Completed'
GROUP BY
    c.customer_id,
    customer_name
ORDER BY total_spent DESC
LIMIT 10;


-- 5.3 Customers with no purchases
SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.email
FROM customers c
LEFT JOIN sales_orders o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL
ORDER BY c.customer_id;


-- 5.4 Repeat customers
SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(DISTINCT o.order_id) AS order_count
FROM customers c
JOIN sales_orders o
    ON c.customer_id = o.customer_id
WHERE o.order_status = 'Completed'
GROUP BY
    c.customer_id,
    customer_name
HAVING COUNT(DISTINCT o.order_id) > 1
ORDER BY order_count DESC;


-- 5.5 Customer lifetime value
SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    ROUND(
        COALESCE(
            SUM(
                oi.quantity * oi.unit_price
                * (1 - oi.discount_percent / 100)
            ),
            0
        ),
        2
    ) AS customer_lifetime_value
FROM customers c
LEFT JOIN sales_orders o
    ON c.customer_id = o.customer_id
    AND o.order_status = 'Completed'
LEFT JOIN sales_order_items oi
    ON o.order_id = oi.order_id
GROUP BY
    c.customer_id,
    customer_name
ORDER BY customer_lifetime_value DESC;


-- ============================================================
-- 6. MONTHLY SALES ANALYSIS
-- ============================================================

-- 6.1 Monthly revenue
SELECT
    DATE_FORMAT(o.order_date, '%Y-%m') AS sales_month,
    ROUND(
        SUM(
            oi.quantity * oi.unit_price
            * (1 - oi.discount_percent / 100)
        ),
        2
    ) AS monthly_revenue
FROM sales_orders o
JOIN sales_order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'Completed'
GROUP BY sales_month
ORDER BY sales_month;


-- 6.2 Monthly order count
SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS sales_month,
    COUNT(*) AS completed_orders
FROM sales_orders
WHERE order_status = 'Completed'
GROUP BY sales_month
ORDER BY sales_month;


-- 6.3 Monthly units sold
SELECT
    DATE_FORMAT(o.order_date, '%Y-%m') AS sales_month,
    SUM(oi.quantity) AS units_sold
FROM sales_orders o
JOIN sales_order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'Completed'
GROUP BY sales_month
ORDER BY sales_month;


-- ============================================================
-- 7. REGIONAL PERFORMANCE
-- ============================================================

-- 7.1 Revenue by region
SELECT
    o.region,
    ROUND(
        SUM(
            oi.quantity * oi.unit_price
            * (1 - oi.discount_percent / 100)
        ),
        2
    ) AS revenue
FROM sales_orders o
JOIN sales_order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'Completed'
GROUP BY o.region
ORDER BY revenue DESC;


-- 7.2 Orders by region and status
SELECT
    region,
    SUM(order_status = 'Completed') AS completed_orders,
    SUM(order_status = 'Pending') AS pending_orders,
    SUM(order_status = 'Cancelled') AS cancelled_orders,
    COUNT(*) AS total_orders
FROM sales_orders
GROUP BY region
ORDER BY total_orders DESC;


-- 7.3 Average order value by region
WITH order_totals AS (
    SELECT
        o.order_id,
        o.region,
        SUM(
            oi.quantity * oi.unit_price
            * (1 - oi.discount_percent / 100)
        ) AS order_value
    FROM sales_orders o
    JOIN sales_order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'Completed'
    GROUP BY
        o.order_id,
        o.region
)
SELECT
    region,
    ROUND(AVG(order_value), 2) AS average_order_value
FROM order_totals
GROUP BY region
ORDER BY average_order_value DESC;


-- ============================================================
-- 8. CUSTOMER RANKINGS
-- ============================================================

WITH customer_sales AS (
    SELECT
        c.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        SUM(
            oi.quantity * oi.unit_price
            * (1 - oi.discount_percent / 100)
        ) AS total_spent
    FROM customers c
    JOIN sales_orders o
        ON c.customer_id = o.customer_id
    JOIN sales_order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'Completed'
    GROUP BY
        c.customer_id,
        customer_name
)
SELECT
    customer_id,
    customer_name,
    ROUND(total_spent, 2) AS total_spent,
    RANK() OVER (
        ORDER BY total_spent DESC
    ) AS customer_rank
FROM customer_sales
ORDER BY customer_rank;


-- ============================================================
-- 9. PRODUCT RANKINGS
-- ============================================================

WITH product_sales AS (
    SELECT
        p.product_id,
        p.product_name,
        c.category_name,
        SUM(
            oi.quantity * oi.unit_price
            * (1 - oi.discount_percent / 100)
        ) AS revenue
    FROM products p
    JOIN categories c
        ON p.category_id = c.category_id
    JOIN sales_order_items oi
        ON p.product_id = oi.product_id
    JOIN sales_orders o
        ON oi.order_id = o.order_id
    WHERE o.order_status = 'Completed'
    GROUP BY
        p.product_id,
        p.product_name,
        c.category_name
)
SELECT
    product_id,
    product_name,
    category_name,
    ROUND(revenue, 2) AS revenue,
    RANK() OVER (
        ORDER BY revenue DESC
    ) AS overall_rank
FROM product_sales
ORDER BY overall_rank;


-- ============================================================
-- 10. PRODUCT RANKING WITHIN CATEGORY
-- ============================================================

WITH product_sales AS (
    SELECT
        p.product_id,
        p.product_name,
        c.category_name,
        SUM(
            oi.quantity * oi.unit_price
            * (1 - oi.discount_percent / 100)
        ) AS revenue
    FROM products p
    JOIN categories c
        ON p.category_id = c.category_id
    JOIN sales_order_items oi
        ON p.product_id = oi.product_id
    JOIN sales_orders o
        ON oi.order_id = o.order_id
    WHERE o.order_status = 'Completed'
    GROUP BY
        p.product_id,
        p.product_name,
        c.category_name
)
SELECT
    product_id,
    product_name,
    category_name,
    ROUND(revenue, 2) AS revenue,
    RANK() OVER (
        PARTITION BY category_name
        ORDER BY revenue DESC
    ) AS category_rank
FROM product_sales
ORDER BY
    category_name,
    category_rank;


-- ============================================================
-- 11. REVENUE CONTRIBUTION
-- ============================================================

WITH product_sales AS (
    SELECT
        p.product_id,
        p.product_name,
        SUM(
            oi.quantity * oi.unit_price
            * (1 - oi.discount_percent / 100)
        ) AS revenue
    FROM products p
    JOIN sales_order_items oi
        ON p.product_id = oi.product_id
    JOIN sales_orders o
        ON oi.order_id = o.order_id
    WHERE o.order_status = 'Completed'
    GROUP BY
        p.product_id,
        p.product_name
)
SELECT
    product_id,
    product_name,
    ROUND(revenue, 2) AS revenue,
    ROUND(
        revenue * 100.0 / SUM(revenue) OVER (),
        2
    ) AS revenue_percentage
FROM product_sales
ORDER BY revenue DESC;


-- ============================================================
-- 12. RUNNING TOTAL OF MONTHLY REVENUE
-- ============================================================

WITH monthly_sales AS (
    SELECT
        DATE_FORMAT(o.order_date, '%Y-%m') AS sales_month,
        SUM(
            oi.quantity * oi.unit_price
            * (1 - oi.discount_percent / 100)
        ) AS monthly_revenue
    FROM sales_orders o
    JOIN sales_order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'Completed'
    GROUP BY sales_month
)
SELECT
    sales_month,
    ROUND(monthly_revenue, 2) AS monthly_revenue,
    ROUND(
        SUM(monthly_revenue) OVER (
            ORDER BY sales_month
            ROWS BETWEEN UNBOUNDED PRECEDING
            AND CURRENT ROW
        ),
        2
    ) AS running_revenue
FROM monthly_sales
ORDER BY sales_month;


-- ============================================================
-- 13. MONTH-OVER-MONTH REVENUE GROWTH
-- ============================================================

WITH monthly_sales AS (
    SELECT
        DATE_FORMAT(o.order_date, '%Y-%m') AS sales_month,
        SUM(
            oi.quantity * oi.unit_price
            * (1 - oi.discount_percent / 100)
        ) AS monthly_revenue
    FROM sales_orders o
    JOIN sales_order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'Completed'
    GROUP BY sales_month
),
monthly_comparison AS (
    SELECT
        sales_month,
        monthly_revenue,
        LAG(monthly_revenue) OVER (
            ORDER BY sales_month
        ) AS previous_month_revenue
    FROM monthly_sales
)
SELECT
    sales_month,
    ROUND(monthly_revenue, 2) AS monthly_revenue,
    ROUND(previous_month_revenue, 2) AS previous_month_revenue,
    ROUND(
        (monthly_revenue - previous_month_revenue)
        * 100.0 / NULLIF(previous_month_revenue, 0),
        2
    ) AS month_over_month_growth_percentage
FROM monthly_comparison
ORDER BY sales_month;


-- ============================================================
-- 14. TOP CUSTOMER IN EACH REGION
-- ============================================================

WITH customer_region_sales AS (
    SELECT
        c.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        c.region,
        SUM(
            oi.quantity * oi.unit_price
            * (1 - oi.discount_percent / 100)
        ) AS total_spent
    FROM customers c
    JOIN sales_orders o
        ON c.customer_id = o.customer_id
    JOIN sales_order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'Completed'
    GROUP BY
        c.customer_id,
        customer_name,
        c.region
),
ranked_customers AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY region
            ORDER BY total_spent DESC
        ) AS regional_rank
    FROM customer_region_sales
)
SELECT
    customer_id,
    customer_name,
    region,
    ROUND(total_spent, 2) AS total_spent
FROM ranked_customers
WHERE regional_rank = 1
ORDER BY region;


-- ============================================================
-- 15. HIGHEST-VALUE ORDER
-- ============================================================

WITH order_totals AS (
    SELECT
        o.order_id,
        o.customer_id,
        o.order_date,
        o.region,
        SUM(
            oi.quantity * oi.unit_price
            * (1 - oi.discount_percent / 100)
        ) AS order_value
    FROM sales_orders o
    JOIN sales_order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'Completed'
    GROUP BY
        o.order_id,
        o.customer_id,
        o.order_date,
        o.region
)
SELECT
    order_id,
    customer_id,
    order_date,
    region,
    ROUND(order_value, 2) AS order_value
FROM order_totals
ORDER BY order_value DESC
LIMIT 1;


-- ============================================================
-- END OF QUERIES
-- ============================================================
