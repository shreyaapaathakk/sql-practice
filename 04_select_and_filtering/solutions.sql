-- ============================================================
-- MODULE 04: SELECT & FILTERING
-- File: solutions.sql
-- Database: school
-- MySQL 8.0+
-- ============================================================

USE school;


-- ============================================================
-- EASY
-- ============================================================

-- Exercise 1
SELECT *
FROM students;


-- Exercise 2
SELECT first_name, last_name, city
FROM students;


-- Exercise 3
SELECT
    first_name,
    age AS student_age
FROM students;


-- Exercise 4
SELECT *
FROM students
WHERE age = 20;


-- Exercise 5
SELECT *
FROM students
WHERE age > 20;


-- Exercise 6
SELECT *
FROM students
WHERE age <= 20;


-- Exercise 7
SELECT *
FROM students
WHERE city <> 'Delhi';


-- Exercise 8
SELECT *
FROM students
WHERE city IN ('Delhi', 'Mumbai');


-- Exercise 9
SELECT *
FROM students
WHERE age BETWEEN 20 AND 22;


-- Exercise 10
SELECT DISTINCT city
FROM students;


-- ============================================================
-- MEDIUM
-- ============================================================

-- Exercise 11
SELECT *
FROM students
WHERE age NOT BETWEEN 20 AND 22;


-- Exercise 12
SELECT *
FROM students
WHERE city IN ('Delhi', 'Pune', 'Lucknow');


-- Exercise 13
SELECT *
FROM students
WHERE city NOT IN ('Delhi', 'Pune', 'Lucknow');


-- Exercise 14
SELECT *
FROM students
WHERE first_name LIKE 'A%';


-- Exercise 15
SELECT *
FROM students
WHERE first_name LIKE '%a';


-- Exercise 16
SELECT *
FROM students
WHERE first_name LIKE '%h%';


-- Exercise 17
SELECT *
FROM students
WHERE first_name LIKE '____';


-- Exercise 18
SELECT *
FROM students
WHERE age >= 20
  AND city IN ('Delhi', 'Mumbai');


-- Exercise 19
SELECT *
FROM students
WHERE age < 20
   OR age > 21;


-- Exercise 20
SELECT *
FROM students
WHERE city <> 'Delhi'
  AND age >= 20;


-- Exercise 21
SELECT *
FROM students
ORDER BY age ASC;


-- Exercise 22
SELECT *
FROM students
ORDER BY age DESC;


-- Exercise 23
SELECT *
FROM students
ORDER BY age ASC, first_name ASC;


-- ============================================================
-- HARD
-- ============================================================

-- Exercise 24
SELECT *
FROM students
WHERE city IN ('Delhi', 'Mumbai', 'Pune')
  AND age >= 20;


-- Exercise 25
SELECT *
FROM students
WHERE (city = 'Delhi' AND age >= 20)
   OR (city = 'Mumbai' AND age >= 21);


-- Exercise 26
SELECT *
FROM students
WHERE first_name LIKE 'A%'
   OR city LIKE '%pur';


-- Exercise 27
SELECT *
FROM students
WHERE age BETWEEN 19 AND 21
  AND city <> 'Mumbai';


-- Exercise 28
SELECT
    first_name AS first_name,
    last_name,
    city AS hometown
FROM students
ORDER BY hometown ASC;


-- Exercise 29
SELECT *
FROM students
ORDER BY age DESC
LIMIT 2;


-- Exercise 30
SELECT *
FROM students
ORDER BY age ASC, first_name ASC
LIMIT 3;


-- Exercise 31
SELECT *
FROM students
WHERE age >= 20
  AND city <> 'Delhi'
ORDER BY age DESC
LIMIT 2;


-- Exercise 32
SELECT *
FROM students
WHERE age BETWEEN 19 AND 22
  AND city IN ('Delhi', 'Mumbai', 'Jaipur', 'Pune')
  AND first_name LIKE '%a%'
ORDER BY age ASC, first_name ASC;


-- Exercise 33
SELECT DISTINCT age, city
FROM students;


-- Exercise 34
SELECT *
FROM students
WHERE first_name LIKE 'A%'
  AND city <> 'Lucknow';


-- Exercise 35
SELECT *
FROM students
WHERE city IN ('Delhi', 'Mumbai', 'Pune')
ORDER BY age DESC
LIMIT 1;


-- ============================================================
-- END OF SOLUTIONS
-- ============================================================
