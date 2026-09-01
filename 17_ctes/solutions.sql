-- ============================================================
-- MODULE 17: COMMON TABLE EXPRESSIONS (CTEs)
-- solutions.sql
-- MySQL 8.0+
-- ============================================================

CREATE DATABASE IF NOT EXISTS module17_ctes;

USE module17_ctes;

-- ============================================================
-- EASY
-- ============================================================

---

-- Exercise 1 — Solution

---

WITH high_salary_employees AS (
SELECT
employee_id,
first_name,
last_name,
salary
FROM employees
WHERE salary >= 65000
)
SELECT *
FROM high_salary_employees;

---

-- Exercise 2 — Solution

---

WITH employee_names AS (
SELECT
employee_id,
CONCAT(first_name, ' ', last_name) AS full_name
FROM employees
)
SELECT *
FROM employee_names
ORDER BY full_name ASC;

---

-- Exercise 3 — Solution

---

WITH large_orders AS (
SELECT
order_id,
customer_id,
total_amount
FROM orders
WHERE total_amount > 2000
)
SELECT *
FROM large_orders
ORDER BY total_amount DESC;

---

-- Exercise 4 — Solution

---

WITH selected_employees AS (
SELECT
employee_id,
first_name,
last_name,
salary
FROM employees
WHERE salary BETWEEN 50000 AND 75000
)
SELECT
employee_id,
CONCAT(first_name, ' ', last_name) AS employee_name,
salary
FROM selected_employees
ORDER BY salary DESC;

---

-- Exercise 5 — Solution

---

WITH employee_salary AS (
SELECT
employee_id,
CONCAT(first_name, ' ', last_name) AS employee_name,
salary * 12 AS annual_salary
FROM employees
)
SELECT *
FROM employee_salary
ORDER BY annual_salary DESC;

-- ============================================================
-- MEDIUM
-- ============================================================

---

-- Exercise 6 — Solution

---

WITH department_counts AS (
SELECT
department_id,
COUNT(*) AS employee_count
FROM employees
GROUP BY department_id
)
SELECT
d.department_name,
c.employee_count
FROM departments AS d
INNER JOIN department_counts AS c
ON d.department_id = c.department_id
ORDER BY c.employee_count DESC;

---

-- Exercise 7 — Solution

---

WITH department_salary AS (
SELECT
department_id,
AVG(salary) AS average_salary,
MAX(salary) AS highest_salary
FROM employees
GROUP BY department_id
)
SELECT
department_id,
average_salary,
highest_salary
FROM department_salary
WHERE average_salary > 60000
ORDER BY average_salary DESC;

---

-- Exercise 8 — Solution

---

WITH customer_totals AS (
SELECT
customer_id,
SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id
)
SELECT
c.customer_name,
ct.total_spent
FROM customer_totals AS ct
INNER JOIN customers AS c
ON ct.customer_id = c.customer_id
ORDER BY ct.total_spent DESC;

---

-- Exercise 9 — Solution

---

WITH customer_totals AS (
SELECT
customer_id,
SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id
),
high_value_customers AS (
SELECT
customer_id,
total_spent
FROM customer_totals
WHERE total_spent > 3000
)
SELECT
c.customer_name,
h.total_spent
FROM high_value_customers AS h
INNER JOIN customers AS c
ON h.customer_id = c.customer_id
ORDER BY h.total_spent DESC;

---

-- Exercise 10 — Solution

---

WITH technology_employees AS (
SELECT
e.employee_id,
e.first_name,
e.last_name,
e.salary
FROM employees AS e
INNER JOIN departments AS d
ON e.department_id = d.department_id
WHERE d.department_name = 'Technology'
)
SELECT
employee_id,
first_name,
last_name,
salary
FROM technology_employees
WHERE salary > 70000
ORDER BY salary DESC;

-- ============================================================
-- HARD
-- ============================================================

---

-- Exercise 11 — Solution

---

WITH department_average AS (
SELECT
department_id,
AVG(salary) AS average_salary
FROM employees
GROUP BY department_id
),
company_average AS (
SELECT
AVG(salary) AS average_salary
FROM employees
)
SELECT
d.department_id,
d.average_salary AS department_average,
c.average_salary AS company_average
FROM department_average AS d
CROSS JOIN company_average AS c
WHERE d.average_salary > c.average_salary
ORDER BY d.average_salary DESC;

---

-- Exercise 12 — Solution

---

WITH monthly_orders AS (
SELECT
YEAR(order_date) AS order_year,
MONTH(order_date) AS order_month,
COUNT(*) AS order_count,
SUM(total_amount) AS total_sales
FROM orders
GROUP BY
YEAR(order_date),
MONTH(order_date)
)
SELECT
order_year,
order_month,
order_count,
total_sales
FROM monthly_orders
ORDER BY
order_year,
order_month;

---

-- Exercise 13 — Solution

---

