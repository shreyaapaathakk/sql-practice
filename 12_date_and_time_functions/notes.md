# Module 12 — Date & Time Functions

The folder will be:

```text
12_date_and_time_functions/
├── notes.md
├── examples.sql
├── practice.sql
├── solutions.sql
└── challenge.sql
```

## `12_date_and_time_functions/notes.md`

````markdown
# Module 12 — Date & Time Functions

## Overview

Dates and times are extremely common in real-world databases.

SQL is frequently used to answer questions such as:

- When was a record created?
- What is today's date?
- Which records were created this month?
- How many days are between two dates?
- How old is a record?
- What year or month does a date belong to?
- What date will occur 30 days from now?
- Which records occurred during a particular period?

MySQL provides many built-in functions for working with dates and times.

This module introduces the most commonly used date and time functions in MySQL 8.0+.

---

# 1. DATE Values

A MySQL DATE value represents a calendar date.

The standard format is:

```text
YYYY-MM-DD
````

Example:

```sql
'2026-08-27'
```

The components are:

```text
2026 → year
08   → month
27   → day
```

---

# 2. DATETIME Values

A DATETIME stores both date and time.

Example:

```text
2026-08-27 18:30:00
```

The format is:

```text
YYYY-MM-DD HH:MM:SS
```

---

# 3. TIME Values

A TIME value represents a time.

Example:

```text
18:30:00
```

---

# 4. Creating a Date-Based Table

For this module, we can create a separate table so that the original `students` table remains unchanged.

Example:

```sql
CREATE TABLE student_records (
    record_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    enrollment_date DATE,
    last_login DATETIME,
    birth_date DATE
);
```

---

# 5. CURDATE()

`CURDATE()` returns the current date.

```sql
SELECT CURDATE();
```

Example result:

```text
2026-08-27
```

The exact result depends on the date when the query is executed.

---

# 6. CURRENT_DATE()

`CURRENT_DATE()` also returns the current date.

```sql
SELECT CURRENT_DATE();
```

It is equivalent to:

```sql
CURDATE()
```

---

# 7. NOW()

`NOW()` returns the current date and time.

```sql
SELECT NOW();
```

Example:

```text
2026-08-27 18:30:45
```

The actual time changes whenever the query is executed.

---

# 8. CURRENT_TIMESTAMP()

`CURRENT_TIMESTAMP()` returns the current date and time.

```sql
SELECT CURRENT_TIMESTAMP();
```

It is commonly used when a query needs the current timestamp.

---

# 9. CURTIME()

`CURTIME()` returns the current time.

```sql
SELECT CURTIME();
```

Example:

```text
18:30:45
```

---

# 10. Extracting the DATE From a DATETIME

`DATE()` extracts the date portion from a DATETIME value.

```sql
SELECT
    DATE('2026-08-27 18:30:45') AS record_date;
```

Result:

```text
2026-08-27
```

---

# 11. Extracting the TIME From a DATETIME

`TIME()` extracts the time portion.

```sql
SELECT
    TIME('2026-08-27 18:30:45') AS record_time;
```

Result:

```text
18:30:45
```

---

# 12. YEAR()

`YEAR()` extracts the year from a date.

```sql
SELECT
    YEAR('2026-08-27') AS year_value;
```

Result:

```text
2026
```

---

# 13. MONTH()

`MONTH()` extracts the month number.

```sql
SELECT
    MONTH('2026-08-27') AS month_value;
```

Result:

```text
8
```

---

# 14. MONTHNAME()

`MONTHNAME()` returns the name of the month.

```sql
SELECT
    MONTHNAME('2026-08-27') AS month_name;
```

Result:

```text
August
```

---

# 15. DAY()

`DAY()` returns the day of the month.

```sql
SELECT
    DAY('2026-08-27') AS day_value;
```

Result:

```text
27
```

---

# 16. DAYNAME()

`DAYNAME()` returns the name of the weekday.

```sql
SELECT
    DAYNAME('2026-08-27') AS day_name;
```

The result depends on the date supplied.

---

# 17. HOUR()

`HOUR()` extracts the hour from a time or DATETIME value.

```sql
SELECT
    HOUR('18:30:45') AS hour_value;
