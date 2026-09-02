-- ============================================================
-- MODULE 19: WINDOW FUNCTIONS
-- solutions.sql
-- ============================================================

USE module19_window_functions;

-- Exercise 1

SELECT
first_name,
salary,
AVG(salary) OVER () AS company_average_salary
FROM employees;

-- Exercise 2

SELECT
first_name,
salary,
SUM(salary) OVER () AS total_salary
FROM employees;

-- Exercise 3

SELECT
first_name,
department_id,
salary,
AVG(salary) OVER (
PARTITION BY department_id
) AS department_average
FROM employees;

-- Exercise 4

SELECT
first_name,
salary,
RANK() OVER (
ORDER BY salary DESC
) AS salary_rank
FROM employees;

-- Exercise 5

SELECT
first_name,
salary,
ROW_NUMBER() OVER (
ORDER BY salary DESC
) AS row_num
FROM employees;

-- Exercise 6

SELECT
first_name,
salary,
DENSE_RANK() OVER (
ORDER BY salary DESC
) AS dense_salary_rank
FROM employees;

-- Exercise 7

SELECT
first_name,
department_id,
salary,
RANK() OVER (
PARTITION BY department_id
ORDER BY salary DESC
) AS department_rank
FROM employees;

-- Exercise 8

SELECT
first_name,
department_id,
salary,
ROW_NUMBER() OVER (
PARTITION BY department_id
ORDER BY salary DESC
) AS department_row_num
FROM employees;

-- Exercise 9

SELECT
order_id,
order_date,
total_amount,
LAG(total_amount) OVER (
ORDER BY order_date
) AS previous_order_amount
FROM orders;

-- Exercise 10

SELECT
order_id,
order_date,
total_amount,
LEAD(total_amount) OVER (
ORDER BY order_date
) AS next_order_amount
FROM orders;

-- Exercise 11

SELECT
order_id,
order_date,
total_amount,
total_amount
- LAG(total_amount) OVER (
ORDER BY order_date
) AS amount_change
FROM orders;

-- Exercise 12

SELECT
order_id,
order_date,
total_amount,
SUM(total_amount) OVER (
ORDER BY order_date
) AS running_total
FROM orders;

-- Exercise 13

SELECT
customer_id,
order_id,
order_date,
total_amount,
SUM(total_amount) OVER (
PARTITION BY customer_id
ORDER BY order_date
) AS customer_running_total
FROM orders;

-- Exercise 14

SELECT
first_name,
department_id,
salary,
MAX(salary) OVER (
PARTITION BY department_id
) AS department_max_salary
FROM employees;

-- Exercise 15

SELECT
first_name,
department_id,
salary,
MIN(salary) OVER (
PARTITION BY department_id
) AS department_min_salary
FROM employees;

-- Exercise 16

SELECT
first_name,
department_id,
salary,
salary
- AVG(salary) OVER (
PARTITION BY department_id
) AS salary_difference
FROM employees;

-- Exercise 17

SELECT
first_name,
salary,
NTILE(4) OVER (
ORDER BY salary DESC
) AS salary_group
FROM employees;

-- Exercise 18

WITH ranked_employees AS (
SELECT
employee_id,
first_name,
department_id,
salary,
ROW_NUMBER() OVER (
PARTITION BY department_id
ORDER BY salary DESC
) AS department_rank
FROM employees
)
SELECT *
FROM ranked_employees
WHERE department_rank = 1;

-- Exercise 19

WITH ranked_employees AS (
SELECT
employee_id,
first_name,
department_id,
salary,
ROW_NUMBER() OVER (
PARTITION BY department_id
ORDER BY salary DESC
) AS department_rank
FROM employees
)
SELECT *
FROM ranked_employees
WHERE department_rank <= 2;

-- Exercise 20

WITH ranked_employees AS (
SELECT
employee_id,
first_name,
salary,
ROW_NUMBER() OVER (
ORDER BY salary DESC
) AS salary_rank
FROM employees
)
SELECT *
FROM ranked_employees
WHERE salary_rank <= 3;

