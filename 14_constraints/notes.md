Absolutely. We’ll continue with **Module 14 — Constraints** using the same repository structure and MySQL 8.0+ syntax.

The focus here is on protecting data integrity at the database level. This module will prepare you for foreign keys and more realistic relational database design.

## Repository structure

```text
14_constraints/
├── notes.md
├── examples.sql
├── practice.sql
├── solutions.sql
└── challenge.sql
```

## `14_constraints/notes.md`

````markdown
# Module 14 — Constraints

## Overview

SQL constraints are rules applied to table columns to control what data can be stored.

Constraints help maintain:

- data accuracy
- data consistency
- data integrity
- valid relationships between tables
- reliable database structure

Instead of relying only on application code to prevent invalid data, constraints allow the database itself to enforce important rules.

This module uses MySQL 8.0+ syntax.

---

# 1. What Is a Constraint?

A constraint is a rule that restricts the values that can be inserted or updated in a table.

For example:

```sql
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL
);
````

Here:

```text
PRIMARY KEY
NOT NULL
```

are constraints.

The database will reject data that violates these rules.

---

# 2. Why Constraints Matter

Without constraints, a table could contain invalid or inconsistent data.

For example:

```text
student_id
1
1
1
NULL
```

If `student_id` is supposed to uniquely identify each student, this would be a problem.

A primary key can prevent duplicate and NULL identifiers.

Constraints move important validation rules into the database.

---

# 3. Main Constraints in MySQL

Important constraints include:

| Constraint  | Purpose                                   |
| ----------- | ----------------------------------------- |
| PRIMARY KEY | Uniquely identifies each row              |
| FOREIGN KEY | Establishes a relationship between tables |
| NOT NULL    | Prevents NULL values                      |
| UNIQUE      | Prevents duplicate values                 |
| DEFAULT     | Provides a value when none is supplied    |
| CHECK       | Restricts values according to a condition |

---

# 4. PRIMARY KEY

A primary key uniquely identifies each row.

Example:

```sql
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);
```

Here:

```text
student_id
```

is the primary key.

---

# 5. Primary Key Rules

A primary key:

* must be unique
* cannot contain NULL
* identifies a row
* can consist of one column or multiple columns

For example:

```sql
INSERT INTO students
VALUES (1, 'Rahul', 'Sharma');
```

is valid.

But:

```sql
INSERT INTO students
VALUES (1, 'Aman', 'Verma');
```

fails because `student_id = 1` already exists.

---

# 6. Primary Key and NULL

This is invalid:

```sql
INSERT INTO students
VALUES (NULL, 'Aman', 'Verma');
```

A primary key cannot contain NULL.

---

# 7. Defining a Primary Key After Table Creation

A primary key can also be added using `ALTER TABLE`.

```sql
ALTER TABLE students
ADD PRIMARY KEY (student_id);
```

The existing column must contain valid unique, non-NULL values.

---

# 8. Removing a Primary Key

You can remove a primary key using:

```sql
ALTER TABLE students
DROP PRIMARY KEY;
```

Be careful when doing this because the table will no longer have that primary-key constraint.

---

# 9. Composite Primary Keys

A primary key can contain multiple columns.

Example:

```sql
CREATE TABLE enrollments (
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    PRIMARY KEY (student_id, course_id)
);
```

The combination of:

```text
student_id + course_id
```

must be unique.

The same student can enroll in multiple courses, and the same course can have multiple students.

But the same student cannot enroll in the same course twice.

---

# 10. NOT NULL

`NOT NULL` prevents a column from storing NULL.

Example:

```sql
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL
);
```

This is invalid:

```sql
INSERT INTO students
    (student_id, first_name)
VALUES
    (1, NULL);
