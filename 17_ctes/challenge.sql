-- ============================================================
-- MODULE 17: COMMON TABLE EXPRESSIONS (CTEs)
-- challenge.sql
-- MySQL 8.0+
-- ============================================================

CREATE DATABASE IF NOT EXISTS module17_ctes;

USE module17_ctes;

-- ============================================================
-- CHALLENGE 1 — INTERVIEW STYLE
-- ============================================================

## -- Explain in a SQL comment:

## -- What is a CTE?

## -- What is the difference between a CTE and a VIEW?

-- Mention the scope of each.

-- ============================================================
-- CHALLENGE 2 — INTERVIEW STYLE
-- ============================================================

## -- Rewrite this query using a CTE:

-- SELECT *
-- FROM (
--     SELECT
--         department_id,
--         COUNT(*) AS employee_count
--     FROM employees
--     GROUP BY department_id
-- ) AS department_counts
-- WHERE employee_count >= 2;
-----------------------------

-- The final result should be equivalent.

-- ============================================================
-- CHALLENGE 3 — INTERVIEW STYLE
-- ============================================================

## -- Create a CTE that finds the employee with the highest salary.

-- Return:
-- employee_id
-- employee_name
-- salary
---------

-- Do not use a VIEW.

-- ============================================================
-- CHALLENGE 4 — INTERVIEW STYLE
-- ============================================================

## -- Create a CTE that calculates each department's average salary.

-- Then return departments whose average salary is higher than
-- the company-wide average salary.
-----------------------------------

-- Include the department name.

-- ============================================================
-- CHALLENGE 5 — MULTIPLE CTEs
-- ============================================================

## -- Create three CTEs:

-- 1. customer_totals
--    Calculate total spending per customer.
--------------------------------------------

-- 2. customer_averages
--    Calculate the average total spending across customers.
------------------------------------------------------------

-- 3. above_average_customers
--    Keep customers whose spending is above the average.
---------------------------------------------------------

-- Final output:
-- customer_name
-- total_spent
--------------

-- Sort by total_spent descending.

-- ============================================================
-- CHALLENGE 6 — MULTI-STEP ORDER ANALYSIS
-- ============================================================

## -- Build a multi-step analysis:

-- Step 1:
-- Calculate total order value for each customer.
-------------------------------------------------

-- Step 2:
-- Keep customers whose total spending is greater than 3000.
------------------------------------------------------------

-- Step 3:
-- Join with customers.
-----------------------

-- Step 4:
-- Display customer_name, city, and total_spent.
------------------------------------------------

-- Sort by total_spent descending.

-- ============================================================
-- CHALLENGE 7 — TOP-N WITH CTE
-- ============================================================

## -- Find the top 2 highest-paid employees.

-- Create a CTE that performs the ranking using:
-- ORDER BY
-- LIMIT
--------

-- Final output:
-- employee_name
-- salary
---------

-- Do not use a window function.

-- ============================================================
-- CHALLENGE 8 — CUSTOMER ORDER REPORT
-- ============================================================

## -- Create a CTE named customer_order_data.

## -- It should combine customers and orders.

## -- Then create a second CTE that calculates:

-- customer_id
-- order_count
-- total_spent
-- average_order_value
----------------------

## -- Finally join the result with customers.

-- Display:
-- customer_name
-- order_count
-- total_spent
-- average_order_value
----------------------

-- Sort by total_spent descending.

-- ============================================================
-- CHALLENGE 9 — CTE WITH CALCULATED VALUES
-- ============================================================

## -- Create a CTE containing:

-- employee_id
-- employee_name
-- monthly_salary
-- annual_salary
----------------

-- Then identify employees whose annual salary exceeds the
-- company-wide average annual salary.
--------------------------------------

-- Return:
-- employee_name
-- annual_salary
----------------

-- Sort from highest to lowest.

-- ============================================================
-- CHALLENGE 10 — RECURSIVE CTE INTERVIEW QUESTION
-- ============================================================

## -- Write a recursive CTE that generates numbers from 1 through 20.

## -- Add comments identifying:

-- 1. The anchor member
-- 2. The recursive member
-- 3. The termination condition

-- ============================================================
-- CHALLENGE 11 — RECURSIVE DATE RANGE
-- ============================================================

## -- Generate every date from:

## -- 2026-05-01

## -- through:

## -- 2026-05-10

## -- using a recursive CTE.

-- Return:
-- report_date

-- ============================================================
-- CHALLENGE 12 — CTE vs SUBQUERY
-- ============================================================

## -- Consider the following problem:

## -- Find departments whose average salary is above 60000.

## -- Solve the problem twice:

## -- A. Using a derived table.

## -- B. Using a CTE.

-- Add SQL comments explaining which version you find easier
-- to read and why.

-- ============================================================
-- CHALLENGE 13 — CTE WITH LEFT JOIN
-- ============================================================

## -- Build a customer activity report.

## -- Requirements:

-- 1. Include every customer.
-- 2. Count their orders.
-- 3. Calculate their total spending.
-- 4. Customers without orders must remain in the result.
---------------------------------------------------------

## -- Use at least one CTE.

-- Final columns:
-- customer_name
-- city
-- order_count
-- total_spent
--------------

-- Sort by total_spent descending.

-- ============================================================
-- CHALLENGE 14 — CTE DESIGN QUESTION
-- ============================================================

## -- Answer in SQL comments:

## -- Why is this unnecessary?

-- WITH all_employees AS (
--     SELECT *
--     FROM employees
-- )
-- SELECT *
-- FROM all_employees;
----------------------

-- When would a CTE actually make sense?

-- ============================================================
-- CHALLENGE 15 — PERFORMANCE QUESTION
-- ============================================================

## -- Answer in SQL comments:

## -- Does using a CTE automatically make a query faster?

## -- Explain why or why not.

-- Mention at least three factors that can affect SQL query
-- performance.

-- ============================================================
-- CHALLENGE 16 — PORTFOLIO-STYLE PROJECT
-- ============================================================

## -- PROJECT: BUSINESS PERFORMANCE ANALYSIS USING CTEs

## -- Build a small analytical report using multiple CTEs.

## -- Your report should answer:

-- 1. Who are the highest-spending customers?
-- 2. What is the average customer spending?
-- 3. Which customers spend above that average?
-- 4. Which departments have above-company-average salaries?
-- 5. Which employees are above the company-wide average salary?
----------------------------------------------------------------

## -- Requirements:

## -- A. Use meaningful CTE names.

## -- B. Use multiple CTEs where they improve the logical structure.

## -- C. Include at least one CTE that references another CTE.

## -- D. Include at least one JOIN involving a CTE.

## -- E. Include at least one aggregate CTE.

## -- F. Include appropriate NULL handling where necessary.

## -- G. Use ORDER BY for final reports where appropriate.

## -- H. Do not create any permanent views for this project.

## -- I. Keep each report within a single SQL statement.

## -- J. Add comments explaining the purpose of each CTE.

## -- OPTIONAL EXTENSION:

-- Create a recursive CTE that generates a 7-day reporting
-- calendar and use it to demonstrate how recursive CTEs can
-- generate a sequence of dates.
--------------------------------

-- The goal is to create readable, portfolio-quality SQL that
-- demonstrates multi-step analysis rather than simply writing
-- one large query.
