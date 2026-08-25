-- ============================================================
-- MODULE 07: ADVANCED JOINs
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
    e.enrollment_id,
    s.first_name,
    s.last_name
FROM students AS s
RIGHT JOIN enrollments AS e
    ON s.student_id = e.student_id;


-- Exercise 2
SELECT
    e.enrollment_id,
    s.first_name,
    s.last_name
FROM enrollments AS e
LEFT JOIN students AS s
    ON e.student_id = s.student_id;


-- Exercise 3
SELECT
    c.course_id,
    c.course_name,
    e.enrollment_id
FROM enrollments AS e
RIGHT JOIN courses AS c
    ON e.course_id = c.course_id;


-- Exercise 4
SELECT
    c.course_id,
    c.course_name
FROM enrollments AS e
RIGHT JOIN courses AS c
    ON e.course_id = c.course_id
WHERE e.enrollment_id IS NULL;


-- Exercise 5
SELECT
    c.course_id,
    c.course_name
FROM courses AS c
LEFT JOIN enrollments AS e
    ON c.course_id = e.course_id
WHERE e.enrollment_id IS NULL;


-- Exercise 6
SELECT
    e.employee_name AS employee,
    m.employee_name AS manager
FROM employees AS e
LEFT JOIN employees AS m
    ON e.manager_id = m.employee_id;


-- Exercise 7
SELECT
    e.employee_name AS employee,
    m.employee_name AS manager
FROM employees AS e
INNER JOIN employees AS m
    ON e.manager_id = m.employee_id;


-- Exercise 8
SELECT
    e.employee_id,
    e.employee_name
FROM employees AS e
LEFT JOIN employees AS m
    ON e.manager_id = m.employee_id
WHERE e.manager_id IS NULL;


-- ============================================================
-- MEDIUM
-- ============================================================

-- Exercise 9
SELECT
    e.employee_name AS employee,
    e.department AS employee_department,
    m.employee_name AS manager,
    m.department AS manager_department
FROM employees AS e
LEFT JOIN employees AS m
    ON e.manager_id = m.employee_id;


-- Exercise 10
SELECT
    e.employee_name
FROM employees AS e
INNER JOIN employees AS m
    ON e.manager_id = m.employee_id
WHERE m.employee_name = 'Rahul Mehta';


-- Exercise 11
SELECT
    e.employee_name AS employee,
    m.employee_name AS manager,
    gm.employee_name AS manager_manager
FROM employees AS e
LEFT JOIN employees AS m
    ON e.manager_id = m.employee_id
LEFT JOIN employees AS gm
    ON m.manager_id = gm.employee_id;


-- Exercise 12
SELECT
    c.course_name,
    COUNT(DISTINCT e.student_id) AS student_count
FROM courses AS c
LEFT JOIN enrollments AS e
    ON c.course_id = e.course_id
GROUP BY
    c.course_id,
    c.course_name;


-- Exercise 13
SELECT
    c.course_name,
    COUNT(DISTINCT e.student_id) AS student_count
FROM courses AS c
LEFT JOIN enrollments AS e
    ON c.course_id = e.course_id
GROUP BY
    c.course_id,
    c.course_name
HAVING COUNT(DISTINCT e.student_id) > 1;


-- Exercise 14
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


-- Exercise 15
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
    s.last_name
HAVING COUNT(e.enrollment_id) = 1;


-- Exercise 16
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
    s.last_name
HAVING COUNT(e.enrollment_id) > 1;


-- Exercise 17
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
WHERE c.course_name = 'SQL Fundamentals';


-- Exercise 18
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
WHERE s.city = 'Mumbai';


-- ============================================================
-- HARD
-- ============================================================

-- Exercise 19
SELECT
    m.employee_name AS manager,
    e.employee_name AS employee
FROM employees AS e
LEFT JOIN employees AS m
    ON e.manager_id = m.employee_id
ORDER BY
    m.employee_name ASC,
    e.employee_name ASC;


-- Exercise 20
SELECT
    e1.employee_name AS employee_1,
    e2.employee_name AS employee_2,
    m.employee_name AS manager
FROM employees AS e1
INNER JOIN employees AS e2
    ON e1.manager_id = e2.manager_id
INNER JOIN employees AS m
    ON e1.manager_id = m.employee_id
WHERE e1.employee_id < e2.employee_id;


-- Exercise 21
SELECT
    m.employee_name AS manager,
    COUNT(e.employee_id) AS report_count
FROM employees AS m
LEFT JOIN employees AS e
    ON m.employee_id = e.manager_id
GROUP BY
    m.employee_id,
    m.employee_name
ORDER BY report_count DESC;


-- Exercise 22
SELECT
    m.employee_name AS manager,
    COUNT(e.employee_id) AS report_count
FROM employees AS m
INNER JOIN employees AS e
    ON m.employee_id = e.manager_id
GROUP BY
    m.employee_id,
    m.employee_name
HAVING COUNT(e.employee_id) >= 2;


-- Exercise 23
SELECT
    s.student_id,
    s.first_name,
    s.last_name
FROM students AS s
INNER JOIN enrollments AS e
    ON s.student_id = e.student_id
INNER JOIN courses AS c
    ON e.course_id = c.course_id
WHERE c.course_name IN (
    'SQL Fundamentals',
    'Python Basics'
)
GROUP BY
    s.student_id,
    s.first_name,
    s.last_name
HAVING COUNT(DISTINCT c.course_id) = 2;


-- Exercise 24
SELECT
    c.course_name,
    COUNT(DISTINCT s.student_id) AS student_count
FROM courses AS c
LEFT JOIN enrollments AS e
    ON c.course_id = e.course_id
LEFT JOIN students AS s
    ON e.student_id = s.student_id
    AND s.age >= 21
GROUP BY
    c.course_id,
    c.course_name;


-- Exercise 25
SELECT
    c.course_name,
    COUNT(e.enrollment_id) AS student_count,
    ROUND(AVG(s.age), 2) AS average_student_age
FROM courses AS c
LEFT JOIN enrollments AS e
    ON c.course_id = e.course_id
LEFT JOIN students AS s
    ON e.student_id = s.student_id
GROUP BY
    c.course_id,
    c.course_name
ORDER BY student_count DESC;


-- Exercise 26
SELECT
    m.employee_name AS manager_name,
    COUNT(e.employee_id) AS report_count
FROM employees AS m
INNER JOIN employees AS e
    ON m.employee_id = e.manager_id
GROUP BY
    m.employee_id,
    m.employee_name
ORDER BY report_count DESC
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
    e.employee_name,
    e.department,
    m.employee_name AS manager
FROM employees AS e
INNER JOIN employees AS m
    ON e.manager_id = m.employee_id
WHERE e.department = m.department;


-- ============================================================
-- END OF SOLUTIONS
-- ============================================================
