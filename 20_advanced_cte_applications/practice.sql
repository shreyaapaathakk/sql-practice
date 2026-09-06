```sql
-- ============================================================
-- MODULE 20: ADVANCED CTE APPLICATIONS
-- practice.sql
-- ============================================================

USE module20_advanced_cte;


-- ============================================================
-- SECTION 1 — MULTIPLE CTEs
-- ============================================================

-- Exercise 1
-- Create two CTEs:
--
-- 1. active_customers
-- 2. customer_totals
--
-- Return active customers together with their total spending.


-- Exercise 2
-- Create three CTEs:
--
-- 1. active_customers
-- 2. customer_totals
-- 3. high_value_customers
--
-- Return customers who are ACTIVE and have spent at least 10000.


-- Exercise 3
-- Create a CTE pipeline that:
--
-- 1. Filters ACTIVE employees.
-- 2. Calculates department salary totals.
-- 3. Joins department names.
--
-- Return the final department report.


-- ============================================================
-- SECTION 2 — AGGREGATION
-- ============================================================

-- Exercise 4
-- Create a CTE that calculates total spending per customer.
--
-- Return customers whose spending is greater than 10000.


-- Exercise 5
-- Create a CTE containing department-level salary statistics.
--
-- Calculate:
--
-- employee_count
-- average_salary
-- minimum_salary
-- maximum_salary
-- total_salary


-- Exercise 6
-- Find departments whose total salary is greater than
-- the average department salary.
--
-- Use at least two CTEs.


-- ============================================================
-- SECTION 3 — CASE + CTE
-- ============================================================

-- Exercise 7
-- Calculate customer spending and classify customers:
--
-- 20000+  → VIP
-- 10000+  → PREMIUM
-- 5000+   → REGULAR
-- otherwise → LOW
--
-- Use a CTE.


-- Exercise 8
-- Count how many customers belong to each spending category.


-- ============================================================
-- SECTION 4 — WINDOW FUNCTIONS + CTE
-- ============================================================

-- Exercise 9
-- Rank employees by salary within each department.
--
-- Use RANK() inside a CTE.


-- Exercise 10
-- Return the top two highest-paid employees in each department.


-- Exercise 11
-- Return only the highest-paid employee from each department.


-- Exercise 12
-- Use ROW_NUMBER() to assign a unique salary position
-- within each department.


-- ============================================================
-- SECTION 5 — MULTI-LEVEL ANALYSIS
-- ============================================================

-- Exercise 13
-- Calculate total spending per customer.
--
-- Then calculate:
--
-- average customer spending
-- highest customer spending
-- lowest customer spending
--
-- Return every customer together with these statistics.


-- Exercise 14
-- Return customers whose total spending is above the
-- average customer spending.


-- Exercise 15
-- Calculate each department's percentage of total company salary.


-- ============================================================
-- SECTION 6 — RUNNING TOTALS
-- ============================================================

-- Exercise 16
-- Calculate daily revenue using a CTE.
--
-- Then calculate a running revenue total using a window function.


-- Exercise 17
-- Calculate daily revenue and compare each day with
-- the previous day's revenue using LAG().


-- Exercise 18
-- Add a revenue_change column showing the difference
-- between the current and previous day.


-- ============================================================
-- SECTION 7 — DATE ANALYSIS
-- ============================================================

-- Exercise 19
-- Create a monthly sales CTE.
--
-- Return:
--
-- year
-- month
-- revenue


-- Exercise 20
-- Using the monthly sales CTE, rank months by revenue.


-- ============================================================
-- SECTION 8 — DATA QUALITY
-- ============================================================

-- Exercise 21
-- Find duplicate customer email addresses using a CTE.


-- Exercise 22
-- Find employees whose salary is zero or negative.


-- Exercise 23
-- Create separate CTEs for:
--
-- employees with missing email
-- employees with invalid salary
--
-- Combine the results into one report.


-- ============================================================
-- SECTION 9 — RECURSIVE CTEs
-- ============================================================

-- Exercise 24
-- Generate numbers from 1 through 20 using a recursive CTE.


-- Exercise 25
-- Generate even numbers from 2 through 20.


-- Exercise 26
-- Generate dates from 2026-01-01 through 2026-01-10.


-- Exercise 27
-- Traverse the employee hierarchy.
--
-- Show:
--
-- employee_name
-- manager_id
-- hierarchy_level


-- Exercise 28
-- Modify the hierarchy query to show only employees
-- under the top-level managers.


-- ============================================================
-- SECTION 10 — COMPLEX CTE PIPELINE
-- ============================================================

-- Exercise 29
-- Build a query with the following stages:
--
-- 1. Calculate customer order totals.
-- 2. Calculate average spending.
-- 3. Classify customers.
-- 4. Rank customers.
-- 5. Return customers above average.


-- Exercise 30
-- Build a department performance report:
--
-- 1. Count employees.
-- 2. Calculate total salary.
-- 3. Calculate average salary.
-- 4. Rank departments by total salary.
-- 5. Join department names.


-- ============================================================
-- SECTION 11 — CTE VS SUBQUERY
-- ============================================================

-- Exercise 31
-- Solve the following problem using a nested subquery:
--
-- Find customers whose total spending is above the average
-- customer spending.


-- Exercise 32
-- Solve the same problem using CTEs.


-- Exercise 33
-- Compare the two solutions.
--
-- Which is easier to read?
-- Which is easier to extend?


-- ============================================================
-- SECTION 12 — REAL-WORLD REPORTING
-- ============================================================

-- Exercise 34
-- Build a customer report containing:
--
-- customer_name
-- order_count
-- total_spent
-- customer_category
-- spending_rank


-- Exercise 35
-- Build an employee report containing:
--
-- employee_name
-- department_name
-- salary
-- department_salary_rank
-- salary_difference_from_department_average


-- Exercise 36
-- Build a sales report containing:
--
-- order_date
-- daily_revenue
-- previous_day_revenue
-- revenue_change
-- running_revenue


-- ============================================================
-- MINI PROJECT
-- ============================================================

-- Project: Customer Analytics Pipeline
--
-- Build one query containing at least four CTEs.
--
-- Required stages:
--
-- 1. Customer order totals.
-- 2. Customer statistics.
-- 3. Customer classification.
-- 4. Customer ranking.
--
-- Final output:
--
-- customer_name
-- order_count
-- total_spent
-- customer_category
-- spending_rank
--
-- Sort by spending_rank.
```
