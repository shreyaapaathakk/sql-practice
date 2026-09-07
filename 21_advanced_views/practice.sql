```sql
-- ============================================================
-- MODULE 21: ADVANCED VIEWS
-- practice.sql
-- ============================================================

USE module21_advanced_views;


-- ============================================================
-- SECTION 1 — ADVANCED VIEW CREATION
-- ============================================================

-- Exercise 1
-- Create a view called active_customers_view.
--
-- Include:
-- customer_id
-- customer_name
-- email
--
-- Return only ACTIVE customers.


-- Exercise 2
-- Create a view called employee_department_view.
--
-- Join employees and departments.
--
-- Include:
-- employee_id
-- employee_name
-- department_name
-- salary


-- Exercise 3
-- Create a view called employee_salary_view.
--
-- Include:
-- employee_name
-- salary
-- annual_salary
--
-- Calculate annual_salary as salary * 12.


-- ============================================================
-- SECTION 2 — AGGREGATED VIEWS
-- ============================================================

-- Exercise 4
-- Create a view called department_statistics.
--
-- Include:
-- department_id
-- employee_count
-- total_salary
-- average_salary


-- Exercise 5
-- Create a view called customer_order_statistics.
--
-- Include:
-- customer_id
-- customer_name
-- order_count
-- total_spent
-- average_order_value


-- Exercise 6
-- Modify the customer order view so customers with no
-- orders are also included.


-- ============================================================
-- SECTION 3 — BUSINESS LOGIC
-- ============================================================

-- Exercise 7
-- Create a view that classifies employees by salary:
--
-- HIGH   >= 100000
-- MEDIUM >= 70000
-- LOW    < 70000


-- Exercise 8
-- Create a view that classifies customers:
--
-- VIP      >= 20000
-- PREMIUM  >= 10000
-- REGULAR  >= 5000
-- LOW      otherwise


-- Exercise 9
-- Create a view that displays only customers classified as
-- VIP or PREMIUM.


-- ============================================================
-- SECTION 4 — WINDOW FUNCTIONS IN VIEWS
-- ============================================================

-- Exercise 10
-- Create a view that ranks employees by salary within
-- each department.


-- Exercise 11
-- Using the view from Exercise 10, return the top two
-- employees in every department.


-- Exercise 12
-- Create a view that calculates each employee's salary
-- and their department's average salary.


-- Exercise 13
-- Using the view, find employees whose salary is above
-- their department average.


-- ============================================================
-- SECTION 5 — VIEW ON VIEW
-- ============================================================

-- Exercise 14
-- Create:
--
-- View 1 → customer_order_summary
-- View 2 → customer_performance
--
-- View 2 should be based on View 1.


-- Exercise 15
-- Add a customer_category column to customer_performance.


-- Exercise 16
-- Query customer_performance and return only PREMIUM
-- and VIP customers.


-- ============================================================
-- SECTION 6 — UPDATABLE VIEWS
-- ============================================================

-- Exercise 17
-- Create a simple view containing:
--
-- customer_id
-- customer_name
-- email
-- status
--
-- Return only ACTIVE customers.


-- Exercise 18
-- Update a customer's name through the view.


-- Exercise 19
-- Create the same view using WITH CHECK OPTION.


-- Exercise 20
-- Attempt to change an ACTIVE customer to INACTIVE
-- through the view.
--
-- Observe what happens.


-- ============================================================
-- SECTION 7 — VIEW MANAGEMENT
-- ============================================================

-- Exercise 21
-- Display the SQL definition of customer_order_summary
-- using SHOW CREATE VIEW.


-- Exercise 22
-- Replace the definition of a view using
-- CREATE OR REPLACE VIEW.


-- Exercise 23
-- Drop a view safely using DROP VIEW IF EXISTS.


-- ============================================================
-- SECTION 8 — SECURITY AND ABSTRACTION
-- ============================================================

-- Exercise 24
-- Create a public employee directory view.
--
-- Include:
-- employee_id
-- employee_name
-- department_id
-- hire_date
--
-- Do not expose salary.


-- Exercise 25
-- Create a customer directory view that exposes only:
--
-- customer_id
-- customer_name
-- email
--
-- Do not expose the customer status.


-- ============================================================
-- SECTION 9 — REPORTING VIEWS
-- ============================================================

-- Exercise 26
-- Create a department reporting view.
--
-- Include:
-- department_name
-- employee_count
-- total_salary
-- average_salary


-- Exercise 27
-- Create an employee performance view.
--
-- Include:
-- employee_name
-- department_name
-- salary
-- salary_rank
-- department_average_salary


-- Exercise 28
-- Query the employee performance view to find the highest
-- paid employee in every department.


-- ============================================================
-- SECTION 10 — VIEWS VS CTEs
-- ============================================================

-- Exercise 29
-- Write a CTE that calculates total customer spending.


-- Exercise 30
-- Convert the same query into a permanent view.


-- Exercise 31
-- Explain:
--
-- When would the CTE be preferable?
-- When would the view be preferable?


-- ============================================================
-- SECTION 11 — VIEW DESIGN
-- ============================================================

-- Exercise 32
-- Rewrite a view that uses SELECT * so that it explicitly
-- lists the required columns.


-- Exercise 33
-- Create a view with a meaningful and descriptive name.


-- Exercise 34
-- Identify whether the following view is likely to be
-- updatable:
--
-- SELECT
--     department_id,
--     AVG(salary)
-- FROM employees
-- GROUP BY department_id;


-- Exercise 35
-- Identify whether the following view is likely to be
-- updatable:
--
-- SELECT
--     employee_id,
--     employee_name,
--     salary
-- FROM employees
-- WHERE status = 'ACTIVE';


-- ============================================================
-- SECTION 12 — FINAL REPORT
-- ============================================================

-- Exercise 36
-- Create a customer analytics view containing:
--
-- customer_name
-- order_count
-- total_spent
-- average_order_value
-- customer_category
--
-- Sort the result by total_spent when querying the view.


-- Exercise 37
-- Create an employee analytics view containing:
--
-- employee_name
-- department_name
-- salary
-- salary_rank
-- department_average_salary
-- salary_difference


-- Exercise 38
-- Query the employee analytics view and return employees
-- earning more than their department average.


-- ============================================================
-- MINI PROJECT
-- ============================================================

-- Project: Business Reporting Layer
--
-- Build three reusable views:
--
-- View 1:
-- employee_department_summary
--
-- View 2:
-- customer_order_summary
--
-- View 3:
-- customer_performance
--
-- customer_performance should be based on
-- customer_order_summary.
--
-- The final customer view must contain:
--
-- customer_name
-- order_count
-- total_spent
-- average_order_value
-- customer_category
--
-- The goal is to create a reusable reporting layer
-- rather than writing the same business logic repeatedly.
```
