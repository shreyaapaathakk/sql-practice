USE sales_analysis;

-- ============================================================
-- SALES ANALYSIS PROJECT
-- File: challenge.sql
-- Description: Advanced business SQL challenges
-- SQL Dialect: MySQL 8.0+
-- ============================================================


/*
================================================================
SALES ANALYSIS CHALLENGE
================================================================

Try to solve each problem independently.

Recommended concepts:

- SELECT
- WHERE
- GROUP BY
- HAVING
- ORDER BY
- JOIN
- LEFT JOIN
- CASE
- COALESCE
- Aggregate functions
- Subqueries
- CTEs
- Window functions
- RANK()
- DENSE_RANK()
- ROW_NUMBER()
- LAG()
- SUM() OVER()
- Conditional aggregation
- Date functions

================================================================
*/


-- ============================================================
-- CHALLENGE 1
-- ============================================================

/*
Calculate the following overall sales KPIs:

1. Total completed orders
2. Total units sold
3. Total revenue
4. Average order value
5. Highest-value order
6. Lowest-value order

Only completed orders should be included.
*/


-- Write your solution below.



-- ============================================================
-- CHALLENGE 2
-- ============================================================

/*
Calculate the percentage of orders represented by each status:

- Completed
- Pending
- Cancelled

Return:

order_status
order_count
percentage_of_total
*/


-- Write your solution below.



-- ============================================================
-- CHALLENGE 3
-- ============================================================

/*
Find the top 5 products by total revenue.

Return:

product_id
product_name
category_name
units_sold
revenue

Only completed orders should be included.
*/


-- Write your solution below.



-- ============================================================
-- CHALLENGE 4
-- ============================================================

/*
Find the top-selling product in each category based on revenue.

Return:

category_name
product_name
revenue

Use a window function to rank products within each category.
*/


-- Write your solution below.



-- ============================================================
-- CHALLENGE 5
-- ============================================================

/*
Find all customers who have placed at least two completed orders.

Return:

customer_id
customer_name
completed_orders
total_spent

Sort by total_spent from highest to lowest.
*/


-- Write your solution below.



-- ============================================================
-- CHALLENGE 6
-- ============================================================

/*
Find customers who have registered but have never placed an order.

Return:

customer_id
customer_name
email
registration_date
*/


-- Write your solution below.



-- ============================================================
-- CHALLENGE 7
-- ============================================================

/*
Calculate customer lifetime value.

For every customer return:

customer_id
customer_name
total_orders
total_spent

Customers with no completed orders should still appear
with total_spent equal to 0.
*/


-- Write your solution below.



-- ============================================================
-- CHALLENGE 8
-- ============================================================

/*
Rank all customers according to their total spending.

Return:

customer_id
customer_name
total_spent
customer_rank

Use RANK().
*/


-- Write your solution below.



-- ============================================================
-- CHALLENGE 9
-- ============================================================

/*
Calculate monthly revenue.

Return:

sales_month
monthly_revenue

Then add:

previous_month_revenue
growth_percentage

Use LAG() to calculate month-over-month growth.
*/


-- Write your solution below.



-- ============================================================
-- CHALLENGE 10
-- ============================================================

/*
Calculate a running total of revenue by month.

Return:

sales_month
monthly_revenue
cumulative_revenue

Use a window function.
*/


-- Write your solution below.



-- ============================================================
-- CHALLENGE 11
-- ============================================================

/*
Find the region generating the highest revenue.

Return:

region
revenue
revenue_percentage
*/


-- Write your solution below.



-- ============================================================
-- CHALLENGE 12
-- ============================================================

/*
Find the highest-spending customer in each region.

Return:

region
customer_id
customer_name
total_spent

Use ROW_NUMBER() or RANK().
*/


-- Write your solution below.



-- ============================================================
-- CHALLENGE 13
-- ============================================================

/*
Calculate revenue contribution for every product.

Return:

product_name
revenue
revenue_percentage

The sum of revenue_percentage should be approximately 100%.
*/


-- Write your solution below.



-- ============================================================
-- CHALLENGE 14
-- ============================================================

/*
Find the category with the highest total number of units sold.

Return:

category_name
units_sold

Only completed orders should be considered.
*/


-- Write your solution below.



-- ============================================================
-- CHALLENGE 15
-- ============================================================

/*
Find products that have never appeared in a completed order.

Return:

product_id
product_name
category_name
stock_quantity
*/


-- Write your solution below.



-- ============================================================
-- CHALLENGE 16
-- ============================================================

/*
For every month, identify the region with the highest revenue.

Return:

sales_month
region
revenue

Use a CTE and window function.
*/


-- Write your solution below.



-- ============================================================
-- CHALLENGE 17
-- ============================================================

/*
Find the three highest-revenue products within every category.

Return:

category_name
product_name
revenue
category_rank

Use a window function.
*/


-- Write your solution below.



-- ============================================================
-- CHALLENGE 18
-- ============================================================

/*
Calculate the average order value for each region.

Return:

region
completed_orders
total_revenue
average_order_value
*/


-- Write your solution below.



-- ============================================================
-- CHALLENGE 19
-- ============================================================

/*
Classify customers into four groups:

High Value:
    total spending >= 10000

Medium Value:
    total spending >= 5000 and < 10000

Low Value:
    total spending > 0 and < 5000

No Purchase:
    total spending = 0

Return:

customer_id
customer_name
total_spent
customer_segment
*/


-- Write your solution below.



-- ============================================================
-- CHALLENGE 20
-- ============================================================

/*
Create a final sales performance report.

Return:

1. Total revenue
2. Total completed orders
3. Total units sold
4. Average order value
5. Number of purchasing customers
6. Number of products sold
7. Best-performing region
8. Best-performing product
9. Best-performing category

Try to solve this using multiple CTEs.
*/


-- Write your solution below.



-- ============================================================
-- BONUS CHALLENGE 21
-- ============================================================

/*
Calculate each customer's percentage contribution to
overall company revenue.

Return:

customer_id
customer_name
total_spent
revenue_contribution_percentage

Use a window function.
*/


-- Write your solution below.



-- ============================================================
-- BONUS CHALLENGE 22
-- ============================================================

/*
Find customers whose spending is above the average
customer spending.

Return:

customer_id
customer_name
total_spent

Use a CTE or subquery.
*/


-- Write your solution below.



-- ============================================================
-- BONUS CHALLENGE 23
-- ============================================================

/*
For each product, compare its revenue with the average
revenue of products in the same category.

Return:

product_name
category_name
product_revenue
category_average_revenue
difference_from_category_average

Use a window function.
*/


-- Write your solution below.



-- ============================================================
-- BONUS CHALLENGE 24
-- ============================================================

/*
Find the month with the highest revenue and the month
with the lowest revenue.

Return:

highest_revenue_month
highest_revenue

lowest_revenue_month
lowest_revenue
*/


-- Write your solution below.



-- ============================================================
-- BONUS CHALLENGE 25
-- ============================================================

/*
Create a complete customer ranking report.

For every purchasing customer return:

customer_id
customer_name
region
completed_orders
total_spent
customer_rank
region_rank
customer_segment

Use:

- CTEs
- CASE
- RANK()
- PARTITION BY
*/


-- Write your solution below.



-- ============================================================
-- END OF SALES ANALYSIS CHALLENGE
-- ============================================================
