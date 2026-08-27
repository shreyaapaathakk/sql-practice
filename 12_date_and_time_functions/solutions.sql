-- ============================================================
-- MODULE 12: DATE & TIME FUNCTIONS
-- File: solutions.sql
-- MySQL 8.0+
-- ============================================================

USE school;


-- ============================================================
-- EASY
-- ============================================================

-- Exercise 1

SELECT CURDATE();


-- Exercise 2

SELECT NOW();


-- Exercise 3

SELECT CURTIME();


-- Exercise 4

SELECT
    student_id,
    enrollment_date,
    YEAR(enrollment_date) AS enrollment_year
FROM student_records;


-- Exercise 5

SELECT
    student_id,
    enrollment_date,
    MONTH(enrollment_date) AS enrollment_month
FROM student_records;


-- Exercise 6

SELECT
    student_id,
    enrollment_date,
    MONTHNAME(enrollment_date) AS month_name
FROM student_records;


-- Exercise 7

SELECT
    student_id,
    enrollment_date,
    DAYNAME(enrollment_date) AS day_name
FROM student_records;


-- Exercise 8

SELECT
    student_id,
    DATE(last_login) AS login_date
FROM student_records;


-- Exercise 9

SELECT
    student_id,
    TIME(last_login) AS login_time
FROM student_records;


-- Exercise 10

SELECT
    student_id,
    enrollment_date,
    EXTRACT(YEAR FROM enrollment_date) AS year_value,
    EXTRACT(MONTH FROM enrollment_date) AS month_value,
    EXTRACT(DAY FROM enrollment_date) AS day_value
FROM student_records;


-- ============================================================
-- MEDIUM
-- ============================================================

-- Exercise 11

SELECT
    student_id,
    enrollment_date,
    DATEDIFF(
        CURDATE(),
        enrollment_date
    ) AS days_since_enrollment
FROM student_records;


-- Exercise 12

SELECT
    student_id,
    enrollment_date,
    DATE_ADD(
        enrollment_date,
        INTERVAL 30 DAY
    ) AS future_date
FROM student_records;


-- Exercise 13

SELECT
    student_id,
    enrollment_date,
    DATE_SUB(
        enrollment_date,
        INTERVAL 7 DAY
    ) AS previous_date
FROM student_records;


-- Exercise 14

SELECT
    student_id,
    birth_date,
    TIMESTAMPDIFF(
        YEAR,
        birth_date,
        CURDATE()
    ) AS age
FROM student_records;


-- Exercise 15

SELECT
    student_id,
    enrollment_date,
    LAST_DAY(enrollment_date) AS month_end
FROM student_records;


-- Exercise 16

SELECT
    student_id,
    DATE_FORMAT(
        enrollment_date,
        '%d-%m-%Y'
    ) AS formatted_date
FROM student_records;


-- Exercise 17

SELECT
    student_id,
    DATE_FORMAT(
        last_login,
        '%Y/%m/%d %H:%i'
    ) AS formatted_login
FROM student_records;


-- Exercise 18

SELECT *
FROM student_records
WHERE enrollment_date >= '2026-08-01'
  AND enrollment_date < '2026-09-01';


-- Exercise 19

SELECT *
FROM student_records
WHERE enrollment_date >= '2026-01-01'
  AND enrollment_date < '2026-07-01';


-- Exercise 20

SELECT *
FROM student_records
ORDER BY enrollment_date DESC
LIMIT 3;


-- ============================================================
-- HARD
-- ============================================================

-- Exercise 21

SELECT
    student_id,
    enrollment_date,
    DATE_ADD(
        enrollment_date,
        INTERVAL 90 DAY
    ) AS course_end_date
FROM student_records;


-- Exercise 22

SELECT *
FROM student_records
WHERE enrollment_date < DATE_SUB(
    CURDATE(),
    INTERVAL 100 DAY
);


-- Exercise 23

SELECT
    student_id,
    birth_date,
    TIMESTAMPDIFF(
        YEAR,
        birth_date,
        CURDATE()
    ) AS age
FROM student_records
WHERE TIMESTAMPDIFF(
    YEAR,
    birth_date,
    CURDATE()
) >= 20;


-- Exercise 24

