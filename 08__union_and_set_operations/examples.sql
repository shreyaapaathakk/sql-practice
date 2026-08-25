
---

# `08_union_and_set_operations/examples.sql`

```sql
-- ============================================================
-- MODULE 08: UNION & SET OPERATIONS
-- File: examples.sql
-- Database: school
-- MySQL 8.0+
-- ============================================================

USE school;


-- ============================================================
-- 1. BASIC UNION
-- ============================================================

SELECT
    city
FROM students

UNION

SELECT
    city
FROM students;


-- ============================================================
-- 2. UNION REMOVES DUPLICATES
-- ============================================================

SELECT
    'Delhi' AS city

UNION

SELECT
    'Delhi' AS city;


-- ============================================================
-- 3. UNION ALL KEEPS DUPLICATES
-- ============================================================

SELECT
    'Delhi' AS city

UNION ALL

SELECT
    'Delhi' AS city;


-- ============================================================
-- 4. UNION WITH DIFFERENT FILTERS
-- ============================================================

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


-- ============================================================
-- 5. EQUIVALENT IN EXAMPLE
-- ============================================================

SELECT
    first_name,
    city
FROM students
WHERE city IN ('Delhi', 'Mumbai');


-- ============================================================
-- 6. UNION WITH ALIASES
-- ============================================================

SELECT
    first_name AS person_name,
    city
FROM students

UNION

SELECT
    first_name AS person_name,
    city
FROM students;


-- ============================================================
-- 7. FIRST SELECT DEFINES RESULT COLUMN NAMES
-- ============================================================

SELECT
    first_name AS person_name
FROM students

UNION

SELECT
    first_name
FROM students;


-- ============================================================
-- 8. UNION WITH CALCULATED COLUMN
-- ============================================================

SELECT
    first_name AS person_name,
    'Student' AS role
FROM students

UNION ALL

SELECT
    employee_name AS person_name,
    'Employee' AS role
FROM employees;


-- ============================================================
-- 9. UNION WITH NULL
-- ============================================================

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


-- ============================================================
-- 10. UNION ALL
-- ============================================================

SELECT
    first_name AS person_name
FROM students

UNION ALL

SELECT
    employee_name AS person_name
FROM employees;


-- ============================================================
-- 11. UNION WITH ORDER BY
-- ============================================================

SELECT
    first_name AS person_name
FROM students

UNION

SELECT
    employee_name AS person_name
FROM employees

ORDER BY person_name;


-- ============================================================
-- 12. UNION WITH ORDER BY AND LIMIT
-- ============================================================

SELECT
    first_name AS person_name
FROM students

UNION

SELECT
    employee_name AS person_name
FROM employees

ORDER BY person_name
LIMIT 5;


-- ============================================================
-- 13. UNION WITH JOIN
-- ============================================================

SELECT
    s.first_name AS person_name,
    c.course_name AS activity
FROM students AS s
INNER JOIN enrollments AS e
    ON s.student_id = e.student_id
INNER JOIN courses AS c
    ON e.course_id = c.course_id

UNION ALL

SELECT
    employee_name AS person_name,
    department AS activity
FROM employees;


-- ============================================================
-- 14. UNION OF CITIES
-- ============================================================

SELECT
    city
FROM students

UNION

SELECT
    department
FROM employees;


-- ============================================================
-- 15. UNION WITH CONSTANT VALUES
-- ============================================================

SELECT
    first_name AS person_name,
    'Student' AS category
FROM students

UNION ALL

SELECT
    'School Administrator' AS person_name,
    'Staff' AS category;


-- ============================================================
-- 16. UNION ALL WITH MULTIPLE CATEGORIES
-- ============================================================

SELECT
    first_name AS person_name,
    'Student' AS category
FROM students

UNION ALL

SELECT
    employee_name AS person_name,
    'Employee' AS category
FROM employees

UNION ALL

SELECT
    'School Administrator' AS person_name,
    'Staff' AS category;


-- ============================================================
-- 17. UNION WITH DISTINCT
-- ============================================================

SELECT DISTINCT
    city
FROM students

UNION

SELECT DISTINCT
    city
FROM students;


-- ============================================================
-- 18. UNION ALL SHOWING ALL STUDENT CITIES
-- ============================================================

SELECT
    city
FROM students

UNION ALL

SELECT
    city
FROM students;


-- ============================================================
-- 19. UNION WITH AGE GROUPS
-- ============================================================

SELECT
    first_name AS person_name,
    'Adult Student' AS category
FROM students
WHERE age >= 21

UNION ALL

SELECT
    first_name AS person_name,
    'Young Student' AS category
FROM students
WHERE age < 21;


-- ============================================================
-- 20. PARENTHESIZED UNION
-- ============================================================

(
    SELECT
        first_name AS person_name
    FROM students
    ORDER BY first_name
    LIMIT 2
)

UNION ALL

(
    SELECT
        employee_name AS person_name
    FROM employees
    ORDER BY employee_name
    LIMIT 2
);


-- ============================================================
-- END OF EXAMPLES
-- ============================================================
