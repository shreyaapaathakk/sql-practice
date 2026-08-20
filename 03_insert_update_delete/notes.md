# INSERT, UPDATE & DELETE

## 📖 Introduction

SQL is not only used to retrieve data. It can also be used to add new records, modify existing records, and remove records from tables.

The three important commands covered in this module are:

```text
INSERT → Add data
UPDATE → Modify data
DELETE → Remove data
```

These commands are part of SQL's **Data Manipulation Language (DML)**.

---

## 🧩 What Is DML?

DML stands for **Data Manipulation Language**.

DML commands are used to work with the data stored inside database tables.

Common DML commands include:

```text
INSERT
UPDATE
DELETE
```

`SELECT` is commonly discussed alongside DML because it retrieves data, although SQL classification can vary depending on the terminology being used.

---

# ➕ INSERT

The `INSERT` statement adds new records to a table.

---

## Basic INSERT Syntax

```sql
INSERT INTO table_name (column1, column2, column3)
VALUES (value1, value2, value3);
```

Example:

```sql
INSERT INTO students (
    student_id,
    first_name,
    age,
    city
)
VALUES (
    6,
    'Riya',
    20,
    'Kolkata'
);
```

---

## Inserting Multiple Records

Multiple rows can be inserted using a single statement:

```sql
INSERT INTO students (
    student_id,
    first_name,
    age,
    city
)
VALUES
    (7, 'Karan', 21, 'Delhi'),
    (8, 'Anjali', 19, 'Pune'),
    (9, 'Vikas', 22, 'Mumbai');
```

This is generally more convenient than executing separate `INSERT` statements.

---

## Inserting Data Into Selected Columns

You do not always have to provide values for every column.

```sql
INSERT INTO students (
    student_id,
    first_name
)
VALUES (
    10,
    'Meera'
);
```

Columns that are not specified will receive their default value, or `NULL` when allowed and no default exists.

> This works only when the omitted columns permit it.

---

## Inserting Values Without Listing Columns

You can write:

```sql
INSERT INTO students
VALUES (
    11,
    'Aarav',
    'Patel',
    20,
    'Surat'
);
```

However, explicitly listing columns is generally recommended because it makes the query clearer and safer.

---

# ✏️ UPDATE

The `UPDATE` statement modifies existing records.

---

## Basic UPDATE Syntax

```sql
UPDATE table_name
SET column1 = value1
WHERE condition;
```

Example:

```sql
UPDATE students
SET city = 'Varanasi'
WHERE student_id = 3;
```

This changes the city of the student whose ID is `3`.

---

## Updating Multiple Columns

You can update several columns at once:

```sql
UPDATE students
SET
    age = 21,
    city = 'Delhi'
WHERE student_id = 3;
```

---

## Updating Multiple Rows

An `UPDATE` can affect multiple records.

For example:

```sql
UPDATE students
SET city = 'Delhi'
WHERE city = 'New Delhi';
```

Every matching record will be updated.

---

## ⚠️ UPDATE Without WHERE

Be extremely careful with:

```sql
UPDATE students
SET city = 'Delhi';
```

Because there is no `WHERE` clause, **every row** in the table will be updated.

Always check your condition before executing an update.

---

# 🗑️ DELETE

The `DELETE` statement removes records from a table.

---

## Basic DELETE Syntax

```sql
DELETE FROM table_name
WHERE condition;
```

Example:

```sql
DELETE FROM students
WHERE student_id = 10;
```

This removes the student whose ID is `10`.

---

## Deleting Multiple Records

For example:

```sql
DELETE FROM students
WHERE age < 20;
```

Every student younger than 20 will be removed.

---

## ⚠️ DELETE Without WHERE

This command:

```sql
DELETE FROM students;
```

removes **all records** from the table.

The table itself remains.

This is different from:

```sql
DROP TABLE students;
```

which removes the table structure as well.

---

# 🔄 INSERT vs UPDATE vs DELETE

| Command  | Purpose                   |
| -------- | ------------------------- |
| `INSERT` | Adds new records          |
| `UPDATE` | Modifies existing records |
| `DELETE` | Removes records           |

Example:

```text
INSERT
   ↓
New record

UPDATE
   ↓
Existing record changes

DELETE
   ↓
Existing record removed
```

---

# 🧪 Using SELECT Before UPDATE or DELETE

A good habit is to check which rows will be affected before changing them.

