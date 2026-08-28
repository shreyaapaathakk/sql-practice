# Module 13 — NULL Handling

We’ll continue the repository sequentially with the same structure:

```text
13_null_handling/
├── notes.md
├── examples.sql
├── practice.sql
├── solutions.sql
└── challenge.sql
```

This module focuses specifically on how `NULL` behaves in MySQL, including `IS NULL`, `IS NOT NULL`, `COALESCE()`, `IFNULL()`, `NULLIF()`, NULL in calculations, filtering, sorting, and aggregates.

## `13_null_handling/notes.md`

````markdown
# Module 13 — NULL Handling

## Overview

`NULL` is one of the most important concepts in SQL.

NULL does not mean:

- 0
- an empty string
- false
- a blank space

Instead, NULL represents a missing, unknown, or unavailable value.

Understanding NULL is essential because it behaves differently from ordinary values.

This module covers NULL handling in MySQL 8.0+.

---

# 1. What Is NULL?

Suppose a student does not have a phone number recorded.

The phone number might be stored as:

```sql
NULL
````

This means the value is missing or unknown.

It does not mean:

```text
0
```

and it does not necessarily mean:

```text
''
```

---

# 2. Creating a NULL-Friendly Table

For this module, we will use a separate table.

```sql
CREATE TABLE student_details (
    student_id INT PRIMARY KEY,
    email VARCHAR(100),
    phone VARCHAR(20),
    scholarship DECIMAL(10,2),
    mentor VARCHAR(100)
);
```

Some columns can contain NULL values.

---

# 3. Inserting NULL

NULL can be inserted explicitly.

```sql
INSERT INTO student_details
    (student_id, email, phone, scholarship, mentor)
VALUES
    (1, 'rahul@example.com', NULL, 5000.00, 'Anita'),
    (2, NULL, '9876543210', NULL, 'Ravi'),
    (3, 'aman@example.com', NULL, 3000.00, NULL);
```

---

# 4. NULL Is Not Zero

Consider:

```sql
scholarship = 0
```

This means the scholarship amount is known and is zero.

But:

```sql
scholarship = NULL
```

means the scholarship amount is unknown or missing.

These are different situations.

---

# 5. NULL Is Not an Empty String

These are also different:

```sql
email = NULL
```

and:

```sql
email = ''
```

An empty string is a known string containing no characters.

NULL means the value is missing or unknown.

---

# 6. Checking for NULL

Do not use:

```sql
WHERE phone = NULL;
```

This does not correctly test for NULL.

Instead use:

```sql
WHERE phone IS NULL;
```

---

# 7. IS NULL

`IS NULL` finds rows where a value is NULL.

Example:

```sql
SELECT *
FROM student_details
WHERE phone IS NULL;
```

---

# 8. IS NOT NULL

`IS NOT NULL` finds rows where a value exists.

```sql
SELECT *
FROM student_details
WHERE phone IS NOT NULL;
```

---

# 9. Why = NULL Does Not Work

SQL uses three-valued logic:

```text
TRUE
FALSE
UNKNOWN
```

A comparison such as:

```sql
phone = NULL
```

produces UNKNOWN rather than TRUE.

Therefore:

```sql
WHERE phone = NULL
```

does not return rows where phone is NULL.

Use:

```sql
WHERE phone IS NULL;
```

---

# 10. NULL in Calculations

NULL usually propagates through arithmetic expressions.

For example:

```sql
SELECT
    scholarship + 1000
FROM student_details;
```

If `scholarship` is NULL, the result is also NULL.

Conceptually:

```text
NULL + 1000 = NULL
```

---

# 11. COALESCE()

`COALESCE()` returns the first non-NULL value from a list of expressions.

Syntax:

```sql
COALESCE(value1, value2, value3, ...)
```

Example:

```sql
SELECT
    COALESCE(phone, 'Not Provided') AS phone_number
FROM student_details;
```

If phone is NULL, the query returns:

```text
Not Provided
```

---

# 12. COALESCE() With Multiple Values

```sql
SELECT
    COALESCE(
        phone,
        email,
        'No Contact Information'
    ) AS contact
FROM student_details;
```

MySQL checks the values from left to right.

It returns the first value that is not NULL.

---

# 13. IFNULL()

`IFNULL()` accepts two arguments.

Syntax:

```sql
IFNULL(value, replacement)
```

Example:

```sql
SELECT
    IFNULL(phone, 'Not Provided') AS phone_number
FROM student_details;
```

If phone is NULL, the replacement value is returned.

---

# 14. COALESCE() vs IFNULL()

Both can replace NULL values.

`IFNULL()`:

```sql
IFNULL(phone, 'Not Provided')
```

`COALESCE()`:

```sql
COALESCE(phone, 'Not Provided')
```

`COALESCE()` is more flexible because it can check multiple expressions.

Example:

```sql
COALESCE(
    phone,
    email,
    'No Contact'
)
```

---

# 15. NULLIF()

`NULLIF()` returns NULL if its two arguments are equal.

Syntax:

```sql
NULLIF(value1, value2)
```

Example:

```sql
SELECT
    NULLIF(10, 10);
