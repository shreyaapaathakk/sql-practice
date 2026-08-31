# Module 16 — Views

Views are an important SQL feature for creating reusable queries. A view behaves like a virtual table that is based on the result of a `SELECT` statement.

Instead of repeatedly writing a long query, you can save the query as a view and later query the view using a normal `SELECT` statement.

This module introduces views from a beginner/intermediate perspective and focuses on practical MySQL 8.0+ usage.

---

## 1. What Is a View?

A **view** is a named SQL query that can be queried like a table.

A view does not normally store a separate copy of the result data. Instead, MySQL stores the definition of the view.

For example:

```sql
CREATE VIEW active_students AS
SELECT
    student_id,
    first_name,
    last_name,
    city
FROM students
WHERE age >= 20;
```

You can then query the view:

```sql
SELECT *
FROM active_students;
```

Conceptually:

```text
students table
      ↓
   SELECT query
      ↓
active_students view
      ↓
   SELECT from view
```

The view provides a reusable layer between the underlying tables and the person writing the query.

---

## 2. Why Are Views Useful?

Views are useful when a query is:

* Frequently reused
* Long or complicated
* Used for reporting
* Used by multiple people
* Useful as a simplified interface to underlying tables
* Intended to hide unnecessary columns
* Useful for restricting which rows users can see

For example, suppose an employee table contains many columns:

```text
employee_id
first_name
last_name
email
phone
salary
department_id
hire_date
address
date_of_birth
```

A reporting system may only need:

```text
employee_id
first_name
last_name
department_id
```

A view can expose only the columns needed by the report.

---

# 3. Creating a View

The basic syntax is:

```sql
CREATE VIEW view_name AS
SELECT
    column1,
    column2
FROM table_name
WHERE condition;
```

Example:

```sql
CREATE VIEW young_students AS
SELECT
    student_id,
    first_name,
    last_name,
    age
FROM students
WHERE age < 21;
```

Now:

```sql
SELECT *
FROM young_students;
```

queries the view.

---

# 4. Querying a View

A view can usually be queried like a table.

```sql
SELECT *
FROM young_students;
```

You can also select specific columns:

```sql
SELECT first_name, age
FROM young_students;
```

You can use filtering:

```sql
SELECT *
FROM young_students
WHERE age = 20;
```

You can also sort the result:

```sql
SELECT *
FROM young_students
ORDER BY age DESC;
```

The view provides the underlying result, and your new query can apply additional filtering or sorting.

---

# 5. View Based on One Table

The simplest views are based on a single table.

Example:

```sql
CREATE VIEW student_directory AS
SELECT
    student_id,
    first_name,
    last_name,
    city
FROM students;
```

Query it:

```sql
SELECT *
FROM student_directory;
```

This can be useful when you want a simplified representation of a table.

---

# 6. View with WHERE

A view can contain filtering conditions.

```sql
CREATE VIEW pune_students AS
SELECT
    student_id,
    first_name,
    last_name,
    city
FROM students
WHERE city = 'Pune';
```

Query:

```sql
SELECT *
FROM pune_students;
```

The `WHERE` condition is part of the view definition.

You can still apply another condition:

```sql
SELECT *
FROM pune_students
WHERE last_name = 'Gupta';
```

The effective result is based on both conditions.

---

# 7. View with Column Aliases

Views can contain aliases.

```sql
CREATE VIEW student_summary AS
SELECT
    student_id AS id,
    CONCAT(first_name, ' ', last_name) AS full_name,
    city AS location
FROM students;
```

Now:

```sql
SELECT *
FROM student_summary;
```

returns columns named:

```text
id
full_name
location
```

Aliases can make reporting views easier to understand.

---

# 8. View with Calculated Columns

A view can contain expressions and calculated columns.

Example:

```sql
CREATE VIEW employee_salary_summary AS
SELECT
    employee_id,
    first_name,
    salary,
    salary * 12 AS annual_salary
FROM employees;
```

The `annual_salary` column is calculated from the underlying salary value.

Query:

```sql
SELECT *
FROM employee_salary_summary;
```

Calculated columns are especially useful in reporting views.

---

# 9. View Based on Multiple Tables

A view does not have to use only one table.

It can use joins.

For example:

