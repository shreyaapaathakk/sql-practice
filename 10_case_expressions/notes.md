# Module 10 — CASE Expressions

Module 10 continues directly from **Subqueries** and introduces `CASE`, one of the most useful SQL features for turning raw data into meaningful categories and business-friendly reports.

The module follows the same repository pattern and uses **MySQL 8.0+** syntax.

## Repository structure

```text
sql-practice/
└── 10_case_expressions/
    ├── notes.md
    ├── examples.sql
    ├── practice.sql
    ├── solutions.sql
    └── challenge.sql
```

---

# `10_case_expressions/notes.md`

````markdown
# Module 10 — CASE Expressions

## Overview

The `CASE` expression allows SQL to perform conditional logic.

It is similar to an `if / else if / else` structure in programming.

For example:

```sql
SELECT
    first_name,
    age,
    CASE
        WHEN age >= 21 THEN 'Adult'
        ELSE 'Young'
    END AS age_group
FROM students;
````

Instead of returning only the original age, SQL creates a new category based on the value of `age`.

`CASE` is extremely useful for:

* categorizing data
* creating labels
* conditional calculations
* conditional sorting
* business reports
* data analysis
* grouping values
* handling multiple conditions

---

# 1. Basic CASE Syntax

The most common form is called a searched CASE expression.

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
    age,
    CASE
        WHEN age >= 21 THEN 'Adult'
        ELSE 'Young'
    END AS age_group
FROM students;
```

The `CASE` expression checks the conditions from top to bottom.

The first matching condition is used.

---

# 2. CASE Works Like Conditional Logic

Consider:

```sql
CASE
    WHEN age >= 21 THEN 'Adult'
    ELSE 'Young'
END
```

Conceptually:

```text
IF age >= 21
    return 'Adult'
ELSE
    return 'Young'
```

This makes CASE useful for transforming raw database values into understandable categories.

---

# 3. Multiple WHEN Conditions

A CASE expression can contain multiple conditions.

```sql
SELECT
    first_name,
    age,
    CASE
        WHEN age < 20 THEN 'Teen'
        WHEN age < 22 THEN 'Young Adult'
        ELSE 'Adult'
    END AS age_group
FROM students;
```

The conditions are evaluated from top to bottom.

---

# 4. Order of WHEN Conditions Matters

Consider:

```sql
CASE
    WHEN age >= 18 THEN 'Adult'
    WHEN age >= 21 THEN '21+'
    ELSE 'Under 18'
END
```

The second condition will never be reached for ages 21 or above.

Why?

Because an age of 21 already satisfies:

```text
age >= 18
```

The first matching condition wins.

A better version is:

```sql
CASE
    WHEN age >= 21 THEN '21+'
    WHEN age >= 18 THEN 'Adult'
    ELSE 'Under 18'
END
```

Always consider the order of overlapping conditions.

---

# 5. ELSE

`ELSE` defines what happens when none of the WHEN conditions match.

Example:

```sql
CASE
    WHEN age >= 21 THEN 'Adult'
    ELSE 'Young'
END
```

If no condition matches and there is no ELSE, SQL returns `NULL`.

Example:

```sql
CASE
    WHEN age >= 21 THEN 'Adult'
END
```

Students younger than 21 will receive `NULL`.

For beginner-friendly reports, using an explicit ELSE is usually clearer.

---

# 6. CASE With Aliases

CASE expressions can be given aliases.

```sql
SELECT
    first_name,
    age,
    CASE
        WHEN age >= 21 THEN 'Adult'
        ELSE 'Young'
    END AS age_group
FROM students;
```

The resulting column is called:

```text
age_group
```

Aliases make reports easier to understand.

---

# 7. Simple CASE

There are two major forms of CASE.

The first is the simple CASE expression.

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
    city,
    CASE city
        WHEN 'Delhi' THEN 'North'
        WHEN 'Mumbai' THEN 'West'
        WHEN 'Pune' THEN 'West'
        ELSE 'Other'
    END AS region
FROM students;
```

The expression:

```sql
city
```

is compared with each WHEN value.

---

# 8. Searched CASE

A searched CASE uses conditions.

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
    age,
    CASE
        WHEN age >= 21 THEN 'Older Student'
        WHEN age >= 20 THEN '20-Year-Old'
        ELSE 'Younger Student'
    END AS category
FROM students;
```

This form is more flexible because conditions can use operators such as:

```text
=
<>
>
<
>=
<=
AND
OR
IN
BETWEEN
IS NULL
```

---

# 9. Simple CASE vs Searched CASE

Simple CASE:

```sql
CASE city
    WHEN 'Delhi' THEN 'North'
    WHEN 'Mumbai' THEN 'West'
    ELSE 'Other'
END
```

Searched CASE:

```sql
CASE
    WHEN city = 'Delhi' THEN 'North'
    WHEN city = 'Mumbai' THEN 'West'
    ELSE 'Other'
END
```