```

Result:

```text
NULL
```

If the values are different:

```sql
SELECT
    NULLIF(10, 20);
```

The result is:

```text
10
```

---

# 16. NULLIF() in Data Cleaning

Suppose an imported dataset uses `0` to represent missing scholarship information.

You can convert 0 to NULL:

```sql
SELECT
    NULLIF(scholarship, 0) AS scholarship
FROM student_details;
```

This can be useful when cleaning imported data.

---

# 17. NULL in COUNT()

Consider:

```sql
SELECT COUNT(phone)
FROM student_details;
```

`COUNT(column)` counts only non-NULL values.

It does not count NULL values.

---

# 18. COUNT(*) and NULL

`COUNT(*)` counts rows.

```sql
SELECT COUNT(*)
FROM student_details;
```

It counts every row, regardless of NULL values.

This distinction is important:

```sql
COUNT(*)
```

counts rows.

```sql
COUNT(column)
```

counts non-NULL values in that column.

---

# 19. NULL in SUM()

`SUM()` ignores NULL values.

Example:

```sql
SELECT
    SUM(scholarship)
FROM student_details;
```

If some scholarship values are NULL, those rows are ignored.

---

# 20. NULL in AVG()

`AVG()` also ignores NULL values.

For example:

```sql
SELECT
    AVG(scholarship)
FROM student_details;
```

The average is calculated using non-NULL scholarship values.

NULL is not treated as zero.

---

# 21. NULL in MIN() and MAX()

`MIN()` and `MAX()` ignore NULL values.

```sql
SELECT
    MIN(scholarship),
    MAX(scholarship)
FROM student_details;
```

Only non-NULL scholarship values are considered.

---

# 22. Replacing NULL Before Calculations

Suppose missing scholarship values should be treated as zero for a particular report.

You can use:

```sql
SELECT
    scholarship,
    COALESCE(scholarship, 0) AS scholarship_amount
FROM student_details;
```

Now NULL scholarship values are displayed as 0.

Be careful: this changes the interpretation of the data for that calculation.

---

# 23. NULL and WHERE

A condition involving NULL does not behave like an ordinary comparison.

For example:

```sql
SELECT *
FROM student_details
WHERE scholarship > 2000;
```

Rows where scholarship is NULL are not returned.

---

# 24. Combining NULL Conditions

You can combine NULL checks with other conditions.

```sql
SELECT *
FROM student_details
WHERE phone IS NULL
  AND email IS NOT NULL;
```

This finds students who have no phone number but do have an email address.

---

# 25. NULL and OR

Example:

```sql
SELECT *
FROM student_details
WHERE phone IS NULL
   OR email IS NULL;
```

This finds students missing at least one contact method.

---

# 26. Finding Complete Contact Information

```sql
SELECT *
FROM student_details
WHERE phone IS NOT NULL
  AND email IS NOT NULL;
```

Both values must be available.

---

# 27. Finding Students With Any Contact Information

```sql
SELECT *
FROM student_details
WHERE phone IS NOT NULL
   OR email IS NOT NULL;
```

At least one contact method must exist.

---

# 28. NULL and ORDER BY

NULL values can appear when sorting.

Example:

```sql
SELECT *
FROM student_details
ORDER BY scholarship ASC;
```

The exact placement of NULL values depends on the sort direction and MySQL's ordering behavior.

If you need explicit control, use an expression.

Example:

```sql
SELECT *
FROM student_details
ORDER BY
    scholarship IS NULL,
    scholarship ASC;
```

This can place non-NULL values before NULL values.

---

# 29. NULL and DISTINCT

NULL is considered as a distinct value for the purpose of `DISTINCT`.

Example:

```sql
SELECT DISTINCT mentor
FROM student_details;
```

If several rows contain NULL mentor values, NULL appears as one distinct result.

---

# 30. NULL and GROUP BY

NULL values are grouped together.

Example:

```sql
SELECT
    mentor,
    COUNT(*) AS student_count
FROM student_details
GROUP BY mentor;
```

All rows where mentor is NULL belong to the same group.

---

# 31. Checking Missing Data

A common data-quality query is:

```sql
SELECT
    COUNT(*) AS total_students,
    COUNT(phone) AS students_with_phone,
    COUNT(*) - COUNT(phone) AS students_without_phone
FROM student_details;
```

This compares total rows with non-NULL values.

---

# 32. Calculating NULL Percentages

You can calculate the percentage of missing phone numbers.

```sql
SELECT
    COUNT(*) AS total_students,
    COUNT(*) - COUNT(phone) AS missing_phone,
    (COUNT(*) - COUNT(phone)) * 100.0 / COUNT(*) AS missing_percentage
