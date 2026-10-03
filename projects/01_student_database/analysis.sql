-- ============================================================
-- Student Database Management System
-- File: analysis.sql
-- SQL Dialect: MySQL 8.0+
-- ============================================================

USE student_database;

-- ============================================================
-- 1. STUDENT PERFORMANCE ANALYSIS
-- ============================================================

-- Calculate the average marks for every student.

SELECT
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    ROUND(AVG(r.marks_obtained), 2) AS average_marks
FROM students AS s
INNER JOIN results AS r
    ON s.student_id = r.student_id
GROUP BY
    s.student_id,
    s.first_name,
    s.last_name
ORDER BY average_marks DESC;


-- ============================================================
-- 2. TOP-PERFORMING STUDENTS
-- ============================================================

SELECT
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    ROUND(AVG(r.marks_obtained), 2) AS average_marks
FROM students AS s
INNER JOIN results AS r
    ON s.student_id = r.student_id
GROUP BY
    s.student_id,
    s.first_name,
    s.last_name
ORDER BY average_marks DESC
LIMIT 5;


-- ============================================================
-- 3. STUDENTS WITH AVERAGE ABOVE 85
-- ============================================================

SELECT
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    ROUND(AVG(r.marks_obtained), 2) AS average_marks
FROM students AS s
INNER JOIN results AS r
    ON s.student_id = r.student_id
GROUP BY
    s.student_id,
    s.first_name,
    s.last_name
HAVING AVG(r.marks_obtained) > 85
ORDER BY average_marks DESC;


-- ============================================================
-- 4. DEPARTMENT-WISE ACADEMIC PERFORMANCE
-- ============================================================

SELECT
    d.department_name,
    COUNT(DISTINCT s.student_id) AS student_count,
    ROUND(AVG(r.marks_obtained), 2) AS average_marks
FROM departments AS d
INNER JOIN students AS s
    ON d.department_id = s.department_id
INNER JOIN results AS r
    ON s.student_id = r.student_id
GROUP BY
    d.department_id,
    d.department_name
ORDER BY average_marks DESC;


-- ============================================================
-- 5. COURSE PERFORMANCE
-- ============================================================

SELECT
    c.course_code,
    c.course_name,
    COUNT(r.result_id) AS students_attempted,
    ROUND(AVG(r.marks_obtained), 2) AS average_marks,
    MAX(r.marks_obtained) AS highest_marks,
    MIN(r.marks_obtained) AS lowest_marks
FROM courses AS c
INNER JOIN exams AS ex
    ON c.course_id = ex.course_id
INNER JOIN results AS r
    ON ex.exam_id = r.exam_id
GROUP BY
    c.course_id,
    c.course_code,
    c.course_name
ORDER BY average_marks DESC;


-- ============================================================
-- 6. PASS RATE BY COURSE
-- Passing score = 40
-- ============================================================

SELECT
    c.course_code,
    c.course_name,
    COUNT(r.result_id) AS total_attempts,

    SUM(
        CASE
            WHEN r.marks_obtained >= 40 THEN 1
            ELSE 0
        END
    ) AS passed_students,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN r.marks_obtained >= 40 THEN 1
                ELSE 0
            END
        ) / COUNT(r.result_id),
        2
    ) AS pass_rate_percentage

FROM courses AS c
INNER JOIN exams AS ex
    ON c.course_id = ex.course_id
INNER JOIN results AS r
    ON ex.exam_id = r.exam_id
GROUP BY
    c.course_id,
    c.course_code,
    c.course_name
ORDER BY pass_rate_percentage DESC;


-- ============================================================
-- 7. STUDENTS WHO FAILED AT LEAST ONE EXAM
-- ============================================================

SELECT DISTINCT
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name
FROM students AS s
INNER JOIN results AS r
    ON s.student_id = r.student_id
WHERE r.marks_obtained < 40
ORDER BY s.student_id;


-- ============================================================
-- 8. STUDENTS WITH MULTIPLE FAILURES
-- ============================================================

SELECT
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    COUNT(*) AS failed_exams
FROM students AS s
INNER JOIN results AS r
    ON s.student_id = r.student_id
