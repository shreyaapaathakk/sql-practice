# SELECT & Filtering

## Introduction

The `SELECT` statement is one of the most important SQL commands. It is used to retrieve data from database tables.

Basic syntax:

SELECT column1, column2
FROM table_name;

To retrieve every column:

SELECT *
FROM table_name;

---

## SELECT Specific Columns

SELECT first_name, age
FROM students;

Selecting only the columns you need makes queries easier to read and can reduce unnecessary data retrieval.

---

## SELECT All Columns

SELECT *
FROM students;

The `*` means all columns.

It is useful while learning and inspecting data, but in production queries it is often better to explicitly specify the columns you need.

---

## WHERE

`WHERE` filters records based on a condition.

SELECT *
FROM students
WHERE age = 20;

Only students whose age is 20 are returned.

---

## Comparison Operators

SQL provides several comparison operators:

| Operator | Meaning |
|---|---|
| = | Equal to |
| <> | Not equal to |
| != | Not equal to |
| > | Greater than |
| < | Less than |
| >= | Greater than or equal to |
| <= | Less than or equal to |

Example:

SELECT *
FROM students
WHERE age >= 20;

---

## AND

`AND` requires all conditions to be true.

SELECT *
FROM students
WHERE age >= 20
AND city = 'Delhi';

---

## OR

`OR` requires at least one condition to be true.

SELECT *
FROM students
WHERE city = 'Delhi'
OR city = 'Mumbai';

---

## NOT

`NOT` reverses a condition.

SELECT *
FROM students
WHERE NOT city = 'Delhi';

You can also use:

SELECT *
FROM students
WHERE city <> 'Delhi';

---

## IN

`IN` checks whether a value matches one of several values.

Instead of:

WHERE city = 'Delhi'
OR city = 'Mumbai'
OR city = 'Pune'

you can write:

WHERE city IN ('Delhi', 'Mumbai', 'Pune');

---

## NOT IN

To exclude several values:

SELECT *
FROM students
WHERE city NOT IN ('Delhi', 'Mumbai');

---

## BETWEEN

`BETWEEN` checks whether a value falls within a range.

SELECT *
FROM students
WHERE age BETWEEN 20 AND 22;

`BETWEEN` is inclusive, meaning 20 and 22 are included.

---

## NOT BETWEEN

SELECT *
FROM students
WHERE age NOT BETWEEN 20 AND 22;

---

## LIKE

`LIKE` is used for pattern matching.

### Starts with A

SELECT *
FROM students
WHERE first_name LIKE 'A%';

`%` represents zero or more characters.

### Ends with a

SELECT *
FROM students
WHERE first_name LIKE '%a';

### Contains "an"

SELECT *
FROM students
WHERE first_name LIKE '%an%';

---

## Underscore Wildcard

The `_` wildcard represents exactly one character.

Example:

SELECT *
FROM students
WHERE first_name LIKE 'A___';

This searches for names beginning with A followed by exactly three additional characters.

---

## IS NULL

`NULL` represents a missing or unknown value.

To find NULL values:

SELECT *
FROM students
WHERE city IS NULL;

Do not use:

WHERE city = NULL;

That will not correctly test for NULL.

---

## IS NOT NULL

SELECT *
FROM students
WHERE city IS NOT NULL;

---

## DISTINCT

`DISTINCT` removes duplicate values from the result.

SELECT DISTINCT city
FROM students;

This returns each city only once.

---

## Column Aliases

Aliases give columns temporary names in query results.

SELECT
    first_name AS Name,
    city AS Location
FROM students;

---

## ORDER BY

`ORDER BY` sorts query results.

Ascending order:

SELECT *
FROM students
ORDER BY age ASC;

Descending order:

SELECT *
FROM students
ORDER BY age DESC;

`ASC` is ascending and `DESC` is descending.

Ascending order is the default, so this:

ORDER BY age;

is equivalent to:

ORDER BY age ASC;

---

## Sorting by Multiple Columns

You can sort using more than one column.

SELECT *
FROM students
ORDER BY age ASC, first_name ASC;

SQL first sorts by age. If two records have the same age, it sorts those records by first name.

---

## LIMIT

`LIMIT` restricts the number of rows returned.

SELECT *
FROM students
LIMIT 5;

This returns at most five records.

---

## LIMIT with ORDER BY

To find the oldest student:

SELECT *
FROM students
ORDER BY age DESC
LIMIT 1;

To find the youngest student:

SELECT *
FROM students
ORDER BY age ASC
LIMIT 1;

---

## Combining Filtering and Sorting

You can combine WHERE and ORDER BY:

SELECT first_name, age, city
FROM students
WHERE age >= 20
ORDER BY age DESC;

The logical flow is:

FROM
↓
WHERE
↓
SELECT
↓
ORDER BY
↓
LIMIT

---

## Parentheses with AND and OR

When combining `AND` and `OR`, parentheses make your intention clear.

SELECT *
FROM students
WHERE age >= 20
AND (city = 'Delhi' OR city = 'Mumbai');

Without parentheses, SQL's operator precedence can produce results different from what you intended.

---

## Common Mistakes

### Using = with NULL

Incorrect:

WHERE city = NULL;

Correct:

WHERE city IS NULL;

### Forgetting quotes around text

Incorrect:

WHERE city = Delhi;

Correct:

WHERE city = 'Delhi';

### Confusing BETWEEN

BETWEEN includes both boundary values.

WHERE age BETWEEN 20 AND 22;

includes 20, 21, and 22.

### Using OR incorrectly

This:

WHERE city = 'Delhi' OR 'Mumbai';

is not the correct way to test two cities.

Use:

WHERE city IN ('Delhi', 'Mumbai');

---

## Learning Objectives

After completing this module, you should be able to:

- Retrieve data with SELECT.
- Select specific columns.
- Filter records with WHERE.
- Use comparison operators.
- Combine conditions using AND and OR.
- Exclude values using NOT and NOT IN.
- Filter ranges with BETWEEN.
- Search text using LIKE.
- Work correctly with NULL values.
- Remove duplicates using DISTINCT.
- Sort results with ORDER BY.
- Limit results with LIMIT.
- Combine multiple filtering and sorting techniques.

## What's Next?

Next module:

# Aggregate Functions

You will learn how to calculate:

- COUNT()
- SUM()
- AVG()
- MIN()
- MAX()

and eventually combine them with `GROUP BY` and `HAVING`.
