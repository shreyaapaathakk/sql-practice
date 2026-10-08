USE sales_analysis;

-- ============================================================
-- SALES ANALYSIS PROJECT
-- File: analysis.sql
-- Description: Business analysis and KPI reporting
-- SQL Dialect: MySQL 8.0+
-- ============================================================


-- ============================================================
-- 1. EXECUTIVE KPI DASHBOARD
-- ============================================================

WITH completed_orders AS (
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
    COUNT(*) AS completed_orders,
    ROUND(SUM(order_value), 2) AS total_revenue,
    ROUND(AVG(order_value), 2) AS average_order_value,
    ROUND(MIN(order_value), 2) AS minimum_order_value,
    ROUND(MAX(order_value), 2) AS maximum_order_value
FROM completed_orders;


-- ============================================================
-- 2. OVERALL ORDER STATUS PERFORMANCE
-- ============================================================

SELECT
    order_status,
    COUNT(*) AS order_count,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS order_percentage
FROM sales_orders
GROUP BY order_status
ORDER BY order_count DESC;


-- ============================================================
-- 3. REVENUE BY REGION
-- ============================================================

WITH regional_sales AS (
    SELECT
        o.region,
        SUM(
            oi.quantity * oi.unit_price
            * (1 - oi.discount_percent / 100)
        ) AS revenue
    FROM sales_orders o
    JOIN sales_order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'Completed'
    GROUP BY o.region
)
SELECT
    region,
    ROUND(revenue, 2) AS revenue,
    ROUND(
        revenue * 100.0 / SUM(revenue) OVER (),
        2
    ) AS revenue_contribution_percentage,
    RANK() OVER (
        ORDER BY revenue DESC
    ) AS regional_rank
FROM regional_sales
ORDER BY regional_rank;


-- ============================================================
-- 4. MONTHLY REVENUE TREND
-- ============================================================

WITH monthly_sales AS (
    SELECT
        DATE_FORMAT(o.order_date, '%Y-%m') AS sales_month,
        SUM(
            oi.quantity * oi.unit_price
            * (1 - oi.discount_percent / 100)
        ) AS revenue
    FROM sales_orders o
    JOIN sales_order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'Completed'
    GROUP BY sales_month
)
SELECT
    sales_month,
    ROUND(revenue, 2) AS revenue,
    ROUND(
        AVG(revenue) OVER (
            ORDER BY sales_month
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ),
        2
    ) AS three_month_moving_average
FROM monthly_sales
ORDER BY sales_month;


-- ============================================================
-- 5. MONTH-OVER-MONTH GROWTH
-- ============================================================

WITH monthly_sales AS (
    SELECT
        DATE_FORMAT(o.order_date, '%Y-%m') AS sales_month,
        SUM(
            oi.quantity * oi.unit_price
            * (1 - oi.discount_percent / 100)
        ) AS revenue
    FROM sales_orders o
    JOIN sales_order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'Completed'
    GROUP BY sales_month
),
growth_analysis AS (
    SELECT
        sales_month,
        revenue,
        LAG(revenue) OVER (
            ORDER BY sales_month
        ) AS previous_revenue
    FROM monthly_sales
)
SELECT
    sales_month,
    ROUND(revenue, 2) AS revenue,
    ROUND(previous_revenue, 2) AS previous_revenue,
    CASE
        WHEN previous_revenue IS NULL THEN NULL
        ELSE ROUND(
            (revenue - previous_revenue)
            * 100.0 / NULLIF(previous_revenue, 0),
            2
        )
    END AS growth_percentage
FROM growth_analysis
ORDER BY sales_month;


-- ============================================================
-- 6. CATEGORY PERFORMANCE REPORT
-- ============================================================

WITH category_sales AS (
    SELECT
        c.category_id,
        c.category_name,
        SUM(oi.quantity) AS units_sold,
        SUM(
            oi.quantity * oi.unit_price
            * (1 - oi.discount_percent / 100)
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
)
SELECT
    category_id,
    category_name,
    units_sold,
    ROUND(revenue, 2) AS revenue,
    ROUND(
        revenue * 100.0 / SUM(revenue) OVER (),
        2
    ) AS revenue_share_percentage,
    RANK() OVER (
        ORDER BY revenue DESC
    ) AS category_rank
FROM category_sales
ORDER BY category_rank;


-- ============================================================
-- 7. TOP PRODUCTS
-- ============================================================

WITH product_sales AS (
    SELECT
        p.product_id,
        p.product_name,
        c.category_name,
        SUM(oi.quantity) AS units_sold,
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
    units_sold,
    ROUND(revenue, 2) AS revenue,
    RANK() OVER (
        ORDER BY revenue DESC
    ) AS revenue_rank
FROM product_sales
ORDER BY revenue_rank
LIMIT 10;


-- ============================================================
-- 8. TOP PRODUCT WITHIN EACH CATEGORY
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
),
ranked_products AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY category_name
            ORDER BY revenue DESC
        ) AS category_rank
    FROM product_sales
)
SELECT
    product_id,
    product_name,
    category_name,
    ROUND(revenue, 2) AS revenue
