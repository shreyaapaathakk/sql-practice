-- ============================================================
-- MODULE 08: UNION & SET OPERATIONS
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
    city
FROM students

UNION

SELECT
    city
FROM students;


-- Exercise 2
SELECT
    city
FROM students

UNION ALL

SELECT
    city
FROM students;


-- Exercise 3
SELECT
    first_name,
    city
FROM students
WHERE city = 'Delhi'

UNION

SELECT
    first_name,
    city
FROM students
WHERE city = 'Mumbai';


-- Exercise 4
SELECT
    first_name,
    city
FROM students
WHERE city IN ('Delhi', 'Mumbai');


-- Exercise 5
SELECT
    first_name AS person_name,
    'Student' AS role
FROM students;


-- Exercise 6
SELECT
    first_name AS person_name,
    'Student' AS role
FROM students

UNION ALL

SELECT
    employee_name AS person_name,
    'Employee' AS role
FROM employees;


-- Exercise 7
SELECT
    first_name AS person_name
FROM students

UNION ALL

SELECT
    employee_name AS person_name
FROM employees;


-- Exercise 8
SELECT
    first_name AS person_name
FROM students

UNION

SELECT
    employee_name AS person_name
FROM employees;


-- ============================================================
-- MEDIUM
-- ============================================================

-- Exercise 9
SELECT
    first_name AS person_name,
    'Student' AS category
FROM students

UNION ALL

SELECT
    employee_name AS person_name,
    'Employee' AS category
FROM employees

ORDER BY person_name;


-- Exercise 10
SELECT
    city AS location_or_department
FROM students

UNION

SELECT
    department AS location_or_department
FROM employees;


-- Exercise 11
SELECT
    student_id AS person_id,
    first_name AS person_name,
    city
FROM students

UNION ALL

SELECT
    employee_id AS person_id,
    employee_name AS person_name,
    NULL AS city
FROM employees;


-- Exercise 12
SELECT
    first_name,
    age,
    '21_or_older' AS age_group
FROM students
WHERE age >= 21

UNION ALL

SELECT
    first_name,
    age,
    'under_21' AS age_group
FROM students
WHERE age < 21;


-- Exercise 13
SELECT
    first_name,
    city
FROM students
WHERE city = 'Delhi'

UNION

SELECT
    first_name,
    city
FROM students
WHERE city = 'Mumbai';


-- Exercise 14
SELECT
    first_name AS person_name,
    'Student' AS category
FROM students

UNION ALL

SELECT
    employee_name AS person_name,
    'Employee' AS category
FROM employees;


-- Exercise 15
(
    SELECT
        first_name AS person_name
    FROM students
    ORDER BY first_name
    LIMIT 3
)

UNION ALL

(
    SELECT
        employee_name AS person_name
    FROM employees
    ORDER BY employee_name
    LIMIT 3
);


-- Exercise 16
SELECT 'SQL' AS technology

UNION

SELECT 'Python'

UNION

SELECT 'Java'

UNION

SELECT 'SQL';


-- ============================================================
-- HARD
-- ============================================================

-- Exercise 17
SELECT
    CONCAT(s.first_name, ' ', s.last_name) AS person_name,
    c.course_name AS activity,
    'Student Course' AS category
FROM students AS s
INNER JOIN enrollments AS e
    ON s.student_id = e.student_id
INNER JOIN courses AS c
    ON e.course_id = c.course_id

UNION ALL

SELECT
    employee_name AS person_name,
    department AS activity,
    'Employee Department' AS category
FROM employees;


-- Exercise 18
SELECT
    first_name AS person_name,
    'Student - Delhi' AS source
FROM students
WHERE city = 'Delhi'

UNION ALL

SELECT
    first_name AS person_name,
    'Student - Mumbai' AS source
FROM students
WHERE city = 'Mumbai'

UNION ALL

SELECT
    employee_name AS person_name,
    'Employee - Technology' AS source
FROM employees
WHERE department = 'Technology';


-- Exercise 19
SELECT
    first_name AS person_name,
    city AS location,
    'Student' AS category
FROM students

UNION ALL

SELECT
    employee_name AS person_name,
    department AS location,
    'Employee' AS category
FROM employees

ORDER BY person_name;


-- Exercise 20
SELECT
    s.first_name AS person_name
FROM students AS s
INNER JOIN employees AS e
    ON s.first_name = e.employee_name;


-- ============================================================
-- NOTE:
-- Exercise 20 assumes exact matching between student first_name
-- and employee_name. If the employee table contains full names,
-- a more appropriate comparison would require matching the
-- corresponding name fields.
-- ============================================================


-- Exercise 21
SELECT
    first_name AS person_name,
    'Student' AS category
FROM students

UNION ALL

SELECT
    employee_name AS person_name,
    'Employee' AS category
FROM employees;


-- Exercise 22
SELECT
    first_name AS person_name,
    'Student' AS category
FROM students

UNION

SELECT
    employee_name AS person_name,
    'Employee' AS category
FROM employees;


-- Exercise 23
SELECT
    first_name AS person_name,
    city AS information
FROM students

UNION ALL

SELECT
    employee_name AS person_name,
    department AS information
FROM employees;


-- Exercise 24
SELECT
    first_name AS person_name,
    'Student' AS category
FROM students

UNION ALL

SELECT
    employee_name AS person_name,
    'Employee' AS category
FROM employees

ORDER BY person_name
LIMIT 5;


-- ============================================================
-- END OF SOLUTIONS
-- ============================================================
