-- ============================================================
-- MODULE 20: CTEs
-- practice.sql
-- ============================================================

USE module20_ctes;

-- ============================================================
-- BASIC CTE PRACTICE
-- ============================================================

-- Exercise 1
-- Create a CTE containing employees whose salary is greater
-- than 60000.
--------------

-- Return:
-- first_name
-- salary

-- Exercise 2
-- Create a CTE containing all Technology department employees.
---------------------------------------------------------------

-- Return:
-- employee_id
-- first_name
-- salary

-- Exercise 3
-- Create a CTE that calculates the average salary for each
-- department.

-- Exercise 4
-- Use a CTE to calculate the total salary for each department.

-- Exercise 5
-- Use a CTE to calculate the number of employees in each
-- department.

-- ============================================================
-- CTE + JOIN
-- ============================================================

-- Exercise 6
-- Create a CTE containing department salary averages.
------------------------------------------------------

-- Join it with employees and display:
-- first_name
-- salary
-- department_average

-- Exercise 7
-- Join employees and departments through a CTE.
------------------------------------------------

-- Display:
-- employee_name
-- department_name
-- salary

-- Exercise 8
-- Find employees earning more than their department average.
-------------------------------------------------------------

-- Use a CTE.

-- Exercise 9
-- Find departments whose total salary exceeds 100000.
------------------------------------------------------

-- Use a CTE.

-- Exercise 10
-- Find departments with more than one employee.
------------------------------------------------

-- Use a CTE.

-- ============================================================
-- MULTIPLE CTEs
-- ============================================================

-- Exercise 11
-- Create:
----------

-- CTE 1:
-- department totals
--------------------

-- CTE 2:
-- rank departments by total salary
-----------------------------------

-- Return the department rankings.

-- Exercise 12
-- Create:
----------

-- CTE 1:
-- customer spending totals
---------------------------

-- CTE 2:
-- rank customers by spending
-----------------------------

-- Return the ranked customer list.

-- Exercise 13
-- Find the top three customers by total spending.
--------------------------------------------------

-- Use two CTEs.

-- Exercise 14
-- Find the highest-paid employee in every department.
------------------------------------------------------

-- Use:
-- CTE
-- ROW_NUMBER()

-- ============================================================
-- WINDOW FUNCTION + CTE
-- ============================================================

-- Exercise 15
-- Rank all employees by salary and return the top three.
---------------------------------------------------------

-- Use:
-- RANK()
-- CTE

-- Exercise 16
-- Find the top two employees in each department.
-------------------------------------------------

-- Use:
-- ROW_NUMBER()
-- PARTITION BY
-- CTE

-- Exercise 17
-- Find employees whose salary is above the company average.
------------------------------------------------------------

-- Use a CTE.

-- Exercise 18
-- Find employees whose salary is above their department average.
-----------------------------------------------------------------

-- Use:
-- window function
-- CTE

-- Exercise 19
-- Display:
-----------

-- employee_name
-- department_name
-- salary
-- department_rank
-- department_average
---------------------

-- Use multiple CTEs.

-- ============================================================
-- AGGREGATION PIPELINES
-- ============================================================

-- Exercise 20
-- Calculate each customer's total spending.
--------------------------------------------

## -- Then calculate the average customer spending.

## -- Finally return customers whose spending is above average.

-- Use multiple CTEs.

-- Exercise 21
-- Calculate department salary totals.
--------------------------------------

## -- Then calculate the average department salary total.

-- Return departments whose total is above that average.

-- Exercise 22
-- Calculate total spending for each customer.
----------------------------------------------

## -- Then rank customers by spending.

-- Then return the top two customers.

-- Exercise 23
-- Calculate each customer's:
-----------------------------

-- total spending
-- number of orders
-- average order amount
-----------------------

-- Use a CTE.

-- ============================================================
-- CASE + CTE
-- ============================================================

-- Exercise 24
-- Create a salary classification:
----------------------------------

-- >= 80000 → 'High'
-- >= 60000 → 'Medium'
-- otherwise → 'Low'
--------------------

-- Put the classification inside a CTE.

-- Exercise 25
-- Using the CTE from Exercise 24, count how many employees
-- belong to each salary category.

-- ============================================================
-- RECURSIVE CTEs
-- ============================================================

-- Exercise 26
-- Generate numbers from 1 to 10 using a recursive CTE.

-- Exercise 27
-- Generate numbers from 1 to 100 using a recursive CTE.

-- Exercise 28
-- Generate dates from:
-----------------------

-- 2026-01-01
-- through
-- 2026-01-10
-------------

-- using a recursive CTE.

-- Exercise 29
-- Generate the first 12 months of 2026 using a recursive CTE.

-- Exercise 30
-- Display the employee hierarchy using:
----------------------------------------

-- employee_id
-- first_name
-- manager_id
-- hierarchy_level
------------------

-- Use a recursive CTE.

-- ============================================================
-- ADVANCED
-- ============================================================

-- Exercise 31
-- Create a three-step employee analysis:
-----------------------------------------

-- Step 1:
-- Join employees with departments.
-----------------------------------

-- Step 2:
-- Calculate department salary rank.
------------------------------------

-- Step 3:
-- Calculate difference from department average.
------------------------------------------------

-- Return the final analytical result.

-- Exercise 32
-- Find the highest-paid employee in every department.
------------------------------------------------------

-- Return:
-- employee_name
-- department_name
-- salary
-- department_average
-- difference_from_average
--------------------------

-- Use multiple CTEs.

-- Exercise 33
-- Find the second-highest-paid employee in every department.
-------------------------------------------------------------

-- Use ROW_NUMBER() inside a CTE.

-- Exercise 34
-- Find the top three customers by total spending.
--------------------------------------------------

-- Return:
-- customer_name
-- total_spending
-- spending_rank

-- Exercise 35
-- Find customers whose total spending is greater than the
-- average spending of all customers.

-- ============================================================
-- INTERVIEW PRACTICE
-- ============================================================

-- Exercise 36
-- Explain:
-----------

-- CTE vs subquery

-- Exercise 37
-- Explain:
-----------

-- CTE vs temporary table

-- Exercise 38
-- Explain:
-----------

-- CTE vs view

-- Exercise 39
-- Why are CTEs useful with window functions?

-- Exercise 40
-- What are the two main parts of a recursive CTE?
--------------------------------------------------

-- Explain:
-- anchor member
-- recursive member

-- ============================================================
-- FINAL PRACTICE
-- ============================================================

-- Exercise 41
-- Build a complete employee analysis using multiple CTEs.
----------------------------------------------------------

## -- Return:

-- employee_name
-- department_name
-- salary
-- department_rank
-- department_average
-- department_total_salary
-- salary_difference
-- salary_status
----------------

-- Use multiple logical steps.

-- Exercise 42
-- Build a complete customer analysis.
--------------------------------------

## -- Return:

-- customer_name
-- total_orders
-- total_spending
-- average_order_value
-- spending_rank
----------------

-- Use multiple CTEs and at least one window function.
