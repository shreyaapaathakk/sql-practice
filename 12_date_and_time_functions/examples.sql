
## `12_date_and_time_functions/examples.sql`

```sql
-- ============================================================
-- MODULE 12: DATE & TIME FUNCTIONS
-- File: examples.sql
-- MySQL 8.0+
-- ============================================================

USE school;


-- ============================================================
-- 1. CURRENT DATE
-- ============================================================

SELECT CURDATE();

SELECT CURRENT_DATE();


-- ============================================================
-- 2. CURRENT DATE AND TIME
-- ============================================================

SELECT NOW();

SELECT CURRENT_TIMESTAMP();


-- ============================================================
-- 3. CURRENT TIME
-- ============================================================

SELECT CURTIME();


-- ============================================================
-- 4. DATE()
-- ============================================================

SELECT
    DATE('2026-08-27 18:30:45') AS record_date;


-- ============================================================
-- 5. TIME()
-- ============================================================

SELECT
    TIME('2026-08-27 18:30:45') AS record_time;


-- ============================================================
-- 6. YEAR()
-- ============================================================

SELECT
    YEAR('2026-08-27') AS year_value;


-- ============================================================
-- 7. MONTH()
-- ============================================================

SELECT
    MONTH('2026-08-27') AS month_value;


-- ============================================================
-- 8. MONTHNAME()
-- ============================================================

SELECT
    MONTHNAME('2026-08-27') AS month_name;


-- ============================================================
-- 9. DAY()
-- ============================================================

SELECT
    DAY('2026-08-27') AS day_value;


-- ============================================================
-- 10. DAYNAME()
-- ============================================================

SELECT
    DAYNAME('2026-08-27') AS day_name;


-- ============================================================
-- 11. HOUR(), MINUTE(), SECOND()
-- ============================================================

SELECT
    HOUR('18:30:45') AS hour_value,
    MINUTE('18:30:45') AS minute_value,
    SECOND('18:30:45') AS second_value;


-- ============================================================
-- 12. CREATE PRACTICE TABLE
-- ============================================================

DROP TABLE IF EXISTS student_records;

CREATE TABLE student_records (
    record_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    enrollment_date DATE,
    last_login DATETIME,
    birth_date DATE
);


-- ============================================================
-- 13. INSERT SAMPLE DATA
-- ============================================================

INSERT INTO student_records
    (student_id, enrollment_date, last_login, birth_date)
VALUES
    (1, '2026-01-15', '2026-08-25 09:30:00', '2005-04-12'),
    (2, '2026-02-10', '2026-08-26 14:15:00', '2004-09-20'),
    (3, '2026-03-05', '2026-08-20 10:45:00', '2006-01-08'),
    (4, '2026-06-18', '2026-08-27 08:20:00', '2003-12-25'),
    (5, '2026-08-01', '2026-08-27 11:10:00', '2005-07-30');


-- ============================================================
-- 14. VIEW TABLE
-- ============================================================

SELECT *
FROM student_records;


-- ============================================================
-- 15. EXTRACT ENROLLMENT YEAR
-- ============================================================

SELECT
    student_id,
    enrollment_date,
    YEAR(enrollment_date) AS enrollment_year
FROM student_records;


-- ============================================================
-- 16. EXTRACT ENROLLMENT MONTH
-- ============================================================

SELECT
    student_id,
    enrollment_date,
    MONTH(enrollment_date) AS enrollment_month
FROM student_records;


-- ============================================================
-- 17. MONTH NAME
-- ============================================================

SELECT
    student_id,
    enrollment_date,
    MONTHNAME(enrollment_date) AS enrollment_month
FROM student_records;


-- ============================================================
-- 18. DAY NAME
-- ============================================================

SELECT
    student_id,
    enrollment_date,
    DAYNAME(enrollment_date) AS enrollment_day
FROM student_records;


-- ============================================================
-- 19. DATEDIFF()
-- ============================================================

SELECT
    student_id,
    enrollment_date,
    DATEDIFF(
        CURDATE(),
        enrollment_date
    ) AS days_since_enrollment
FROM student_records;


-- ============================================================
-- 20. DATE_ADD()
-- ============================================================

SELECT
    student_id,
    enrollment_date,
    DATE_ADD(
        enrollment_date,
        INTERVAL 30 DAY
    ) AS course_end_date
FROM student_records;


-- ============================================================
-- 21. DATE_SUB()
-- ============================================================

SELECT
    student_id,
    enrollment_date,
    DATE_SUB(
        enrollment_date,
        INTERVAL 30 DAY
    ) AS date_30_days_before
FROM student_records;


-- ============================================================
-- 22. TIMESTAMPDIFF()
-- ============================================================

SELECT
    student_id,
    birth_date,
    TIMESTAMPDIFF(
        YEAR,
        birth_date,
        CURDATE()
    ) AS age
FROM student_records;


-- ============================================================
-- 23. LAST_DAY()
-- ============================================================

SELECT
    enrollment_date,
    LAST_DAY(enrollment_date) AS month_end
FROM student_records;


-- ============================================================
-- 24. EXTRACT()
-- ============================================================

SELECT
    enrollment_date,
    EXTRACT(YEAR FROM enrollment_date) AS year_value,
    EXTRACT(MONTH FROM enrollment_date) AS month_value,
    EXTRACT(DAY FROM enrollment_date) AS day_value
FROM student_records;


-- ============================================================
-- 25. DATE_FORMAT()
-- ============================================================

SELECT
    enrollment_date,
    DATE_FORMAT(
        enrollment_date,
        '%d-%m-%Y'
    ) AS formatted_date
FROM student_records;


-- ============================================================
-- 26. FORMAT DATETIME
-- ============================================================

SELECT
    student_id,
    DATE_FORMAT(
        last_login,
        '%W, %M %d, %Y at %H:%i'
    ) AS formatted_login
FROM student_records;


-- ============================================================
-- 27. STR_TO_DATE()
-- ============================================================

SELECT
    STR_TO_DATE(
        '27-08-2026',
        '%d-%m-%Y'
    ) AS converted_date;


-- ============================================================
-- 28. RECENT ENROLLMENTS
-- ============================================================

SELECT *
FROM student_records
WHERE enrollment_date >= '2026-06-01';


-- ============================================================
-- 29. RECORDS FROM 2026
-- ============================================================

SELECT *
FROM student_records
WHERE enrollment_date >= '2026-01-01'
  AND enrollment_date < '2027-01-01';


-- ============================================================
-- 30. RECORDS FROM AUGUST 2026
-- ============================================================

SELECT *
FROM student_records
WHERE enrollment_date >= '2026-08-01'
  AND enrollment_date < '2026-09-01';


-- ============================================================
-- 31. LAST 30 DAYS
-- ============================================================

SELECT *
FROM student_records
WHERE enrollment_date >= DATE_SUB(
    CURDATE(),
    INTERVAL 30 DAY
);


-- ============================================================
-- 32. TODAY'S LOGINS
-- ============================================================

SELECT *
FROM student_records
WHERE last_login >= CURDATE()
  AND last_login < DATE_ADD(
      CURDATE(),
      INTERVAL 1 DAY
  );


-- ============================================================
-- 33. NEWEST STUDENTS
-- ============================================================

SELECT *
FROM student_records
ORDER BY enrollment_date DESC
LIMIT 3;


-- ============================================================
-- 34. OLDEST ENROLLMENTS
-- ============================================================

SELECT *
FROM student_records
ORDER BY enrollment_date ASC
LIMIT 3;


-- ============================================================
-- 35. MISSING BIRTH DATES
-- ============================================================

SELECT *
FROM student_records
WHERE birth_date IS NULL;


-- ============================================================
-- 36. COMPLETE DATE REPORT
-- ============================================================

SELECT
    student_id,
    enrollment_date,
    YEAR(enrollment_date) AS enrollment_year,
    MONTHNAME(enrollment_date) AS enrollment_month,
    DAYNAME(enrollment_date) AS enrollment_day,
    DATEDIFF(
        CURDATE(),
        enrollment_date
    ) AS days_since_enrollment
FROM student_records
ORDER BY enrollment_date;