WHERE r.marks_obtained < 40
GROUP BY
    s.student_id,
    s.first_name,
    s.last_name
HAVING COUNT(*) >= 2;


-- ============================================================
-- 9. MOST ENROLLED COURSES
-- ============================================================

SELECT
    c.course_code,
    c.course_name,
    COUNT(e.enrollment_id) AS enrollment_count
FROM courses AS c
LEFT JOIN enrollments AS e
    ON c.course_id = e.course_id
GROUP BY
    c.course_id,
    c.course_code,
    c.course_name
ORDER BY enrollment_count DESC;


-- ============================================================
-- 10. STUDENTS WITH THE MOST COURSE ENROLLMENTS
-- ============================================================

SELECT
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
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
-- 11. TOP STUDENT IN EACH DEPARTMENT
-- Uses a CTE and ROW_NUMBER()
-- ============================================================

WITH student_averages AS (
    SELECT
        s.student_id,
        CONCAT(s.first_name, ' ', s.last_name) AS student_name,
        s.department_id,
        ROUND(AVG(r.marks_obtained), 2) AS average_marks
    FROM students AS s
    INNER JOIN results AS r
        ON s.student_id = r.student_id
    GROUP BY
        s.student_id,
        s.first_name,
        s.last_name,
        s.department_id
),

ranked_students AS (
    SELECT
        student_id,
        student_name,
        department_id,
        average_marks,
        ROW_NUMBER() OVER (
            PARTITION BY department_id
            ORDER BY average_marks DESC
        ) AS department_rank
    FROM student_averages
)

SELECT
    rs.student_id,
    rs.student_name,
    d.department_name,
    rs.average_marks
FROM ranked_students AS rs
INNER JOIN departments AS d
    ON rs.department_id = d.department_id
WHERE rs.department_rank = 1
ORDER BY rs.average_marks DESC;


-- ============================================================
-- 12. RANK ALL STUDENTS BY AVERAGE MARKS
-- ============================================================

WITH student_averages AS (
    SELECT
        s.student_id,
        CONCAT(s.first_name, ' ', s.last_name) AS student_name,
        d.department_name,
        AVG(r.marks_obtained) AS average_marks
    FROM students AS s
    INNER JOIN departments AS d
        ON s.department_id = d.department_id
    INNER JOIN results AS r
        ON s.student_id = r.student_id
    GROUP BY
        s.student_id,
        s.first_name,
        s.last_name,
        d.department_name
)

SELECT
    student_id,
    student_name,
    department_name,
    ROUND(average_marks, 2) AS average_marks,
    RANK() OVER (
        ORDER BY average_marks DESC
    ) AS overall_rank
FROM student_averages
ORDER BY overall_rank;


-- ============================================================
-- 13. RANK STUDENTS WITHIN THEIR DEPARTMENT
-- ============================================================

WITH student_averages AS (
    SELECT
        s.student_id,
        CONCAT(s.first_name, ' ', s.last_name) AS student_name,
        s.department_id,
        AVG(r.marks_obtained) AS average_marks
    FROM students AS s
    INNER JOIN results AS r
        ON s.student_id = r.student_id
    GROUP BY
        s.student_id,
        s.first_name,
        s.last_name,
        s.department_id
)

SELECT
    student_id,
    student_name,
    department_id,
    ROUND(average_marks, 2) AS average_marks,
    RANK() OVER (
        PARTITION BY department_id
        ORDER BY average_marks DESC
    ) AS department_rank
FROM student_averages
ORDER BY department_id, department_rank;


-- ============================================================
-- 14. STUDENT PERFORMANCE CATEGORY
-- ============================================================

WITH student_averages AS (
    SELECT
        s.student_id,
        CONCAT(s.first_name, ' ', s.last_name) AS student_name,
        AVG(r.marks_obtained) AS average_marks
    FROM students AS s
    INNER JOIN results AS r
        ON s.student_id = r.student_id
    GROUP BY
        s.student_id,
        s.first_name,
        s.last_name
)

