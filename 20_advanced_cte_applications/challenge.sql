```sql
-- ============================================================
-- MODULE 20: ADVANCED CTE APPLICATIONS
-- challenge.sql
-- ============================================================

USE module20_advanced_cte;


-- ============================================================
-- CHALLENGE 1 — CUSTOMER ANALYTICS PIPELINE
-- ============================================================

-- Build a query using at least FOUR CTEs.
--
-- Required stages:
--
-- 1. Calculate order count and total spending per customer.
-- 2. Calculate the average customer spending.
-- 3. Classify customers:
--
--    VIP      >= 20000
--    PREMIUM  >= 10000
--    REGULAR  >= 5000
--    LOW      < 5000
--
-- 4. Rank customers by spending.
--
-- Final output:
--
-- customer_name
-- order_count
-- total_spent
-- customer_category
-- spending_rank


-- ============================================================
-- CHALLENGE 2 — TOP EMPLOYEES PER DEPARTMENT
-- ============================================================

-- Use a CTE and RANK() to find the top two employees
-- by salary in every department.
--
-- Include:
--
-- department_name
-- employee_name
-- salary
-- salary_rank


-- ============================================================
-- CHALLENGE 3 — ABOVE-DEPARTMENT-AVERAGE EMPLOYEES
-- ============================================================

-- Find employees whose salary is above the average salary
-- of their own department.
--
-- Use a CTE and a window function.
--
-- Include:
--
-- employee_name
-- department_name
-- salary
-- department_average
-- salary_difference


-- ============================================================
-- CHALLENGE 4 — DEPARTMENT SALARY ANALYSIS
-- ============================================================

-- Create a multi-stage CTE pipeline that:
--
-- 1. Calculates total salary per department.
-- 2. Calculates company-wide salary.
-- 3. Calculates each department's percentage of company salary.
-- 4. Ranks departments by salary.
--
-- Return:
--
-- department_name
-- total_salary
-- salary_percentage
-- salary_rank


-- ============================================================
-- CHALLENGE 5 — DAILY SALES ANALYSIS
-- ============================================================

-- Create a CTE that calculates daily revenue.
--
-- Then calculate:
--
-- previous_day_revenue
-- revenue_change
-- running_revenue
--
-- Use:
--
-- LAG()
-- SUM() OVER()


-- ============================================================
-- CHALLENGE 6 — MONTHLY SALES LEADERBOARD
-- ============================================================

-- Create a monthly revenue report.
--
-- Then rank the months by revenue.
--
-- Return:
--
-- year
-- month
-- revenue
-- revenue_rank


-- ============================================================
-- CHALLENGE 7 — CUSTOMER CONTRIBUTION
-- ============================================================

-- Calculate total customer spending.
--
-- Then calculate what percentage of total company revenue
-- each customer generated.
--
-- Return:
--
-- customer_name
-- total_spent
-- revenue_percentage
--
-- Sort from highest contribution to lowest.


-- ============================================================
-- CHALLENGE 8 — DATA QUALITY REPORT
-- ============================================================

-- Build a data-quality report using multiple CTEs.
--
-- Detect:
--
-- 1. Missing customer email.
-- 2. Invalid employee salary.
-- 3. Invalid employee status.
--
-- Combine the issues into one result.
--
-- Include:
--
-- record_id
-- record_name
-- issue


-- ============================================================
-- CHALLENGE 9 — EMPLOYEE HIERARCHY
-- ============================================================

-- Use a recursive CTE to display the complete employee
-- hierarchy.
--
-- Include:
--
-- employee_name
-- manager_id
-- hierarchy_level
--
-- Order the results so that higher-level employees appear
-- before their subordinates.


-- ============================================================
-- CHALLENGE 10 — HIERARCHY PATH
-- ============================================================

-- Extend the recursive hierarchy query to build a path such as:
--
-- Aarav Sharma
-- Aarav Sharma > Priya Verma
-- Aarav Sharma > Rohan Singh
--
-- For deeper hierarchies, continue building the path.


-- ============================================================
-- CHALLENGE 11 — ABOVE-AVERAGE CUSTOMERS
-- ============================================================

-- Build a query that:
--
-- 1. Calculates customer totals.
-- 2. Calculates average customer spending.
-- 3. Returns only customers above average.
-- 4. Ranks them by spending.
--
-- Use at least three CTEs.


-- ============================================================
-- CHALLENGE 12 — CUSTOMER SEGMENTATION
-- ============================================================

-- Create a customer segmentation report.
--
-- Segments:
--
-- VIP
-- PREMIUM
-- REGULAR
-- LOW
--
-- Then count how many customers belong to each segment.
--
-- Return:
--
-- segment
-- customer_count
-- average_spending


-- ============================================================
-- CHALLENGE 13 — CTE VS SUBQUERY
-- ============================================================

-- Solve the same business problem twice:
--
-- Problem:
-- Find departments whose total salary is above the
-- average department salary.
--
-- Version 1:
-- Nested subqueries.
--
-- Version 2:
-- Multiple CTEs.
--
-- Compare readability and maintainability.


-- ============================================================
-- CHALLENGE 14 — COMPLEX REPORTING PIPELINE
-- ============================================================

-- Build a single query using at least FIVE CTEs.
--
-- Suggested pipeline:
--
-- CTE 1 → customer order totals
-- CTE 2 → customer statistics
-- CTE 3 → customer classification
-- CTE 4 → customer ranking
-- CTE 5 → final filtered report
--
-- Final output should show only customers whose spending
-- is above the average.


-- ============================================================
-- CHALLENGE 15 — RECURSIVE DATE GENERATOR
-- ============================================================

-- Use a recursive CTE to generate every date from:
--
-- 2026-01-01
-- through
-- 2026-01-31
--
-- Then LEFT JOIN the generated dates to orders.
--
-- The final result should show every date, including dates
-- on which there were no orders.
--
-- Return:
--
-- order_date
-- daily_order_count
-- daily_revenue


-- ============================================================
-- CHALLENGE 16 — FINAL ADVANCED CTE PROJECT
-- ============================================================

-- PROJECT: BUSINESS ANALYTICS ENGINE
--
-- Build a single SQL reporting system using CTEs.
--
-- Your query should contain at least FIVE CTEs.
--
-- Requirements:
--
-- 1. Customer order aggregation.
-- 2. Customer spending classification.
-- 3. Customer ranking.
-- 4. Company-level statistics.
-- 5. Final reporting layer.
--
-- Final report should contain:
--
-- customer_name
-- order_count
-- total_spent
-- customer_category
-- spending_rank
-- average_customer_spending
-- difference_from_average
--
-- Sort by spending_rank.
--
-- BONUS:
--
-- Add a percentage-of-total-revenue column.
--
-- EXTRA BONUS:
--
-- Rewrite the solution using a different CTE structure
-- while producing the same result.


-- ============================================================
-- CHALLENGE 17 — EXPLAIN YOUR DESIGN
-- ============================================================

-- After completing the project, answer:
--
-- 1. Why did you create each CTE?
-- 2. What transformation does each CTE perform?
-- 3. Could any CTE be removed?
-- 4. Would a nested subquery be less readable?
-- 5. Where are window functions used?
-- 6. Where is aggregation performed?
-- 7. Which CTE depends on another CTE?
-- 8. What would happen if the data volume became very large?
-- 9. Which columns would you consider indexing?
-- 10. Would a view be appropriate for this report?
--
-- The goal is not only to write the query.
-- The goal is to understand the architecture of the query.
```
