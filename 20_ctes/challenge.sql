-- ============================================================
-- MODULE 20: CTEs
-- challenge.sql
-- ============================================================

USE module20_ctes;

-- ============================================================
-- CHALLENGE 1 — DEPARTMENT ANALYTICS
-- ============================================================

## -- Build a multi-step analysis of departments.

## -- Return:

-- department_name
-- employee_count
-- total_salary
-- average_salary
-- department_rank
------------------

-- Rank departments by total salary.

-- ============================================================
-- CHALLENGE 2 — EMPLOYEE ANALYTICS
-- ============================================================

## -- Build an employee analytical report.

## -- Return:

-- employee_name
-- department_name
-- salary
-- department_rank
-- department_average
-- salary_difference
--------------------

-- Use at least two CTEs.

-- ============================================================
-- CHALLENGE 3 — TOP TWO PER DEPARTMENT
-- ============================================================

## -- Find the top two highest-paid employees in every department.

## -- Requirements:

-- Use ROW_NUMBER().
-- Use PARTITION BY.
-- Use a CTE.
-------------

## -- Return:

-- employee_name
-- department_name
-- salary
-- department_rank

-- ============================================================
-- CHALLENGE 4 — ABOVE-AVERAGE EMPLOYEES
-- ============================================================

-- Find employees whose salary is greater than their
-- department average.
----------------------

## -- Return:

-- employee_name
-- department_name
-- salary
-- department_average
-- salary_difference
--------------------

-- Use a CTE and a window function.

-- ============================================================
-- CHALLENGE 5 — CUSTOMER SPENDING PIPELINE
-- ============================================================

## -- Create the following pipeline:

-- Step 1:
-- Calculate total spending per customer.
-----------------------------------------

-- Step 2:
-- Calculate average customer spending.
---------------------------------------

-- Step 3:
-- Rank customers by total spending.
------------------------------------

-- Step 4:
-- Return customers above average.
----------------------------------

## -- Return:

-- customer_name
-- total_spending
-- average_customer_spending
-- spending_rank

-- ============================================================
-- CHALLENGE 6 — TOP CUSTOMERS
-- ============================================================

## -- Find the top three customers by total spending.

## -- Include ties.

-- Use RANK().

-- ============================================================
-- CHALLENGE 7 — CUSTOMER ORDER SUMMARY
-- ============================================================

## -- Build a customer summary containing:

-- customer_name
-- total_orders
-- total_spending
-- average_order_value
-- largest_order
----------------

-- Use a CTE.

-- ============================================================
-- CHALLENGE 8 — CUSTOMER ORDER RANKING
-- ============================================================

## -- For every customer, rank their orders from largest to smallest.

## -- Return:

-- customer_name
-- order_id
-- total_amount
-- order_rank
-------------

-- Use:
-- CTE
-- ROW_NUMBER()
-- PARTITION BY

-- ============================================================
-- CHALLENGE 9 — LARGEST ORDER PER CUSTOMER
-- ============================================================

## -- Find the largest order for every customer.

## -- Return:

-- customer_name
-- order_id
-- order_date
-- total_amount
---------------

-- Use ROW_NUMBER() inside a CTE.

-- ============================================================
-- CHALLENGE 10 — DEPARTMENT SALARY DISTRIBUTION
-- ============================================================

## -- Calculate:

-- employee_name
-- department_name
-- salary
-- department_total_salary
-- salary_percentage
--------------------

-- salary_percentage should represent the employee's salary
-- as a percentage of the department's total salary.
----------------------------------------------------

-- Use a CTE and a window function.

-- ============================================================
-- CHALLENGE 11 — DEPARTMENT LEADER
-- ============================================================

## -- Find the highest-paid employee in each department.

## -- Return:

-- employee_name
-- department_name
-- salary
-- department_average
-- difference_from_average
--------------------------

-- Use multiple CTEs.

-- ============================================================
-- CHALLENGE 12 — SECOND-HIGHEST EMPLOYEE
-- ============================================================

## -- Find the second-highest-paid employee in every department.

-- Use ROW_NUMBER() and a CTE.

-- ============================================================
-- CHALLENGE 13 — SALARY CATEGORIES
-- ============================================================

## -- Classify employees:

-- 80000+ → High
-- 60000–79999 → Medium
-- below 60000 → Low
--------------------

## -- Then produce:

-- salary_category
-- employee_count
-- average_salary
-----------------

-- Use a CTE.

-- ============================================================
-- CHALLENGE 14 — RECURSIVE NUMBER GENERATOR
-- ============================================================

## -- Generate numbers from 1 through 50.

-- Use a recursive CTE.

-- ============================================================
-- CHALLENGE 15 — RECURSIVE DATE GENERATOR
-- ============================================================

## -- Generate every date in January 2026.

-- Use a recursive CTE.

-- ============================================================
-- CHALLENGE 16 — EMPLOYEE HIERARCHY
-- ============================================================

## -- Display the organizational hierarchy.

## -- Return:

-- employee_id
-- employee_name
-- manager_id
-- hierarchy_level
------------------

## -- Use a recursive CTE.

-- The CEO/top-level employee should have hierarchy_level = 0.

-- ============================================================
-- CHALLENGE 17 — MULTI-STEP BUSINESS ANALYSIS
-- ============================================================

## -- Build a complete employee business analysis.

-- CTE 1:
-- Join employees and departments.
----------------------------------

-- CTE 2:
-- Calculate department statistics.
-----------------------------------

-- CTE 3:
-- Rank employees.
------------------

-- CTE 4:
-- Calculate salary differences.
--------------------------------

## -- Final result:

-- employee_name
-- department_name
-- salary
-- department_rank
-- department_average
-- department_total_salary
-- salary_difference
-- salary_status

-- ============================================================
-- CHALLENGE 18 — CUSTOMER BUSINESS ANALYSIS
-- ============================================================

## -- Build a customer performance report.

## -- Return:

-- customer_name
-- total_orders
-- total_spending
-- average_order_value
-- largest_order
-- spending_rank
-- customer_status
------------------

## -- customer_status:

-- spending above average
-- → 'Above Average'
--------------------

-- otherwise
-- → 'Below Average'
--------------------

-- Use multiple CTEs.

-- ============================================================
-- CHALLENGE 19 — ADVANCED TOP-N ANALYSIS
-- ============================================================

## -- Find the top two customers by spending within each city.

## -- Requirements:

-- 1. Calculate customer spending.
-- 2. Join customers with spending.
-- 3. Rank customers within each city.
-- 4. Return the top two per city.
----------------------------------

-- Use multiple CTEs and ROW_NUMBER().

-- ============================================================
-- CHALLENGE 20 — MODULE 20 PORTFOLIO PROJECT
-- ============================================================

## -- PROJECT: BUSINESS PERFORMANCE ANALYTICS

## -- Build a portfolio-quality SQL project combining:

-- CTEs
-- Multiple CTEs
-- JOINs
-- GROUP BY
-- Window functions
-- CASE
-- Ranking
----------

--
-- PART A — EMPLOYEE PERFORMANCE
--------------------------------

## -- Produce:

-- employee_name
-- department_name
-- salary
-- department_rank
-- department_average
-- department_total_salary
-- salary_difference
-- salary_percentage
--------------------

--
-- PART B — CUSTOMER PERFORMANCE
--------------------------------

## -- Produce:

-- customer_name
-- total_orders
-- total_spending
-- average_order_value
-- largest_order
-- spending_rank
----------------

--
-- PART C — TOP PERFORMERS
--------------------------

## -- Find:

## -- Top 2 employees in every department.

## -- Top 3 customers overall.

--
-- PART D — MANAGEMENT HIERARCHY
--------------------------------

## -- Produce:

-- employee_name
-- manager_id
-- hierarchy_level
------------------

## -- Use a recursive CTE.

--
-- REQUIREMENTS
---------------

## -- 1. Use at least four CTEs across the project.

## -- 2. Use at least two window functions.

## -- 3. Use at least one recursive CTE.

## -- 4. Use at least one CASE expression.

## -- 5. Use at least two JOINs.

## -- 6. Use at least one GROUP BY.

## -- 7. Use clear CTE names.

## -- 8. Add comments explaining each logical step.

## -- 9. Keep each major analysis as a separate SQL statement.

-- 10. Write the SQL as if it will be displayed in a GitHub
--     portfolio.
