-- ============================================================
-- MODULE 18: CASE EXPRESSIONS
-- solutions.sql
-- MySQL 8.0+
-- ============================================================

CREATE DATABASE IF NOT EXISTS module18_case_expressions;

USE module18_case_expressions;

-- ============================================================
-- EASY
-- ============================================================

---

-- Exercise 1 — Solution

---

SELECT
first_name,
salary,
CASE
WHEN salary >= 70000 THEN 'High'
WHEN salary >= 50000 THEN 'Medium'
ELSE 'Low'
END AS salary_level
FROM employees;

---

-- Exercise 2 — Solution

---

SELECT
first_name,
CASE department_id
WHEN 1 THEN 'Sales'
WHEN 2 THEN 'Technology'
WHEN 3 THEN 'Human Resources'
WHEN 4 THEN 'Finance'
ELSE 'Unknown'
END AS department_name
FROM employees;

---

-- Exercise 3 — Solution

---

SELECT
first_name,
hire_date,
CASE
WHEN hire_date < '2022-01-01' THEN 'Experienced'
WHEN hire_date < '2024-01-01' THEN 'Recent'
ELSE 'New'
END AS employee_type
FROM employees;

---

-- Exercise 4 — Solution

---

SELECT
first_name,
CASE
WHEN email IS NULL THEN 'Missing Email'
ELSE 'Available'
END AS email_status
FROM employees;

---

-- Exercise 5 — Solution

---

SELECT
order_id,
total_amount,
CASE
WHEN total_amount >= 3000 THEN 'Large'
WHEN total_amount >= 1500 THEN 'Medium'
ELSE 'Small'
END AS order_size
FROM orders;

-- ============================================================
-- MEDIUM
-- ============================================================

---

-- Exercise 6 — Solution

---

SELECT
SUM(
CASE
WHEN salary >= 60000 THEN 1
ELSE 0
END
) AS high_salary_count
FROM employees;

---

-- Exercise 7 — Solution

---

SELECT
SUM(
CASE
WHEN salary >= 60000 THEN salary
ELSE 0
END
) AS high_salary_total
FROM employees;

---

-- Exercise 8 — Solution

---

SELECT
department_id,

```
SUM(
    CASE
        WHEN salary >= 60000 THEN 1
        ELSE 0
    END
) AS high_salary_count,

SUM(
    CASE
        WHEN salary < 60000 THEN 1
        ELSE 0
    END
) AS low_salary_count
```

FROM employees
GROUP BY department_id;

---

-- Exercise 9 — Solution

---

SELECT
CONCAT(first_name, ' ', last_name) AS employee_name,
salary,
CASE
WHEN salary >= 80000 THEN 'A'
WHEN salary >= 60000 THEN 'B'
WHEN salary >= 50000 THEN 'C'
ELSE 'D'
END AS salary_band
FROM employees;

---

-- Exercise 10 — Solution

---

SELECT
CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
d.department_name,
CASE
WHEN d.department_name = 'Technology'
THEN 'Technical'
ELSE 'Non-Technical'
END AS department_type
FROM employees AS e
INNER JOIN departments AS d
ON e.department_id = d.department_id;

---

-- Exercise 11 — Solution

---

SELECT
AVG(
CASE
WHEN department_id = 2 THEN salary
END
) AS technology_average_salary
FROM employees;

---

-- Exercise 12 — Solution

---

SELECT
CASE
WHEN salary >= 70000 THEN 'High'
WHEN salary >= 50000 THEN 'Medium'
ELSE 'Low'
END AS salary_level,
COUNT(*) AS employee_count
FROM employees
GROUP BY
CASE
WHEN salary >= 70000 THEN 'High'
WHEN salary >= 50000 THEN 'Medium'
ELSE 'Low'
END
ORDER BY employee_count DESC;

-- ============================================================
-- HARD
-- ============================================================

---

-- Exercise 13 — Solution

---

SELECT
department_id,

