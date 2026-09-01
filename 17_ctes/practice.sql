-- ============================================================
-- MODULE 17: COMMON TABLE EXPRESSIONS (CTEs)
-- practice.sql
-- MySQL 8.0+
-- ============================================================

CREATE DATABASE IF NOT EXISTS module17_ctes;

USE module17_ctes;

-- ============================================================
-- EASY
-- ============================================================

---

-- Exercise 1

---

## -- Create a CTE named high_salary_employees.

-- Return:
-- employee_id
-- first_name
-- last_name
-- salary
---------

## -- Include employees whose salary is at least 65000.

-- Then query the CTE.

---

-- Exercise 2

---

## -- Create a CTE named employee_names.

-- Return:
-- employee_id
-- full_name
------------

## -- full_name should combine first_name and last_name.

-- Query the CTE and sort by full_name alphabetically.

---

-- Exercise 3

---

## -- Create a CTE named large_orders.

## -- Include orders where total_amount is greater than 2000.

-- Return:
-- order_id
-- customer_id
-- total_amount
---------------

-- Sort by total_amount descending.

---

-- Exercise 4

---

## -- Create a CTE named selected_employees.

## -- Include employees whose salary is between 50000 and 75000.

-- Query the CTE and return the employee name and salary.

---

-- Exercise 5

---

## -- Create a CTE that calculates annual salary:

-- employee_id
-- employee_name
-- annual_salary
----------------

-- Sort the final result by annual_salary descending.

-- ============================================================
-- MEDIUM
-- ============================================================

---

-- Exercise 6

---

## -- Create a CTE named department_counts.

## -- Calculate the number of employees in each department.

-- Return:
-- department_id
-- employee_count
-----------------

-- Then join the CTE with departments to display:
-- department_name
-- employee_count

---

-- Exercise 7

---

## -- Create a CTE named department_salary.

-- Calculate:
-- department_id
-- average_salary
-- highest_salary
-----------------

-- Then return only departments whose average salary is
-- greater than 60000.

---

-- Exercise 8

---

## -- Create a CTE named customer_totals.

-- Calculate each customer's:
-- customer_id
-- total_spent
--------------

-- Then join it with customers and display:
-- customer_name
-- total_spent
--------------

-- Sort from highest spending to lowest.

---

-- Exercise 9

---

## -- Create two CTEs:

-- 1. customer_totals
-- 2. high_value_customers
--------------------------

## -- customer_totals should calculate total spending.

-- high_value_customers should use customer_totals and keep
-- customers whose total spending exceeds 3000.
-----------------------------------------------

-- Join the result with customers.

---

-- Exercise 10

---

## -- Create a CTE containing Technology department employees.

-- Then use the outer query to return only Technology employees
-- whose salary is greater than 70000.

-- ============================================================
-- HARD
-- ============================================================

---

-- Exercise 11

---

## -- Create a CTE named department_average.

## -- Calculate the average salary for every department.

## -- Create another CTE named company_average.

## -- Calculate the average salary for the entire company.

-- Return departments whose average salary is greater than
-- the company-wide average.

---

-- Exercise 12

---

## -- Create a CTE named monthly_orders.

-- Return:
-- order_year
-- order_month
-- order_count
-- total_sales
--------------

## -- Group orders by year and month.

-- Then display the result in chronological order.

---

-- Exercise 13

---

## -- Create a CTE named customer_order_counts.

## -- Calculate the number of orders for each customer.

-- Use a LEFT JOIN from customers so that customers without
-- orders are not lost.
-----------------------

-- Return:
-- customer_name
-- order_count

---

-- Exercise 14

---

## -- Create a CTE named expensive_orders.

-- Find orders whose total_amount is greater than the average
-- order amount across all orders.
----------------------------------

-- Return:
-- order_id
-- order_date
-- total_amount
---------------

-- Hint:
-- A second CTE can calculate the overall average.

---

-- Exercise 15

---

## -- Create two CTEs:

-- 1. department_totals
-- 2. high_salary_departments
-----------------------------

-- department_totals should calculate total salary for each
-- department.
--------------

-- high_salary_departments should contain departments whose
-- total salary is greater than 120000.
---------------------------------------

-- Join with departments to display department_name and
-- total_salary.

-- ============================================================
-- ADVANCED BEGINNER
-- ============================================================

---

-- Exercise 16

---

## -- Create a CTE named top_customers.

## -- Calculate each customer's total spending.

-- Keep only the top 3 customers using ORDER BY and LIMIT
-- inside the CTE.
------------------

-- Join with customers to display:
-- customer_name
-- total_spent

---

-- Exercise 17

---

## -- Create three CTEs:

-- 1. employee_counts
-- 2. department_details
-- 3. department_report
-----------------------

## -- employee_counts should count employees by department.

## -- department_details should contain department names.

## -- department_report should combine the first two CTEs.

-- Return:
-- department_name
-- employee_count
-----------------

-- Sort by employee_count descending.

---

-- Exercise 18

---

## -- Create a CTE named employee_salary_data.

-- Return:
-- employee_id
-- employee_name
-- monthly_salary
-- annual_salary
----------------

-- Then use the outer query to display employees whose annual
-- salary is greater than 800000.

---

-- Exercise 19

---

## -- Create a CTE named customer_orders.

## -- Join customers and orders.

-- Then create another CTE named large_customer_orders that
-- keeps orders greater than 1500.
----------------------------------

-- Finally, return:
-- customer_name
-- order_id
-- total_amount
---------------

-- Sort by total_amount descending.

---

-- Exercise 20

---

## -- Create a CTE using an explicit column list.

## -- Name the CTE employee_report.

-- Columns:
-- employee_id
-- employee_name
-- annual_salary
----------------

-- Return employees ordered by annual_salary descending.

---

-- Exercise 21

---

## -- Write a recursive CTE that generates the numbers 1 through 10.

-- The final query should display one column named number.

---

-- Exercise 22

---

## -- Write a recursive CTE that generates these dates:

-- 2026-04-01
-- 2026-04-02
-- 2026-04-03
-- 2026-04-04
-- 2026-04-05
-------------

-- Return one column named report_date.

---

-- Exercise 23

---

## -- Rewrite the following derived-table query using a CTE:

-- SELECT *
-- FROM (
--     SELECT
--         department_id,
--         AVG(salary) AS average_salary
--     FROM employees
--     GROUP BY department_id
-- ) AS department_summary
-- WHERE average_salary > 60000;
--------------------------------

-- The result should be equivalent.

---

-- Exercise 24

---

## -- Create a multi-step analysis using CTEs.

-- Step 1:
-- Calculate each customer's total spending.
--------------------------------------------

-- Step 2:
-- Calculate the average customer spending.
-------------------------------------------

-- Step 3:
-- Return customers whose total spending is above the average
-- customer spending.
---------------------

-- Display:
-- customer_name
-- total_spent
--------------

-- Sort from highest spending to lowest.