WITH customer_order_counts AS (
SELECT
c.customer_id,
c.customer_name,
COUNT(o.order_id) AS order_count
FROM customers AS c
LEFT JOIN orders AS o
ON c.customer_id = o.customer_id
GROUP BY
c.customer_id,
c.customer_name
)
SELECT
customer_name,
order_count
FROM customer_order_counts
ORDER BY order_count DESC;

---

-- Exercise 14 — Solution

---

WITH overall_average AS (
SELECT
AVG(total_amount) AS average_order_amount
FROM orders
),
expensive_orders AS (
SELECT
o.order_id,
o.order_date,
o.total_amount
FROM orders AS o
CROSS JOIN overall_average AS a
WHERE o.total_amount > a.average_order_amount
)
SELECT *
FROM expensive_orders
ORDER BY total_amount DESC;

---

-- Exercise 15 — Solution

---

WITH department_totals AS (
SELECT
department_id,
SUM(salary) AS total_salary
FROM employees
GROUP BY department_id
),
high_salary_departments AS (
SELECT
department_id,
total_salary
FROM department_totals
WHERE total_salary > 120000
)
SELECT
d.department_name,
h.total_salary
FROM high_salary_departments AS h
INNER JOIN departments AS d
ON h.department_id = d.department_id
ORDER BY h.total_salary DESC;

-- ============================================================
-- ADVANCED BEGINNER
-- ============================================================

---

-- Exercise 16 — Solution

---

WITH customer_totals AS (
SELECT
customer_id,
SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id
),
top_customers AS (
SELECT
customer_id,
total_spent
FROM customer_totals
ORDER BY total_spent DESC
LIMIT 3
)
SELECT
c.customer_name,
t.total_spent
FROM top_customers AS t
INNER JOIN customers AS c
ON t.customer_id = c.customer_id
ORDER BY t.total_spent DESC;

---

-- Exercise 17 — Solution

---

WITH employee_counts AS (
SELECT
department_id,
COUNT(*) AS employee_count
FROM employees
GROUP BY department_id
),
department_details AS (
SELECT
department_id,
department_name
FROM departments
),
department_report AS (
SELECT
d.department_name,
e.employee_count
FROM department_details AS d
INNER JOIN employee_counts AS e
ON d.department_id = e.department_id
)
SELECT
department_name,
employee_count
FROM department_report
ORDER BY employee_count DESC;

---

-- Exercise 18 — Solution

---

WITH employee_salary_data AS (
SELECT
employee_id,
CONCAT(first_name, ' ', last_name) AS employee_name,
salary AS monthly_salary,
salary * 12 AS annual_salary
FROM employees
)
SELECT
employee_id,
employee_name,
monthly_salary,
annual_salary
FROM employee_salary_data
WHERE annual_salary > 800000
ORDER BY annual_salary DESC;

---

-- Exercise 19 — Solution

---

WITH customer_orders AS (
SELECT
c.customer_name,
o.order_id,
o.total_amount
FROM customers AS c
INNER JOIN orders AS o
ON c.customer_id = o.customer_id
),
large_customer_orders AS (
SELECT
customer_name,
order_id,
total_amount
FROM customer_orders
WHERE total_amount > 1500
)
SELECT
customer_name,
order_id,
total_amount
FROM large_customer_orders
ORDER BY total_amount DESC;

---

-- Exercise 20 — Solution

---

WITH employee_report (
employee_id,
employee_name,
annual_salary
) AS (
SELECT
employee_id,
CONCAT(first_name, ' ', last_name),
salary * 12
FROM employees
)
SELECT *
FROM employee_report
ORDER BY annual_salary DESC;

---

-- Exercise 21 — Solution

---

WITH RECURSIVE numbers AS (
SELECT 1 AS number

```
UNION ALL

SELECT number + 1
FROM numbers
WHERE number < 10
```

)
SELECT number
FROM numbers;

---

-- Exercise 22 — Solution

---

WITH RECURSIVE dates AS (
SELECT DATE('2026-04-01') AS report_date

```
UNION ALL

SELECT report_date + INTERVAL 1 DAY
FROM dates
WHERE report_date < '2026-04-05'
```

)
SELECT report_date
FROM dates;

---

-- Exercise 23 — Solution

---

WITH department_summary AS (
SELECT
department_id,
AVG(salary) AS average_salary
FROM employees
GROUP BY department_id
)
SELECT *
FROM department_summary
WHERE average_salary > 60000;

---

-- Exercise 24 — Solution

---

WITH customer_totals AS (
SELECT
customer_id,
SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id
),
average_customer_spending AS (
SELECT
AVG(total_spent) AS average_spending
FROM customer_totals
)
SELECT
c.customer_name,
ct.total_spent
FROM customer_totals AS ct
CROSS JOIN average_customer_spending AS a
INNER JOIN customers AS c
ON ct.customer_id = c.customer_id
WHERE ct.total_spent > a.average_spending
ORDER BY ct.total_spent DESC;