FROM student_details;
```

This is a useful real-world data-quality technique.

---

# 33. NULL in CASE

NULL conditions can be handled using `IS NULL`.

```sql
SELECT
    student_id,
    CASE
        WHEN phone IS NULL THEN 'Missing'
        ELSE 'Available'
    END AS phone_status
FROM student_details;
```

---

# 34. COALESCE() in Reports

Instead of displaying NULL:

```sql
SELECT
    student_id,
    phone
FROM student_details;
```

you can create a more readable report:

```sql
SELECT
    student_id,
    COALESCE(phone, 'Not Provided') AS phone
FROM student_details;
```

---

# 35. Multiple Fallback Values

A realistic contact report might use:

```sql
SELECT
    student_id,
    COALESCE(
        phone,
        email,
        'No Contact Information'
    ) AS preferred_contact
FROM student_details;
```

This tries phone first, then email, then a fallback message.

---

# 36. NULLIF() and Division by Zero

`NULLIF()` can help avoid division-by-zero errors.

Suppose:

```sql
SELECT
    total_marks / total_subjects
FROM results;
```

If `total_subjects` is zero, the calculation can cause a problem.

You can use:

```sql
SELECT
    total_marks / NULLIF(total_subjects, 0)
FROM results;
```

If `total_subjects` is 0, `NULLIF()` returns NULL.

The division therefore becomes:

```text
total_marks / NULL
```

which produces NULL rather than dividing by zero.

---

# 37. NULL Propagation

Remember that NULL often propagates through expressions.

For example:

```sql
SELECT
    100 + NULL;
```

returns:

```text
NULL
```

Similarly:

```sql
SELECT
    CONCAT('Student: ', NULL);
```

can result in NULL.

When building reports, consider whether `COALESCE()` is appropriate.

---

# 38. NULL vs Zero

This distinction is particularly important in reporting.

Suppose scholarship information is:

```text
5000
3000
NULL
0
```

These values can mean:

```text
5000 → scholarship is 5000
3000 → scholarship is 3000
NULL → scholarship information is missing
0 → scholarship is known to be zero
```

Do not automatically convert NULL to zero unless that interpretation is appropriate.

---

# 39. NULL vs Empty String

Similarly:

```text
NULL → value is missing/unknown
''   → value is an empty string
```

You can check an empty string separately:

```sql
WHERE email = '';
```

You can check NULL separately:

```sql
WHERE email IS NULL;
```

If imported data contains both, they may need different handling.

---

# 40. Finding Both NULL and Empty Strings

For a text column:

```sql
SELECT *
FROM student_details
WHERE email IS NULL
   OR email = '';
```

This can help identify incomplete contact data.

---

# 41. Converting Empty Strings to NULL

`NULLIF()` can convert an empty string into NULL.

```sql
SELECT
    NULLIF(email, '') AS cleaned_email
FROM student_details;
```

If email is:

```text
''
```

the result becomes:

```text
NULL
```

---

# 42. Combining NULLIF() and COALESCE()

You can normalize empty strings and then provide a fallback.

```sql
SELECT
    COALESCE(
        NULLIF(email, ''),
        'Not Provided'
    ) AS email
FROM student_details;
```

The process is:

1. Convert empty string to NULL.
2. Replace NULL with `Not Provided`.

---

# 43. Common NULL Functions

| Function      | Purpose                               |
| ------------- | ------------------------------------- |
| `IS NULL`     | Check whether a value is NULL         |
| `IS NOT NULL` | Check whether a value is not NULL     |
| `COALESCE()`  | Return first non-NULL value           |
| `IFNULL()`    | Replace NULL with another value       |
| `NULLIF()`    | Return NULL when two values are equal |

---

# 44. Important Rules

Remember these rules:

### Rule 1

Never use:

```sql
column = NULL
```

Use:

```sql
column IS NULL
```

### Rule 2

Never use:

```sql
column != NULL
```

Use:

```sql
column IS NOT NULL
```

### Rule 3

`COUNT(column)` ignores NULL.

### Rule 4

`COUNT(*)` counts rows regardless of NULL.

### Rule 5

`SUM()`, `AVG()`, `MIN()`, and `MAX()` generally ignore NULL values.

### Rule 6

NULL is not the same as zero.

### Rule 7

NULL is not the same as an empty string.

### Rule 8

Use `COALESCE()` when you need multiple fallback values.

### Rule 9

Use `IFNULL()` when you need a simple two-value replacement.

### Rule 10

Use `NULLIF()` when a particular value should be converted to NULL or when you need to protect calculations such as division.

---

# 45. Key Takeaways

By the end of this module, you should understand:

* what NULL represents
* why NULL is different from zero
* why NULL is different from an empty string
* how to find NULL values
* how to find non-NULL values
* how NULL behaves in calculations
* how aggregate functions handle NULL
* the difference between COUNT(*) and COUNT(column)
* how to replace NULL with COALESCE()
* how to replace NULL with IFNULL()
* how to use NULLIF()
* how to handle missing data in reports
* how to identify incomplete records
* how to safely handle division by zero
