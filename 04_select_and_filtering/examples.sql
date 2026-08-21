-- ============================================================
-- MODULE 04: SELECT & FILTERING
-- File: examples.sql
-- Database: school
-- MySQL 8.0+
-- ============================================================

USE school;


-- ============================================================
-- 1. SELECT
-- ============================================================

-- Select all columns from the students table.
SELECT *
FROM students;


-- Select specific columns.
SELECT first_name, last_name
FROM students;


-- Select multiple specific columns.
SELECT student_id, first_name, age, city
FROM students;


-- ============================================================
-- 2. COLUMN ALIASES
-- ============================================================

-- Rename columns in the result using aliases.
SELECT
    first_name AS first_name,
    last_name AS surname,
    age AS student_age
FROM students;


-- AS can be omitted.
SELECT
    first_name first_name,
    last_name surname
FROM students;


-- ============================================================
-- 3. WHERE
-- ============================================================

-- Find students who are exactly 20 years old.
SELECT *
FROM students
WHERE age = 20;


-- Find students older than 20.
SELECT *
FROM students
WHERE age > 20;


-- Find students younger than 21.
SELECT *
FROM students
WHERE age < 21;


-- Find students aged 20 or older.
SELECT *
FROM students
WHERE age >= 20;


-- Find students aged 20 or younger.
SELECT *
FROM students
WHERE age <= 20;


-- <> means "not equal to".
SELECT *
FROM students
WHERE city <> 'Delhi';


-- != also means "not equal to" in MySQL.
SELECT *
FROM students
WHERE city != 'Delhi';


-- ============================================================
-- 4. AND
-- ============================================================

-- Both conditions must be true.
SELECT *
FROM students
WHERE age >= 20
  AND city = 'Mumbai';


-- Multiple AND conditions.
SELECT *
FROM students
WHERE age >= 20
  AND age <= 22
  AND city <> 'Delhi';


-- ============================================================
-- 5. OR
-- ============================================================

-- At least one condition must be true.
SELECT *
FROM students
WHERE city = 'Delhi'
   OR city = 'Mumbai';


-- ============================================================
-- 6. NOT
-- ============================================================

-- NOT reverses a condition.
SELECT *
FROM students
WHERE NOT city = 'Delhi';


-- NOT can also be used with more complex conditions.
SELECT *
FROM students
WHERE NOT age > 20;


-- ============================================================
-- 7. PARENTHESES WITH AND / OR
-- ============================================================

-- Parentheses make the intended logic explicit.
SELECT *
FROM students
WHERE (city = 'Delhi' OR city = 'Mumbai')
  AND age >= 20;


-- Without parentheses, AND has higher precedence than OR.
-- Parentheses are recommended when mixing AND and OR.
SELECT *
FROM students
WHERE city = 'Delhi'
   OR (city = 'Mumbai' AND age >= 21);


-- ============================================================
-- 8. IN
-- ============================================================

-- Find students from any of the listed cities.
SELECT *
FROM students
WHERE city IN ('Delhi', 'Mumbai', 'Pune');


-- IN is useful when checking several possible values.
SELECT *
FROM students
WHERE age IN (19, 20, 22);


-- ============================================================
-- 9. NOT IN
-- ============================================================

-- Exclude students from the listed cities.
SELECT *
FROM students
WHERE city NOT IN ('Delhi', 'Mumbai');


-- ============================================================
-- 10. BETWEEN
-- ============================================================

-- BETWEEN includes both boundary values.
SELECT *
FROM students
WHERE age BETWEEN 20 AND 22;


-- Equivalent to:
-- age >= 20 AND age <= 22


-- ============================================================
-- 11. NOT BETWEEN
-- ============================================================

SELECT *
FROM students
WHERE age NOT BETWEEN 20 AND 22;


-- ============================================================
-- 12. LIKE
-- ============================================================

-- Names beginning with "A".
SELECT *
FROM students
WHERE first_name LIKE 'A%';


-- Names ending with "a".
SELECT *
FROM students
WHERE first_name LIKE '%a';


-- Names containing "h".
SELECT *
FROM students
WHERE first_name LIKE '%h%';


-- ============================================================
-- 13. % WILDCARD
-- ============================================================

-- % represents zero or more characters.
SELECT *
FROM students
WHERE city LIKE 'D%';


SELECT *
FROM students
WHERE city LIKE '%pur';


