# Module 27: Database Design & Normalization

Database design is the process of structuring data so that it is accurate, consistent, efficient, and easy to maintain.

Normalization is a systematic approach to organizing tables and relationships to reduce unnecessary data duplication and prevent data anomalies.

This module focuses on practical database design and normalization using MySQL 8.0+.

---

## 1. Why Database Design Matters

A poorly designed database can cause:

* Duplicate data
* Inconsistent information
* Difficult updates
* Accidental data loss
* Complex queries
* Poor data integrity
* Unnecessary storage usage

A well-designed database should make it easy to:

1. Store data accurately.
2. Retrieve data efficiently.
3. Update information consistently.
4. Maintain relationships between entities.
5. Enforce data integrity.

---

# 2. Understanding Entities

An entity represents something about which we want to store information.

Examples:

* Customer
* Employee
* Product
* Order
* Department
* Student
* Course

An entity usually becomes a table in a relational database.

For example:

```text
Customer
Product
Order
```

Each table should generally represent one meaningful entity or relationship.

---

# 3. Attributes

Attributes describe an entity.

For a `customers` table:

```text
Customer
---------
customer_id
first_name
last_name
email
phone
```

Here:

* `customer_id` is an identifier.
* `first_name` and `last_name` describe the customer.
* `email` and `phone` contain customer information.

Attributes normally become columns in a table.

---

# 4. Keys

Keys help uniquely identify records and establish relationships between tables.

## Primary Key

A primary key uniquely identifies each row.

Example:

```sql
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100)
);
```

Each `customer_id` must be:

* Unique
* Not NULL

---

## Candidate Key

A candidate key is a column or combination of columns that can uniquely identify a row.

Example:

```text
customer_id
email
```

If both are guaranteed to be unique, both can be candidate keys.

One candidate key is selected as the primary key.

---

## Alternate Key

A candidate key that is not selected as the primary key is an alternate key.

Example:

```text
customer_id → Primary Key
email       → Alternate Key
```

---

## Composite Key

A composite key consists of multiple columns.

Example:

```sql
CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    quantity INT,
    PRIMARY KEY (order_id, product_id)
);
```

The combination of `order_id` and `product_id` uniquely identifies each row.

---

## Foreign Key

A foreign key creates a relationship between tables.

Example:

```sql
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);
```

Here:

```text
customers.customer_id
        ↓
orders.customer_id
```

The foreign key helps maintain referential integrity.

---

# 5. Relationships Between Tables

Common relationship types include:

## One-to-One

One record in table A corresponds to one record in table B.

Example:

```text
Person → Passport
```

---

## One-to-Many

One record in table A can correspond to many records in table B.

Example:

```text
Customer → Orders
```

One customer can place many orders.

---

## Many-to-Many

Many records in table A can relate to many records in table B.

Example:

```text
Students ↔ Courses
```

A student can enroll in many courses, and a course can have many students.

A junction table is normally used:

```text
students
courses
enrollments
```

Example:

```sql
CREATE TABLE enrollments (
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    PRIMARY KEY (student_id, course_id)
);
```

---

# 6. Data Redundancy

Data redundancy occurs when the same information is unnecessarily stored multiple times.

Consider:

```text
order_id | customer_name | customer_phone | product
-----------------------------------------------------
101      | Alice         | 9876543210     | Laptop
102      | Alice         | 9876543210     | Mouse
103      | Alice         | 9876543210     | Keyboard
```

Alice's phone number is repeated.

If Alice changes her phone number, multiple rows may need to be updated.

This can create inconsistencies.

---

# 7. Data Anomalies

Poor database design can cause three major types of anomalies.

## 7.1 Insert Anomaly

An insert anomaly occurs when we cannot insert information without also inserting unrelated information.

Example:

Suppose a table stores:

```text
student_id
student_name
course_id
course_name
```

If a new course has no students yet, inserting the course may become difficult because the table expects student information.

---

## 7.2 Update Anomaly

An update anomaly occurs when the same information appears in multiple rows and must be changed everywhere.

Example:

```text
customer_id | customer_name | phone
------------------------------------
1           | Alice         | 111111
2           | Alice         | 111111
3           | Alice         | 111111
```

If Alice's phone changes, all three rows must be updated.

Missing one row creates inconsistent data.

---

## 7.3 Delete Anomaly

A delete anomaly occurs when deleting one piece of information accidentally removes another piece of information.

Example:

If the only student enrolled in a course is deleted, the course information may also disappear.

---

# 8. Functional Dependency

Functional dependency describes a relationship where one attribute determines another.

Notation:

```text
A → B
```

This means:

> A determines B.

Example:

```text
customer_id → customer_name
```

If we know the `customer_id`, we can determine the customer's name.

Another example:

```text
product_id → product_name, price
```

A product ID determines its name and price.

---

# 9. Full Functional Dependency

An attribute is fully functionally dependent on a composite key when it depends on the entire key, not just part of it.

Consider:

```text
(order_id, product_id) → quantity
```

The quantity depends on both:

```text
order_id
product_id
```

Neither column alone completely determines the quantity.

This concept becomes important when understanding Second Normal Form.

---

# 10. Partial Dependency

A partial dependency occurs when a non-key attribute depends on only part of a composite primary key.

Example:

```text
(order_id, product_id) → quantity
order_id → order_date
```

If the primary key is:

```text
(order_id, product_id)
```

then `order_date` depends only on `order_id`.

Therefore, `order_date` has a partial dependency on the composite key.

---

# 11. Transitive Dependency

A transitive dependency occurs when a non-key attribute depends on another non-key attribute.

Example:

```text
employee_id → department_id
department_id → department_name
```

Therefore:

```text
employee_id → department_name
```

The department name does not directly depend on the employee ID. It depends on `department_id`.

This is the main issue addressed by Third Normal Form.

---

# 12. Normalization

Normalization is the process of organizing data into related tables to reduce redundancy and improve data integrity.

The commonly discussed normal forms are:

```text
1NF
 ↓
2NF
 ↓
3NF
 ↓
BCNF
```

Each normal form introduces stronger rules for database structure.

---

# 13. First Normal Form (1NF)

A table is in First Normal Form when:

1. Each column contains atomic values.
2. There are no repeating groups.
3. Each row is uniquely identifiable.

## Bad Example

```text
student_id | student_name | courses
------------------------------------
1          | Alice        | SQL, Java, Python
```

The `courses` column contains multiple values.

---

## 1NF Example

Separate the values into rows:

```text
student_id | student_name | course
-----------------------------------
1          | Alice        | SQL
1          | Alice        | Java
1          | Alice        | Python
```

Now each cell contains a single value.

---

# 14. Atomic Values

Atomic means that a value should represent one logical value for the purposes of the relational design.

Bad example:

```text
phone_numbers
------------------------
9876543210, 8765432109
```

Better:

```text
customer_id | phone
--------------------
1           | 9876543210
1           | 8765432109
```

Or, if phone numbers represent a separate entity, use a separate related table.

---

# 15. Second Normal Form (2NF)

A table is in 2NF when:

1. It is already in 1NF.
2. Every non-key attribute is fully dependent on the entire primary key.

2NF primarily matters when the table has a composite primary key.

---

## Example of a Table Not in 2NF

Consider:

```text
order_id
product_id
order_date
product_name
quantity
```

Primary key:

```text
(order_id, product_id)
```

Dependencies:

```text
order_id → order_date
product_id → product_name
(order_id, product_id) → quantity
```

`order_date` depends only on `order_id`.

`product_name` depends only on `product_id`.

These are partial dependencies.

Therefore, the table is not in 2NF.

---

# 16. Converting to 2NF

Separate the data into appropriate tables.

### Orders

```text
order_id
order_date
```

### Products

```text
product_id
product_name
```

### Order Items

```text
order_id
product_id
quantity
```

Now:

```text
Orders
   ↓
Order Items
   ↓
Products
```

The order item quantity depends on the complete combination:

```text
(order_id, product_id)
```

---

# 17. Third Normal Form (3NF)

A table is in 3NF when:

1. It is already in 2NF.
2. There are no inappropriate transitive dependencies between non-key attributes.

A common simplified rule is:

> Non-key attributes should depend on the key, the whole key, and nothing but the key.

---

# 18. Example of a Table Not in 3NF

Consider:

```text
employee_id
employee_name
department_id
department_name
```

Dependencies:

```text
employee_id → employee_name
employee_id → department_id
department_id → department_name
```

Therefore:

```text
employee_id → department_id → department_name
```

`department_name` has a transitive dependency.

---

# 19. Converting to 3NF

Split the table.

### Employees

```text
employee_id
employee_name
department_id
```

### Departments

```text
department_id
department_name
```

Now:

```text
Employees.department_id
        ↓
Departments.department_id
```

Department information is stored once.

---

# 20. Boyce-Codd Normal Form (BCNF)

BCNF is a stronger version of 3NF.

A relation is in BCNF when:

> Every determinant is a candidate key.

In other words, whenever:

```text
A → B
```

then `A` must be a candidate key.

BCNF is useful when 3NF still allows certain dependency-related redundancies.

For most practical application databases, understanding 1NF, 2NF, and 3NF is essential. BCNF becomes particularly useful for advanced relational design.

---

# 21. Normalization Example

Suppose we have:

```text
student_id
student_name
course_id
course_name
instructor_id
instructor_name
```

