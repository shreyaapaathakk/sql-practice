-- ============================================================
-- MODULE 22: STORED PROCEDURES
-- examples.sql
-- MySQL 8.0+
-- ============================================================

CREATE DATABASE IF NOT EXISTS module22_procedures;

USE module22_procedures;

-- ============================================================
-- CLEANUP
-- ============================================================

DROP PROCEDURE IF EXISTS get_all_employees;
DROP PROCEDURE IF EXISTS get_employee_by_id;
DROP PROCEDURE IF EXISTS get_employees_by_department;
DROP PROCEDURE IF EXISTS get_salary_range;
DROP PROCEDURE IF EXISTS add_customer;
DROP PROCEDURE IF EXISTS increase_salary;
DROP PROCEDURE IF EXISTS delete_customer;
DROP PROCEDURE IF EXISTS employee_count;
DROP PROCEDURE IF EXISTS check_salary;
DROP PROCEDURE IF EXISTS department_statistics;
DROP PROCEDURE IF EXISTS department_employees;
DROP PROCEDURE IF EXISTS highest_paid_employees;
DROP PROCEDURE IF EXISTS get_employee_count_out;
DROP PROCEDURE IF EXISTS add_bonus;

DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

-- ============================================================
-- TABLES
-- ============================================================

CREATE TABLE departments (
department_id INT PRIMARY KEY,
department_name VARCHAR(100) NOT NULL
);

CREATE TABLE employees (
employee_id INT PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
salary DECIMAL(10,2) NOT NULL,
department_id INT,
hire_date DATE,
FOREIGN KEY (department_id)
REFERENCES departments(department_id)
);

CREATE TABLE customers (
customer_id INT PRIMARY KEY,
customer_name VARCHAR(100) NOT NULL,
city VARCHAR(100)
);

CREATE TABLE orders (
order_id INT PRIMARY KEY,
customer_id INT NOT NULL,
order_date DATE NOT NULL,
total_amount DECIMAL(10,2) NOT NULL,
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id)
);

-- ============================================================
-- DATA
-- ============================================================

INSERT INTO departments
VALUES
(1, 'Sales'),
(2, 'Technology'),
(3, 'Human Resources'),
(4, 'Finance');

INSERT INTO employees
VALUES
(101, 'Aarav', 'Sharma', 55000, 1, '2022-01-15'),
(102, 'Priya', 'Singh', 72000, 2, '2021-06-10'),
(103, 'Rohan', 'Verma', 48000, 1, '2023-03-20'),
(104, 'Neha', 'Gupta', 65000, 3, '2020-11-05'),
(105, 'Arjun', 'Mehta', 85000, 2, '2019-08-12'),
(106, 'Kavya', 'Patel', 58000, 4, '2024-02-01'),
(107, 'Meera', 'Joshi', 62000, 2, '2023-05-10'),
(108, 'Vikram', 'Rao', 51000, 1, '2024-01-12');

INSERT INTO customers
VALUES
(1, 'Rahul Enterprises', 'Delhi'),
(2, 'Priya Stores', 'Mumbai'),
(3, 'Aman Traders', 'Jaipur'),
(4, 'Neha Solutions', 'Pune');

INSERT INTO orders
VALUES
(1001, 1, '2026-01-05', 1200),
(1002, 2, '2026-01-10', 2500),
(1003, 1, '2026-02-15', 1800),
(1004, 3, '2026-02-20', 950),
(1005, 4, '2026-03-01', 3200);

-- ============================================================
-- 1. SIMPLE PROCEDURE
-- ============================================================

DELIMITER //

CREATE PROCEDURE get_all_employees()
BEGIN
SELECT *
FROM employees;
END //

DELIMITER ;

CALL get_all_employees();

-- ============================================================
-- 2. PROCEDURE WITH IN PARAMETER
-- ============================================================

DELIMITER //

CREATE PROCEDURE get_employee_by_id(
IN p_employee_id INT
)
BEGIN
SELECT *
FROM employees
WHERE employee_id = p_employee_id;
END //

DELIMITER ;

CALL get_employee_by_id(101);

-- ============================================================
-- 3. EMPLOYEES BY DEPARTMENT
-- ============================================================

DELIMITER //

CREATE PROCEDURE get_employees_by_department(
IN p_department_id INT
)
BEGIN
SELECT
employee_id,
first_name,
last_name,
salary
FROM employees
WHERE department_id = p_department_id
ORDER BY salary DESC;
END //

DELIMITER ;

CALL get_employees_by_department(2);

-- ============================================================
-- 4. MULTIPLE PARAMETERS
-- ============================================================

DELIMITER //

CREATE PROCEDURE get_salary_range(
IN p_min_salary DECIMAL(10,2),
IN p_max_salary DECIMAL(10,2)
)
BEGIN
SELECT
employee_id,
first_name,
salary
FROM employees
WHERE salary BETWEEN p_min_salary AND p_max_salary
ORDER BY salary;
END //

DELIMITER ;

CALL get_salary_range(50000, 70000);

-- ============================================================
-- 5. PROCEDURE WITH INSERT
-- ============================================================

DELIMITER //

CREATE PROCEDURE add_customer(
IN p_customer_id INT,
IN p_customer_name VARCHAR(100),
IN p_city VARCHAR(100)
)
BEGIN
INSERT INTO customers (
customer_id,
customer_name,
city
)
VALUES (
p_customer_id,
p_customer_name,
p_city
);
END //

