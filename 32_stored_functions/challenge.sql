/*
============================================================
Module 32: Stored Functions in MySQL
File: challenge.sql
Dialect: MySQL 8.0+

Portfolio Challenge:
Build a Reusable Employee Compensation & Reporting
Function Library
============================================================

Scenario:

A company wants to centralize several recurring calculations
inside MySQL.

You will build a collection of stored functions that can be
used by reporting queries.

Requirements:

- Functions must have clear names.
- Functions must have appropriate return types.
- Use DETERMINISTIC only when appropriate.
- Use READS SQL DATA when a function reads tables.
- Handle NULL values deliberately.
- Avoid unnecessary table access.
- Keep each function focused on one responsibility.
============================================================
*/

CREATE DATABASE IF NOT EXISTS employee_function_challenge;

USE employee_function_challenge;


-- ============================================================
-- 1. Create Tables
-- ============================================================

CREATE TABLE IF NOT EXISTS departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_name VARCHAR(100) NOT NULL,
    department_id INT NOT NULL,
    salary DECIMAL(10, 2),
    hire_date DATE,
    FOREIGN KEY (department_id)
        REFERENCES departments(department_id)
);


CREATE TABLE IF NOT EXISTS sales (
    sale_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT,
    sale_amount DECIMAL(10, 2),
    sale_date DATE,
    FOREIGN KEY (employee_id)
        REFERENCES employees(employee_id)
);


-- ============================================================
-- 2. Insert Sample Data
-- ============================================================

INSERT INTO departments (department_name)
VALUES
    ('Engineering'),
    ('Finance'),
    ('Sales'),
    ('Human Resources')
ON DUPLICATE KEY UPDATE
    department_name = VALUES(department_name);


INSERT INTO employees (
    employee_name,
    department_id,
    salary,
    hire_date
)
VALUES
    ('Aarav Sharma', 1, 85000.00, '2021-04-10'),
    ('Diya Singh', 2, 72000.00, '2022-08-15'),
    ('Kabir Verma', 3, 60000.00, '2023-01-20'),
    ('Meera Patel', 3, 58000.00, '2024-05-12'),
    ('Riya Gupta', 4, 65000.00, '2020-11-05');


INSERT INTO sales (
    employee_id,
    sale_amount,
    sale_date
)
VALUES
    (3, 12000.00, '2026-01-10'),
    (3, 8500.00, '2026-02-12'),
    (4, 15000.00, '2026-02-18'),
    (4, 6000.00, '2026-03-05');


-- ============================================================
-- Challenge 1: Net Salary Calculator
-- ============================================================

/*
Create:

    calculate_net_salary

Parameters:

    gross_salary
    deduction_percentage

Return the salary remaining after the deduction.

Example:

    gross_salary = 80000
    deduction = 10%

Expected result:

    72000

The function should be deterministic and should not access
database tables.
*/


-- ============================================================
-- Challenge 2: Performance Bonus
-- ============================================================

/*
Create:

    calculate_performance_bonus

Rules:

    salary >= 80000  -> 15%
    salary >= 60000  -> 10%
    salary >= 40000  -> 7%
    otherwise        -> 5%

Return the calculated bonus amount.

Handle NULL salary by returning 0.
*/


-- ============================================================
-- Challenge 3: Employee Service Category
-- ============================================================

/*
Create:

    employee_service_category

Accept a hire date.

Return:

    'Veteran'  -> 10 or more complete years
    'Experienced' -> 5 to 9 complete years
    'Regular' -> less than 5 years

Because the result depends on the current date, do not mark
the function as deterministic.
*/


-- ============================================================
-- Challenge 4: Employee Salary Lookup
-- ============================================================

/*
Create:

    get_salary_by_employee

Accept an employee ID.

Return the employee's salary.

If the employee does not exist, return NULL.

The function reads from employees.
*/


-- ============================================================
-- Challenge 5: Employee Sales Total
-- ============================================================

/*
Create:

    get_employee_sales_total

Accept an employee ID.

Return the total sale amount for that employee.

If the employee has no sales, return 0.

The function must read from the sales table.
*/


-- ============================================================
-- Challenge 6: Sales Commission
-- ============================================================

/*
Create:

    calculate_sales_commission

Accept:

    sales_amount

Rules:

    sales >= 20000 -> 10%
    sales >= 10000 -> 7%
    sales >= 5000  -> 5%
    otherwise      -> 2%

If sales_amount is NULL, return 0.
*/


-- ============================================================
-- Challenge 7: Employee Total Compensation
-- ============================================================

/*
Create:

    calculate_total_compensation

Accept:

    salary

Calculate:

    salary + 10% bonus

Do not query the employees table.

Handle NULL by returning NULL.
*/


-- ============================================================
-- Challenge 8: Department Employee Count
-- ============================================================

/*
Create:

    get_department_employee_count

Accept a department ID.

Return the number of employees in that department.
*/


-- ============================================================
-- Challenge 9: Department Average Salary
-- ============================================================

/*
Create:

    get_department_average_salary

Accept a department ID.

Return the average salary of employees in that department.

If the department has no employees, the result should be NULL.
*/


-- ============================================================
-- Challenge 10: Department Report
-- ============================================================

/*
Using your functions, create a report containing:

    department_name
    employee_count
    average_salary

Return one row per department.
*/


-- ============================================================
-- Challenge 11: Employee Compensation Report
-- ============================================================

/*
Create a query returning:

    employee_name
    salary
    performance_bonus
    total_compensation
    service_category

Use the functions created in previous challenges.

Do not repeat the underlying calculation logic directly in
the query.
*/


-- ============================================================
-- Challenge 12: Sales Performance Report
-- ============================================================

/*
Create a report returning:

    employee_name
    total_sales
    commission

Use:

    get_employee_sales_total
    calculate_sales_commission

Sort the result by total sales from highest to lowest.
*/


-- ============================================================
-- Challenge 13: High-Value Sales Employees
-- ============================================================

/*
Return employees whose total sales are greater than 10000.

Return:

    employee_name
    total_sales

Use the get_employee_sales_total function.
*/


-- ============================================================
-- Challenge 14: Function Performance Review
-- ============================================================

/*
Compare these two approaches conceptually:

1. Calling get_employee_sales_total(employee_id) once for
   every employee.

2. Using GROUP BY and SUM(sale_amount) with a JOIN.

Write both queries.

Then inspect the execution plans using EXPLAIN.

The goal is to understand that reusable stored functions
may be convenient while set-based SQL can be more efficient
for large datasets.
*/


-- ============================================================
-- Challenge 15: NULL and Edge-Case Testing
-- ============================================================

/*
Test your functions using:

- NULL salary
- Zero salary
- Zero sales
- NULL sales
- A nonexistent employee ID
- A department with no employees
- A very large salary
- A negative percentage where your business rules need
  validation

Document the expected behavior in SQL comments.
*/


-- ============================================================
-- Challenge 16: Final Function Library
-- ============================================================

/*
Create a final collection of focused functions covering:

1. Salary calculations
2. Performance bonuses
3. Employee service
4. Employee salary lookup
5. Employee sales totals
6. Sales commissions
7. Department employee counts
8. Department average salary

For each function:

- Use a descriptive name.
- Choose the correct return type.
- Use DETERMINISTIC only when justified.
- Use NO SQL for pure calculations where appropriate.
- Use READS SQL DATA for table-reading functions.
- Handle NULL values deliberately.
- Keep the function focused on one responsibility.

Finally, write reporting queries that demonstrate the
functions working together.

This final section should represent a clean, reusable
stored-function library suitable for a SQL portfolio project.
*/
