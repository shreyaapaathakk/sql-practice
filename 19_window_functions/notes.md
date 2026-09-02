# Module 19 — Window Functions

Window functions are one of the most important advanced SQL concepts.

They allow you to perform calculations across a set of related rows while keeping the individual rows in the result.

This module uses **MySQL 8.0+** syntax.

---

## 1. What Is a Window Function?

A window function performs a calculation across rows that are related to the current row.

For example:

```sql
SELECT
    first_name,
    salary,
    AVG(salary) OVER () AS company_average_salary
FROM employees;
```

Unlike `GROUP BY`, this does not combine all employees into one row.

Every employee remains visible.

Example:

```text
first_name    salary    company_average_salary
Aarav         55000     63833
Priya         72000     63833
Rohan         48000     63833
...
```

The average is calculated across the entire result while the original rows remain.

---

## 2. GROUP BY vs Window Functions

Consider:

```sql
SELECT
    department_id,
    AVG(salary)
FROM employees
GROUP BY department_id;
```

This produces one row per department.

With a window function:

```sql
SELECT
    first_name,
    department_id,
    salary,
    AVG(salary) OVER (
        PARTITION BY department_id
    ) AS department_average
FROM employees;
```

Every employee remains visible.

The department average is added to every employee's row.

The key difference is:

```text
GROUP BY
Rows → grouped together → fewer rows

Window Function
Rows → calculations added → same number of rows
```

---

## 3. Basic Window Function Syntax

The general syntax is:

```sql
function_name(...) OVER (
    PARTITION BY ...
    ORDER BY ...
    frame_clause
)
```

The `OVER()` clause defines the window.

Example:

```sql
SUM(salary) OVER ()
```

---

## 4. OVER()

The simplest window is:

```sql
OVER ()
```

It means the calculation uses all rows in the result.

Example:

```sql
SELECT
    first_name,
    salary,
    SUM(salary) OVER () AS total_salary
FROM employees;
```

Every employee receives the same company-wide total.

---

## 5. PARTITION BY

`PARTITION BY` divides the result into groups for the window calculation.

Example:

```sql
SELECT
    first_name,
    department_id,
    salary,
    AVG(salary) OVER (
        PARTITION BY department_id
    ) AS department_average
FROM employees;
```

Each department gets its own average.

Important:

`PARTITION BY` does not remove rows.

It only determines which rows participate in the calculation.

---

## 6. PARTITION BY vs GROUP BY

`GROUP BY`:

```sql
SELECT
    department_id,
    AVG(salary)
FROM employees
GROUP BY department_id;
```

Result:

```text
department_id    average_salary
1                 ...
2                 ...
3                 ...
```

Window function:

```sql
SELECT
    employee_id,
    department_id,
    salary,
    AVG(salary) OVER (
        PARTITION BY department_id
    ) AS department_average
FROM employees;
```

Result:

```text
employee_id    department_id    salary    department_average
101            1                55000     ...
103            1                48000     ...
102            2                72000     ...
105            2                85000     ...
```

The employee rows remain.

---

# 7. Window Functions and ORDER BY

Some window functions use an ordering.

Example:

```sql
SELECT
    first_name,
    salary,
    ROW_NUMBER() OVER (
        ORDER BY salary DESC
    ) AS row_num
FROM employees;
```

This assigns a sequential number according to salary.

---

# 8. ROW_NUMBER()

`ROW_NUMBER()` assigns a unique sequential number to every row.

Example:

```sql
SELECT
    first_name,
    salary,
    ROW_NUMBER() OVER (
        ORDER BY salary DESC
    ) AS row_number
FROM employees;
```

Possible result:

```text
first_name    salary    row_number
Arjun         85000     1
Priya         72000     2
Neha          65000     3
Kavya         58000     4
Aarav         55000     5
Rohan         48000     6
```

---

# 9. ROW_NUMBER() with PARTITION BY

You can number rows separately within each group.

```sql
SELECT
    first_name,
    department_id,
    salary,
    ROW_NUMBER() OVER (
        PARTITION BY department_id
        ORDER BY salary DESC
    ) AS department_rank
FROM employees;
```