FROM ranked_products
WHERE category_rank = 1
ORDER BY category_name;


-- ============================================================
-- 9. CUSTOMER VALUE SEGMENTATION
-- ============================================================

WITH customer_sales AS (
    SELECT
        c.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        COALESCE(
            SUM(
                oi.quantity * oi.unit_price
                * (1 - oi.discount_percent / 100)
            ),
            0
        ) AS total_spent
    FROM customers c
    LEFT JOIN sales_orders o
        ON c.customer_id = o.customer_id
        AND o.order_status = 'Completed'
    LEFT JOIN sales_order_items oi
        ON o.order_id = oi.order_id
    GROUP BY
        c.customer_id,
        customer_name
)
SELECT
    customer_id,
    customer_name,
    ROUND(total_spent, 2) AS total_spent,
    CASE
        WHEN total_spent >= 10000 THEN 'High Value'
        WHEN total_spent >= 5000 THEN 'Medium Value'
        WHEN total_spent > 0 THEN 'Low Value'
        ELSE 'No Purchase'
    END AS customer_segment
FROM customer_sales
ORDER BY total_spent DESC;


-- ============================================================
-- 10. REPEAT CUSTOMER ANALYSIS
-- ============================================================

WITH customer_orders AS (
    SELECT
        c.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        COUNT(DISTINCT CASE
            WHEN o.order_status = 'Completed'
            THEN o.order_id
        END) AS completed_orders
    FROM customers c
    LEFT JOIN sales_orders o
        ON c.customer_id = o.customer_id
    GROUP BY
        c.customer_id,
        customer_name
)
SELECT
    customer_id,
    customer_name,
    completed_orders,
    CASE
        WHEN completed_orders >= 3 THEN 'Frequent Customer'
        WHEN completed_orders = 2 THEN 'Repeat Customer'
        WHEN completed_orders = 1 THEN 'One-Time Customer'
        ELSE 'No Purchase'
    END AS customer_type
FROM customer_orders
ORDER BY completed_orders DESC;


-- ============================================================
-- 11. CUSTOMER RANKING
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
    DENSE_RANK() OVER (
        ORDER BY total_spent DESC
    ) AS customer_rank
FROM customer_sales
ORDER BY customer_rank;


-- ============================================================
-- 12. RUNNING REVENUE
-- ============================================================

WITH monthly_sales AS (
    SELECT
        DATE_FORMAT(o.order_date, '%Y-%m') AS sales_month,
        SUM(
            oi.quantity * oi.unit_price
            * (1 - oi.discount_percent / 100)
        ) AS revenue
    FROM sales_orders o
    JOIN sales_order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'Completed'
    GROUP BY sales_month
)
SELECT
    sales_month,
    ROUND(revenue, 2) AS monthly_revenue,
    ROUND(
        SUM(revenue) OVER (
            ORDER BY sales_month
        ),
        2
    ) AS cumulative_revenue
FROM monthly_sales
ORDER BY sales_month;


-- ============================================================
-- 13. SALES BY REGION AND MONTH
-- ============================================================

SELECT
    o.region,
    DATE_FORMAT(o.order_date, '%Y-%m') AS sales_month,
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
GROUP BY
    o.region,
    sales_month
ORDER BY
    o.region,
    sales_month;


-- ============================================================
-- 14. BEST REGION EACH MONTH
-- ============================================================

