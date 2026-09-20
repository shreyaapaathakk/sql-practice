/*
============================================================
Module 32: Stored Functions in MySQL
File: practice.sql
Dialect: MySQL 8.0+
============================================================
*/

CREATE DATABASE IF NOT EXISTS functions_practice;

USE functions_practice;


-- ============================================================
-- Setup Tables
-- ============================================================

CREATE TABLE IF NOT EXISTS departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_name VARCHAR(100) NOT NULL,
    email VARCHAR(150),
    department_id INT,
    salary DECIMAL(10, 2),
    hire_date DATE,
    FOREIGN KEY (department_id)
        REFERENCES departments(department_id)
);

INSERT INTO departments (department_name)
VALUES
    ('Engineering'),
    ('Finance'),
    ('Human Resources'),
    ('Sales')
ON DUPLICATE KEY UPDATE
    department_name = VALUES(department_name);

INSERT INTO employees (
    employee_name,
    email,
    department_id,
    salary,
    hire_date
)
VALUES
    ('Aarav Sharma', 'aarav@example.com', 1, 80000.00, '2022-01-15'),
    ('Diya Singh', 'diya@example.com', 2, 68000.00, '2023-03-10'),
    ('Kabir Verma', 'kabir@example.com', 3, 62000.00, '2021-07-20'),
    ('Meera Patel', 'meera@example.com', 4, 55000.00, '2024-02-05');


-- ============================================================
-- Exercise 1: Basic Addition Function
-- ============================================================

/*
Create a function named:

    add_values

It should accept two INT parameters and return their sum.

The function should be deterministic and should not use SQL
data.
*/


-- ============================================================
-- Exercise 2: Percentage Calculation
-- ============================================================

/*
Create:

    calculate_percentage

Parameters:

    amount DECIMAL(10,2)
    percentage DECIMAL(5,2)

Return the calculated percentage amount.

Example:

    calculate_percentage(1000, 15)

should return:

    150
*/


-- ============================================================
-- Exercise 3: Full Name Function
-- ============================================================

/*
Create:

    create_full_name

Accept:

    first_name VARCHAR(50)
    last_name VARCHAR(50)

Return the two values joined with a single space.
*/


-- ============================================================
-- Exercise 4: Discounted Price
-- ============================================================

/*
Create:

    discounted_price

Parameters:

    original_price
    discount_percentage

Return the price after applying the discount.

Example:

    discounted_price(1000, 20)

should return:

    800
*/


-- ============================================================
-- Exercise 5: Salary Category
-- ============================================================

/*
Create:

    classify_salary

Rules:

    salary >= 75000  -> 'High'
    salary >= 60000  -> 'Medium'
    otherwise        -> 'Low'

Return VARCHAR(20).
*/


-- ============================================================
-- Exercise 6: Safe Salary Bonus
-- ============================================================

/*
Create:

    calculate_safe_bonus

The function should:

    - Return 10% of salary.
    - Return 0 if salary is NULL.

Use IF logic.
*/


-- ============================================================
-- Exercise 7: Employee Label
-- ============================================================

/*
Create:

    employee_label

Parameters:

    employee_id
    employee_name

Return a value in this format:

    Employee #1 - Aarav Sharma
*/


-- ============================================================
-- Exercise 8: Add Days to a Date
-- ============================================================

/*
Create:

    future_date

Parameters:

    input_date DATE
    days_to_add INT

Return the date after adding the specified number of days.
*/


-- ============================================================
-- Exercise 9: Employee Years of Service
-- ============================================================

/*
Create:

    years_of_service

Accept a hire date and return the number of complete years
between the hire date and the current date.

Because the result depends on the current date, classify the
function appropriately rather than declaring it deterministic.
*/


-- ============================================================
-- Exercise 10: Retrieve Employee Salary
-- ============================================================

/*
Create:

    find_employee_salary

Accept an employee ID.

Look up the employee's salary from employees and return it.

The function reads SQL data.
*/


-- ============================================================
-- Exercise 11: Count Department Employees
-- ============================================================

/*
Create:

    count_department_employees

Accept a department ID.

Return the number of employees belonging to that department.
*/


-- ============================================================
-- Exercise 12: Employee Exists
-- ============================================================

/*
Create:

    employee_exists

Accept an employee ID.

Return:

    1 if the employee exists
    0 if the employee does not exist

Use a database lookup.
*/


-- ============================================================
-- Exercise 13: Highest Salary in a Department
-- ============================================================

/*
Create:

    department_highest_salary

Accept a department ID.

Return the highest salary in that department.

If the department has no employees, the result should be NULL.
*/


-- ============================================================
-- Exercise 14: Average Salary in a Department
-- ============================================================

/*
Create:

    department_average_salary

Accept a department ID.

Return the average salary for that department.
*/


-- ============================================================
-- Exercise 15: Function Used in SELECT
-- ============================================================

/*
Using your calculate_safe_bonus function, write a query that
returns:

    employee_name
    salary
    bonus

for every employee.
*/


-- ============================================================
-- Exercise 16: Function Used in WHERE
-- ============================================================

/*
Using calculate_safe_bonus, return employees whose bonus is
greater than 6000.

Return:

    employee_name
    salary
*/


-- ============================================================
-- Exercise 17: Function Used in ORDER BY
-- ============================================================

/*
Return all employees and calculate their bonus.

Sort the results by calculated bonus from highest to lowest.
*/


-- ============================================================
-- Exercise 18: Department Report
-- ============================================================

/*
Using count_department_employees and
department_average_salary, return:

    department_name
    employee_count
    average_salary

for every department.
*/


-- ============================================================
-- Exercise 19: NULL Testing
-- ============================================================

/*
Call calculate_safe_bonus using:

    50000
    0
    NULL

Verify that the function handles NULL correctly.
*/


-- ============================================================
-- Exercise 20: Function Metadata
-- ============================================================

/*
Write SQL statements to:

1. Display all functions in functions_practice.
2. Display the CREATE statement for calculate_safe_bonus.
3. Remove a test function using DROP FUNCTION IF EXISTS.
*/
