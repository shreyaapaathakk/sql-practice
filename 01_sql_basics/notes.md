# SQL Basics

## 📖 Introduction

SQL stands for **Structured Query Language**.

SQL is a standard language used to communicate with relational databases. It allows us to create databases and tables, store data, retrieve information, modify existing records, and manage relationships between different sets of data.

SQL is widely used in software development, data analysis, data engineering, business intelligence, and database administration.

---

## 🗃️ What Is a Database?

A database is an organized collection of data that can be stored, managed, and retrieved efficiently.

For example, a school database might contain information about:

* Students
* Teachers
* Courses
* Classes
* Exams
* Grades

A relational database stores this information in **tables**.

---

## 📊 What Is a Table?

A table stores related information in rows and columns.

For example:

| id | name  | age | city   |
| -: | ----- | --: | ------ |
|  1 | Rahul |  20 | Delhi  |
|  2 | Priya |  21 | Mumbai |
|  3 | Aman  |  19 | Jaipur |

Here:

* `id`, `name`, `age`, and `city` are **columns**.
* Each horizontal record is a **row**.
* The complete structure is a **table**.

---

## 🧩 Rows and Columns

### Column

A column represents a particular attribute of the data.

For example:

```text
name
age
city
```

Each column normally has a specific data type.

### Row

A row represents one complete record.

For example:

```text
1 | Rahul | 20 | Delhi
```

represents one student.

---

## 🔤 Common SQL Data Types

MySQL provides many data types.

Some commonly used types are:

| Data Type  | Purpose                 | Example                 |
| ---------- | ----------------------- | ----------------------- |
| `INT`      | Whole numbers           | `25`                    |
| `DECIMAL`  | Precise decimal numbers | `499.99`                |
| `VARCHAR`  | Variable-length text    | `'Rahul'`               |
| `CHAR`     | Fixed-length text       | `'IN'`                  |
| `DATE`     | Date values             | `'2026-08-17'`          |
| `DATETIME` | Date and time           | `'2026-08-17 10:30:00'` |
| `BOOLEAN`  | True/false values       | `TRUE`                  |

---

## 💻 What Is an SQL Query?

An SQL query is an instruction given to a database.

For example:

```sql
SELECT *
FROM students;
```

This asks the database to return all columns and rows from the `students` table.

---

## 🔎 The SELECT Statement

`SELECT` is used to retrieve data from a table.

### Select all columns

```sql
SELECT *
FROM students;
```

The `*` means all columns.

### Select specific columns

```sql
SELECT name, age
FROM students;
```

This returns only the `name` and `age` columns.

---

## 🏷️ SQL Keywords

SQL uses keywords to perform specific operations.

Common SQL keywords include:

```text
SELECT
FROM
WHERE
INSERT
UPDATE
DELETE
CREATE
ALTER
DROP
GROUP BY
ORDER BY
HAVING
JOIN
```

SQL keywords are generally written in uppercase for readability.

For example:

```sql
SELECT name
FROM students;
```

Although MySQL is generally case-insensitive for SQL keywords, using uppercase keywords makes queries easier to read.

---

## ✍️ SQL Statements

An SQL statement usually ends with a semicolon:

```sql
SELECT *
FROM students;
```

The semicolon indicates the end of the statement.

---

## 💬 SQL Comments

Comments allow you to explain SQL code without affecting its execution.

### Single-line comment

```sql
-- This query displays all students
SELECT *
FROM students;
```

### Another single-line style

```sql
# This query displays all students
SELECT *
FROM students;
```

### Multi-line comment

```sql
/*
This query displays
all students.
*/
SELECT *
FROM students;
```

Using comments is especially useful when creating educational SQL scripts.

---

## 🏗️ Creating a Database

The `CREATE DATABASE` statement creates a new database.

```sql
CREATE DATABASE school;
```

After creating a database, use it with:

```sql
USE school;
```

---

## 🗂️ Creating a Table

The `CREATE TABLE` statement creates a new table.

Example:

```sql
CREATE TABLE students (
    id INT,
    name VARCHAR(100),
    age INT,
    city VARCHAR(100)
);
```

This creates a `students` table with four columns.

---

## 🔍 Viewing Tables

To see the tables in the currently selected database:

```sql
SHOW TABLES;
```

---

## 🧾 Viewing Table Structure

You can inspect a table's structure using:

```sql
DESCRIBE students;
```

You can also use:

```sql
DESC students;
```

---

## ➕ Adding Data

The `INSERT INTO` statement adds records to a table.

```sql
INSERT INTO students (id, name, age, city)
VALUES (1, 'Rahul', 20, 'Delhi');
```

Multiple records can be inserted at once:

```sql
INSERT INTO students (id, name, age, city)
VALUES
    (2, 'Priya', 21, 'Mumbai'),
    (3, 'Aman', 19, 'Jaipur'),
    (4, 'Neha', 22, 'Pune');
```

---

## 🔎 Retrieving Data

After inserting data, retrieve it using `SELECT`.

```sql
SELECT *
FROM students;
```

Or select particular columns:

```sql
SELECT name, city
FROM students;
```

---

## 📝 SQL Naming Conventions

Clear names make databases easier to understand.

Prefer:

```text
student_id
first_name
last_name
date_of_birth
```

over unclear names such as:

```text
x
data1
abc
value
```

For this repository, we will generally use:

* lowercase table and column names
* `snake_case` for multi-word names
* descriptive names
* singular or consistent table naming

Example:

```sql
CREATE TABLE employees (
    employee_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department_id INT
);
```

---

## ⚠️ Common Beginner Mistakes

### Forgetting the semicolon

Incorrect:

```sql
SELECT *
FROM students
```

Better:

```sql
SELECT *
FROM students;
```

### Using the wrong table name

If the table is named:

```text
students
```

then this will fail:

```sql
SELECT *
FROM student;
```

### Forgetting quotes around text

Incorrect:

```sql
INSERT INTO students (name)
VALUES (Rahul);
```

Correct:

```sql
INSERT INTO students (name)
VALUES ('Rahul');
```

Text values should generally be enclosed in single quotes.

---

## 🧠 Important Concepts to Remember

Remember these basic ideas:

1. SQL is used to communicate with relational databases.
2. Databases can contain multiple tables.
3. Tables contain rows and columns.
4. Columns describe attributes.
5. Rows represent records.
6. SQL statements commonly end with `;`.
7. `SELECT` retrieves data.
8. `CREATE DATABASE` creates a database.
9. `CREATE TABLE` creates a table.
10. `INSERT INTO` adds records.
11. `SHOW TABLES` lists tables.
12. `DESCRIBE` shows table structure.

---

## 🎯 Learning Objective

After completing this module, you should be able to:

* Explain what SQL is.
* Explain what a relational database is.
* Understand tables, rows, and columns.
* Create a database.
* Select a database.
* Create a table.
* Understand basic SQL data types.
* Insert records.
* Retrieve records.
* Read basic SQL queries.
* Write simple SQL statements.
* Use comments in SQL code.

---

## 🚀 What's Next?

After learning the basics, the next module focuses on:

**Databases & Tables**

You will learn more about creating, modifying, inspecting, and managing database structures.
