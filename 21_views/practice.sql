-- ============================================================
-- MODULE 21: SQL VIEWS
-- practice.sql
-- ============================================================

USE module21_views;

-- ============================================================
-- BASIC VIEWS
-- ============================================================

-- Exercise 1
-- Create a view named high_salary_employees.
---------------------------------------------

-- Include:
-- employee_id
-- first_name
-- salary
---------

-- Only include employees earning more than 60000.

-- Exercise 2
-- Query the high_salary_employees view.

-- Exercise 3
-- Query the view and return only employees earning more
-- than 70000.

-- Exercise 4
-- Sort the high_salary_employees view by salary descending.

-- ============================================================
-- VIEWS WITH JOINS
-- ============================================================

-- Exercise 5
-- Create a view named employee_details.
----------------------------------------

-- Include:
-- employee_id
-- employee_name
-- salary
-- department_name
------------------

-- Join employees and departments.

-- Exercise 6
-- Query employee_details.

-- Exercise 7
-- From employee_details, find employees earning more
-- than 60000.

-- Exercise 8
-- From employee_details, return the highest-paid employees
-- first.

-- ============================================================
-- AGGREGATION VIEWS
-- ============================================================

-- Exercise 9
-- Create a view named department_summary.
------------------------------------------

-- Return:
-- department_id
-- employee_count
-- total_salary
-- average_salary

-- Exercise 10
-- Query department_summary.

-- Exercise 11
-- Find departments whose total salary exceeds 100000.

-- Exercise 12
-- Find departments with more than one employee.

-- ============================================================
-- CASE + VIEWS
-- ============================================================

-- Exercise 13
-- Create a view named employee_salary_categories.
--------------------------------------------------

## -- Classify employees:

-- >= 80000 → High
-- >= 60000 → Medium
-- otherwise → Low

-- Exercise 14
-- Query the view and count employees in each salary category.

-- Exercise 15
-- Find all employees classified as High.

-- ============================================================
-- WINDOW FUNCTIONS + VIEWS
-- ============================================================

-- Exercise 16
-- Create a view named employee_rankings.
-----------------------------------------

## -- Rank employees by salary within each department.

-- Use RANK() and PARTITION BY.

-- Exercise 17
-- Query the employee_rankings view.

-- Exercise 18
-- Find the top two employees in every department.

-- Exercise 19
-- Find the highest-paid employee in every department.

-- ============================================================
-- CUSTOMER VIEWS
-- ============================================================

-- Exercise 20
-- Create a view named customer_order_details.
----------------------------------------------

-- Include:
-- customer_name
-- city
-- order_id
-- order_date
-- total_amount

-- Exercise 21
-- Query customer_order_details.

-- Exercise 22
-- Find orders greater than 2000 using the view.

-- Exercise 23
-- Create a view named customer_spending.
-----------------------------------------

-- Include:
-- customer_name
-- total_orders
-- total_spending
-- average_order_value

-- Exercise 24
-- Find the top three customers by total spending.

-- Exercise 25
-- Find customers whose total spending exceeds 3000.

-- ============================================================
-- CREATE OR REPLACE
-- ============================================================

-- Exercise 26
-- Create a view named salary_report containing:
-- employee_id
-- first_name
-- salary

-- Exercise 27
-- Replace salary_report so that it also contains:
-- last_name
------------

-- Use CREATE OR REPLACE VIEW.

-- ============================================================
-- VIEW MANAGEMENT
-- ============================================================

-- Exercise 28
-- Display the definition of employee_details.

-- Exercise 29
-- Display all tables and views in the current database.

-- Exercise 30
-- Drop salary_report safely using:
-- DROP VIEW IF EXISTS

-- ============================================================
-- VIEW + ADDITIONAL QUERYING
-- ============================================================

-- Exercise 31
-- Using employee_details, calculate the average salary
-- for each department.

-- Exercise 32
-- Using employee_details, find departments with an
-- average salary greater than 60000.

-- Exercise 33
-- Using customer_spending, sort customers by spending.

-- Exercise 34
-- Using customer_spending, find the customer with the
-- largest total spending.

-- Exercise 35
-- Using customer_spending, calculate the average spending
-- across customers.

-- ============================================================
-- CONCEPTUAL PRACTICE
-- ============================================================

-- Exercise 36
-- Explain the difference between:
----------------------------------

-- TABLE
-- VIEW
-- CTE

-- Exercise 37
-- Explain why a view is useful for repeated queries.

-- Exercise 38
-- Explain whether a view automatically improves performance.

-- Exercise 39
-- What does CREATE OR REPLACE VIEW do?

-- Exercise 40
-- What does DROP VIEW IF EXISTS do?

-- Exercise 41
-- What is an updatable view?

-- Exercise 42
-- Why are views containing GROUP BY generally not directly
-- updatable?

-- ============================================================
-- ADVANCED VIEW PRACTICE
-- ============================================================

-- Exercise 43
-- Create a view containing:
----------------------------

-- employee_name
-- department_name
-- salary
-- department_average
---------------------

-- Use a window function.

-- Exercise 44
-- Using the view from Exercise 43, return employees whose
-- salary is above their department average.

-- Exercise 45
-- Create a customer performance view containing:
-------------------------------------------------

-- customer_name
-- city
-- total_orders
-- total_spending
-- average_order_value
-- largest_order

-- Exercise 46
-- Using customer performance view, return customers whose
-- total spending is above 3000.

-- ============================================================
-- FINAL PRACTICE
-- ============================================================

-- Exercise 47
-- Create an employee reporting view that combines:
---------------------------------------------------

-- employee information
-- department information
-- salary category
-- department salary rank
-------------------------

-- Then query the view for the top two employees in each
-- department.

-- Exercise 48
-- Create a customer reporting view containing:
-----------------------------------------------

-- customer_name
-- city
-- total_orders
-- total_spending
-- average_order_value
-- largest_order
----------------

-- Then return the top three customers by spending.
