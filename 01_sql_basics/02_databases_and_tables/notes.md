# Databases & Tables

## 📖 Introduction

A relational database organizes data into tables. Before working with records, it is important to understand how databases and tables are created, inspected, modified, and removed.

In this module, we will work with MySQL 8.0+ and learn the fundamental commands used to manage databases and table structures.

---

## 🗃️ What Is a Database?

A database is a structured collection of data.

A database can contain multiple related tables.

For example, an e-commerce database might contain:

```text
customers
products
orders
order_items
payments
```

Each table stores a specific type of information.

---

## 🏗️ Creating a Database

The `CREATE DATABASE` statement creates a new database.

```sql
CREATE DATABASE company;
```

You can then select the database:

```sql
USE company;
```

After selecting a database, newly created tables will belong to that database.

---

## ⚠️ CREATE DATABASE IF NOT EXISTS

If you try to create a database that already exists, MySQL will normally return an error.

To avoid this, use:

```sql
CREATE DATABASE IF NOT EXISTS company;
```

This tells MySQL to create the database only if it does not already exist.

---

## 🔍 Viewing Databases

To display all databases available on the MySQL server:

```sql
SHOW DATABASES;
```

This is useful when you want to verify whether a database exists.

---

## 🎯 Selecting a Database

Use the `USE` statement:

```sql
USE company;
```

You can check which database is currently selected with:

```sql
SELECT DATABASE();
```

If a database has not been selected, the result will be `NULL`.

---

## 🗑️ Deleting a Database

The `DROP DATABASE` statement permanently deletes a database.

```sql
DROP DATABASE company;
```

This removes the database and all tables and data inside it.

Because this operation can result in permanent data loss, use it carefully.

A safer version is:

```sql
DROP DATABASE IF EXISTS company;
```

---

# 📊 Tables

A table stores data in rows and columns.

For example:

```text
employees

+-------------+------------+-----------+
| employee_id | first_name | salary    |
+-------------+------------+-----------+
| 1           | Rahul      | 50000     |
| 2           | Priya      | 60000     |
+-------------+------------+-----------+
```

Each column represents an attribute, while each row represents a record.

---

## 🏗️ Creating a Table

Use `CREATE TABLE`:

```sql
CREATE TABLE employees (
    employee_id INT,
    first_name VARCHAR(50),
    salary DECIMAL(10, 2)
);
```

Each column definition contains:

```text
column_name data_type
```

For example:

```sql
employee_id INT
```

means that `employee_id` stores integer values.

---

## 🧩 Common Data Types

### INT

Used for whole numbers.

```sql
age INT
```

Examples:

```text
18
25
100
```

---

### VARCHAR

Used for variable-length text.

```sql
first_name VARCHAR(50)
```

The number represents the maximum character length.

---

### CHAR

Used for fixed-length text.

```sql
country_code CHAR(2)
```

This can be useful for values with a consistent length.

---

### DECIMAL

Used for precise numeric values, especially monetary values.

```sql
salary DECIMAL(10, 2)
```

The first number represents the total number of digits, while the second represents the number of digits after the decimal point.

For example:

```text
50000.00
1250.50
999999.99
```

---

### DATE

Used for dates.

```sql
date_of_birth DATE
```

Example:

```text
2005-08-17
```

---

### DATETIME

Used for date and time values.

```sql
created_at DATETIME
```

Example:

```text
2026-08-17 14:30:00
```

---

### BOOLEAN

Used for true/false values.

```sql
is_active BOOLEAN
```

In MySQL, `BOOLEAN` is effectively treated as a tiny integer type, where `TRUE` and `FALSE` can be used for readability.

---

# 🔎 Viewing Tables

Use:

```sql
SHOW TABLES;
```

This displays the tables in the currently selected database.

---

## 🧾 Viewing Table Structure

Use:

```sql
DESCRIBE employees;
```

or:

```sql
DESC employees;
```

This shows information such as:

* Column name
* Data type
* Whether NULL is allowed
* Key information
* Default value
* Extra information

---

## 📋 SHOW CREATE TABLE

To see the SQL statement used to create a table:

```sql
SHOW CREATE TABLE employees;
```

This is particularly useful when you want to inspect a table's complete definition.

---

# ✏️ Altering Tables

The `ALTER TABLE` statement modifies an existing table.

---

## ➕ Adding a Column

Suppose we want to add an email address:

```sql
ALTER TABLE employees
ADD email VARCHAR(100);
```

The table now contains the additional `email` column.

---

## ➕ Adding Multiple Columns

You can add multiple columns using separate `ADD` operations:

```sql
ALTER TABLE employees
ADD phone VARCHAR(20),
ADD department VARCHAR(50);
```