Suppose you want to update students from Mumbai.

First run:

```sql
SELECT *
FROM students
WHERE city = 'Mumbai';
```

After confirming the correct rows, run:

```sql
UPDATE students
SET city = 'Pune'
WHERE city = 'Mumbai';
```

The same principle applies to `DELETE`.

First:

```sql
SELECT *
FROM students
WHERE age < 18;
```

Then, if the results are correct:

```sql
DELETE FROM students
WHERE age < 18;
```

This simple habit can prevent accidental data loss.

---

# 🔐 Using Transactions

For important changes, transactions can provide additional protection.

A transaction allows you to make changes and decide whether to keep or undo them.

Example:

```sql
START TRANSACTION;

UPDATE students
SET city = 'Delhi'
WHERE student_id = 3;

ROLLBACK;
```

`ROLLBACK` cancels the change.

If you are satisfied with the change, you can use:

```sql
START TRANSACTION;

UPDATE students
SET city = 'Delhi'
WHERE student_id = 3;

COMMIT;
```

`COMMIT` permanently saves the transaction's changes.

Transactions will be covered in more detail in a later advanced module.

---

# 📝 String Values

Text values should normally be enclosed in single quotes:

```sql
INSERT INTO students (first_name)
VALUES ('Rahul');
```

Incorrect:

```sql
INSERT INTO students (first_name)
VALUES (Rahul);
```

Numbers do not require quotes:

```sql
INSERT INTO students (age)
VALUES (20);
```

---

# 📅 Date Values

Dates can be inserted using the standard MySQL date format:

```sql
INSERT INTO employees (
    employee_id,
    hire_date
)
VALUES (
    101,
    '2026-08-20'
);
```

The standard format is:

```text
YYYY-MM-DD
```

---

# NULL Values

`NULL` represents a missing or unknown value.

Example:

```sql
INSERT INTO students (
    student_id,
    first_name,
    city
)
VALUES (
    12,
    'Rohan',
    NULL
);
```

You can explicitly insert `NULL` when the column permits it.

Remember:

```text
NULL ≠ 0
NULL ≠ ''
NULL ≠ FALSE
```

`NULL` represents the absence of a known value.

---

# ⚠️ Common Mistakes

## Forgetting WHERE in UPDATE

Dangerous:

```sql
UPDATE employees
SET salary = 50000;
```

This updates every employee.

Safer:

```sql
UPDATE employees
SET salary = 50000
WHERE employee_id = 101;
```

---

## Forgetting WHERE in DELETE

Dangerous:

```sql
DELETE FROM employees;
```

This removes every record.

Safer:

```sql
DELETE FROM employees
WHERE employee_id = 101;
```

---

## Using the Wrong Data Type

For example, text should normally be quoted:

```sql
'Delhi'
```

while numbers should normally not be:

```sql
20
```

---

## Updating the Wrong Rows

Always inspect the target rows first:

```sql
SELECT *
FROM employees
WHERE department = 'Sales';
```

Then perform the update.

---

# 🧠 Best Practices

### 1. Always use explicit column names with INSERT

Prefer:

```sql
INSERT INTO students (
    student_id,
    first_name,
    age
)
VALUES (
    1,
    'Rahul',
    20
);
```

over:

```sql
INSERT INTO students
VALUES (1, 'Rahul', 20);
```

### 2. Use WHERE with UPDATE

Unless you intentionally want to update every row.

### 3. Use WHERE with DELETE

Unless you intentionally want to remove every row.

### 4. Test your condition with SELECT

Before modifying important data, check:

```sql
SELECT *
FROM table_name
WHERE condition;
```

### 5. Use transactions for important operations

When appropriate, use:

```sql
START TRANSACTION;
```

and either:

```sql
COMMIT;
```

or:

```sql
ROLLBACK;
```

---

# 🎯 Learning Objectives

After completing this module, you should be able to:

* Explain DML.
* Insert individual records.
* Insert multiple records.
* Insert data into selected columns.
* Update existing records.
* Update multiple columns.
* Update multiple records.
* Delete individual records.
* Delete multiple records.
* Understand the risks of missing `WHERE`.
* Work with `NULL` values.
* Insert date values.
* Use `SELECT` to verify affected rows.
* Understand the basic purpose of transactions.

---

# 🚀 What's Next?

After learning how to add, modify, and remove data, the next module focuses on retrieving data in greater detail.

**Next Module: SELECT**
