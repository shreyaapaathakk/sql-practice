# `08_union_and_set_operations/notes.md`

# Module 08 — UNION & Set Operations

## Overview

In the previous modules, we learned how to combine related tables using JOINs.

A JOIN combines columns from related tables.

Set operations work differently.

Set operations combine the results of multiple `SELECT` statements into a single result.

In this module, we will learn:

- `UNION`
- `UNION ALL`
- the difference between `UNION` and `UNION ALL`
- requirements for combining result sets
- column compatibility
- column names in UNION results
- data types in UNION
- `ORDER BY` with UNION
- `LIMIT` with UNION
- using UNION with filtering
- using UNION with JOINs
- removing duplicate rows
- preserving duplicate rows
- common UNION mistakes
- practical UNION patterns
- beginner interview-style UNION questions

---

# 1. What Is UNION?

`UNION` combines the results of two or more `SELECT` statements into one result.

Basic syntax:

```sql
SELECT column1, column2
FROM table1

UNION

SELECT column1, column2
FROM table2;
````

For example:

```sql
SELECT city
FROM students

UNION

SELECT city
FROM teachers;
```

The result contains cities from both tables.

Duplicate rows are removed automatically.

---

# 2. UNION vs JOIN

It is important to understand the difference.

A JOIN combines columns horizontally.

For example:

```text
students
    +
enrollments
```

can produce:

```text
student_name | course_id
```

A UNION combines rows vertically.

For example:

```text
students_table_1
        +
students_table_2
```

can produce:

```text
student_name
------------
Rahul
Priya
Aman
Neha
```

A simple way to remember:

```text
JOIN  → combines columns from related tables
UNION → combines rows from separate result sets
```

---

# 3. UNION Removes Duplicates

`UNION` removes duplicate rows from the final result.

Example:

```sql
SELECT 'Delhi' AS city

UNION

SELECT 'Delhi' AS city;
```

The result contains:

```text
Delhi
```

only once.

This is one of the main differences between `UNION` and `UNION ALL`.

---

# 4. UNION ALL

`UNION ALL` combines result sets without removing duplicates.

Example:

```sql
SELECT 'Delhi' AS city

UNION ALL

SELECT 'Delhi' AS city;
```

The result is:

```text
Delhi
Delhi
```

Use `UNION ALL` when duplicate rows should be preserved.

---

# 5. UNION vs UNION ALL

The difference can be summarized as:

```text
UNION
    ↓
Combines results
    ↓
Removes duplicate rows

UNION ALL
    ↓
Combines results
    ↓
Keeps duplicate rows
```

Example:

```sql
SELECT city
FROM students

UNION

SELECT city
FROM teachers;
```

removes duplicate cities.

While:

```sql
SELECT city
FROM students

UNION ALL

SELECT city
FROM teachers;
```

keeps duplicate cities.

---

# 6. UNION Requires Compatible SELECT Statements

The SELECT statements used with UNION must have the same number of columns.

For example, this is valid:

```sql
SELECT
    first_name,
    city
FROM students

UNION

SELECT
    first_name,
    city
FROM teachers;
```

Both SELECT statements return two columns.

This is invalid:

```sql
SELECT
    first_name,
    city
FROM students

UNION

SELECT
    first_name
FROM teachers;
```

The first SELECT returns two columns while the second returns one.

The number of columns must match.

---

# 7. Column Positions Matter

UNION combines columns according to their position.

Consider:

```sql
SELECT
    first_name,
    city
FROM students

UNION

SELECT
    teacher_name,
    department
FROM teachers;
```

The first column from the first SELECT is combined with the first column from the second SELECT.

The second column is combined with the second column.

Conceptually:

```text
first_name   ←→ teacher_name
city         ←→ department
```

The column names do not need to be identical.

The positions must correspond logically.

---

# 8. Column Names in UNION

The column names of a UNION result generally come from the first SELECT.

For example:

```sql
SELECT
    first_name AS person_name
FROM students

UNION

SELECT
    teacher_name
FROM teachers;
```

The resulting column will be named:

```text
person_name
```

because the first SELECT defines the result column name.

Therefore, it is good practice to use meaningful aliases in the first SELECT.

---

# 9. Compatible Data Types

Corresponding columns should contain compatible data types.

For example:

```sql
SELECT
    student_id
FROM students

UNION

SELECT
    teacher_id
FROM teachers;
```

Both columns are integer IDs.

This is appropriate.

You should avoid combining completely unrelated data types simply because SQL allows implicit conversion.

The result should make logical sense.

---

# 10. UNION With Different Table Names

The tables being combined do not need to have the same name.

For example:

```sql
SELECT
    first_name AS person_name
FROM students

UNION

SELECT
    teacher_name
FROM teachers;
```

The two tables have different structures, but the selected result columns are compatible.

The important thing is the structure of the SELECT results, not the names of the source tables.

---

# 11. UNION With WHERE

Each SELECT statement can have its own filtering condition.

Example:

```sql
SELECT
    first_name AS person_name,
    city
FROM students
WHERE city = 'Delhi'

