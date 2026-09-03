-- ============================================================
-- MODULE 21: SQL VIEWS
-- challenge.sql
-- ============================================================

USE module21_views;

-- ============================================================
-- CHALLENGE 1 — EMPLOYEE REPORTING VIEW
-- ============================================================

## -- Create a view named employee_report.

## -- Include:

-- employee_name
-- department_name
-- salary
-- salary_category
------------------

## -- Salary categories:

-- >= 80000 → High
-- >= 60000 → Medium
-- otherwise → Low
------------------

-- Then query the view.

-- ============================================================
-- CHALLENGE 2 — DEPARTMENT SUMMARY VIEW
-- ============================================================

## -- Create a view named department_report.

## -- Include:

-- department_name
-- employee_count
-- total_salary
-- average_salary
-----------------

-- Then return departments ordered by total salary.

-- ============================================================
-- CHALLENGE 3 — TOP EMPLOYEES VIEW
-- ============================================================

## -- Create a view containing:

-- employee_name
-- department_name
-- salary
-- department_rank
------------------

## -- Rank employees within each department.

-- Use RANK().

-- ============================================================
-- CHALLENGE 4 — TOP TWO PER DEPARTMENT
-- ============================================================

-- Using the view from Challenge 3, return the top two
-- employees from every department.

-- ============================================================
-- CHALLENGE 5 — CUSTOMER ORDER VIEW
-- ============================================================

## -- Create a view named customer_orders_report.

## -- Include:

-- customer_name
-- city
-- order_id
-- order_date
-- total_amount
---------------

-- Then return orders greater than 2000.

-- ============================================================
-- CHALLENGE 6 — CUSTOMER PERFORMANCE VIEW
-- ============================================================

## -- Create a view named customer_performance.

## -- Include:

-- customer_name
-- city
-- total_orders
-- total_spending
-- average_order_value
-- largest_order
----------------

-- Include customers who have no orders.

-- ============================================================
-- CHALLENGE 7 — TOP CUSTOMERS
-- ============================================================

-- Using customer_performance, return the top three customers
-- by total spending.

-- ============================================================
-- CHALLENGE 8 — ABOVE-AVERAGE CUSTOMERS
-- ============================================================

-- Using customer_performance, find customers whose spending
-- is greater than the average spending across all customers.
-------------------------------------------------------------

-- Do not create unnecessary duplicate views.

-- ============================================================
-- CHALLENGE 9 — EMPLOYEE ANALYTICS VIEW
-- ============================================================

## -- Create a view named employee_analytics.

## -- Include:

-- employee_name
-- department_name
-- salary
-- department_average
-- salary_difference
-- department_rank
------------------

-- Use:
-- JOIN
-- window functions
-- calculated columns

-- ============================================================
-- CHALLENGE 10 — ABOVE-AVERAGE EMPLOYEES
-- ============================================================

-- Using employee_analytics, return employees whose salary
-- is above their department average.

-- ============================================================
-- CHALLENGE 11 — CREATE OR REPLACE
-- ============================================================

## -- Create a view named employee_summary containing:

-- employee_id
-- first_name
-- salary
---------

## -- Then replace the view so that it also includes:

-- last_name
-- department_id
----------------

-- Use CREATE OR REPLACE VIEW.

-- ============================================================
-- CHALLENGE 12 — PUBLIC EMPLOYEE VIEW
-- ============================================================

## -- Create a view that exposes:

-- employee_id
-- first_name
-- last_name
-- department_name
------------------

## -- Do not expose salary.

-- This simulates a simplified public-facing dataset.

-- ============================================================
-- CHALLENGE 13 — VIEW MANAGEMENT
-- ============================================================

## -- Write SQL statements to:

-- 1. Display the definition of employee_analytics.
-- 2. Display all tables and views.
-- 3. Safely drop employee_summary.

-- ============================================================
-- CHALLENGE 14 — VIEW + GROUP BY
-- ============================================================

## -- Using employee_report:

## -- Return:

-- salary_category
-- employee_count
-- average_salary
-----------------

-- Group employees by salary category.

-- ============================================================
-- CHALLENGE 15 — VIEW + HAVING
-- ============================================================

## -- Using department_report:

-- Return departments whose employee count is greater than 1
-- and whose average salary is greater than 50000.

-- ============================================================
-- CHALLENGE 16 — VIEW + WINDOW FUNCTION
-- ============================================================

## -- Create a customer ranking view.

## -- Include:

-- customer_name
-- total_spending
-- spending_rank
----------------

-- Rank customers using RANK().

-- ============================================================
-- CHALLENGE 17 — REUSABLE BUSINESS LOGIC
-- ============================================================

## -- Create a view that determines customer status:

-- total_spending >= 4000 → 'VIP'
-- total_spending >= 2000 → 'Regular'
-- otherwise → 'Low Value'
--------------------------

## -- Include:

-- customer_name
-- total_spending
-- customer_status

-- ============================================================
-- CHALLENGE 18 — COMBINED EMPLOYEE REPORT
-- ============================================================

## -- Create a portfolio-quality employee reporting view.

## -- Include:

-- employee_id
-- employee_name
-- department_name
-- salary
-- salary_category
-- department_rank
-- department_average
-- salary_difference
--------------------

## -- Requirements:

-- JOIN employees and departments.
-- Use CASE.
-- Use RANK().
-- Use a window function for department average.

-- ============================================================
-- CHALLENGE 19 — COMBINED CUSTOMER REPORT
-- ============================================================

## -- Create a portfolio-quality customer reporting view.

## -- Include:

-- customer_name
-- city
-- total_orders
-- total_spending
-- average_order_value
-- largest_order
-- spending_rank
-- customer_status
------------------

## -- Requirements:

-- Use LEFT JOIN.
-- Use aggregation.
-- Use a window function.
-- Use CASE.

-- ============================================================
-- CHALLENGE 20 — MODULE 21 PORTFOLIO PROJECT
-- ============================================================

## -- PROJECT: REUSABLE SQL REPORTING LAYER

-- Build a collection of reusable views that could form the
-- reporting layer of a small business database.
------------------------------------------------

--
-- VIEW 1 — Employee Report
---------------------------

## -- Include:

-- employee_name
-- department_name
-- salary
-- salary_category
-- department_rank
-- department_average
-- salary_difference
--------------------

--
-- VIEW 2 — Department Report
-----------------------------

## -- Include:

-- department_name
-- employee_count
-- total_salary
-- average_salary
-----------------

--
-- VIEW 3 — Customer Report
---------------------------

## -- Include:

-- customer_name
-- city
-- total_orders
-- total_spending
-- average_order_value
-- largest_order
-- spending_rank
-- customer_status
------------------

--
-- VIEW 4 — Order Report
------------------------

## -- Include:

-- customer_name
-- city
-- order_id
-- order_date
-- total_amount
---------------

--
-- FINAL ANALYSIS
-----------------

## -- Using only your views where possible:

## -- 1. Find the top two employees in every department.

## -- 2. Find the top three customers.

## -- 3. Find above-average employees.

## -- 4. Find VIP customers.

## -- 5. Find departments with more than one employee.

--
-- REQUIREMENTS
---------------

## -- 1. Create at least four views.

## -- 2. Use JOINs.

## -- 3. Use GROUP BY.

## -- 4. Use CASE.

## -- 5. Use window functions.

## -- 6. Use meaningful view names.

## -- 7. Add comments explaining each view.

## -- 8. Use CREATE OR REPLACE where appropriate.

## -- 9. Use DROP VIEW IF EXISTS during setup.

-- 10. Write the project as portfolio-quality SQL suitable
--     for your GitHub sql-practice repository.
