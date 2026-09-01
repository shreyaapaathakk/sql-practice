-- ============================================================
-- MODULE 18: CASE EXPRESSIONS
-- practice.sql
-- MySQL 8.0+
-- ============================================================

CREATE DATABASE IF NOT EXISTS module18_case_expressions;

USE module18_case_expressions;

-- ============================================================
-- EASY
-- ============================================================

---

-- Exercise 1

---

-- Display:
-- first_name
-- salary
-- salary_level
---------------

-- salary_level rules:
-- 70000 or more → 'High'
-- 50000 to 69999 → 'Medium'
-- below 50000 → 'Low'

---

-- Exercise 2

---

## -- Use a simple CASE expression to convert department_id into:

-- 1 → Sales
-- 2 → Technology
-- 3 → Human Resources
-- 4 → Finance
--------------

-- Return:
-- first_name
-- department_name

---

-- Exercise 3

---

## -- Classify employees according to hire_date:

-- Before 2022-01-01 → 'Experienced'
-- Before 2024-01-01 → 'Recent'
-- Otherwise → 'New'
--------------------

-- Return:
-- first_name
-- hire_date
-- employee_type

---

-- Exercise 4

---

## -- Create an email_status column.

-- If email is NULL:
-- 'Missing Email'
------------------

-- Otherwise:
-- 'Available'

---

-- Exercise 5

---

## -- Classify orders:

-- total_amount >= 3000 → 'Large'
-- total_amount >= 1500 → 'Medium'
-- otherwise → 'Small'
----------------------

-- Return:
-- order_id
-- total_amount
-- order_size

-- ============================================================
-- MEDIUM
-- ============================================================

---

-- Exercise 6

---

## -- Count the number of employees whose salary is at least 60000.

-- Use:
-- SUM()
-- CASE

---

-- Exercise 7

---

-- Calculate the total salary paid to employees whose salary is
-- at least 60000.
------------------

-- Use conditional aggregation.

---

-- Exercise 8

---

## -- For each department, calculate:

-- department_id
-- high_salary_count
-- low_salary_count
-------------------

-- High salary:
-- salary >= 60000
------------------

-- Low salary:
-- salary < 60000
-----------------

-- Use CASE and SUM.

---

-- Exercise 9

---

## -- Create a salary_band column:

-- salary >= 80000 → 'A'
-- salary >= 60000 → 'B'
-- salary >= 50000 → 'C'
-- otherwise → 'D'
------------------

-- Return employee name and salary_band.

---

-- Exercise 10

---

## -- Join employees with departments.

## -- Create department_type:

-- Technology → 'Technical'
-- Everything else → 'Non-Technical'
------------------------------------

-- Return:
-- employee_name
-- department_name
-- department_type

---

-- Exercise 11

---

## -- Calculate the average salary of Technology employees using:

-- AVG()
-- CASE
-------

-- Do not use WHERE.

---

-- Exercise 12

---

## -- Group employees by salary level.

-- Return:
-- salary_level
-- employee_count
-----------------

-- Use CASE and GROUP BY.

-- ============================================================
-- HARD
-- ============================================================

---

-- Exercise 13

---

## -- For each department calculate:

-- department_id
-- high_salary_count
-- medium_salary_count
-- low_salary_count
-------------------

## -- Rules:

-- High: salary >= 70000
-- Medium: 50000–69999
-- Low: below 50000
-------------------

-- Use conditional aggregation.

---

-- Exercise 14

---

## -- Create a customer_totals CTE.

## -- Calculate each customer's total spending.

## -- Then classify customers:

-- >= 4000 → 'Premium'
-- >= 2500 → 'Standard'
-- otherwise → 'Basic'
----------------------

-- Display:
-- customer_name
-- total_spent
-- customer_segment

---

-- Exercise 15

---

## -- Create a CTE called employee_categories.

-- The CTE should calculate:
-- employee_id
-- employee_name
-- salary_level
---------------

-- Then use the outer query to count employees in each
-- salary level.

