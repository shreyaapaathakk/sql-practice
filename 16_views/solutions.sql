-- ============================================================
-- MODULE 16: VIEWS
-- solutions.sql
-- MySQL 8.0+
-- ============================================================

CREATE DATABASE IF NOT EXISTS module16_views;

USE module16_views;

-- ============================================================
-- EASY
-- ============================================================

---

-- Exercise 1 — Solution

---

DROP VIEW IF EXISTS basic_employee_view;

CREATE VIEW basic_employee_view AS
SELECT
employee_id,
first_name,
last_name,
email
FROM employees;

---

-- Exercise 2 — Solution

---

DROP VIEW IF EXISTS high_salary_employees;

CREATE VIEW high_salary_employees AS
SELECT
employee_id,
first_name,
last_name,
salary
FROM employees
WHERE salary >= 60000;

---

-- Exercise 3 — Solution

---

SELECT
employee_id,
first_name,
last_name,
salary
FROM high_salary_employees
WHERE salary < 80000
ORDER BY salary DESC;

---

-- Exercise 4 — Solution

---

DROP VIEW IF EXISTS employee_names;

CREATE VIEW employee_names AS
SELECT
employee_id,
CONCAT(first_name, ' ', last_name) AS full_name
FROM employees;

---

-- Exercise 5 — Solution

---

SHOW CREATE VIEW employee_names;

-- ============================================================
-- MEDIUM
-- ============================================================

---

-- Exercise 6 — Solution

---

DROP VIEW IF EXISTS employee_department_view;

CREATE VIEW employee_department_view AS
SELECT
e.employee_id,
CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
d.department_name,
e.salary
FROM employees AS e
INNER JOIN departments AS d
ON e.department_id = d.department_id;

---

-- Exercise 7 — Solution

---

SELECT
employee_id,
employee_name,
department_name,
salary
FROM employee_department_view
WHERE department_name = 'Technology'
ORDER BY salary DESC;

---

-- Exercise 8 — Solution

---

DROP VIEW IF EXISTS customer_orders_view;

CREATE VIEW customer_orders_view AS
SELECT
c.customer_id,
c.customer_name,
o.order_id,
o.order_date,
o.total_amount
FROM customers AS c
INNER JOIN orders AS o
ON c.customer_id = o.customer_id;

---

-- Exercise 9 — Solution

---

DROP VIEW IF EXISTS customer_order_summary;

CREATE VIEW customer_order_summary AS
SELECT
c.customer_id,
c.customer_name,
COUNT(o.order_id) AS order_count,
COALESCE(SUM(o.total_amount), 0) AS total_spent
FROM customers AS c
LEFT JOIN orders AS o
ON c.customer_id = o.customer_id
GROUP BY
c.customer_id,
c.customer_name;

---

-- Exercise 10 — Solution

---

SELECT
customer_id,
customer_name,
order_count,
total_spent
FROM customer_order_summary
WHERE total_spent > 2500
ORDER BY total_spent DESC;

-- ============================================================
-- HARD
-- ============================================================

---

-- Exercise 11 — Solution

---

DROP VIEW IF EXISTS department_salary_report;

CREATE VIEW department_salary_report AS
SELECT
department_id,
COUNT(*) AS employee_count,
AVG(salary) AS average_salary,
MAX(salary) AS highest_salary,
MIN(salary) AS lowest_salary
FROM employees
GROUP BY department_id;

---

-- Exercise 12 — Solution

---

SELECT
department_id,
employee_count,
average_salary,
highest_salary,
lowest_salary
FROM department_salary_report
WHERE average_salary > 60000
ORDER BY average_salary DESC;

---

-- Exercise 13 — Solution

---

DROP VIEW IF EXISTS monthly_order_report;

CREATE VIEW monthly_order_report AS
SELECT
YEAR(order_date) AS order_year,
MONTH(order_date) AS order_month,
COUNT(*) AS order_count,
SUM(total_amount) AS total_sales
FROM orders
GROUP BY
YEAR(order_date),
MONTH(order_date);

---

-- Exercise 14 — Solution

---

