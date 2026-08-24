# `solutions.sql`

```sql
-- ============================================================
-- MODULE 05: AGGREGATE FUNCTIONS
-- File: solutions.sql
-- Database: school
-- MySQL 8.0+
-- ============================================================

USE school;


-- ============================================================
-- EASY
-- ============================================================

-- Exercise 1
SELECT COUNT(*) AS total_students
FROM students;


-- Exercise 2
SELECT ROUND(AVG(age), 2) AS average_age
FROM students;


-- Exercise 3
SELECT MIN(age) AS youngest_age
FROM students;


-- Exercise 4
SELECT MAX(age) AS oldest_age
FROM students;


-- Exercise 5
SELECT
    MIN(age) AS youngest_age,
    MAX(age) AS oldest_age
FROM students;


-- Exercise 6
SELECT COUNT(DISTINCT city) AS number_of_cities
FROM students;


-- Exercise 7
SELECT COUNT(*) AS students_20_or_older
FROM students
WHERE age >= 20;


-- Exercise 8
SELECT ROUND(AVG(age), 2) AS average_age
FROM students
WHERE age < 21;


-- Exercise 9
SELECT MAX(age) AS oldest_mumbai_student
FROM students
WHERE city = 'Mumbai';


-- Exercise 10
SELECT MIN(age) AS youngest_delhi_student
FROM students
WHERE city = 'Delhi';


-- ============================================================
-- MEDIUM
-- ============================================================

-- Exercise 11
SELECT
    city,
    COUNT(*) AS student_count
FROM students
GROUP BY city;


-- Exercise 12
SELECT
    city,
    ROUND(AVG(age), 2) AS average_age
FROM students
GROUP BY city;


-- Exercise 13
SELECT
    city,
    MIN(age) AS youngest_age,
    MAX(age) AS oldest_age
FROM students
GROUP BY city;


-- Exercise 14
SELECT
    city,
    COUNT(*) AS student_count
FROM students
GROUP BY city
ORDER BY student_count DESC;


-- Exercise 15
SELECT
    city,
    COUNT(*) AS student_count
FROM students
WHERE age >= 20
GROUP BY city;


-- Exercise 16
SELECT
    city,
    ROUND(AVG(age), 2) AS average_age
FROM students
WHERE age >= 20
GROUP BY city;


-- Exercise 17
SELECT
    city,
    COUNT(*) AS student_count
FROM students
GROUP BY city
HAVING COUNT(*) > 1;


-- Exercise 18
SELECT
    city,
    ROUND(AVG(age), 2) AS average_age
FROM students
GROUP BY city
HAVING AVG(age) > 20;


-- Exercise 19
SELECT
    city,
    COUNT(*) AS student_count
FROM students
WHERE age >= 20
GROUP BY city
HAVING COUNT(*) >= 2;


-- Exercise 20
SELECT
    city,
    COUNT(*) AS student_count
FROM students
GROUP BY city
ORDER BY student_count DESC
LIMIT 2;


-- ============================================================
-- HARD
-- ============================================================

-- Exercise 21
SELECT
    city,
    COUNT(*) AS total_students,
    ROUND(AVG(age), 2) AS average_age,
    MIN(age) AS youngest_age,
    MAX(age) AS oldest_age
FROM students
GROUP BY city
ORDER BY total_students DESC;


-- Exercise 22
SELECT
    city,
    MIN(age) AS youngest_age
FROM students
GROUP BY city
HAVING MIN(age) >= 20;


-- Exercise 23
SELECT
    city,
    MAX(age) AS oldest_age
FROM students
GROUP BY city
HAVING MAX(age) > 20;


-- Exercise 24
SELECT
    city,
    age,
    COUNT(*) AS student_count
FROM students
GROUP BY city, age;


-- Exercise 25
SELECT
    city,
    ROUND(AVG(age), 2) AS average_age
FROM students
WHERE city IN ('Delhi', 'Mumbai', 'Pune')
GROUP BY city
HAVING AVG(age) >= 20;


-- Exercise 26
SELECT
    city,
    COUNT(*) AS student_count
FROM students
WHERE age BETWEEN 19 AND 21
GROUP BY city
HAVING COUNT(*) >= 1;


-- Exercise 27
SELECT
    city,
    COUNT(*) AS student_count,
    ROUND(AVG(age), 2) AS average_age
FROM students
GROUP BY city
HAVING COUNT(*) > 1
   AND AVG(age) > 20;


-- Exercise 28
SELECT
    city,
    COUNT(*) AS student_count,
    ROUND(AVG(age), 2) AS average_age
FROM students
WHERE age >= 20
GROUP BY city
HAVING COUNT(*) >= 2
ORDER BY average_age DESC;


-- Exercise 29
SELECT
    city,
    ROUND(AVG(age), 2) AS average_age
FROM students
GROUP BY city
HAVING COUNT(*) >= 2;


-- Exercise 30
-- Recreate the temporary table if it does not already exist.

CREATE TEMPORARY TABLE IF NOT EXISTS student_fees (
    student_id INT,
    fee_amount DECIMAL(10, 2)
);

INSERT INTO student_fees (student_id, fee_amount)
VALUES
    (1, 15000.00),
    (2, 18000.00),
    (3, 12000.00),
    (4, 20000.00),
    (5, 17500.00);


-- 1. Total fees
SELECT SUM(fee_amount) AS total_fees
FROM student_fees;


-- 2. Average fees
SELECT ROUND(AVG(fee_amount), 2) AS average_fee
FROM student_fees;


-- 3. Lowest fee
SELECT MIN(fee_amount) AS lowest_fee
FROM student_fees;


-- 4. Highest fee
SELECT MAX(fee_amount) AS highest_fee
FROM student_fees;


-- ============================================================
-- END OF SOLUTIONS
-- ============================================================
```