Simple CASE is convenient when comparing one expression against specific values.

Searched CASE is better when conditions are more complex.

---

# 10. CASE With Comparison Operators

Example:

```sql
SELECT
    first_name,
    age,
    CASE
        WHEN age > 20 THEN 'Above 20'
        WHEN age = 20 THEN 'Exactly 20'
        ELSE 'Below 20'
    END AS age_status
FROM students;
```

---

# 11. CASE With AND

Multiple conditions can be combined using AND.

```sql
SELECT
    first_name,
    age,
    city,
    CASE
        WHEN age >= 20 AND city = 'Delhi'
            THEN 'Delhi Student 20+'
        ELSE 'Other'
    END AS category
FROM students;
```

Both conditions must be true.

---

# 12. CASE With OR

Example:

```sql
SELECT
    first_name,
    city,
    CASE
        WHEN city = 'Delhi' OR city = 'Mumbai'
            THEN 'Major City'
        ELSE 'Other City'
    END AS city_type
FROM students;
```

At least one condition must be true.

---

# 13. CASE With IN

Example:

```sql
SELECT
    first_name,
    city,
    CASE
        WHEN city IN ('Delhi', 'Mumbai', 'Pune')
            THEN 'Selected City'
        ELSE 'Other City'
    END AS city_group
FROM students;
```

---

# 14. CASE With BETWEEN

Example:

```sql
SELECT
    first_name,
    age,
    CASE
        WHEN age BETWEEN 19 AND 20 THEN '19-20'
        WHEN age BETWEEN 21 AND 22 THEN '21-22'
        ELSE 'Other'
    END AS age_range
FROM students;
```

---

# 15. CASE With NULL

CASE can check for NULL.

```sql
SELECT
    first_name,
    city,
    CASE
        WHEN city IS NULL THEN 'City Unknown'
        ELSE city
    END AS city_display
FROM students;
```

Remember:

Do not use:

```sql
city = NULL
```

Use:

```sql
city IS NULL
```

---

# 16. CASE in SELECT

The most common use of CASE is inside SELECT.

```sql
SELECT
    first_name,
    age,
    CASE
        WHEN age >= 21 THEN 'Adult'
        ELSE 'Young'
    END AS age_group
FROM students;
```

This creates a calculated column.

---

# 17. CASE in ORDER BY

CASE can control sorting.

Example:

```sql
SELECT
    first_name,
    city
FROM students
ORDER BY
    CASE city
        WHEN 'Delhi' THEN 1
        WHEN 'Mumbai' THEN 2
        WHEN 'Pune' THEN 3
        ELSE 4
    END;
```

This allows custom ordering instead of normal alphabetical ordering.

---

# 18. CASE for Priority Sorting

Suppose we want Delhi students first, then Mumbai, then everyone else.

```sql
SELECT
    first_name,
    city
FROM students
ORDER BY
    CASE
        WHEN city = 'Delhi' THEN 1
        WHEN city = 'Mumbai' THEN 2
        ELSE 3
    END,
    first_name;
```

The second sort criterion sorts names within each priority group.

---

# 19. CASE With Arithmetic

CASE can be used inside calculations.

Example:

```sql
SELECT
    first_name,
    age,
    CASE
        WHEN age >= 21 THEN age + 1
        ELSE age
    END AS adjusted_age
FROM students;
```

The result is calculated separately for each row.

---

# 20. CASE for Conditional Values

Example:

```sql
SELECT
    first_name,
    city,
    CASE
        WHEN city = 'Delhi' THEN 'Capital Region'
        ELSE 'Other Region'
    END AS region_type
FROM students;
```

---

# 21. Multiple CASE Expressions

A query can contain more than one CASE expression.

```sql
SELECT
    first_name,
    age,
    city,
    CASE
        WHEN age >= 21 THEN 'Older'
        ELSE 'Younger'
    END AS age_category,
    CASE
        WHEN city IN ('Delhi', 'Mumbai')
            THEN 'Major City'
        ELSE 'Other City'
    END AS city_category
FROM students;
```

---

# 22. CASE With Aggregate Functions

CASE becomes especially useful with aggregate functions.

For example, count students who are 21 or older:

```sql
SELECT
    COUNT(
        CASE
            WHEN age >= 21 THEN 1
        END
    ) AS students_21_plus
FROM students;
```

Another common pattern is:

```sql
SELECT
    SUM(
        CASE
            WHEN age >= 21 THEN 1
            ELSE 0
        END
    ) AS students_21_plus
FROM students;
```

The second pattern is particularly useful when learning conditional aggregation.

---

# 23. CASE With GROUP BY

CASE can be used to create categories before grouping.

Example:

```sql
SELECT
    CASE
        WHEN age >= 21 THEN '21+'
        ELSE 'Under 21'
    END AS age_group,
    COUNT(*) AS student_count
FROM students
GROUP BY
    CASE
        WHEN age >= 21 THEN '21+'
        ELSE 'Under 21'
    END;
```