---

-- Exercise 16

---

## -- For each department, calculate:

-- total_employees
-- high_salary_employees
-- high_salary_percentage
-------------------------

## -- High salary means salary >= 60000.

-- Hint:
-- You can divide the conditional count by COUNT(*).
----------------------------------------------------

-- Consider multiplying by 100.

---

-- Exercise 17

---

## -- Create an order_category:

-- >= 3000 → 'Large'
-- 1500–2999 → 'Medium'
-- < 1500 → 'Small'
-------------------

-- Then calculate the number of orders in each category.

---

-- Exercise 18

---

## -- Calculate sales by order category.

-- Return:
-- order_category
-- order_count
-- total_sales
--------------

-- Use CASE with COUNT and SUM.

-- ============================================================
-- ADVANCED BEGINNER
-- ============================================================

---

-- Exercise 19

---

## -- Create a CTE that calculates customer total spending.

## -- Create another CTE that classifies customers based on spending.

-- Then return:
-- customer_segment
-- customer_count
-- total_segment_sales
----------------------

-- Use GROUP BY in the final query.

---

-- Exercise 20

---

## -- Find the average order value for:

-- Large orders
-- Medium orders
-- Small orders
---------------

-- Use:
-- AVG()
-- CASE

---

-- Exercise 21

---

## -- Create an employee performance classification:

-- Salary >= 70000 AND department_id = 2
-- → 'Senior Technology'
------------------------

-- Salary >= 70000
-- → 'Senior Employee'
----------------------

-- Salary >= 50000
-- → 'Mid-Level Employee'
-------------------------

-- Otherwise
-- → 'Junior Employee'
----------------------

-- Return:
-- employee_name
-- salary
-- employee_category

---

-- Exercise 22

---

## -- Use CASE in ORDER BY.

## -- Sort employees in this custom order:

-- Technology first
-- Sales second
-- Finance third
-- Human Resources last
-----------------------

-- Within each department, sort employees by salary descending.

---

-- Exercise 23

---

## -- Use a CTE to calculate each employee's salary level.

## -- Then use a second CASE expression in the outer query:

-- High salary + Technology
-- → 'Priority'
---------------

-- High salary + other department
-- → 'High Value'
-----------------

-- Everything else
-- → 'Standard'
---------------

-- Return:
-- employee_name
-- salary_level
-- final_category

---

-- Exercise 24

---

## -- Create a report showing each department's:

-- department_name
-- total_employees
-- average_salary
-- high_salary_count
-- salary_status
----------------

## -- salary_status rules:

-- average salary >= 70000 → 'High Paying'
-- average salary >= 55000 → 'Moderate'
-- otherwise → 'Low Paying'
---------------------------

-- Use JOIN, GROUP BY, CASE, COUNT, and AVG.

-- ============================================================
-- CHALLENGE PREPARATION
-- ============================================================

---

-- Exercise 25

---

## -- Build a customer segmentation report.

-- Step 1:
-- Calculate total spending per customer.
-----------------------------------------

-- Step 2:
-- Classify customers:
----------------------

-- >= 4000 → Premium
-- >= 2500 → Standard
-- >= 1500 → Regular
-- otherwise → Basic
--------------------

-- Step 3:
-- Display:
-- customer_name
-- city
-- total_spent
-- customer_segment
-------------------

-- Step 4:
-- Sort Premium customers first, then Standard, Regular,
-- and Basic.
-------------

-- Use CASE in ORDER BY.

---

-- Exercise 26

---

## -- Build an employee salary report.

-- Display:
-- employee_name
-- department_name
-- salary
-- salary_band
-- salary_priority
------------------

-- salary_band:
-- >= 80000 → A
-- >= 70000 → B
-- >= 60000 → C
-- >= 50000 → D
-- otherwise → E
----------------

-- salary_priority:
-- Technology + A/B → 'Critical'
-- Technology + C → 'High'
-- Otherwise → 'Normal'
-----------------------

-- Use JOIN and multiple CASE expressions.