```

Result:

```text
18
```

---

# 18. MINUTE()

`MINUTE()` extracts the minute.

```sql
SELECT
    MINUTE('18:30:45') AS minute_value;
```

Result:

```text
30
```

---

# 19. SECOND()

`SECOND()` extracts the seconds.

```sql
SELECT
    SECOND('18:30:45') AS second_value;
```

Result:

```text
45
```

---

# 20. DATEDIFF()

`DATEDIFF()` calculates the number of days between two dates.

Syntax:

```sql
DATEDIFF(date1, date2)
```

Example:

```sql
SELECT
    DATEDIFF('2026-08-27', '2026-08-20') AS days_difference;
```

Result:

```text
7
```

The time portion is ignored when using `DATEDIFF()`.

---

# 21. DATEDIFF() Direction

The order of the arguments matters.

```sql
SELECT DATEDIFF('2026-08-27', '2026-08-20');
```

returns:

```text
7
```

But:

```sql
SELECT DATEDIFF('2026-08-20', '2026-08-27');
```

returns:

```text
-7
```

---

# 22. DATE_ADD()

`DATE_ADD()` adds an interval to a date.

Syntax:

```sql
DATE_ADD(date, INTERVAL value unit)
```

Example:

```sql
SELECT
    DATE_ADD('2026-08-27', INTERVAL 10 DAY) AS future_date;
```

Result:

```text
2026-09-06
```

---

# 23. Adding Months

You can add months.

```sql
SELECT
    DATE_ADD('2026-08-27', INTERVAL 2 MONTH) AS future_date;
```

---

# 24. Adding Years

You can add years.

```sql
SELECT
    DATE_ADD('2026-08-27', INTERVAL 1 YEAR) AS future_date;
```

---

# 25. Adding Hours

Intervals can also be used with DATETIME values.

```sql
SELECT
    DATE_ADD(
        '2026-08-27 18:30:00',
        INTERVAL 3 HOUR
    ) AS future_time;
```

---

# 26. DATE_SUB()

`DATE_SUB()` subtracts an interval from a date.

Example:

```sql
SELECT
    DATE_SUB('2026-08-27', INTERVAL 10 DAY) AS previous_date;
```

---

# 27. Subtracting Months

```sql
SELECT
    DATE_SUB('2026-08-27', INTERVAL 2 MONTH) AS previous_date;
```

---

# 28. Subtracting Years

```sql
SELECT
    DATE_SUB('2026-08-27', INTERVAL 1 YEAR) AS previous_date;
```

---

# 29. TIMESTAMPDIFF()

`TIMESTAMPDIFF()` calculates the difference between two dates or timestamps using a specified unit.

Syntax:

```sql
TIMESTAMPDIFF(unit, start_date, end_date)
```

Example:

```sql
SELECT
    TIMESTAMPDIFF(
        YEAR,
        '2005-01-01',
        '2026-01-01'
    ) AS years_difference;
```

Result:

```text
21
```

---

# 30. TIMESTAMPDIFF() With Different Units

You can calculate differences in:

```text
YEAR
MONTH
DAY
HOUR
MINUTE
SECOND
```

Example:

```sql
SELECT
    TIMESTAMPDIFF(
        MONTH,
        '2026-01-01',
        '2026-08-01'
    ) AS months_difference;
```

---

# 31. LAST_DAY()

`LAST_DAY()` returns the last day of the month.

```sql
SELECT
    LAST_DAY('2026-08-15') AS month_end;
```

Result:

```text
2026-08-31
```

This is useful for monthly reporting.

---

# 32. DAYOFWEEK()

`DAYOFWEEK()` returns a numeric representation of the weekday.

```sql
SELECT
    DAYOFWEEK('2026-08-27') AS weekday_number;
```

The numbering follows MySQL's weekday convention.

---

# 33. WEEKDAY()

`WEEKDAY()` also returns a weekday number, but uses a different numbering system.

```sql
SELECT
    WEEKDAY('2026-08-27') AS weekday_number;
```

Do not confuse `DAYOFWEEK()` and `WEEKDAY()`.

---

# 34. EXTRACT()

`EXTRACT()` retrieves a specific component from a date or datetime.

Syntax:

```sql
EXTRACT(unit FROM date)
```

Example:

```sql
SELECT
    EXTRACT(YEAR FROM '2026-08-27') AS year_value;