```
SUM(
    CASE
        WHEN salary >= 70000 THEN 1
        ELSE 0
    END
) AS high_salary_count,

SUM(
    CASE
        WHEN salary BETWEEN 50000 AND 69999 THEN 1
        ELSE 0
    END
) AS medium_salary_count,

SUM(
    CASE
        WHEN salary < 50000 THEN 1
        ELSE 0
    END
) AS low_salary_count
```

FROM employees
GROUP BY department_id;

---

-- Exercise 14 — Solution

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
ct.total_spent,
CASE
WHEN ct.total_spent >= 4000 THEN 'Premium'
WHEN ct.total_spent >= 2500 THEN 'Standard'
ELSE 'Basic'
END AS customer_segment
FROM customer_totals AS ct
INNER JOIN customers AS c
ON ct.customer_id = c.customer_id
ORDER BY ct.total_spent DESC;

---

-- Exercise 15 — Solution

---

WITH employee_categories AS (
SELECT
employee_id,
CONCAT(first_name, ' ', last_name) AS employee_name,
CASE
WHEN salary >= 70000 THEN 'High'
WHEN salary >= 50000 THEN 'Medium'
ELSE 'Low'
END AS salary_level
FROM employees
)
SELECT
salary_level,
COUNT(*) AS employee_count
FROM employee_categories
GROUP BY salary_level
ORDER BY employee_count DESC;

---

-- Exercise 16 — Solution

---

SELECT
department_id,
COUNT(*) AS total_employees,

```
SUM(
    CASE
        WHEN salary >= 60000 THEN 1
        ELSE 0
    END
) AS high_salary_employees,

ROUND(
    SUM(
        CASE
            WHEN salary >= 60000 THEN 1
            ELSE 0
        END
    ) * 100.0 / COUNT(*),
    2
) AS high_salary_percentage
```

FROM employees
GROUP BY department_id;

---

-- Exercise 17 — Solution

---

SELECT
CASE
WHEN total_amount >= 3000 THEN 'Large'
WHEN total_amount >= 1500 THEN 'Medium'
ELSE 'Small'
END AS order_category,
COUNT(*) AS order_count
FROM orders
GROUP BY
CASE
WHEN total_amount >= 3000 THEN 'Large'
WHEN total_amount >= 1500 THEN 'Medium'
ELSE 'Small'
END;

---

-- Exercise 18 — Solution

---

SELECT
CASE
WHEN total_amount >= 3000 THEN 'Large'
WHEN total_amount >= 1500 THEN 'Medium'
ELSE 'Small'
END AS order_category,
COUNT(*) AS order_count,
SUM(total_amount) AS total_sales
FROM orders
GROUP BY
CASE
WHEN total_amount >= 3000 THEN 'Large'
WHEN total_amount >= 1500 THEN 'Medium'
ELSE 'Small'
END
ORDER BY total_sales DESC;

-- ============================================================
-- ADVANCED BEGINNER
-- ============================================================

---

-- Exercise 19 — Solution

---

WITH customer_totals AS (
SELECT
customer_id,
SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id
),
customer_segments AS (
SELECT
customer_id,
total_spent,
CASE
WHEN total_spent >= 4000 THEN 'Premium'
WHEN total_spent >= 2500 THEN 'Standard'
ELSE 'Basic'
END AS customer_segment
FROM customer_totals
)
SELECT
customer_segment,
COUNT(*) AS customer_count,
SUM(total_spent) AS total_segment_sales
FROM customer_segments
GROUP BY customer_segment
ORDER BY total_segment_sales DESC;

---

-- Exercise 20 — Solution

---

SELECT
AVG(
CASE
WHEN total_amount >= 3000 THEN total_amount
END
) AS large_average_order,

```
AVG(
    CASE
        WHEN total_amount >= 1500
         AND total_amount < 3000
        THEN total_amount
    END
) AS medium_average_order,

AVG(
    CASE
        WHEN total_amount < 1500 THEN total_amount
    END
) AS small_average_order
```

