-- ============================================================
-- MODULE 18: CASE EXPRESSIONS
-- challenge.sql
-- MySQL 8.0+
-- ============================================================

CREATE DATABASE IF NOT EXISTS module18_case_expressions;

USE module18_case_expressions;

-- ============================================================
-- CHALLENGE 1 — BASIC CLASSIFICATION
-- ============================================================

## -- Create a salary classification report.

-- Return:
-- employee_name
-- salary
-- salary_level
---------------

## -- Rules:

-- >= 80000 → 'Excellent'
-- >= 70000 → 'High'
-- >= 60000 → 'Above Average'
-- >= 50000 → 'Average'
-- otherwise → 'Below Average'
------------------------------

-- Use a searched CASE expression.

-- ============================================================
-- CHALLENGE 2 — CONDITIONAL AGGREGATION
-- ============================================================

## -- Create one report containing:

-- total_employees
-- high_salary_count
-- medium_salary_count
-- low_salary_count
-------------------

## -- Rules:

-- High: >= 70000
-- Medium: 50000–69999
-- Low: < 50000
---------------

-- Use SUM + CASE.

-- ============================================================
-- CHALLENGE 3 — DEPARTMENT REPORT
-- ============================================================

## -- For every department, display:

-- department_name
-- employee_count
-- average_salary
-- high_salary_count
-- salary_status
----------------

## -- salary_status:

-- average >= 70000 → 'High Paying'
-- average >= 55000 → 'Moderate'
-- otherwise → 'Low Paying'
---------------------------

-- Include departments even if they have no employees.

-- ============================================================
-- CHALLENGE 4 — CUSTOMER SEGMENTATION
-- ============================================================

## -- Build a customer segmentation report.

-- Step 1:
-- Calculate total spending per customer.
-----------------------------------------

-- Step 2:
-- Classify:
------------

-- >= 4000 → Premium
-- >= 2500 → Standard
-- >= 1500 → Regular
-- otherwise → Basic
--------------------

-- Step 3:
-- Return:
-- customer_name
-- city
-- total_spent
-- customer_segment
-------------------

-- Sort Premium first and Basic last.

-- ============================================================
-- CHALLENGE 5 — ORDER ANALYSIS
-- ============================================================

## -- Classify every order:

-- >= 3000 → Large
-- >= 1500 → Medium
-- otherwise → Small
--------------------

## -- Then calculate:

-- order_category
-- order_count
-- total_sales
-- average_order_value
----------------------

-- Sort by total_sales descending.

-- ============================================================
-- CHALLENGE 6 — CONDITIONAL AVERAGES
-- ============================================================

## -- Calculate all of the following in one query:

-- average_salary_all_employees
-- average_salary_technology
-- average_salary_sales
-- average_salary_finance
-- average_salary_hr
--------------------

## -- Use AVG + CASE.

-- Do not use WHERE or GROUP BY.

-- ============================================================
-- CHALLENGE 7 — EMPLOYEE PRIORITY
-- ============================================================

## -- Create an employee priority system.

## -- Rules:

-- Technology + salary >= 70000
-- → 'Critical'
---------------

-- Technology + salary >= 60000
-- → 'High'
-----------

-- Any department + salary >= 80000
-- → 'High'
-----------

-- Any department + salary >= 60000
-- → 'Medium'
-------------

-- Otherwise
-- → 'Normal'
-------------

-- Return:
-- employee_name
-- department_name
-- salary
-- priority
-----------

-- Carefully consider the order of the WHEN conditions.

-- ============================================================
-- CHALLENGE 8 — CASE WITH ORDER BY
-- ============================================================

## -- Create a custom employee ordering:

-- Critical employees first
-- High employees second
-- Medium employees third
-- Normal employees last
------------------------

## -- Within each priority group, sort by salary descending.

-- You may use a CASE expression inside ORDER BY.

-- ============================================================
-- CHALLENGE 9 — MULTIPLE CTEs + CASE
-- ============================================================

## -- Create three logical stages:

-- CTE 1:
-- employee_salary_data
-----------------------

## -- Calculate employee_name and salary.

-- CTE 2:
-- employee_categories
----------------------

## -- Add salary_level using CASE.

-- CTE 3:
-- employee_priority
--------------------

-- Add a priority classification based on:
-- salary_level
-- department_id
----------------

-- Final output:
-- employee_name
-- salary
-- salary_level
-- priority

-- ============================================================
-- CHALLENGE 10 — CUSTOMER PERFORMANCE
-- ============================================================

## -- Create a customer performance report.

