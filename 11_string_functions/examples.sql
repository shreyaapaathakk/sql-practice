
---

# `11_string_functions/examples.sql`

```sql
-- ============================================================
-- MODULE 11: STRING FUNCTIONS
-- File: examples.sql
-- MySQL 8.0+
-- ============================================================

USE school;


-- ============================================================
-- 1. CONCAT()
-- ============================================================

SELECT
    CONCAT(first_name, ' ', last_name) AS full_name
FROM students;


-- ============================================================
-- 2. CONCAT() WITH MULTIPLE VALUES
-- ============================================================

SELECT
    CONCAT(first_name, ' - ', city) AS student_location
FROM students;


-- ============================================================
-- 3. CONCAT_WS()
-- ============================================================

SELECT
    CONCAT_WS(' ', first_name, last_name) AS full_name
FROM students;


-- ============================================================
-- 4. UPPER()
-- ============================================================

SELECT
    first_name,
    UPPER(first_name) AS first_name_upper
FROM students;


-- ============================================================
-- 5. LOWER()
-- ============================================================

SELECT
    first_name,
    LOWER(first_name) AS first_name_lower
FROM students;


-- ============================================================
-- 6. LENGTH()
-- ============================================================

SELECT
    first_name,
    LENGTH(first_name) AS name_length
FROM students;


-- ============================================================
-- 7. CHAR_LENGTH()
-- ============================================================

SELECT
    first_name,
    CHAR_LENGTH(first_name) AS character_count
FROM students;


-- ============================================================
-- 8. TRIM()
-- ============================================================

SELECT
    TRIM('   Rahul   ') AS cleaned_name;


-- ============================================================
-- 9. LTRIM()
-- ============================================================

SELECT
    LTRIM('   Rahul') AS cleaned_name;


-- ============================================================
-- 10. RTRIM()
-- ============================================================

SELECT
    RTRIM('Rahul   ') AS cleaned_name;


-- ============================================================
-- 11. SUBSTRING()
-- ============================================================

SELECT
    first_name,
    SUBSTRING(first_name, 1, 3) AS short_name
FROM students;


-- ============================================================
-- 12. SUBSTRING() WITHOUT LENGTH
-- ============================================================

SELECT
    first_name,
    SUBSTRING(first_name, 2) AS remaining_name
FROM students;


-- ============================================================
-- 13. LEFT()
-- ============================================================

SELECT
    first_name,
    LEFT(first_name, 2) AS name_prefix
FROM students;


-- ============================================================
-- 14. RIGHT()
-- ============================================================

SELECT
    first_name,
    RIGHT(first_name, 2) AS name_suffix
FROM students;


-- ============================================================
-- 15. REPLACE()
-- ============================================================

SELECT
    city,
    REPLACE(city, 'Delhi', 'New Delhi') AS updated_city
FROM students;


-- ============================================================
-- 16. LOCATE()
-- ============================================================

SELECT
    first_name,
    LOCATE('a', first_name) AS position_of_a
FROM students;


-- ============================================================
-- 17. INSTR()
-- ============================================================

SELECT
    first_name,
    INSTR(first_name, 'a') AS position_of_a
FROM students;


-- ============================================================
-- 18. REVERSE()
-- ============================================================

SELECT
    first_name,
    REVERSE(first_name) AS reversed_name
FROM students;


-- ============================================================
-- 19. LPAD()
-- ============================================================

SELECT
    student_id,
    LPAD(student_id, 5, '0') AS formatted_id
FROM students;


-- ============================================================
-- 20. RPAD()
-- ============================================================

SELECT
    first_name,
    RPAD(first_name, 10, '.') AS formatted_name
FROM students;


-- ============================================================
-- 21. NESTED STRING FUNCTIONS
-- ============================================================

SELECT
    UPPER(
        CONCAT(first_name, ' ', last_name)
    ) AS full_name_upper
FROM students;


-- ============================================================
-- 22. TRIM() + UPPER()
-- ============================================================

SELECT
    UPPER(TRIM(first_name)) AS cleaned_name
FROM students;


-- ============================================================
-- 23. CASE + CHAR_LENGTH()
-- ============================================================

SELECT
    first_name,
    CASE
        WHEN CHAR_LENGTH(first_name) >= 5
            THEN 'Long Name'
        ELSE 'Short Name'
    END AS name_length_category
FROM students;


-- ============================================================
-- 24. ORDER BY STRING LENGTH
-- ============================================================

SELECT
    first_name
FROM students
ORDER BY CHAR_LENGTH(first_name);


-- ============================================================
-- 25. WHERE + STRING FUNCTION
-- ============================================================

SELECT *
FROM students
WHERE CHAR_LENGTH(first_name) > 4;


-- ============================================================
-- 26. CREATE A USERNAME
-- ============================================================

SELECT
    LOWER(
        CONCAT(first_name, '.', last_name)
    ) AS username
FROM students;


-- ============================================================
-- 27. CREATE INITIALS
-- ============================================================

SELECT
    CONCAT(
        LEFT(first_name, 1),
        LEFT(last_name, 1)
    ) AS initials
FROM students;


-- ============================================================
-- 28. FULL STUDENT LABEL
-- ============================================================

SELECT
    CONCAT(
        first_name,
        ' ',
        last_name,
        ' - ',
        city
    ) AS student_label
FROM students;


-- ============================================================
-- 29. NAME AND CITY IN UPPERCASE
-- ============================================================

SELECT
    UPPER(first_name) AS first_name,
    UPPER(city) AS city
FROM students;


-- ============================================================
-- 30. PRACTICAL STUDENT REPORT
-- ============================================================

SELECT
    student_id,
    CONCAT_WS(' ', first_name, last_name) AS full_name,
    UPPER(city) AS city,
    CHAR_LENGTH(first_name) AS first_name_length,
    CONCAT(
        LEFT(first_name, 1),
        LEFT(last_name, 1)
    ) AS initials
FROM students
ORDER BY full_name;