A possible set of dependencies is:

```text
student_id → student_name
course_id → course_name, instructor_id
instructor_id → instructor_name
(student_id, course_id) → enrollment_details
```

This table contains information about multiple entities:

```text
Student
Course
Instructor
Enrollment
```

A normalized design could be:

### Students

```text
student_id
student_name
```

### Courses

```text
course_id
course_name
instructor_id
```

### Instructors

```text
instructor_id
instructor_name
```

### Enrollments

```text
student_id
course_id
enrollment_details
```

Each table focuses on a specific entity or relationship.

---

# 22. Normalization and Foreign Keys

Normalization commonly creates multiple related tables.

Foreign keys connect those tables.

Example:

```sql
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    department_id INT,
    FOREIGN KEY (department_id)
        REFERENCES departments(department_id)
);
```

This allows department information to be stored once.

---

# 23. Surrogate Keys

A surrogate key is an artificial identifier created specifically for database identification.

Example:

```sql
customer_id INT AUTO_INCREMENT PRIMARY KEY
```

The value has no business meaning.

Advantages include:

* Simple relationships
* Smaller foreign keys
* Stable identifiers
* Easier joins

---

# 24. Natural Keys

A natural key is an existing real-world attribute that uniquely identifies an entity.

Examples:

```text
email
ISBN
country_code
```

Natural keys can sometimes be useful, but they may change over time.

For example, a person's email address can change.

A surrogate key may therefore be preferable for many application databases.

---

# 25. Choosing Primary Keys

A good primary key should generally be:

* Unique
* Stable
* Minimal
* Not NULL
* Easy to reference

Example:

```sql
customer_id INT PRIMARY KEY AUTO_INCREMENT
```

Avoid using attributes that are likely to change as primary keys.

---

# 26. Denormalization

Denormalization intentionally introduces some redundancy into a database.

This can be useful for:

* Faster reads
* Reporting
* Analytics
* Reducing expensive joins
* Frequently accessed derived information

Example:

A normalized design might store:

```text
orders
customers
```

A reporting table might intentionally contain:

```text
order_id
customer_name
customer_city
order_total
order_date
```

This duplicates some information but can simplify reporting.

---

# 27. Normalization vs Denormalization

Normalization prioritizes:

```text
Data integrity
↓
Reduced redundancy
↓
Maintainability
```

Denormalization may prioritize:

```text
Read performance
↓
Simpler reporting
↓
Fewer joins
```

Denormalization should be intentional rather than the result of poor design.

---

# 28. OLTP and Normalization

OLTP stands for Online Transaction Processing.

Examples include:

* Banking systems
* E-commerce applications
* Booking systems
* Inventory systems

OLTP databases commonly benefit from normalized designs because they perform frequent:

```text
INSERT
UPDATE
DELETE
```

operations.

Reducing redundancy helps maintain consistency.

---

# 29. OLAP and Denormalization

OLAP stands for Online Analytical Processing.

Examples include:

* Business intelligence
* Data warehouses
* Reporting systems
* Analytical dashboards

Analytical systems may use denormalized structures such as:

```text
Star Schema
Snowflake Schema
```

These designs are optimized differently from typical transactional databases.

---

# 30. Entity Separation

A useful database design principle is:

> Store each important fact in the table where it naturally belongs.

For example, do not repeatedly store:

```text
department_name
department_location
department_manager
```

in every employee row.

Instead:

```text
departments
employees
```

with a foreign key relationship.

---

# 31. Avoid Storing Derived Data Unnecessarily

Suppose:

```text
quantity = 5
unit_price = 20
```

Then:

```text
total = 100
```

If `total` can always be calculated reliably, storing it may create redundancy.

Example:

```sql
SELECT quantity * unit_price AS total
FROM order_items;
```

However, storing derived values can sometimes be justified for performance, historical accuracy, or business requirements.

The decision should be intentional.

---

# 32. NULL and Database Design

NULL represents missing or unknown information.

Poor schema design can lead to excessive NULL values.

For example:

```text
employee_id
employee_name
student_id
student_name
customer_id
customer_name
```

A table like this may be mixing unrelated entities.

A better design separates the entities.

Use constraints where appropriate:

```sql
NOT NULL
UNIQUE
PRIMARY KEY
FOREIGN KEY
CHECK
```

---

# 33. Constraints and Data Integrity

Database design should use constraints to enforce rules.

## NOT NULL

Prevents missing values.

```sql
name VARCHAR(100) NOT NULL
```

## UNIQUE

Prevents duplicate values.

```sql
email VARCHAR(255) UNIQUE
```

## PRIMARY KEY

Uniquely identifies rows.

```sql
customer_id INT PRIMARY KEY
```

## FOREIGN KEY

Maintains relationships.

