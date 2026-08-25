# Module 07 — Advanced JOINs

## Overview

In Module 06, we learned the fundamentals of SQL JOINs, including `INNER JOIN`, `LEFT JOIN`, joining multiple tables, table aliases, filtering joined data, and working with `GROUP BY` and `HAVING`.

In this module, we will build on those concepts and learn how to handle more complex relationships between tables.

The main topics covered are:

- `RIGHT JOIN`
- `SELF JOIN`
- joining a table to itself
- joining multiple tables
- multi-level relationships
- many-to-many relationships
- `JOIN` with `WHERE`
- filtering in `ON` vs `WHERE`
- `JOIN` with `GROUP BY`
- `JOIN` with `HAVING`
- `DISTINCT` with JOINs
- counting rows after JOINs
- `COUNT(DISTINCT ...)`
- finding unmatched records
- avoiding duplicate rows
- understanding row multiplication
- choosing the appropriate JOIN
- common advanced JOIN mistakes

The examples in this module use the `school` database and build on the tables introduced in previous modules.

---

# 1. RIGHT JOIN

A `RIGHT JOIN` returns every row from the table on the right side of the JOIN.

If a matching row exists in the left table, its data is returned.

If no matching row exists, the columns from the left table contain `NULL`.

### Syntax

```sql
SELECT columns
FROM table1
RIGHT JOIN table2
    ON table1.column = table2.column;
````

For example:

```sql
SELECT
    s.first_name,
    e.enrollment_id
FROM students AS s
RIGHT JOIN enrollments AS e
    ON s.student_id = e.student_id;
```

Because `enrollments` is on the right side, every enrollment is preserved.

---

# 2. RIGHT JOIN vs LEFT JOIN

The direction of the JOIN determines which table's rows are preserved.

For example:

```sql
FROM students AS s
LEFT JOIN enrollments AS e
    ON s.student_id = e.student_id;
```

This preserves every student.

By comparison:

```sql
FROM students AS s
RIGHT JOIN enrollments AS e
    ON s.student_id = e.student_id;
```

This preserves every enrollment.

A useful way to remember this is:

```text
LEFT JOIN  → preserve the LEFT table
RIGHT JOIN → preserve the RIGHT table
```

---

# 3. RIGHT JOIN Can Be Rewritten as LEFT JOIN

A `RIGHT JOIN` can usually be rewritten as a `LEFT JOIN` by reversing the order of the tables.

For example:

```sql
SELECT
    s.first_name,
    e.enrollment_id
FROM students AS s
RIGHT JOIN enrollments AS e
    ON s.student_id = e.student_id;
```

Can be rewritten as:

```sql
SELECT
    s.first_name,
    e.enrollment_id
FROM enrollments AS e
LEFT JOIN students AS s
    ON e.student_id = s.student_id;
```

Both queries preserve all rows from `enrollments`.

Many SQL developers prefer `LEFT JOIN` because consistently thinking in terms of "the table I want to preserve goes on the left" can make complex queries easier to read.

However, understanding `RIGHT JOIN` is still important because it appears in existing SQL code and technical interviews.

---

# 4. Finding Unmatched Records

JOINs are frequently used to find records that do not have a related record.

For example, to find students who have no enrollments:

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

The important pattern is:

```sql
LEFT JOIN
WHERE right_table.column IS NULL
```

This is commonly used to find missing relationships.

---

# 5. Finding Courses Without Students

The same technique can be used with courses.

```sql
SELECT
    c.course_id,
    c.course_name
FROM courses AS c
LEFT JOIN enrollments AS e
    ON c.course_id = e.course_id
WHERE e.enrollment_id IS NULL;
```

This returns courses that have no enrollment records.

The general pattern is:

```text
Parent table
     ↓
LEFT JOIN
     ↓
Related table
     ↓
WHERE related_table.id IS NULL
```

This is one of the most useful JOIN patterns to remember.

---

# 6. SELF JOIN

A `SELF JOIN` occurs when a table is joined to itself.

This is useful when rows in the same table have relationships with other rows in that same table.

For example, consider an `employees` table:

```text
employee_id
employee_name
department
manager_id
```

The `manager_id` contains the `employee_id` of another employee.

Therefore, the same table contains both employees and managers.

We can use a SELF JOIN:

```sql
SELECT
    e.employee_name AS employee,
    m.employee_name AS manager
FROM employees AS e
LEFT JOIN employees AS m
    ON e.manager_id = m.employee_id;
