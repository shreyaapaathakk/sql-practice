# Module 18 — CASE Expressions

The `CASE` expression allows SQL to perform conditional logic.

It is similar to:

* `if / else` in programming
* `if / elif / else` logic
* Conditional classification

`CASE` is one of the most important SQL tools for transforming and categorizing data.

This module uses **MySQL 8.0+** syntax.

---

## 1. What Is a CASE Expression?

A `CASE` expression evaluates conditions and returns a value based on which condition is true.

Basic syntax:

```sql
CASE
    WHEN condition THEN result
    WHEN condition THEN result
    ELSE result
END
```

Example:

```sql
SELECT
    first_name,
    salary,
    CASE
        WHEN salary >= 70000 THEN 'High'
        WHEN salary >= 50000 THEN 'Medium'
        ELSE 'Low'
    END AS salary_level
FROM employees;
```

The query creates a new calculated column called `salary_level`.

---

## 2. CASE Is an Expression

`CASE` is an expression rather than a standalone SQL statement.

It can be used inside:

* `SELECT`
* `ORDER BY`
* `GROUP BY`
* `HAVING`
* `WHERE`
* `UPDATE`
* `INSERT`

The most common use is inside `SELECT`.

---

## 3. Simple CASE

There are two major forms of `CASE`.

The first is called a **simple CASE expression**.

Syntax:

```sql
CASE expression
    WHEN value1 THEN result1
    WHEN value2 THEN result2
    ELSE result
END
```

Example:

```sql
SELECT
    first_name,
    department_id,
    CASE department_id
        WHEN 1 THEN 'Sales'
        WHEN 2 THEN 'Technology'
        WHEN 3 THEN 'Human Resources'
        WHEN 4 THEN 'Finance'
        ELSE 'Unknown'
    END AS department_name
FROM employees;
```

The expression after `CASE` is compared against each `WHEN` value.

---

## 4. Searched CASE

The second form is the **searched CASE expression**.

Syntax:

```sql
CASE
    WHEN condition THEN result
    WHEN condition THEN result
    ELSE result
END
```

Example:

```sql
SELECT
    first_name,
    salary,
    CASE
        WHEN salary >= 70000 THEN 'High'
        WHEN salary >= 50000 THEN 'Medium'
        ELSE 'Low'
    END AS salary_level
FROM employees;
```

Here, each `WHEN` contains a condition.

---

## 5. Simple CASE vs Searched CASE

### Simple CASE

```sql
CASE department_id
    WHEN 1 THEN 'Sales'
    WHEN 2 THEN 'Technology'
    ELSE 'Other'
END
```

Useful when comparing one expression against specific values.

### Searched CASE

```sql
CASE
    WHEN salary >= 70000 THEN 'High'
    WHEN salary >= 50000 THEN 'Medium'
    ELSE 'Low'
END
```

Useful when conditions involve:

* Comparisons
* Ranges
* Multiple columns
* Boolean expressions

A useful rule:

```text
Specific values → Simple CASE

Conditions/ranges → Searched CASE
```

---

## 6. The ELSE Clause

`ELSE` defines the value returned when none of the `WHEN` conditions are true.

Example:

```sql
SELECT
    first_name,
    salary,
    CASE
        WHEN salary >= 70000 THEN 'High'
        WHEN salary >= 50000 THEN 'Medium'
        ELSE 'Low'
    END AS salary_level
FROM employees;
```

If salary is below 50000, the result is:

```text
Low
```

---

## 7. What Happens Without ELSE?

If no `WHEN` condition matches and there is no `ELSE`, the result is `NULL`.

Example:

```sql
SELECT
    first_name,
    CASE
        WHEN salary >= 70000 THEN 'High'
    END AS salary_level
FROM employees;
```

Employees earning less than 70000 receive:

```text
NULL
```

For predictable output, an `ELSE` is often a good idea.

---

## 8. CASE Conditions Are Evaluated in Order

Consider:

```sql
CASE
    WHEN salary >= 50000 THEN 'Medium'
    WHEN salary >= 70000 THEN 'High'
    ELSE 'Low'
END
```

An employee earning 80000 satisfies the first condition:

```sql
salary >= 50000
```

Therefore, the result is:

```text
Medium
```

The later condition is never reached for that row.

This means **the order of `WHEN` conditions matters**.

Correct ordering:

```sql
CASE
    WHEN salary >= 70000 THEN 'High'
    WHEN salary >= 50000 THEN 'Medium'
    ELSE 'Low'
END
```

