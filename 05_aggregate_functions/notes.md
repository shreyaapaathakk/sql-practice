# Module 05 — Aggregate Functions

## Overview

Aggregate functions perform calculations across multiple rows and return a summarized result. Instead of looking at individual student records, aggregate functions allow us to answer questions such as "How many students are there?", "What is the average age?", "What is the oldest student?", or "How many students are in each city?"

In this module, we will learn `COUNT()`, `SUM()`, `AVG()`, `MIN()`, `MAX()`, `GROUP BY`, and `HAVING`. These are fundamental SQL skills used extensively in reporting, analytics, dashboards, business intelligence, and SQL interviews.

The examples continue using the `school.students` table created in earlier modules.

---

## 1. What Are Aggregate Functions?

An aggregate function takes values from multiple rows and produces a single summarized result.

For example:

```sql
SELECT COUNT(*)
FROM students;
```

Instead of returning five student rows, this query returns one value representing the total number of rows.

Common aggregate functions include:

| Function  | Purpose                  |
| --------- | ------------------------ |
| `COUNT()` | Counts rows or values    |
| `SUM()`   | Calculates a total       |
| `AVG()`   | Calculates an average    |
| `MIN()`   | Finds the smallest value |
| `MAX()`   | Finds the largest value  |

---

## 2. COUNT()

`COUNT()` counts rows or non-NULL values.

### COUNT(*)

`COUNT(*)` counts every row.

```sql
SELECT COUNT(*)
FROM students;
```

If the table contains five students, the result is `5`.

### Using an Alias

Aliases make aggregate results easier to understand.

```sql
SELECT COUNT(*) AS total_students
FROM students;
```

---

## 3. COUNT(column)

`COUNT(column)` counts non-NULL values in the specified column.

```sql
SELECT COUNT(city) AS students_with_city
FROM students;
```

If a student's `city` is `NULL`, that row is not counted by `COUNT(city)`.

This is different from:

```sql
SELECT COUNT(*)
FROM students;
```

`COUNT(*)` counts the row regardless of whether individual columns contain `NULL`.

---

## 4. COUNT(DISTINCT column)

`COUNT(DISTINCT column)` counts unique non-NULL values.

For example:

```sql
SELECT COUNT(DISTINCT city) AS number_of_cities
FROM students;
```

This tells us how many different cities are represented in the table.

---

## 5. SUM()

`SUM()` calculates the total of a numeric column.

For example, if we have a table containing student fees:

```sql
SELECT SUM(fee_amount) AS total_fees
FROM student_fees;
```

`SUM()` is generally used with meaningful numeric quantities such as:

* fees
* sales
* salaries
* marks
* quantities
* expenses
* revenue

It would technically be possible to calculate `SUM(age)`, but that would usually not provide a meaningful business result.

---

## 6. AVG()

`AVG()` calculates the arithmetic average of numeric values.

```sql
SELECT AVG(age) AS average_age
FROM students;
```

The result may contain decimal places.

You can use `ROUND()` when you want a cleaner result:

```sql
SELECT ROUND(AVG(age), 2) AS average_age
FROM students;
```

`AVG()` ignores `NULL` values.

---

## 7. MIN()

`MIN()` returns the smallest value.

For numeric data:

```sql
SELECT MIN(age) AS youngest_age
FROM students;
```

For text columns, `MIN()` can also return the first value according to the database's comparison rules, although it is more commonly used with numeric or date values.

---

## 8. MAX()

`MAX()` returns the largest value.

```sql
SELECT MAX(age) AS oldest_age
FROM students;
```

Together, `MIN()` and `MAX()` are useful for finding ranges.

```sql
SELECT
    MIN(age) AS youngest_age,
    MAX(age) AS oldest_age
FROM students;
```

---

## 9. Multiple Aggregate Functions

Multiple aggregate functions can be used in the same query.

```sql
SELECT
    COUNT(*) AS total_students,
    AVG(age) AS average_age,
    MIN(age) AS youngest_age,
    MAX(age) AS oldest_age
FROM students;
```

This produces one summary row.

---

## 10. Aggregate Functions With WHERE

`WHERE` filters rows before the aggregate calculation is performed.

For example:

```sql
SELECT COUNT(*) AS students_20_or_older
FROM students
WHERE age >= 20;
```

The database first filters the students and then counts the remaining rows.

The general logical idea is:

```text
FROM
↓
WHERE
↓
Aggregate calculation
↓
SELECT result
```

---

## 11. GROUP BY

`GROUP BY` divides rows into groups and performs aggregate calculations separately for each group.

For example:

```sql
SELECT
    city,
    COUNT(*) AS student_count
FROM students
GROUP BY city;
```

Instead of one total for the entire table, we get one result for each city.

Conceptually:

```text
Delhi    → students in Delhi
Mumbai   → students in Mumbai
Jaipur   → students in Jaipur
Pune     → students in Pune
Lucknow  → students in Lucknow
```

---

## 12. GROUP BY With Other Aggregate Functions