UNION

SELECT
    first_name AS person_name,
    city
FROM students
WHERE city = 'Mumbai';
```

This combines students from two different cities.

However, if both conditions apply to the same table, there may be a simpler way to write the query using `IN`.

For example:

```sql
SELECT
    first_name,
    city
FROM students
WHERE city IN ('Delhi', 'Mumbai');
```

Understanding this distinction is important.

UNION should be used when combining separate result sets makes the query clearer or when the source data comes from different tables or queries.

---

# 12. UNION With Different Tables

A common real-world use case is combining similar data from different tables.

For example:

```text
current_students
former_students
```

Both tables may contain:

```text
student_id
student_name
city
```

We can combine them:

```sql
SELECT
    student_id,
    student_name,
    city
FROM current_students

UNION

SELECT
    student_id,
    student_name,
    city
FROM former_students;
```

This creates one result containing both current and former students.

---

# 13. UNION ALL for Historical Data

`UNION ALL` is often useful when duplicate records are meaningful.

For example, suppose two tables contain monthly sales:

```text
sales_january
sales_february
```

We may want every sale from both months.

```sql
SELECT
    order_id,
    customer_id,
    amount
FROM sales_january

UNION ALL

SELECT
    order_id,
    customer_id,
    amount
FROM sales_february;
```

We usually do not want SQL to remove rows simply because two rows happen to contain the same values.

---

# 14. Why UNION ALL Is Often Preferred

`UNION` has to identify duplicate rows.

`UNION ALL` simply combines the results.

Therefore, when you know duplicates should be preserved, `UNION ALL` is usually the more appropriate choice.

For example:

```sql
SELECT city
FROM students

UNION ALL

SELECT city
FROM students;
```

This intentionally duplicates the result.

Do not use `UNION` when duplicate rows are meaningful.

---

# 15. UNION With ORDER BY

If you want to sort the final combined result, place `ORDER BY` after the final SELECT.

Correct:

```sql
SELECT
    first_name AS person_name
FROM students

UNION

SELECT
    teacher_name
FROM teachers

ORDER BY person_name;
```

The `ORDER BY` applies to the final UNION result.

---

# 16. ORDER BY and Column Names

Because the first SELECT determines the result column names, it is usually safest to order using the column name from the first SELECT.

Example:

```sql
SELECT
    first_name AS person_name
FROM students

UNION

SELECT
    teacher_name
FROM teachers

ORDER BY person_name;
```

---

# 17. UNION With LIMIT

`LIMIT` can be used on the final combined result.

Example:

```sql
SELECT
    first_name AS person_name
FROM students

UNION

SELECT
    teacher_name
FROM teachers

ORDER BY person_name
LIMIT 5;
```

This returns the first five rows from the final result.

---

# 18. Parentheses With UNION

Parentheses can be useful when individual SELECT statements contain their own `ORDER BY` or `LIMIT`.

For example:

```sql
(
    SELECT
        first_name AS person_name
    FROM students
    ORDER BY first_name
    LIMIT 3
)

UNION ALL

(
    SELECT
        teacher_name
    FROM teachers
    ORDER BY teacher_name
    LIMIT 3
);
```

The parentheses make it clear that each SELECT has its own ordering and limit.

Without parentheses, `ORDER BY` and `LIMIT` generally apply to the final combined result.

---

# 19. UNION With JOIN

A SELECT statement used in a UNION can contain JOINs.

For example:

```sql
SELECT
    s.first_name AS person_name,
    c.course_name AS subject
FROM students AS s
INNER JOIN enrollments AS e
    ON s.student_id = e.student_id
INNER JOIN courses AS c
    ON e.course_id = c.course_id

UNION

SELECT
    'Guest Student' AS person_name,
    'Orientation' AS subject;
```

The individual SELECT statements can contain normal SQL operations.

The final result still needs compatible columns.

---

# 20. UNION and DISTINCT

Remember that `UNION` removes duplicate rows.

For example:

```sql
SELECT city
FROM students

UNION

SELECT city
FROM students;
```

produces unique cities.

You do not normally need:

```sql
SELECT DISTINCT city
FROM students

UNION

SELECT DISTINCT city
FROM students;
```

because `UNION` already removes duplicates from the combined result.

---

# 21. UNION ALL and Duplicates

`UNION ALL` does not remove duplicates.

Example:

```sql
SELECT city
FROM students

UNION ALL

SELECT city
FROM students;
```

Every row from both SELECT statements is preserved.

This makes `UNION ALL` useful when the number of rows matters.

---

# 22. UNION With Calculated Columns

SELECT statements can contain expressions.

For example:

```sql
SELECT
    first_name AS person_name,
    'Student' AS role
FROM students

UNION ALL

SELECT
    teacher_name AS person_name,
    'Teacher' AS role
FROM teachers;
```

This creates a combined list of people with a role column.

Example result:

```text
person_name     | role
----------------|--------
Rahul           | Student
Priya           | Student
Aman            | Student
Anita           | Teacher
Vikram          | Teacher
```

This is a useful real-world reporting pattern.

---

# 23. Creating a Combined People Report

Suppose we have students and employees.

We can create one combined result:

```sql
SELECT
    first_name AS person_name,
    'Student' AS role
