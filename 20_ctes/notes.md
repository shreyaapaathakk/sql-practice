# Module 20 — CTEs & Advanced Query Composition

Common Table Expressions (CTEs) are one of the most useful tools for writing clean, readable, and maintainable SQL.

A CTE allows you to create a temporary named result set that can be referenced by a query.

This module uses MySQL 8.0+ syntax.

---

## 1. What Is a CTE?

CTE stands for:

```text
Common Table Expression
```

Basic syntax:

```sql
WITH cte_name AS (
    SELECT ...
)
SELECT *
FROM cte_name;
```

The CTE exists only for the duration of the statement.

---

## 2. Simple CTE

Instead of writing:

```sql
SELECT *
FROM employees
WHERE salary > 60000;
```

you can write:

```sql
WITH high_salary_employees AS (
    SELECT *
    FROM employees
    WHERE salary > 60000
)
SELECT *
FROM high_salary_employees;
```

The second query is more useful when the intermediate result needs additional processing.

---

## 3. Why Use CTEs?

CTEs help you:

* Break complex queries into steps.
* Improve readability.
* Avoid repeating complicated subqueries.
* Work with window-function results.
* Build multi-stage analysis.
* Create recursive queries.
* Make analytical SQL easier to debug.

Think of a CTE as a named temporary result.

---

## 4. CTE Structure

The general structure is:

```sql
WITH cte_name AS (
    SELECT ...
)
SELECT ...
FROM cte_name;
```

The important parts are:

```text
WITH
   ↓
CTE name
   ↓
AS
   ↓
Intermediate query
   ↓
Main query
```

---

## 5. CTE with Filtering

Example:

```sql
WITH high_salary AS (
    SELECT
        employee_id,
        first_name,
        salary
    FROM employees
    WHERE salary > 60000
)
SELECT *
FROM high_salary;
```

The CTE contains only employees earning more than 60,000.

---

## 6. CTE with Aggregation

A CTE can contain aggregate functions.

```sql
WITH department_salary AS (
    SELECT
        department_id,
        AVG(salary) AS average_salary
    FROM employees
    GROUP BY department_id
)
SELECT *
FROM department_salary;
```

This creates a department-level summary.

---

## 7. CTE with JOIN

CTEs can be joined with other tables.

```sql
WITH department_salary AS (
    SELECT
        department_id,
        AVG(salary) AS average_salary
    FROM employees
    GROUP BY department_id
)
SELECT
    e.first_name,
    e.salary,
    ds.average_salary
FROM employees AS e
JOIN department_salary AS ds
    ON e.department_id = ds.department_id;
```

This lets us compare each employee with their department average.

---

## 8. CTE vs Subquery

A subquery might look like:

```sql
SELECT *
FROM (
    SELECT
        first_name,
        salary
    FROM employees
    WHERE salary > 60000
) AS high_salary;
```

The equivalent CTE is:

```sql
WITH high_salary AS (
    SELECT
        first_name,
        salary
    FROM employees
    WHERE salary > 60000
)
SELECT *
FROM high_salary;
```

Both can solve similar problems.

CTEs are often easier to read, especially when queries become complicated.

---

## 9. Multiple CTEs

You can define more than one CTE.

```sql
WITH employee_data AS (
    SELECT
        employee_id,
        first_name,
        department_id,
        salary
    FROM employees
),

department_data AS (
    SELECT
        department_id,
        department_name
    FROM departments
)

SELECT
    employee_data.first_name,
    employee_data.salary,
    department_data.department_name
FROM employee_data
JOIN department_data
    ON employee_data.department_id =
       department_data.department_id;
```

Multiple CTEs are separated by commas.

---

## 10. CTEs Work Sequentially

Multiple CTEs can reference earlier CTEs.

Example:

```sql
WITH high_salary AS (
    SELECT *
    FROM employees
    WHERE salary > 60000
),

ranked_employees AS (
    SELECT
        first_name,
        salary,
        RANK() OVER (
            ORDER BY salary DESC
        ) AS salary_rank
    FROM high_salary
)

SELECT *
FROM ranked_employees;
```

The flow is:

```text
employees
   ↓
high_salary
   ↓
ranked_employees
   ↓
final SELECT
```