SELECT
    student_id,
    enrollment_date,
    DATEDIFF(
        CURDATE(),
        enrollment_date
    ) AS days_since_enrollment,
    CASE
        WHEN DATEDIFF(
            CURDATE(),
            enrollment_date
        ) >= 180
            THEN 'Long-Term'
        ELSE 'Recent'
    END AS enrollment_status
FROM student_records;


-- Exercise 25

SELECT *
FROM student_records
WHERE last_login >= '2026-08-27 00:00:00'
  AND last_login < '2026-08-28 00:00:00';


-- Exercise 26

SELECT *
FROM student_records
ORDER BY enrollment_date ASC
LIMIT 1;


-- Exercise 27

SELECT *
FROM student_records
ORDER BY enrollment_date DESC
LIMIT 1;


-- Exercise 28

SELECT
    student_id,
    birth_date,
    TIMESTAMPDIFF(
        YEAR,
        birth_date,
        CURDATE()
    ) AS age
FROM student_records
ORDER BY
    age DESC,
    student_id ASC;


-- Exercise 29

SELECT
    student_id,
    enrollment_date,
    MONTHNAME(enrollment_date) AS month_name,
    DAYNAME(enrollment_date) AS day_name
FROM student_records
ORDER BY enrollment_date;


-- Exercise 30

SELECT
    student_id,
    TIMESTAMPDIFF(
        YEAR,
        birth_date,
        CURDATE()
    ) AS age,
    enrollment_date,
    DATE_ADD(
        enrollment_date,
        INTERVAL 90 DAY
    ) AS course_end_date,
    DATEDIFF(
        CURDATE(),
        enrollment_date
    ) AS days_since_enrollment
FROM student_records
ORDER BY enrollment_date;


-- ============================================================
-- ADVANCED BEGINNER
-- ============================================================

-- Exercise 31

SELECT *
FROM student_records
WHERE enrollment_date >= '2026-02-01'
  AND enrollment_date < '2026-07-01';


-- Exercise 32

SELECT *
FROM student_records
WHERE enrollment_date >= '2026-01-01'
  AND enrollment_date < '2027-01-01';


-- Exercise 33

SELECT *
FROM student_records
WHERE last_login >= CURDATE()
  AND last_login < DATE_ADD(
      CURDATE(),
      INTERVAL 1 DAY
  );


-- Exercise 34

SELECT *
FROM student_records
WHERE last_login >= DATE_SUB(
    NOW(),
    INTERVAL 7 DAY
);


-- Exercise 35

SELECT
    CONCAT(
        'Student #',
        student_id,
        ' | Enrolled: ',
        DATE_FORMAT(
            enrollment_date,
            '%d-%m-%Y'
        )
    ) AS student_timeline
FROM student_records;


-- Exercise 36

SELECT
    student_id,
    birth_date,
    TIMESTAMPDIFF(
        YEAR,
        birth_date,
        CURDATE()
    ) AS age_in_years,
    TIMESTAMPDIFF(
        MONTH,
        birth_date,
        CURDATE()
    ) AS age_in_months
FROM student_records;


-- Exercise 37

SELECT
    student_id,
    enrollment_date,
    DATE_ADD(
        enrollment_date,
        INTERVAL 90 DAY
    ) AS course_end_date,
    DATEDIFF(
        DATE_ADD(
            enrollment_date,
            INTERVAL 90 DAY
        ),
        enrollment_date
    ) AS course_duration_days
FROM student_records;


-- Exercise 38

SELECT
    student_id,
    birth_date,
    enrollment_date
FROM student_records
WHERE MONTH(birth_date) = MONTH(enrollment_date);


-- Exercise 39

SELECT
    student_id,
    enrollment_date,
    DAYNAME(enrollment_date) AS day_name
FROM student_records
WHERE WEEKDAY(enrollment_date) IN (5, 6);


-- Exercise 40

SELECT
    student_id,
    birth_date,
    enrollment_date,
    last_login,
    TIMESTAMPDIFF(
        YEAR,
        birth_date,
        CURDATE()
    ) AS age,
    DATEDIFF(
        CURDATE(),
        enrollment_date
    ) AS days_since_enrollment,
    DATE_ADD(
        enrollment_date,
        INTERVAL 90 DAY
    ) AS course_end_date
FROM student_records
ORDER BY enrollment_date;
