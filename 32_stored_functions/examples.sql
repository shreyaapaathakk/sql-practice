/*
============================================================
Module 32: Stored Functions in MySQL
File: examples.sql
Dialect: MySQL 8.0+
============================================================

IMPORTANT:
- Educational examples only.
- Use a dedicated MySQL practice database.
- Never use real passwords or secrets.
- These examples assume appropriate privileges.
============================================================
*/

CREATE DATABASE IF NOT EXISTS functions_practice;

USE functions_practice;


-- ============================================================
-- 1. Sample Tables
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
-- 2. Simple Function
-- ============================================================

DELIMITER //

CREATE FUNCTION add_numbers(
    first_number INT,
    second_number INT
)
RETURNS INT
DETERMINISTIC
NO SQL
BEGIN
    RETURN first_number + second_number;
END //

DELIMITER ;


SELECT add_numbers(10, 25) AS result;


-- ============================================================
-- 3. Function with a Decimal Result
-- ============================================================

DELIMITER //

CREATE FUNCTION calculate_tax(
    amount DECIMAL(10, 2)
)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
NO SQL
BEGIN
    RETURN amount * 0.18;
END //

DELIMITER ;


SELECT calculate_tax(1000.00) AS tax;


-- ============================================================
-- 4. Function Used with Table Data
-- ============================================================

SELECT
    employee_name,
    salary,
    calculate_tax(salary) AS estimated_tax
FROM employees;


-- ============================================================
-- 5. Function Returning a String
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
        '#',
        employee_id_value,
        ' - ',
        employee_name_value
    );
END //

DELIMITER ;


SELECT
    employee_label(employee_id, employee_name) AS employee_label
FROM employees;


-- ============================================================
-- 6. Function with a Local Variable
-- ============================================================

DELIMITER //

CREATE FUNCTION calculate_bonus(
    salary_value DECIMAL(10, 2)
)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
NO SQL
BEGIN
    DECLARE bonus DECIMAL(10, 2);

    SET bonus = salary_value * 0.10;

    RETURN bonus;
END //

DELIMITER ;


SELECT
    employee_name,
    salary,
    calculate_bonus(salary) AS bonus
FROM employees;


-- ============================================================
-- 7. Function with IF Logic
-- ============================================================

DELIMITER //

CREATE FUNCTION salary_category(
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


SELECT
    employee_name,
    salary,
    salary_category(salary) AS salary_category
FROM employees;


-- ============================================================
-- 8. Function Using CASE
-- ============================================================

DELIMITER //

CREATE FUNCTION order_size(
    amount DECIMAL(10, 2)
)
RETURNS VARCHAR(20)
DETERMINISTIC
NO SQL
BEGIN
    RETURN CASE
        WHEN amount >= 10000 THEN 'Large'
        WHEN amount >= 5000 THEN 'Medium'
        ELSE 'Small'
    END;
END //

DELIMITER ;


SELECT
    order_size(2500.00) AS category;


-- ============================================================
-- 9. Function Handling NULL
-- ============================================================

DELIMITER //

CREATE FUNCTION safe_bonus(
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


SELECT
    safe_bonus(50000.00) AS bonus_with_salary,
    safe_bonus(NULL) AS bonus_without_salary;


-- ============================================================
-- 10. Function Returning a Date
-- ============================================================

DELIMITER //

CREATE FUNCTION add_days(
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


SELECT add_days('2026-01-01', 30) AS resulting_date;


-- ============================================================
-- 11. Function Based on the Current Date
-- ============================================================

DELIMITER //

CREATE FUNCTION employee_years_of_service(
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


SELECT
    employee_name,
    hire_date,
    employee_years_of_service(hire_date) AS years_of_service
FROM employees;


-- ============================================================
-- 12. Function That Reads Table Data
-- ============================================================

DELIMITER //

CREATE FUNCTION get_employee_salary(
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


SELECT get_employee_salary(1) AS employee_salary;


-- ============================================================
-- 13. Function That Counts Rows
-- ============================================================

DELIMITER //

CREATE FUNCTION department_employee_count(
    department_id_value INT
)
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE employee_count_value INT;

    SELECT COUNT(*)
    INTO employee_count_value
    FROM employees
    WHERE department_id = department_id_value;

    RETURN employee_count_value;
END //

DELIMITER ;


SELECT
    department_name,
    department_employee_count(department_id) AS employee_count
FROM departments;


-- ============================================================
-- 14. Function Returning a Calculated Price
-- ============================================================

DELIMITER //

CREATE FUNCTION calculate_discounted_price(
    original_price DECIMAL(10, 2),
    discount_percentage DECIMAL(5, 2)
)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
NO SQL
BEGIN
    IF original_price IS NULL
       OR discount_percentage IS NULL THEN
        RETURN NULL;
    END IF;

    RETURN original_price
        - (original_price * discount_percentage / 100);
END //

DELIMITER ;


SELECT
    calculate_discounted_price(2500.00, 15) AS final_price;


-- ============================================================
-- 15. Function Used in WHERE
-- ============================================================

SELECT
    employee_name,
    salary
FROM employees
WHERE calculate_bonus(salary) > 6000;


-- ============================================================
-- 16. Function Used in ORDER BY
-- ============================================================

SELECT
    employee_name,
    salary,
    calculate_bonus(salary) AS bonus
FROM employees
ORDER BY calculate_bonus(salary) DESC;


-- ============================================================
-- 17. Function Used in a Larger Expression
-- ============================================================

SELECT
    employee_name,
    salary,
    calculate_bonus(salary) AS bonus,
    salary + calculate_bonus(salary) AS total_compensation
FROM employees;


-- ============================================================
-- 18. Drop a Function
-- ============================================================

/*
DROP FUNCTION IF EXISTS add_numbers;
*/


-- ============================================================
-- 19. Inspect Stored Functions
-- ============================================================

SHOW FUNCTION STATUS
WHERE Db = 'functions_practice';


-- ============================================================
-- 20. Inspect a Function Definition
-- ============================================================

SHOW CREATE FUNCTION calculate_bonus;
