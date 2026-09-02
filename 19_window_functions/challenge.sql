-- ============================================================
-- MODULE 19: WINDOW FUNCTIONS
-- challenge.sql
-- ============================================================

USE module19_window_functions;

-- ============================================================
-- CHALLENGE 1 — COMPANY SALARY LEADERBOARD
-- ============================================================

## -- Create a salary leaderboard.

-- Return:
-- employee_name
-- department_name
-- salary
-- company_rank
-- dense_company_rank
-- row_number
-------------

-- Sort by salary descending.

-- ============================================================
-- CHALLENGE 2 — DEPARTMENT LEADERBOARD
-- ============================================================

## -- Rank employees within each department.

-- Return:
-- employee_name
-- department_name
-- salary
-- department_rank
------------------

-- Highest-paid employee should have rank 1.

-- ============================================================
-- CHALLENGE 3 — TOP N PER GROUP
-- ============================================================

## -- Find the top two highest-paid employees from every department.

-- Use ROW_NUMBER() and a CTE.

-- ============================================================
-- CHALLENGE 4 — INCLUDE TIES
-- ============================================================

## -- Find the top three salary ranks in the company.

## -- Employees sharing a salary rank should all be included.

-- Use RANK().

-- ============================================================
-- CHALLENGE 5 — DEPARTMENT AVERAGE ANALYSIS
-- ============================================================

## -- Display:

-- employee_name
-- department_name
-- salary
-- department_average
-- salary_difference
-- salary_status
----------------

## -- salary_status:

-- salary > department average
-- → 'Above Average'
--------------------

-- otherwise
-- → 'Below Average'

-- ============================================================
-- CHALLENGE 6 — RUNNING SALES
-- ============================================================

## -- Create a company-wide running sales report.

-- Return:
-- order_id
-- order_date
-- total_amount
-- running_total
----------------

-- Order chronologically.

-- ============================================================
-- CHALLENGE 7 — CUSTOMER RUNNING SALES
-- ============================================================

## -- Create a customer-level running sales report.

-- Return:
-- customer_id
-- order_id
-- order_date
-- total_amount
-- customer_running_total
-------------------------

-- Each customer's running total should start from zero.

-- ============================================================
-- CHALLENGE 8 — PREVIOUS ORDER ANALYSIS
-- ============================================================

## -- For each customer order, show:

-- customer_id
-- order_id
-- order_date
-- total_amount
-- previous_order_amount
-- amount_change
-- percentage_change
--------------------

## -- Use LAG().

-- Avoid division-by-zero errors.

-- ============================================================
-- CHALLENGE 9 — NEXT ORDER ANALYSIS
-- ============================================================

## -- For each order, show:

-- customer_id
-- order_id
-- order_date
-- total_amount
-- next_order_amount
-- difference_to_next_order
---------------------------

-- Use LEAD().

-- ============================================================
-- CHALLENGE 10 — CUSTOMER ORDER RANKING
-- ============================================================

## -- Rank each customer's orders by amount.

-- Return:
-- customer_id
-- order_id
-- total_amount
-- customer_order_rank
----------------------

-- Highest order amount should have rank 1.

-- ============================================================
-- CHALLENGE 11 — SALARY QUARTILES
-- ============================================================

## -- Divide employees into four salary groups.

-- Group 1:
-- Highest salaries
-------------------

-- Group 4:
-- Lowest salaries
------------------

-- Use NTILE(4).

-- ============================================================
-- CHALLENGE 12 — DEPARTMENT SALARY QUARTILES
-- ============================================================

## -- Divide employees into two salary groups within each department.

-- Use:
-- NTILE(2)
-- PARTITION BY department_id

-- ============================================================
-- CHALLENGE 13 — HIGHEST AND LOWEST
-- ============================================================

## -- For each employee display:

-- employee_name
-- department_id
-- salary
-- highest_department_salary
-- lowest_department_salary
---------------------------

-- Use FIRST_VALUE() and LAST_VALUE().

-- ============================================================
-- CHALLENGE 14 — MOVING AVERAGE
-- ============================================================

## -- Calculate a three-order moving average.

-- The calculation should include:
-- current order
-- previous order
-- second previous order
------------------------

-- Order by order_date.

-- ============================================================
-- CHALLENGE 15 — TOP EMPLOYEE VS DEPARTMENT AVERAGE
-- ============================================================

## -- Find the highest-paid employee in each department.

-- Display:
-- employee_name
-- department_name
-- salary
-- department_average
-- difference_from_average
--------------------------

-- Use:
-- CTE
-- ROW_NUMBER()
-- AVG() OVER()

-- ============================================================
-- CHALLENGE 16 — CUMULATIVE DEPARTMENT SALARY
-- ============================================================

## -- For every employee calculate:

-- employee_name
-- department_id
-- salary
-- cumulative_salary
-- department_total_salary
-- cumulative_salary_percentage
-------------------------------

-- Employees should be ordered by salary descending
-- within each department.

-- ============================================================
-- CHALLENGE 17 — BUSINESS ANALYSIS
-- ============================================================

## -- Build an employee analytical report containing:

-- employee_name
-- department_name
-- salary
-- company_rank
-- department_rank
-- department_average
-- department_max_salary
-- salary_difference
-- salary_status
----------------

## -- salary_status:

-- salary > department_average
-- → 'Above Average'
--------------------

-- otherwise
-- → 'Below Average'
--------------------

-- Use multiple window functions.

-- ============================================================
-- CHALLENGE 18 — CUSTOMER ANALYTICS
-- ============================================================

## -- Build a customer order analysis.

## -- For every order calculate:

-- customer_id
-- order_id
-- order_date
-- total_amount
-- customer_order_rank
-- previous_order_amount
-- customer_running_total
-------------------------

-- Use:
-- RANK()
-- LAG()
-- SUM() OVER()
-- PARTITION BY

-- ============================================================
-- CHALLENGE 19 — TOP CUSTOMER ORDER
-- ============================================================

## -- Find the largest order for every customer.

-- Return:
-- customer_name
-- order_id
-- order_date
-- total_amount
---------------

-- Use ROW_NUMBER() and a CTE.

-- ============================================================
-- CHALLENGE 20 — PORTFOLIO PROJECT
-- ============================================================

## -- PROJECT: EMPLOYEE & SALES ANALYTICS

## -- Build a portfolio-quality SQL analysis using window functions.

## -- SECTION A — EMPLOYEE RANKING

-- Include:
-- employee_name
-- department_name
-- salary
-- company_rank
-- department_rank
------------------

--
-- SECTION B — SALARY ANALYSIS
------------------------------

-- Include:
-- employee_name
-- salary
-- department_average
-- department_max_salary
-- salary_difference
-- salary_percentage_of_department
----------------------------------

--
-- SECTION C — CUSTOMER ORDER ANALYSIS
--------------------------------------

-- Include:
-- customer_name
-- order_id
-- order_date
-- total_amount
-- previous_order_amount
-- amount_change
-- customer_running_total
-------------------------

--
-- SECTION D — TOP-N ANALYSIS
-----------------------------

## -- Find the top two employees in every department.

--
-- REQUIREMENTS
---------------

## -- 1. Use at least three different window functions.

## -- 2. Use PARTITION BY at least twice.

## -- 3. Use ORDER BY inside OVER().

## -- 4. Use at least one CTE.

## -- 5. Use at least one ranking function.

## -- 6. Use LAG() or LEAD().

## -- 7. Use a running total.

## -- 8. Add comments explaining each major step.

## -- 9. Keep each analytical report as a separate SQL statement.

-- 10. Format the SQL clearly enough for a GitHub portfolio.