-- Exercise 21

WITH ranked_employees AS (
SELECT
employee_id,
first_name,
salary,
RANK() OVER (
ORDER BY salary DESC
) AS salary_rank
FROM employees
)
SELECT *
FROM ranked_employees
WHERE salary_rank <= 3;

-- Exercise 22

SELECT
first_name,
department_id,
salary,
ROUND(
salary /
SUM(salary) OVER (
PARTITION BY department_id
) * 100,
2
) AS salary_percentage
FROM employees;

-- Exercise 23

SELECT
order_id,
order_date,
total_amount,
AVG(total_amount) OVER (
ORDER BY order_date
ROWS BETWEEN 2 PRECEDING
AND CURRENT ROW
) AS moving_average
FROM orders;

-- Exercise 24

SELECT
customer_id,
order_id,
total_amount,

```
LAG(total_amount) OVER (
    PARTITION BY customer_id
    ORDER BY order_date
) AS previous_order_amount,

total_amount
    - LAG(total_amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS amount_change
```

FROM orders;

-- Exercise 25

SELECT
first_name,
salary,
CASE
WHEN salary >
AVG(salary) OVER (
PARTITION BY department_id
)
THEN 'Above Average'
ELSE 'Below Average'
END AS salary_status
FROM employees;

-- Exercise 26

SELECT
CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
d.department_name,
e.salary,

```
RANK() OVER (
    PARTITION BY e.department_id
    ORDER BY e.salary DESC
) AS department_rank,

AVG(e.salary) OVER (
    PARTITION BY e.department_id
) AS department_average
```

FROM employees AS e
INNER JOIN departments AS d
ON e.department_id = d.department_id;

-- Exercise 27

WITH ranked_employees AS (
SELECT
e.employee_id,
CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
e.department_id,
e.salary,

```
    ROW_NUMBER() OVER (
        PARTITION BY e.department_id
        ORDER BY e.salary DESC
    ) AS department_rank,

    AVG(e.salary) OVER (
        PARTITION BY e.department_id
    ) AS department_average

FROM employees AS e
```

)
SELECT
employee_name,
department_id,
salary,
department_average
FROM ranked_employees
WHERE department_rank = 1;

-- Exercise 28

WITH ranked_employees AS (
SELECT
employee_id,
first_name,
department_id,
salary,
ROW_NUMBER() OVER (
PARTITION BY department_id
ORDER BY salary DESC
) AS department_rank
FROM employees
)
SELECT *
FROM ranked_employees
WHERE department_rank = 2;

-- Exercise 29

WITH employee_analysis AS (
SELECT
employee_id,
first_name,
department_id,
salary,
AVG(salary) OVER (
PARTITION BY department_id
) AS department_average
FROM employees
)
SELECT *
FROM employee_analysis
WHERE salary > department_average;

-- Exercise 30

SELECT
first_name,
department_id,
salary,

```
SUM(salary) OVER (
    PARTITION BY department_id
    ORDER BY salary DESC
    ROWS BETWEEN UNBOUNDED PRECEDING
         AND CURRENT ROW
)
/
SUM(salary) OVER (
    PARTITION BY department_id
) * 100 AS cumulative_salary_percentage
```

FROM employees;

-- Exercise 35

SELECT
CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
d.department_name,
e.salary,

```
RANK() OVER (
    ORDER BY e.salary DESC
) AS company_rank,

RANK() OVER (
    PARTITION BY e.department_id
    ORDER BY e.salary DESC
) AS department_rank,

AVG(e.salary) OVER (
    PARTITION BY e.department_id
) AS department_average,

e.salary
    - AVG(e.salary) OVER (
        PARTITION BY e.department_id
    ) AS salary_difference
```

FROM employees AS e
INNER JOIN departments AS d
ON e.department_id = d.department_id;