DELIMITER ;

CALL add_customer(
5,
'Arjun Retail',
'Lucknow'
);

SELECT *
FROM customers;

-- ============================================================
-- 6. PROCEDURE WITH UPDATE
-- ============================================================

DELIMITER //

CREATE PROCEDURE increase_salary(
IN p_employee_id INT,
IN p_amount DECIMAL(10,2)
)
BEGIN
UPDATE employees
SET salary = salary + p_amount
WHERE employee_id = p_employee_id;
END //

DELIMITER ;

CALL increase_salary(101, 5000);

SELECT *
FROM employees
WHERE employee_id = 101;

-- ============================================================
-- 7. PROCEDURE WITH DELETE
-- ============================================================

DELIMITER //

CREATE PROCEDURE delete_customer(
IN p_customer_id INT
)
BEGIN
DELETE FROM customers
WHERE customer_id = p_customer_id;
END //

DELIMITER ;

CALL delete_customer(5);

-- ============================================================
-- 8. LOCAL VARIABLE
-- ============================================================

DELIMITER //

CREATE PROCEDURE employee_count()
BEGIN

```
DECLARE total_employees INT;

SELECT COUNT(*)
INTO total_employees
FROM employees;

SELECT total_employees AS employee_count;
```

END //

DELIMITER ;

CALL employee_count();

-- ============================================================
-- 9. IF / ELSEIF / ELSE
-- ============================================================

DELIMITER //

CREATE PROCEDURE check_salary(
IN p_salary DECIMAL(10,2)
)
BEGIN

```
IF p_salary >= 80000 THEN

    SELECT 'High' AS salary_category;

ELSEIF p_salary >= 60000 THEN

    SELECT 'Medium' AS salary_category;

ELSE

    SELECT 'Low' AS salary_category;

END IF;
```

END //

DELIMITER ;

CALL check_salary(85000);
CALL check_salary(65000);
CALL check_salary(45000);

-- ============================================================
-- 10. DEPARTMENT STATISTICS
-- ============================================================

DELIMITER //

CREATE PROCEDURE department_statistics(
IN p_department_id INT
)
BEGIN

```
SELECT
    COUNT(*) AS employee_count,
    SUM(salary) AS total_salary,
    AVG(salary) AS average_salary,
    MIN(salary) AS minimum_salary,
    MAX(salary) AS maximum_salary
FROM employees
WHERE department_id = p_department_id;
```

END //

DELIMITER ;

CALL department_statistics(2);

-- ============================================================
-- 11. PROCEDURE WITH JOIN
-- ============================================================

DELIMITER //

CREATE PROCEDURE department_employees(
IN p_department_id INT
)
BEGIN

```
SELECT
    e.employee_id,
    e.first_name,
    e.last_name,
    e.salary,
    d.department_name
FROM employees AS e
JOIN departments AS d
    ON e.department_id = d.department_id
WHERE e.department_id = p_department_id
ORDER BY e.salary DESC;
```

END //

DELIMITER ;

CALL department_employees(2);

-- ============================================================
-- 12. LIMIT PARAMETER
-- ============================================================

DELIMITER //

CREATE PROCEDURE highest_paid_employees(
IN p_limit INT
)
BEGIN

```
SELECT
    employee_id,
    first_name,
    last_name,
    salary
FROM employees
ORDER BY salary DESC
LIMIT p_limit;
```

END //

DELIMITER ;

CALL highest_paid_employees(3);

-- ============================================================
-- 13. OUT PARAMETER
-- ============================================================

DELIMITER //

CREATE PROCEDURE get_employee_count_out(
OUT p_total INT
)
BEGIN

```
SELECT COUNT(*)
INTO p_total
FROM employees;
```

END //

DELIMITER ;

CALL get_employee_count_out(@total);

SELECT @total AS total_employees;

-- ============================================================
-- 14. INOUT PARAMETER
-- ============================================================

DELIMITER //

CREATE PROCEDURE add_bonus(
INOUT p_amount DECIMAL(10,2)
)
BEGIN

```
SET p_amount = p_amount + 5000;
```

END //

DELIMITER ;

SET @amount = 10000;

CALL add_bonus(@amount);

SELECT @amount AS amount_after_bonus;

-- ============================================================
-- 15. MULTIPLE SQL STATEMENTS
-- ============================================================

DELIMITER //

CREATE PROCEDURE employee_report()
BEGIN

```
SELECT
    employee_id,
    first_name,
    last_name,
    salary
FROM employees
ORDER BY salary DESC;

SELECT
    COUNT(*) AS employee_count,
    AVG(salary) AS average_salary
FROM employees;
```

END //

DELIMITER ;

CALL employee_report();

-- ============================================================
-- 16. INSPECT PROCEDURE
-- ============================================================

SHOW CREATE PROCEDURE get_all_employees;

-- ============================================================
-- 17. LIST PROCEDURES
-- ============================================================

SHOW PROCEDURE STATUS
WHERE Db = 'module22_procedures';

-- ============================================================
-- 18. DROP PROCEDURE
-- ============================================================

DROP PROCEDURE IF EXISTS add_bonus;

-- ============================================================
-- 19. VERIFY REMAINING PROCEDURES
-- ============================================================

SHOW PROCEDURE STATUS
WHERE Db = 'module22_procedures';