SELECT
    student_id,
    student_name,
    ROUND(average_marks, 2) AS average_marks,

    CASE
        WHEN average_marks >= 90 THEN 'Outstanding'
        WHEN average_marks >= 80 THEN 'Excellent'
        WHEN average_marks >= 70 THEN 'Good'
        WHEN average_marks >= 60 THEN 'Satisfactory'
        ELSE 'Needs Improvement'
    END AS performance_category

FROM student_averages
ORDER BY average_marks DESC;


-- ============================================================
-- 15. ACADEMIC RISK ANALYSIS
-- Students with average below 65
-- ============================================================

WITH student_averages AS (
    SELECT
        s.student_id,
        CONCAT(s.first_name, ' ', s.last_name) AS student_name,
        d.department_name,
        AVG(r.marks_obtained) AS average_marks
    FROM students AS s
    INNER JOIN departments AS d
        ON s.department_id = d.department_id
    INNER JOIN results AS r
        ON s.student_id = r.student_id
    GROUP BY
        s.student_id,
        s.first_name,
        s.last_name,
        d.department_name
)

SELECT
    student_id,
    student_name,
    department_name,
    ROUND(average_marks, 2) AS average_marks,
    'Academic Risk' AS risk_status
FROM student_averages
WHERE average_marks < 65
ORDER BY average_marks;


-- ============================================================
-- 16. INSTRUCTOR COURSE LOAD
-- ============================================================

SELECT
    i.instructor_id,
    CONCAT(i.first_name, ' ', i.last_name) AS instructor_name,
    COUNT(c.course_id) AS courses_taught
FROM instructors AS i
LEFT JOIN courses AS c
    ON i.instructor_id = c.instructor_id
GROUP BY
    i.instructor_id,
    i.first_name,
    i.last_name
ORDER BY courses_taught DESC;


-- ============================================================
-- 17. DEPARTMENT STUDENT AND COURSE SUMMARY
-- ============================================================

SELECT
    d.department_name,
    COUNT(DISTINCT s.student_id) AS student_count,
    COUNT(DISTINCT c.course_id) AS course_count
FROM departments AS d
LEFT JOIN students AS s
    ON d.department_id = s.department_id
LEFT JOIN courses AS c
    ON d.department_id = c.department_id
GROUP BY
    d.department_id,
    d.department_name
ORDER BY d.department_name;


-- ============================================================
-- 18. HIGHEST-SCORING STUDENT IN EACH COURSE
-- ============================================================

WITH course_scores AS (
    SELECT
        c.course_id,
        c.course_code,
        c.course_name,
        s.student_id,
        CONCAT(s.first_name, ' ', s.last_name) AS student_name,
        r.marks_obtained
    FROM results AS r
    INNER JOIN students AS s
        ON r.student_id = s.student_id
    INNER JOIN exams AS ex
        ON r.exam_id = ex.exam_id
    INNER JOIN courses AS c
        ON ex.course_id = c.course_id
),

ranked_scores AS (
    SELECT
        *,
        RANK() OVER (
            PARTITION BY course_id
            ORDER BY marks_obtained DESC
        ) AS course_rank
    FROM course_scores
)

SELECT
    course_code,
    course_name,
    student_name,
    marks_obtained
FROM ranked_scores
WHERE course_rank = 1
ORDER BY course_code;


-- ============================================================
-- 19. AVERAGE MARKS BY GENDER
-- ============================================================

SELECT
    gender,
    COUNT(*) AS student_count,
    ROUND(AVG(average_marks), 2) AS average_student_performance
FROM (
    SELECT
        s.student_id,
        s.gender,
        AVG(r.marks_obtained) AS average_marks
    FROM students AS s
    INNER JOIN results AS r
        ON s.student_id = r.student_id
    GROUP BY
        s.student_id,
        s.gender
) AS student_performance
GROUP BY gender;


-- ============================================================
-- 20. STUDENTS WHO HAVE TAKEN MORE THAN TWO COURSES
-- ============================================================

SELECT
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    COUNT(DISTINCT e.course_id) AS total_courses
FROM students AS s
INNER JOIN enrollments AS e
    ON s.student_id = e.student_id
GROUP BY
    s.student_id,
    s.first_name,
    s.last_name
HAVING COUNT(DISTINCT e.course_id) > 2
ORDER BY total_courses DESC;