You can use different aggregate functions with `GROUP BY`.

```sql
SELECT
    city,
    AVG(age) AS average_age
FROM students
GROUP BY city;
```

You can also combine several aggregates:

```sql
SELECT
    city,
    COUNT(*) AS student_count,
    AVG(age) AS average_age,
    MIN(age) AS youngest_age,
    MAX(age) AS oldest_age
FROM students
GROUP BY city;
```

---

## 13. GROUP BY Multiple Columns

You can group by more than one column.

```sql
SELECT
    city,
    age,
    COUNT(*) AS student_count
FROM students
GROUP BY city, age;
```

This creates a group for each unique combination of `city` and `age`.

For example:

```text
Delhi + 20
Mumbai + 21
Jaipur + 19
```

and so on.

---

## 14. HAVING

`HAVING` filters groups after aggregation.

For example:

```sql
SELECT
    city,
    COUNT(*) AS student_count
FROM students
GROUP BY city
HAVING COUNT(*) > 1;
```

This returns only cities containing more than one student.

The important distinction is:

```text
WHERE  → filters individual rows
HAVING → filters groups
```

---

## 15. WHERE vs HAVING

Consider this query:

```sql
SELECT
    city,
    COUNT(*) AS student_count
FROM students
WHERE age >= 20
GROUP BY city
HAVING COUNT(*) >= 2;
```

The processing is conceptually:

```text
1. FROM students
2. WHERE age >= 20
3. GROUP BY city
4. Calculate COUNT(*)
5. HAVING COUNT(*) >= 2
6. Return the result
```

So `WHERE` filters students before grouping, while `HAVING` filters the resulting groups.

---

## 16. GROUP BY With ORDER BY

You can sort grouped results.

```sql
SELECT
    city,
    COUNT(*) AS student_count
FROM students
GROUP BY city
ORDER BY student_count DESC;
```

This displays cities with the largest number of students first.

---

## 17. GROUP BY With HAVING and ORDER BY

These clauses can be combined.

```sql
SELECT
    city,
    COUNT(*) AS student_count
FROM students
GROUP BY city
HAVING COUNT(*) >= 2
ORDER BY student_count DESC;
```

This means:

* group students by city
* keep only cities with at least two students
* sort those cities by student count from highest to lowest

---

## 18. Aggregate Functions and NULL

Most aggregate functions ignore `NULL` values.

For example:

```sql
SELECT AVG(age)
FROM students;
```

If `age` contains a `NULL`, that value is not included in the average.

Similarly:

```sql
SELECT COUNT(age)
FROM students;
```

counts only rows where `age` is not `NULL`.

However:

```sql
SELECT COUNT(*)
FROM students;
```

counts every row.

This distinction is extremely important in real-world SQL.

---

## 19. Common Mistake: WHERE With an Aggregate

This is incorrect:

```sql
SELECT
    city,
    COUNT(*) AS student_count
FROM students
GROUP BY city
WHERE COUNT(*) > 1;
```

Aggregate conditions belong in `HAVING`, not `WHERE`.

Correct:

```sql
SELECT
    city,
    COUNT(*) AS student_count
FROM students
GROUP BY city
HAVING COUNT(*) > 1;
```

---

## 20. Common Mistake: Selecting a Non-Grouped Column

Consider:

```sql
SELECT city, first_name, COUNT(*)
FROM students
GROUP BY city;
```

This is problematic because `first_name` is neither grouped nor aggregated.

When using `GROUP BY`, selected columns generally need to be:

* included in `GROUP BY`, or
* used inside an aggregate function.

For example:

```sql
SELECT city, COUNT(*)
FROM students
GROUP BY city;
```

is valid.

---

## 21. Aggregate Query Execution Order

A useful simplified model of SQL query processing is:

```text
FROM
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

This is a conceptual processing order, not necessarily the exact physical execution plan used internally by MySQL.

Understanding this order helps explain why `WHERE` and `HAVING` serve different purposes.

---

## 22. Practical Questions You Can Answer

After this module, you should be able to write queries answering questions such as:

```text
How many students are there?

What is the average student age?

Who is the youngest student?

Who is the oldest student?

How many different cities are represented?

How many students live in each city?

What is the average age in each city?

Which cities have at least two students?

Which cities have an average age above 20?

How many students aged 20 or older are in each city?
```

---

## 23. Key Takeaways

`COUNT()` counts rows or non-NULL values.

`SUM()` calculates totals for numeric data.

`AVG()` calculates averages.

`MIN()` finds the smallest value.

`MAX()` finds the largest value.

`GROUP BY` creates groups so aggregate calculations can be performed separately for each group.

`WHERE` filters individual rows before grouping.

`HAVING` filters groups after aggregation.

`ORDER BY` can sort aggregate results.

`LIMIT` can restrict the number of grouped results returned.

The most important distinction in this module is:

```text
WHERE  → filter rows
HAVING → filter groups
```

Once these concepts are comfortable, we can move into more realistic datasets and then begin JOINs, which are one of the most important areas of SQL.
