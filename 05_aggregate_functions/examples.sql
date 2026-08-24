# `examples.sql`

```sql
-- ============================================================
-- MODULE 05: AGGREGATE FUNCTIONS
-- File: examples.sql
-- Database: school
-- MySQL 8.0+
-- ============================================================

USE school;


-- ============================================================
-- 1. COUNT()
-- ============================================================

-- Count every student.
SELECT COUNT(*) AS total_students
FROM students;


-- Count non-NULL student IDs.
SELECT COUNT(student_id) AS students_with_id
FROM students;


-- Count non-NULL cities.
SELECT COUNT(city) AS students_with_city
FROM students;


-- Count unique cities.
SELECT COUNT(DISTINCT city) AS number_of_cities
FROM students;


-- ============================================================
-- 2. AVG()
-- ============================================================

-- Calculate the average age.
SELECT AVG(age) AS average_age
FROM students;


-- Round the average to two decimal places.
SELECT ROUND(AVG(age), 2) AS average_age
FROM students;


-- ============================================================
-- 3. MIN() AND MAX()
-- ============================================================

-- Find the youngest age.
SELECT MIN(age) AS youngest_age
FROM students;


-- Find the oldest age.
SELECT MAX(age) AS oldest_age
FROM students;


-- Find both the youngest and oldest ages.
SELECT
    MIN(age) AS youngest_age,
    MAX(age) AS oldest_age
FROM students;


-- ============================================================
-- 4. MULTIPLE AGGREGATES
-- ============================================================

SELECT
    COUNT(*) AS total_students,
    ROUND(AVG(age), 2) AS average_age,
    MIN(age) AS youngest_age,
    MAX(age) AS oldest_age
FROM students;


-- ============================================================
-- 5. AGGREGATES WITH WHERE
-- ============================================================

-- Count students aged 20 or older.
SELECT COUNT(*) AS students_20_or_older
FROM students
WHERE age >= 20;


-- Find the average age of students aged 20 or older.
SELECT ROUND(AVG(age), 2) AS average_age
FROM students
WHERE age >= 20;


-- Find the oldest student age among students from Delhi.
SELECT MAX(age) AS oldest_delhi_student
FROM students
WHERE city = 'Delhi';


-- ============================================================
-- 6. SUM() WITH A PRACTICAL NUMERIC DATASET
-- ============================================================

-- This table is used only to demonstrate SUM().
-- It does not replace the existing students table.

CREATE TEMPORARY TABLE student_fees (
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


-- Calculate total fees.
SELECT SUM(fee_amount) AS total_fees
FROM student_fees;


-- Calculate the average fee.
SELECT AVG(fee_amount) AS average_fee
FROM student_fees;


-- Find the lowest and highest fee.
SELECT
    MIN(fee_amount) AS lowest_fee,
    MAX(fee_amount) AS highest_fee
FROM student_fees;


-- Count fee records.
SELECT COUNT(*) AS fee_records
FROM student_fees;


-- ============================================================
-- 7. GROUP BY
-- ============================================================

-- Count students in each city.
SELECT
    city,
    COUNT(*) AS student_count
FROM students
GROUP BY city;


-- Calculate average age for each city.
SELECT
    city,
    ROUND(AVG(age), 2) AS average_age
FROM students
GROUP BY city;


-- Find the youngest and oldest student age in each city.
SELECT
    city,
    MIN(age) AS youngest_age,
    MAX(age) AS oldest_age
FROM students
GROUP BY city;


-- ============================================================
-- 8. GROUP BY WITH MULTIPLE AGGREGATES
-- ============================================================

SELECT
    city,
    COUNT(*) AS student_count,
    ROUND(AVG(age), 2) AS average_age,
    MIN(age) AS youngest_age,
    MAX(age) AS oldest_age
FROM students
GROUP BY city;


-- ============================================================
-- 9. GROUP BY MULTIPLE COLUMNS
-- ============================================================

-- Count students for each city + age combination.
SELECT
    city,
    age,
    COUNT(*) AS student_count
FROM students
GROUP BY city, age;


-- ============================================================
-- 10. GROUP BY WITH WHERE
-- ============================================================

-- Count students aged 20 or older in each city.
SELECT
    city,
    COUNT(*) AS student_count
FROM students
WHERE age >= 20
GROUP BY city;


-- Calculate average age for students aged 20 or older,
-- grouped by city.
SELECT
    city,
    ROUND(AVG(age), 2) AS average_age
FROM students
WHERE age >= 20
GROUP BY city;


-- ============================================================
-- 11. HAVING
-- ============================================================

-- Show only cities containing at least two students.
SELECT
    city,
    COUNT(*) AS student_count
FROM students
GROUP BY city
HAVING COUNT(*) >= 2;


-- Show cities whose average age is greater than 20.
SELECT
    city,
    ROUND(AVG(age), 2) AS average_age
FROM students
GROUP BY city
HAVING AVG(age) > 20;


-- ============================================================
-- 12. WHERE + GROUP BY + HAVING
-- ============================================================

-- First filter students aged 20 or older.
-- Then group them by city.
-- Finally keep cities with at least two students.
SELECT
    city,
    COUNT(*) AS student_count
FROM students
WHERE age >= 20
GROUP BY city
HAVING COUNT(*) >= 2;


-- ============================================================
-- 13. GROUP BY + ORDER BY
-- ============================================================

-- Show cities with the most students first.
SELECT
    city,
    COUNT(*) AS student_count
FROM students
GROUP BY city
ORDER BY student_count DESC;


-- Show cities with the fewest students first.
SELECT
    city,
    COUNT(*) AS student_count
FROM students
GROUP BY city
ORDER BY student_count ASC;


-- ============================================================
-- 14. GROUP BY + HAVING + ORDER BY
-- ============================================================

SELECT
    city,
    COUNT(*) AS student_count
FROM students
GROUP BY city
HAVING COUNT(*) >= 2
ORDER BY student_count DESC;


-- ============================================================
-- 15. GROUP BY + LIMIT
-- ============================================================

-- Return the two cities with the most students.
SELECT
    city,
    COUNT(*) AS student_count
FROM students
GROUP BY city
ORDER BY student_count DESC
LIMIT 2;


-- ============================================================
-- 16. PRACTICAL REPORT
-- ============================================================

-- Generate a city-level student report.
SELECT
    city,
    COUNT(*) AS total_students,
    ROUND(AVG(age), 2) AS average_age,
    MIN(age) AS youngest_age,
    MAX(age) AS oldest_age
FROM students
GROUP BY city
ORDER BY total_students DESC, city ASC;


-- ============================================================
-- 17. NULL BEHAVIOR
-- ============================================================

-- COUNT(*) counts every row.
SELECT COUNT(*) AS total_rows
FROM students;


-- COUNT(age) counts only non-NULL age values.
SELECT COUNT(age) AS rows_with_age
FROM students;


-- AVG(age) ignores NULL ages.
SELECT AVG(age) AS average_age
FROM students;


-- ============================================================
-- 18. COMMON MISTAKE
-- ============================================================

-- Incorrect:
-- SELECT city, COUNT(*)
-- FROM students
-- WHERE COUNT(*) > 1
-- GROUP BY city;


-- Correct:
SELECT
    city,
    COUNT(*) AS student_count
FROM students
GROUP BY city
HAVING COUNT(*) > 1;


-- ============================================================
-- END OF EXAMPLES
-- ============================================================
```