FROM orders;

---

-- Exercise 21 — Solution

---

SELECT
CONCAT(first_name, ' ', last_name) AS employee_name,
salary,
CASE
WHEN salary >= 70000
AND department_id = 2
THEN 'Senior Technology'
WHEN salary >= 70000
THEN 'Senior Employee'
WHEN salary >= 50000
THEN 'Mid-Level Employee'
ELSE 'Junior Employee'
END AS employee_category
FROM employees;

---

-- Exercise 22 — Solution

---

SELECT
CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
d.department_name,
e.salary
FROM employees AS e
INNER JOIN departments AS d
ON e.department_id = d.department_id
ORDER BY
CASE d.department_name
WHEN 'Technology' THEN 1
WHEN 'Sales' THEN 2
WHEN 'Finance' THEN 3
WHEN 'Human Resources' THEN 4
ELSE 5
END,
e.salary DESC;

---

-- Exercise 23 — Solution

---

WITH employee_categories AS (
SELECT
employee_id,
first_name,
last_name,
department_id,
CASE
WHEN salary >= 70000 THEN 'High'
WHEN salary >= 50000 THEN 'Medium'
ELSE 'Low'
END AS salary_level
FROM employees
)
SELECT
CONCAT(first_name, ' ', last_name) AS employee_name,
salary_level,
CASE
WHEN salary_level = 'High'
AND department_id = 2
THEN 'Priority'
WHEN salary_level = 'High'
THEN 'High Value'
ELSE 'Standard'
END AS final_category
FROM employee_categories;

---

-- Exercise 24 — Solution

---

SELECT
d.department_name,
COUNT(e.employee_id) AS total_employees,
AVG(e.salary) AS average_salary,

```
SUM(
    CASE
        WHEN e.salary >= 60000 THEN 1
        ELSE 0
    END
) AS high_salary_count,

CASE
    WHEN AVG(e.salary) >= 70000 THEN 'High Paying'
    WHEN AVG(e.salary) >= 55000 THEN 'Moderate'
    ELSE 'Low Paying'
END AS salary_status
```

FROM departments AS d
LEFT JOIN employees AS e
ON d.department_id = e.department_id
GROUP BY
d.department_id,
d.department_name
ORDER BY average_salary DESC;

-- ============================================================
-- CHALLENGE PREPARATION
-- ============================================================

---

-- Exercise 25 — Solution

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
c.city,
ct.total_spent,
CASE
WHEN ct.total_spent >= 4000 THEN 'Premium'
WHEN ct.total_spent >= 2500 THEN 'Standard'
WHEN ct.total_spent >= 1500 THEN 'Regular'
ELSE 'Basic'
END AS customer_segment
FROM customer_totals AS ct
INNER JOIN customers AS c
ON ct.customer_id = c.customer_id
ORDER BY
CASE
WHEN ct.total_spent >= 4000 THEN 1
WHEN ct.total_spent >= 2500 THEN 2
WHEN ct.total_spent >= 1500 THEN 3
ELSE 4
END,
ct.total_spent DESC;

---

-- Exercise 26 — Solution

---

SELECT
CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
d.department_name,
e.salary,

```
CASE
    WHEN e.salary >= 80000 THEN 'A'
    WHEN e.salary >= 70000 THEN 'B'
    WHEN e.salary >= 60000 THEN 'C'
    WHEN e.salary >= 50000 THEN 'D'
    ELSE 'E'
END AS salary_band,

CASE
    WHEN d.department_name = 'Technology'
         AND e.salary >= 70000
        THEN 'Critical'
    WHEN d.department_name = 'Technology'
         AND e.salary >= 60000
        THEN 'High'
    ELSE 'Normal'
END AS salary_priority
```

FROM employees AS e
INNER JOIN departments AS d
ON e.department_id = d.department_id
ORDER BY e.salary DESC;