This groups students into age categories.

---

# 24. CASE With ORDER BY and LIMIT

Example:

```sql
SELECT
    first_name,
    city
FROM students
ORDER BY
    CASE
        WHEN city = 'Delhi' THEN 1
        WHEN city = 'Mumbai' THEN 2
        ELSE 3
    END,
    first_name
LIMIT 3;
```

This can be useful when a report has business priorities.

---

# 25. CASE and WHERE

CASE is usually not necessary when a normal WHERE condition is sufficient.

For example, instead of:

```sql
SELECT *
FROM students
WHERE
    CASE
        WHEN age >= 21 THEN 1
        ELSE 0
    END = 1;
```

prefer:

```sql
SELECT *
FROM students
WHERE age >= 21;
```

Use CASE when you need to produce a value or category, not simply filter rows.

---

# 26. CASE and NULL

A CASE expression can explicitly classify NULL values.

```sql
SELECT
    first_name,
    CASE
        WHEN city IS NULL THEN 'Unknown'
        ELSE city
    END AS city_status
FROM students;
```

This is useful for data-quality reports.

---

# 27. CASE in Reports

Suppose a company wants a customer status report.

Raw data might contain:

```text
amount
```

A report could transform it into:

```text
High Value
Medium Value
Low Value
```

Example:

```sql
CASE
    WHEN amount >= 10000 THEN 'High Value'
    WHEN amount >= 5000 THEN 'Medium Value'
    ELSE 'Low Value'
END
```

This is one reason CASE is widely used in analytics and business intelligence.

---

# 28. CASE With Subqueries

CASE and subqueries can be combined.

Example:

```sql
SELECT
    first_name,
    age,
    CASE
        WHEN age > (
            SELECT AVG(age)
            FROM students
        )
        THEN 'Above Average'
        ELSE 'Average or Below'
    END AS age_status
FROM students;
```

This combines concepts from Modules 09 and 10.

---

# 29. CASE Evaluation Order

Conditions are checked from top to bottom.

Example:

```sql
CASE
    WHEN age >= 18 THEN 'Adult'
    WHEN age >= 21 THEN '21+'
    ELSE 'Under 18'
END
```

For age 21, SQL returns:

```text
Adult
```

The `age >= 21` condition is never reached.

Correct ordering:

```sql
CASE
    WHEN age >= 21 THEN '21+'
    WHEN age >= 18 THEN 'Adult'
    ELSE 'Under 18'
END
```

---

# 30. CASE Without ELSE

This is valid:

```sql
CASE
    WHEN age >= 21 THEN 'Adult'
END
```

Rows that do not satisfy the condition return NULL.

However, when building reports, an explicit ELSE often makes the output clearer.

---

# 31. Common CASE Mistakes

## Mistake 1 — Forgetting END

Incorrect:

```sql
CASE
    WHEN age >= 21 THEN 'Adult'
```

Correct:

```sql
CASE
    WHEN age >= 21 THEN 'Adult'
END
```

---

## Mistake 2 — Incorrect condition order

Incorrect:

```sql
CASE
    WHEN age >= 18 THEN 'Adult'
    WHEN age >= 21 THEN '21+'
END
```

The second condition is effectively unreachable for ages 21+.

---

## Mistake 3 — Forgetting ELSE

If no condition matches and ELSE is missing, the result is NULL.

---

## Mistake 4 — Confusing CASE with WHERE

WHERE filters rows.

CASE creates or transforms values.

---

# 32. CASE vs IF

MySQL provides an `IF()` function:

```sql
IF(age >= 21, 'Adult', 'Young')
```

However, CASE is more portable SQL and handles multiple conditions more cleanly.

For example:

```sql
CASE
    WHEN age >= 21 THEN 'Adult'
    WHEN age >= 18 THEN 'Young Adult'
    ELSE 'Minor'
END
```

For this learning repository, CASE should be preferred.

---

# 33. Practical Decision Guide

Use CASE when you need to:

```text
Create categories
       ↓
Create labels
       ↓
Perform conditional calculations
       ↓
Create custom sorting
       ↓
Build reports
       ↓
Perform conditional aggregation
```

Do not use CASE when a simple WHERE condition is sufficient.

---

# 34. Key Takeaways

CASE provides conditional logic inside SQL.

The basic structure is:

```sql
CASE
    WHEN condition THEN result
    ELSE result
END
```

There are two important forms:

```text
Simple CASE
Searched CASE
```

Simple CASE compares one expression against specific values.

Searched CASE evaluates conditions.

CASE can be used in:

```text
SELECT
ORDER BY
GROUP BY
aggregate expressions
calculations
reports
```

CASE conditions are evaluated from top to bottom.

The first matching condition wins.

`ELSE` handles cases where no condition matches.

CASE is one of the most important SQL tools for creating business-friendly reports.