---

## ✏️ Modifying a Column

The `MODIFY COLUMN` statement changes a column's definition.

```sql
ALTER TABLE employees
MODIFY COLUMN first_name VARCHAR(100);
```

The maximum length of `first_name` has now been changed from 50 to 100 characters.

---

## 🔄 Renaming a Column

MySQL allows you to rename a column using `RENAME COLUMN`:

```sql
ALTER TABLE employees
RENAME COLUMN first_name TO given_name;
```

The column is now called `given_name`.

---

## 🗑️ Removing a Column

Use `DROP COLUMN`:

```sql
ALTER TABLE employees
DROP COLUMN phone;
```

The column and its data are removed from the table.

---

# 🔄 Renaming a Table

You can rename a table using:

```sql
RENAME TABLE employees TO staff;
```

The table is now called `staff`.

You can also use:

```sql
ALTER TABLE staff
RENAME TO employees;
```

---

# 🗑️ Deleting a Table

The `DROP TABLE` statement permanently removes a table.

```sql
DROP TABLE employees;
```

To avoid an error if the table does not exist:

```sql
DROP TABLE IF EXISTS employees;
```

Dropping a table removes its structure and data.

---

# 🧹 DELETE vs DROP

These commands are very different.

### DELETE

`DELETE` removes rows from a table.

```sql
DELETE FROM employees;
```

The table itself still exists.

### DROP

`DROP TABLE` removes the entire table.

```sql
DROP TABLE employees;
```

The table no longer exists.

---

# 🧹 DROP vs TRUNCATE

`TRUNCATE` removes all rows while keeping the table structure.

```sql
TRUNCATE TABLE employees;
```

Comparison:

| Command    | Removes Rows | Removes Table | Keeps Structure |
| ---------- | ------------ | ------------- | --------------- |
| `DELETE`   | Yes          | No            | Yes             |
| `TRUNCATE` | Yes          | No            | Yes             |
| `DROP`     | Yes          | Yes           | No              |

---

# 🔐 Temporary Tables

MySQL supports temporary tables.

```sql
CREATE TEMPORARY TABLE temporary_students (
    student_id INT,
    name VARCHAR(100)
);
```

A temporary table exists only for the current database session.

It is automatically removed when the session ends.

---

# 🧠 Naming Conventions

Good naming makes databases easier to understand.

Prefer:

```text
employee_id
first_name
date_of_birth
department_name
```

Avoid unclear names such as:

```text
id1
x
data
abc
```

For this repository, we generally use:

* lowercase names
* `snake_case`
* descriptive names
* consistent naming

Example:

```sql
CREATE TABLE employees (
    employee_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department_name VARCHAR(100),
    salary DECIMAL(10, 2)
);
```

---

# ⚠️ Common Mistakes

## Forgetting to Select a Database

You may create a database but forget:

```sql
USE company;
```

Always make sure the correct database is selected before creating tables.

---

## Using Invalid Data Types

Incorrect:

```sql
age TEXT
```

Although this may technically store numbers as text, it is usually inappropriate when the value represents an integer.

Prefer:

```sql
age INT
```

---

## Accidentally Dropping Data

Be careful with:

```sql
DROP DATABASE
```

and:

```sql
DROP TABLE
```

These commands can permanently remove data.

---

## Confusing DROP, DELETE, and TRUNCATE

Remember:

```text
DELETE    → removes rows
TRUNCATE  → removes all rows
DROP      → removes the table
```

---

# 🧠 Important Commands

Here are the main commands covered in this module:

```sql
CREATE DATABASE
SHOW DATABASES
USE
SELECT DATABASE()
DROP DATABASE

CREATE TABLE
SHOW TABLES
DESCRIBE
SHOW CREATE TABLE

ALTER TABLE
ADD
MODIFY COLUMN
RENAME COLUMN
DROP COLUMN

RENAME TABLE
DROP TABLE
TRUNCATE TABLE
CREATE TEMPORARY TABLE
```

---

# 🎯 Learning Objectives

After completing this module, you should be able to:

* Explain what a database is.
* Explain what a table is.
* Create a database.
* Select a database.
* List available databases.
* Create tables.
* Understand common MySQL data types.
* Inspect table structures.
* Modify existing tables.
* Add and remove columns.
* Rename tables and columns.
* Understand `DELETE`, `TRUNCATE`, and `DROP`.
* Create temporary tables.
* Use consistent database naming conventions.

---

# 🚀 What's Next?

After learning how databases and tables are structured, the next module focuses on manipulating the data stored inside them.

**Next Module: INSERT, UPDATE & DELETE**
