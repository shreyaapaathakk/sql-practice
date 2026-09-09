-- ============================================================
-- Module 27: Database Design & Normalization
-- solutions.sql
-- MySQL 8.0+
-- ============================================================

USE module27_normalization;

-- ============================================================
-- SECTION 1: DATABASE DESIGN BASICS
-- ============================================================

-- 1.
CREATE TABLE suppliers (
supplier_id INT PRIMARY KEY,
supplier_name VARCHAR(100),
email VARCHAR(255),
city VARCHAR(100)
);

-- 2.
ALTER TABLE suppliers
ADD CONSTRAINT uq_supplier_email
UNIQUE (email);

-- 3.
ALTER TABLE suppliers
MODIFY supplier_name VARCHAR(100) NOT NULL;

-- 4.
CREATE TABLE categories (
category_id INT PRIMARY KEY,
category_name VARCHAR(100) NOT NULL UNIQUE
);

-- 5.
INSERT INTO categories
VALUES
(1, 'Electronics'),
(2, 'Furniture'),
(3, 'Stationery');

-- ============================================================
-- SECTION 2: KEYS
-- ============================================================

-- 6.
-- customers.customer_id

-- 7.
-- customers.customer_phone can act as a candidate key
-- because it has a UNIQUE constraint.

-- 8.
-- customer_id is simple, stable, and does not depend
-- on business information.

-- 9.
-- order_items:
-- PRIMARY KEY (order_id, product_id)

-- 10.
-- One order can contain multiple products.
-- Therefore, order_id alone cannot uniquely identify
-- an order_items row.

-- ============================================================
-- SECTION 3: RELATIONSHIPS
-- ============================================================

-- 11.
-- One customer can have many orders.
-- Relationship: One-to-Many

-- 12.
-- One order can contain many products and one product
-- can appear in many orders.
-- Relationship: Many-to-Many

-- 13.
-- order_items acts as a junction table.

-- 14.
SELECT
c.customer_name,
o.order_id,
o.order_date
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
ORDER BY c.customer_name, o.order_date;

-- 15.
SELECT
o.order_id,
p.product_name,
oi.quantity
FROM orders o
JOIN order_items oi
ON o.order_id = oi.order_id
JOIN products p
ON oi.product_id = p.product_id
ORDER BY o.order_id;

-- 16.
SELECT
s.student_name,
c.course_name
FROM students s
JOIN enrollments e
ON s.student_id = e.student_id
JOIN courses c
ON e.course_id = c.course_id
ORDER BY s.student_name;

-- ============================================================
-- SECTION 4: FIRST NORMAL FORM
-- ============================================================

-- 17.
-- The courses column contains multiple values in one cell.
-- This violates atomic-value requirements of 1NF.

-- 18.
CREATE TABLE student_courses_1nf (
student_id INT,
student_name VARCHAR(100),
course_name VARCHAR(100)
);

INSERT INTO student_courses_1nf
VALUES
(1, 'Alice', 'SQL'),
(1, 'Alice', 'Python');

-- 19.
-- Multiple phone numbers stored in one column make searching,
-- validating, updating, and indexing individual numbers
-- more difficult.

-- 20.
CREATE TABLE student_phone_numbers (
student_id INT,
phone_number VARCHAR(20),

```
PRIMARY KEY (student_id, phone_number),

FOREIGN KEY (student_id)
    REFERENCES students(student_id)
```

);

-- ============================================================
-- SECTION 5: SECOND NORMAL FORM
-- ============================================================

-- 21.
-- Primary key:
-- (order_id, product_id)
-------------------------

## -- Partial dependencies:

-- order_id → order_date
-- product_id → product_name

-- 22.
-- order_date depends on order_id, not on the complete
-- (order_id, product_id) key.

-- 23.
-- product_name depends on product_id, not on the complete
-- (order_id, product_id) key.

-- 24.
-- Normalized design:
---------------------

-- orders(order_id, order_date)
-- products(product_id, product_name)
-- order_items(order_id, product_id, quantity)

-- 25.
-- quantity describes a specific product within a specific
-- order, so it depends on both order_id and product_id.

-- ============================================================
-- SECTION 6: THIRD NORMAL FORM
-- ============================================================

-- 26.
-- employee_id → department_id
-- department_id → department_name
----------------------------------

-- Therefore:
-- employee_id → department_name
--------------------------------

-- through department_id.

-- 27.
-- department_name describes the department, not the employee.

-- 28.
SELECT
e.employee_id,
e.employee_name,
d.department_name
FROM employees e
JOIN departments d
ON e.department_id = d.department_id;

-- 29.
-- Department information is stored once.
-- A department name change requires only one update.

-- 30.
-- employee_id → employee_name
-- employee_id → department_id
-- department_id → department_name

