# Module 09 — Subqueries

## Overview

A subquery is a query written inside another query.

A subquery executes first and its result is used by the outer query.

Basic syntax:

```sql
SELECT column_name
FROM table_name
WHERE column_name = (
    SELECT column_name
    FROM another_table
);
```

Subqueries allow us to answer questions such as:

- Which student has the highest age?
- Which students are older than the average age?
- Which students belong to cities that meet certain conditions?
- Which courses have enrollments?

---

# 1. What Is a Subquery?

A subquery is a query nested inside another SQL statement.

Example:

```sql
SELECT *
FROM students
WHERE age = (
    SELECT MAX(age)
    FROM students
);
```

The inner query:

```sql
SELECT MAX(age)
FROM students;
```

runs first.

Suppose it returns:

```text
22
```

Then the outer query becomes:

```sql
SELECT *
FROM students
WHERE age = 22;
```

---

# 2. Types of Subqueries

Common types:

- Scalar subquery
- Single-row subquery
- Multi-row subquery
- Correlated subquery
- Subquery in SELECT
- Subquery in FROM
- Subquery in WHERE

We will learn them gradually.

---

# 3. Scalar Subquery

A scalar subquery returns exactly one value.

Example:

```sql
SELECT *
FROM students
WHERE age > (
    SELECT AVG(age)
    FROM students
);
```

The inner query returns one value:

```text
20.4
```

The outer query compares every student against that value.

---

# 4. Subquery in WHERE

This is the most common type.

Example:

```sql
SELECT *
FROM students
WHERE age = (
    SELECT MIN(age)
    FROM students
);
```

Returns the youngest student.

---

# 5. Subquery with Aggregate Functions

Subqueries often use:

```sql
COUNT()
SUM()
AVG()
MIN()
MAX()
```

Example:

```sql
SELECT *
FROM students
WHERE age > (
    SELECT AVG(age)
    FROM students
);
```

---

# 6. Multi-Row Subquery

Sometimes a subquery returns multiple rows.

Example:

```sql
SELECT *
FROM students
WHERE city IN (
    SELECT city
    FROM students
    WHERE age >= 21
);
```

The subquery may return:

```text
Mumbai
Pune
```

The outer query uses IN to compare against multiple values.

---

# 7. Using IN with Subqueries

Example:

```sql
SELECT *
FROM students
WHERE city IN (
    SELECT city
    FROM students
    WHERE age > 20
);
```

Useful when the inner query returns many values.

---

# 8. Using NOT IN with Subqueries

Example:

```sql
SELECT *
FROM students
WHERE city NOT IN (
    SELECT city
    FROM students
    WHERE age > 20
);
```

Returns students from cities not present in the subquery result.

---

# 9. Subquery in FROM

A subquery can act like a temporary table.

Example:

```sql
SELECT *
FROM (
    SELECT
        student_id,
        first_name,
        age
    FROM students
) AS student_data;
```

The alias is required.

---

# 10. Why Alias Is Required

This is invalid:

```sql
SELECT *
FROM (
    SELECT *
    FROM students
);
```

Correct:

```sql
SELECT *
FROM (
    SELECT *
    FROM students
) AS s;
```

Every derived table needs an alias.

---

# 11. Subquery in SELECT

A subquery can appear inside the SELECT list.

Example:

```sql
SELECT
    first_name,
    age,
    (
        SELECT AVG(age)
        FROM students
    ) AS average_age
FROM students;
```

The average age appears on every row.

---

# 12. Comparing Against MAX()

Example:

```sql
SELECT *
FROM students
WHERE age = (
    SELECT MAX(age)
    FROM students
);
```

Returns the oldest student.

---

# 13. Comparing Against MIN()

Example:

```sql
SELECT *
FROM students
WHERE age = (
    SELECT MIN(age)
    FROM students
);
```

Returns the youngest student.

---

# 14. Comparing Against AVG()

Example:

```sql
SELECT *
FROM students
WHERE age > (
    SELECT AVG(age)
    FROM students
);
```

Returns students older than average.

---

# 15. Comparing Against COUNT()

Example:

```sql
SELECT (
    SELECT COUNT(*)
    FROM students
) AS total_students;
```

Returns a single value.

---

# 16. EXISTS

EXISTS checks whether a subquery returns rows.

Example:

```sql
SELECT *
FROM students s
WHERE EXISTS (
    SELECT 1
    FROM enrollments e
    WHERE e.student_id = s.student_id
);
```

Returns students that have enrollments.

---

# 17. NOT EXISTS

Example:

```sql
SELECT *
FROM students s
WHERE NOT EXISTS (
    SELECT 1
    FROM enrollments e
    WHERE e.student_id = s.student_id
);
```

Returns students without enrollments.

---

# 18. Correlated Subquery

A correlated subquery references the outer query.

Example:

```sql
SELECT *
FROM students s
WHERE age > (
    SELECT AVG(age)
    FROM students
    WHERE city = s.city
);
```

The inner query runs for each row.

---

# 19. Subquery vs JOIN

Many problems can be solved using either approach.

Subquery:

```sql
SELECT *
FROM students
WHERE student_id IN (
    SELECT student_id
    FROM enrollments
);
```

JOIN:

```sql
SELECT DISTINCT s.*
FROM students s
INNER JOIN enrollments e
    ON s.student_id = e.student_id;
```

Both can produce similar results.

---

# 20. Common Mistakes

### Mistake 1

Using = when multiple rows are returned.

Incorrect:

```sql
SELECT *
FROM students
WHERE city = (
    SELECT city
    FROM students
);
```

Use IN instead.

---

### Mistake 2

Forgetting alias in FROM subquery.

Incorrect:

```sql
SELECT *
FROM (
    SELECT *
    FROM students
);
```

---

### Mistake 3

Expecting subqueries to always return one row.

Always understand how many rows the inner query returns.

---

# 21. Performance Note

For large databases:

- JOINs are often faster.
- Subqueries improve readability in some situations.
- Choose the approach that is easiest to understand and maintain.

---

# Key Takeaways

- A subquery is a query inside another query.
- Inner query executes first.
- Scalar subqueries return one value.
- Multi-row subqueries often use IN.
- EXISTS checks whether rows exist.
- NOT EXISTS checks whether rows do not exist.
- Correlated subqueries reference the outer query.
- Subqueries can appear in SELECT, FROM, and WHERE clauses.
- Derived tables require aliases.