---

## 9. CASE with Numeric Ranges

CASE is very useful for categorizing numerical values.

```sql
SELECT
    first_name,
    salary,
    CASE
        WHEN salary < 50000 THEN 'Low Salary'
        WHEN salary BETWEEN 50000 AND 69999 THEN 'Mid Salary'
        ELSE 'High Salary'
    END AS salary_category
FROM employees;
```

This converts numerical values into meaningful categories.

---

## 10. CASE with Dates

CASE can also classify dates.

```sql
SELECT
    first_name,
    hire_date,
    CASE
        WHEN hire_date < '2022-01-01' THEN 'Experienced'
        WHEN hire_date < '2024-01-01' THEN 'Recent'
        ELSE 'New'
    END AS employee_type
FROM employees;
```

Dates can therefore be divided into useful business categories.

---

## 11. CASE with Strings

CASE can compare text values.

```sql
SELECT
    first_name,
    last_name,
    CASE
        WHEN first_name = 'Aarav' THEN 'Matched'
        ELSE 'Not Matched'
    END AS match_status
FROM employees;
```

It can also be used with other string expressions.

---

## 12. CASE with Multiple Conditions

Conditions can be combined using:

```sql
AND
OR
```

Example:

```sql
SELECT
    first_name,
    salary,
    department_id,
    CASE
        WHEN salary >= 70000 AND department_id = 2
            THEN 'Senior Technology Employee'
        WHEN salary >= 70000
            THEN 'High Salary Employee'
        ELSE 'Standard Employee'
    END AS employee_category
FROM employees;
```

---

## 13. CASE with IN

CASE can use `IN`.

```sql
SELECT
    first_name,
    department_id,
    CASE
        WHEN department_id IN (1, 4) THEN 'Business'
        WHEN department_id = 2 THEN 'Technology'
        ELSE 'Other'
    END AS department_group
FROM employees;
```

---

## 14. CASE with NULL

Use `IS NULL` when checking for `NULL`.

Correct:

```sql
CASE
    WHEN email IS NULL THEN 'Missing Email'
    ELSE 'Email Available'
END
```

Incorrect:

```sql
CASE
    WHEN email = NULL THEN 'Missing Email'
END
```

`NULL` does not behave like an ordinary value.

---

## 15. CASE for NULL Replacement

CASE can be used to provide a replacement value.

```sql
SELECT
    first_name,
    CASE
        WHEN email IS NULL THEN 'No Email'
        ELSE email
    END AS contact_email
FROM employees;
```

This is one of the practical uses of conditional expressions.

---

## 16. CASE with Aggregates

CASE can be combined with aggregate functions.

For example, count employees earning at least 60000:

```sql
SELECT
    SUM(
        CASE
            WHEN salary >= 60000 THEN 1
            ELSE 0
        END
    ) AS high_salary_count
FROM employees;
```

This technique is often called **conditional aggregation**.

---

## 17. Conditional COUNT

Another approach is:

```sql
SELECT
    COUNT(
        CASE
            WHEN salary >= 60000 THEN 1
        END
    ) AS high_salary_count
FROM employees;
```

The CASE returns `1` for qualifying employees and `NULL` otherwise.

`COUNT(expression)` counts non-NULL values.

---

## 18. Conditional SUM

Suppose we want total salaries of employees earning at least 60000:

```sql
SELECT
    SUM(
        CASE
            WHEN salary >= 60000 THEN salary
            ELSE 0
        END
    ) AS high_salary_total
FROM employees;
```

This is useful for financial reporting and business analysis.

---

## 19. Conditional Aggregation by Department

CASE becomes even more useful with `GROUP BY`.

```sql
SELECT
    department_id,
    SUM(
        CASE
            WHEN salary >= 60000 THEN 1
            ELSE 0
        END
    ) AS high_salary_employees
FROM employees
GROUP BY department_id;
```

This calculates the number of high-salary employees per department.

---

## 20. Multiple Conditional Aggregates

A single query can calculate several categories.

```sql
SELECT
    department_id,

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

FROM employees
GROUP BY department_id;
```

This produces a compact summary report.

---

## 21. CASE in ORDER BY

CASE can control sorting.

Example:

```sql
SELECT
    first_name,
    salary,
    department_id
FROM employees
ORDER BY
    CASE
        WHEN department_id = 2 THEN 1
        WHEN department_id = 1 THEN 2
        ELSE 3
    END,
    first_name;
```

