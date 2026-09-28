SQL

```
/*
File: 36_sql_interview_practice/challenge.sql
Module 36: SQL Interview Practice

Challenge: E-commerce Customer Analytics

MySQL Version: 8.0+
*/

-- ============================================================
-- SECTION 1: SETUP
-- ============================================================

DROP TEMPORARY TABLE IF EXISTS challenge_orders;
DROP TEMPORARY TABLE IF EXISTS challenge_customers;

CREATE TEMPORARY TABLE challenge_customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL
);

CREATE TEMPORARY TABLE challenge_orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    amount DECIMAL(10, 2) NOT NULL
);

INSERT INTO challenge_customers VALUES
    (1, 'Aarav Sharma', 'Delhi'),
    (2, 'Diya Verma', 'Mumbai'),
    (3, 'Kabir Singh', 'Delhi'),
    (4, 'Anaya Gupta', 'Mumbai'),
    (5, 'Meera Joshi', 'Delhi'),
    (6, 'Rohan Das', 'Pune');

INSERT INTO challenge_orders VALUES
    (1001, 1, '2026-01-05', 1500.00),
    (1002, 2, '2026-01-10', 2200.00),
    (1003, 1, '2026-02-15', 1800.00),
    (1004, 3, '2026-02-20', 3000.00),
    (1005, 4, '2026-03-01', 1200.00),
    (1006, 2, '2026-03-10', 2800.00),
    (1007, 5, '2026-03-15', 1500.00),
    (1008, 3, '2026-04-01', 2500.00),
    (1009, 1, '2026-04-12', 900.00),
    (1010, 4, '2026-04-20', 1700.00);


-- ============================================================
-- SECTION 2: BUSINESS QUESTIONS
-- ============================================================

/*
TASK 1: CUSTOMER SPENDING

For every customer, calculate:
- customer_id
- customer_name
- city
- total_orders
- total_spent

Include customers who have never ordered.
Their order count and total spending should be zero.

Sort by total_spent descending, then customer_id.


TASK 2: CUSTOMER RANKING WITHIN EACH CITY

Rank customers by total spending within their city.

Requirements:
- Include all customers.
- Customers with equal spending should share a rank.
- Return customer_name, city, total_spent, city_rank.
- Use DENSE_RANK().


TASK 3: TOP TWO CUSTOMERS PER CITY

Return the top two distinct spending ranks in each city.

Requirements:
- Use a CTE and a window function.
- Include ties at the cutoff rank.
- Return customer_name, city, total_spent, city_rank.


TASK 4: MONTHLY REVENUE AND CHANGE

Calculate:
- Monthly revenue.
- Previous available month's revenue.
- Revenue change from the previous available month.

Use a CTE and LAG().


TASK 5: RUNNING REVENUE

Return each order with:
- order_id
- order_date
- amount
- running_revenue

Order by order_date, then order_id.

Use an explicit ROWS window frame.


TASK 6: CUSTOMERS ABOVE AVERAGE SPENDING

Find customers whose total spending is greater than
the average total spending across all customers.

Requirements:
- Include customers with zero orders in the average.
- Return customer_id, customer_name, total_spent.
- Use a CTE or subquery.


TASK 7: FINAL BUSINESS SUMMARY

Produce a summary containing:
- total_customers
- customers_with_orders
- total_orders
- total_revenue
- average_revenue_per_customer

The average revenue per customer must include
customers who have never ordered.
*/


-- ============================================================
-- SECTION 3: VALIDATION
-- ============================================================

/*
Expected overall results:

Total customers: 6
Customers with orders: 5
Total orders: 10
Total revenue: 19100.00
Average revenue per customer: 3183.333333...

Check the source data:

SELECT *
FROM challenge_customers
ORDER BY customer_id;

SELECT *
FROM challenge_orders
ORDER BY order_date, order_id;


CLEANUP:

DROP TEMPORARY TABLE IF EXISTS challenge_orders;
DROP TEMPORARY TABLE IF EXISTS challenge_customers;
*/
```
  
Once Module 36 is complete, we'll move to Module 37 and finish the planned 37-module learning roadmap for `sql-practice`.
