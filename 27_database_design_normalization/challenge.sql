-- ============================================================
-- Module 27: Database Design & Normalization
-- challenge.sql
-- MySQL 8.0+
-- ============================================================

USE module27_normalization;

-- ============================================================
-- CHALLENGE 1: Identify Design Problems
-- ============================================================

## -- Consider:

-- employee_id
-- employee_name
-- department_name
-- department_location
-- department_manager
---------------------

-- Task:
-- Identify the entities represented by this structure
-- and explain why storing all information in one table
-- could create redundancy.

-- ============================================================
-- CHALLENGE 2: Normalize Employee Data
-- ============================================================

## -- Design normalized tables for:

-- Employee
-- Department
-------------

-- Include:
-- * Primary keys
-- * Foreign key
-- * Appropriate constraints

-- ============================================================
-- CHALLENGE 3: Normalize a Customer Order Table
-- ============================================================

## -- Given:

-- order_id
-- order_date
-- customer_name
-- customer_phone
-- product_name
-- product_price
-- quantity
-----------

## -- Design a normalized schema.

## -- Your solution should contain at least:

-- customers
-- products
-- orders
-- order_items

-- ============================================================
-- CHALLENGE 4: Identify Functional Dependencies
-- ============================================================

-- For the customer/order design, identify the functional
-- dependencies for each table.

-- ============================================================
-- CHALLENGE 5: First Normal Form
-- ============================================================

## -- Consider:

-- customer_id | customer_name | phone_numbers

---

## -- 1           | Alice         | 111111,222222

-- Convert this design to 1NF.

-- ============================================================
-- CHALLENGE 6: Second Normal Form
-- ============================================================

## -- Consider:

-- order_id
-- product_id
-- order_date
-- customer_id
-- product_name
-- quantity
-----------

-- Primary key:
-- (order_id, product_id)
-------------------------

## -- Identify all partial dependencies.

-- Redesign the schema to achieve 2NF.

-- ============================================================
-- CHALLENGE 7: Third Normal Form
-- ============================================================

## -- Consider:

-- employee_id
-- employee_name
-- department_id
-- department_name
-- department_location
----------------------

## -- Identify the transitive dependencies.

-- Redesign the schema to achieve 3NF.

-- ============================================================
-- CHALLENGE 8: Many-to-Many Design
-- ============================================================

## -- Design a database for:

-- Students
-- Courses
----------

-- Requirements:
-- * One student can take many courses.
-- * One course can contain many students.
-- * Store enrollment date.
-- * Prevent duplicate enrollment.

-- ============================================================
-- CHALLENGE 9: University Database
-- ============================================================

## -- Design normalized tables for:

-- Students
-- Instructors
-- Courses
-- Departments
-- Enrollments
--------------

-- Requirements:
-- * Each student belongs to a department.
-- * Each instructor belongs to a department.
-- * Each course belongs to a department.
-- * Students can enroll in many courses.
-- * Courses can contain many students.
-- * An instructor can teach multiple courses.

-- ============================================================
-- CHALLENGE 10: E-Commerce Database
-- ============================================================

-- Design a normalized schema for an e-commerce system
-- containing:
--------------

-- Customers
-- Addresses
-- Products
-- Categories
-- Orders
-- Order Items
-- Payments
-----------

-- Identify:
-- * Primary keys
-- * Foreign keys
-- * One-to-many relationships
-- * Many-to-many relationships

-- ============================================================
-- CHALLENGE 11: Composite Key Analysis
-- ============================================================

## -- Explain why this primary key may be appropriate:

## -- PRIMARY KEY (order_id, product_id)

## -- Then explain when you might instead introduce:

## -- order_item_id

-- as a surrogate primary key.

-- ============================================================
-- CHALLENGE 12: Data Anomalies
-- ============================================================

## -- Create an example of a table that suffers from:

-- 1. Insert anomaly
-- 2. Update anomaly
-- 3. Delete anomaly
--------------------

-- Explain how normalization fixes each problem.

-- ============================================================
-- CHALLENGE 13: Constraint Design
-- ============================================================

## -- Design a products table with:

-- product_id
-- product_name
-- product_code
-- price
-- stock_quantity
-----------------

-- Requirements:
-- * product_id is the primary key.
-- * product_code is unique.
-- * product_name cannot be NULL.
-- * price cannot be negative.
-- * stock_quantity cannot be negative.

