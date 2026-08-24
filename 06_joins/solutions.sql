# `solutions.sql`

```sql
-- ============================================================
-- MODULE 06: JOINs
-- File: solutions.sql
-- Database: school
-- MySQL 8.0+
-- ============================================================

USE school;


-- ============================================================
-- EASY
-- ============================================================

-- Exercise 1
SELECT
    s.first_name,
    e.enrollment_id
FROM students AS s
INNER JOIN enrollments AS e
    ON s.student_id = e.student_id;


-- Exercise 2
SELECT
    s.first_name,
    s.last_name,
    e.course_id
FROM students AS s
INNER JOIN enrollments AS e
    ON s.student_id = e.student_id;


-- Exercise 3
SELECT
    s.first_name,
    s.last_name,
    c.course_name
FROM students AS s
INNER JOIN enrollments AS e
    ON s.student_id = e.student_id
INNER JOIN courses AS c
    ON e.course_id = c.course_id;


-- Exercise 4
SELECT
    s.first_name,
    s.last_name,
    c.instructor
FROM students AS s
INNER JOIN enrollments AS e
    ON s.student_id = e.student_id
INNER JOIN courses AS c
    ON e.course_id = c.course_id;


-- Exercise 5
SELECT
    s.first_name,
    s.last_name
FROM students AS s
INNER JOIN enrollments AS e
    ON s.student_id = e.student_id
INNER JOIN courses AS c
    ON e.course_id = c.course_id
WHERE c.course_name = 'SQL Fundamentals';


-- Exercise 6
SELECT
    s.first_name,
    s.last_name
FROM students AS s
INNER JOIN enrollments AS e
    ON s.student_id = e.student_id
INNER JOIN courses AS c
    ON e.course_id = c.course_id
WHERE c.course_name = 'Python Basics';


-- Exercise 7
SELECT
    s.first_name,
    s.last_name,
    c.course_name,
    e.enrollment_date
FROM students AS s
INNER JOIN enrollments AS e
    ON s.student_id = e.student_id
INNER JOIN courses AS c
    ON e.course_id = c.course_id
ORDER BY e.enrollment_date ASC;


-- Exercise 8
SELECT
    s.first_name,
    s.last_name,
    c.course_name
FROM students AS s
INNER JOIN enrollments AS e
    ON s.student_id = e.student_id
INNER JOIN courses AS c
    ON e.course_id = c.course_id
WHERE s.city = 'Delhi';


-- ============================================================
-- MEDIUM
-- ============================================================

-- Exercise 9
SELECT
    c.course_name,
    COUNT(e.enrollment_id) AS enrollment_count
FROM courses AS c
LEFT JOIN enrollments AS e
    ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name
ORDER BY enrollment_count DESC;


-- Exercise 10
SELECT
    c.course_name,
    COUNT(e.enrollment_id) AS enrollment_count
FROM courses AS c
INNER JOIN enrollments AS e
    ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name
HAVING COUNT(e.enrollment_id) >= 2;


-- Exercise 11
SELECT
    s.first_name,
    s.last_name,
    COUNT(e.enrollment_id) AS course_count
FROM students AS s
LEFT JOIN enrollments AS e
    ON s.student_id = e.student_id
GROUP BY
    s.student_id,
    s.first_name,
    s.last_name;


-- Exercise 12
SELECT
    s.first_name,
    s.last_name,
    COUNT(e.enrollment_id) AS course_count
FROM students AS s
INNER JOIN enrollments AS e
    ON s.student_id = e.student_id
GROUP BY
    s.student_id,
    s.first_name,
    s.last_name
HAVING COUNT(e.enrollment_id) >= 2;


-- Exercise 13
SELECT
    s.first_name,
    s.last_name,
    c.course_name,
    e.enrollment_date
FROM students AS s
INNER JOIN enrollments AS e
    ON s.student_id = e.student_id
INNER JOIN courses AS c
    ON e.course_id = c.course_id
ORDER BY
    s.last_name ASC,
    c.course_name ASC;


-- Exercise 14
SELECT
    s.first_name,
    s.last_name,
    s.age,
    c.course_name
FROM students AS s
INNER JOIN enrollments AS e
    ON s.student_id = e.student_id
INNER JOIN courses AS c
    ON e.course_id = c.course_id
WHERE s.age >= 20;


-- Exercise 15
SELECT
    s.first_name,
    s.last_name,
    c.course_name,
    c.instructor
FROM students AS s
INNER JOIN enrollments AS e
    ON s.student_id = e.student_id
INNER JOIN courses AS c
    ON e.course_id = c.course_id
WHERE c.instructor = 'Anita Sharma';


-- Exercise 16
SELECT
    c.course_name,
    COUNT(DISTINCT e.student_id) AS student_count
FROM courses AS c
LEFT JOIN enrollments AS e
    ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name;


-- Exercise 17
SELECT DISTINCT
    s.student_id,
    s.first_name,
    s.last_name
FROM students AS s
INNER JOIN enrollments AS e
    ON s.student_id = e.student_id;


-- Exercise 18
SELECT
    c.course_id,
    c.course_name
FROM courses AS c
LEFT JOIN enrollments AS e
    ON c.course_id = e.course_id
WHERE e.enrollment_id IS NULL;


-- ============================================================
-- HARD
-- ============================================================

-- Exercise 19
SELECT
    s.student_id,
    s.first_name,
    s.last_name
FROM students AS s
LEFT JOIN enrollments AS e
    ON s.student_id = e.student_id
WHERE e.enrollment_id IS NULL;


-- Exercise 20
SELECT
    s.first_name,
    s.last_name,
    s.city,
    COUNT(e.enrollment_id) AS course_count
FROM students AS s
LEFT JOIN enrollments AS e
    ON s.student_id = e.student_id
GROUP BY
    s.student_id,
    s.first_name,
    s.last_name,
    s.city
ORDER BY course_count DESC;


-- Exercise 21
SELECT
    c.course_name,
    COUNT(e.enrollment_id) AS student_count
FROM courses AS c
INNER JOIN enrollments AS e
    ON c.course_id = e.course_id
INNER JOIN students AS s
    ON e.student_id = s.student_id
WHERE s.age >= 20
GROUP BY c.course_id, c.course_name;


-- Exercise 22
SELECT
    c.course_name,
    COUNT(e.enrollment_id) AS student_count
FROM courses AS c
INNER JOIN enrollments AS e
    ON c.course_id = e.course_id
INNER JOIN students AS s
    ON e.student_id = s.student_id
WHERE s.age >= 20
GROUP BY c.course_id, c.course_name
HAVING COUNT(e.enrollment_id) >= 2;


-- Exercise 23
SELECT
    c.course_name,
    ROUND(AVG(s.age), 2) AS average_age
FROM courses AS c
INNER JOIN enrollments AS e
    ON c.course_id = e.course_id
INNER JOIN students AS s
    ON e.student_id = s.student_id
GROUP BY c.course_id, c.course_name;


-- Exercise 24
SELECT
    c.course_name,
    ROUND(AVG(s.age), 2) AS average_age
FROM courses AS c
INNER JOIN enrollments AS e
    ON c.course_id = e.course_id
INNER JOIN students AS s
    ON e.student_id = s.student_id
GROUP BY c.course_id, c.course_name
HAVING AVG(s.age) > 20;


-- Exercise 25
SELECT
    c.course_name,
    c.instructor,
    COUNT(e.enrollment_id) AS student_count,
    ROUND(AVG(s.age), 2) AS average_student_age
FROM courses AS c
LEFT JOIN enrollments AS e
    ON c.course_id = e.course_id
LEFT JOIN students AS s
    ON e.student_id = s.student_id
GROUP BY
    c.course_id,
    c.course_name,
    c.instructor
ORDER BY student_count DESC;


-- Exercise 26
SELECT
    c.course_name,
    COUNT(e.enrollment_id) AS student_count
FROM courses AS c
INNER JOIN enrollments AS e
    ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name
ORDER BY student_count DESC
LIMIT 1;


-- Exercise 27
SELECT
    s.first_name,
    s.last_name,
    COUNT(e.enrollment_id) AS course_count
FROM students AS s
INNER JOIN enrollments AS e
    ON s.student_id = e.student_id
GROUP BY
    s.student_id,
    s.first_name,
    s.last_name
ORDER BY course_count DESC
LIMIT 1;


-- Exercise 28
SELECT
    s.first_name,
    s.last_name,
    s.city,
    c.course_name
FROM students AS s
INNER JOIN enrollments AS e
    ON s.student_id = e.student_id
INNER JOIN courses AS c
    ON e.course_id = c.course_id
WHERE s.city IN ('Delhi', 'Mumbai');


-- ============================================================
-- END OF SOLUTIONS
-- ============================================================
```