```sql
CREATE VIEW employee_department_details AS
SELECT
    e.employee_id,
    e.first_name,
    e.last_name,
    d.department_name
FROM employees AS e
INNER JOIN departments AS d
    ON e.department_id = d.department_id;
```

Now:

```sql
SELECT *
FROM employee_department_details;
```

returns employee and department information together.

This is useful when users frequently need related information from multiple tables.

---

# 10. Views with JOIN

A view can contain different types of joins.

For example:

```sql
CREATE VIEW customer_orders AS
SELECT
    c.customer_id,
    c.customer_name,
    o.order_id,
    o.order_date,
    o.total_amount
FROM customers AS c
INNER JOIN orders AS o
    ON c.customer_id = o.customer_id;
```

The view hides the join complexity.

Instead of repeatedly writing:

```sql
SELECT ...
FROM customers
JOIN orders
    ON ...
```

you can simply write:

```sql
SELECT *
FROM customer_orders;
```

---

# 11. Views with Aggregate Functions

Views can also contain aggregate functions.

Example:

```sql
CREATE VIEW department_salary_summary AS
SELECT
    department_id,
    COUNT(*) AS employee_count,
    AVG(salary) AS average_salary,
    MAX(salary) AS highest_salary
FROM employees
GROUP BY department_id;
```

Query:

```sql
SELECT *
FROM department_salary_summary;
```

This is useful for dashboards and reports.

---

# 12. Views with GROUP BY

A view can store grouped results.

Example:

```sql
CREATE VIEW city_student_counts AS
SELECT
    city,
    COUNT(*) AS student_count
FROM students
GROUP BY city;
```

You can then query:

```sql
SELECT *
FROM city_student_counts
ORDER BY student_count DESC;
```

The grouping happens inside the view.

---

# 13. CREATE OR REPLACE VIEW

If a view already exists, you can modify its definition using:

```sql
CREATE OR REPLACE VIEW view_name AS
SELECT ...
```

Example:

```sql
CREATE OR REPLACE VIEW student_directory AS
SELECT
    student_id,
    first_name,
    last_name,
    city,
    age
FROM students;
```

This replaces the existing definition.

It is often more convenient than dropping the view first.

---

# 14. DROP VIEW

To remove a view:

```sql
DROP VIEW view_name;
```

A safer version is:

```sql
DROP VIEW IF EXISTS view_name;
```

Example:

```sql
DROP VIEW IF EXISTS student_directory;
```

Dropping a view does not delete the underlying table data.

For example:

```sql
DROP VIEW IF EXISTS student_directory;
```

does not delete rows from:

```text
students
```

Only the view is removed.

---

# 15. SHOW CREATE VIEW

MySQL can display the SQL definition used to create a view.

```sql
SHOW CREATE VIEW student_directory;
```

This is useful when you want to inspect an existing view.

---

# 16. SHOW FULL TABLES

You can use:

```sql
SHOW FULL TABLES;
```

to see tables and views in the current database.

The result includes a column identifying whether an object is a:

```text
BASE TABLE
```

or:

```text
VIEW
```

This is useful when exploring a database.

---

# 17. INFORMATION_SCHEMA.VIEWS

MySQL provides metadata about views through:

```sql
INFORMATION_SCHEMA.VIEWS
```

For example:

```sql
SELECT
    TABLE_SCHEMA,
    TABLE_NAME,
    VIEW_DEFINITION
FROM INFORMATION_SCHEMA.VIEWS
WHERE TABLE_SCHEMA = DATABASE();
```

This can help you inspect views in the current database.

You can also search for one particular view:

```sql
SELECT
    TABLE_NAME,
    VIEW_DEFINITION
FROM INFORMATION_SCHEMA.VIEWS
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'student_directory';
```

---

# 18. Updating Data Through a View

Some views are **updatable**.

A simple view based on one table can often allow `UPDATE`, `INSERT`, or `DELETE` operations.

For example:

```sql
CREATE VIEW employee_contact AS
SELECT
    employee_id,
    first_name,
    last_name,
    email
FROM employees;
```

If the view is updatable, you may be able to execute:

```sql
UPDATE employee_contact
SET email = 'new@example.com'
WHERE employee_id = 101;
```

The change affects the underlying `employees` table.

This is important:

> A view is not necessarily a separate copy of the data.

Changes made through an updatable view can affect the underlying table.

Always understand the view definition before modifying data through it.

---

# 19. Simple Views Are More Likely to Be Updatable

A simple view such as:

```sql
CREATE VIEW employee_contact AS
SELECT
    employee_id,
    first_name,
    last_name,
    email
FROM employees;
```

is a good candidate for being updatable.

It directly exposes columns from one underlying table.

However, whether a view is updatable depends on its definition and the operation being attempted.

---

# 20. Limitations of Updatable Views

Not every view can be updated.

Views involving certain constructs are generally not suitable for direct updates.

Examples include views containing:

* Aggregate functions
* `GROUP BY`
* `DISTINCT`
* `UNION`
* Certain joins or complex expressions
* Some other query constructs that prevent a one-to-one relationship with underlying rows

For example:

```sql
CREATE VIEW department_summary AS
SELECT
    department_id,
    COUNT(*) AS employee_count
FROM employees
GROUP BY department_id;
```

This view represents grouped information.

There is no single underlying employee row corresponding directly to:

```text
department_id = 10
employee_count = 8
```

Therefore, treating this result as a directly editable employee record does not make sense.

---

# 21. Read-Only and Reporting Views

Many real-world views are created specifically for reading and reporting.

For example:

```sql
CREATE VIEW monthly_sales_report AS
SELECT
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    SUM(total_amount) AS total_sales
FROM orders
GROUP BY
    YEAR(order_date),
    MONTH(order_date);
```

A reporting system can query:

```sql
SELECT *
FROM monthly_sales_report;
```

The purpose is to make data easier to consume rather than to modify it.

---

# 22. Views for Security and Abstraction

Views can provide a layer of abstraction.

Suppose a table contains:

```text
employee_id
first_name
last_name
email
salary
bank_account
```

A reporting user may not need access to salary or bank account information.

A view could expose only:

```sql
CREATE VIEW employee_directory AS
SELECT
    employee_id,
    first_name,
    last_name,
    email
FROM employees;
```

The view provides a simpler interface.

Views can therefore help with:

* Data abstraction
* Simplifying queries
* Exposing only necessary columns
* Creating reporting interfaces
* Separating users from underlying table structure

However, views should not be treated as a complete security system by themselves. Proper database privileges are also important.

---

# 23. Views vs Tables

A table normally stores data physically.

A view normally stores a query definition and presents the result of that query.

| Feature                    | Table                   | View                      |
| -------------------------- | ----------------------- | ------------------------- |
| Stores rows                | Yes                     | Normally no separate copy |
| Stores query definition    | No                      | Yes                       |
| Can contain joins          | Data is stored directly | Yes                       |
| Can contain calculations   | Values may be stored    | Yes                       |
| Can be queried with SELECT | Yes                     | Yes                       |
| Can be updated             | Yes                     | Some views                |
| Useful for reporting       | Yes                     | Very useful               |

A view is therefore best thought of as a reusable query interface rather than simply another table.

---

# 24. Views vs Temporary Tables

A temporary table is different from a view.

A temporary table stores rows temporarily during a database session.

Example:

```sql
CREATE TEMPORARY TABLE temporary_students AS
SELECT *
FROM students
WHERE age >= 20;
```

A view is normally a persistent database object:

```sql
CREATE VIEW adult_students AS
SELECT *
FROM students
WHERE age >= 20;
```

Important differences:

| View                                           | Temporary Table                          |
| ---------------------------------------------- | ---------------------------------------- |
| Persistent database object                     | Temporary object                         |
| Stores query definition                        | Stores result rows                       |
| Usually available across sessions              | Exists only for the session              |
| Data comes from underlying tables when queried | Data was copied into the temporary table |
| Good for reusable queries                      | Good for temporary intermediate data     |

---

# 25. Views vs CTEs

A view and a Common Table Expression (CTE) can both make SQL easier to organize, but they serve different purposes.

A CTE is defined inside one SQL statement:

```sql
WITH high_value_orders AS (
    SELECT *
    FROM orders
    WHERE total_amount > 1000
)
SELECT *
FROM high_value_orders;
```

A view is stored as a database object:

```sql
CREATE VIEW high_value_orders AS
SELECT *
FROM orders
WHERE total_amount > 1000;
```