-- ============================================================
-- CHALLENGE 14: Derived Data
-- ============================================================

## -- Consider:

-- quantity
-- unit_price
-- total_price
--------------

## -- Explain whether total_price should always be stored.

-- Give one argument for calculating it.
-- Give one argument for storing it.

-- ============================================================
-- CHALLENGE 15: Normalization vs Denormalization
-- ============================================================

-- A reporting dashboard repeatedly executes a complex query
-- joining:
-----------

-- customers
-- orders
-- order_items
-- products
-----------

## -- The query is slow.

-- Explain at least three approaches you could consider
-- before deciding to denormalize the data.

-- ============================================================
-- CHALLENGE 16: BCNF
-- ============================================================

## -- Consider a relation where:

-- instructor_id → course_id
-- course_id → instructor_id
----------------------------

## -- Analyze whether the determinants are candidate keys.

-- Explain whether the relation satisfies the BCNF rule.

-- ============================================================
-- CHALLENGE 17: Schema Review
-- ============================================================

## -- Review the following design:

-- customer_orders(
--     order_id,
--     customer_name,
--     customer_email,
--     customer_city,
--     product_1,
--     product_2,
--     product_3,
--     total
-- )
----

-- Identify at least five problems.

-- ============================================================
-- CHALLENGE 18: Redesign the Schema
-- ============================================================

## -- Redesign customer_orders into a normalized structure.

-- Include appropriate relationships and constraints.

-- ============================================================
-- CHALLENGE 19: Build and Query
-- ============================================================

## -- Create your normalized schema from Challenge 18.

## -- Insert sample data.

## -- Write a query that returns:

-- order_id
-- customer_name
-- product_name
-- quantity
-- product_price
-- line_total

-- ============================================================
-- CHALLENGE 20: Integrity Test
-- ============================================================

## -- Attempt to:

-- 1. Insert a duplicate customer email.
-- 2. Insert an order for a non-existent customer.
-- 3. Insert an order item for a non-existent product.
-- 4. Insert a negative product price.
--------------------------------------

-- Record which constraints prevent each operation.

-- ============================================================
-- CHALLENGE 21: Normalization Audit
-- ============================================================

## -- Choose any database schema you have designed previously.

## -- Audit it using:

-- 1NF
-- 2NF
-- 3NF
------

-- Document:
-- * Entities
-- * Keys
-- * Functional dependencies
-- * Relationships
-- * Potential anomalies

-- ============================================================
-- CHALLENGE 22: Design Decision
-- ============================================================

## -- You are designing an online bookstore.

-- Decide whether each item should be normalized or
-- potentially denormalized:
----------------------------

-- 1. Book information
-- 2. Author information
-- 3. Customer information
-- 4. Order information
-- 5. Frequently accessed sales summaries
-----------------------------------------

-- Justify every decision.

-- ============================================================
-- CHALLENGE 23: Final Design Project
-- ============================================================

-- Design a complete normalized database for a food delivery
-- application.
---------------

## -- Possible entities:

-- Customers
-- Restaurants
-- Addresses
-- Menu Items
-- Categories
-- Orders
-- Order Items
-- Payments
-- Delivery Partners
--------------------

-- Requirements:
-- * Identify primary keys.
-- * Identify foreign keys.
-- * Define one-to-many relationships.
-- * Define many-to-many relationships where required.
-- * Apply 1NF, 2NF, and 3NF.
-- * Add appropriate constraints.
-- * Explain important functional dependencies.

-- ============================================================
-- CHALLENGE 24: Final Normalization Review
-- ============================================================

## -- Answer the following without looking at notes:

-- 1. What problem does normalization solve?
-- 2. What is data redundancy?
-- 3. What is an insert anomaly?
-- 4. What is an update anomaly?
-- 5. What is a delete anomaly?
-- 6. What is a functional dependency?
-- 7. What is partial dependency?
-- 8. What is transitive dependency?
-- 9. What is 1NF?
-- 10. What is 2NF?
-- 11. What is 3NF?
-- 12. What is BCNF?
-- 13. What is a surrogate key?
-- 14. What is a natural key?
-- 15. When can denormalization be useful?
-- 16. Why are foreign keys important?

-- ============================================================
-- END OF MODULE 27
-- ============================================================
