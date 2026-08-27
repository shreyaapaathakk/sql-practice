# Module 11 — String Functions

Module 11 continues the progression from `CASE` expressions. We’ll focus on manipulating and cleaning text data using **MySQL 8.0+** string functions.

## Repository structure

```text
sql-practice/
└── 11_string_functions/
    ├── notes.md
    ├── examples.sql
    ├── practice.sql
    ├── solutions.sql
    └── challenge.sql
```

---

# `11_string_functions/notes.md`

````markdown
# Module 11 — String Functions

## Overview

String functions are SQL functions used to work with text values.

They are useful for:

- combining text
- changing letter case
- measuring text length
- removing unwanted spaces
- extracting parts of strings
- replacing text
- searching within text
- cleaning database values
- formatting reports

In this module we will use MySQL 8.0+ syntax.

The examples use the `students` table from the `school` database.

---

# 1. CONCAT()

`CONCAT()` combines two or more strings.

Syntax:

```sql
CONCAT(value1, value2, value3)
````

Example:

```sql
SELECT
    CONCAT(first_name, ' ', last_name) AS full_name
FROM students;
```

Example result:

```text
Rahul Sharma
Priya Singh
Aman Verma
```

---

# 2. CONCAT() With Multiple Values

You can combine several values.

```sql
SELECT
    CONCAT(first_name, ' - ', city) AS student_location
FROM students;
```

Example:

```text
Rahul - Delhi
Priya - Mumbai
```

---

# 3. CONCAT() and NULL

An important MySQL behavior is that `CONCAT()` returns `NULL` if any argument is `NULL`.

Example:

```sql
SELECT CONCAT('Hello', NULL);
```

Result:

```text
NULL
```

For NULL-safe concatenation, consider `CONCAT_WS()` or `COALESCE()`.

---

# 4. CONCAT_WS()

`CONCAT_WS()` means "concatenate with separator."

Syntax:

```sql
CONCAT_WS(separator, value1, value2, ...)
```

Example:

```sql
SELECT
    CONCAT_WS(' ', first_name, last_name) AS full_name
FROM students;
```

The first argument is the separator.

---

# 5. UPPER()

`UPPER()` converts text to uppercase.

```sql
SELECT
    UPPER(first_name) AS first_name_upper
FROM students;
```

Example:

```text
RAHUL
PRIYA
AMAN
```

---

# 6. LOWER()

`LOWER()` converts text to lowercase.

```sql
SELECT
    LOWER(first_name) AS first_name_lower
FROM students;
```

Example:

```text
rahul
priya
aman
```

---

# 7. LENGTH()

`LENGTH()` returns the length of a string in bytes.

For ordinary English text, the result usually corresponds to the number of characters.

Example:

```sql
SELECT
    first_name,
    LENGTH(first_name) AS name_length
FROM students;
```

Example:

```text
Rahul → 5
Priya → 5
Aman  → 4
```

For multilingual text, remember that `LENGTH()` measures bytes rather than characters.

---

# 8. CHAR_LENGTH()

`CHAR_LENGTH()` returns the number of characters.

```sql
SELECT
    first_name,
    CHAR_LENGTH(first_name) AS character_count
FROM students;
```

For Unicode or multilingual text, `CHAR_LENGTH()` is often more appropriate when you need the actual character count.

---

# 9. TRIM()

`TRIM()` removes leading and trailing spaces.

Example:

```sql
SELECT
    TRIM('   Rahul   ') AS cleaned_name;
```

Result:

```text
Rahul
```

This is especially useful when cleaning imported data.

---

# 10. LTRIM()

`LTRIM()` removes spaces from the left side.

```sql
SELECT
    LTRIM('   Rahul') AS cleaned_name;
```

Result:

```text
Rahul
```

---

# 11. RTRIM()

`RTRIM()` removes spaces from the right side.

```sql
SELECT
    RTRIM('Rahul   ') AS cleaned_name;
```

Result:

```text
Rahul
```

---

# 12. SUBSTRING()

`SUBSTRING()` extracts part of a string.

Syntax:

```sql
SUBSTRING(string, start_position, length)
```

Example:

```sql
SELECT
    SUBSTRING(first_name, 1, 3) AS short_name
