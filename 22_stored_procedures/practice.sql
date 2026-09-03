-- ============================================================
-- MODULE 22: STORED PROCEDURES
-- practice.sql
-- ============================================================

USE module22_procedures;

-- ============================================================
-- BASIC PROCEDURES
-- ============================================================

-- Exercise 1
-- Create a procedure named get_all_employees that returns
-- every employee.

-- Exercise 2
-- Call get_all_employees.

-- Exercise 3
-- Create a procedure named get_employee_by_id.
-----------------------------------------------

-- Accept:
-- p_employee_id
----------------

-- Return the employee with that ID.

-- Exercise 4
-- Create a procedure named get_high_salary_employees.
------------------------------------------------------

-- Accept:
-- p_min_salary
---------------

-- Return employees whose salary is greater than or equal
-- to the supplied value.

-- ============================================================
-- MULTIPLE PARAMETERS
-- ============================================================

-- Exercise 5
-- Create a procedure that accepts:
-----------------------------------

-- p_min_salary
-- p_max_salary
---------------

-- Return employees whose salary falls within the range.

-- Exercise 6
-- Create a procedure that accepts:
-----------------------------------

-- p_department_id
-- p_min_salary
---------------

-- Return employees from that department whose salary is
-- greater than or equal to p_min_salary.

-- ============================================================
-- INSERT / UPDATE / DELETE
-- ============================================================

-- Exercise 7
-- Create a procedure named add_customer.
-----------------------------------------

-- Accept:
-- customer_id
-- customer_name
-- city
-------

-- Insert the customer.

-- Exercise 8
-- Create a procedure named update_customer_city.
-------------------------------------------------

-- Accept:
-- p_customer_id
-- p_city
---------

-- Update the customer's city.

-- Exercise 9
-- Create a procedure named increase_salary.
--------------------------------------------

-- Accept:
-- p_employee_id
-- p_amount
-----------

-- Increase the employee's salary.

-- Exercise 10
-- Create a procedure named delete_customer.
--------------------------------------------

-- Accept:
-- p_customer_id
----------------

-- Delete that customer.

-- ============================================================
-- VARIABLES
-- ============================================================

-- Exercise 11
-- Create a procedure that calculates the total number
-- of employees.
----------------

## -- Store the result in a local variable.

-- Return the variable.

-- Exercise 12
-- Create a procedure that calculates the average salary.
---------------------------------------------------------

## -- Store the result in a local variable named avg_salary.

-- Return the result.

-- Exercise 13
-- Create a procedure that accepts p_department_id.
---------------------------------------------------

## -- Calculate the average salary for that department.

-- Store it in a local variable.

-- ============================================================
-- IF / ELSE
-- ============================================================

-- Exercise 14
-- Create a procedure named salary_category.
--------------------------------------------

-- Accept:
-- p_salary
-----------

## -- Return:

-- >= 80000 → High
-- >= 60000 → Medium
-- otherwise → Low

-- Exercise 15
-- Create a procedure that accepts p_amount.
--------------------------------------------

-- If amount >= 5000:
-- return 'Large Amount'
------------------------

-- Otherwise:
-- return 'Small Amount'

-- ============================================================
-- AGGREGATION
-- ============================================================

-- Exercise 16
-- Create a procedure named department_statistics.
--------------------------------------------------

-- Accept:
-- p_department_id
------------------

-- Return:
-- employee_count
-- total_salary
-- average_salary
-- minimum_salary
-- maximum_salary

-- Exercise 17
-- Create a procedure that returns the number of employees
-- in a supplied department.

-- ============================================================
-- JOIN
-- ============================================================

-- Exercise 18
-- Create a procedure named department_employees.
-------------------------------------------------

-- Accept:
-- p_department_id
------------------

-- Return:
-- employee_id
-- employee_name
-- salary
-- department_name

-- Exercise 19
-- Modify the procedure so employees are sorted by salary
-- descending.

-- ============================================================
-- OUT PARAMETERS
-- ============================================================

-- Exercise 20
-- Create a procedure with an OUT parameter that returns
-- the total number of employees.

