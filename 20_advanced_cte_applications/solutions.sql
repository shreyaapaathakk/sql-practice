```sql
-- ============================================================
-- MODULE 20: ADVANCED CTE APPLICATIONS
-- solutions.sql
-- ============================================================

USE module20_advanced_cte;


-- ============================================================
-- Exercise 1
-- ============================================================

WITH active_customers AS (
    SELECT *
    FROM customers
    WHERE status = 'ACTIVE'
),
customer_totals AS (
    SELECT
        customer_id,
        SUM(total_amount) AS total_spent
    FROM orders
    GROUP BY customer_id
)
SELECT
    c.customer_name,
    t.total_spent
FROM active_customers c
JOIN customer_totals t
    ON c.customer_id = t.customer_id;


-- ============================================================
-- Exercise 2
-- ============================================================

WITH active_customers AS (
    SELECT *
    FROM customers
    WHERE status = 'ACTIVE'
),
customer_totals AS (
    SELECT
        customer_id,
        SUM(total_amount) AS total_spent
    FROM orders
    GROUP BY customer_id
),
high_value_customers AS (
    SELECT
        c.customer_id,
        c.customer_name,
        t.total_spent
    FROM active_customers c
    JOIN customer_totals t
        ON c.customer_id = t.customer_id
    WHERE t.total_spent >= 10000
)
SELECT *
FROM high_value_customers
ORDER BY total_spent DESC;


-- ============================================================
-- Exercise 3
-- ============================================================

WITH active_employees AS (
    SELECT *
    FROM employees
    WHERE status = 'ACTIVE'
),
department_salary AS (
    SELECT
        department_id,
        COUNT(*) AS employee_count,
        SUM(salary) AS total_salary
    FROM active_employees
    GROUP BY department_id
),
department_report AS (
    SELECT
        d.department_name,
        s.employee_count,
        s.total_salary
    FROM departments d
    JOIN department_salary s
        ON d.department_id = s.department_id
)
SELECT *
FROM department_report
ORDER BY total_salary DESC;


-- ============================================================
-- Exercise 4
-- ============================================================

WITH customer_totals AS (
    SELECT
        customer_id,
        SUM(total_amount) AS total_spent
    FROM orders
    GROUP BY customer_id
)
SELECT
    c.customer_name,
    t.total_spent
FROM customer_totals t
JOIN customers c
    ON c.customer_id = t.customer_id
WHERE t.total_spent > 10000
ORDER BY t.total_spent DESC;


-- ============================================================
-- Exercise 5
-- ============================================================

WITH department_statistics AS (
    SELECT
        department_id,
        COUNT(*) AS employee_count,
        AVG(salary) AS average_salary,
        MIN(salary) AS minimum_salary,
        MAX(salary) AS maximum_salary,
        SUM(salary) AS total_salary
    FROM employees
    WHERE status = 'ACTIVE'
    GROUP BY department_id
)
SELECT
    d.department_name,
    s.*
FROM department_statistics s
JOIN departments d
    ON d.department_id = s.department_id;


-- ============================================================
-- Exercise 6
-- ============================================================

WITH department_totals AS (
    SELECT
        department_id,
        SUM(salary) AS total_salary
    FROM employees
    WHERE status = 'ACTIVE'
    GROUP BY department_id
),
department_average AS (
    SELECT
        AVG(total_salary) AS average_department_salary
    FROM department_totals
)
SELECT
    d.department_name,
    t.total_salary
FROM department_totals t
JOIN departments d
    ON d.department_id = t.department_id
CROSS JOIN department_average a
WHERE t.total_salary > a.average_department_salary
ORDER BY t.total_salary DESC;


-- ============================================================
-- Exercise 7
-- ============================================================

WITH customer_totals AS (
    SELECT
        customer_id,
        SUM(total_amount) AS total_spent
    FROM orders
    GROUP BY customer_id
)
SELECT
    c.customer_name,
    t.total_spent,
    CASE
        WHEN t.total_spent >= 20000 THEN 'VIP'
        WHEN t.total_spent >= 10000 THEN 'PREMIUM'
        WHEN t.total_spent >= 5000 THEN 'REGULAR'
        ELSE 'LOW'
    END AS customer_category
FROM customer_totals t
JOIN customers c
    ON c.customer_id = t.customer_id;


-- ============================================================
-- Exercise 8
-- ============================================================

WITH classified_customers AS (
    SELECT
        customer_id,
        CASE
            WHEN SUM(total_amount) >= 20000 THEN 'VIP'
            WHEN SUM(total_amount) >= 10000 THEN 'PREMIUM'
            WHEN SUM(total_amount) >= 5000 THEN 'REGULAR'
            ELSE 'LOW'
        END AS customer_category
    FROM orders
    GROUP BY customer_id
)
SELECT
    customer_category,
    COUNT(*) AS customer_count
FROM classified_customers
GROUP BY customer_category;


-- ============================================================
-- Exercise 9
-- ============================================================

WITH ranked_employees AS (
    SELECT
        employee_id,
        employee_name,
        department_id,
        salary,
        RANK() OVER (
            PARTITION BY department_id
            ORDER BY salary DESC
        ) AS salary_rank
    FROM employees
)
SELECT *
FROM ranked_employees
ORDER BY department_id, salary_rank;


-- ============================================================
-- Exercise 10
-- ============================================================

WITH ranked_employees AS (
    SELECT
        employee_id,
        employee_name,
        department_id,
        salary,
        RANK() OVER (
            PARTITION BY department_id
            ORDER BY salary DESC
        ) AS salary_rank
    FROM employees
)
SELECT *
FROM ranked_employees
WHERE salary_rank <= 2;


-- ============================================================
-- Exercise 11
-- ============================================================

WITH ranked_employees AS (
    SELECT
        employee_id,
        employee_name,
        department_id,
        salary,
        ROW_NUMBER() OVER (
            PARTITION BY department_id
            ORDER BY salary DESC
        ) AS row_num
    FROM employees
)
SELECT *
FROM ranked_employees
WHERE row_num = 1;


-- ============================================================
-- Exercise 12
-- ============================================================

WITH ranked_employees AS (
    SELECT
        employee_id,
        employee_name,
        department_id,
        salary,
        ROW_NUMBER() OVER (
            PARTITION BY department_id
            ORDER BY salary DESC
        ) AS salary_position
    FROM employees
)
SELECT *
FROM ranked_employees
ORDER BY department_id, salary_position;


-- ============================================================
-- Exercise 13
-- ============================================================

WITH customer_totals AS (
    SELECT
        customer_id,
        SUM(total_amount) AS total_spent
    FROM orders
    GROUP BY customer_id
),
customer_statistics AS (
    SELECT
        AVG(total_spent) AS average_spending,
        MAX(total_spent) AS highest_spending,
        MIN(total_spent) AS lowest_spending
    FROM customer_totals
)
SELECT
    c.customer_name,
    t.total_spent,
    s.average_spending,
    s.highest_spending,
    s.lowest_spending
FROM customer_totals t
JOIN customers c
    ON c.customer_id = t.customer_id
CROSS JOIN customer_statistics s;


-- ============================================================
-- Exercise 14
-- ============================================================

WITH customer_totals AS (
    SELECT
        customer_id,
        SUM(total_amount) AS total_spent
    FROM orders
    GROUP BY customer_id
),
customer_average AS (
    SELECT
        AVG(total_spent) AS average_spending
    FROM customer_totals
)
SELECT
    c.customer_name,
    t.total_spent
FROM customer_totals t
JOIN customers c
    ON c.customer_id = t.customer_id
CROSS JOIN customer_average a
WHERE t.total_spent > a.average_spending
ORDER BY t.total_spent DESC;


-- ============================================================
-- Exercise 15
-- ============================================================

WITH department_totals AS (
    SELECT
        department_id,
        SUM(salary) AS department_salary
    FROM employees
    WHERE status = 'ACTIVE'
    GROUP BY department_id
),
company_total AS (
    SELECT
        SUM(department_salary) AS total_salary
    FROM department_totals
)
SELECT
    d.department_name,
    t.department_salary,
    ROUND(
        t.department_salary / c.total_salary * 100,
        2
    ) AS salary_percentage
FROM department_totals t
JOIN departments d
    ON d.department_id = t.department_id
CROSS JOIN company_total c
ORDER BY salary_percentage DESC;


-- ============================================================
-- Exercise 16
-- ============================================================

WITH daily_sales AS (
    SELECT
        order_date,
        SUM(total_amount) AS daily_revenue
    FROM orders
    GROUP BY order_date
)
SELECT
    order_date,
    daily_revenue,
    SUM(daily_revenue) OVER (
        ORDER BY order_date
    ) AS running_revenue
FROM daily_sales
ORDER BY order_date;


-- ============================================================
-- Exercise 17
-- ============================================================

WITH daily_sales AS (
    SELECT
        order_date,
        SUM(total_amount) AS daily_revenue
    FROM orders
    GROUP BY order_date
)
SELECT
    order_date,
    daily_revenue,
    LAG(daily_revenue) OVER (
        ORDER BY order_date
    ) AS previous_revenue
FROM daily_sales;


-- ============================================================
-- Exercise 18
-- ============================================================

WITH daily_sales AS (
    SELECT
        order_date,
        SUM(total_amount) AS daily_revenue
    FROM orders
    GROUP BY order_date
),
comparison AS (
    SELECT
        order_date,
        daily_revenue,
        LAG(daily_revenue) OVER (
            ORDER BY order_date
        ) AS previous_revenue
    FROM daily_sales
)
SELECT
    order_date,
    daily_revenue,
    previous_revenue,
    daily_revenue - previous_revenue AS revenue_change
FROM comparison;


-- ============================================================
-- Exercise 19
-- ============================================================

WITH monthly_sales AS (
    SELECT
        YEAR(order_date) AS sales_year,
        MONTH(order_date) AS sales_month,
        SUM(total_amount) AS revenue
    FROM orders
    GROUP BY
        YEAR(order_date),
        MONTH(order_date)
)
SELECT *
FROM monthly_sales
ORDER BY sales_year, sales_month;


-- ============================================================
-- Exercise 20
-- ============================================================

WITH monthly_sales AS (
    SELECT
        YEAR(order_date) AS sales_year,
        MONTH(order_date) AS sales_month,
        SUM(total_amount) AS revenue
    FROM orders
    GROUP BY
        YEAR(order_date),
        MONTH(order_date)
),
ranked_months AS (
    SELECT
        *,
        RANK() OVER (
            ORDER BY revenue DESC
        ) AS revenue_rank
    FROM monthly_sales
)
SELECT *
FROM ranked_months
ORDER BY revenue_rank;


-- ============================================================
-- Exercise 21
-- ============================================================

WITH duplicate_emails AS (
    SELECT
        email,
        COUNT(*) AS email_count
    FROM customers
    GROUP BY email
)
SELECT *
FROM duplicate_emails
WHERE email_count > 1;


-- ============================================================
-- Exercise 22
-- ============================================================

WITH invalid_employees AS (
    SELECT *
    FROM employees
    WHERE salary <= 0
)
SELECT *
FROM invalid_employees;


-- ============================================================
-- Exercise 23
-- ============================================================

WITH missing_email AS (
    SELECT
        employee_id,
        employee_name,
        'MISSING EMAIL' AS issue
    FROM employees
    WHERE email IS NULL
),
invalid_salary AS (
    SELECT
        employee_id,
        employee_name,
        'INVALID SALARY' AS issue
    FROM employees
    WHERE salary <= 0
)
SELECT *
FROM missing_email

UNION ALL

SELECT *
FROM invalid_salary;


-- ============================================================
-- Exercise 24
-- ============================================================

WITH RECURSIVE numbers AS (
    SELECT 1 AS number

    UNION ALL

    SELECT number + 1
    FROM numbers
    WHERE number < 20
)
SELECT *
FROM numbers;


-- ============================================================
-- Exercise 25
-- ============================================================

WITH RECURSIVE even_numbers AS (
    SELECT 2 AS number

    UNION ALL

    SELECT number + 2
    FROM even_numbers
    WHERE number < 20
)
SELECT *
FROM even_numbers;


-- ============================================================
-- Exercise 26
-- ============================================================

WITH RECURSIVE dates AS (
    SELECT DATE('2026-01-01') AS order_date

    UNION ALL

    SELECT order_date + INTERVAL 1 DAY
    FROM dates
    WHERE order_date < '2026-01-10'
)
SELECT *
FROM dates;


-- ============================================================
-- Exercise 27
-- ============================================================

WITH RECURSIVE employee_hierarchy AS (
    SELECT
        employee_id,
        employee_name,
        manager_id,
        0 AS hierarchy_level
    FROM employees
    WHERE manager_id IS NULL

    UNION ALL

    SELECT
        e.employee_id,
        e.employee_name,
        e.manager_id,
        h.hierarchy_level + 1
    FROM employees e
    JOIN employee_hierarchy h
        ON e.manager_id = h.employee_id
)
SELECT *
FROM employee_hierarchy
ORDER BY hierarchy_level, employee_id;


-- ============================================================
-- Exercise 28
-- ============================================================

WITH RECURSIVE employee_hierarchy AS (
    SELECT
        employee_id,
        employee_name,
        manager_id,
        0 AS hierarchy_level
    FROM employees
    WHERE manager_id IS NULL

    UNION ALL

    SELECT
        e.employee_id,
        e.employee_name,
        e.manager_id,
        h.hierarchy_level + 1
    FROM employees e
    JOIN employee_hierarchy h
        ON e.manager_id = h.employee_id
)
SELECT *
FROM employee_hierarchy
WHERE hierarchy_level > 0
ORDER BY hierarchy_level, employee_id;


-- ============================================================
-- Exercise 29
-- ============================================================

WITH customer_totals AS (
    SELECT
        customer_id,
        COUNT(*) AS order_count,
        SUM(total_amount) AS total_spent
    FROM orders
    GROUP BY customer_id
),
customer_average AS (
    SELECT
        AVG(total_spent) AS average_spending
    FROM customer_totals
),
classified_customers AS (
    SELECT
        customer_id,
        order_count,
        total_spent,
        CASE
            WHEN total_spent >= 20000 THEN 'VIP'
            WHEN total_spent >= 10000 THEN 'PREMIUM'
            ELSE 'STANDARD'
        END AS customer_category
    FROM customer_totals
),
ranked_customers AS (
    SELECT
        *,
        RANK() OVER (
            ORDER BY total_spent DESC
        ) AS spending_rank
    FROM classified_customers
)
SELECT
    c.customer_name,
    r.order_count,
    r.total_spent,
    r.customer_category,
    r.spending_rank
FROM ranked_customers r
JOIN customers c
    ON c.customer_id = r.customer_id
CROSS JOIN customer_average a
WHERE r.total_spent > a.average_spending
ORDER BY r.spending_rank;


-- ============================================================
-- Exercise 30
-- ============================================================

WITH department_statistics AS (
    SELECT
        department_id,
        COUNT(*) AS employee_count,
        SUM(salary) AS total_salary,
        AVG(salary) AS average_salary
    FROM employees
    WHERE status = 'ACTIVE'
    GROUP BY department_id
),
ranked_departments AS (
    SELECT
        *,
        RANK() OVER (
            ORDER BY total_salary DESC
        ) AS salary_rank
    FROM department_statistics
)
SELECT
    d.department_name,
    r.employee_count,
    r.total_salary,
    r.average_salary,
    r.salary_rank
FROM ranked_departments r
JOIN departments d
    ON d.department_id = r.department_id
ORDER BY r.salary_rank;


-- ============================================================
-- Exercise 31 — Nested Subquery
-- ============================================================

SELECT
    c.customer_name,
    t.total_spent
FROM customers c
JOIN (
    SELECT
        customer_id,
        SUM(total_amount) AS total_spent
    FROM orders
    GROUP BY customer_id
) t
    ON c.customer_id = t.customer_id
WHERE t.total_spent > (
    SELECT AVG(customer_total)
    FROM (
        SELECT
            customer_id,
            SUM(total_amount) AS customer_total
        FROM orders
        GROUP BY customer_id
    ) totals
);


-- ============================================================
-- Exercise 32 — CTE
-- ============================================================

WITH customer_totals AS (
    SELECT
        customer_id,
        SUM(total_amount) AS total_spent
    FROM orders
    GROUP BY customer_id
),
customer_average AS (
    SELECT
        AVG(total_spent) AS average_spending
    FROM customer_totals
)
SELECT
    c.customer_name,
    t.total_spent
FROM customer_totals t
JOIN customers c
    ON c.customer_id = t.customer_id
CROSS JOIN customer_average a
WHERE t.total_spent > a.average_spending;


-- ============================================================
-- Exercise 34
-- ============================================================

WITH customer_totals AS (
    SELECT
        customer_id,
        COUNT(*) AS order_count,
        SUM(total_amount) AS total_spent
    FROM orders
    GROUP BY customer_id
),
classified_customers AS (
    SELECT
        *,
        CASE
            WHEN total_spent >= 20000 THEN 'VIP'
            WHEN total_spent >= 10000 THEN 'PREMIUM'
            WHEN total_spent >= 5000 THEN 'REGULAR'
            ELSE 'LOW'
        END AS customer_category
    FROM customer_totals
),
ranked_customers AS (
    SELECT
        *,
        RANK() OVER (
            ORDER BY total_spent DESC
        ) AS spending_rank
    FROM classified_customers
)
SELECT
    c.customer_name,
    r.order_count,
    r.total_spent,
    r.customer_category,
    r.spending_rank
FROM ranked_customers r
JOIN customers c
    ON c.customer_id = r.customer_id
ORDER BY r.spending_rank;


-- ============================================================
-- Exercise 35
-- ============================================================

WITH employee_statistics AS (
    SELECT
        employee_id,
        employee_name,
        department_id,
        salary,
        AVG(salary) OVER (
            PARTITION BY department_id
        ) AS department_average
    FROM employees
),
ranked_employees AS (
    SELECT
        *,
        RANK() OVER (
            PARTITION BY department_id
            ORDER BY salary DESC
        ) AS department_salary_rank
    FROM employee_statistics
)
SELECT
    e.employee_name,
    d.department_name,
    e.salary,
    e.department_salary_rank,
    e.salary - e.department_average
        AS salary_difference_from_average
FROM ranked_employees e
JOIN departments d
    ON d.department_id = e.department_id
ORDER BY d.department_name, e.department_salary_rank;


-- ============================================================
-- Exercise 36
-- ============================================================

WITH daily_sales AS (
    SELECT
        order_date,
        SUM(total_amount) AS daily_revenue
    FROM orders
    GROUP BY order_date
),
sales_analysis AS (
    SELECT
        order_date,
        daily_revenue,
        LAG(daily_revenue) OVER (
            ORDER BY order_date
        ) AS previous_day_revenue,
        SUM(daily_revenue) OVER (
            ORDER BY order_date
        ) AS running_revenue
    FROM daily_sales
)
SELECT
    order_date,
    daily_revenue,
    previous_day_revenue,
    daily_revenue - previous_day_revenue AS revenue_change,
    running_revenue
FROM sales_analysis
ORDER BY order_date;


-- ============================================================
-- MINI PROJECT SOLUTION
-- ============================================================

WITH customer_totals AS (
    SELECT
        customer_id,
        COUNT(*) AS order_count,
        SUM(total_amount) AS total_spent
    FROM orders
    GROUP BY customer_id
),
customer_statistics AS (
    SELECT
        AVG(total_spent) AS average_spending
    FROM customer_totals
),
classified_customers AS (
    SELECT
        customer_id,
        order_count,
        total_spent,
        CASE
            WHEN total_spent >= 20000 THEN 'VIP'
            WHEN total_spent >= 10000 THEN 'PREMIUM'
            WHEN total_spent >= 5000 THEN 'REGULAR'
            ELSE 'LOW'
        END AS customer_category
    FROM customer_totals
),
ranked_customers AS (
    SELECT
        *,
        RANK() OVER (
            ORDER BY total_spent DESC
        ) AS spending_rank
    FROM classified_customers
)
SELECT
    c.customer_name,
    r.order_count,
    r.total_spent,
    r.customer_category,
    r.spending_rank,
    s.average_spending
FROM ranked_customers r
JOIN customers c
    ON c.customer_id = r.customer_id
CROSS JOIN customer_statistics s
ORDER BY r.spending_rank;
```
