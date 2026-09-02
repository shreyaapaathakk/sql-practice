-- ============================================================
-- MODULE 19: WINDOW FUNCTIONS
-- practice.sql
-- ============================================================

USE module19_window_functions;

-- ============================================================
-- EASY
-- ============================================================

-- Exercise 1
-- Display every employee and the average salary of all employees.
------------------------------------------------------------------

-- Columns:
-- first_name
-- salary
-- company_average_salary

-- Exercise 2
-- Display every employee and the total salary of all employees.
----------------------------------------------------------------

-- Do not use GROUP BY.

-- Exercise 3
-- Display every employee with the average salary of their department.
----------------------------------------------------------------------

-- Columns:
-- first_name
-- department_id
-- salary
-- department_average

-- Exercise 4
-- Rank all employees by salary from highest to lowest.
-------------------------------------------------------

-- Use RANK().

-- Exercise 5
-- Assign a unique row number to employees ordered by salary
-- descending.
--------------

-- Use ROW_NUMBER().

-- Exercise 6
-- Assign a dense salary rank to all employees.
-----------------------------------------------

-- Use DENSE_RANK().

-- ============================================================
-- MEDIUM
-- ============================================================

-- Exercise 7
-- Rank employees within each department by salary.
---------------------------------------------------

-- Use:
-- PARTITION BY
-- RANK()

-- Exercise 8
-- Number employees within each department.
-------------------------------------------

-- Highest-paid employee in each department should receive 1.

-- Exercise 9
-- Display each order together with the previous order amount.
--------------------------------------------------------------

-- Use LAG().

-- Exercise 10
-- Display each order together with the next order amount.
----------------------------------------------------------

-- Use LEAD().

-- Exercise 11
-- Calculate the difference between the current order amount
-- and the previous order amount.

-- Exercise 12
-- Calculate a running total of all orders ordered by order_date.

-- Exercise 13
-- Calculate a running total for each customer.
-----------------------------------------------

-- Use:
-- PARTITION BY customer_id
-- ORDER BY order_date

-- Exercise 14
-- Display each employee's salary and the maximum salary in
-- their department.

-- Exercise 15
-- Display each employee's salary and the minimum salary in
-- their department.

-- Exercise 16
-- Calculate how much each employee's salary differs from the
-- average salary of their department.

-- ============================================================
-- HARD
-- ============================================================

-- Exercise 17
-- Divide employees into four salary groups using NTILE(4).
-----------------------------------------------------------

-- Highest salaries should be in group 1.

-- Exercise 18
-- Find the highest-paid employee in every department.
------------------------------------------------------

-- Use:
-- ROW_NUMBER()
-- PARTITION BY
---------------

-- Return only rank 1.

-- Exercise 19
-- Find the top two employees from every department.

-- Exercise 20
-- Find the top three highest-paid employees in the company.
------------------------------------------------------------

-- Use a CTE and a window function.

-- Exercise 21
-- Find the top three salary ranks.
-----------------------------------

## -- Unlike Exercise 20, include employees tied at the same rank.

-- Use RANK().

-- Exercise 22
-- Calculate each employee's percentage of their department's
-- total salary.

-- Exercise 23
-- Calculate a three-order moving average.
------------------------------------------

-- Use:
-- current row
-- two preceding rows

-- Exercise 24
-- For every customer order, display:
-------------------------------------

-- customer_id
-- order_id
-- total_amount
-- previous_order_amount
-- amount_change
----------------

-- Use LAG() with PARTITION BY customer_id.

-- ============================================================
-- ADVANCED BEGINNER
-- ============================================================

-- Exercise 25
-- Classify employees:
----------------------

-- salary above department average → 'Above Average'
-- otherwise → 'Below Average'
------------------------------

-- Use CASE + window function.

-- Exercise 26
-- Display:
-----------

-- employee_name
-- department_name
-- salary
-- department_rank
-- department_average
---------------------

-- Use JOIN and multiple window functions.

-- Exercise 27
-- Find the highest-paid employee in each department and include:
-----------------------------------------------------------------

-- employee_name
-- department_name
-- salary
-- department_average
---------------------

-- Use a CTE.

-- Exercise 28
-- Find the second-highest-paid employee in every department.
-------------------------------------------------------------

-- Use ROW_NUMBER().

-- Exercise 29
-- Find employees whose salary is greater than the average salary
-- of their department.
-----------------------

-- Use a window function and CTE.

-- Exercise 30
-- Calculate the cumulative salary percentage for employees
-- within each department.
--------------------------

## -- Order employees by salary descending.

-- Hint:
-- Running SUM / department SUM.

-- ============================================================
-- INTERVIEW PRACTICE
-- ============================================================

-- Exercise 31
-- Explain the difference between:
----------------------------------

-- ROW_NUMBER()
-- RANK()
-- DENSE_RANK()

-- Exercise 32
-- Explain the difference between:
----------------------------------

-- GROUP BY
-- PARTITION BY

-- Exercise 33
-- Explain why a CTE is commonly needed when filtering the
-- result of a window function.

-- Exercise 34
-- Explain the difference between:
----------------------------------

-- LAG()
-- LEAD()

-- ============================================================
-- FINAL PRACTICE
-- ============================================================

-- Exercise 35
-- Build an employee ranking report.
------------------------------------

## -- Return:

-- employee_name
-- department_name
-- salary
-- company_rank
-- department_rank
-- department_average
-- salary_difference
--------------------

-- company_rank:
-- Rank all employees by salary.
--------------------------------

-- department_rank:
-- Rank employees within their department.
------------------------------------------

-- salary_difference:
-- Employee salary minus department average.
::
