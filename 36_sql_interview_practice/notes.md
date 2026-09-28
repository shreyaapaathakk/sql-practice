# Module 36: SQL Interview Practice

## Overview

This module brings together SQL concepts from earlier modules and applies them to interview-style problems.

The focus is on writing correct, readable, and efficient queries while understanding why a particular approach works.

The examples use MySQL 8.0+ and include joins, aggregation, subqueries, Common Table Expressions (CTEs), and window functions.

## Learning Objectives

By the end of this module, you should be able to:

- Identify duplicate records.
- Find the second-highest salary.
- Retrieve the highest-paid employee in each department.
- Use GROUP BY and HAVING correctly.
- Compare correlated subqueries with window functions.
- Calculate running totals and rankings.
- Analyze customer purchasing behavior.
- Solve date-based SQL problems.
- Explain NULL handling and edge cases.
- Write clear, interview-ready SQL.

## 1. Understand the Problem First

Before writing a query, identify the expected output, the relevant tables, the relationships between them, and any special conditions.

For example, "find the second-highest salary" is ambiguous if multiple employees share the highest salary. Usually, the question refers to the second-highest distinct salary, but clarify this when necessary.

## 2. Find the Second-Highest Distinct Salary

A common interview question is to find the second-highest distinct salary.

```sql
SELECT MAX(salary) AS second_highest_salary
FROM employees
WHERE salary < (
    SELECT MAX(salary)
    FROM employees
);
````

The inner query finds the highest salary. The outer query finds the maximum salary below that value.

If no second distinct salary exists, the result is NULL.

## 3. Find the Nth-Highest Salary

`DENSE_RANK()` assigns the same rank to tied values without leaving gaps.

SQL

```
WITH ranked_salaries AS (
    SELECT
        salary,
        DENSE_RANK() OVER (
            ORDER BY salary DESC
        ) AS salary_rank
    FROM employees
)
SELECT DISTINCT salary
FROM ranked_salaries
WHERE salary_rank = 3;
```

This returns the third-highest distinct salary. Use `ROW_NUMBER()` when you need a unique sequence for each row, or `RANK()` when ties should leave gaps.

## 4. Find the Highest-Paid Employee in Each Department

A window function can rank employees within each department.

SQL

```
WITH ranked_employees AS (
    SELECT
        employee_id,
        employee_name,
        department_id,
        salary,
        DENSE_RANK() OVER (
            PARTITION BY department_id
            ORDER BY salary DESC
        ) AS salary_rank
    FROM employees
)
SELECT *
FROM ranked_employees
WHERE salary_rank = 1;
```

This returns every employee tied for the highest salary in their department. Use `ROW_NUMBER()` with a deterministic tie-breaker if exactly one employee per department is required.

## 5. Find Duplicate Records

`GROUP BY` and `HAVING` are useful for identifying repeated values.

SQL

```
SELECT
    email,
    COUNT(*) AS occurrences
FROM customers
GROUP BY email
HAVING COUNT(*) > 1;
```

This identifies duplicate email values. Whether two records are true duplicates depends on the business rules and which columns define uniqueness.

## 6. WHERE vs. HAVING

`WHERE` filters rows before grouping. `HAVING` filters groups after aggregation.

SQL

```
SELECT
    department_id,
    AVG(salary) AS average_salary
FROM employees
WHERE salary > 30000
GROUP BY department_id
HAVING AVG(salary) > 50000;
```

Here, individual salaries are filtered first. The remaining employees are grouped, and only departments whose resulting average exceeds 50,000 are returned.

## 7. Customers Who Have Never Ordered

An anti-join can identify customers without matching orders.

SQL

```
SELECT
    c.customer_id,
    c.customer_name
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;
```

A `NOT EXISTS` subquery is another useful approach. Be careful with `NOT IN` when the subquery may return NULL, because NULL can affect the result.

## 8. Running Totals

A window function calculates a cumulative total without collapsing individual rows.

SQL

```
SELECT
    order_id,
    order_date,
    amount,
    SUM(amount) OVER (
        ORDER BY order_date, order_id
        ROWS BETWEEN UNBOUNDED PRECEDING
                 AND CURRENT ROW
    ) AS running_total
FROM orders;
```

The explicit window frame and stable ordering make the intended row-by-row accumulation clear.

## 9. Customers With More Than One Order

SQL

```
SELECT
    customer_id,
    COUNT(*) AS order_count
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > 1;
```

This is a straightforward aggregation problem. If the requirement concerns distinct products or order items, use the appropriate distinct key instead of blindly counting rows.

## 10. Month-over-Month Analysis

A common reporting task is to compare monthly revenue with the previous month.

SQL

```
WITH monthly_revenue AS (
    SELECT
        DATE_FORMAT(order_date, '%Y-%m') AS order_month,
        SUM(amount) AS revenue
    FROM orders
    GROUP BY DATE_FORMAT(order_date, '%Y-%m')
),
revenue_comparison AS (
    SELECT
        order_month,
        revenue,
        LAG(revenue) OVER (
            ORDER BY order_month
        ) AS previous_month_revenue
    FROM monthly_revenue
)
SELECT
    order_month,
    revenue,
    previous_month_revenue,
    revenue - previous_month_revenue AS revenue_change
FROM revenue_comparison
ORDER BY order_month;
```

This compares consecutive rows in the monthly result. If months with zero orders must appear, generate a complete calendar of months and join the revenue data to it before applying `LAG()`.

## 11. Common Interview Mistakes

* Ignoring ties when ranking values.

* Confusing `RANK()`, `DENSE_RANK()`, and `ROW_NUMBER()`.

* Using `WHERE` to filter aggregate results.

* Forgetting that `COUNT(column)` ignores NULL values.

* Counting joined rows when the question asks for distinct entities.

* Using `NOT IN` without considering NULL.

* Failing to define what happens when no matching rows exist.

* Assuming a query has a guaranteed order without `ORDER BY`.

* Using a window function when a simple aggregate would suffice.

* Ignoring date boundaries and duplicate timestamps.

## 12. How to Approach an Interview Query

1. Restate the expected result.

2. Identify the required tables and join keys.

3. Decide the correct level of aggregation.

4. Consider NULLs, duplicates, ties, and empty results.

5. Write a straightforward solution.

6. Test it against edge cases.

7. Explain its behavior and possible alternatives.

8. Discuss performance when relevant.

## Summary

SQL interviews test both technical knowledge and problem-solving ability. A strong solution is correct, readable, and appropriate for the data and business requirement.

Practice explaining your assumptions, handling edge cases, and choosing between joins, subqueries, aggregation, and window functions.
