
## `07_advanced_joins/examples.sql`

```sql
-- ============================================================
-- MODULE 07: ADVANCED JOINs
-- File: examples.sql
-- Database: school
-- MySQL 8.0+
-- ============================================================

USE school;


-- ============================================================
-- 1. RIGHT JOIN
-- ============================================================

SELECT
    s.first_name,
    s.last_name,
    e.enrollment_id
FROM students AS s
RIGHT JOIN enrollments AS e
    ON s.student_id = e.student_id;


-- ============================================================
-- 2. RIGHT JOIN REWRITTEN AS LEFT JOIN
-- ============================================================

SELECT
    s.first_name,
    s.last_name,
    e.enrollment_id
FROM enrollments AS e
LEFT JOIN students AS s
    ON e.student_id = s.student_id;


-- ============================================================
-- 3. RIGHT JOIN WITH COURSES
-- ============================================================

SELECT
    e.enrollment_id,
    c.course_name
FROM enrollments AS e
RIGHT JOIN courses AS c
    ON e.course_id = c.course_id;


-- ============================================================
-- 4. FIND COURSES WITHOUT ENROLLMENTS USING RIGHT JOIN
-- ============================================================

SELECT
    c.course_id,
    c.course_name
FROM enrollments AS e
RIGHT JOIN courses AS c
    ON e.course_id = c.course_id
WHERE e.enrollment_id IS NULL;


-- ============================================================
-- 5. EQUIVALENT LEFT JOIN
-- ============================================================

SELECT
    c.course_id,
    c.course_name
FROM courses AS c
LEFT JOIN enrollments AS e
    ON c.course_id = e.course_id
WHERE e.enrollment_id IS NULL;


-- ============================================================
-- 6. CREATE EMPLOYEES TABLE FOR SELF JOIN
-- ============================================================

CREATE TABLE IF NOT EXISTS employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    department VARCHAR(100) NOT NULL,
    manager_id INT NULL
);


-- ============================================================
-- 7. INSERT EMPLOYEE DATA
-- ============================================================

INSERT INTO employees (
    employee_id,
    employee_name,
    department,
    manager_id
)
VALUES
    (1, 'Anita Sharma', 'Management', NULL),
    (2, 'Rahul Mehta', 'Technology', 1),
    (3, 'Priya Singh', 'Marketing', 1),
    (4, 'Aman Verma', 'Technology', 2),
    (5, 'Neha Gupta', 'Technology', 2),
    (6, 'Arjun Mehta', 'Marketing', 3);


-- ============================================================
-- 8. VIEW EMPLOYEES
-- ============================================================

SELECT *
FROM employees;


-- ============================================================
-- 9. BASIC SELF JOIN
-- ============================================================

SELECT
    e.employee_name AS employee,
    m.employee_name AS manager
FROM employees AS e
LEFT JOIN employees AS m
    ON e.manager_id = m.employee_id;


-- ============================================================
-- 10. SELF JOIN WITH DEPARTMENT
-- ============================================================

SELECT
    e.employee_name AS employee,
    e.department,
    m.employee_name AS manager
FROM employees AS e
LEFT JOIN employees AS m
    ON e.manager_id = m.employee_id
ORDER BY e.employee_name;


-- ============================================================
-- 11. EMPLOYEES WHO HAVE A MANAGER
-- ============================================================

SELECT
    e.employee_name AS employee,
    m.employee_name AS manager
FROM employees AS e
INNER JOIN employees AS m
    ON e.manager_id = m.employee_id;


-- ============================================================
-- 12. EMPLOYEES WITHOUT A MANAGER
-- ============================================================

SELECT
    e.employee_id,
    e.employee_name
FROM employees AS e
LEFT JOIN employees AS m
    ON e.manager_id = m.employee_id
WHERE e.manager_id IS NULL;


-- ============================================================
-- 13. MULTI-LEVEL SELF JOIN
-- ============================================================

SELECT
    e.employee_name AS employee,
    m.employee_name AS manager,
    gm.employee_name AS general_manager
FROM employees AS e
LEFT JOIN employees AS m
    ON e.manager_id = m.employee_id
LEFT JOIN employees AS gm
    ON m.manager_id = gm.employee_id;


-- ============================================================
-- 14. FIND EMPLOYEES REPORTING TO RAHUL
-- ============================================================

SELECT
    e.employee_name
FROM employees AS e
INNER JOIN employees AS m
    ON e.manager_id = m.employee_id
WHERE m.employee_name = 'Rahul Mehta';


-- ============================================================
-- 15. EMPLOYEE + MANAGER DEPARTMENT
-- ============================================================

SELECT
    e.employee_name AS employee,
    e.department AS employee_department,
    m.employee_name AS manager,
    m.department AS manager_department
FROM employees AS e
LEFT JOIN employees AS m
    ON e.manager_id = m.employee_id;


-- ============================================================
-- 16. STUDENT → ENROLLMENT → COURSE
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
    ON e.course_id = c.course_id;


-- ============================================================
-- 17. LEFT JOIN WITH CONDITION IN ON
-- ============================================================

SELECT
    s.first_name,
    s.last_name,
    e.course_id
FROM students AS s
LEFT JOIN enrollments AS e
    ON s.student_id = e.student_id
    AND e.course_id = 101;


-- ============================================================
-- 18. LEFT JOIN WITH CONDITION IN WHERE
-- ============================================================

SELECT
    s.first_name,
    s.last_name,
    e.course_id
FROM students AS s
LEFT JOIN enrollments AS e
    ON s.student_id = e.student_id
WHERE e.course_id = 101;


-- ============================================================
-- 19. COUNT DISTINCT STUDENTS PER COURSE
-- ============================================================

SELECT
    c.course_name,
    COUNT(DISTINCT e.student_id) AS student_count
FROM courses AS c
LEFT JOIN enrollments AS e
    ON c.course_id = e.course_id
GROUP BY
    c.course_id,
    c.course_name;


-- ============================================================
-- 20. COURSES WITH MORE THAN ONE STUDENT
-- ============================================================

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


-- ============================================================
-- 21. STUDENTS WITH THEIR COURSE COUNTS
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
-- 22. STUDENTS WITH MORE THAN ONE COURSE
-- ============================================================

SELECT
    s.student_id,
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
HAVING COUNT(e.enrollment_id) > 1;


-- ============================================================
-- 23. EMPLOYEES WITH THE SAME MANAGER
-- ============================================================

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


-- ============================================================
-- 24. STUDENTS FROM DELHI WITH THEIR COURSES
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
-- 25. COURSES WITH NO STUDENTS
-- ============================================================

SELECT
    c.course_id,
    c.course_name
FROM courses AS c
LEFT JOIN enrollments AS e
    ON c.course_id = e.course_id
WHERE e.enrollment_id IS NULL;


-- ============================================================
-- END OF EXAMPLES
-- ============================================================
