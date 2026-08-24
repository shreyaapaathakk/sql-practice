# Module 06 — JOINs

## Overview

A JOIN allows SQL to combine related data from multiple tables.

In earlier modules, most queries worked with one table at a time. Real databases usually contain many related tables. For example, a school database may store students in one table, courses in another table, and student enrollments in a third table.

JOINs allow us to connect these tables and answer questions such as:

* Which courses is each student enrolled in?
* Which students are enrolled in SQL?
* How many students are enrolled in each course?
* Which students have not enrolled in any course?
* What is the average age of students enrolled in a particular course?

This module focuses primarily on `INNER JOIN` and `LEFT JOIN`.

---

## 1. Why Do We Need JOINs?

Suppose we have a `students` table:

```sql
SELECT *
FROM students;
```

and a separate `courses` table:

```sql
SELECT *
FROM courses;
```

The tables contain different types of information.

The `students` table stores information about students.

The `courses` table stores information about courses.

The `enrollments` table connects students to courses.

Conceptually:

```text
students
   |
   | student_id
   |
enrollments
   |
   | course_id
   |
courses
```

The common columns allow us to connect related rows.

---

## 2. The Sample Tables

This module uses:

### students

```text
student_id
first_name
last_name
age
city
```

### courses

```text
course_id
course_name
instructor
```

### enrollments

```text
enrollment_id
student_id
course_id
enrollment_date
```

The `student_id` in `enrollments` identifies the student.

The `course_id` in `enrollments` identifies the course.

This is a common relational database design.

---

## 3. INNER JOIN

`INNER JOIN` returns only rows where a matching record exists in both tables.

Basic syntax:

```sql
SELECT columns
FROM table1
INNER JOIN table2
    ON table1.column = table2.column;
```

For example:

```sql
SELECT
    students.first_name,
    students.last_name,
    enrollments.course_id
FROM students
INNER JOIN enrollments
    ON students.student_id = enrollments.student_id;
```

Only students who have a matching enrollment are returned.

---

## 4. JOIN vs INNER JOIN

In MySQL, these are equivalent:

```sql
FROM students
INNER JOIN enrollments
```

and:

```sql
FROM students
JOIN enrollments
```

`JOIN` without a specified type means `INNER JOIN`.

For learning and readability, explicitly writing `INNER JOIN` can make the query's intention clearer.

---

## 5. The ON Clause

The `ON` clause specifies how two tables are related.

Example:

```sql
SELECT *
FROM students
INNER JOIN enrollments
    ON students.student_id = enrollments.student_id;
```

Here:

```text
students.student_id
        =
enrollments.student_id
```

is the relationship used to match rows.

Do not confuse `ON` with `WHERE`.

`ON` defines how tables are joined.

`WHERE` filters the resulting rows.

---

## 6. Table Aliases

Long table names can make JOIN queries difficult to read.

Aliases make them shorter:

```sql
SELECT
    s.first_name,
    s.last_name,
    e.course_id
FROM students AS s
INNER JOIN enrollments AS e
    ON s.student_id = e.student_id;
```

The `AS` keyword can be omitted:

```sql
FROM students s
INNER JOIN enrollments e
```

Both styles are valid.

For this repository, aliases will generally be used in multi-table queries because they make JOINs easier to read.

---

## 7. Joining Three Tables

We can join all three tables:

```text
students
   ↓
enrollments
   ↓
courses
```

Example:

```sql
SELECT
    s.first_name,
    s.last_name,
    c.course_name
FROM students AS s
INNER JOIN enrollments AS e
    ON s.student_id = e.student_id
INNER JOIN courses AS c
    ON e.course_id = c.course_id;
```

This gives us the student's name and the course they are enrolled in.

---

## 8. JOIN + WHERE

JOINs can be combined with filtering.

For example, find students enrolled in a course with a particular name:

```sql
SELECT
    s.first_name,
    s.last_name,
    c.course_name
FROM students AS s
INNER JOIN enrollments AS e
    ON s.student_id = e.student_id
INNER JOIN courses AS c
    ON e.course_id = c.course_id
WHERE c.course_name = 'SQL Fundamentals';
```

The JOIN connects the tables.

The `WHERE` clause filters the resulting records.

---

## 9. JOIN + ORDER BY

JOIN results can be sorted.