CREATE OR REPLACE VIEW monthly_order_report AS
SELECT
YEAR(order_date) AS order_year,
MONTH(order_date) AS order_month,
COUNT(*) AS order_count,
SUM(total_amount) AS total_sales,
AVG(total_amount) AS average_order_value
FROM orders
GROUP BY
YEAR(order_date),
MONTH(order_date);

---

-- Exercise 15 — Solution

---

SELECT
TABLE_NAME,
VIEW_DEFINITION
FROM INFORMATION_SCHEMA.VIEWS
WHERE TABLE_SCHEMA = DATABASE()
AND TABLE_NAME = 'monthly_order_report';

-- ============================================================
-- ADVANCED BEGINNER
-- ============================================================

---

-- Exercise 16 — Solution

---

DROP VIEW IF EXISTS employee_directory;

CREATE VIEW employee_directory AS
SELECT
e.employee_id,
CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
d.department_name,
e.email
FROM employees AS e
INNER JOIN departments AS d
ON e.department_id = d.department_id;

---

-- Exercise 17 — Solution

---

SELECT
employee_id,
employee_name,
department_name,
email
FROM employee_directory
WHERE department_name IN ('Sales', 'Finance')
ORDER BY employee_name ASC;

---

-- Exercise 18 — Solution

---

DROP VIEW IF EXISTS large_orders;

CREATE VIEW large_orders AS
SELECT
order_id,
customer_id,
order_date,
total_amount
FROM orders
WHERE total_amount > 2000;

---

-- Exercise 19 — Solution

---

SELECT
order_id,
customer_id,
order_date,
total_amount
FROM large_orders
ORDER BY total_amount DESC
LIMIT 3;

---

-- Exercise 20 — Solution

---

DROP VIEW IF EXISTS employee_email_view;

CREATE VIEW employee_email_view AS
SELECT
employee_id,
first_name,
last_name,
email
FROM employees;

-- Update the underlying employee through the simple view.

UPDATE employee_email_view
SET email = '[priya.updated@example.com](mailto:priya.updated@example.com)'
WHERE employee_id = 102;

-- Verify the change in the underlying table.

SELECT
employee_id,
first_name,
last_name,
email
FROM employees
WHERE employee_id = 102;

-- Restore the original demonstration value.

UPDATE employees
SET email = '[priya@example.com](mailto:priya@example.com)'
WHERE employee_id = 102;

---

-- Exercise 21 — Solution

---

DROP VIEW IF EXISTS department_employee_report;

CREATE VIEW department_employee_report AS
SELECT
d.department_name,
COUNT(e.employee_id) AS employee_count,
SUM(e.salary) AS total_salary,
AVG(e.salary) AS average_salary
FROM departments AS d
INNER JOIN employees AS e
ON d.department_id = e.department_id
GROUP BY
d.department_id,
d.department_name;

---

-- Exercise 22 — Solution

---

SELECT
department_name,
employee_count,
total_salary,
average_salary
FROM department_employee_report
WHERE employee_count >= 2
AND total_salary > 100000
ORDER BY total_salary DESC;

---

-- Exercise 23 — Solution

---

DROP VIEW IF EXISTS customer_spending_report;

CREATE VIEW customer_spending_report AS
SELECT
c.customer_id,
c.customer_name,
c.city,
COUNT(o.order_id) AS order_count,
COALESCE(SUM(o.total_amount), 0) AS total_spent,
COALESCE(AVG(o.total_amount), 0) AS average_order_value
FROM customers AS c
LEFT JOIN orders AS o
ON c.customer_id = o.customer_id
GROUP BY
c.customer_id,
c.customer_name,
c.city;

---

-- Exercise 24 — Solution

---

SHOW FULL TABLES;

---

-- Exercise 25 — Solution

---

DROP VIEW IF EXISTS top_customer_orders;

CREATE VIEW top_customer_orders AS
SELECT
c.customer_name,
o.order_id,
o.order_date,
o.total_amount
FROM customers AS c
INNER JOIN orders AS o
ON c.customer_id = o.customer_id
WHERE o.total_amount > 1500;

SELECT
customer_name,
order_id,
order_date,
total_amount
FROM top_customer_orders
ORDER BY total_amount DESC;