Each department starts counting from 1.

---

# 10. RANK()

`RANK()` assigns the same rank to tied values.

Example:

```sql
SELECT
    first_name,
    salary,
    RANK() OVER (
        ORDER BY salary DESC
    ) AS salary_rank
FROM employees;
```

If two employees have the same salary:

```text
salary    rank
85000     1
72000     2
72000     2
65000     4
```

Notice that rank 3 is skipped.

---

# 11. DENSE_RANK()

`DENSE_RANK()` also gives tied rows the same rank, but it does not skip numbers.

Example:

```text
salary    dense_rank
85000     1
72000     2
72000     2
65000     3
```

Comparison:

```text
ROW_NUMBER()
Every row gets a different number.

RANK()
Ties share a rank and gaps appear.

DENSE_RANK()
Ties share a rank and no gaps appear.
```

---

# 12. Comparing ROW_NUMBER, RANK and DENSE_RANK

Suppose salaries are:

```text
85000
72000
72000
65000
65000
48000
```

The result is:

```text
salary    ROW_NUMBER    RANK    DENSE_RANK
85000     1             1       1
72000     2             2       2
72000     3             2       2
65000     4             4       3
65000     5             4       3
48000     6             6       4
```

Choose the function according to the desired behavior.

---

# 13. LAG()

`LAG()` retrieves a value from a previous row.

Example:

```sql
SELECT
    order_id,
    order_date,
    total_amount,
    LAG(total_amount) OVER (
        ORDER BY order_date
    ) AS previous_order_amount
FROM orders;
```

The first row has no previous row, so its result is `NULL`.

---

# 14. LAG() for Differences

LAG is useful for comparing current and previous values.

```sql
SELECT
    order_id,
    order_date,
    total_amount,
    total_amount
        - LAG(total_amount) OVER (
            ORDER BY order_date
        ) AS difference_from_previous
FROM orders;
```

This calculates the difference between consecutive orders.

---

# 15. LEAD()

`LEAD()` retrieves a value from a following row.

Example:

```sql
SELECT
    order_id,
    order_date,
    total_amount,
    LEAD(total_amount) OVER (
        ORDER BY order_date
    ) AS next_order_amount
FROM orders;
```

The final row has no following row, so its result is `NULL`.

---

# 16. LAG vs LEAD

```text
LAG
Current row ← Previous row

LEAD
Current row → Next row
```

Use:

```sql
LAG(column)
```

when you need previous-row information.

Use:

```sql
LEAD(column)
```

when you need next-row information.

---

# 17. SUM() as a Window Function

Aggregate functions can also become window functions.

Example:

```sql
SELECT
    first_name,
    salary,
    SUM(salary) OVER () AS total_salary
FROM employees;
```

This calculates the total salary without grouping rows together.

---

# 18. Running Total

A very common window-function pattern is a running total.

```sql
SELECT
    order_id,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        ORDER BY order_date
    ) AS running_total
FROM orders;
```

The running total increases as rows are processed chronologically.

---

# 19. Running Total by Customer

You can combine `PARTITION BY` and `ORDER BY`.

```sql
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
```

Each customer has an independent running total.

---

# 20. AVG() as a Window Function

Example:

```sql
SELECT
    first_name,
    salary,
    AVG(salary) OVER () AS company_average
FROM employees;
```

You can also partition:

```sql
SELECT
    first_name,
    department_id,
    salary,
    AVG(salary) OVER (
        PARTITION BY department_id
    ) AS department_average
FROM employees;
```

---

# 21. MIN() and MAX() as Window Functions

Example:

```sql
SELECT
    first_name,
    department_id,
    salary,
    MAX(salary) OVER (
        PARTITION BY department_id
    ) AS department_max_salary
FROM employees;
```

This shows the highest salary in the employee's department.

Similarly:

```sql
MIN(salary) OVER (
    PARTITION BY department_id
)
```

shows the lowest salary.

---

# 22. Comparing an Employee with the Department Average

Window functions are excellent for comparisons.

