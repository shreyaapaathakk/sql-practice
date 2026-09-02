-- ============================================================
-- MODULE 20: CTEs
-- solutions.sql
-- ============================================================

USE module20_ctes;

-- Exercise 1

WITH high_salary_employees AS (
SELECT
first_name,
salary
FROM employees
WHERE salary > 60000
)
SELECT *
FROM high_salary_employees;

-- Exercise 2

WITH technology_employees AS (
SELECT
e.employee_id,
e.first_name,
e.salary
FROM employees AS e
WHERE e.department_id = 2
)
SELECT *
FROM technology_employees;

-- Exercise 3

WITH department_averages AS (
SELECT
department_id,
AVG(salary) AS average_salary
FROM employees
GROUP BY department_id
)
SELECT *
FROM department_averages;

-- Exercise 4

WITH department_totals AS (
SELECT
department_id,
SUM(salary) AS total_salary
FROM employees
GROUP BY department_id
)
SELECT *
FROM department_totals;

-- Exercise 5

WITH employee_counts AS (
SELECT
department_id,
COUNT(*) AS employee_count
FROM employees
GROUP BY department_id
)
SELECT *
FROM employee_counts;

-- Exercise 6

WITH department_averages AS (
SELECT
department_id,
AVG(salary) AS department_average
FROM employees
GROUP BY department_id
)
SELECT
e.first_name,
e.salary,
da.department_average
FROM employees AS e
JOIN department_averages AS da
ON e.department_id = da.department_id;

-- Exercise 7

WITH employee_data AS (
SELECT
e.employee_id,
CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
d.department_name,
e.salary
FROM employees AS e
JOIN departments AS d
ON e.department_id = d.department_id
)
SELECT *
FROM employee_data;

-- Exercise 8

WITH employee_analysis AS (
SELECT
e.first_name,
e.salary,
e.department_id,
AVG(e.salary) OVER (
PARTITION BY e.department_id
) AS department_average
FROM employees AS e
)
SELECT *
FROM employee_analysis
WHERE salary > department_average;

-- Exercise 9

WITH department_totals AS (
SELECT
department_id,
SUM(salary) AS total_salary
FROM employees
GROUP BY department_id
)
SELECT *
FROM department_totals
WHERE total_salary > 100000;

-- Exercise 10

WITH employee_counts AS (
SELECT
department_id,
COUNT(*) AS employee_count
FROM employees
GROUP BY department_id
)
SELECT *
FROM employee_counts
WHERE employee_count > 1;

-- Exercise 11

WITH department_totals AS (
SELECT
department_id,
SUM(salary) AS total_salary
FROM employees
GROUP BY department_id
),

ranked_departments AS (
SELECT
department_id,
total_salary,
RANK() OVER (
ORDER BY total_salary DESC
) AS department_rank
FROM department_totals
)

SELECT *
FROM ranked_departments;

-- Exercise 12

WITH customer_totals AS (
SELECT
customer_id,
SUM(total_amount) AS total_spending
FROM orders
GROUP BY customer_id
),

ranked_customers AS (
SELECT
customer_id,
total_spending,
RANK() OVER (
ORDER BY total_spending DESC
) AS spending_rank
FROM customer_totals
)

SELECT *
FROM ranked_customers;

-- Exercise 13

WITH customer_totals AS (
SELECT
customer_id,
SUM(total_amount) AS total_spending
FROM orders
GROUP BY customer_id
),

ranked_customers AS (
SELECT
customer_id,
total_spending,
ROW_NUMBER() OVER (
ORDER BY total_spending DESC
) AS spending_rank
FROM customer_totals
)

SELECT *
FROM ranked_customers
WHERE spending_rank <= 3;

-- Exercise 14

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

-- Exercise 15

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

-- Exercise 16

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

-- Exercise 17

WITH company_average AS (
SELECT
AVG(salary) AS average_salary
FROM employees
)
SELECT
e.first_name,
e.salary
FROM employees AS e
CROSS JOIN company_average AS ca
WHERE e.salary > ca.average_salary;

-- Exercise 18

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

-- Exercise 19

WITH employee_data AS (
SELECT
e.employee_id,
CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
e.department_id,
e.salary,
d.department_name
FROM employees AS e
JOIN departments AS d
ON e.department_id = d.department_id
),

