-- ============================================================
-- MODULE 10: CASE EXPRESSIONS
-- File: solutions.sql
-- MySQL 8.0+
-- ============================================================

USE school;


-- ============================================================
-- EASY
-- ============================================================

-- Exercise 1

SELECT
    first_name,
    age,
    CASE
        WHEN age >= 21 THEN '21+'
        ELSE 'Under 21'
    END AS age_group
FROM students;


-- Exercise 2

SELECT
    first_name,
    city,
    CASE
        WHEN city IN ('Delhi', 'Mumbai')
            THEN 'Major City'
        ELSE 'Other City'
    END AS city_type
FROM students;


-- Exercise 3

SELECT
    first_name,
    age,
    CASE
        WHEN age > 20 THEN 'Above 20'
        WHEN age = 20 THEN 'Exactly 20'
        ELSE 'Below 20'
    END AS age_status
FROM students;


-- Exercise 4

SELECT
    first_name,
    city,
    CASE city
        WHEN 'Delhi' THEN 'North'
        WHEN 'Mumbai' THEN 'West'
        WHEN 'Pune' THEN 'West'
        WHEN 'Jaipur' THEN 'North'
        ELSE 'Other'
    END AS region
FROM students;


-- Exercise 5

SELECT
    first_name,
    age,
    CASE
        WHEN age BETWEEN 19 AND 20 THEN '19-20'
        WHEN age BETWEEN 21 AND 22 THEN '21-22'
        ELSE 'Other'
    END AS age_range
FROM students;


-- ============================================================
-- MEDIUM
-- ============================================================

-- Exercise 6

SELECT
    first_name,
    age,
    CASE
        WHEN age >= 22 THEN 'Level 3'
        WHEN age >= 20 THEN 'Level 2'
        ELSE 'Level 1'
    END AS student_level
FROM students;


-- Exercise 7

SELECT
    first_name,
    city,
    CASE
        WHEN city IN ('Delhi', 'Jaipur') THEN 'North'
        WHEN city IN ('Mumbai', 'Pune') THEN 'West'
        WHEN city = 'Lucknow' THEN 'Central'
        ELSE 'Other'
    END AS region
FROM students;


-- Exercise 8

SELECT
    first_name,
    city,
    CASE city
        WHEN 'Delhi' THEN 1
        WHEN 'Mumbai' THEN 2
        WHEN 'Pune' THEN 3
        ELSE 4
    END AS city_priority
FROM students
ORDER BY city_priority;


-- Exercise 9

SELECT
    first_name,
    age,
    CASE
        WHEN age >= 21 THEN age - 20
        ELSE 0
    END AS age_difference
FROM students;


-- Exercise 10

SELECT
    first_name,
    age,
    CASE
        WHEN age < 20 THEN 'Under 20'
        WHEN age = 20 THEN 'Exactly 20'
        ELSE 'Over 20'
    END AS age_group
FROM students;


-- Exercise 11

SELECT
    SUM(
        CASE
            WHEN age >= 21 THEN 1
            ELSE 0
        END
    ) AS students_21_plus
FROM students;


-- Exercise 12

SELECT
    SUM(
        CASE
            WHEN age < 21 THEN 1
            ELSE 0
        END
    ) AS students_under_21
FROM students;


-- ============================================================
-- HARD
-- ============================================================

-- Exercise 13

SELECT
    CASE
        WHEN age < 20 THEN 'Young'
        WHEN age = 20 THEN 'Standard'
        ELSE 'Older'
    END AS age_group,
    COUNT(*) AS student_count
FROM students
GROUP BY
    CASE
        WHEN age < 20 THEN 'Young'
        WHEN age = 20 THEN 'Standard'
        ELSE 'Older'
    END;


-- Exercise 14

SELECT
    first_name,
    age,
    (
        SELECT AVG(age)
        FROM students
    ) AS average_age,
    CASE
        WHEN age > (
            SELECT AVG(age)
            FROM students
        )
        THEN 'Above Average'
        ELSE 'Average or Below'
    END AS age_status
FROM students;


-- Exercise 15

SELECT
    first_name,
    city
FROM students
ORDER BY
    CASE city
        WHEN 'Delhi' THEN 1
        WHEN 'Mumbai' THEN 2
        WHEN 'Pune' THEN 3
        ELSE 4
    END,
    first_name;


-- Exercise 16

SELECT
    first_name,
    age,
    city,

    CASE
        WHEN age >= 21 THEN '21+'
        ELSE 'Under 21'
    END AS age_group,

    CASE
        WHEN city IN ('Delhi', 'Mumbai')
            THEN 'Major'
        ELSE 'Other'
    END AS city_group

FROM students;


-- Exercise 17

SELECT
    first_name,
    age,
    CASE
        WHEN age >= 22 THEN 'Senior'
        WHEN age = 21 THEN 'Intermediate'
        WHEN age = 20 THEN 'Junior'
        ELSE 'Beginner'
    END AS student_status
FROM students;


-- Exercise 18

SELECT
    CASE
        WHEN age >= 21 THEN '21+'
        ELSE 'Under 21'
    END AS age_group,
    COUNT(*) AS student_count
FROM students
GROUP BY
    CASE
        WHEN age >= 21 THEN '21+'
        ELSE 'Under 21'
    END;


-- Exercise 19

SELECT
    first_name,
    city,
    age
FROM students
ORDER BY
    CASE city
        WHEN 'Delhi' THEN 1
        WHEN 'Mumbai' THEN 2
        WHEN 'Pune' THEN 3
        ELSE 4
    END,
    first_name
LIMIT 3;


-- Exercise 20

SELECT
    first_name,
    city,
    age,
    CASE
        WHEN city = 'Delhi' AND age >= 21
            THEN 'Priority A'

        WHEN city = 'Delhi' AND age < 21
            THEN 'Priority B'

        WHEN city <> 'Delhi' AND age >= 21
            THEN 'Priority C'

        ELSE 'Priority D'
    END AS classification
FROM students;
