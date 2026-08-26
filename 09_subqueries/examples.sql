-- ============================================================
-- MODULE 09: SUBQUERIES
-- File: examples.sql
-- ============================================================

USE school;

-- 1. Oldest student
SELECT *
FROM students
WHERE age = (
    SELECT MAX(age)
    FROM students
);

-- 2. Youngest student
SELECT *
FROM students
WHERE age = (
    SELECT MIN(age)
    FROM students
);

-- 3. Students older than average age
SELECT *
FROM students
WHERE age > (
    SELECT AVG(age)
    FROM students
);

-- 4. Students from cities that contain age 21+
SELECT *
FROM students
WHERE city IN (
    SELECT city
    FROM students
    WHERE age >= 21
);

-- 5. Students from cities not containing age 21+
SELECT *
FROM students
WHERE city NOT IN (
    SELECT city
    FROM students
    WHERE age >= 21
);

-- 6. Subquery in SELECT
SELECT
    first_name,
    age,
    (
        SELECT AVG(age)
        FROM students
    ) AS average_age
FROM students;

-- 7. Subquery in FROM
SELECT *
FROM (
    SELECT
        student_id,
        first_name,
        city
    FROM students
) AS student_data;

-- 8. EXISTS
SELECT *
FROM students s
WHERE EXISTS (
    SELECT 1
    FROM enrollments e
    WHERE e.student_id = s.student_id
);

-- 9. NOT EXISTS
SELECT *
FROM students s
WHERE NOT EXISTS (
    SELECT 1
    FROM enrollments e
    WHERE e.student_id = s.student_id
);

-- 10. Correlated subquery
SELECT *
FROM students s
WHERE age > (
    SELECT AVG(age)
    FROM students
    WHERE city = s.city
);