-- Exercise 21
-- Create a procedure with an OUT parameter that returns
-- the average employee salary.

-- Exercise 22
-- Create a procedure with an OUT parameter that returns
-- the total salary of a supplied department.

-- ============================================================
-- INOUT PARAMETERS
-- ============================================================

-- Exercise 23
-- Create a procedure that accepts an INOUT amount.
---------------------------------------------------

-- Increase the amount by 1000.

-- Exercise 24
-- Create a procedure that accepts an INOUT amount.
---------------------------------------------------

-- If amount is greater than 10000, increase it by 20%.
-- Otherwise increase it by 10%.

-- ============================================================
-- LIMIT
-- ============================================================

-- Exercise 25
-- Create a procedure that accepts p_limit.
-------------------------------------------

-- Return the top p_limit highest-paid employees.

-- Exercise 26
-- Create a procedure that accepts p_limit and
-- p_department_id.
-------------------

-- Return the top p_limit highest-paid employees from
-- that department.

-- ============================================================
-- MULTIPLE STATEMENTS
-- ============================================================

-- Exercise 27
-- Create a procedure named employee_report that returns:
---------------------------------------------------------

-- Result 1:
-- all employees ordered by salary descending
---------------------------------------------

-- Result 2:
-- total employee count
-----------------------

-- Result 3:
-- average salary

-- ============================================================
-- PROCEDURE MANAGEMENT
-- ============================================================

-- Exercise 28
-- Display the definition of one of your procedures.

-- Exercise 29
-- Display all procedures belonging to the current database.

-- Exercise 30
-- Safely drop one practice procedure.

-- ============================================================
-- ADVANCED PRACTICE
-- ============================================================

-- Exercise 31
-- Create a procedure named customer_orders.
--------------------------------------------

-- Accept:
-- p_customer_id
----------------

-- Return all orders for that customer.

-- Exercise 32
-- Create a procedure named customer_total_spending.
----------------------------------------------------

-- Accept:
-- p_customer_id
----------------

-- Return the customer's:
-- total_orders
-- total_spending
-- average_order_value

-- Exercise 33
-- Create a procedure named employee_analysis.
----------------------------------------------

-- Accept:
-- p_employee_id
----------------

-- Return:
-- employee name
-- department name
-- salary
-- salary category

-- Exercise 34
-- Create a procedure that accepts:
-----------------------------------

## -- p_department_id

-- Return the highest-paid employee in that department.

-- Exercise 35
-- Create a procedure that accepts:
-----------------------------------

## -- p_min_salary

-- Return:
-- employee_count
-- average_salary
-- highest_salary
-- lowest_salary
----------------

-- for employees earning at least p_min_salary.

-- ============================================================
-- FINAL PRACTICE
-- ============================================================

-- Exercise 36
-- Explain the difference between:
----------------------------------

-- VIEW
-- PROCEDURE
-- CTE

-- Exercise 37
-- Explain the difference between:
----------------------------------

-- IN
-- OUT
-- INOUT

-- Exercise 38
-- Explain why DELIMITER is commonly used while creating
-- MySQL stored procedures.

-- Exercise 39
-- Explain the difference between a stored procedure and
-- a stored function.

-- Exercise 40
-- Explain why stored procedures should not automatically
-- be used for every SQL query.

-- ============================================================
-- MODULE 22 MINI PROJECT
-- ============================================================

## -- Build a small stored-procedure API for the database.

## -- Create procedures for:

-- 1. Get employee by ID.
-- 2. Get employees by department.
-- 3. Increase employee salary.
-- 4. Get department statistics.
-- 5. Add customer.
-- 6. Get customer orders.
-- 7. Get customer spending.
-- 8. Get top-paid employees.
-----------------------------

## -- Requirements:

-- Use IN parameters.
-- Use at least one OUT parameter.
-- Use at least one local variable.
-- Use IF/ELSE at least once.
-- Use aggregation.
-- Use JOINs.
-- Use meaningful procedure names.
-- Add comments explaining each procedure.
