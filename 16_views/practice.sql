-- ============================================================
-- MODULE 16: VIEWS
-- practice.sql
-- MySQL 8.0+
-- ============================================================

-- Instructions:
-- Solve each exercise yourself before checking solutions.sql.
--------------------------------------------------------------

-- The exercises use the module16_views database and the tables
-- created in examples.sql.
---------------------------

-- Do not copy answers from examples.sql. Write the queries
-- yourself as practice.

CREATE DATABASE IF NOT EXISTS module16_views;

USE module16_views;

-- ============================================================
-- EASY
-- ============================================================

---

-- Exercise 1

---

## -- Create a view named basic_employee_view.

-- The view should contain:
-- employee_id
-- first_name
-- last_name
-- email
--------

-- Use only the employees table.

---

-- Exercise 2

---

## -- Create a view named high_salary_employees.

-- Include:
-- employee_id
-- first_name
-- last_name
-- salary
---------

-- Only employees with a salary greater than or equal to
-- 60000 should appear in the view.

---

-- Exercise 3

---

## -- Query the high_salary_employees view.

## -- Return employees whose salary is less than 80000.

-- Sort the result by salary from highest to lowest.

---

-- Exercise 4

---

## -- Create a view named employee_names.

-- Return:
-- employee_id
-- full_name
------------

-- full_name should be created by combining first_name and
-- last_name using CONCAT().

---

-- Exercise 5

---

-- Display the SQL definition of employee_names using
-- SHOW CREATE VIEW.

-- ============================================================
-- MEDIUM
-- ============================================================

---

-- Exercise 6

---

## -- Create a view named employee_department_view.

-- Return:
-- employee_id
-- employee_name
-- department_name
-- salary
---------

## -- employee_name should combine first_name and last_name.

-- Join employees with departments.

---

-- Exercise 7

---

-- Query employee_department_view and return only employees
-- belonging to the Technology department.
------------------------------------------

-- Sort by salary from highest to lowest.

---

-- Exercise 8

---

## -- Create a view named customer_orders_view.

-- Return:
-- customer_id
-- customer_name
-- order_id
-- order_date
-- total_amount
---------------

-- Join customers and orders.

---

-- Exercise 9

---

## -- Create a view named customer_order_summary.

-- Return:
-- customer_id
-- customer_name
-- order_count
-- total_spent
--------------

-- Use a LEFT JOIN so that customers without orders would
-- still be represented.
------------------------

-- Group the result by customer.

---

-- Exercise 10

---

-- Query customer_order_summary and return only customers
-- whose total_spent is greater than 2500.
------------------------------------------

-- Sort from highest total_spent to lowest.

-- ============================================================
-- HARD
-- ============================================================

---

-- Exercise 11

---

## -- Create a view named department_salary_report.

-- Return:
-- department_id
-- employee_count
-- average_salary
-- highest_salary
-- lowest_salary
----------------

-- Group employees by department_id.

---

-- Exercise 12

---

## -- Query department_salary_report.

-- Return departments whose average salary is greater than
-- 60000.
---------

-- Sort by average_salary from highest to lowest.

---

-- Exercise 13

---

## -- Create a view named monthly_order_report.

-- Return:
-- order_year
-- order_month
-- order_count
-- total_sales
--------------

-- Group orders by year and month.

---

-- Exercise 14

---

## -- Use CREATE OR REPLACE VIEW to modify monthly_order_report.

-- Add:
-- average_order_value
----------------------

-- The value should be calculated using AVG(total_amount).

---

-- Exercise 15

---

-- Use INFORMATION_SCHEMA.VIEWS to find the definition of
-- monthly_order_report in the current database.

-- ============================================================
-- ADVANCED BEGINNER
-- ============================================================

---

-- Exercise 16

---

## -- Create a view named employee_directory.

-- The view should expose only:
-- employee_id
-- employee_name
-- department_name
-- email
--------

## -- Use employees and departments.

-- Do not expose salary.

---

-- Exercise 17

---

-- Query employee_directory and return employees whose
-- department is either Sales or Finance.
-----------------------------------------

-- Sort alphabetically by employee_name.

---

-- Exercise 18

---

## -- Create a view named large_orders.

-- Return:
-- order_id
-- customer_id
-- order_date
-- total_amount
---------------

-- Include only orders with total_amount greater than 2000.

---

-- Exercise 19

---

## -- Query large_orders and return the three largest orders.

-- Sort by total_amount descending and use LIMIT.

---

-- Exercise 20

---

-- Create a simple view named employee_email_view that exposes:
-- employee_id
-- first_name
-- last_name
-- email
--------

## -- Then update the email of employee_id 102 through the view.

-- After the update, query the underlying employees table to
-- verify that the change occurred.
-----------------------------------

-- Finally, restore the original email:
-- [priya@example.com](mailto:priya@example.com)

---

-- Exercise 21

---

## -- Create a view named department_employee_report.

-- Return:
-- department_name
-- employee_count
-- total_salary
-- average_salary
-----------------

-- Join employees and departments and group by department.

---

-- Exercise 22

---

## -- Query department_employee_report.

-- Return only departments where:
-- employee_count >= 2
-- AND total_salary > 100000
----------------------------

-- Sort by total_salary descending.

---

-- Exercise 23

---

## -- Create a view named customer_spending_report.

-- Return:
-- customer_id
-- customer_name
-- city
-- order_count
-- total_spent
-- average_order_value
----------------------

## -- Customers without orders should still appear.

-- Use appropriate NULL handling for customers without orders.

---

-- Exercise 24

---

## -- Use SHOW FULL TABLES to inspect the current database.

-- Identify which objects are BASE TABLE objects and which
-- objects are VIEW objects.

---

-- Exercise 25

---

## -- Create a view named top_customer_orders.

-- The view should return:
-- customer_name
-- order_id
-- order_date
-- total_amount
---------------

## -- Include orders greater than 1500.

-- Then query the view to display the results from highest
-- total_amount to lowest.
