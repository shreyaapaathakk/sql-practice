-- ============================================================
-- MODULE 09: SUBQUERIES
-- File: solutions.sql
-- ============================================================

USE school;

-- Exercise 1
SELECT *
FROM students
WHERE age = (
    SELECT MAX(age)
    FROM students
);

-- Exercise 2
SELECT *
FROM students
WHERE age = (
    SELECT MIN(age)
    FROM students
);

-- Exercise 3
SELECT *
FROM students
WHERE age > (
    SELECT AVG(age)
    FROM students
);

-- Exercise 4
SELECT
    first_name,
    age,
    (
        SELECT AVG(age)
        FROM students
    ) AS average_age
FROM students;

-- Exercise 5
SELECT *
FROM students
WHERE city IN (
    SELECT city
    FROM students
    WHERE age >= 21
);

-- Exercise 6
SELECT *
FROM students
WHERE age = (
    SELECT ROUND(AVG(age))
    FROM students
);

-- Exercise 7
SELECT *
FROM students
WHERE city NOT IN (
    SELECT city
    FROM students
    WHERE age >= 21
);

-- Exercise 8
SELECT *
FROM (
    SELECT
        student_id,
        first_name,
        city
    FROM students
) AS student_data;

-- Exercise 9
SELECT
    first_name,
    age,
    (
        SELECT MAX(age)
        FROM students
    ) AS maximum_age
FROM students;

-- Exercise 10
SELECT *
FROM students
WHERE age > (
    SELECT MIN(age)
    FROM students
);

-- Exercise 11
SELECT *
FROM students s
WHERE EXISTS (
    SELECT 1
    FROM enrollments e
    WHERE e.student_id = s.student_id
);

-- Exercise 12
SELECT *
FROM students s
WHERE NOT EXISTS (
    SELECT 1
    FROM enrollments e
    WHERE e.student_id = s.student_id
);

-- Exercise 13
SELECT *
FROM students s
WHERE age > (
    SELECT AVG(age)
    FROM students
    WHERE city = s.city
);

-- Exercise 14
SELECT DISTINCT city
FROM students
WHERE city IN (
    SELECT city
    FROM students
    WHERE age > (
        SELECT AVG(age)
        FROM students
    )
);

-- Exercise 15
SELECT *
FROM students
WHERE student_id IN (
    SELECT student_id
    FROM enrollments
);