```

Here:

```text
e = employee
m = manager
```

Although both aliases refer to the same table, they represent different roles.

---

# 7. Why SELF JOIN Requires Aliases

Without aliases, it would be difficult to distinguish between the two instances of the table.

For example:

```sql
employees AS e
```

represents the employee.

```sql
employees AS m
```

represents the manager.

Therefore:

```sql
e.employee_name
```

means the employee's name.

While:

```sql
m.employee_name
```

means the manager's name.

Aliases are essential when joining a table to itself.

---

# 8. Employees and Managers

Suppose the `employees` table contains:

```text
employee_id | employee_name | manager_id
------------|---------------|-----------
1           | Anita Sharma  | NULL
2           | Rahul Mehta   | 1
3           | Priya Singh   | 1
4           | Aman Verma    | 2
5           | Neha Gupta    | 2
6           | Arjun Mehta   | 3
```

The relationships are:

```text
Anita Sharma
├── Rahul Mehta
│   ├── Aman Verma
│   └── Neha Gupta
└── Priya Singh
    └── Arjun Mehta
```

A SELF JOIN allows us to retrieve these relationships.

---

# 9. Employees With Managers

If we only want employees who have a manager, we can use `INNER JOIN`:

```sql
SELECT
    e.employee_name AS employee,
    m.employee_name AS manager
FROM employees AS e
INNER JOIN employees AS m
    ON e.manager_id = m.employee_id;
```

Employees whose `manager_id` is `NULL` will not appear.

---

# 10. Employees Without Managers

To find employees without managers:

```sql
SELECT
    e.employee_id,
    e.employee_name
FROM employees AS e
LEFT JOIN employees AS m
    ON e.manager_id = m.employee_id
WHERE e.manager_id IS NULL;
```

This is useful for identifying top-level employees such as department heads or CEOs.

---

# 11. Multi-Level SELF JOIN

A SELF JOIN can be repeated to follow multiple levels of a hierarchy.

For example:

```text
Employee
   ↓
Manager
   ↓
Manager's Manager
```

SQL:

```sql
SELECT
    e.employee_name AS employee,
    m.employee_name AS manager,
    gm.employee_name AS general_manager
FROM employees AS e
LEFT JOIN employees AS m
    ON e.manager_id = m.employee_id
LEFT JOIN employees AS gm
    ON m.manager_id = gm.employee_id;
```

Here:

```text
e  → employee
m  → manager
gm → manager's manager
```

This pattern is useful when working with organizational hierarchies.

---

# 12. Joining Multiple Tables

A query can join more than two tables.

Our school database contains a relationship like:

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

Therefore, to display students and their courses, we can join all three tables:

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

The `enrollments` table connects students and courses.

---

# 13. Many-to-Many Relationships

Students and courses have a many-to-many relationship.

One student can enroll in multiple courses.

One course can have multiple students.

Conceptually:

```text
students ←──────→ courses
```

Instead of directly connecting the two tables, we use a junction table:

```text
students
    ↓
enrollments
    ↓
courses
```

The `enrollments` table stores the relationships.

For example:

```text
student_id | course_id
-----------|----------
1          | 101
1          | 102
2          | 101
3          | 103
```

This means:

* Student 1 is enrolled in courses 101 and 102.
* Student 2 is enrolled in course 101.
* Student 3 is enrolled in course 103.

Understanding junction tables is essential before moving into larger relational databases.

---

# 14. JOIN With WHERE

A JOIN can be combined with a `WHERE` condition.

For example, to find courses taken by students from Mumbai:

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
WHERE s.city = 'Mumbai';
```

The JOIN determines which records are related.

The `WHERE` clause then filters the result.

---

# 15. Filtering in ON vs WHERE

One of the most important concepts in advanced JOINs is understanding the difference between putting a condition in `ON` and putting it in `WHERE`.

Consider:

```sql
SELECT
    s.first_name,
    e.course_id
FROM students AS s
LEFT JOIN enrollments AS e
    ON s.student_id = e.student_id
WHERE e.course_id = 101;
```

The `WHERE` condition removes rows where `e.course_id` is `NULL`.

This can effectively make the result behave like an INNER JOIN for that condition.

Now consider:

```sql
SELECT
    s.first_name,
    e.course_id
FROM students AS s
LEFT JOIN enrollments AS e
    ON s.student_id = e.student_id
    AND e.course_id = 101;
```

Here, all students remain.

Only enrollments for course `101` are matched.

This distinction is especially important with `LEFT JOIN`.

---

# 16. JOIN Conditions With Multiple Conditions

A JOIN condition can contain multiple conditions.

For example:

```sql
SELECT
    s.first_name,
    e.course_id
FROM students AS s
LEFT JOIN enrollments AS e
    ON s.student_id = e.student_id
    AND e.course_id = 101;
```

The relationship requires:

```text
student IDs must match
AND
course ID must be 101
```

Multiple conditions can be combined using `AND`.

---

# 17. JOIN With GROUP BY

JOINs are commonly combined with aggregate functions.

For example, to count students in each course:

```sql
SELECT
    c.course_name,
    COUNT(e.student_id) AS student_count
FROM courses AS c
LEFT JOIN enrollments AS e
    ON c.course_id = e.course_id
GROUP BY
    c.course_id,
    c.course_name;
```

Because this uses `LEFT JOIN`, courses with zero students can still appear.

This is an important real-world reporting pattern.

---

# 18. JOIN With HAVING

`HAVING` can filter grouped JOIN results.

For example, to find courses with at least two students:

```sql
SELECT
    c.course_name,
    COUNT(e.student_id) AS student_count
FROM courses AS c
LEFT JOIN enrollments AS e
    ON c.course_id = e.course_id
GROUP BY
    c.course_id,
    c.course_name
HAVING COUNT(e.student_id) >= 2;
```

Remember:

```text
WHERE  → filters rows
HAVING → filters groups
```

---

# 19. DISTINCT With JOINs

JOINs can produce multiple rows for the same entity.

Suppose Rahul is enrolled in three courses.

This query:

```sql
SELECT
    s.first_name
FROM students AS s
INNER JOIN enrollments AS e
    ON s.student_id = e.student_id;
```

may return:

```text
Rahul
Rahul
Rahul
```

If we only want each student once:

```sql
SELECT DISTINCT
    s.first_name
FROM students AS s
INNER JOIN enrollments AS e
    ON s.student_id = e.student_id;
```

The `DISTINCT` keyword removes duplicate result rows.

However, do not automatically add `DISTINCT` whenever a JOIN produces duplicates.

First determine whether the duplicates are actually expected.

---

# 20. Row Multiplication

JOINs can increase the number of rows in a result.

For example, suppose:

```text
Student A → 3 enrollments
```

Joining the student to the enrollment table produces three rows for Student A.

This is expected because one student is related to three enrollment records.

This becomes especially important when multiple one-to-many relationships are joined together.

For example:

```text
Student
   ↓
Enrollments
   ↓
Course
```

The number of rows depends on the number of relationships.

Before using aggregate functions, always ask:

> How many rows can one record produce after this JOIN?

---

# 21. COUNT(*) vs COUNT(column)

When working with JOINs, the choice of `COUNT()` matters.

Consider:

```sql
COUNT(*)
```

This counts result rows.

By comparison:

```sql
COUNT(e.enrollment_id)
```

counts non-NULL enrollment IDs.

With a `LEFT JOIN`, this difference is important.

For a course with no enrollment:

```text
COUNT(*)                  → 1
COUNT(e.enrollment_id)    → 0
```

Therefore, when counting matching records after a `LEFT JOIN`, counting a nullable column from the joined table is often more appropriate.

---

# 22. COUNT(DISTINCT ...)

Sometimes multiple rows can represent the same entity.

For example:

```sql
COUNT(DISTINCT e.student_id)
```

counts unique students.

This is useful when we want the number of distinct students rather than the total number of joined rows.

Example:

```sql
SELECT
    c.course_name,
    COUNT(DISTINCT e.student_id) AS student_count
FROM courses AS c
LEFT JOIN enrollments AS e
    ON c.course_id = e.course_id
GROUP BY
    c.course_id,
    c.course_name;
```

---

# 23. Finding Students With No Courses

A common interview-style question is:

> Find students who are not enrolled in any course.

Solution:

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

```text
Start with every student
        ↓
LEFT JOIN enrollments
        ↓
Keep students with no enrollment match
```

---

# 24. Finding Courses With No Students

The reverse problem:

> Find courses that have no students.

Solution:

```sql
SELECT
    c.course_id,
    c.course_name
FROM courses AS c
LEFT JOIN enrollments AS e
    ON c.course_id = e.course_id
WHERE e.enrollment_id IS NULL;
```

Again, the pattern is:

```text
preserved table
      ↓
LEFT JOIN
      ↓
WHERE joined_table.id IS NULL
```

---

# 25. SELF JOIN for Comparing Rows

A SELF JOIN can also be used to compare rows within the same table.

For example, suppose we want to find employees who report to the same manager.

```sql
SELECT
    e1.employee_name AS employee_1,
    e2.employee_name AS employee_2
FROM employees AS e1
INNER JOIN employees AS e2
    ON e1.manager_id = e2.manager_id
WHERE e1.employee_id < e2.employee_id;
```

The condition:

```sql
e1.employee_id < e2.employee_id
```

prevents duplicate pairs.

Without this condition, we might get:

```text
Rahul | Priya
Priya | Rahul
```

The condition keeps only one version.

---

# 26. Choosing the Correct JOIN

A useful decision process is:

### Use INNER JOIN when:

You only want records that have a match.

```sql
INNER JOIN
```

### Use LEFT JOIN when:

Every row from the left table must remain.

```sql
LEFT JOIN
```

### Use RIGHT JOIN when:

Every row from the right table must remain.