```

Another example:

```sql
SELECT
    EXTRACT(MONTH FROM '2026-08-27') AS month_value;
```

---

# 35. Date Functions With Tables

Suppose we have:

```text
student_records
```

with:

```text
enrollment_date
last_login
birth_date
```

We can extract information from those columns.

```sql
SELECT
    student_id,
    enrollment_date,
    YEAR(enrollment_date) AS enrollment_year
FROM student_records;
```

---

# 36. Finding Recently Enrolled Students

You can compare dates using `WHERE`.

```sql
SELECT *
FROM student_records
WHERE enrollment_date >= '2026-01-01';
```

---

# 37. Finding Records From a Specific Year

Use `YEAR()`:

```sql
SELECT *
FROM student_records
WHERE YEAR(enrollment_date) = 2026;
```

For larger production tables, direct date ranges are often preferable because applying a function to the indexed column can make index usage less efficient.

For example:

```sql
SELECT *
FROM student_records
WHERE enrollment_date >= '2026-01-01'
  AND enrollment_date < '2027-01-01';
```

---

# 38. Finding Records From a Specific Month

A date range is often a good approach:

```sql
SELECT *
FROM student_records
WHERE enrollment_date >= '2026-08-01'
  AND enrollment_date < '2026-09-01';
```

---

# 39. Records From the Last 30 Days

A common real-world query is:

```sql
SELECT *
FROM student_records
WHERE enrollment_date >= DATE_SUB(CURDATE(), INTERVAL 30 DAY);
```

This dynamically calculates the date 30 days before today.

---

# 40. Records From Today

For a DATE column:

```sql
SELECT *
FROM student_records
WHERE enrollment_date = CURDATE();
```

For a DATETIME column, use a range:

```sql
SELECT *
FROM student_records
WHERE last_login >= CURDATE()
  AND last_login < DATE_ADD(CURDATE(), INTERVAL 1 DAY);
```

---

# 41. Calculating Days Since Enrollment

```sql
SELECT
    student_id,
    enrollment_date,
    DATEDIFF(
        CURDATE(),
        enrollment_date
    ) AS days_since_enrollment
FROM student_records;
```

---

# 42. Calculating a Future Date

Suppose a student receives a 30-day course period.

```sql
SELECT
    student_id,
    enrollment_date,
    DATE_ADD(
        enrollment_date,
        INTERVAL 30 DAY
    ) AS course_end_date
FROM student_records;
```

---

# 43. Calculating Age

A simple year difference can be calculated with:

```sql
TIMESTAMPDIFF(
    YEAR,
    birth_date,
    CURDATE()
)
```

Example:

```sql
SELECT
    student_id,
    birth_date,
    TIMESTAMPDIFF(
        YEAR,
        birth_date,
        CURDATE()
    ) AS age
FROM student_records;
```

`TIMESTAMPDIFF()` is preferred over simply subtracting years because it accounts for whether the birthday has occurred yet.

---

# 44. Formatting Dates

`DATE_FORMAT()` formats a date or datetime as text.

Example:

```sql
SELECT
    DATE_FORMAT(
        '2026-08-27',
        '%d-%m-%Y'
    ) AS formatted_date;
```

Result:

```text
27-08-2026
```

---

# 45. Common DATE_FORMAT() Specifiers

Some useful format specifiers are:

| Specifier | Meaning                 |
| --------- | ----------------------- |
| `%Y`      | Four-digit year         |
| `%y`      | Two-digit year          |
| `%m`      | Month number            |
| `%M`      | Full month name         |
| `%d`      | Day of month            |
| `%D`      | Day with English suffix |
| `%H`      | Hour, 00–23             |
| `%i`      | Minutes                 |
| `%s`      | Seconds                 |
| `%W`      | Full weekday name       |

Example:

```sql
SELECT
    DATE_FORMAT(
        '2026-08-27 18:30:45',
        '%W, %M %d, %Y'
    ) AS formatted_datetime;
```

---

# 46. STR_TO_DATE()

`STR_TO_DATE()` converts a string into a date or datetime using a specified format.

Example:

```sql
SELECT
    STR_TO_DATE(
        '27-08-2026',
        '%d-%m-%Y'
    ) AS converted_date;
