# Module 17 — Common Table Expressions (CTEs)

Common Table Expressions, usually called **CTEs**, provide a clean way to create temporary named result sets inside a SQL statement.

A CTE can make complicated queries easier to read, understand, and maintain.

CTEs are especially useful when a query needs multiple logical steps.

This module uses **MySQL 8.0+** syntax.

---

## 1. What Is a CTE?

A Common Table Expression is a named temporary result set that exists only for the duration of a single SQL statement.

The basic structure is:

```sql
WITH cte_name AS (
    SELECT ...
)
SELECT ...
FROM cte_name;
```

For example:

```sql
WITH high_salary_employees AS (
    SELECT
        employee_id,
        first_name,
        last_name,
        salary
    FROM employees
    WHERE salary >= 60000
)
SELECT *
FROM high_salary_employees;
```

The CTE is defined first and then used by the main query.

Conceptually:

```text
Underlying table
       ↓
   CTE query
       ↓
 Named result
       ↓
 Main SELECT
```

---

## 2. Why Use CTEs?

Without a CTE, a complex query can become difficult to read.

For example:

```sql
SELECT *
FROM (
    SELECT
        department_id,
        AVG(salary) AS average_salary
    FROM employees
    GROUP BY department_id
) AS department_summary
WHERE average_salary > 60000;
```

The same logic can be written with a CTE:

```sql
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
```

The CTE version clearly separates the two logical steps.

---

## 3. Basic CTE Syntax

The general syntax is:

```sql
WITH cte_name AS (
    SELECT
        ...
)
SELECT
    ...
FROM cte_name;
```

The `WITH` clause comes before the main SQL statement.

A CTE can be used with statements such as:

```sql
SELECT
```

and, under appropriate conditions:

```sql
UPDATE
DELETE
```

The focus in this module is primarily on `SELECT` queries.

---

## 4. A Simple CTE

Suppose we want employees whose salary is at least 60000.

```sql
WITH high_salary_employees AS (
    SELECT
        employee_id,
        first_name,
        last_name,
        salary
    FROM employees
    WHERE salary >= 60000
)
SELECT *
FROM high_salary_employees;
```

The CTE is called:

```text
high_salary_employees
```

The main query treats it similarly to a temporary result table.

---

## 5. CTEs Are Statement-Scoped

A CTE exists only for the statement immediately following its definition.

For example:

```sql
WITH high_salary_employees AS (
    SELECT *
    FROM employees
    WHERE salary >= 60000
)
SELECT *
FROM high_salary_employees;
```

The CTE is available to that query.

This will not work afterward:

```sql
SELECT *
FROM high_salary_employees;
```

because the CTE no longer exists.

This is an important difference between a CTE and a database view.

---

## 6. CTEs vs Views

A view is a persistent database object.

A CTE exists only within one statement.

### View

```sql
CREATE VIEW high_salary_employees AS
SELECT *
FROM employees
WHERE salary >= 60000;
```

The view can later be queried:

```sql
SELECT *
FROM high_salary_employees;
```

### CTE

```sql
WITH high_salary_employees AS (
    SELECT *
    FROM employees
    WHERE salary >= 60000
)
SELECT *
FROM high_salary_employees;
```

The CTE disappears after the statement finishes.

A useful rule is:

```text
VIEW → reusable database object

CTE → reusable query component within one statement
```

---

# 7. CTEs vs Temporary Tables

A temporary table stores rows temporarily.

For example:

```sql
CREATE TEMPORARY TABLE high_salary_employees AS
SELECT *
FROM employees
WHERE salary >= 60000;
```

A CTE does not create a temporary table that you manually manage.

Instead:

```sql
WITH high_salary_employees AS (
    SELECT *
    FROM employees
    WHERE salary >= 60000
)
SELECT *
FROM high_salary_employees;
```

The CTE is part of the SQL statement.

Use a temporary table when you need temporary stored data across multiple statements.

Use a CTE when you need an intermediate result as part of one query.

---

# 8. CTEs vs Derived Tables

A derived table is a subquery in the `FROM` clause.

Example:

```sql
SELECT *
FROM (
    SELECT
        department_id,
        AVG(salary) AS average_salary
    FROM employees
    GROUP BY department_id
) AS department_summary;
```

A CTE can express the same idea more clearly:

```sql
WITH department_summary AS (
    SELECT
        department_id,
        AVG(salary) AS average_salary
    FROM employees
    GROUP BY department_id
)
SELECT *
FROM department_summary;
```

Both approaches can be useful.

CTEs are often easier to read when the query contains multiple logical steps.

---

# 9. CTE with Filtering

A CTE can perform filtering before the main query.

```sql
WITH technology_employees AS (
    SELECT
        e.employee_id,
        e.first_name,
        e.last_name,
        e.salary,
        d.department_name
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
ORDER BY salary DESC;
```

The first step identifies Technology employees.

The second step sorts the result.

---

# 10. CTE with Aggregation

CTEs are very useful with aggregate queries.

Example:

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

The CTE contains the grouped result.

The outer query can then filter or sort it.

---

# 11. Filtering an Aggregate Result with a CTE

Suppose we only want departments whose average salary is above 60000.

```sql
WITH department_salary AS (
    SELECT
        department_id,
        AVG(salary) AS average_salary
    FROM employees
    GROUP BY department_id
)
SELECT
    department_id,
    average_salary
FROM department_salary
WHERE average_salary > 60000;
```

This is an alternative to using `HAVING`.

Both approaches can be appropriate.

---

# 12. Multiple CTEs

A single query can contain multiple CTEs.

Syntax:

```sql
WITH
first_cte AS (
    SELECT ...
),
second_cte AS (
    SELECT ...
)
SELECT ...
FROM first_cte
JOIN second_cte
    ON ...;
```

For example:

```sql
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
)
SELECT
    d.department_name,
    e.employee_count
FROM department_details AS d
INNER JOIN employee_counts AS e
    ON d.department_id = e.department_id;
```

Multiple CTEs allow a complex problem to be divided into logical steps.

---

# 13. One CTE Can Reference Another CTE

Later CTEs can use earlier CTEs in the same `WITH` clause.

Example:

```sql
WITH department_salary AS (
    SELECT
        department_id,
        AVG(salary) AS average_salary
    FROM employees
    GROUP BY department_id
),
high_salary_departments AS (
    SELECT
        department_id,
        average_salary
    FROM department_salary
    WHERE average_salary > 60000
)
SELECT *
FROM high_salary_departments;
```

The dependency is:

```text
employees
    ↓
department_salary
    ↓
high_salary_departments
    ↓
main query
```

This creates a readable sequence of operations.

---

# 14. CTE with JOIN

A CTE can prepare one dataset and then join it to another table.

Example:

```sql
WITH employee_counts AS (
    SELECT
        department_id,
        COUNT(*) AS employee_count
    FROM employees
    GROUP BY department_id
)
SELECT
    d.department_name,
    e.employee_count
FROM departments AS d
INNER JOIN employee_counts AS e
    ON d.department_id = e.department_id;
```

The CTE calculates employee counts.

The outer query adds the department name.

---

# 15. CTE with Calculated Columns

A CTE can create calculated columns.

```sql
WITH employee_salary AS (
    SELECT
        employee_id,
        first_name,
        salary,
        salary * 12 AS annual_salary
    FROM employees
)
SELECT
    employee_id,
    first_name,
    annual_salary
FROM employee_salary
ORDER BY annual_salary DESC;
```

This makes the calculation available to the outer query.

---

# 16. CTE with Multiple Conditions

A CTE can contain normal filtering logic.

```sql
WITH selected_employees AS (
    SELECT
        employee_id,
        first_name,
        salary,
        department_id
    FROM employees
    WHERE salary >= 55000
      AND department_id IN (1, 2)
)
SELECT *
FROM selected_employees
ORDER BY salary DESC;
```

The CTE can therefore use many concepts learned earlier.

---

# 17. CTE with LIMIT

A CTE can contain `ORDER BY` and `LIMIT` when the intermediate result needs to be restricted.

Example:

```sql
WITH highest_paid AS (
    SELECT
        employee_id,
        first_name,
        salary
    FROM employees
    ORDER BY salary DESC
    LIMIT 3
)
SELECT *
FROM highest_paid;
```

This first identifies the three highest-paid employees.

---

# 18. CTE for Multi-Step Analysis

One of the biggest benefits of CTEs is breaking a problem into steps.

Suppose we want to find departments whose average salary is greater than the company-wide average salary.

Step 1:

Calculate each department's average:

```sql
WITH department_average AS (
    SELECT
        department_id,
        AVG(salary) AS average_salary
    FROM employees
    GROUP BY department_id
)
SELECT *
FROM department_average;
```

Then calculate the overall average:

```sql
SELECT AVG(salary)
FROM employees;
```

With a CTE, both logical results can be used together:

```sql
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
    d.average_salary
FROM department_average AS d
CROSS JOIN company_average AS c
WHERE d.average_salary > c.average_salary;
```

This demonstrates why CTEs become valuable as SQL problems become more complex.

---

# 19. CTEs and NULL Values

CTEs do not change how `NULL` works.

For example:

```sql
WITH employee_emails AS (
    SELECT
        employee_id,
        email
    FROM employees
)
SELECT *
FROM employee_emails
WHERE email IS NULL;
```

The normal SQL rules for `NULL` still apply.

Use:

```sql
IS NULL
```

instead of:

```sql
= NULL
```

---

# 20. Naming CTEs

Use meaningful names.

Good:

```text
high_salary_employees
department_salary
employee_counts
company_average
customer_orders
```

Avoid:

```text
x
temp1
data
abc
```

A CTE name should communicate what the result represents.

---

# 21. Column Names in CTEs

A CTE can use aliases inside its query.

```sql
WITH employee_summary AS (
    SELECT
        employee_id,
        CONCAT(first_name, ' ', last_name) AS employee_name,
        salary * 12 AS annual_salary
    FROM employees
)
SELECT
    employee_id,
    employee_name,
    annual_salary
FROM employee_summary;
```

The outer query can use those aliases.

---

# 22. Explicit CTE Column Lists

MySQL also allows column names to be specified after the CTE name.

Example:

```sql
WITH employee_summary (
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
FROM employee_summary;
```

This can make the intended output structure explicit.

However, using aliases directly inside the CTE is often easier for beginners to read.

---

# 23. Recursive CTEs

MySQL 8.0 also supports **recursive CTEs**.

A recursive CTE can refer to itself.

A simplified example is:

```sql
WITH RECURSIVE numbers AS (
    SELECT 1 AS number

    UNION ALL

    SELECT number + 1
    FROM numbers
    WHERE number < 5
)
SELECT *
FROM numbers;
```

This produces:

```text
1
2
3
4
5
```

Recursive CTEs can be useful for:

* Hierarchical data
* Organizational structures
* Tree-like relationships
* Generating sequences

Recursive CTEs are introduced here only at a basic level. More advanced recursive techniques should be studied separately after the fundamentals are comfortable.

---

# 24. Recursive CTE Structure

A recursive CTE generally contains two parts.

### Anchor member

The starting query:

```sql
SELECT 1 AS number
```

### Recursive member

The query that references the CTE:

```sql
SELECT number + 1
FROM numbers
WHERE number < 5
```

They are combined with:

```sql
UNION ALL
```

The general pattern is:

```sql
WITH RECURSIVE cte_name AS (
    -- Anchor member
    SELECT ...

    UNION ALL

    -- Recursive member
    SELECT ...
    FROM cte_name
    WHERE ...
)
SELECT *
FROM cte_name;
```

A termination condition is extremely important.

Without a proper stopping condition, a recursive query can continue generating rows until MySQL reaches its recursion limit or the query fails.

---

# 25. CTEs and Query Readability

A major advantage of CTEs is readability.

Instead of writing one large query:

```text
SELECT
    ...
FROM
    ...
JOIN
    ...
WHERE
    ...
GROUP BY
    ...
HAVING
    ...
```

you can break the logic into meaningful stages:

```text
WITH
step_one AS (...),
step_two AS (...),
step_three AS (...)
SELECT ...
FROM step_three;
```

Each CTE should ideally represent a meaningful logical step.

---

# 26. CTEs Do Not Automatically Improve Performance

A common misconception is:

> "Using a CTE automatically makes a query faster."

That is not necessarily true.

CTEs primarily help with:

* Organization
* Readability
* Maintainability
* Breaking complex logic into steps

Query performance depends on many factors, including:

* Data size
* Indexes
* Join strategy
* Filtering
* Aggregation
* Query execution plan
* MySQL optimizer behavior

Use CTEs because they make the query clearer, not simply because they look more advanced.

---

# 27. Common Mistakes

## Mistake 1: Forgetting the main query

This is incomplete:

```sql
WITH high_salary AS (
    SELECT *
    FROM employees
    WHERE salary >= 60000
);
```

A CTE must be followed by the statement that uses it.

Correct:

```sql
WITH high_salary AS (
    SELECT *
    FROM employees
    WHERE salary >= 60000
)
SELECT *
FROM high_salary;
```

---

## Mistake 2: Trying to use a CTE in another statement

This will not work:

```sql
WITH high_salary AS (
    SELECT *
    FROM employees
    WHERE salary >= 60000
)
SELECT *
FROM high_salary;

SELECT *
FROM high_salary;
```

The second query cannot use the CTE.

---

## Mistake 3: Poor CTE names

Avoid:

```sql
WITH x AS (...)
```

Prefer:

```sql
WITH high_salary_employees AS (...)
```

---

## Mistake 4: Creating unnecessary CTEs

Not every simple query needs a CTE.

This is unnecessarily complicated:

```sql
WITH all_employees AS (
    SELECT *
    FROM employees
)
SELECT *
FROM all_employees;
```

If there is no meaningful reason for the CTE, a normal query is simpler:

```sql
SELECT *
FROM employees;
```

---

## Mistake 5: Forgetting dependencies between CTEs

If one CTE references another, the referenced CTE must be defined appropriately in the `WITH` clause.

---

## Mistake 6: Incorrect recursive termination

Recursive CTEs require a clear stopping condition.

Always test recursive queries carefully.

---

# 28. Best Practices

Use CTEs when they improve readability or break a complicated query into logical stages.

Give CTEs descriptive names.

Keep each CTE focused on one logical task when possible.

Use aliases for calculated columns.

Avoid creating unnecessary CTE layers.

Do not assume a CTE automatically improves performance.

Use recursive CTEs carefully and always include a termination condition.

For frequently reused queries across many statements, consider whether a view is more appropriate.

---

# 29. Practical Decision Guide

Use a **CTE** when:

* The logic is needed only in one statement.
* You need to break a complex query into steps.
* You want readable intermediate results.
* You need multiple related intermediate datasets.

Use a **VIEW** when:

* The query should be reusable across many statements.
* You want a persistent database object.
* You are building a reporting interface.

Use a **TEMPORARY TABLE** when:

* Intermediate rows need to persist across multiple statements in a session.
* You need to manipulate or repeatedly query temporary data.

Use a **derived table** when:

* The intermediate query is small.
* A CTE would not make the query significantly clearer.

---

# 30. Key Takeaways

A CTE is a named temporary result set defined with:

```sql
WITH
```

A basic CTE looks like:

```sql
WITH cte_name AS (
    SELECT ...
)
SELECT *
FROM cte_name;
```

CTEs:

* Exist only for one SQL statement.
* Improve query readability.
* Can contain filters.
* Can contain joins.
* Can contain aggregates.
* Can contain calculated columns.
* Can be combined with multiple CTEs.
* Can reference earlier CTEs.
* Can be used for multi-step analysis.
* Can be recursive in MySQL 8.0+.

The key distinction is:

```text
VIEW
Persistent reusable database object

CTE
Statement-scoped query component

TEMPORARY TABLE
Session-scoped temporary stored data

DERIVED TABLE
Subquery used as a table within one query
```

The goal is not to use CTEs everywhere. The goal is to use them when they make SQL easier to understand and maintain.