```sql
RIGHT JOIN
```

### Use SELF JOIN when:

Rows within the same table are related to each other.

```sql
employees AS e
JOIN employees AS m
```

---

# 27. A Practical JOIN Checklist

Before writing a JOIN, ask these questions:

```text
1. What is my main table?

2. Which table contains the related information?

3. Which columns connect the tables?

4. Do I need INNER JOIN or OUTER JOIN behavior?

5. Which table's rows must be preserved?

6. Can one row match multiple rows?

7. Could the JOIN produce duplicate rows?

8. Do I need DISTINCT?

9. Am I counting rows or unique entities?

10. Should a filtering condition go in ON or WHERE?

11. Could NULL values affect the result?

12. Do I need GROUP BY or HAVING?
```

This approach is more useful than simply memorizing JOIN syntax.

---

# 28. Common Advanced JOIN Mistakes

## Mistake 1 — Choosing the Wrong JOIN

Using `INNER JOIN` when unmatched rows need to be preserved will remove those rows.

For example:

```sql
INNER JOIN
```

will not preserve students who have no enrollments.

Use:

```sql
LEFT JOIN
```

when those students must remain.

---

## Mistake 2 — Filtering a LEFT JOIN in WHERE

This:

```sql
LEFT JOIN enrollments AS e
    ON s.student_id = e.student_id
WHERE e.course_id = 101
```

can remove students with no matching enrollment.

Sometimes the condition belongs in the `ON` clause instead.

---

## Mistake 3 — Forgetting SELF JOIN Aliases

This is confusing:

```sql
employees
JOIN employees
```

Instead use meaningful aliases:

```sql
employees AS e
JOIN employees AS m
```

---

## Mistake 4 — Ignoring Row Multiplication

A JOIN may produce more rows than expected.

Always understand the relationship between the tables before calculating totals.

---

## Mistake 5 — Using DISTINCT to Hide a JOIN Error

If a query unexpectedly returns duplicates, do not immediately add:

```sql
DISTINCT
```

First check whether the JOIN condition is correct.

---

## Mistake 6 — Using COUNT(*) When COUNT(column) Is Needed

With a `LEFT JOIN`, `COUNT(*)` can count the preserved row even when there is no match.

Often this is more appropriate:

```sql
COUNT(e.enrollment_id)
```

---

## Mistake 7 — Joining the Wrong Columns

Always identify the actual relationship.

For example:

```sql
s.student_id = e.student_id
```

connects students and enrollments.

Do not join columns merely because they have similar names or data types.

---

# 29. JOIN Order and Query Readability

There may be multiple technically valid ways to write a query.

However, starting with the table that represents the main subject often makes the query easier to understand.

For a student report:

```sql
FROM students AS s
```

For a course report:

```sql
FROM courses AS c
```

For an enrollment report:

```sql
FROM enrollments AS e
```

Then follow the relationships between the tables.

For example:

```text
students
   ↓
enrollments
   ↓
courses
```

This makes the query's purpose easier to understand.

---

# 30. JOINs in Real-World SQL

JOINs are one of the most frequently used SQL concepts in real applications.

They are commonly used for:

* customer orders
* products and categories
* employees and managers
* students and courses
* users and subscriptions
* customers and payments
* products and reviews
* departments and employees
* invoices and invoice items

A real-world report may involve several tables:

```text
customers
    ↓
orders
    ↓
order_items
    ↓
products
    ↓
categories
```

Understanding how to follow these relationships is one of the most important SQL skills.

---

# 31. Key Takeaways

In this module, we learned that:

* `RIGHT JOIN` preserves all rows from the right table.
* `LEFT JOIN` preserves all rows from the left table.
* A `RIGHT JOIN` can usually be rewritten as a `LEFT JOIN`.
* `SELF JOIN` joins a table to itself.
* SELF JOINs require aliases to distinguish different roles.
* A table can be joined multiple times.
* Many-to-many relationships commonly use junction tables.
* JOINs can be combined with `WHERE`.
* Conditions in `ON` and `WHERE` can produce different results with OUTER JOINs.
* JOINs can be combined with `GROUP BY` and `HAVING`.
* `DISTINCT` can remove duplicate result rows.
* `COUNT(column)` and `COUNT(*)` can behave differently with `LEFT JOIN`.
* `COUNT(DISTINCT column)` counts unique entities.
* JOINs can multiply rows.
* Understanding relationships is more important than memorizing JOIN syntax.

The most important questions to ask when writing a JOIN are:

```text
Which tables are related?

Which columns connect them?

Which rows must be preserved?

How many matches can each row have?

Could the JOIN create duplicate rows?

Where should my filtering condition go?
```

Once these questions become natural, more advanced SQL topics such as subqueries, `CASE`, CTEs, and window functions become much easier to understand.

```