```sql
SELECT
    s.first_name,
    s.last_name,
    c.course_name
FROM students AS s
INNER JOIN enrollments AS e
    ON s.student_id = e.student_id
INNER JOIN courses AS c
    ON e.course_id = c.course_id
ORDER BY s.first_name ASC;
```

You can also sort by course:

```sql
ORDER BY c.course_name ASC;
```

---

## 10. JOIN + GROUP BY

JOINs become particularly powerful when combined with aggregate functions.

For example, count students enrolled in each course:

```sql
SELECT
    c.course_name,
    COUNT(e.student_id) AS student_count
FROM courses AS c
INNER JOIN enrollments AS e
    ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name;
```

This combines concepts from Module 05 with JOINs.

---

## 11. JOIN + GROUP BY + HAVING

We can filter grouped JOIN results using `HAVING`.

For example, find courses with at least two enrolled students:

```sql
SELECT
    c.course_name,
    COUNT(e.student_id) AS student_count
FROM courses AS c
INNER JOIN enrollments AS e
    ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name
HAVING COUNT(e.student_id) >= 2;
```

Remember:

```text
WHERE
    filters rows

HAVING
    filters groups
```

---

## 12. LEFT JOIN

`LEFT JOIN` returns:

* every row from the left table
* matching rows from the right table when available

If there is no match, columns from the right table contain `NULL`.

Example:

```sql
SELECT
    s.first_name,
    s.last_name,
    e.course_id
FROM students AS s
LEFT JOIN enrollments AS e
    ON s.student_id = e.student_id;
```

This can show students even if they have no enrollment.

---

## 13. INNER JOIN vs LEFT JOIN

Consider two students:

```text
Student A → has an enrollment
Student B → has no enrollment
```

An `INNER JOIN` returns:

```text
Student A
```

A `LEFT JOIN` returns:

```text
Student A
Student B
```

For Student B, columns from `enrollments` will contain `NULL`.

This difference is extremely important.

---

## 14. Finding Unmatched Rows With LEFT JOIN

One of the most useful patterns is finding records that have no matching record.

For example, find students who are not enrolled in any course:

```sql
SELECT
    s.student_id,
    s.first_name,
    s.last_name
FROM students AS s
LEFT JOIN enrollments AS e
    ON s.student_id = e.student_id
WHERE e.enrollment_id IS NULL;
```

The logic is:

1. Keep every student.
2. Attempt to match an enrollment.
3. Students without an enrollment receive `NULL`.
4. Filter for those `NULL` values.

This pattern is widely used in real-world SQL.

---

## 15. LEFT JOIN With Three Tables

We can also use `LEFT JOIN` across three tables:

```sql
SELECT
    s.first_name,
    s.last_name,
    c.course_name
FROM students AS s
LEFT JOIN enrollments AS e
    ON s.student_id = e.student_id
LEFT JOIN courses AS c
    ON e.course_id = c.course_id;
```

Students without enrollments still appear, but their course name is `NULL`.

---

## 16. JOIN Conditions and Filtering

Be careful when using `WHERE` with a `LEFT JOIN`.

For example:

```sql
SELECT
    s.first_name,
    c.course_name
FROM students AS s
LEFT JOIN enrollments AS e
    ON s.student_id = e.student_id
LEFT JOIN courses AS c
    ON e.course_id = c.course_id
WHERE c.course_name = 'SQL Fundamentals';
```

The `WHERE` condition removes rows where `course_name` is `NULL`.

In many situations, this effectively removes the unmatched rows you were trying to preserve with the `LEFT JOIN`.

This is an important concept that will become increasingly useful as JOIN queries become more advanced.

---

## 17. Joining on the Correct Columns

A common JOIN mistake is using unrelated columns.

Correct:

```sql
ON s.student_id = e.student_id
```

Incorrect examples would include joining:

```text
student_id = course_id
```

unless the database specifically defines such a relationship.

Always identify the relationship between the tables before writing the JOIN.

---

## 18. Duplicate Rows After a JOIN

A JOIN can return multiple rows for one record in the original table.

Suppose Rahul is enrolled in three courses.

A query joining `students` to `enrollments` will return Rahul three times:

```text
Rahul → Course A
Rahul → Course B
Rahul → Course C
```

This is not necessarily a problem.

The result is correctly representing three enrollment relationships.

