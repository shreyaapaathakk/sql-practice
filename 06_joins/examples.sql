# `examples.sql`

```sql
-- ============================================================
-- MODULE 06: JOINs
-- File: examples.sql
-- Database: school
-- MySQL 8.0+
-- ============================================================

USE school;


-- ============================================================
-- 1. CREATE COURSES TABLE
-- ============================================================

CREATE TABLE IF NOT EXISTS courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    instructor VARCHAR(100) NOT NULL
);


-- ============================================================
-- 2. CREATE ENROLLMENTS TABLE
-- ============================================================

CREATE TABLE IF NOT EXISTS enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enrollment_date DATE NOT NULL
);


-- ============================================================
-- 3. INSERT COURSE DATA
-- ============================================================

INSERT INTO courses (course_id, course_name, instructor)
VALUES
    (101, 'SQL Fundamentals', 'Anita Sharma'),
    (102, 'Python Basics', 'Rahul Mehta'),
    (103, 'Web Development', 'Priya Singh'),
    (104, 'Data Analytics', 'Aman Verma'),
    (105, 'Computer Networks', 'Neha Gupta');


-- ============================================================
-- 4. INSERT ENROLLMENT DATA
-- ============================================================

INSERT INTO enrollments (
    enrollment_id,
    student_id,
    course_id,
    enrollment_date
)
VALUES
    (1, 1, 101, '2026-01-10'),
    (2, 1, 102, '2026-01-12'),
    (3, 2, 101, '2026-01-11'),
    (4, 2, 103, '2026-01-15'),
    (5, 3, 104, '2026-01-13'),
    (6, 4, 101, '2026-01-14'),
    (7, 4, 104, '2026-01-16'),
    (8, 5, 102, '2026-01-17');


-- ============================================================
-- 5. VIEW THE TABLES
-- ============================================================

SELECT *
FROM students;

SELECT *
FROM courses;

SELECT *
FROM enrollments;


-- ============================================================
-- 6. BASIC INNER JOIN
-- ============================================================

SELECT
    students.first_name,
    students.last_name,
    enrollments.course_id
FROM students
INNER JOIN enrollments
    ON students.student_id = enrollments.student_id;


-- ============================================================
-- 7. INNER JOIN WITH ALIASES
-- ============================================================

SELECT
    s.first_name,
    s.last_name,
    e.course_id
FROM students AS s
INNER JOIN enrollments AS e
    ON s.student_id = e.student_id;


-- ============================================================
-- 8. JOIN THREE TABLES
-- ============================================================

SELECT
    s.first_name,
    s.last_name,
    c.course_name
FROM students AS s
INNER JOIN enrollments AS e
    ON s.student_id = e.student_id
INNER JOIN courses AS c
    ON e.course_id = c.course_id;


-- ============================================================
-- 9. INCLUDE MORE COLUMNS
-- ============================================================

SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    c.course_id,
    c.course_name,
    c.instructor,
    e.enrollment_date
FROM students AS s
INNER JOIN enrollments AS e
    ON s.student_id = e.student_id
INNER JOIN courses AS c
    ON e.course_id = c.course_id;


-- ============================================================
-- 10. JOIN + WHERE
-- ============================================================

-- Find students enrolled in SQL Fundamentals.
SELECT
    s.first_name,
    s.last_name,
    c.course_name
FROM students AS s
INNER JOIN enrollments AS e
    ON s.student_id = e.student_id
INNER JOIN courses AS c
    ON e.course_id = c.course_id
WHERE c.course_name = 'SQL Fundamentals';


-- ============================================================
-- 11. JOIN + WHERE + ORDER BY
-- ============================================================

SELECT
    s.first_name,
    s.last_name,
    c.course_name
FROM students AS s
INNER JOIN enrollments AS e
    ON s.student_id = e.student_id
INNER JOIN courses AS c
    ON e.course_id = c.course_id
WHERE c.course_name = 'SQL Fundamentals'
ORDER BY s.last_name ASC, s.first_name ASC;


-- ============================================================
-- 12. FIND STUDENTS FROM A CITY AND THEIR COURSES
-- ============================================================

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
WHERE s.city = 'Delhi';


-- ============================================================
-- 13. INNER JOIN + GROUP BY
-- ============================================================

-- Count enrollments for each course.
SELECT
    c.course_name,
    COUNT(e.enrollment_id) AS enrollment_count
FROM courses AS c
INNER JOIN enrollments AS e
    ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name;


-- ============================================================
-- 14. GROUP BY + ORDER BY
-- ============================================================

SELECT
    c.course_name,
    COUNT(e.enrollment_id) AS enrollment_count
FROM courses AS c
INNER JOIN enrollments AS e
    ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name
ORDER BY enrollment_count DESC;


-- ============================================================
-- 15. GROUP BY + HAVING
-- ============================================================

-- Find courses with at least two enrollments.
SELECT
    c.course_name,
    COUNT(e.enrollment_id) AS enrollment_count
FROM courses AS c
INNER JOIN enrollments AS e
    ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name
HAVING COUNT(e.enrollment_id) >= 2;


-- ============================================================
-- 16. LEFT JOIN
-- ============================================================

SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    e.enrollment_id
FROM students AS s
LEFT JOIN enrollments AS e
    ON s.student_id = e.student_id;


-- ============================================================
-- 17. LEFT JOIN THREE TABLES
-- ============================================================

SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    c.course_name
FROM students AS s
LEFT JOIN enrollments AS e
    ON s.student_id = e.student_id
LEFT JOIN courses AS c
    ON e.course_id = c.course_id;


-- ============================================================
-- 18. FIND STUDENTS WITH NO ENROLLMENTS
-- ============================================================

SELECT
    s.student_id,
    s.first_name,
    s.last_name
FROM students AS s
LEFT JOIN enrollments AS e
    ON s.student_id = e.student_id
WHERE e.enrollment_id IS NULL;


-- ============================================================
-- 19. COUNT COURSES PER STUDENT
-- ============================================================

SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    COUNT(e.enrollment_id) AS course_count
FROM students AS s
LEFT JOIN enrollments AS e
    ON s.student_id = e.student_id
GROUP BY
    s.student_id,
    s.first_name,
    s.last_name
ORDER BY course_count DESC;


-- ============================================================
-- 20. STUDENTS WITH TWO OR MORE COURSES
-- ============================================================

SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    COUNT(e.enrollment_id) AS course_count
FROM students AS s
LEFT JOIN enrollments AS e
    ON s.student_id = e.student_id
GROUP BY
    s.student_id,
    s.first_name,
    s.last_name
HAVING COUNT(e.enrollment_id) >= 2;


-- ============================================================
-- 21. COURSE + STUDENT COUNT USING LEFT JOIN
-- ============================================================

-- LEFT JOIN ensures courses with zero enrollments
-- would also be included.
SELECT
    c.course_id,
    c.course_name,
    COUNT(e.enrollment_id) AS student_count
FROM courses AS c
LEFT JOIN enrollments AS e
    ON c.course_id = e.course_id
GROUP BY
    c.course_id,
    c.course_name
ORDER BY student_count DESC;


-- ============================================================
-- 22. FIND COURSES WITH NO STUDENTS
-- ============================================================

SELECT
    c.course_id,
    c.course_name
FROM courses AS c
LEFT JOIN enrollments AS e
    ON c.course_id = e.course_id
WHERE e.enrollment_id IS NULL;


-- ============================================================
-- 23. DISTINCT STUDENTS WHO HAVE ENROLLMENTS
-- ============================================================

SELECT DISTINCT
    s.student_id,
    s.first_name,
    s.last_name
FROM students AS s
INNER JOIN enrollments AS e
    ON s.student_id = e.student_id;


-- ============================================================
-- 24. STUDENT + COURSE + ENROLLMENT DATE
-- ============================================================

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


-- ============================================================
-- 25. FILTER BY AGE
-- ============================================================

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
WHERE s.age >= 20
ORDER BY s.age DESC;


-- ============================================================
-- 26. COURSES WITH AT LEAST TWO STUDENTS
-- ============================================================

SELECT
    c.course_name,
    COUNT(DISTINCT e.student_id) AS student_count
FROM courses AS c
INNER JOIN enrollments AS e
    ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name
HAVING COUNT(DISTINCT e.student_id) >= 2
ORDER BY student_count DESC;


-- ============================================================
-- END OF EXAMPLES
-- ============================================================
```
