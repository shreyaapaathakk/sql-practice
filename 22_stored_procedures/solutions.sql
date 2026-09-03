-- ============================================================
-- MODULE 22: STORED PROCEDURES
-- solutions.sql
-- ============================================================

USE module22_procedures;

-- ============================================================
-- Exercise 1
-- ============================================================

DROP PROCEDURE IF EXISTS get_all_employees;

DELIMITER //

CREATE PROCEDURE get_all_employees()
BEGIN
SELECT *
FROM employees;
END //

DELIMITER ;

-- Exercise 2

CALL get_all_employees();

-- ============================================================
-- Exercise 3
-- ============================================================

DROP PROCEDURE IF EXISTS get_employee_by_id;

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
-- Exercise 4
-- ============================================================

DROP PROCEDURE IF EXISTS get_high_salary_employees;

DELIMITER //

CREATE PROCEDURE get_high_salary_employees(
IN p_min_salary DECIMAL(10,2)
)
BEGIN
SELECT
employee_id,
first_name,
last_name,
salary
FROM employees
WHERE salary >= p_min_salary
ORDER BY salary DESC;
END //

DELIMITER ;

-- ============================================================
-- Exercise 5
-- ============================================================

DROP PROCEDURE IF EXISTS get_salary_range;

DELIMITER //

CREATE PROCEDURE get_salary_range(
IN p_min_salary DECIMAL(10,2),
IN p_max_salary DECIMAL(10,2)
)
BEGIN
SELECT
employee_id,
first_name,
last_name,
salary
FROM employees
WHERE salary BETWEEN p_min_salary AND p_max_salary
ORDER BY salary;
END //

DELIMITER ;

-- ============================================================
-- Exercise 6
-- ============================================================

DROP PROCEDURE IF EXISTS department_salary_filter;

DELIMITER //

CREATE PROCEDURE department_salary_filter(
IN p_department_id INT,
IN p_min_salary DECIMAL(10,2)
)
BEGIN
SELECT
employee_id,
first_name,
last_name,
salary
FROM employees
WHERE department_id = p_department_id
AND salary >= p_min_salary
ORDER BY salary DESC;
END //

DELIMITER ;

-- ============================================================
-- Exercise 7
-- ============================================================

DROP PROCEDURE IF EXISTS add_customer;

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

-- ============================================================
-- Exercise 8
-- ============================================================

DROP PROCEDURE IF EXISTS update_customer_city;

DELIMITER //

CREATE PROCEDURE update_customer_city(
IN p_customer_id INT,
IN p_city VARCHAR(100)
)
BEGIN
UPDATE customers
SET city = p_city
WHERE customer_id = p_customer_id;
END //

DELIMITER ;

-- ============================================================
-- Exercise 9
-- ============================================================

DROP PROCEDURE IF EXISTS increase_salary;

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

-- ============================================================
-- Exercise 10
-- ============================================================

DROP PROCEDURE IF EXISTS delete_customer;

DELIMITER //

CREATE PROCEDURE delete_customer(
IN p_customer_id INT
)
BEGIN
DELETE FROM customers
WHERE customer_id = p_customer_id;
END //

DELIMITER ;

-- ============================================================
-- Exercise 11
-- ============================================================

DROP PROCEDURE IF EXISTS employee_count;

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

-- ============================================================
-- Exercise 12
-- ============================================================

DROP PROCEDURE IF EXISTS average_salary;

DELIMITER //

CREATE PROCEDURE average_salary()
BEGIN

```
DECLARE avg_salary DECIMAL(10,2);

SELECT AVG(salary)
INTO avg_salary
FROM employees;

SELECT avg_salary AS average_salary;
```

END //

DELIMITER ;

-- ============================================================
-- Exercise 13
-- ============================================================

DROP PROCEDURE IF EXISTS department_average_salary;

DELIMITER //

CREATE PROCEDURE department_average_salary(
IN p_department_id INT
)
BEGIN

```
DECLARE avg_salary DECIMAL(10,2);

SELECT AVG(salary)
INTO avg_salary
FROM employees
WHERE department_id = p_department_id;

SELECT avg_salary AS average_salary;
```

