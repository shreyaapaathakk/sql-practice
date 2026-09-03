-- ============================================================
-- MODULE 22: STORED PROCEDURES
-- challenge.sql
-- ============================================================

USE module22_procedures;

-- ============================================================
-- CHALLENGE 1 — EMPLOYEE LOOKUP
-- ============================================================

## -- Create a procedure named employee_lookup.

-- Input:
-- p_employee_id
----------------

-- Return:
-- employee_id
-- employee_name
-- department_name
-- salary
-- hire_date
------------

-- Use a JOIN.

-- ============================================================
-- CHALLENGE 2 — SALARY RANGE
-- ============================================================

## -- Create a procedure that accepts:

-- p_min_salary
-- p_max_salary
---------------

## -- Return employees within the salary range.

-- Sort by salary descending.

-- ============================================================
-- CHALLENGE 3 — DEPARTMENT REPORT
-- ============================================================

## -- Create a procedure named department_report.

-- Input:
-- p_department_id
------------------

-- Return:
-- department_name
-- employee_count
-- total_salary
-- average_salary
-- minimum_salary
-- maximum_salary
-----------------

-- Include the department even if it has no employees.

-- ============================================================
-- CHALLENGE 4 — SALARY CATEGORY
-- ============================================================

## -- Create a procedure named salary_category_report.

-- Input:
-- p_employee_id
----------------

-- Return:
-- employee_name
-- salary
-- salary_category
------------------

## -- Categories:

-- >= 80000 → High
-- >= 60000 → Medium
-- otherwise → Low
------------------

-- Use IF or CASE.

-- ============================================================
-- CHALLENGE 5 — OUT PARAMETER
-- ============================================================

## -- Create a procedure named department_employee_count.

-- Inputs:
-- p_department_id
------------------

-- Output:
-- p_employee_count
-------------------

-- Store the employee count in the OUT parameter.

-- ============================================================
-- CHALLENGE 6 — OUT PARAMETERS
-- ============================================================

## -- Create a procedure named department_metrics.

-- Input:
-- p_department_id
------------------

-- Outputs:
-- p_employee_count
-- p_total_salary
-- p_average_salary
-------------------

-- Use three OUT parameters.

-- ============================================================
-- CHALLENGE 7 — INOUT
-- ============================================================

## -- Create a procedure named calculate_bonus.

-- INOUT:
-- p_salary
-----------

-- If salary >= 80000:
-- increase by 20%
------------------

-- Otherwise:
-- increase by 10%.

-- ============================================================
-- CHALLENGE 8 — TOP EMPLOYEES
-- ============================================================

## -- Create a procedure named top_employees.

-- Inputs:
-- p_department_id
-- p_limit
----------

-- Return the top p_limit employees by salary.

-- ============================================================
-- CHALLENGE 9 — CUSTOMER SPENDING
-- ============================================================

## -- Create a procedure named customer_spending_report.

-- Input:
-- p_customer_id
----------------

-- Return:
-- customer_name
-- city
-- total_orders
-- total_spending
-- average_order_value
-- largest_order

-- ============================================================
-- CHALLENGE 10 — CUSTOMER STATUS
-- ============================================================

## -- Create a procedure named customer_status.

-- Input:
-- p_customer_id
----------------

## -- Determine:

-- total_spending >= 4000 → VIP
-- total_spending >= 2000 → Regular
-- otherwise → Low Value
------------------------

-- Return:
-- customer_name
-- total_spending
-- customer_status

-- ============================================================
-- CHALLENGE 11 — MULTIPLE RESULT SETS
-- ============================================================

## -- Create a procedure named company_report.

## -- It should return three result sets:

-- Result 1:
-- employee list
----------------

-- Result 2:
-- department statistics
------------------------

-- Result 3:
-- customer spending

-- ============================================================
-- CHALLENGE 12 — LOCAL VARIABLE + IF
-- ============================================================

## -- Create a procedure named employee_salary_check.

-- Input:
-- p_employee_id
----------------

## -- Store the employee's salary in a local variable.

## -- Then:

-- >= 80000 → 'High Salary'
-- >= 60000 → 'Medium Salary'
-- otherwise → 'Low Salary'
---------------------------

-- Return employee name and category.