-- Step 1:
-- Calculate total orders per customer.
---------------------------------------

-- Step 2:
-- Calculate total spending per customer.
-----------------------------------------

-- Step 3:
-- Calculate average order value.
---------------------------------

-- Step 4:
-- Classify:
------------

-- total_spent >= 4000 → 'Premium'
-- total_spent >= 2500 → 'Standard'
-- total_spent >= 1500 → 'Regular'
-- otherwise → 'Basic'
----------------------

-- Final columns:
-- customer_name
-- order_count
-- total_spent
-- average_order_value
-- customer_segment

-- ============================================================
-- CHALLENGE 11 — BUSINESS SUMMARY
-- ============================================================

## -- Build a single business summary report containing:

-- total_employees
-- high_salary_employees
-- total_customers
-- total_orders
-- large_orders
-- large_order_sales
--------------------

-- Use conditional aggregation with CASE where appropriate.

-- ============================================================
-- CHALLENGE 12 — CONDITIONAL PERCENTAGES
-- ============================================================

## -- For each department calculate:

-- department_name
-- total_employees
-- high_salary_employees
-- high_salary_percentage
-------------------------

-- High salary:
-- salary >= 60000
------------------

-- Round the percentage to two decimal places.

-- ============================================================
-- CHALLENGE 13 — DATA QUALITY REPORT
-- ============================================================

## -- Create an employee data-quality report.

-- Return:
-- employee_name
-- email_status
-- salary_status
----------------

-- email_status:
-- NULL → 'Missing'
-- otherwise → 'Available'
--------------------------

-- salary_status:
-- salary <= 0 → 'Invalid'
-- otherwise → 'Valid'
----------------------

-- Use CASE.

-- ============================================================
-- CHALLENGE 14 — INTERVIEW QUESTION
-- ============================================================

## -- Explain in SQL comments:

## -- 1. What is the difference between simple CASE and searched CASE?

## -- 2. Why does the order of WHEN conditions matter?

## -- 3. What happens when no WHEN condition matches and ELSE is absent?

-- 4. Why is CASE useful for conditional aggregation?

-- ============================================================
-- CHALLENGE 15 — CASE + CTE + AGGREGATION
-- ============================================================

## -- Build a department salary analysis.

-- Step 1:
-- Use a CTE to classify every employee:
----------------------------------------

-- High: >= 70000
-- Medium: 50000–69999
-- Low: < 50000
---------------

-- Step 2:
-- Group the CTE by department.
-------------------------------

-- Step 3:
-- Calculate:
-------------

-- department_id
-- high_count
-- medium_count
-- low_count
-- total_salary
-- average_salary
-----------------

-- Step 4:
-- Join with departments to display department_name.

-- ============================================================
-- CHALLENGE 16 — PORTFOLIO PROJECT
-- ============================================================

## -- PROJECT: BUSINESS SEGMENTATION & REPORTING

## -- Build a portfolio-quality SQL report using:

-- CASE
-- CTEs
-- JOINs
-- GROUP BY
-- Aggregate functions
-- Conditional aggregation
--------------------------

## -- Your analysis should contain at least three sections:

## -- SECTION A — EMPLOYEE ANALYSIS

-- Report:
-- employee_name
-- department_name
-- salary
-- salary_band
-- employee_priority
--------------------

## -- SECTION B — CUSTOMER ANALYSIS

-- Report:
-- customer_name
-- city
-- order_count
-- total_spent
-- average_order_value
-- customer_segment
-------------------

## -- SECTION C — ORDER ANALYSIS

-- Report:
-- order_category
-- order_count
-- total_sales
-- average_order_value
----------------------

## -- Requirements:

## -- 1. Use meaningful CTE names.

## -- 2. Use CASE for business classifications.

## -- 3. Use conditional aggregation at least once.

## -- 4. Use at least one CASE expression inside ORDER BY.

## -- 5. Use at least one CTE that references another CTE.

## -- 6. Use JOINs where appropriate.

## -- 7. Handle NULL values correctly.

## -- 8. Keep each report as a separate SQL statement.

## -- 9. Add comments explaining the purpose of each major step.

-- 10. Make the SQL readable enough to be included in a GitHub
--     portfolio.
-----------------

## -- OPTIONAL EXTENSION:

## -- Add a fourth section that compares departments using:

-- total employees
-- average salary
-- high salary percentage
-------------------------

## -- Then classify departments:

-- average salary >= 70000 → 'Premium Department'
-- average salary >= 55000 → 'Standard Department'
-- otherwise → 'Budget Department'