This is one of the most powerful CTE patterns.

---

# 11. CTE + Window Function

This is particularly important.

Suppose you want the top three employees.

First create rankings:

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

The CTE allows us to filter the window-function result.

---

# 12. Top N per Group

CTEs and window functions work extremely well together.

```sql
WITH ranked_employees AS (
    SELECT
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

This returns the top two employees in every department.

---

# 13. CTE for Above-Average Employees

```sql
WITH employee_analysis AS (
    SELECT
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
```

The CTE creates the analytical result.

The outer query filters it.

---

# 14. CTE + GROUP BY

Example:

```sql
WITH department_totals AS (
    SELECT
        department_id,
        SUM(salary) AS total_salary
    FROM employees
    GROUP BY department_id
)
SELECT
    AVG(total_salary) AS average_department_salary
FROM department_totals;
```

The first query calculates department totals.

The second query calculates the average of those totals.

This is difficult to express cleanly in one simple query.

---

# 15. CTE + HAVING

Example:

```sql
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
```

The CTE makes the aggregated result available to the outer query.

---

# 16. CTE + ORDER BY

You can sort the CTE result:

```sql
WITH salary_data AS (
    SELECT
        first_name,
        salary
    FROM employees
)
SELECT *
FROM salary_data
ORDER BY salary DESC;
```

Usually, the final `ORDER BY` belongs in the outer query when the ordering is intended for the final result.

---

# 17. CTE + CASE

CTEs can simplify complicated classification.

```sql
WITH employee_status AS (
    SELECT
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
```

The classification can then be used by later queries.

---

# 18. CTE for Multi-Step Analysis

Suppose we want:

```text
Step 1 → Calculate department average
Step 2 → Calculate employee difference
Step 3 → Find employees above average
```

We can write:

```sql
WITH employee_analysis AS (
    SELECT
        first_name,
        department_id,
        salary,
        AVG(salary) OVER (
            PARTITION BY department_id
        ) AS department_average
    FROM employees
),

salary_comparison AS (
    SELECT
        first_name,
        department_id,
        salary,
        department_average,
        salary - department_average AS difference
    FROM employee_analysis
)

SELECT *
FROM salary_comparison
WHERE difference > 0;
```

Each CTE performs one logical step.

---

# 19. Naming CTEs Clearly

Bad:

```sql
WITH x AS (...)
```

Better:

```sql
WITH high_salary_employees AS (...)
```

Good CTE names should describe what the CTE contains.

Examples:

```text
department_totals
ranked_employees
customer_orders
monthly_sales
employee_analysis
customer_summary
```

---

# 20. CTE Column Names

You can explicitly define CTE column names.

Example:

```sql
WITH salary_data(employee_name, employee_salary) AS (
    SELECT
        first_name,
        salary
    FROM employees
)
SELECT *
FROM salary_data;
```

However, allowing the SELECT expressions to provide the column names is usually easier to read.

---

# 21. Recursive CTEs

A recursive CTE references itself.

Basic structure:

```sql
WITH RECURSIVE cte_name AS (
    -- Anchor query

    UNION ALL

    -- Recursive query
)
SELECT *
FROM cte_name;
```

Recursive CTEs are useful for:

* Hierarchies.
* Organizational structures.
* Tree structures.
* Graph-like data.
* Number sequences.
* Date sequences.

---

# 22. Recursive CTE Example

Generate numbers from 1 to 5:

```sql
WITH RECURSIVE numbers AS (
    SELECT 1 AS n

    UNION ALL

    SELECT n + 1
    FROM numbers
    WHERE n < 5
)
SELECT *
FROM numbers;
```

Result:

```text
1
2
3
4
5
```

The first query creates the starting value.

The recursive query generates the next values.

---

# 23. Anchor Member

In:

```sql
WITH RECURSIVE numbers AS (
    SELECT 1 AS n

    UNION ALL

    SELECT n + 1
    FROM numbers
    WHERE n < 5
)
```

this is the anchor:

```sql
SELECT 1 AS n
```

It provides the starting row.

---

# 24. Recursive Member

This is the recursive member:

```sql
SELECT n + 1
FROM numbers
WHERE n < 5
```

It references the CTE itself.

Each iteration creates the next number.

---

# 25. Recursive CTE Safety

Always make sure a recursive CTE has a stopping condition.

For example:

```sql
WHERE n < 5
```

Without a stopping condition, recursion may continue until MySQL reaches its recursion limit.

---

# 26. Recursive CTE for Dates

Recursive CTEs can generate dates.

Example:

```sql
WITH RECURSIVE dates AS (
    SELECT DATE('2026-01-01') AS order_date

    UNION ALL

    SELECT order_date + INTERVAL 1 DAY
    FROM dates
    WHERE order_date < '2026-01-07'
)
SELECT *
FROM dates;
```

This generates one row for every date from January 1 through January 7.

---

# 27. Recursive CTE for Employee Hierarchies

Suppose an employee table has:

```text
employee_id
employee_name
manager_id
```

A recursive CTE can traverse the hierarchy.

Conceptually:

```sql
WITH RECURSIVE employee_hierarchy AS (

    SELECT
        employee_id,
        employee_name,
        manager_id,
        0 AS level
    FROM employees
    WHERE manager_id IS NULL

    UNION ALL

    SELECT
        e.employee_id,
        e.employee_name,
        e.manager_id,
        eh.level + 1
    FROM employees AS e
    JOIN employee_hierarchy AS eh
        ON e.manager_id = eh.employee_id
)

SELECT *
FROM employee_hierarchy;
```

This can represent:

```text
CEO
 ├── Manager A
 │    ├── Employee A1
 │    └── Employee A2
 └── Manager B
      └── Employee B1
```

---

# 28. CTEs and Temporary Tables

A CTE is not the same as a temporary table.

A CTE:

```text
Exists for one SQL statement.
```

A temporary table:

```text
Can exist across multiple statements during a session.
```

Use a CTE when the intermediate result is needed only for the current query.

---

# 29. CTEs and Views

A CTE is also different from a view.

A view is stored in the database:

```sql
CREATE VIEW ...
```

A CTE is defined inside a query:

```sql
WITH ...
```

Think:

```text
CTE
→ temporary query-level result

VIEW
→ stored database object

TEMPORARY TABLE
→ temporary table object
```

---

# 30. CTE + JOIN + Window Function

This pattern combines several advanced SQL concepts.

```sql
WITH employee_data AS (
    SELECT
        e.employee_id,
        e.first_name,
        e.department_id,
        e.salary,
        d.department_name
    FROM employees AS e
    JOIN departments AS d
        ON e.department_id = d.department_id
),

ranked_employees AS (
    SELECT
        employee_id,
        first_name,
        department_name,
        department_id,
        salary,

        RANK() OVER (
            PARTITION BY department_id
            ORDER BY salary DESC
        ) AS department_rank,

        AVG(salary) OVER (
            PARTITION BY department_id
        ) AS department_average

    FROM employee_data
)

SELECT *
FROM ranked_employees
WHERE department_rank <= 2;
```

This is close to the kind of SQL used in real analytical work.

---

# 31. CTE + Multiple Aggregation Levels

CTEs are useful when analysis requires several levels of aggregation.

For example:

```text
Orders
 ↓
Customer totals
 ↓
Average customer spending
 ↓
Customers above average
```

This can be written as:

```sql
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
```

---

# 32. CTE + DISTINCT

A CTE can simplify DISTINCT operations.

```sql
WITH customer_cities AS (
    SELECT DISTINCT city
    FROM customers
)
SELECT *
FROM customer_cities;
```

---

# 33. CTE + UNION

CTEs can also be combined with set operations.

```sql
WITH combined_people AS (
    SELECT first_name
    FROM employees

    UNION

    SELECT customer_name
    FROM customers
)
SELECT *
FROM combined_people;
```

---

# 34. CTEs Improve Debugging

One major advantage of CTEs is that you can test each logical step.

For example:

```sql
WITH step_one AS (
    SELECT ...
),

step_two AS (
    SELECT ...
    FROM step_one
)

SELECT *
FROM step_two;
```

During development, you can temporarily inspect:

```sql
SELECT *
FROM step_one;
```

This makes complicated SQL easier to debug.

---

# 35. Avoid Unnecessary CTEs

Not every query needs a CTE.

For example:

```sql
SELECT *
FROM employees
WHERE salary > 60000;
```

does not need:

```sql
WITH employees_above_salary AS (...)
```

Use CTEs when they make the query clearer or enable multi-step processing.

---

# 36. CTE Performance

A CTE should not automatically be assumed to be faster than a subquery.

Performance depends on:

* Query structure.
* Indexes.
* Data size.
* MySQL optimizer behavior.
* Joins.
* Aggregations.
* Filtering.

Use CTEs primarily for **clarity and query composition**, then optimize when necessary.

---

# 37. CTE vs Derived Table

A derived table:

```sql
SELECT *
FROM (
    SELECT ...
) AS x;
```

A CTE:

```sql
WITH x AS (
    SELECT ...
)
SELECT *
FROM x;
```

CTEs are generally easier to manage when there are several intermediate steps.

---

# 38. Multi-CTE Analytical Pattern

A very useful pattern is:

```sql
WITH
base_data AS (
    SELECT ...
),

aggregated_data AS (
    SELECT ...
    FROM base_data
),

ranked_data AS (
    SELECT ...
    FROM aggregated_data
),

final_data AS (
    SELECT ...
    FROM ranked_data
)

SELECT *
FROM final_data;
```

Think of this as a SQL pipeline.

---

# 39. SQL Pipeline Thinking

Instead of asking:

> How do I write one giant SQL query?

Think:

```text
What is my starting dataset?
        ↓
What calculation do I need first?
        ↓
What should happen next?
        ↓
What should be filtered?
        ↓
What should the final result contain?
```

Then create one CTE per meaningful step.

---

# 40. Important CTE Patterns

### Basic CTE

```sql
WITH data AS (
    SELECT ...
)
SELECT *
FROM data;
```

### Multiple CTEs

```sql
WITH
step_one AS (...),
step_two AS (...)
SELECT *
FROM step_two;
```

### CTE + Window Function

```sql
WITH ranked AS (
    SELECT
        *,
        ROW_NUMBER() OVER (...) AS rn
    FROM employees
)
SELECT *
FROM ranked
WHERE rn <= 3;
```

### CTE + Aggregation

```sql
WITH totals AS (
    SELECT
        department_id,
        SUM(salary) AS total_salary
    FROM employees
    GROUP BY department_id
)
SELECT *
FROM totals;
```

### Recursive CTE

```sql
WITH RECURSIVE numbers AS (
    SELECT 1 AS n

    UNION ALL

    SELECT n + 1
    FROM numbers
    WHERE n < 10
)
SELECT *
FROM numbers;
```

---

# 41. Common Mistakes

## Mistake 1: Forgetting the CTE alias

Incorrect:

```sql
WITH (
    SELECT *
    FROM employees
)
SELECT *;
```

Correct:

```sql
WITH employees_data AS (
    SELECT *
    FROM employees
)
SELECT *
FROM employees_data;
```

---

## Mistake 2: Forgetting the final query

A CTE must be followed by a query that uses it.

---

## Mistake 3: Referencing a later CTE

CTEs normally reference CTEs defined before them.

Good:

```sql
WITH
first_step AS (...),
second_step AS (
    SELECT *
    FROM first_step
)
SELECT *
FROM second_step;
```

---

## Mistake 4: Recursive CTE without termination

Always include a stopping condition.

---

## Mistake 5: Creating too many unnecessary CTEs

A CTE should represent a meaningful logical step.

---

# 42. Key Takeaways

Remember:

```text
CTE
→ Common Table Expression

WITH
→ starts the CTE definition

AS
→ defines the query

CTE
→ temporary named result for one statement
```

CTEs are especially useful for:

* Complex queries.
* Multi-step analysis.
* Window-function filtering.
* Aggregation pipelines.
* Top-N problems.
* Above-average analysis.
* Hierarchical data.
* Recursive queries.

The most important pattern from this module is:

```text
Base data
   ↓
CTE
   ↓
Transformation
   ↓
CTE
   ↓
Window function / aggregation
   ↓
CTE
   ↓
Filtering
   ↓
Final result
```

By the end of Module 20, you should be able to look at a complicated SQL problem and break it into logical stages instead of trying to solve everything in one enormous query.