```

---

# 11. NOT NULL vs PRIMARY KEY

A primary key automatically cannot contain NULL.

For example:

```sql
student_id INT PRIMARY KEY
```

already guarantees that `student_id` is not NULL.

However, `NOT NULL` can be applied to other columns where a value is required.

Example:

```sql
email VARCHAR(100) NOT NULL
```

---

# 12. UNIQUE

`UNIQUE` prevents duplicate values in a column.

Example:

```sql
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    email VARCHAR(100) UNIQUE
);
```

Two users cannot have the same email address.

---

# 13. UNIQUE vs PRIMARY KEY

Both enforce uniqueness, but they serve different purposes.

A primary key:

* identifies the row
* cannot be NULL
* is normally the main identifier

A UNIQUE constraint:

* prevents duplicate values
* is used for other values that must remain unique
* can allow NULL values in MySQL

Example:

```sql
user_id INT PRIMARY KEY,
email VARCHAR(100) UNIQUE
```

---

# 14. Multiple UNIQUE Constraints

A table can have multiple UNIQUE constraints.

Example:

```sql
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    email VARCHAR(100) UNIQUE,
    username VARCHAR(50) UNIQUE
);
```

Both email and username must be unique.

---

# 15. DEFAULT

`DEFAULT` provides a value when an INSERT does not specify one.

Example:

```sql
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    status VARCHAR(20) DEFAULT 'Active'
);
```

Now:

```sql
INSERT INTO students
    (student_id, first_name)
VALUES
    (1, 'Rahul');
```

automatically assigns:

```text
status = Active
```

---

# 16. Explicitly Providing a Value

A default value is used when the column is omitted.

You can still provide a different value:

```sql
INSERT INTO students
    (student_id, first_name, status)
VALUES
    (2, 'Priya', 'Inactive');
```

The default is not used in this case.

---

# 17. CHECK

`CHECK` restricts values according to a condition.

Example:

```sql
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    age INT CHECK (age >= 16)
);
```

The database rejects an age below 16.

---

# 18. CHECK With a Range

```sql
CREATE TABLE exams (
    exam_id INT PRIMARY KEY,
    marks INT CHECK (marks BETWEEN 0 AND 100)
);
```

Valid:

```text
85
```

Invalid:

```text
120
```

---

# 19. CHECK With Multiple Conditions

You can create more complex rules.

```sql
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    age INT CHECK (age >= 18),
    salary DECIMAL(10,2) CHECK (salary >= 0)
);
```

Both conditions must be satisfied.

---

# 20. Named Constraints

Constraints can be given names.

Example:

```sql
CREATE TABLE students (
    student_id INT,
    age INT,
    CONSTRAINT chk_student_age
        CHECK (age >= 16)
);
```

Naming constraints makes database maintenance easier.

---

# 21. FOREIGN KEY

A foreign key creates a relationship between two tables.

Suppose we have:

```text
departments
```

and:

```text
students
```

A student can belong to a department.

The department ID in `students` can reference the department ID in `departments`.

---

# 22. Parent and Child Tables

In a foreign-key relationship:

```text
departments
```

is the parent table.

```text
students
```

is the child table.

Example:

```sql
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL
);
```

Then:

```sql
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    department_id INT,
    FOREIGN KEY (department_id)
        REFERENCES departments(department_id)
);
```

---

# 23. Foreign Key Integrity

Suppose departments contain:

```text
1 → Computer Science
2 → Mathematics
3 → Physics
```

A student can reference:

```text
1
2
3
```

but normally cannot reference:

```text
99
```

if department 99 does not exist.

This prevents orphan references.

---

# 24. Foreign Key and NULL

A foreign-key column can generally contain NULL unless it is also declared `NOT NULL`.

Example:

```sql
department_id INT
```

allows NULL.

This can represent a student who currently has no department assigned.

If every student must belong to a department:

```sql
department_id INT NOT NULL
```

can be used.

---

# 25. Adding a Foreign Key With ALTER TABLE

You can add a foreign key after creating the table.

```sql
ALTER TABLE students
ADD CONSTRAINT fk_student_department
FOREIGN KEY (department_id)
REFERENCES departments(department_id);
```

---

# 26. Dropping a Foreign Key

If the constraint is named:

```sql
fk_student_department
```

you can remove it:

```sql
ALTER TABLE students
DROP FOREIGN KEY fk_student_department;
```

---

# 27. ON DELETE CASCADE

Foreign keys can define what happens when a referenced parent row is deleted.

Example:

```sql
FOREIGN KEY (department_id)
REFERENCES departments(department_id)
ON DELETE CASCADE
```

If a department is deleted, related student rows may also be deleted.

Use this carefully.

---

# 28. ON DELETE SET NULL

Another option is:

```sql
FOREIGN KEY (department_id)
REFERENCES departments(department_id)
ON DELETE SET NULL
```

If the department is deleted, the student's `department_id` becomes NULL.

The foreign-key column must allow NULL.

---

# 29. ON DELETE RESTRICT

You can prevent deletion of a parent row that is still referenced.

```sql
FOREIGN KEY (department_id)
REFERENCES departments(department_id)
ON DELETE RESTRICT
```

This protects related child records.

---

# 30. ON UPDATE CASCADE

You can also control what happens when a referenced key changes.

```sql
FOREIGN KEY (department_id)
REFERENCES departments(department_id)
ON UPDATE CASCADE
```

If the referenced department ID changes, the child value can be updated automatically.

---

# 31. Referential Integrity

Referential integrity means relationships between tables remain valid.

For example:

```text
departments
     ↓