employee_analysis AS (
SELECT
employee_id,
employee_name,
department_name,
department_id,
salary,

```
    RANK() OVER (
        PARTITION BY department_id
        ORDER BY salary DESC
    ) AS department_rank,

    AVG(salary) OVER (
        PARTITION BY department_id
    ) AS department_average

FROM employee_data
```

)

SELECT *
FROM employee_analysis;

-- Exercise 20

WITH customer_totals AS (
SELECT
customer_id,
SUM(total_amount) AS total_spending
FROM orders
GROUP BY customer_id
),

customer_average AS (
SELECT
AVG(total_spending) AS average_spending
FROM customer_totals
)

SELECT
ct.customer_id,
ct.total_spending
FROM customer_totals AS ct
CROSS JOIN customer_average AS ca
WHERE ct.total_spending > ca.average_spending;

-- Exercise 21

WITH department_totals AS (
SELECT
department_id,
SUM(salary) AS total_salary
FROM employees
GROUP BY department_id
),

average_department_total AS (
SELECT
AVG(total_salary) AS average_total
FROM department_totals
)

SELECT
dt.department_id,
dt.total_salary
FROM department_totals AS dt
CROSS JOIN average_department_total AS adt
WHERE dt.total_salary > adt.average_total;

-- Exercise 22

WITH customer_totals AS (
SELECT
customer_id,
SUM(total_amount) AS total_spending
FROM orders
GROUP BY customer_id
),

ranked_customers AS (
SELECT
customer_id,
total_spending,
RANK() OVER (
ORDER BY total_spending DESC
) AS spending_rank
FROM customer_totals
)

SELECT *
FROM ranked_customers
WHERE spending_rank <= 2;

-- Exercise 23

WITH customer_summary AS (
SELECT
customer_id,
COUNT(*) AS total_orders,
SUM(total_amount) AS total_spending,
AVG(total_amount) AS average_order_value
FROM orders
GROUP BY customer_id
)
SELECT *
FROM customer_summary;

-- Exercise 24

WITH employee_status AS (
SELECT
employee_id,
first_name,
salary,
CASE
WHEN salary >= 80000 THEN 'High'
WHEN salary >= 60000 THEN 'Medium'
ELSE 'Low'
END AS salary_category
FROM employees
)
SELECT *
FROM employee_status;

-- Exercise 25

WITH employee_status AS (
SELECT
employee_id,
first_name,
salary,
CASE
WHEN salary >= 80000 THEN 'High'
WHEN salary >= 60000 THEN 'Medium'
ELSE 'Low'
END AS salary_category
FROM employees
)
SELECT
salary_category,
COUNT(*) AS employee_count
FROM employee_status
GROUP BY salary_category;

-- Exercise 26

WITH RECURSIVE numbers AS (
SELECT 1 AS n

```
UNION ALL

SELECT n + 1
FROM numbers
WHERE n < 10
```

)
SELECT *
FROM numbers;

-- Exercise 27

WITH RECURSIVE numbers AS (
SELECT 1 AS n

```
UNION ALL

SELECT n + 1
FROM numbers
WHERE n < 100
```

)
SELECT *
FROM numbers;

-- Exercise 28

WITH RECURSIVE dates AS (
SELECT DATE('2026-01-01') AS date_value

```
UNION ALL

SELECT date_value + INTERVAL 1 DAY
FROM dates
WHERE date_value < '2026-01-10'
```

)
SELECT *
FROM dates;

-- Exercise 29

WITH RECURSIVE months AS (
SELECT
DATE('2026-01-01') AS month_start

```
UNION ALL

SELECT
    month_start + INTERVAL 1 MONTH
FROM months
WHERE month_start < '2026-12-01'
```

)
SELECT *
FROM months;

-- Exercise 30

WITH RECURSIVE employee_hierarchy AS (

```
SELECT
    employee_id,
    first_name,
    manager_id,
    0 AS hierarchy_level
FROM employees
WHERE manager_id IS NULL

UNION ALL

SELECT
    e.employee_id,
    e.first_name,
    e.manager_id,
    eh.hierarchy_level + 1
FROM employees AS e
JOIN employee_hierarchy AS eh
    ON e.manager_id = eh.employee_id
```

)

SELECT
employee_id,
first_name,
manager_id,
hierarchy_level
FROM employee_hierarchy
ORDER BY hierarchy_level, employee_id;

-- Exercise 31