The key difference is scope.

A CTE is normally useful for one query.

A view can be reused by many queries.

---

# 26. Choosing Between a View, CTE, and Temporary Table

A useful beginner-level rule is:

Use a **view** when:

* A query is reused regularly.
* You want a persistent reporting interface.
* You want to simplify access to complex data.

Use a **CTE** when:

* You need to organize one query.
* You need an intermediate result only for that statement.
* You want readable multi-step query logic.

Use a **temporary table** when:

* You need temporary stored results.
* You need to perform multiple operations against intermediate data during a session.

---

# 27. Common Mistakes

## Mistake 1: Thinking a view is a normal stored copy of data

A normal view does not create an independent copy of the underlying table data.

---

## Mistake 2: Forgetting that the underlying data can change

Suppose:

```sql
CREATE VIEW active_students AS
SELECT *
FROM students
WHERE age >= 20;
```

If the `students` table changes, the result returned by the view can change as well.

---

## Mistake 3: Assuming every view is updatable

Complex views may not support direct updates.

Do not assume that:

```sql
UPDATE some_view
```

will always work.

---

## Mistake 4: Dropping the underlying table without considering dependent views

A view may depend on one or more tables.

Changing or removing those tables can affect the view.

Always understand dependencies before modifying database structures.

---

## Mistake 5: Creating too many unnecessary views

Views are useful, but creating a view for every small query can make a database difficult to understand.

Create views when they provide a clear benefit.

---

## Mistake 6: Exposing unnecessary sensitive columns

A view intended for reporting should expose only the information required for its purpose.

---

# 28. Best Practices

Use meaningful view names.

Good:

```text
active_students
employee_department_details
monthly_sales_report
customer_order_summary
```

Avoid vague names such as:

```text
view1
test_view
abc
```

Keep views focused on a clear purpose.

Use column aliases when they make reports easier to understand.

Document complicated views with comments or project documentation.

Avoid unnecessarily complex views when a simpler query would work.

Be careful when updating data through views.

Use `DROP VIEW IF EXISTS` when writing repeatable setup scripts.

Review dependencies before changing underlying tables.

Use views to simplify repeated reporting queries rather than using them merely because they are available.

---

# 29. Practical Example

Suppose we have:

```text
employees
departments
```

and frequently need:

```text
employee name
department name
salary
```

Instead of repeatedly writing:

```sql
SELECT
    e.first_name,
    e.last_name,
    d.department_name,
    e.salary
FROM employees AS e
INNER JOIN departments AS d
    ON e.department_id = d.department_id;
```

we can create:

```sql
CREATE VIEW employee_department_report AS
SELECT
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    d.department_name,
    e.salary
FROM employees AS e
INNER JOIN departments AS d
    ON e.department_id = d.department_id;
```

Now reporting queries become simpler:

```sql
SELECT *
FROM employee_department_report
ORDER BY salary DESC;
```

The view hides the join implementation from the person consuming the report.

---

# 30. Key Takeaways

A **view** is a named reusable SQL query.

Use:

```sql
CREATE VIEW
```

to create a view.

Use:

```sql
CREATE OR REPLACE VIEW
```

to replace its definition.

Use:

```sql
SELECT
```

to query a view.

Use:

```sql
DROP VIEW
```

to remove a view.

Use:

```sql
SHOW CREATE VIEW
```

to inspect its definition.

Use:

```sql
SHOW FULL TABLES
```

to distinguish tables and views.

Use:

```sql
INFORMATION_SCHEMA.VIEWS
```

to inspect view metadata.

Views can be based on:

* One table
* Multiple tables
* Joins
* Filters
* Calculated columns
* Aggregate functions
* `GROUP BY`

Some simple views can be updated, but complex views may not be updatable.

Views are especially useful for:

* Reusable queries
* Reporting
* Abstraction
* Simplifying complex SQL
* Presenting only the data needed by consumers

Remember the distinction:

```text
VIEW
    Persistent reusable query definition

CTE
    Query-scoped intermediate result

TEMPORARY TABLE
    Session-scoped temporary stored rows
```

A good SQL developer does not create views simply because they can. Views should have a clear purpose and should make the database easier to use, maintain, or understand.
