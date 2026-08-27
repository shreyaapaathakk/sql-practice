-- ============================================================
-- MODULE 11: STRING FUNCTIONS
-- File: solutions.sql
-- MySQL 8.0+
-- ============================================================

USE school;


-- ============================================================
-- EASY
-- ============================================================

-- Exercise 1

SELECT
    CONCAT(first_name, ' ', last_name) AS full_name
FROM students;


-- Exercise 2

SELECT
    first_name,
    UPPER(first_name) AS first_name_upper
FROM students;


-- Exercise 3

SELECT
    city,
    LOWER(city) AS city_lower
FROM students;


-- Exercise 4

SELECT
    first_name,
    CHAR_LENGTH(first_name) AS name_length
FROM students;


-- Exercise 5

SELECT
    first_name,
    LEFT(first_name, 3) AS short_name
FROM students;


-- Exercise 6

SELECT
    first_name,
    RIGHT(first_name, 2) AS name_suffix
FROM students;


-- Exercise 7

SELECT
    CONCAT(first_name, ' - ', last_name) AS student_name
FROM students;


-- Exercise 8

SELECT
    first_name,
    LEFT(first_name, 1) AS name_initial
FROM students;


-- ============================================================
-- MEDIUM
-- ============================================================

-- Exercise 9

SELECT
    CONCAT_WS(' ', first_name, last_name) AS full_name
FROM students;


-- Exercise 10

SELECT
    LOWER(
        CONCAT(first_name, '.', last_name)
    ) AS username
FROM students;


-- Exercise 11

SELECT
    CONCAT(
        LEFT(first_name, 1),
        LEFT(last_name, 1)
    ) AS initials
FROM students;


-- Exercise 12

SELECT
    *
FROM students
WHERE LOCATE('a', first_name) > 0;


-- Exercise 13

SELECT
    *
FROM students
WHERE CHAR_LENGTH(first_name) > 4;


-- Exercise 14

SELECT
    first_name,
    LEFT(first_name, 3) AS short_name
FROM students;


-- Exercise 15

SELECT
    first_name,
    REPLACE(city, 'Delhi', 'New Delhi') AS updated_city
FROM students;


-- Exercise 16

SELECT
    first_name,
    CASE
        WHEN CHAR_LENGTH(first_name) >= 5
            THEN 'Long'
        ELSE 'Short'
    END AS name_category
FROM students;


-- Exercise 17

SELECT
    first_name,
    REVERSE(first_name) AS reversed_name
FROM students;


-- Exercise 18

SELECT
    student_id,
    LPAD(student_id, 5, '0') AS formatted_id
FROM students;


-- ============================================================
-- HARD
-- ============================================================

-- Exercise 19

SELECT
    CONCAT(
        UPPER(CONCAT(first_name, ' ', last_name)),
        ' | ',
        city
    ) AS student_label
FROM students;


-- Exercise 20

SELECT
    first_name,
    last_name,
    CONCAT(first_name, ' ', last_name) AS full_name,
    CONCAT(
        LEFT(first_name, 1),
        LEFT(last_name, 1)
    ) AS initials,
    LOWER(
        CONCAT(first_name, '.', last_name)
    ) AS username
FROM students;


-- Exercise 21

SELECT
    first_name
FROM students
ORDER BY
    CHAR_LENGTH(first_name) ASC,
    first_name ASC;


-- Exercise 22

SELECT
    *
FROM students
WHERE LEFT(first_name, 1) = 'A';


-- Exercise 23

SELECT
    *
FROM students
WHERE RIGHT(first_name, 1) = 'a';


-- Exercise 24

SELECT
    first_name,
    CHAR_LENGTH(first_name) AS name_length,
    CASE
        WHEN CHAR_LENGTH(first_name) <= 4 THEN 'Short'
        WHEN CHAR_LENGTH(first_name) = 5 THEN 'Medium'
        ELSE 'Long'
    END AS name_category
FROM students;


-- Exercise 25

SELECT
    student_id,
    CONCAT(
        'STUDENT-',
        LPAD(student_id, 5, '0')
    ) AS formatted_student_id
FROM students;


-- Exercise 26

SELECT
    CONCAT(first_name, ' ', last_name) AS full_name,
    city,
    CONCAT(
        first_name,
        ' ',
        last_name,
        ' - ',
        city
    ) AS location_label
FROM students;


-- Exercise 27

SELECT
    UPPER(TRIM(first_name)) AS cleaned_name
FROM students;


-- Exercise 28

SELECT
    first_name,
    LOCATE('a', first_name) AS position_of_a
FROM students;


-- Exercise 29

SELECT
    CONCAT(
        UPPER(last_name),
        ', ',
        first_name
    ) AS display_name
FROM students;


-- Exercise 30

SELECT
    student_id,
    CONCAT(first_name, ' ', last_name) AS full_name,
    CONCAT(
        LEFT(first_name, 1),
        LEFT(last_name, 1)
    ) AS initials,
    LOWER(
        CONCAT(first_name, '.', last_name)
    ) AS username,
    city,
    CHAR_LENGTH(first_name) AS name_length
FROM students
ORDER BY
    city,
    full_name;
