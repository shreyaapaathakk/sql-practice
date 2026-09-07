```sql
-- ============================================================
-- MODULE 21: ADVANCED VIEWS
-- challenge.sql
-- ============================================================

USE module21_advanced_views;


-- ============================================================
-- CHALLENGE 1 — CUSTOMER REPORTING VIEW
-- ============================================================

-- Create a reusable view called customer_analytics.
--
-- It must contain:
--
-- customer_name
-- order_count
-- total_spent
-- average_order_value
-- customer_category
--
-- Customer categories:
--
-- VIP      >= 20000
-- PREMIUM  >= 10000
-- REGULAR  >= 5000
-- LOW      otherwise


-- ============================================================
-- CHALLENGE 2 — EMPLOYEE ANALYTICS VIEW
-- ============================================================

-- Create a view called employee_analytics.
--
-- It must contain:
--
-- employee_name
-- department_name
-- salary
-- salary_rank
-- department_average_salary
-- salary_difference
--
-- Use window functions.


-- ============================================================
-- CHALLENGE 3 — TOP EMPLOYEES
-- ============================================================

-- Using employee_analytics, return the top two employees
-- from every department.


-- ============================================================
-- CHALLENGE 4 — ABOVE-AVERAGE EMPLOYEES
-- ============================================================

-- Using employee_analytics, return employees whose salary
-- is greater than their department average.


-- ============================================================
-- CHALLENGE 5 — DEPARTMENT REPORTING VIEW
-- ============================================================

-- Create a department_reporting view.
--
-- Include:
--
-- department_name
-- employee_count
-- total_salary
-- average_salary
-- highest_salary
-- lowest_salary
--
-- Include departments even when they have no employees.


-- ============================================================
-- CHALLENGE 6 — SECURITY VIEW
-- ============================================================

-- Create a public_employee_directory view.
--
-- It should expose:
--
-- employee_id
-- employee_name
-- department_id
-- hire_date
--
-- It must NOT expose:
--
-- salary
-- manager_id
-- status
--
-- Explain why a view can be useful for data abstraction
-- and controlled exposure.


-- ============================================================
-- CHALLENGE 7 — VIEW ON VIEW
-- ============================================================

-- Create:
--
-- View 1 → customer_order_summary_advanced
-- View 2 → customer_performance_advanced
--
-- View 2 must be built using View 1.
--
-- Add a customer category in View 2.


-- ============================================================
-- CHALLENGE 8 — WITH CHECK OPTION
-- ============================================================

-- Create an ACTIVE customer view using:
--
-- WITH CHECK OPTION
--
-- Then test:
--
-- 1. Updating the customer's name.
-- 2. Changing the customer status to INACTIVE.
--
-- Explain the difference between the two operations.


-- ============================================================
-- CHALLENGE 9 — VIEW MANAGEMENT
-- ============================================================

-- Create a view.
--
-- Then:
--
-- 1. Inspect it using SHOW CREATE VIEW.
-- 2. Replace it using CREATE OR REPLACE VIEW.
-- 3. Remove it using DROP VIEW IF EXISTS.


-- ============================================================
-- CHALLENGE 10 — CTE TO VIEW
-- ============================================================

-- Start with a CTE that calculates customer spending.
--
-- Then convert the same logic into a permanent view.
--
-- Explain why the view might be more useful if multiple
-- reports need the same customer spending calculation.


-- ============================================================
-- CHALLENGE 11 — BUSINESS LOGIC LAYER
-- ============================================================

-- Create a view that centralizes customer segmentation.
--
-- Then write three different queries against the view:
--
-- 1. Count customers in each category.
-- 2. Find VIP customers.
-- 3. Find customers above the average spending.


-- ============================================================
-- CHALLENGE 12 — MULTI-LAYER REPORTING
-- ============================================================

-- Build the following architecture:
--
-- customers + orders
--        ↓
-- customer_order_summary
--        ↓
-- customer_performance
--        ↓
-- final reporting query
--
-- The final query should return the top three customers
-- by total spending.


-- ============================================================
-- CHALLENGE 13 — VIEW DESIGN REVIEW
-- ============================================================

-- Consider this view:
--
-- CREATE VIEW employee_data AS
-- SELECT *
-- FROM employees;
--
-- Identify at least three problems with this design.
--
-- Then rewrite it as a better production-style view.


-- ============================================================
-- CHALLENGE 14 — UPDATABLE VS NON-UPDATABLE
-- ============================================================

-- For each view below, determine whether it is likely
-- to be updatable.
--
-- A:
--
-- SELECT employee_id, employee_name
-- FROM employees;
--
--
-- B:
--
-- SELECT employee_id, employee_name
-- FROM employees
-- WHERE status = 'ACTIVE';
--
--
-- C:
--
-- SELECT department_id, AVG(salary)
-- FROM employees
-- GROUP BY department_id;
--
--
-- D:
--
-- SELECT DISTINCT department_id
-- FROM employees;
--
-- Explain your reasoning.


-- ============================================================
-- CHALLENGE 15 — FINAL BUSINESS REPORTING PROJECT
-- ============================================================

-- PROJECT: COMPANY REPORTING DATABASE
--
-- Build a reusable reporting layer using views.
--
-- Create at least FOUR views.
--
-- Required views:
--
-- 1. employee_directory
-- 2. employee_department_statistics
-- 3. customer_order_summary
-- 4. customer_performance
--
-- Requirements:
--
-- employee_directory:
--     employee information without unnecessary sensitive
--     columns.
--
-- employee_department_statistics:
--     department-level employee statistics.
--
-- customer_order_summary:
--     customer order count and spending.
--
-- customer_performance:
--     customer spending classification.
--
-- Then create final SELECT queries that answer:
--
-- A. Who are the top three customers?
--
-- B. Which departments have the highest salary costs?
--
-- C. Which employees earn above their department average?
--
-- D. How many customers are in each spending category?
--
-- E. Which customers have never placed an order?


-- ============================================================
-- CHALLENGE 16 — ARCHITECTURE QUESTION
-- ============================================================

-- Design the following system:
--
-- Base tables
--     ↓
-- Reusable views
--     ↓
-- Reporting queries
--
-- Explain:
--
-- 1. Which logic belongs in the base tables?
-- 2. Which logic belongs in views?
-- 3. Which logic belongs in CTEs?
-- 4. When would a stored procedure be preferable?
-- 5. When might a temporary table be preferable?
--
-- Your goal is to decide which SQL feature is appropriate
-- rather than using views automatically.


-- ============================================================
-- FINAL CHECK
-- ============================================================

-- Before completing Module 21, make sure you can:
--
-- [ ] Create advanced views.
-- [ ] Use JOINs inside views.
-- [ ] Use GROUP BY inside views.
-- [ ] Use CASE inside views.
-- [ ] Use window functions inside views.
-- [ ] Build a view on another view.
-- [ ] Use WITH CHECK OPTION.
-- [ ] Understand updatable views.
-- [ ] Understand non-updatable views.
-- [ ] Inspect view definitions.
-- [ ] Replace views.
-- [ ] Drop views.
-- [ ] Design security-oriented views.
-- [ ] Build reporting layers.
-- [ ] Compare views and CTEs.
-- [ ] Compare views and temporary tables.
-- [ ] Compare views and stored procedures.
```