FROM students;
```

For `Rahul`, the result is:

```text
Rah
```

Positions start at 1.

---

# 13. SUBSTRING() Without Length

You can omit the length.

```sql
SELECT
    SUBSTRING(first_name, 2) AS remaining_name
FROM students;
```

For `Rahul`:

```text
ahul
```

---

# 14. LEFT()

`LEFT()` returns characters from the beginning of a string.

Syntax:

```sql
LEFT(string, number_of_characters)
```

Example:

```sql
SELECT
    LEFT(first_name, 2) AS name_prefix
FROM students;
```

For `Rahul`:

```text
Ra
```

---

# 15. RIGHT()

`RIGHT()` returns characters from the end of a string.

Example:

```sql
SELECT
    RIGHT(first_name, 2) AS name_suffix
FROM students;
```

For `Rahul`:

```text
ul
```

---

# 16. REPLACE()

`REPLACE()` replaces one piece of text with another.

Syntax:

```sql
REPLACE(string, old_text, new_text)
```

Example:

```sql
SELECT
    REPLACE(city, 'Delhi', 'New Delhi') AS updated_city
FROM students;
```

Only matching occurrences are replaced.

---

# 17. LOCATE()

`LOCATE()` searches for a substring.

Syntax:

```sql
LOCATE(substring, string)
```

Example:

```sql
SELECT
    LOCATE('a', first_name) AS position_of_a
FROM students;
```

If the substring is found, its position is returned.

If it is not found, the result is:

```text
0
```

---

# 18. INSTR()

`INSTR()` also searches for a substring.

```sql
SELECT
    INSTR(first_name, 'a') AS position_of_a
FROM students;
```

It is similar to `LOCATE()`.

---

# 19. REVERSE()

`REVERSE()` reverses a string.

```sql
SELECT
    REVERSE(first_name) AS reversed_name
FROM students;
```

For:

```text
Rahul
```

the result is:

```text
luhaR
```

---

# 20. LPAD()

`LPAD()` adds characters to the left side of a string until it reaches a specified length.

Syntax:

```sql
LPAD(string, length, pad_string)
```

Example:

```sql
SELECT
    LPAD(student_id, 5, '0') AS formatted_id
FROM students;
```

Student ID `1` becomes:

```text
00001
```

---

# 21. RPAD()

`RPAD()` adds characters to the right side.

Example:

```sql
SELECT
    RPAD(first_name, 10, '.') AS formatted_name
FROM students;
```

The result is padded to a length of 10.

---

# 22. Combining String Functions

Functions can be nested.

Example:

```sql
SELECT
    UPPER(CONCAT(first_name, ' ', last_name)) AS full_name
FROM students;
```

This first combines the names and then converts the result to uppercase.

---

# 23. TRIM() + UPPER()

You can combine multiple functions.

```sql
SELECT
    UPPER(TRIM(first_name)) AS cleaned_name
FROM students;
```

This removes surrounding spaces and converts the result to uppercase.

---

# 24. String Functions With CASE

String functions can be combined with CASE.

```sql
SELECT
    first_name,
    CASE
        WHEN CHAR_LENGTH(first_name) >= 5
            THEN 'Long Name'
        ELSE 'Short Name'
    END AS name_length_category
FROM students;
```

---

# 25. String Functions With ORDER BY

You can sort using calculated string values.

```sql
SELECT
    first_name
FROM students
ORDER BY CHAR_LENGTH(first_name);
```

This sorts students by name length.

---

# 26. String Functions With WHERE

String functions can also be used for filtering.

Example:

```sql
SELECT *
FROM students
WHERE CHAR_LENGTH(first_name) > 4;
```

This returns students whose first name contains more than four characters.

---

# 27. String Functions and Aliases

Calculated string expressions should usually have meaningful aliases.

Instead of:

```sql
SELECT CONCAT(first_name, ' ', last_name)
FROM students;
```

prefer:

```sql
SELECT
    CONCAT(first_name, ' ', last_name) AS full_name
FROM students;
```

This makes the result easier to understand.

---

# 28. Cleaning Text Data

String functions are frequently used for data cleaning.

Example:

```sql
SELECT
    UPPER(TRIM(first_name)) AS cleaned_first_name