```sql
SELECT
    first_name,
    department_id,
    salary,
    AVG(salary) OVER (
        PARTITION BY department_id
    ) AS department_average,

    salary
        - AVG(salary) OVER (
            PARTITION BY department_id
        ) AS difference_from_average

FROM employees;
```

This tells us whether an employee earns above or below the department average.

---

# 23. Percentage of Department Salary

You can calculate each employee's percentage of the department's total salary.

```sql
SELECT
    first_name,
    department_id,
    salary,
    salary /
        SUM(salary) OVER (
            PARTITION BY department_id
        ) * 100 AS salary_percentage
FROM employees;
```

This is useful in financial and business analysis.

---

# 24. NTILE()

`NTILE()` divides rows into approximately equal groups.

Example:

```sql
SELECT
    first_name,
    salary,
    NTILE(4) OVER (
        ORDER BY salary DESC
    ) AS salary_quartile
FROM employees;
```

This divides employees into four groups.

Possible interpretation:

```text
1 → Top 25%
2 → Next 25%
3 → Next 25%
4 → Bottom 25%
```

---

# 25. NTILE() with PARTITION BY

You can create groups within each department.

```sql
SELECT
    first_name,
    department_id,
    salary,
    NTILE(2) OVER (
        PARTITION BY department_id
        ORDER BY salary DESC
    ) AS salary_half
FROM employees;
```

Each department is divided independently.

---

# 26. FIRST_VALUE()

`FIRST_VALUE()` returns the first value in the window according to its ordering.

Example:

```sql
SELECT
    first_name,
    department_id,
    salary,
    FIRST_VALUE(salary) OVER (
        PARTITION BY department_id
        ORDER BY salary DESC
    ) AS highest_department_salary
FROM employees;
```

Every employee in a department can therefore see the department's highest salary.

---

# 27. LAST_VALUE()

`LAST_VALUE()` returns the last value according to the window frame.

For example:

```sql
SELECT
    first_name,
    department_id,
    salary,
    LAST_VALUE(salary) OVER (
        PARTITION BY department_id
        ORDER BY salary DESC
        ROWS BETWEEN UNBOUNDED PRECEDING
             AND UNBOUNDED FOLLOWING
    ) AS lowest_department_salary
FROM employees;
```

The explicit frame is important when using `LAST_VALUE()`.

---

# 28. Window Frames

A window frame determines which rows are included in a calculation.

Example:

```sql
ROWS BETWEEN UNBOUNDED PRECEDING
     AND CURRENT ROW
```

means:

```text
Start from the first row
and continue through the current row.
```

This is commonly used for running totals.

---

# 29. Running Total with an Explicit Frame

```sql
SELECT
    order_id,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        ORDER BY order_date
        ROWS BETWEEN UNBOUNDED PRECEDING
             AND CURRENT ROW
    ) AS running_total
FROM orders;
```

This explicitly defines the running-total frame.

---

# 30. Moving Average

Window frames can calculate moving averages.

Example:

```sql
SELECT
    order_id,
    order_date,
    total_amount,
    AVG(total_amount) OVER (
        ORDER BY order_date
        ROWS BETWEEN 2 PRECEDING
             AND CURRENT ROW
    ) AS three_order_average
FROM orders;
```

The calculation uses the current row and the two preceding rows.

---

# 31. Window Functions with CTEs

Window functions can be combined with CTEs.

Example:

```sql
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
```

This is a common pattern for finding the top N rows.

---

# 32. Why a CTE Is Useful with Window Functions

Window functions are calculated after the `WHERE` clause logically applies.

Therefore, this does not work as expected:

```sql
SELECT
    first_name,
    salary,
    RANK() OVER (
        ORDER BY salary DESC
    ) AS salary_rank
FROM employees
WHERE salary_rank <= 3;
```

The alias `salary_rank` cannot be directly used in the same query's `WHERE`.

Instead:

```sql
WITH ranked_employees AS (
    SELECT
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
```

The CTE creates a result that can then be filtered.

---

# 33. Top N per Group

One of the most important uses of window functions is finding the top N rows within each group.