Technology employees appear first, followed by Sales employees, followed by other departments.

---

## 22. CASE in GROUP BY

CASE can create groups dynamically.

```sql
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
    END;
```

The salary ranges become groups.

---

## 23. CASE in HAVING

A CASE expression can also be used with `HAVING`.

Example:

```sql
SELECT
    department_id,
    AVG(salary) AS average_salary
FROM employees
GROUP BY department_id
HAVING
    CASE
        WHEN AVG(salary) >= 60000 THEN 1
        ELSE 0
    END = 1;
```

However, a simpler condition is usually preferable:

```sql
HAVING AVG(salary) >= 60000
```

Do not use CASE when a normal condition already expresses the logic clearly.

---

## 24. CASE with JOINs

CASE can classify joined data.

```sql
SELECT
    e.first_name,
    d.department_name,
    CASE
        WHEN d.department_name = 'Technology'
            THEN 'Technical'
        ELSE 'Non-Technical'
    END AS department_type
FROM employees AS e
INNER JOIN departments AS d
    ON e.department_id = d.department_id;
```

This combines joins with conditional classification.

---

## 25. CASE with CTEs

CASE and CTEs work very well together.

Example:

```sql
WITH employee_categories AS (
    SELECT
        employee_id,
        first_name,
        salary,
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
GROUP BY salary_level;
```

The CTE creates the classification.

The outer query analyzes it.

This combines two important concepts from Modules 17 and 18.

---

## 26. CASE for Business Rules

CASE is frequently used to represent business rules.

For example:

```sql
CASE
    WHEN total_amount >= 5000 THEN 'Premium'
    WHEN total_amount >= 2000 THEN 'Standard'
    ELSE 'Basic'
END
```

The SQL query converts raw data into business categories.

Common examples include:

* Customer segments
* Salary bands
* Product categories
* Risk levels
* Performance levels
* Order sizes
* Age groups
* Employee classifications

---

## 27. Nested CASE

A CASE expression can contain another CASE expression.

Example:

```sql
SELECT
    first_name,
    salary,
    department_id,
    CASE
        WHEN salary >= 70000 THEN
            CASE
                WHEN department_id = 2 THEN 'Senior Technology'
                ELSE 'Senior Employee'
            END
        ELSE 'Other Employee'
    END AS employee_category
FROM employees;
```

Nested CASE expressions are valid, but they can become difficult to read.

If the logic becomes complicated, consider using multiple CTEs.

---

## 28. Avoiding Excessive Nested CASE

Instead of creating deeply nested CASE expressions, break the problem into steps.

For example:

```sql
WITH employee_category AS (
    SELECT
        employee_id,
        first_name,
        salary,
        department_id,
        CASE
            WHEN salary >= 70000 THEN 'High'
            WHEN salary >= 50000 THEN 'Medium'
            ELSE 'Low'
        END AS salary_level
    FROM employees
)
SELECT
    employee_id,
    first_name,
    salary_level,
    CASE
        WHEN salary_level = 'High'
             AND department_id = 2
            THEN 'Senior Technology'
        ELSE salary_level
    END AS final_category
FROM employee_category;
```

This is often easier to understand.

---

## 29. CASE vs IF

MySQL also provides an `IF()` function:

```sql
IF(condition, true_value, false_value)
```

Example:

```sql
SELECT
    first_name,
    IF(salary >= 60000, 'High', 'Low') AS salary_level
FROM employees;
```

For simple two-way conditions, `IF()` can be convenient.

However, CASE is more flexible:

```sql
CASE
    WHEN salary >= 70000 THEN 'High'
    WHEN salary >= 50000 THEN 'Medium'
    ELSE 'Low'
END
```

CASE is also standard SQL and is therefore a valuable skill beyond MySQL.

---

## 30. CASE vs COALESCE

`COALESCE()` is designed specifically for handling NULL values.

Example:

```sql
SELECT
    COALESCE(email, 'No Email') AS contact_email
FROM employees;
```

The equivalent CASE logic is:

```sql
SELECT
    CASE
        WHEN email IS NULL THEN 'No Email'
        ELSE email
    END AS contact_email
FROM employees;
```

For simple NULL replacement, `COALESCE()` may be clearer.

Use CASE when actual conditional logic is required.

---

## 31. CASE and Data Transformation

CASE can transform existing data into a more useful representation.

Raw data:

```text
salary
------
48000
55000
72000
85000
```

