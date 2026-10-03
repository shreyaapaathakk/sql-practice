-- ============================================================
-- Student Database Management System
-- File: queries.sql
-- SQL Dialect: MySQL 8.0+
-- ============================================================

USE student_database;

-- ============================================================
-- SECTION 1: BASIC DATA RETRIEVAL
-- ============================================================

-- 1. Display all students.
SELECT *
FROM students;


-- 2. Display only student names and email addresses.
SELECT
    first_name,
    last_name,
    email
FROM students;


-- 3. Display students ordered alphabetically by last name.
SELECT
    student_id,
    first_name,
    last_name,
    email
FROM students
ORDER BY last_name, first_name;


-- 4. Display all departments.
SELECT *
FROM departments;


-- 5. Display all courses.
SELECT
    course_id,
    course_code,
    course_name,
    credits
FROM courses;


-- ============================================================
-- SECTION 2: FILTERING
-- ============================================================

-- 6. Find students belonging to Computer Science.
SELECT
    student_id,
    first_name,
    last_name
FROM students
WHERE department_id = 1;


-- 7. Find students enrolled in 2022.
SELECT
    student_id,
    first_name,
    last_name,
    enrollment_date
FROM students
WHERE YEAR(enrollment_date) = 2022;


-- 8. Find students born after January 1, 2004.
SELECT
    student_id,
    first_name,
    last_name,
    date_of_birth
FROM students
WHERE date_of_birth > '2004-01-01';


-- 9. Find courses worth four credits.
SELECT
    course_code,
    course_name,
    credits
FROM courses
WHERE credits = 4;


-- 10. Find students whose first name starts with A.
SELECT
    student_id,
    first_name,
    last_name
FROM students
WHERE first_name LIKE 'A%';


-- ============================================================
-- SECTION 3: SORTING AND LIMIT
-- ============================================================

-- 11. Find the five most recently enrolled students.
SELECT
    student_id,
    first_name,
    last_name,
    enrollment_date
FROM students
ORDER BY enrollment_date DESC
LIMIT 5;


-- 12. Find the three courses with the highest credit value.
SELECT
    course_code,
    course_name,
    credits
FROM courses
ORDER BY credits DESC, course_name
LIMIT 3;


-- ============================================================
-- SECTION 4: JOINS
-- ============================================================

-- 13. Display students with their department names.
SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    d.department_name
FROM students AS s
INNER JOIN departments AS d
    ON s.department_id = d.department_id
ORDER BY s.student_id;


-- 14. Display courses with their departments.
SELECT
    c.course_code,
    c.course_name,
    c.credits,
    d.department_name
FROM courses AS c
INNER JOIN departments AS d
    ON c.department_id = d.department_id;


-- 15. Display courses with their instructors.
SELECT
    c.course_code,
    c.course_name,
    CONCAT(i.first_name, ' ', i.last_name) AS instructor_name
FROM courses AS c
LEFT JOIN instructors AS i
    ON c.instructor_id = i.instructor_id;


-- 16. Display instructors with their departments.
SELECT
    i.instructor_id,
    CONCAT(i.first_name, ' ', i.last_name) AS instructor_name,
    d.department_name
FROM instructors AS i
INNER JOIN departments AS d
    ON i.department_id = d.department_id;


-- ============================================================
-- SECTION 5: ENROLLMENT INFORMATION
-- ============================================================

-- 17. Display students and the courses they are enrolled in.
SELECT
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    c.course_code,
    c.course_name,
    e.semester,
    e.academic_year
FROM enrollments AS e
INNER JOIN students AS s
    ON e.student_id = s.student_id
INNER JOIN courses AS c
    ON e.course_id = c.course_id
ORDER BY s.student_id, c.course_code;


-- 18. Find all courses taken by Aarav Sharma.
SELECT
    c.course_code,
    c.course_name,
    e.semester,
    e.academic_year
FROM enrollments AS e
INNER JOIN students AS s
    ON e.student_id = s.student_id
INNER JOIN courses AS c
    ON e.course_id = c.course_id