WITH monthly_region_sales AS (
    SELECT
        DATE_FORMAT(o.order_date, '%Y-%m') AS sales_month,
        o.region,
        SUM(
            oi.quantity * oi.unit_price
            * (1 - oi.discount_percent / 100)
        ) AS revenue
    FROM sales_orders o
    JOIN sales_order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'Completed'
    GROUP BY
        sales_month,
        o.region
),
ranked_regions AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY sales_month
            ORDER BY revenue DESC
        ) AS region_rank
    FROM monthly_region_sales
)
SELECT
    sales_month,
    region,
    ROUND(revenue, 2) AS revenue
FROM ranked_regions
WHERE region_rank = 1
ORDER BY sales_month;


-- ============================================================
-- 15. PRODUCT DISCOUNT ANALYSIS
-- ============================================================

SELECT
    p.product_id,
    p.product_name,
    ROUND(AVG(oi.discount_percent), 2) AS average_discount,
    SUM(oi.quantity) AS units_sold,
    ROUND(
        SUM(
            oi.quantity * oi.unit_price
            * (1 - oi.discount_percent / 100)
        ),
        2
    ) AS net_revenue
FROM products p
JOIN sales_order_items oi
    ON p.product_id = oi.product_id
JOIN sales_orders o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'Completed'
GROUP BY
    p.product_id,
    p.product_name
ORDER BY average_discount DESC;


-- ============================================================
-- 16. INVENTORY PERFORMANCE
-- ============================================================

WITH product_sales AS (
    SELECT
        p.product_id,
        p.product_name,
        p.stock_quantity,
        COALESCE(SUM(
            CASE
                WHEN o.order_status = 'Completed'
                THEN oi.quantity
                ELSE 0
            END
        ), 0) AS units_sold
    FROM products p
    LEFT JOIN sales_order_items oi
        ON p.product_id = oi.product_id
    LEFT JOIN sales_orders o
        ON oi.order_id = o.order_id
    GROUP BY
        p.product_id,
        p.product_name,
        p.stock_quantity
)
SELECT
    product_id,
    product_name,
    stock_quantity,
    units_sold,
    CASE
        WHEN units_sold = 0 THEN 'No Sales'
        WHEN units_sold >= 10 THEN 'High Demand'
        WHEN units_sold >= 5 THEN 'Medium Demand'
        ELSE 'Low Demand'
    END AS demand_level
FROM product_sales
ORDER BY units_sold DESC;


-- ============================================================
-- 17. CUSTOMER PURCHASE FREQUENCY
-- ============================================================

SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(DISTINCT CASE
        WHEN o.order_status = 'Completed'
        THEN o.order_id
    END) AS completed_orders,
    ROUND(
        AVG(
            CASE
                WHEN o.order_status = 'Completed'
                THEN oi.quantity * oi.unit_price
                     * (1 - oi.discount_percent / 100)
            END
        ),
        2
    ) AS average_item_value
FROM customers c
LEFT JOIN sales_orders o
    ON c.customer_id = o.customer_id
LEFT JOIN sales_order_items oi
    ON o.order_id = oi.order_id
GROUP BY
    c.customer_id,
    customer_name
ORDER BY completed_orders DESC;


-- ============================================================
-- 18. HIGH-VALUE CUSTOMERS
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
    ROUND(total_spent, 2) AS total_spent
FROM customer_sales
WHERE total_spent >= (
    SELECT AVG(total_spent)
    FROM customer_sales
)
ORDER BY total_spent DESC;


-- ============================================================
-- 19. SALES PERFORMANCE SUMMARY
-- ============================================================

WITH completed_sales AS (
    SELECT
        o.order_id,
        o.customer_id,
        o.region,
        o.order_date,
        oi.product_id,
        oi.quantity,
        oi.quantity * oi.unit_price
            * (1 - oi.discount_percent / 100) AS revenue
    FROM sales_orders o
    JOIN sales_order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'Completed'
)
SELECT
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS purchasing_customers,
    SUM(quantity) AS total_units_sold,
    ROUND(SUM(revenue), 2) AS total_revenue,
    ROUND(AVG(revenue), 2) AS average_line_revenue,
    COUNT(DISTINCT product_id) AS products_sold,
    COUNT(DISTINCT region) AS active_regions
FROM completed_sales;


-- ============================================================
-- END OF ANALYSIS
-- ============================================================