FROM students;
```

This:

1. removes surrounding spaces
2. converts the name to uppercase

---

# 29. Formatting Names

A common reporting requirement is to display a full name.

```sql
SELECT
    CONCAT_WS(' ', first_name, last_name) AS full_name
FROM students;
```

---

# 30. Creating a Username

String functions can be combined to create a simple username.

```sql
SELECT
    LOWER(
        CONCAT(first_name, '.', last_name)
    ) AS username
FROM students;
```

For Rahul Sharma:

```text
rahul.sharma
```

---

# 31. Creating Initials

You can extract initials using LEFT().

```sql
SELECT
    CONCAT(
        LEFT(first_name, 1),
        LEFT(last_name, 1)
    ) AS initials
FROM students;
```

For Rahul Sharma:

```text
RS
```

---

# 32. Extracting Name Parts

Suppose a column contains:

```text
Rahul Sharma
```

You can use string functions to extract pieces of the value.

For example:

```sql
SELECT
    LEFT('Rahul Sharma', 5);
```

returns:

```text
Rahul
```

More advanced extraction techniques will be introduced later when appropriate.

---

# 33. String Functions in Real-World SQL

String functions are commonly used for:

* cleaning customer names
* formatting addresses
* generating usernames
* creating display names
* extracting codes
* validating data
* standardizing capitalization
* preparing data for reports
* searching text

---

# 34. Important Functions in This Module

| Function      | Purpose                          |
| ------------- | -------------------------------- |
| CONCAT()      | Combine strings                  |
| CONCAT_WS()   | Combine strings with a separator |
| UPPER()       | Convert to uppercase             |
| LOWER()       | Convert to lowercase             |
| LENGTH()      | Return byte length               |
| CHAR_LENGTH() | Return character count           |
| TRIM()        | Remove leading/trailing spaces   |
| LTRIM()       | Remove left spaces               |
| RTRIM()       | Remove right spaces              |
| SUBSTRING()   | Extract part of a string         |
| LEFT()        | Extract from the beginning       |
| RIGHT()       | Extract from the end             |
| REPLACE()     | Replace text                     |
| LOCATE()      | Find text position               |
| INSTR()       | Find text position               |
| REVERSE()     | Reverse text                     |
| LPAD()        | Pad from the left                |
| RPAD()        | Pad from the right               |

---

# 35. Common Mistakes

## Mistake 1 — Confusing LENGTH() and CHAR_LENGTH()

`LENGTH()` measures bytes.

`CHAR_LENGTH()` measures characters.

For English text they often produce the same result, but they are conceptually different.

---

## Mistake 2 — Starting SUBSTRING() at position 0

SQL string positions normally start at 1.

Use:

```sql
SUBSTRING(first_name, 1, 3)
```

not:

```sql
SUBSTRING(first_name, 0, 3)
```

---

## Mistake 3 — Forgetting CONCAT() NULL behavior

If one CONCAT argument is NULL, the result can be NULL.

Use `CONCAT_WS()` or NULL-handling functions when appropriate.

---

## Mistake 4 — Modifying data when you only want to clean the output

This:

```sql
SELECT UPPER(TRIM(first_name))
FROM students;
```

only changes the query result.

It does not permanently modify the stored value.

---

# 36. String Functions vs LIKE

`LIKE` is useful for filtering based on patterns:

```sql
SELECT *
FROM students
WHERE first_name LIKE 'A%';
```

String functions transform or inspect values:

```sql
SELECT
    UPPER(first_name)
FROM students;
```

Both are useful, but they solve different problems.

---

# 37. Key Takeaways

String functions allow SQL to manipulate and analyze text.

The most important functions to remember are:

```text
CONCAT()
CONCAT_WS()
UPPER()
LOWER()
TRIM()
LENGTH()
CHAR_LENGTH()
SUBSTRING()
LEFT()
RIGHT()
REPLACE()
LOCATE()
```

Functions can be nested:

```sql
UPPER(TRIM(first_name))
```

They can also be combined with:

```text
CASE
WHERE
ORDER BY
GROUP BY
aggregate functions
```

String manipulation is an important SQL skill because real-world databases frequently contain text that needs to be cleaned, transformed, searched, or formatted.