students
```

A student's `department_id` should reference an existing department.

Foreign keys enforce this relationship.

---

# 32. AUTO_INCREMENT

`AUTO_INCREMENT` is commonly used with integer primary keys.

Example:

```sql
CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL
);
```

When inserting:

```sql
INSERT INTO students
    (first_name)
VALUES
    ('Rahul');
```

MySQL automatically generates the student ID.

---

# 33. AUTO_INCREMENT Is Not a Constraint

`AUTO_INCREMENT` controls how MySQL generates numeric values.

It does not itself guarantee that a column is a primary key.

It is commonly combined with:

```sql
PRIMARY KEY
```

---

# 34. Combining Multiple Constraints

A realistic table can use several constraints.

Example:

```sql
CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    age INT CHECK (age >= 16),
    status VARCHAR(20) DEFAULT 'Active',
    department_id INT,
    FOREIGN KEY (department_id)
        REFERENCES departments(department_id)
);
```

Here the table uses:

* PRIMARY KEY
* NOT NULL
* UNIQUE
* CHECK
* DEFAULT
* FOREIGN KEY

---

# 35. Constraint Order in Table Design

A good table definition often follows a readable order:

```sql
CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    age INT CHECK (age >= 16),
    status VARCHAR(20) DEFAULT 'Active',
    department_id INT,
    FOREIGN KEY (department_id)
        REFERENCES departments(department_id)
);
```

Keep related constraints close to the columns they affect when possible.

---

# 36. Inspecting Constraints

Use:

```sql
SHOW CREATE TABLE students;
```

This displays the table definition, including constraints.

It is an important debugging and learning tool.

---

# 37. Information Schema

MySQL provides metadata through `INFORMATION_SCHEMA`.

For example:

```sql
SELECT
    CONSTRAINT_NAME,
    CONSTRAINT_TYPE
