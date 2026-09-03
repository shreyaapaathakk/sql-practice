-- ============================================================
-- MODULE 21: SQL VIEWS
-- solutions.sql
-- ============================================================

USE module21_views;

-- ============================================================
-- Exercise 1
-- ============================================================

DROP VIEW IF EXISTS high_salary_employees;

CREATE VIEW high_salary_employees AS
SELECT
employee_id,
first_name,
salary
FROM employees
WHERE salary > 60000;

-- Exercise 2

SELECT *
FROM high_salary_employees;

-- Exercise 3

SELECT *
FROM high_salary_employees
WHERE salary > 70000;

-- Exercise 4

SELECT *
FROM high_salary_employees
ORDER BY salary DESC;

-- Exercise 5

DROP VIEW IF EXISTS employee_details;

CREATE VIEW employee_details AS
SELECT
e.employee_id,
CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
e.salary,
d.department_name
FROM employees AS e
JOIN departments AS d
ON e.department_id = d.department_id;

-- Exercise 6

SELECT *
FROM employee_details;

-- Exercise 7

SELECT *
FROM employee_details
WHERE salary > 60000;

-- Exercise 8

SELECT *
FROM employee_details
ORDER BY salary DESC;

-- Exercise 9

DROP VIEW IF EXISTS department_summary;

CREATE VIEW department_summary AS
SELECT
department_id,
COUNT(*) AS employee_count,
SUM(salary) AS total_salary,
AVG(salary) AS average_salary
FROM employees
GROUP BY department_id;

-- Exercise 10

SELECT *
FROM department_summary;

-- Exercise 11

SELECT *
FROM department_summary
WHERE total_salary > 100000;

-- Exercise 12

SELECT *
FROM department_summary
WHERE employee_count > 1;

-- Exercise 13

DROP VIEW IF EXISTS employee_salary_categories;

CREATE VIEW employee_salary_categories AS
SELECT
employee_id,
first_name,
salary,
CASE
WHEN salary >= 80000 THEN 'High'
WHEN salary >= 60000 THEN 'Medium'
ELSE 'Low'
END AS salary_category
FROM employees;

-- Exercise 14

SELECT
salary_category,
COUNT(*) AS employee_count
FROM employee_salary_categories
GROUP BY salary_category;

-- Exercise 15

SELECT *
FROM employee_salary_categories
WHERE salary_category = 'High';

-- Exercise 16

DROP VIEW IF EXISTS employee_rankings;

CREATE VIEW employee_rankings AS
SELECT
employee_id,
first_name,
department_id,
salary,
RANK() OVER (
PARTITION BY department_id
ORDER BY salary DESC
) AS department_rank
FROM employees;

-- Exercise 17

SELECT *
FROM employee_rankings;

-- Exercise 18

SELECT *
FROM employee_rankings
WHERE department_rank <= 2;

-- Exercise 19

SELECT *
FROM employee_rankings
WHERE department_rank = 1;

-- Exercise 20

DROP VIEW IF EXISTS customer_order_details;

CREATE VIEW customer_order_details AS
SELECT
c.customer_name,
c.city,
o.order_id,
o.order_date,
o.total_amount
FROM customers AS c
JOIN orders AS o
ON c.customer_id = o.customer_id;

-- Exercise 21

SELECT *
FROM customer_order_details;

-- Exercise 22

SELECT *
FROM customer_order_details
WHERE total_amount > 2000;

-- Exercise 23

DROP VIEW IF EXISTS customer_spending;

CREATE VIEW customer_spending AS
SELECT
c.customer_id,
c.customer_name,
COUNT(o.order_id) AS total_orders,
COALESCE(SUM(o.total_amount), 0) AS total_spending,
COALESCE(AVG(o.total_amount), 0) AS average_order_value
FROM customers AS c
LEFT JOIN orders AS o
ON c.customer_id = o.customer_id
GROUP BY
c.customer_id,
c.customer_name;

-- Exercise 24

SELECT *
FROM customer_spending
ORDER BY total_spending DESC
LIMIT 3;

-- Exercise 25

SELECT *
FROM customer_spending
WHERE total_spending > 3000;

-- Exercise 26

DROP VIEW IF EXISTS salary_report;

CREATE VIEW salary_report AS
SELECT
employee_id,
first_name,
salary
FROM employees;

-- Exercise 27

CREATE OR REPLACE VIEW salary_report AS
SELECT
employee_id,
first_name,
last_name,
salary
FROM employees;

-- Exercise 28

SHOW CREATE VIEW employee_details;

-- Exercise 29

SHOW FULL TABLES;

-- Exercise 30

DROP VIEW IF EXISTS salary_report;

-- Exercise 31

SELECT
department_name,
AVG(salary) AS average_salary
FROM employee_details
GROUP BY department_name;

-- Exercise 32

SELECT
department_name,
AVG(salary) AS average_salary
FROM employee_details
GROUP BY department_name
HAVING AVG(salary) > 60000;

-- Exercise 33

SELECT *
FROM customer_spending
ORDER BY total_spending DESC;

-- Exercise 34

SELECT *
FROM customer_spending
ORDER BY total_spending DESC
LIMIT 1;

-- Exercise 35

SELECT
AVG(total_spending) AS average_customer_spending
FROM customer_spending;

-- Exercise 43

DROP VIEW IF EXISTS employee_average_salary;

CREATE VIEW employee_average_salary AS
SELECT
CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
d.department_name,
e.salary,
AVG(e.salary) OVER (
PARTITION BY e.department_id
) AS department_average
FROM employees AS e
JOIN departments AS d
ON e.department_id = d.department_id;

-- Exercise 44

SELECT *
FROM employee_average_salary
WHERE salary > department_average;

-- Exercise 45

DROP VIEW IF EXISTS customer_performance;

CREATE VIEW customer_performance AS
SELECT
c.customer_name,
c.city,
COUNT(o.order_id) AS total_orders,
COALESCE(SUM(o.total_amount), 0) AS total_spending,
COALESCE(AVG(o.total_amount), 0) AS average_order_value,
COALESCE(MAX(o.total_amount), 0) AS largest_order
FROM customers AS c
LEFT JOIN orders AS o
ON c.customer_id = o.customer_id
GROUP BY
c.customer_id,
c.customer_name,
c.city;

-- Exercise 46

SELECT *
FROM customer_performance
WHERE total_spending > 3000;

-- Exercise 47

DROP VIEW IF EXISTS employee_reporting;

CREATE VIEW employee_reporting AS
SELECT
e.employee_id,
CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
d.department_name,
e.salary,

```
CASE
    WHEN e.salary >= 80000 THEN 'High'
    WHEN e.salary >= 60000 THEN 'Medium'
    ELSE 'Low'
END AS salary_category,

RANK() OVER (
    PARTITION BY e.department_id
    ORDER BY e.salary DESC
) AS department_rank
```

FROM employees AS e
JOIN departments AS d
ON e.department_id = d.department_id;

SELECT *
FROM employee_reporting
WHERE department_rank <= 2;

-- Exercise 48

SELECT *
FROM customer_performance
ORDER BY total_spending DESC
LIMIT 3;