WHERE s.first_name = 'Aarav'
  AND s.last_name = 'Sharma';


-- 19. Find students enrolled in Database Management Systems.
SELECT
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name
FROM enrollments AS e
INNER JOIN students AS s
    ON e.student_id = s.student_id
INNER JOIN courses AS c
    ON e.course_id = c.course_id
WHERE c.course_code = 'CS201';


-- ============================================================
-- SECTION 6: RESULTS
-- ============================================================

-- 20. Display all exam results with student and course information.
SELECT
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    c.course_code,
    c.course_name,
    ex.exam_name,
    r.marks_obtained,
    r.grade
FROM results AS r
INNER JOIN students AS s
    ON r.student_id = s.student_id
INNER JOIN exams AS ex
    ON r.exam_id = ex.exam_id
INNER JOIN courses AS c
    ON ex.course_id = c.course_id
ORDER BY s.student_id, ex.exam_date;


-- 21. Find students who scored at least 90.
SELECT
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    c.course_name,
    r.marks_obtained,
    r.grade
FROM results AS r
INNER JOIN students AS s
    ON r.student_id = s.student_id
INNER JOIN exams AS ex
    ON r.exam_id = ex.exam_id
INNER JOIN courses AS c
    ON ex.course_id = c.course_id
WHERE r.marks_obtained >= 90
ORDER BY r.marks_obtained DESC;


-- 22. Find students who scored below 60.
SELECT
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    c.course_name,
    r.marks_obtained,
    r.grade
FROM results AS r
INNER JOIN students AS s
    ON r.student_id = s.student_id
INNER JOIN exams AS ex
    ON r.exam_id = ex.exam_id
INNER JOIN courses AS c
    ON ex.course_id = c.course_id
WHERE r.marks_obtained < 60;


-- ============================================================
-- SECTION 7: AGGREGATION
-- ============================================================

-- 23. Count the total number of students.
SELECT COUNT(*) AS total_students
FROM students;


-- 24. Count students in each department.
SELECT
    d.department_name,
    COUNT(s.student_id) AS student_count
FROM departments AS d
LEFT JOIN students AS s
    ON d.department_id = s.department_id
GROUP BY
    d.department_id,
    d.department_name
ORDER BY student_count DESC;


-- 25. Count courses in each department.
SELECT
    d.department_name,
    COUNT(c.course_id) AS course_count
FROM departments AS d
LEFT JOIN courses AS c
    ON d.department_id = c.department_id
GROUP BY
    d.department_id,
    d.department_name
ORDER BY course_count DESC;


-- 26. Calculate the average marks across all exams.
SELECT
    ROUND(AVG(marks_obtained), 2) AS average_marks
FROM results;


-- 27. Find the highest and lowest marks.
SELECT
    MAX(marks_obtained) AS highest_marks,
    MIN(marks_obtained) AS lowest_marks
FROM results;


-- 28. Count results by grade.
SELECT
    grade,
    COUNT(*) AS number_of_students
FROM results
GROUP BY grade
ORDER BY number_of_students DESC;


-- ============================================================
-- SECTION 8: GROUP BY AND HAVING
-- ============================================================

-- 29. Find departments containing more than two students.
SELECT
    d.department_name,
    COUNT(s.student_id) AS student_count
FROM departments AS d
INNER JOIN students AS s
    ON d.department_id = s.department_id
GROUP BY
    d.department_id,
    d.department_name
HAVING COUNT(s.student_id) > 2;


-- 30. Find courses with an average score above 80.
SELECT
    c.course_code,
    c.course_name,
    ROUND(AVG(r.marks_obtained), 2) AS average_marks
FROM results AS r
INNER JOIN exams AS ex
    ON r.exam_id = ex.exam_id
INNER JOIN courses AS c
    ON ex.course_id = c.course_id
GROUP BY
    c.course_id,
    c.course_code,
    c.course_name
HAVING AVG(r.marks_obtained) > 80
ORDER BY average_marks DESC;