FROM information_schema.TABLE_CONSTRAINTS
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'students';
```

This can help inspect constraints programmatically.

---

# 38. Constraint Violations

If an INSERT or UPDATE violates a constraint, MySQL rejects the operation.

For example, a duplicate primary key:

```sql
INSERT INTO students
VALUES (1, 'Rahul');
```

when ID 1 already exists will fail.

Similarly, an invalid foreign-key reference can fail.

---

# 39. Constraints and UPDATE

Constraints apply to updates too.

Suppose:

```sql
age INT CHECK (age >= 16)
```

Then:

```sql
UPDATE students
SET age = 10
WHERE student_id = 1;
```

can be rejected because the new value violates the CHECK condition.

---

# 40. Constraints and DELETE

Deleting data can also be affected by foreign keys.

For example, if a department is referenced by students, deleting that department may fail when the foreign key uses restrictive behavior.

This prevents accidental breaking of relationships.

---

# 41. Choosing NOT NULL

Use `NOT NULL` when a value is required for every row.

Good examples:

```text
first_name
created_at
product_name
order_date
```

Do not automatically use `NOT NULL` everywhere.

Some information may legitimately be unknown.

---

# 42. Choosing UNIQUE

Use `UNIQUE` when duplicate values are not allowed.

Common examples:

```text
email
username
employee_number
registration_number
```

---

# 43. Choosing CHECK

Use `CHECK` for business rules that can be expressed as conditions.

Examples:

```sql
CHECK (age >= 18)
```

```sql
CHECK (salary >= 0)
```

```sql
CHECK (status IN ('Active', 'Inactive'))
```

---

# 44. Choosing DEFAULT

Use `DEFAULT` when a sensible value should automatically be used when no value is supplied.

Examples:

```sql
status VARCHAR(20) DEFAULT 'Active'
```

```sql
quantity INT DEFAULT 1
```

---

# 45. Choosing FOREIGN KEY

Use a foreign key when one table references another table.

For example:

```text
orders.customer_id
```

can reference:

```text
customers.customer_id
```

This ensures that an order refers to a valid customer.

---

# 46. Primary Key vs Unique

A table can have:

```text
one primary key
```

but can have:

```text
multiple UNIQUE constraints
```

Example:

```sql
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    username VARCHAR(50) UNIQUE,
    email VARCHAR(100) UNIQUE
);
```

The primary key identifies the user.

The unique constraints prevent duplicate usernames and emails.

---

# 47. Constraint Design Example

Imagine an employee table.

Requirements:

* every employee needs an ID
* employee name is required
* email must be unique
* age must be at least 18
* status defaults to Active

A suitable design is:

```sql
CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    age INT CHECK (age >= 18),
    status VARCHAR(20) DEFAULT 'Active'
);
```

The constraints directly represent the requirements.

---

# 48. Real-World Example

Consider an online store.

Customers:

```text
customer_id
name
email
```

Orders:

```text
order_id
customer_id
order_date
```

A foreign key can ensure that every order references an existing customer.

```sql
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id)
```

This is one of the most important uses of constraints in relational databases.

---

# 49. Common Mistakes

## Mistake 1: Using UNIQUE instead of PRIMARY KEY

A unique column is not automatically the main row identifier.

---

## Mistake 2: Forgetting NOT NULL

If a value is mandatory, explicitly enforce it.

---

## Mistake 3: Using CHECK for application-only logic

Some business rules are better handled in application code, especially rules involving multiple tables or external systems.

---

## Mistake 4: Using CASCADE without understanding it

`ON DELETE CASCADE` can delete related rows automatically.

Use it only when that behavior is actually desired.

---

## Mistake 5: Creating invalid foreign-key data

The referenced parent row normally needs to exist before the child row can reference it.

---

## Mistake 6: Adding constraints to dirty data

Before adding a constraint to an existing table, inspect the existing data.

For example, before adding:

```sql
UNIQUE (email)
```

check for duplicates.

---

# 50. Practical Constraint Checklist

Before creating a table, ask:

1. What uniquely identifies each row?
2. Which columns are required?
3. Which values must be unique?
4. Which values have sensible defaults?
5. Which values have valid ranges?
6. Which tables should this table reference?
7. What should happen when a referenced row is deleted?
8. What should happen when a referenced key changes?

These questions lead to better database designs.

---

# 51. Key Takeaways

By the end of this module, you should understand:

* what constraints are
* why constraints are important
* PRIMARY KEY
* composite primary keys
* NOT NULL
* UNIQUE
* DEFAULT
* CHECK
* FOREIGN KEY
* referential integrity
* AUTO_INCREMENT
* ON DELETE CASCADE
* ON DELETE SET NULL
* ON DELETE RESTRICT
* ON UPDATE CASCADE
* adding and removing constraints
* inspecting constraints
* designing tables with multiple constraints