Do not automatically use `DISTINCT` just because duplicate-looking names appear.

First understand why the rows are repeated.

---

## 19. JOINs and DISTINCT

Sometimes `DISTINCT` is useful.

For example, to find students who have at least one enrollment:

```sql
SELECT DISTINCT
    s.student_id,
    s.first_name,
    s.last_name
FROM students AS s
INNER JOIN enrollments AS e
    ON s.student_id = e.student_id;
```

Without `DISTINCT`, students with multiple enrollments can appear multiple times.

However, if you need the number of enrollments, `DISTINCT` may hide useful information.

---

## 20. JOIN and Aggregate Counting

Consider:

```sql
SELECT
    s.student_id,
    s.first_name,
    COUNT(e.enrollment_id) AS course_count
FROM students AS s
LEFT JOIN enrollments AS e
    ON s.student_id = e.student_id
GROUP BY
    s.student_id,
    s.first_name;
```

Using `LEFT JOIN` means students with zero enrollments can still appear.

Their count will be:

```text
0
```

This is often more useful than an `INNER JOIN` when building reports.

---

## 21. Why COUNT(column) Matters With LEFT JOIN

Consider:

```sql
COUNT(e.enrollment_id)
```

This counts only non-NULL enrollment IDs.

For a student with no enrollment:

```text
e.enrollment_id = NULL
```

Therefore:

```text
COUNT(e.enrollment_id) = 0
```

This is useful for finding students with no related records.

---

## 22. JOIN Query Structure

A useful structure for many JOIN queries is:

```sql
SELECT
    ...
FROM table1 AS t1
INNER JOIN table2 AS t2
    ON ...
LEFT JOIN table3 AS t3
    ON ...
WHERE ...
GROUP BY ...
HAVING ...
ORDER BY ...
LIMIT ...;
```

Not every query requires every clause.

The important thing is to understand the purpose of each clause.

---

## 23. Conceptual Query Processing

A simplified logical order is:

```text
FROM
↓
JOIN / ON
↓
WHERE
↓
GROUP BY
↓
HAVING
↓
SELECT
↓
ORDER BY
↓
LIMIT
```

This builds on the aggregate query processing model from Module 05.

---

## 24. Common JOIN Mistakes

### Mistake 1: Forgetting the JOIN condition

Incorrect:

```sql
SELECT *
FROM students
JOIN enrollments;
```

A JOIN normally needs a condition explaining how the tables relate.

### Mistake 2: Joining the wrong columns

Always identify the relationship between the tables first.

### Mistake 3: Using WHERE when you need unmatched LEFT JOIN rows

A condition on the right-side table in `WHERE` can eliminate `NULL` rows.

### Mistake 4: Assuming repeated rows are automatically wrong

One student can legitimately have many enrollments.

### Mistake 5: Using SELECT * everywhere

`SELECT *` is useful while learning, but explicit columns are generally clearer in portfolio-quality queries.

### Mistake 6: Forgetting table aliases

When multiple tables contain columns with the same name, qualify the column:

```sql
s.student_id
```

instead of:

```sql
student_id
```

---

## 25. INNER JOIN vs LEFT JOIN Summary

| JOIN         | Returns unmatched left rows? |
| ------------ | ---------------------------- |
| `INNER JOIN` | No                           |
| `LEFT JOIN`  | Yes                          |
| `RIGHT JOIN` | Yes, from the right side     |

This module focuses on `INNER JOIN` and `LEFT JOIN`.

`RIGHT JOIN`, `SELF JOIN`, and more advanced JOIN patterns will be introduced later after the fundamentals are comfortable.

---

## 26. Key Takeaways

A JOIN combines related data from multiple tables.

`INNER JOIN` returns matching rows from both tables.

`LEFT JOIN` returns all rows from the left table and matching rows from the right table.

`ON` defines the relationship between tables.

`WHERE` filters the resulting rows.

`GROUP BY` can summarize joined data.

`HAVING` filters grouped results.

`COUNT(column)` is especially useful with `LEFT JOIN` because `NULL` values are not counted.

A strong SQL developer should always understand:

```text
Which tables am I joining?
Which columns relate them?
Which rows should be preserved?
Do I need INNER JOIN or LEFT JOIN?
Am I filtering rows or groups?
```

These questions form the foundation for more advanced JOINs and real-world relational queries.