END //

DELIMITER ;

-- ============================================================
-- Exercise 14
-- ============================================================

DROP PROCEDURE IF EXISTS salary_category;

DELIMITER //

CREATE PROCEDURE salary_category(
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

-- ============================================================
-- Exercise 15
-- ============================================================

DROP PROCEDURE IF EXISTS amount_category;

DELIMITER //

CREATE PROCEDURE amount_category(
IN p_amount DECIMAL(10,2)
)
BEGIN

```
IF p_amount >= 5000 THEN
    SELECT 'Large Amount' AS amount_category;
ELSE
    SELECT 'Small Amount' AS amount_category;
END IF;
```

END //

DELIMITER ;

-- ============================================================
-- Exercise 16
-- ============================================================

DROP PROCEDURE IF EXISTS department_statistics;

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

-- ============================================================
-- Exercise 17
-- ============================================================

DROP PROCEDURE IF EXISTS department_employee_count;

DELIMITER //

CREATE PROCEDURE department_employee_count(
IN p_department_id INT
)
BEGIN

```
SELECT COUNT(*) AS employee_count
FROM employees
WHERE department_id = p_department_id;
```

END //

DELIMITER ;

-- ============================================================
-- Exercise 18
-- ============================================================

DROP PROCEDURE IF EXISTS department_employees;

DELIMITER //

CREATE PROCEDURE department_employees(
IN p_department_id INT
)
BEGIN

```
SELECT
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    e.salary,
    d.department_name
FROM employees AS e
JOIN departments AS d
    ON e.department_id = d.department_id
WHERE e.department_id = p_department_id;
```

END //

DELIMITER ;

-- ============================================================
-- Exercise 19
-- ============================================================

DROP PROCEDURE IF EXISTS department_employees;

DELIMITER //

CREATE PROCEDURE department_employees(
IN p_department_id INT
)
BEGIN

```
SELECT
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
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

-- ============================================================
-- Exercise 20
-- ============================================================

DROP PROCEDURE IF EXISTS get_employee_count_out;

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

CALL get_employee_count_out(@total_employees);

SELECT @total_employees;

-- ============================================================
-- Exercise 21
-- ============================================================

DROP PROCEDURE IF EXISTS get_average_salary_out;

DELIMITER //

CREATE PROCEDURE get_average_salary_out(
OUT p_average DECIMAL(10,2)
)
BEGIN

```
SELECT AVG(salary)
INTO p_average
FROM employees;
```

END //

DELIMITER ;

CALL get_average_salary_out(@average_salary);

SELECT @average_salary;

-- ============================================================
-- Exercise 22
-- ============================================================

DROP PROCEDURE IF EXISTS get_department_total_salary;

DELIMITER //

CREATE PROCEDURE get_department_total_salary(
IN p_department_id INT,
OUT p_total_salary DECIMAL(10,2)
)
BEGIN

```
SELECT COALESCE(SUM(salary), 0)
INTO p_total_salary
FROM employees
WHERE department_id = p_department_id;
```

END //

DELIMITER ;

CALL get_department_total_salary(
2,
@department_total
);

SELECT @department_total;

-- ============================================================
-- Exercise 23
-- ============================================================

DROP PROCEDURE IF EXISTS increase_amount;

DELIMITER //

CREATE PROCEDURE increase_amount(
INOUT p_amount DECIMAL(10,2)
)
BEGIN

```
SET p_amount = p_amount + 1000;
```

END //

DELIMITER ;

SET @amount = 5000;

CALL increase_amount(@amount);

SELECT @amount;

-- ============================================================
-- Exercise 24
-- ============================================================

DROP PROCEDURE IF EXISTS smart_increase;

DELIMITER //

CREATE PROCEDURE smart_increase(
INOUT p_amount DECIMAL(10,2)
)
BEGIN

```
IF p_amount > 10000 THEN
    SET p_amount = p_amount * 1.20;
ELSE
    SET p_amount = p_amount * 1.10;
END IF;
```

END //

DELIMITER ;

SET @amount = 12000;

CALL smart_increase(@amount);

SELECT @amount;

-- ============================================================
-- Exercise 25
-- ============================================================

DROP PROCEDURE IF EXISTS top_paid_employees;

DELIMITER //

CREATE PROCEDURE top_paid_employees(
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

-- ============================================================
-- Exercise 26
-- ============================================================

DROP PROCEDURE IF EXISTS top_department_employees;

DELIMITER //

CREATE PROCEDURE top_department_employees(
IN p_department_id INT,
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
WHERE department_id = p_department_id
ORDER BY salary DESC
LIMIT p_limit;
```

END //

DELIMITER ;

-- ============================================================
-- Exercise 27
-- ============================================================

DROP PROCEDURE IF EXISTS employee_report;

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
    COUNT(*) AS employee_count
FROM employees;

SELECT
    AVG(salary) AS average_salary
FROM employees;
```

END //

DELIMITER ;

-- ============================================================
-- Exercise 28
-- ============================================================

SHOW CREATE PROCEDURE employee_report;

-- ============================================================
-- Exercise 29
-- ============================================================

SHOW PROCEDURE STATUS
WHERE Db = 'module22_procedures';

-- ============================================================
-- Exercise 30
-- ============================================================

DROP PROCEDURE IF EXISTS amount_category;

-- ============================================================
-- Exercise 31
-- ============================================================

DROP PROCEDURE IF EXISTS customer_orders;

DELIMITER //

CREATE PROCEDURE customer_orders(
IN p_customer_id INT
)
BEGIN

```
SELECT
    order_id,
    order_date,
    total_amount
FROM orders
WHERE customer_id = p_customer_id
ORDER BY order_date;
```

END //

DELIMITER ;

-- ============================================================
-- Exercise 32
-- ============================================================

DROP PROCEDURE IF EXISTS customer_total_spending;

DELIMITER //

CREATE PROCEDURE customer_total_spending(
IN p_customer_id INT
)
BEGIN

```
SELECT
    COUNT(*) AS total_orders,
    SUM(total_amount) AS total_spending,
    AVG(total_amount) AS average_order_value
FROM orders
WHERE customer_id = p_customer_id;
```

END //

DELIMITER ;

-- ============================================================
-- Exercise 33
-- ============================================================

DROP PROCEDURE IF EXISTS employee_analysis;

DELIMITER //

CREATE PROCEDURE employee_analysis(
IN p_employee_id INT
)
BEGIN

```
SELECT
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    d.department_name,
    e.salary,

    CASE
        WHEN e.salary >= 80000 THEN 'High'
        WHEN e.salary >= 60000 THEN 'Medium'
        ELSE 'Low'
    END AS salary_category

FROM employees AS e

JOIN departments AS d
    ON e.department_id = d.department_id

WHERE e.employee_id = p_employee_id;
```

END //

DELIMITER ;

-- ============================================================
-- Exercise 34
-- ============================================================

DROP PROCEDURE IF EXISTS highest_paid_in_department;

DELIMITER //

CREATE PROCEDURE highest_paid_in_department(
IN p_department_id INT
)
BEGIN

```
SELECT
    employee_id,
    first_name,
    last_name,
    salary
FROM employees
WHERE department_id = p_department_id
ORDER BY salary DESC
LIMIT 1;
```

END //

DELIMITER ;

-- ============================================================
-- Exercise 35
-- ============================================================

DROP PROCEDURE IF EXISTS salary_analysis;

DELIMITER //

CREATE PROCEDURE salary_analysis(
IN p_min_salary DECIMAL(10,2)
)
BEGIN

```
SELECT
    COUNT(*) AS employee_count,
    AVG(salary) AS average_salary,
    MAX(salary) AS highest_salary,
    MIN(salary) AS lowest_salary
FROM employees
WHERE salary >= p_min_salary;
```

END //

DELIMITER ;

-- ============================================================
-- MINI PROJECT PROCEDURES
-- ============================================================

-- 1. Get employee by ID

DROP PROCEDURE IF EXISTS api_get_employee;

DELIMITER //

CREATE PROCEDURE api_get_employee(
IN p_employee_id INT
)
BEGIN

```
SELECT
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    d.department_name,
    e.salary
FROM employees AS e
JOIN departments AS d
    ON e.department_id = d.department_id
WHERE e.employee_id = p_employee_id;
```

END //

DELIMITER ;

-- 2. Get employees by department

DROP PROCEDURE IF EXISTS api_get_department_employees;

DELIMITER //

CREATE PROCEDURE api_get_department_employees(
IN p_department_id INT
)
BEGIN

```
SELECT
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    e.salary
FROM employees AS e
WHERE e.department_id = p_department_id
ORDER BY e.salary DESC;
```

END //

DELIMITER ;

-- 3. Increase salary

DROP PROCEDURE IF EXISTS api_increase_salary;

DELIMITER //

CREATE PROCEDURE api_increase_salary(
IN p_employee_id INT,
IN p_amount DECIMAL(10,2)
)
BEGIN

```
UPDATE employees
SET salary = salary + p_amount
WHERE employee_id = p_employee_id;

SELECT
    employee_id,
    first_name,
    last_name,
    salary
FROM employees
WHERE employee_id = p_employee_id;
```

END //

DELIMITER ;

-- 4. Department statistics

DROP PROCEDURE IF EXISTS api_department_statistics;

DELIMITER //

CREATE PROCEDURE api_department_statistics(
IN p_department_id INT
)
BEGIN

```
SELECT
    d.department_name,
    COUNT(e.employee_id) AS employee_count,
    COALESCE(SUM(e.salary), 0) AS total_salary,
    COALESCE(AVG(e.salary), 0) AS average_salary
FROM departments AS d
LEFT JOIN employees AS e
    ON d.department_id = e.department_id
WHERE d.department_id = p_department_id
GROUP BY
    d.department_id,
    d.department_name;
```

END //

DELIMITER ;

-- 5. Add customer

DROP PROCEDURE IF EXISTS api_add_customer;

DELIMITER //

CREATE PROCEDURE api_add_customer(
IN p_customer_id INT,
IN p_customer_name VARCHAR(100),
IN p_city VARCHAR(100)
)
BEGIN

```
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
```

END //

DELIMITER ;

-- 6. Customer orders

DROP PROCEDURE IF EXISTS api_customer_orders;

DELIMITER //

CREATE PROCEDURE api_customer_orders(
IN p_customer_id INT
)
BEGIN

```
SELECT
    c.customer_name,
    o.order_id,
    o.order_date,
    o.total_amount
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
WHERE c.customer_id = p_customer_id
ORDER BY o.order_date;
```

END //

DELIMITER ;

-- 7. Customer spending

DROP PROCEDURE IF EXISTS api_customer_spending;

DELIMITER //

CREATE PROCEDURE api_customer_spending(
IN p_customer_id INT
)
BEGIN

```
SELECT
    c.customer_name,
    COUNT(o.order_id) AS total_orders,
    COALESCE(SUM(o.total_amount), 0) AS total_spending,
    COALESCE(AVG(o.total_amount), 0) AS average_order_value
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
WHERE c.customer_id = p_customer_id
GROUP BY
    c.customer_id,
    c.customer_name;
```

END //

DELIMITER ;

-- 8. Top-paid employees

DROP PROCEDURE IF EXISTS api_top_paid_employees;

DELIMITER //

CREATE PROCEDURE api_top_paid_employees(
IN p_limit INT
)
BEGIN

```
SELECT
    employee_id,
    CONCAT(first_name, ' ', last_name) AS employee_name,
    salary
FROM employees
ORDER BY salary DESC
LIMIT p_limit;
```

END //

DELIMITER ;

-- ============================================================
-- TEST MINI PROJECT
-- ============================================================

CALL api_get_employee(101);

CALL api_get_department_employees(2);

CALL api_increase_salary(101, 2000);

CALL api_department_statistics(2);

CALL api_customer_orders(1);

CALL api_customer_spending(1);

CALL api_top_paid_employees(3);