```

Result:

```text
2026-08-27
```

This can be useful when importing data stored in a non-standard text format.

---

# 47. Date Comparisons

Dates can be compared using normal comparison operators.

```sql
SELECT *
FROM student_records
WHERE enrollment_date > '2026-01-01';
```

You can also use:

```text
=
<>
>
<
>=
<=
```

---

# 48. ORDER BY Dates

Dates can be sorted.

Oldest first:

```sql
SELECT *
FROM student_records
ORDER BY enrollment_date ASC;
```

Newest first:

```sql
SELECT *
FROM student_records
ORDER BY enrollment_date DESC;
```

---

# 49. LIMIT With Dates

You can find the most recently enrolled students:

```sql
SELECT *
FROM student_records
ORDER BY enrollment_date DESC
LIMIT 3;
```

---

# 50. NULL Dates

Date columns can contain NULL.

Use:

```sql
WHERE enrollment_date IS NULL;
```

to find missing dates.

Use:

```sql
WHERE enrollment_date IS NOT NULL;
```

to find records with an enrollment date.

Do not use:

```sql
WHERE enrollment_date = NULL;
```

because NULL represents an unknown or missing value.

---

# 51. Important Date Functions

| Function            | Purpose                          |
| ------------------- | -------------------------------- |
| CURDATE()           | Current date                     |
| CURRENT_DATE()      | Current date                     |
| NOW()               | Current date and time            |
| CURRENT_TIMESTAMP() | Current date and time            |
| CURTIME()           | Current time                     |
| DATE()              | Extract date                     |
| TIME()              | Extract time                     |
| YEAR()              | Extract year                     |
| MONTH()             | Extract month                    |
| MONTHNAME()         | Month name                       |
| DAY()               | Day of month                     |
| DAYNAME()           | Weekday name                     |
| HOUR()              | Extract hour                     |
| MINUTE()            | Extract minute                   |
| SECOND()            | Extract second                   |
| DATEDIFF()          | Difference in days               |
| TIMESTAMPDIFF()     | Difference using a selected unit |
| DATE_ADD()          | Add an interval                  |
| DATE_SUB()          | Subtract an interval             |
| LAST_DAY()          | Last day of month                |
| EXTRACT()           | Extract date component           |
| DATE_FORMAT()       | Format date/time                 |
| STR_TO_DATE()       | Convert text to date/time        |

---

# 52. Common Mistakes

## Mistake 1 — Comparing a DATETIME directly to CURDATE()

This can cause unexpected results:

```sql
WHERE last_login = CURDATE()
```

If `last_login` contains a time component, it may not equal midnight.

A range is safer:

```sql
WHERE last_login >= CURDATE()
  AND last_login < DATE_ADD(CURDATE(), INTERVAL 1 DAY)
```

---

## Mistake 2 — Confusing DATEDIFF() and TIMESTAMPDIFF()

`DATEDIFF()` returns a difference in days.

```sql
DATEDIFF(date1, date2)
```

`TIMESTAMPDIFF()` lets you specify the unit.

```sql
TIMESTAMPDIFF(MONTH, date1, date2)
```

---

## Mistake 3 — Reversing DATEDIFF() Arguments

These produce opposite signs:

```sql
DATEDIFF(date1, date2)
```

and:

```sql
DATEDIFF(date2, date1)
```

---

## Mistake 4 — Using String Functions for Date Calculations

Avoid manually manipulating date strings when MySQL provides date functions.

Prefer:

```sql
DATE_ADD()
DATE_SUB()
DATEDIFF()
TIMESTAMPDIFF()
```

---

# 53. Key Takeaways

Date and time functions are essential for real-world SQL.

The most important functions in this module are:

```text
CURDATE()
NOW()
DATE()
TIME()
YEAR()
MONTH()
DAY()
DATEDIFF()
TIMESTAMPDIFF()
DATE_ADD()
DATE_SUB()
LAST_DAY()
DATE_FORMAT()
STR_TO_DATE()
```

You should now be comfortable:

* extracting date components
* comparing dates
* calculating date differences
* adding and subtracting intervals
* filtering records by date
* sorting records by date
* calculating ages
* formatting dates
* handling missing dates
