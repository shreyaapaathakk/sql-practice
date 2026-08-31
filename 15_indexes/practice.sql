-- ============================================================
-- MODULE 15: INDEXES
-- File: practice.sql
-- MySQL 8.0+
-- ============================================================

USE school;


-- ============================================================
-- EASY
-- ============================================================

-- Exercise 1
-- Create a table named practice_index_students with:
--
-- student_id INT PRIMARY KEY
-- first_name VARCHAR(50)
-- last_name VARCHAR(50)
-- city VARCHAR(50)
-- age INT


-- Exercise 2
-- Insert at least five students into the table.


-- Exercise 3
-- Create an index named:
--
-- idx_practice_students_city
--
-- on the city column.


-- Exercise 4
-- Display all indexes on practice_index_students.


-- Exercise 5
-- Write a query that finds students from Delhi.


-- Exercise 6
-- Use EXPLAIN with the Delhi query.


-- Exercise 7
-- Create an index on last_name.


-- Exercise 8
-- Remove the last_name index.


-- Exercise 9
-- Create a users table with:
--
-- user_id INT PRIMARY KEY
-- username VARCHAR(50) UNIQUE
-- email VARCHAR(100)
--
-- Inspect the indexes created by the PRIMARY KEY
-- and UNIQUE constraint.


-- Exercise 10
-- Explain why you normally should not create another
-- ordinary index on a PRIMARY KEY column.


-- ============================================================
-- MEDIUM
-- ============================================================

-- Exercise 11
-- Create an index on age.


-- Exercise 12
-- Write a query that searches for students whose age
-- is between 18 and 21.


-- Exercise 13
-- Use EXPLAIN to inspect the age query.


-- Exercise 14
-- Create a composite index:
--
-- (city, age)
--
-- Give it a meaningful name.


-- Exercise 15
-- Write a query filtering by:
--
-- city
-- AND age


-- Exercise 16
-- Write another query filtering only by city.


-- Exercise 17
-- Write another query filtering only by age.
--
-- Consider whether the composite index from Exercise 14
-- is an ideal index for this query.


-- Exercise 18
-- Create an index on last_name and test:
--
-- last_name LIKE 'Sh%'


-- Exercise 19
-- Test:
--
-- last_name LIKE '%ma'
--
-- Explain why a leading wildcard can make normal
-- B-tree index usage difficult.


-- Exercise 20
-- Create a departments table and a students table.
--
-- Make students.department_id a foreign key.
--
-- Create an appropriate index for the student
-- department_id column.


-- ============================================================
-- HARD
-- ============================================================

-- Exercise 21
-- Create an orders table containing:
--
-- order_id
-- customer_id
-- order_date
-- status
-- total_amount
--
-- Choose appropriate data types.


-- Exercise 22
-- Create an index on customer_id.


-- Exercise 23
-- Create a composite index suitable for queries that
-- frequently filter orders using:
--
-- customer_id
-- AND status


-- Exercise 24
-- Write an EXPLAIN query that filters by customer_id
-- and status.


-- Exercise 25
-- Create an index suitable for a query that frequently
-- retrieves the newest orders for a customer.
--
-- Consider:
--
-- customer_id
-- order_date


-- Exercise 26
-- Use EXPLAIN to inspect a query that:
--
-- filters by customer_id
-- sorts by order_date DESC
-- returns only five rows


-- Exercise 27
-- Create an index containing:
--
-- city
-- first_name
--
-- Then write a query that selects first_name for
-- students from a particular city.


-- Exercise 28
-- Explain what a covering index is in your own words.


-- Exercise 29
-- Use SHOW INDEX to inspect the indexes on one of
-- your practice tables.
--
-- Identify:
--
-- Key_name
-- Column_name
-- Non_unique
-- Seq_in_index
-- Cardinality


-- Exercise 30
-- Query INFORMATION_SCHEMA.STATISTICS to display
-- index metadata for one of your practice tables.


-- ============================================================
-- ADVANCED BEGINNER
-- ============================================================

-- Exercise 31
-- Create a table containing:
--
-- employee_id
-- employee_name
-- department_id
-- salary
-- status
--
-- Create an index that could support queries filtering
-- by department_id and status.


-- Exercise 32
-- Explain why:
--
-- INDEX(department_id, status)
--
-- is not necessarily equivalent to:
--
-- INDEX(status, department_id)


-- Exercise 33
-- Create a table containing a long VARCHAR column.
--
-- Create a prefix index on the first 20 characters.


-- Exercise 34
-- Create a descending index on salary.


-- Exercise 35
-- Create a multi-column index using:
--
-- department_id ASC
-- salary DESC


-- Exercise 36
-- Explain why creating indexes on every column
-- is usually a bad idea.


-- Exercise 37
-- Explain how indexes can affect:
--
-- INSERT
-- UPDATE
-- DELETE


-- Exercise 38
-- Explain the difference between:
--
-- primary-key index
-- secondary index


-- Exercise 39
-- Explain what index selectivity means.


-- Exercise 40
-- Explain why a column containing only two possible
-- values may not always be an excellent standalone
-- index candidate.


-- ============================================================
-- PERFORMANCE PRACTICE
-- ============================================================

-- Exercise 41
-- Create a table named performance_students with
-- at least 1,000 rows.
--
-- You may generate the data using a recursive CTE
-- or another appropriate MySQL technique.


-- Exercise 42
-- Write a query that searches performance_students
-- by email.


-- Exercise 43
-- Run EXPLAIN before creating an email index.


-- Exercise 44
-- Create an index on email.


-- Exercise 45
-- Run EXPLAIN again.
--
-- Compare the execution plan.


-- Exercise 46
-- Write a query that filters students by city
-- and age.


-- Exercise 47
-- Design an index specifically for that query.


-- Exercise 48
-- Use EXPLAIN to determine whether MySQL chooses
-- your new index.


-- Exercise 49
-- Remove an index that is not useful.
--
-- Use SHOW INDEX before and after the operation.


-- Exercise 50
-- Write a short comment explaining why you removed it.