-- ============================================================
-- SECTION 7: ANOMALIES
-- ============================================================

-- 31.
-- Insert anomaly:
-- A new product may be difficult to store if the table
-- requires order information.

-- 32.
-- Update anomaly:
-- Changing a customer's phone number may require
-- updating multiple rows.

-- 33.
-- Delete anomaly:
-- Deleting the only order containing a product could
-- accidentally remove the only stored information about
-- that product.

-- 34.
-- Normalization stores each fact in an appropriate table,
-- reducing duplicate copies that must be updated.

-- 35.
-- Foreign keys prevent rows from referencing non-existent
-- parent records.

-- ============================================================
-- SECTION 8: FUNCTIONAL DEPENDENCIES
-- ============================================================

-- 36.
-- product_id → product_name
-- product_id → product_price

-- 37.
-- customer_id → customer_name
-- customer_id → customer_phone
-- customer_id → customer_city

-- 38.
-- employee_id determines department_id.
-- department_id determines department_name.
-- Therefore department_name is transitively dependent
-- on employee_id.

-- 39.
-- In a logical dependency chain, employee_id determines
-- department_name through department_id.
-- In the normalized design, department_name is stored
-- in departments rather than employees.

-- 40.
-- Direct dependency:
-- A directly determines B.
---------------------------

-- Transitive dependency:
-- A determines B, and B determines C,
-- so A determines C through B.

-- ============================================================
-- SECTION 9: CONSTRAINTS
-- ============================================================

-- 41.
INSERT INTO customers
(customer_name, customer_phone, customer_city)
VALUES
('David', '6543210987', 'Pune');

-- 42.
-- This should fail:
--------------------

-- INSERT INTO customers
--     (customer_name, customer_phone, customer_city)
-- VALUES
--     ('Another Alice', '9876543210', 'Delhi');

-- 43.
-- This should fail:
--------------------

-- INSERT INTO orders
-- VALUES
-- (999, 9999, '2026-03-01');

-- 44.
-- This should fail:
--------------------

-- INSERT INTO products
--     (product_name, product_price)
-- VALUES
-- ('Invalid Product', -100);

-- 45.
-- This should fail:
--------------------

-- INSERT INTO order_items
-- VALUES
-- (101, 1, 0);

-- ============================================================
-- SECTION 10: PRACTICAL NORMALIZATION
-- ============================================================

-- 46.
-- Problems:
-- 1. Customer information is repeated.
-- 2. Product information is repeated.
-- 3. Customer and product data are mixed with sale data.
-- 4. Updates can create inconsistent information.
-- 5. Insert/delete anomalies are possible.

-- 47.
-- Entities:
-- Customer
-- Product
-- Sale/Order
-- Sale Item/Order Item

-- 48.
-- A normalized schema:
-----------------------

-- customers(
--     customer_id,
--     customer_name,
--     customer_city
-- )
----

-- products(
--     product_id,
--     product_name,
--     product_price
-- )
----

-- orders(
--     order_id,
--     customer_id
-- )
----

-- order_items(
--     order_id,
--     product_id,
--     quantity
-- )

-- 49.
-- customers.customer_id
-- products.product_id
-- orders.order_id
-- order_items(order_id, product_id)

-- 50.
-- orders.customer_id → customers.customer_id
-- order_items.order_id → orders.order_id
-- order_items.product_id → products.product_id

-- ============================================================
-- SECTION 11: NORMALIZATION REVIEW
-- ============================================================

-- 51.
-- 1NF:
-- Values are appropriately atomic and repeating groups
-- are avoided.

-- 52.
-- 2NF:
-- 1NF plus removal of partial dependencies.

-- 53.
-- 3NF:
-- 2NF plus removal of inappropriate transitive dependencies.

-- 54.
-- BCNF requires every determinant to be a candidate key.

-- 55.
-- BCNF imposes a stronger dependency rule than 3NF.

-- 56.
-- Transactional databases frequently insert, update,
-- and delete data. Reducing redundancy helps maintain
-- consistency.

-- 57.
-- Denormalization may be useful for reporting, analytics,
-- read-heavy workloads, or reducing expensive joins.

-- 58.
-- Uncontrolled redundancy can create inconsistent data.
-- Therefore denormalization should have a clear reason.

-- 59.
-- An order total may be stored if business requirements
-- require preserving the historical calculated amount,
-- even if it could otherwise be calculated.

-- 60.
-- Example checklist:
---------------------

-- 1. Identify entities.
-- 2. Identify attributes.
-- 3. Define primary keys.
-- 4. Define foreign keys.
-- 5. Check relationships.
-- 6. Check 1NF.
-- 7. Check 2NF.
-- 8. Check 3NF.
-- 9. Add appropriate constraints.
-- 10. Review indexes and performance.