```sql
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id)
```

## CHECK

Enforces a condition.

```sql
CHECK (price >= 0)
```

---

# 34. Practical Normalization Workflow

When designing or improving a database, use the following process.

### Step 1: Identify Entities

Ask:

> What real-world things am I storing?

Example:

```text
Customers
Products
Orders
Employees
Departments
```

### Step 2: Identify Attributes

Determine what information belongs to each entity.

### Step 3: Identify Keys

Determine how each entity will be uniquely identified.

### Step 4: Identify Relationships

Determine whether relationships are:

```text
1:1
1:N
N:M
```

### Step 5: Identify Functional Dependencies

Determine which attributes depend on which keys.

### Step 6: Check 1NF

Ensure values are appropriately atomic and there are no repeating groups.

### Step 7: Check 2NF

Remove partial dependencies, especially from composite-key tables.

### Step 8: Check 3NF

Remove inappropriate transitive dependencies.

### Step 9: Add Constraints

Use:

```text
PRIMARY KEY
FOREIGN KEY
UNIQUE
NOT NULL
CHECK
```

### Step 10: Review Performance

Only after establishing a sound logical design should you consider indexes and intentional denormalization.

---

# 35. Example: Poorly Designed Table

Consider:

```text
order_id
customer_name
customer_phone
customer_city
product_name
product_price
quantity
```

Problems include:

* Customer information is repeated.
* Product information is repeated.
* Updating a product price may require many updates.
* Updating customer information may require many updates.
* Customer and product entities are mixed with order information.

---

# 36. Improved Design

A normalized design could contain:

### Customers

```text
customer_id
customer_name
customer_phone
customer_city
```

### Products

```text
product_id
product_name
product_price
```

### Orders

```text
order_id
customer_id
order_date
```

### Order Items

```text
order_id
product_id
quantity
```

Relationships:

```text
Customers
    │
    │ 1:N
    ▼
Orders
    │
    │ 1:N
    ▼
Order Items
    ▲
    │ N:1
Products
```

This structure separates different types of information.

---

# 37. Many-to-Many Relationships

Many-to-many relationships should normally be represented using a junction table.

Example:

```text
Students
   ↕
Enrollments
   ↕
Courses
```

The junction table might contain:

```text
student_id
course_id
enrollment_date
grade
```

Example:

```sql
CREATE TABLE enrollments (
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    grade CHAR(2),

    PRIMARY KEY (student_id, course_id),

    FOREIGN KEY (student_id)
        REFERENCES students(student_id),

    FOREIGN KEY (course_id)
        REFERENCES courses(course_id)
);
```

---

# 38. Normalization Does Not Mean "More Tables Are Always Better"

Normalization should be based on logical dependencies and business rules.

Do not split tables simply to increase the number of tables.

The goal is:

```text
Logical structure
+
Data integrity
+
Maintainability
+
Appropriate performance
```

A database with unnecessarily fragmented tables can make queries difficult and may introduce unnecessary joins.

---

# 39. Normalization Checklist

Before considering a schema well designed, ask:

### Entities

* Does each table represent a meaningful entity or relationship?
* Are unrelated concepts separated?

### Keys

* Does every table have an appropriate primary key?
* Are candidate keys identified?
* Are foreign keys correctly defined?

### 1NF

* Are values appropriately atomic?
* Are repeating groups avoided?

### 2NF

* Are partial dependencies removed?
* Do non-key attributes depend on the complete composite key?

### 3NF

* Are transitive dependencies removed?
* Does each non-key attribute depend on the appropriate key?

### Relationships

* Are one-to-many relationships represented correctly?
* Are many-to-many relationships handled using junction tables?

### Integrity

* Are `NOT NULL`, `UNIQUE`, `CHECK`, `PRIMARY KEY`, and `FOREIGN KEY` constraints used appropriately?

### Performance

* Are indexes added based on actual query patterns?
* Is denormalization intentional and justified?

---

# 40. Key Takeaways

Remember these core ideas:

```text
Database Design
      ↓
Identify Entities
      ↓
Identify Attributes
      ↓
Choose Keys
      ↓
Define Relationships
      ↓
Identify Dependencies
      ↓
Normalize
      ↓
Add Constraints
      ↓
Review Performance
```

The normal forms can be summarized as:

```text
1NF
→ Atomic values and no repeating groups

2NF
→ 1NF + no partial dependencies

3NF
→ 2NF + no inappropriate transitive dependencies

BCNF
→ Every determinant is a candidate key
```

The most important practical lesson is:

> Good database design stores each fact in the appropriate place and uses keys and relationships to connect related information.

Normalization is not simply about creating more tables. It is about creating a logical structure that minimizes unnecessary redundancy while preserving data integrity and making the database maintainable.