SELECT *
FROM students
WHERE city LIKE '%a%';


-- ============================================================
-- 14. _ WILDCARD
-- ============================================================

-- _ represents exactly one character.
SELECT *
FROM students
WHERE first_name LIKE '_man';


-- Matches a four-character name ending in "man".
-- Example: Aman


-- Find names where the second character is "r".
SELECT *
FROM students
WHERE first_name LIKE '_r%';


-- ============================================================
-- 15. IS NULL
-- ============================================================

-- Find rows where a column contains NULL.
SELECT *
FROM students
WHERE city IS NULL;


-- ============================================================
-- 16. IS NOT NULL
-- ============================================================

-- Find rows where city has a value.
SELECT *
FROM students
WHERE city IS NOT NULL;


-- IMPORTANT:
-- Do NOT use:
--
-- WHERE city = NULL
--
-- Use IS NULL instead.


-- ============================================================
-- 17. DISTINCT
-- ============================================================

-- Return each city only once.
SELECT DISTINCT city
FROM students;


-- DISTINCT can be applied to multiple columns.
SELECT DISTINCT age, city
FROM students;


-- ============================================================
-- 18. ORDER BY
-- ============================================================

-- Sort by age in ascending order.
SELECT *
FROM students
ORDER BY age ASC;


-- ASC is the default.
SELECT *
FROM students
ORDER BY age;


-- Sort by age in descending order.
SELECT *
FROM students
ORDER BY age DESC;


-- Sort alphabetically by first name.
SELECT *
FROM students
ORDER BY first_name ASC;


-- ============================================================
-- 19. SORTING BY MULTIPLE COLUMNS
-- ============================================================

-- Sort by age first.
-- If two students have the same age,
-- sort those students by first_name.
SELECT *
FROM students
ORDER BY age ASC, first_name ASC;


-- Sort by age descending, then name ascending.
SELECT *
FROM students
ORDER BY age DESC, first_name ASC;


-- ============================================================
-- 20. LIMIT
-- ============================================================

-- Return only the first three rows.
SELECT *
FROM students
LIMIT 3;


-- Find the three oldest students.
SELECT *
FROM students
ORDER BY age DESC
LIMIT 3;


-- Find the two youngest students.
SELECT *
FROM students
ORDER BY age ASC
LIMIT 2;


-- ============================================================
-- 21. WHERE + ORDER BY + LIMIT
-- ============================================================

-- Find students aged 20 or older,
-- sort them from oldest to youngest,
-- and return only two rows.
SELECT *
FROM students
WHERE age >= 20
ORDER BY age DESC
LIMIT 2;


-- Find students from selected cities,
-- sort alphabetically,
-- and return the first two.
SELECT *
FROM students
WHERE city IN ('Delhi', 'Mumbai', 'Pune')
ORDER BY first_name ASC
LIMIT 2;


-- ============================================================
-- 22. PRACTICAL FILTERING EXAMPLES
-- ============================================================

-- Students between ages 19 and 21 from selected cities.
SELECT
    first_name,
    last_name,
    age,
    city
FROM students
WHERE age BETWEEN 19 AND 21
  AND city IN ('Delhi', 'Mumbai', 'Jaipur');


-- Students whose names start with A and who are at least 19.
SELECT *
FROM students
WHERE first_name LIKE 'A%'
  AND age >= 19;


-- Students who are not from Delhi or Mumbai.
SELECT *
FROM students
WHERE city NOT IN ('Delhi', 'Mumbai');


-- Students aged 20 or 21, sorted by age and name.
SELECT *
FROM students
WHERE age IN (20, 21)
ORDER BY age ASC, first_name ASC;


-- ============================================================
-- 23. COMMON FILTERING MISTAKES
-- ============================================================

-- WRONG:
-- WHERE city = NULL

-- CORRECT:
SELECT *
FROM students
WHERE city IS NULL;


-- WRONG:
-- WHERE city <> NULL

-- CORRECT:
SELECT *
FROM students
WHERE city IS NOT NULL;


-- Be careful when mixing AND and OR.
-- Parentheses make the intended logic clear.

SELECT *
FROM students
WHERE (city = 'Delhi' OR city = 'Mumbai')
  AND age >= 20;


-- ============================================================
-- END OF MODULE 04 EXAMPLES
-- ============================================================