-- ============================================================
-- CHALLENGE 13 — CUSTOMER ORDER COUNT
-- ============================================================

## -- Create a procedure that accepts:

## -- p_customer_id

## -- Store the number of orders in a local variable.

-- Return:
-- customer_name
-- order_count

-- ============================================================
-- CHALLENGE 14 — CONDITIONAL SALARY UPDATE
-- ============================================================

## -- Create a procedure named smart_salary_increase.

-- Inputs:
-- p_employee_id
-- p_amount
-----------

-- If the employee currently earns less than 60000:
-- apply the full amount.
-------------------------

-- Otherwise:
-- apply only 50% of the supplied amount.
-----------------------------------------

-- Return the updated employee record.

-- ============================================================
-- CHALLENGE 15 — PROCEDURE USING A VIEW
-- ============================================================

## -- Use a view from Module 21 if available.

-- Create a procedure that queries the employee reporting
-- view for a supplied department.
----------------------------------

-- Return employees ordered by department rank.

-- ============================================================
-- CHALLENGE 16 — PROCEDURE USING MULTIPLE OPERATIONS
-- ============================================================

## -- Create a procedure named employee_promotion.

-- Inputs:
-- p_employee_id
-- p_amount
-----------

## -- Steps:

-- 1. Find the employee.
-- 2. Increase salary.
-- 3. Return updated employee information.
------------------------------------------

-- Use multiple SQL statements.

-- ============================================================
-- CHALLENGE 17 — PROCEDURE WITH VALIDATION
-- ============================================================

## -- Create a procedure named safe_salary_increase.

-- Inputs:
-- p_employee_id
-- p_amount
-----------

## -- Rules:

-- If p_amount <= 0:
-- return 'Invalid amount'.
---------------------------

-- Otherwise:
-- update salary and return the employee.

-- ============================================================
-- CHALLENGE 18 — ADVANCED EMPLOYEE REPORT
-- ============================================================

## -- Create a procedure named advanced_employee_report.

-- Input:
-- p_department_id
------------------

-- Return:
-- employee_id
-- employee_name
-- department_name
-- salary
-- salary_category
-- department_average
-- salary_difference
-- department_rank
------------------

## -- Use:

-- JOIN
-- CASE
-- window functions
-- calculated columns

-- ============================================================
-- CHALLENGE 19 — ADVANCED CUSTOMER REPORT
-- ============================================================

## -- Create a procedure named advanced_customer_report.

-- Input:
-- p_customer_id
----------------

-- Return:
-- customer_name
-- city
-- total_orders
-- total_spending
-- average_order_value
-- largest_order
-- customer_status
------------------

## -- Use:

-- LEFT JOIN
-- aggregation
-- CASE

-- ============================================================
-- CHALLENGE 20 — MODULE 22 PORTFOLIO PROJECT
-- ============================================================

-- PROJECT:
-- BUILD A STORED PROCEDURE API
-------------------------------

-- Design a reusable collection of stored procedures that
-- acts as a small database API.
--------------------------------

--
-- EMPLOYEE PROCEDURES
----------------------

-- 1. get employee by ID
-- 2. get employees by department
-- 3. get top employees
-- 4. increase salary
-- 5. employee analytics
------------------------

--
-- DEPARTMENT PROCEDURES
------------------------

-- 6. department statistics
-- 7. department employee count
-- 8. highest-paid employee
---------------------------

--
-- CUSTOMER PROCEDURES
----------------------

-- 9. add customer
-- 10. customer orders
-- 11. customer spending
-- 12. customer status
----------------------

--
-- REQUIREMENTS
---------------

## -- 1. Use IN parameters.

## -- 2. Use at least two OUT parameters.

## -- 3. Use at least one INOUT parameter.

## -- 4. Use local variables.

## -- 5. Use IF/ELSE.

## -- 6. Use JOINs.

## -- 7. Use aggregation.

## -- 8. Use CASE.

## -- 9. Use at least one window function.

## -- 10. Include input validation.

## -- 11. Use meaningful procedure names.

## -- 12. Add comments explaining each procedure.

## -- 13. Test every procedure with CALL.

## -- 14. Inspect the procedures using SHOW CREATE PROCEDURE.

-- 15. Make the code clean enough to include in your
--     GitHub sql-practice repository.
