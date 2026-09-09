-- ============================================================
-- Module 27: Database Design & Normalization
-- practice.sql
-- MySQL 8.0+
-- ============================================================

USE module27_normalization;

-- ============================================================
-- SECTION 1: DATABASE DESIGN BASICS
-- ============================================================

-- 1. Create a table named suppliers with:
--    supplier_id as the primary key
--    supplier_name
--    email
--    city

-- 2. Add a UNIQUE constraint to supplier email.

-- 3. Add a NOT NULL constraint to supplier_name.

-- 4. Create a table named categories with:
--    category_id as the primary key
--    category_name as a unique value.

-- 5. Add three categories.

-- ============================================================
-- SECTION 2: KEYS
-- ============================================================

-- 6. Identify the primary key in the customers table.

-- 7. Identify the candidate key in the customers table.

-- 8. Explain why customer_id is a suitable surrogate key.

-- 9. Identify the composite primary key in order_items.

-- 10. Explain why order_id alone cannot uniquely identify
--     an order_items row.

-- ============================================================
-- SECTION 3: RELATIONSHIPS
-- ============================================================

-- 11. Identify the relationship between customers and orders.

-- 12. Identify the relationship between orders and products.

-- 13. Explain how order_items represents a many-to-many
--     relationship between orders and products.

-- 14. Write a query showing each customer and their orders.

-- 15. Write a query showing each order and its products.

-- 16. Write a query showing students and the courses
--     in which they are enrolled.

-- ============================================================
-- SECTION 4: FIRST NORMAL FORM
-- ============================================================

## -- 17. Consider:

-- student_id | student_name | courses

---

## -- 1          | Alice        | SQL, Python

-- Explain why this violates 1NF.

-- 18. Rewrite the above structure so that each course
--     is represented by an individual row.

-- 19. Explain why storing multiple phone numbers in one
--     column can be problematic.

-- 20. Design a normalized student_phone_numbers table.

-- ============================================================
-- SECTION 5: SECOND NORMAL FORM
-- ============================================================

## -- 21. Consider:

-- order_id
-- product_id
-- order_date
-- product_name
-- quantity
-----------

-- Primary key:
-- (order_id, product_id)
-------------------------

-- Identify all partial dependencies.

-- 22. Explain why order_date should not be stored in
--     order_items.

-- 23. Explain why product_name should not be stored in
--     order_items.

-- 24. Design normalized tables that remove the partial
--     dependencies.

-- 25. Explain why quantity can remain in order_items.

-- ============================================================
-- SECTION 6: THIRD NORMAL FORM
-- ============================================================

## -- 26. Consider:

-- employee_id
-- employee_name
-- department_id
-- department_name
------------------

-- Identify the transitive dependency.

-- 27. Explain why department_name belongs in departments.

-- 28. Write a query showing employees with their department names.

-- 29. Explain how separating departments prevents
--     update anomalies.

-- 30. Identify the functional dependencies in the
--     employees/departments design.

-- ============================================================
-- SECTION 7: ANOMALIES
-- ============================================================

-- 31. Describe an insert anomaly using the orders_bad table.

-- 32. Describe an update anomaly using the orders_bad table.

-- 33. Describe a delete anomaly that could occur in
--     a poorly designed order table.

-- 34. Explain how normalization reduces update anomalies.

-- 35. Explain how foreign keys help prevent invalid
--     relationships.

-- ============================================================
-- SECTION 8: FUNCTIONAL DEPENDENCIES
-- ============================================================

## -- 36. Identify the functional dependency:

-- product_id → ?

## -- 37. Identify the functional dependencies:

-- customer_id → ?

## -- 38. Explain:

-- employee_id → department_id
-- department_id → department_name

-- 39. Determine whether employee_id directly determines
--     department_name in the normalized design.

-- 40. Explain the difference between direct and transitive
--     dependency.

-- ============================================================
-- SECTION 9: CONSTRAINTS
-- ============================================================

-- 41. Insert a customer with a unique phone number.

-- 42. Attempt to insert a duplicate customer phone number.
--     Observe the constraint error.

-- 43. Attempt to insert an order using a non-existent
--     customer_id.

-- 44. Attempt to insert a product with a negative price.

-- 45. Attempt to insert an order_item with quantity 0.

-- ============================================================
-- SECTION 10: PRACTICAL NORMALIZATION
-- ============================================================

## -- 46. Consider the following table:

-- sales(
--     sale_id,
--     customer_name,
--     customer_city,
--     product_name,
--     product_price,
--     quantity
-- )
----

-- Identify at least three design problems.

-- 47. Identify the entities represented by the table.

-- 48. Design a normalized schema for the sales data.

-- 49. Identify the primary key of each new table.

-- 50. Identify the foreign keys connecting the tables.

-- ============================================================
-- SECTION 11: NORMALIZATION REVIEW
-- ============================================================

-- 51. Define 1NF in your own words.

-- 52. Define 2NF in your own words.

-- 53. Define 3NF in your own words.

-- 54. Explain BCNF.

-- 55. Explain why BCNF is stricter than 3NF.

-- 56. Explain why normalization is particularly useful
--     in transactional databases.

-- 57. Explain when denormalization may be useful.

-- 58. Explain why denormalization should be intentional.

-- 59. Give one example where storing derived data could
--     be justified.

-- 60. Write a short checklist you would use before
--     approving a new database schema.
