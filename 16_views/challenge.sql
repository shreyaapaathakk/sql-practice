-- ============================================================
-- MODULE 16: VIEWS
-- challenge.sql
-- MySQL 8.0+
-- ============================================================

-- These challenges are intentionally different from the
-- practice exercises.
----------------------

## -- Try solving them without looking at solutions.sql.

-- Some challenges are SQL interview-style questions.
-- The final challenge is designed as a small portfolio task.

CREATE DATABASE IF NOT EXISTS module16_views;

USE module16_views;

-- ============================================================
-- CHALLENGE 1 — INTERVIEW STYLE
-- ============================================================

## -- Create a view named sales_employee_report.

-- Return:
-- employee_id
-- employee_name
-- department_name
-- salary
---------

## -- Only include employees who belong to the Sales department.

-- Then query the view to display the employees ordered by
-- salary from highest to lowest.

-- ============================================================
-- CHALLENGE 2 — INTERVIEW STYLE
-- ============================================================

## -- Create a view named customer_order_metrics.

## -- Return one row per customer:

-- customer_id
-- customer_name
-- order_count
-- total_spent
-- highest_order
----------------

## -- Customers without orders must still appear.

## -- What JOIN should you use?

-- Use appropriate NULL handling.

-- ============================================================
-- CHALLENGE 3 — INTERVIEW STYLE
-- ============================================================

## -- Create a view named expensive_orders.

-- Include orders whose total_amount is greater than the
-- average order amount across ALL orders.
------------------------------------------

-- Return:
-- order_id
-- customer_id
-- order_date
-- total_amount
---------------

-- Hint:
-- The average can be calculated with a subquery.

-- ============================================================
-- CHALLENGE 4 — VIEW METADATA
-- ============================================================

## -- Write a query using INFORMATION_SCHEMA.VIEWS that returns:

-- TABLE_NAME
-- VIEW_DEFINITION
------------------

## -- for every view in the current database.

-- Sort the results alphabetically by TABLE_NAME.

-- ============================================================
-- CHALLENGE 5 — CREATE OR REPLACE
-- ============================================================

## -- Assume a view named employee_contact_report already exists.

## -- Create or replace it so that it contains:

-- employee_id
-- employee_name
-- email
-- hire_date
------------

## -- employee_name should combine first_name and last_name.

-- Do not include salary.

-- ============================================================
-- CHALLENGE 6 — UPDATABLE VIEW
-- ============================================================

## -- Create a simple view named employee_email_directory containing:

-- employee_id
-- first_name
-- last_name
-- email
--------

## -- Use the view to change employee_id 105's email to:

## -- [arjun.new@example.com](mailto:arjun.new@example.com)

## -- Verify the update through the employees table.

## -- Then restore:

-- [arjun@example.com](mailto:arjun@example.com)

-- ============================================================
-- CHALLENGE 7 — REPORTING VIEW
-- ============================================================

## -- Create a view named department_performance.

## -- Return:

-- department_id
-- department_name
-- employee_count
-- average_salary
-- highest_salary
-- total_salary
---------------

## -- The result should be useful for a management report.

-- Then display departments from highest total_salary to
-- lowest total_salary.

-- ============================================================
-- CHALLENGE 8 — CUSTOMER REPORT
-- ============================================================

## -- Create a view named customer_value_report.

## -- Return:

-- customer_id
-- customer_name
-- city
-- order_count
-- total_spent
-- average_order_value
----------------------

## -- Then query the view to identify customers who:

-- 1. Have at least 2 orders
-- 2. Have spent more than 2500
-------------------------------

-- Sort by total_spent descending.

-- ============================================================
-- CHALLENGE 9 — VIEW VS TABLE INTERVIEW QUESTION
-- ============================================================

## -- Answer the following question in a SQL comment:

-- What is the main difference between a normal table and
-- a normal view?
-----------------

-- Also explain why changing data in an underlying table can
-- change the results returned by a view.

-- ============================================================
-- CHALLENGE 10 — VIEW VS CTE INTERVIEW QUESTION
-- ============================================================

## -- Answer in a SQL comment:

## -- When would you prefer a VIEW over a CTE?

-- Give at least two practical reasons.

-- ============================================================
-- CHALLENGE 11 — UPDATABILITY INTERVIEW QUESTION
-- ============================================================

## -- Consider the following view:

-- CREATE VIEW department_summary AS
-- SELECT
--     department_id,
--     COUNT(*) AS employee_count,
--     AVG(salary) AS average_salary
-- FROM employees
-- GROUP BY department_id;
--------------------------

-- Explain in a SQL comment why this type of view should not
-- be treated as a simple updatable view.
-----------------------------------------

-- Think about the relationship between one result row and
-- the underlying employee rows.

-- ============================================================
-- CHALLENGE 12 — PORTFOLIO-STYLE PROJECT
-- ============================================================

## -- PROJECT: COMPANY REPORTING VIEW LAYER

## -- Build a small reporting layer using views.

## -- Create the following three views:

## -- 1. employee_directory_report

-- Columns:
-- employee_id
-- employee_name
-- department_name
-- email
-- hire_date
------------

## -- Salary should NOT be exposed.

--
-- 2. department_salary_report
------------------------------

-- Columns:
-- department_name
-- employee_count
-- total_salary
-- average_salary
-- highest_salary
-----------------

--
-- 3. customer_sales_report
---------------------------

-- Columns:
-- customer_id
-- customer_name
-- city
-- order_count
-- total_spent
-- average_order_value
----------------------

## -- Requirements:

## -- A. Use meaningful view names.

## -- B. Use table aliases where appropriate.

## -- C. Use appropriate JOIN types.

## -- D. Use GROUP BY correctly for aggregate views.

## -- E. Handle customers without orders.

## -- F. Do not expose employee salary in employee_directory_report.

## -- G. Query each view after creating it.

## -- H. Use ORDER BY where it makes the report easier to read.

## -- I. Use SHOW CREATE VIEW on at least one of your views.

-- J. Use INFORMATION_SCHEMA.VIEWS to confirm that all three
--    reporting views exist.
----------------------------

-- K. Explain in comments why a VIEW is useful for this reporting
--    layer instead of repeatedly writing the underlying queries.
-----------------------------------------------------------------

## -- Optional extension:

-- Create a fourth view named high_value_orders_report containing
-- orders whose total_amount is greater than 2000.
--------------------------------------------------

-- The final result should look like a small, realistic reporting
-- layer that could be included in a SQL portfolio repository.