Example:

```sql
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
```

This returns the top two employees from every department.

---

# 34. Finding the Highest-Paid Employee per Department

```sql
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
```

This is a very common SQL interview problem.

---

# 35. Ranking vs ROW_NUMBER for Top N

Suppose two employees have the same salary.

With:

```sql
ROW_NUMBER()
```

only one may receive rank 1.

With:

```sql
RANK()
```

both employees can receive rank 1.

Therefore:

```text
Need exactly N rows per group
→ ROW_NUMBER()

Need to include ties
→ RANK()
```

---

# 36. Window Functions with CASE

Window functions and CASE can be combined.

Example:

```sql
SELECT
    first_name,
    salary,
    CASE
        WHEN salary >
            AVG(salary) OVER ()
        THEN 'Above Average'
        ELSE 'Below Average'
    END AS salary_status
FROM employees;
```

This classifies employees relative to the company average.

---

# 37. Ranking Employees by Department

```sql
SELECT
    first_name,
    department_id,
    salary,
    RANK() OVER (
        PARTITION BY department_id
        ORDER BY salary DESC
    ) AS department_rank
FROM employees;
```

This is useful for:

* Performance reports
* Salary comparisons
* Department leaderboards
* Top employee analysis

---

# 38. Comparing Current and Previous Orders

```sql
SELECT
    customer_id,
    order_id,
    order_date,
    total_amount,

    LAG(total_amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS previous_order_amount

FROM orders;
```

This allows customer-level order comparisons.

---

# 39. Calculating Order Growth

```sql
SELECT
    customer_id,
    order_id,
    order_date,
    total_amount,

    total_amount
        - LAG(total_amount) OVER (
            PARTITION BY customer_id
            ORDER BY order_date
        ) AS amount_change

FROM orders;
```

You can calculate percentage change as well:

```sql
SELECT
    customer_id,
    order_id,
    total_amount,

    ROUND(
        (
            total_amount
            - LAG(total_amount) OVER (
                PARTITION BY customer_id
                ORDER BY order_date
            )
        )
        /
        NULLIF(
            LAG(total_amount) OVER (
                PARTITION BY customer_id
                ORDER BY order_date
            ),
            0
        ) * 100,
        2
    ) AS percentage_change

FROM orders;
```

---

# 40. Window Function Execution Concept

A simplified logical order is:

```text
FROM
JOIN
WHERE
GROUP BY
HAVING
WINDOW FUNCTIONS
SELECT / ORDER BY
```

The exact SQL processing model is more nuanced, but the important practical point is:

Window functions operate after filtering and grouping have established the rows they can see.

---

# 41. Window Functions Cannot Usually Be Used in WHERE

This is invalid:

```sql
SELECT
    first_name,
    salary,
    ROW_NUMBER() OVER (
        ORDER BY salary DESC
    ) AS row_num
FROM employees
WHERE row_num <= 3;
```

Use a CTE:

```sql
WITH ranked AS (
    SELECT
        first_name,
        salary,
        ROW_NUMBER() OVER (
            ORDER BY salary DESC
        ) AS row_num
    FROM employees
)
SELECT *
FROM ranked
WHERE row_num <= 3;
```

---

# 42. Window Functions Cannot Usually Be Used in GROUP BY

Do not try:

```sql
GROUP BY RANK() OVER (...)
```

Instead, calculate the window result in a CTE or derived table and group the resulting data.

---

# 43. Multiple Window Functions

A query can contain multiple window functions.

Example:

```sql
SELECT
    first_name,
    department_id,
    salary,

    ROW_NUMBER() OVER (
        PARTITION BY department_id
        ORDER BY salary DESC
    ) AS row_num,

    RANK() OVER (
        PARTITION BY department_id
        ORDER BY salary DESC
    ) AS salary_rank,

    AVG(salary) OVER (
        PARTITION BY department_id
    ) AS department_average

FROM employees;
```

This creates a detailed analytical report.

---

# 44. Named Windows

MySQL allows a named window definition.

Example:

```sql
SELECT
    first_name,
    salary,

    RANK() OVER w AS salary_rank,

    ROW_NUMBER() OVER w AS row_num

FROM employees

WINDOW w AS (
    ORDER BY salary DESC
);
```

This can reduce repeated window definitions.

---

# 45. Practical Analytical Pattern

A powerful pattern is:

```text
1. Build the base dataset.
2. Add window calculations.
3. Put the result into a CTE.
4. Filter or analyze the calculated values.
```

Example:

```sql
WITH analysis AS (
    SELECT
        first_name,
        department_id,
        salary,

        RANK() OVER (
            PARTITION BY department_id
            ORDER BY salary DESC
        ) AS department_rank,

        AVG(salary) OVER (
            PARTITION BY department_id
        ) AS department_average

    FROM employees
)
SELECT *
FROM analysis
WHERE department_rank <= 2;
```

---

# 46. Common Mistakes

## Mistake 1: Confusing GROUP BY and PARTITION BY

`GROUP BY` reduces rows.

`PARTITION BY` does not.

---

## Mistake 2: Forgetting ORDER BY

Ranking functions normally need an ordering:

```sql
RANK() OVER (
    ORDER BY salary DESC
)
```

Without a meaningful order, the result may not represent the desired ranking.

---

## Mistake 3: Using ROW_NUMBER when ties matter

If tied values should receive the same rank, use `RANK()` or `DENSE_RANK()`.

---

## Mistake 4: Filtering a window alias directly

Incorrect:

```sql
WHERE rank <= 3
```

Use a CTE or derived table.

---

## Mistake 5: Misunderstanding LAG and LEAD

Remember:

```text
LAG  → previous
LEAD → next
```

---

## Mistake 6: Forgetting PARTITION BY

If you need a calculation separately for every department or customer, you probably need:

```sql
PARTITION BY department_id
```

or:

```sql
PARTITION BY customer_id
```

---

# 47. Important Window Functions

You should know these functions:

```text
ROW_NUMBER()
RANK()
DENSE_RANK()
LAG()
LEAD()
FIRST_VALUE()
LAST_VALUE()
NTILE()
```

You should also understand that aggregate functions can be used as window functions:

```text
SUM()
AVG()
MIN()
MAX()
COUNT()
```

---

# 48. Most Important Patterns

### Ranking

```sql
RANK() OVER (
    ORDER BY salary DESC
)
```

### Ranking within groups

```sql
RANK() OVER (
    PARTITION BY department_id
    ORDER BY salary DESC
)
```

### Previous row

```sql
LAG(amount) OVER (
    ORDER BY date
)
```

### Next row

```sql
LEAD(amount) OVER (
    ORDER BY date
)
```

### Running total

```sql
SUM(amount) OVER (
    ORDER BY date
)
```

### Group average

```sql
AVG(salary) OVER (
    PARTITION BY department_id
)
```

### Top N per group

```sql
WITH ranked AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY department_id
            ORDER BY salary DESC
        ) AS rn
    FROM employees
)
SELECT *
FROM ranked
WHERE rn <= 3;
```

---

# 49. Key Takeaways

Window functions allow SQL to perform advanced analysis while preserving individual rows.

Remember:

* `OVER()` defines a window.
* `PARTITION BY` divides rows into independent groups.
* `ORDER BY` determines the order within the window.
* `ROW_NUMBER()` gives unique sequential numbers.
* `RANK()` allows ties and leaves gaps.
* `DENSE_RANK()` allows ties without gaps.
* `LAG()` accesses a previous row.
* `LEAD()` accesses a following row.
* `SUM() OVER()` can create running totals.
* `AVG() OVER()` can calculate group averages without grouping rows.
* `NTILE()` divides rows into approximately equal groups.
* CTEs are extremely useful when filtering window-function results.
* Window functions are essential for top-N-per-group problems.
* Window functions are widely used in analytics, reporting, and SQL interviews.

The most important conceptual distinction is:

```text
GROUP BY
→ summarize rows

WINDOW FUNCTION
→ analyze rows while keeping them
```

Once you understand this distinction, many advanced SQL problems become much easier.