FROM students

UNION ALL

SELECT
    employee_name AS person_name,
    'Employee' AS role
FROM employees;
```

This allows different entities to be represented in one result set.

The source tables can have different structures as long as the selected columns are compatible.

---

# 24. UNION and NULL

`NULL` can be used to make SELECT statements compatible.

Suppose one table has:

```text
student_id
student_name
city
```

and another has:

```text
employee_id
employee_name
```

We can write:

```sql
SELECT
    student_id AS person_id,
    first_name AS person_name,
    city
FROM students

UNION ALL

SELECT
    employee_id AS person_id,
    employee_name AS person_name,
    NULL AS city
FROM employees;
```

The employee rows will have `NULL` for city.

This is useful when combining different but related result sets.

---

# 25. UNION vs OR

Sometimes beginners use UNION when a single SELECT with `OR` or `IN` would be simpler.

For example:

```sql
SELECT
    first_name,
    city
FROM students
WHERE city = 'Delhi'

UNION

SELECT
    first_name,
    city
FROM students
WHERE city = 'Mumbai';
```

Can often be simplified to:

```sql
SELECT
    first_name,
    city
FROM students
WHERE city IN ('Delhi', 'Mumbai');
```

The two approaches are not always interchangeable.

Use UNION when combining separate result sets is the actual requirement.

Use `OR` or `IN` when filtering the same result set is simpler.

---

# 26. UNION vs JOIN

This distinction is extremely important.

### JOIN

Use JOIN when tables are related and you want columns from both tables.

Example:

```text
students + enrollments
```

Result:

```text
student_name | enrollment_id
```

### UNION

Use UNION when you have separate result sets with compatible structures and want to stack them.

Example:

```text
students
+
former_students
```

Result:

```text
student_name
```

Remember:

```text
JOIN  → side by side
UNION → one after another
```

---

# 27. Common UNION Mistakes

## Mistake 1 — Different Number of Columns

This is invalid:

```sql
SELECT
    first_name,
    city
FROM students

UNION

SELECT
    teacher_name
FROM teachers;
```

The SELECT statements return different numbers of columns.

---

## Mistake 2 — Incorrect Column Order

This may be syntactically valid but logically incorrect:

```sql
SELECT
    first_name,
    age
FROM students

UNION

SELECT
    teacher_name,
    department
FROM teachers;
```

The second column contains completely different concepts.

Always make sure corresponding columns represent compatible information.

---

## Mistake 3 — Using UNION When UNION ALL Is Required

If duplicate rows are meaningful, `UNION` will incorrectly remove them.

Use:

```sql
UNION ALL
```

when every row must be preserved.

---

## Mistake 4 — Incorrect ORDER BY Placement

Usually, the final `ORDER BY` belongs after the final SELECT:

```sql
SELECT ...
FROM ...

UNION

SELECT ...
FROM ...

ORDER BY column_name;
```

---

## Mistake 5 — Expecting UNION to Combine Columns

UNION does not produce:

```text
name | city | course
```

from separate tables.

It stacks rows.

For combining columns from related tables, use JOIN.

---

# 28. Practical Decision Guide

Ask yourself:

### Do I need columns from related tables?

Use:

```text
JOIN
```

### Do I need to stack rows from different SELECT results?

Use:

```text
UNION
```

### Should duplicates be removed?

Use:

```text
UNION
```

### Should every row be preserved?

Use:

```text
UNION ALL
```

### Am I filtering different values from the same table?

Consider:

```text
WHERE ... IN (...)
```

instead of UNION.

---

# 29. UNION Checklist

Before using UNION, check:

```text
1. Do all SELECT statements return the same number of columns?

2. Are corresponding columns logically compatible?

3. Are the columns in the correct order?

4. Should duplicates be removed?

5. Should duplicates be preserved?

6. Are the column names defined clearly in the first SELECT?

7. Does ORDER BY belong to the final result?

8. Would JOIN be more appropriate?

9. Would WHERE or IN be simpler?

10. Is UNION ALL more appropriate than UNION?
```

---

# 30. Key Takeaways

`UNION` combines the results of multiple SELECT statements.

`UNION` removes duplicate rows.

`UNION ALL` keeps duplicate rows.

All SELECT statements in a UNION must return the same number of columns.

Corresponding columns should contain compatible data.

The first SELECT generally determines the result column names.

`ORDER BY` normally applies to the final combined result.

A SELECT inside a UNION can contain JOINs, WHERE conditions, expressions, and other SQL operations.

Use JOIN to combine related columns.

Use UNION to stack compatible rows.

Use `UNION ALL` when duplicate rows are meaningful or should be preserved.

The most important distinction is:

```text
JOIN
→ combines columns horizontally

UNION
→ combines rows vertically
```

Once UNION becomes comfortable, the next important SQL concepts are subqueries and conditional expressions such as `CASE`.

````
