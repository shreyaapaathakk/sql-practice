SQL

```
/*
File: 36_sql_interview_practice/solutions.sql
Module 36: SQL Interview Practice

Requires the setup from practice.sql.
*/

-- ============================================================
-- SOLUTION 1: SECOND-HIGHEST DISTINCT SALARY
-- ============================================================

SELECT MAX(salary) AS second_highest_salary
FROM practice_employees
WHERE salary < (
    SELECT MAX(salary)
    FROM practice_employees
);


-- ============================================================
-- SOLUTION 2: HIGHEST-PAID EMPLOYEE PER DEPARTMENT
-- Include ties.
-- ============================================================

WITH ranked_employees AS (
    SELECT
        employee_id,
        employee_name,
        department,
        salary,
        DENSE_RANK() OVER (
            PARTITION BY department
            ORDER BY salary DESC
        ) AS salary_rank
    FROM practice_employees
)
SELECT
    employee_id,
    employee_name,
    department,
    salary
FROM ranked_employees
WHERE salary_rank = 1
ORDER BY department, employee_id;


-- ============================================================
-- SOLUTION 3: CUSTOMERS WITHOUT ORDERS
-- ============================================================

SELECT
    c.customer_id,
    c.customer_name
FROM practice_customers AS c
LEFT JOIN practice_orders AS o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL
ORDER BY c.customer_id;


-- ============================================================
-- SOLUTION 4: DEPARTMENT SALARY SUMMARY
-- ============================================================

SELECT
    department,
    COUNT(*) AS employee_count,
    AVG(salary) AS average_salary
FROM practice_employees
GROUP BY department
HAVING COUNT(*) >= 2
   AND AVG(salary) > 60000
ORDER BY department;


-- ============================================================
-- SOLUTION 5: RUNNING ORDER TOTAL
-- ============================================================

SELECT
    order_id,
    order_date,
    amount,
    SUM(amount) OVER (
        ORDER BY order_date, order_id
        ROWS BETWEEN UNBOUNDED PRECEDING
                 AND CURRENT ROW
    ) AS running_total
FROM practice_orders
ORDER BY order_date, order_id;


-- ============================================================
-- SOLUTION 6: MONTHLY REVENUE
-- ============================================================

WITH monthly_revenue AS (
    SELECT
        DATE_FORMAT(order_date, '%Y-%m') AS order_month,
        SUM(amount) AS revenue
    FROM practice_orders
    GROUP BY DATE_FORMAT(order_date, '%Y-%m')
)
SELECT
    order_month,
    revenue,
    LAG(revenue) OVER (
        ORDER BY order_month
    ) AS previous_revenue
FROM monthly_revenue
ORDER BY order_month;


-- ============================================================
-- CLEANUP
-- ============================================================

DROP TEMPORARY TABLE IF EXISTS practice_orders;
DROP TEMPORARY TABLE IF EXISTS practice_employees;
DROP TEMPORARY TABLE IF EXISTS practice_customers;
```

Once Module 36 is complete, we'll move to Module 37 and finish the planned 37-module learning roadmap for `sql-practice`.
