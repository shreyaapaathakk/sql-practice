/*
============================================================
Module 32: Stored Functions in MySQL
File: solutions.sql
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

DELIMITER //

CREATE FUNCTION add_values(
    first_value INT,
    second_value INT
)
RETURNS INT
DETERMINISTIC
NO SQL
BEGIN
    RETURN first_value + second_value;
END //

DELIMITER ;


-- ============================================================
-- Exercise 2: Percentage Calculation
-- ============================================================

DELIMITER //

CREATE FUNCTION calculate_percentage(
    amount DECIMAL(10, 2),
    percentage DECIMAL(5, 2)
)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
NO SQL
BEGIN
    RETURN amount * percentage / 100;
END //

DELIMITER ;


-- ============================================================
-- Exercise 3: Full Name Function
-- ============================================================

DELIMITER //

CREATE FUNCTION create_full_name(
    first_name VARCHAR(50),
    last_name VARCHAR(50)
)
RETURNS VARCHAR(101)
DETERMINISTIC
NO SQL
BEGIN
    RETURN CONCAT(first_name, ' ', last_name);
END //

DELIMITER ;


-- ============================================================
-- Exercise 4: Discounted Price
-- ============================================================

DELIMITER //

CREATE FUNCTION discounted_price(
    original_price DECIMAL(10, 2),
    discount_percentage DECIMAL(5, 2)
)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
NO SQL
BEGIN
    RETURN original_price
        - (original_price * discount_percentage / 100);
END //

DELIMITER ;


-- ============================================================
-- Exercise 5: Salary Category
-- ============================================================

DELIMITER //

CREATE FUNCTION classify_salary(
    salary_value DECIMAL(10, 2)
)
RETURNS VARCHAR(20)
DETERMINISTIC
NO SQL
BEGIN
    IF salary_value >= 75000 THEN
        RETURN 'High';
    ELSEIF salary_value >= 60000 THEN
        RETURN 'Medium';
    ELSE
        RETURN 'Low';
    END IF;
END //

DELIMITER ;


-- ============================================================
-- Exercise 6: Safe Salary Bonus
-- ============================================================

DELIMITER //

CREATE FUNCTION calculate_safe_bonus(
    salary_value DECIMAL(10, 2)
)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
NO SQL
BEGIN
    IF salary_value IS NULL THEN
        RETURN 0;
    END IF;

    RETURN salary_value * 0.10;
END //

DELIMITER ;


-- ============================================================
-- Exercise 7: Employee Label
-- ============================================================

DELIMITER //

CREATE FUNCTION employee_label(
    employee_id_value INT,
    employee_name_value VARCHAR(100)
)
RETURNS VARCHAR(150)
DETERMINISTIC
NO SQL
BEGIN
    RETURN CONCAT(
        'Employee #',
        employee_id_value,
        ' - ',
        employee_name_value
    );
END //

DELIMITER ;


-- ============================================================
-- Exercise 8: Add Days to a Date
-- ============================================================

DELIMITER //

CREATE FUNCTION future_date(
    input_date DATE,
    days_to_add INT
)
RETURNS DATE
DETERMINISTIC
NO SQL
BEGIN
    RETURN DATE_ADD(
        input_date,
        INTERVAL days_to_add DAY
    );
END //

DELIMITER ;


-- ============================================================
-- Exercise 9: Employee Years of Service
-- ============================================================

DELIMITER //

CREATE FUNCTION years_of_service(
    hire_date_value DATE
)
RETURNS INT
NOT DETERMINISTIC
NO SQL
BEGIN
    RETURN TIMESTAMPDIFF(
        YEAR,
        hire_date_value,
        CURRENT_DATE
    );
END //

DELIMITER ;


-- ============================================================
-- Exercise 10: Retrieve Employee Salary
-- ============================================================

DELIMITER //

CREATE FUNCTION find_employee_salary(
    employee_id_value INT
)
RETURNS DECIMAL(10, 2)
READS SQL DATA
BEGIN
    DECLARE salary_value DECIMAL(10, 2);

    SELECT salary
    INTO salary_value
    FROM employees
    WHERE employee_id = employee_id_value;

    RETURN salary_value;
END //

DELIMITER ;


-- ============================================================
-- Exercise 11: Count Department Employees
-- ============================================================

DELIMITER //

CREATE FUNCTION count_department_employees(
    department_id_value INT
)
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE employee_count INT;

    SELECT COUNT(*)
    INTO employee_count
    FROM employees
    WHERE department_id = department_id_value;

    RETURN employee_count;
END //

DELIMITER ;


-- ============================================================
-- Exercise 12: Employee Exists
-- ============================================================

DELIMITER //

CREATE FUNCTION employee_exists(
    employee_id_value INT
)
RETURNS TINYINT
READS SQL DATA
BEGIN
    DECLARE employee_count INT;

    SELECT COUNT(*)
    INTO employee_count
    FROM employees
    WHERE employee_id = employee_id_value;

    IF employee_count > 0 THEN
        RETURN 1;
    END IF;

    RETURN 0;
END //

DELIMITER ;


-- ============================================================
-- Exercise 13: Highest Salary in a Department
-- ============================================================

DELIMITER //

CREATE FUNCTION department_highest_salary(
    department_id_value INT
)
RETURNS DECIMAL(10, 2)
READS SQL DATA
BEGIN
    DECLARE highest_salary DECIMAL(10, 2);

    SELECT MAX(salary)
    INTO highest_salary
    FROM employees
    WHERE department_id = department_id_value;

    RETURN highest_salary;
END //

DELIMITER ;


-- ============================================================
-- Exercise 14: Average Salary in a Department
-- ============================================================

DELIMITER //

CREATE FUNCTION department_average_salary(
    department_id_value INT
)
RETURNS DECIMAL(10, 2)
READS SQL DATA
BEGIN
    DECLARE average_salary DECIMAL(10, 2);

    SELECT AVG(salary)
    INTO average_salary
    FROM employees
    WHERE department_id = department_id_value;

    RETURN average_salary;
END //

DELIMITER ;


-- ============================================================
-- Exercise 15: Function Used in SELECT
-- ============================================================

SELECT
    employee_name,
    salary,
    calculate_safe_bonus(salary) AS bonus
FROM employees;


-- ============================================================
-- Exercise 16: Function Used in WHERE
-- ============================================================

SELECT
    employee_name,
    salary
FROM employees
WHERE calculate_safe_bonus(salary) > 6000;


-- ============================================================
-- Exercise 17: Function Used in ORDER BY
-- ============================================================

SELECT
    employee_name,
    salary,
    calculate_safe_bonus(salary) AS bonus
FROM employees
ORDER BY calculate_safe_bonus(salary) DESC;


-- ============================================================
-- Exercise 18: Department Report
-- ============================================================

SELECT
    department_name,
    count_department_employees(department_id) AS employee_count,
    department_average_salary(department_id) AS average_salary
FROM departments;


-- ============================================================
-- Exercise 19: NULL Testing
-- ============================================================

SELECT
    calculate_safe_bonus(50000) AS bonus_for_50000,
    calculate_safe_bonus(0) AS bonus_for_zero,
    calculate_safe_bonus(NULL) AS bonus_for_null;


-- ============================================================
-- Exercise 20: Function Metadata
-- ============================================================

SELECT
    ROUTINE_SCHEMA,
    ROUTINE_NAME,
    ROUTINE_TYPE,
    DATA_TYPE
FROM information_schema.ROUTINES
WHERE ROUTINE_SCHEMA = 'functions_practice'
  AND ROUTINE_TYPE = 'FUNCTION';

SHOW CREATE FUNCTION calculate_safe_bonus;

DROP FUNCTION IF EXISTS add_values;