WITH employee_data AS (
SELECT
e.employee_id,
CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
e.department_id,
e.salary,
d.department_name
FROM employees AS e
JOIN departments AS d
ON e.department_id = d.department_id
),

employee_analysis AS (
SELECT
employee_id,
employee_name,
department_id,
department_name,
salary,

```
    RANK() OVER (
        PARTITION BY department_id
        ORDER BY salary DESC
    ) AS department_rank,

    AVG(salary) OVER (
        PARTITION BY department_id
    ) AS department_average

FROM employee_data
```

),

final_analysis AS (
SELECT
*,
salary - department_average AS salary_difference
FROM employee_analysis
)

SELECT *
FROM final_analysis;

-- Exercise 32

WITH employee_analysis AS (
SELECT
e.employee_id,
CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
d.department_name,
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
JOIN departments AS d
    ON e.department_id = d.department_id
```

),

top_employees AS (
SELECT
employee_name,
department_name,
salary,
department_average,
salary - department_average AS difference_from_average
FROM employee_analysis
WHERE department_rank = 1
)

SELECT *
FROM top_employees;

-- Exercise 33

WITH ranked_employees AS (
SELECT
employee_id,
first_name,
department_id,
salary,

```
    ROW_NUMBER() OVER (
        PARTITION BY department_id
        ORDER BY salary DESC
    ) AS department_rank

FROM employees
```

)

SELECT *
FROM ranked_employees
WHERE department_rank = 2;

-- Exercise 34

WITH customer_totals AS (
SELECT
customer_id,
SUM(total_amount) AS total_spending
FROM orders
GROUP BY customer_id
),

ranked_customers AS (
SELECT
customer_id,
total_spending,

```
    RANK() OVER (
        ORDER BY total_spending DESC
    ) AS spending_rank

FROM customer_totals
```

)

SELECT
c.customer_name,
rc.total_spending,
rc.spending_rank
FROM ranked_customers AS rc
JOIN customers AS c
ON rc.customer_id = c.customer_id
WHERE rc.spending_rank <= 3;

-- Exercise 35

WITH customer_totals AS (
SELECT
customer_id,
SUM(total_amount) AS total_spending
FROM orders
GROUP BY customer_id
),

customer_average AS (
SELECT
AVG(total_spending) AS average_spending
FROM customer_totals
)

SELECT
c.customer_name,
ct.total_spending
FROM customer_totals AS ct
JOIN customers AS c
ON ct.customer_id = c.customer_id
CROSS JOIN customer_average AS ca
WHERE ct.total_spending > ca.average_spending;

-- Exercise 41

WITH employee_data AS (
SELECT
e.employee_id,
CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
e.department_id,
e.salary,
d.department_name
FROM employees AS e
JOIN departments AS d
ON e.department_id = d.department_id
),

employee_analysis AS (
SELECT
employee_id,
employee_name,
department_id,
department_name,
salary,

```
    RANK() OVER (
        PARTITION BY department_id
        ORDER BY salary DESC
    ) AS department_rank,

    AVG(salary) OVER (
        PARTITION BY department_id
    ) AS department_average,

    SUM(salary) OVER (
        PARTITION BY department_id
    ) AS department_total_salary

FROM employee_data
```

),

final_analysis AS (
SELECT
employee_name,
department_name,
salary,
department_rank,
department_average,
department_total_salary,
salary - department_average AS salary_difference,

```
    CASE
        WHEN salary > department_average
            THEN 'Above Average'
        ELSE 'Below Average'
    END AS salary_status

FROM employee_analysis
```

)

SELECT *
FROM final_analysis;

-- Exercise 42

WITH customer_summary AS (
SELECT
customer_id,
COUNT(*) AS total_orders,
SUM(total_amount) AS total_spending,
AVG(total_amount) AS average_order_value
FROM orders
GROUP BY customer_id
),

ranked_customers AS (
SELECT
customer_id,
total_orders,
total_spending,
average_order_value,

```
    RANK() OVER (
        ORDER BY total_spending DESC
    ) AS spending_rank

FROM customer_summary
```

)

SELECT
c.customer_name,
rc.total_orders,
rc.total_spending,
rc.average_order_value,
rc.spending_rank
FROM ranked_customers AS rc
JOIN customers AS c
ON rc.customer_id = c.customer_id
ORDER BY rc.spending_rank;