CASE transformation:

```text
salary     salary_level
48000      Low
55000      Medium
72000      High
85000      High
```

This is an important concept in data analysis:

```text
Raw data
   ↓
Conditional transformation
   ↓
Meaningful categories
   ↓
Analysis
```

---

## 32. Common Mistakes

### Mistake 1: Forgetting END

Incorrect:

```sql
CASE
    WHEN salary >= 60000 THEN 'High'
```

Correct:

```sql
CASE
    WHEN salary >= 60000 THEN 'High'
    ELSE 'Low'
END
```

---

### Mistake 2: Incorrect condition order

Incorrect:

```sql
CASE
    WHEN salary >= 50000 THEN 'Medium'
    WHEN salary >= 70000 THEN 'High'
END
```

The high-salary condition is effectively hidden by the first condition.

Correct:

```sql
CASE
    WHEN salary >= 70000 THEN 'High'
    WHEN salary >= 50000 THEN 'Medium'
    ELSE 'Low'
END
```

---

### Mistake 3: Forgetting ELSE

Without ELSE, unmatched rows produce `NULL`.

---

### Mistake 4: Comparing NULL with =

Incorrect:

```sql
email = NULL
```

Correct:

```sql
email IS NULL
```

---

### Mistake 5: Overusing CASE

CASE is powerful, but not every query needs it.

Avoid:

```sql
CASE
    WHEN department_id = 2 THEN 'Technology'
END
```

if the original department name is already available through a JOIN.

---

## 33. CASE and Query Readability

Good CASE:

```sql
CASE
    WHEN salary >= 70000 THEN 'High'
    WHEN salary >= 50000 THEN 'Medium'
    ELSE 'Low'
END AS salary_level
```

Poor CASE:

```sql
CASE WHEN salary>=70000 THEN 'High' WHEN salary>=50000
THEN 'Medium' ELSE 'Low' END
```

Both may work, but formatting matters.

Use indentation so that each condition is easy to identify.

---

## 34. Practical Pattern: Classification

A common SQL pattern is:

```sql
CASE
    WHEN condition_1 THEN 'Category 1'
    WHEN condition_2 THEN 'Category 2'
    ELSE 'Category 3'
END
```

This is useful whenever raw values need to be converted into categories.

---

## 35. Practical Pattern: Conditional Counting

A common analytical pattern is:

```sql
SUM(
    CASE
        WHEN condition THEN 1
        ELSE 0
    END
)
```

Example:

```sql
SELECT
    SUM(
        CASE
            WHEN salary >= 60000 THEN 1
            ELSE 0
        END
    ) AS high_salary_count
FROM employees;
```

Remember this pattern. It appears frequently in SQL interviews and real-world analytics.

---

## 36. Practical Pattern: Conditional Summation

```sql
SUM(
    CASE
        WHEN condition THEN amount
        ELSE 0
    END
)
```

Example:

```sql
SELECT
    SUM(
        CASE
            WHEN total_amount >= 2000 THEN total_amount
            ELSE 0
        END
    ) AS large_order_sales
FROM orders;
```

---

## 37. Practical Pattern: Conditional Average

You can also calculate an average for a condition.

```sql
SELECT
    AVG(
        CASE
            WHEN department_id = 2 THEN salary
        END
    ) AS technology_average_salary
FROM employees;
```

Rows that do not satisfy the condition return `NULL`.

`AVG()` ignores NULL values.

---

## 38. Key Takeaways

The basic searched CASE syntax is:

```sql
CASE
    WHEN condition THEN result
    WHEN condition THEN result
    ELSE result
END
```

The simple CASE syntax is:

```sql
CASE expression
    WHEN value THEN result
    WHEN value THEN result
    ELSE result
END
```

Important rules:

* Always close CASE with `END`.
* `WHEN` conditions are evaluated in order.
* The first matching condition determines the result.
* `ELSE` handles unmatched cases.
* Without `ELSE`, unmatched cases return `NULL`.
* Use `IS NULL` for NULL checks.
* CASE can be used in many parts of SQL.
* CASE is especially useful for classification.
* CASE works extremely well with aggregate functions.
* Conditional aggregation is an important SQL technique.
* CASE can be combined with CTEs.
* Avoid unnecessarily complicated nested CASE expressions.

The most important pattern to remember is:

```sql
SUM(
    CASE
        WHEN condition THEN 1
        ELSE 0
    END
)
```

This is the foundation of many SQL reporting and analytics queries.
