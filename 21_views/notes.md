# Module 21 — SQL Views

A **View** is a virtual table based on the result of a SQL query.

Instead of repeatedly writing a complicated query, you can save the query as a view and query the view like a table.

This module uses MySQL 8.0+ syntax.

---

## 1. What Is a View?

A view is created from a SELECT statement.

Basic syntax:

```sql
CREATE VIEW view_name AS
SELECT ...
FROM ...;
```

After creating it, you can query it:

```sql
SELECT *
FROM view_name;
```

A view normally does not store the result data itself. It stores the query definition.

---

## 2. Why Use Views?

Views are useful for:

* Simplifying complex queries.
* Reusing frequently needed queries.
* Hiding unnecessary columns.
* Controlling access to data.
* Creating reporting layers.
* Improving consistency.
* Making analytical queries easier to use.

For example, instead of repeatedly writing:

```sql
SELECT
    e.first_name,
    e.salary,
    d.department_name
FROM employees AS e
JOIN departments AS d
    ON e.department_id = d.department_id;
```

you can create:

```sql
CREATE VIEW employee_details AS
SELECT
    e.first_name,
    e.salary,
    d.department_name
FROM employees AS e
JOIN departments AS d
    ON e.department_id = d.department_id;
```

Then simply use:

```sql
SELECT *
FROM employee_details;
```

---

# 3. Creating a View

Example:

```sql
CREATE VIEW high_salary_employees AS
SELECT
    employee_id,
    first_name,
    salary
FROM employees
WHERE salary > 60000;
```

Now:

```sql
SELECT *
FROM high_salary_employees;
```

returns employees earning more than 60,000.

---

# 4. View Names

Choose descriptive names.

Good:

```text
employee_details
high_salary_employees
department_summary
customer_orders
customer_spending
```

Avoid vague names such as:

```text
v1
data
test
abc
```

Clear names make databases easier to understand.

---

# 5. Querying a View

A view can be queried just like a table.

```sql
SELECT *
FROM employee_details;
```

You can also select specific columns:

```sql
SELECT
    first_name,
    salary
FROM employee_details;
```

---

# 6. Filtering a View

You can apply a WHERE clause to a view.

```sql
SELECT *
FROM employee_details
WHERE salary > 70000;
```

The view provides the base result, and the outer query applies additional filtering.

---

# 7. Sorting a View

```sql
SELECT *
FROM employee_details
ORDER BY salary DESC;
```

The final query controls the ordering of the returned result.

---

# 8. Creating a View with JOIN

Views can contain joins.

```sql
CREATE VIEW employee_details AS
SELECT
    e.employee_id,
    e.first_name,
    e.last_name,
    e.salary,
    d.department_name
FROM employees AS e
JOIN departments AS d
    ON e.department_id = d.department_id;
```

Now:

```sql
SELECT *
FROM employee_details;
```

provides employee and department information without requiring the user to remember the JOIN.

---

# 9. Creating a View with Aggregation

Views can contain GROUP BY and aggregate functions.

```sql
CREATE VIEW department_salary_summary AS
SELECT
    department_id,
    COUNT(*) AS employee_count,
    SUM(salary) AS total_salary,
    AVG(salary) AS average_salary
FROM employees
GROUP BY department_id;
```

Query:

```sql
SELECT *
FROM department_salary_summary;
```

---

# 10. Creating a View with CASE

A view can contain calculated classifications.

```sql
CREATE VIEW employee_salary_categories AS
SELECT
    employee_id,
    first_name,
    salary,
    CASE
        WHEN salary >= 80000 THEN 'High'
        WHEN salary >= 60000 THEN 'Medium'
        ELSE 'Low'
    END AS salary_category
FROM employees;
```

Then:

```sql
SELECT *
FROM employee_salary_categories;
```

---

# 11. Creating a View with Window Functions

Views can contain window functions.

```sql
CREATE VIEW employee_rankings AS
SELECT
    employee_id,
    first_name,
    department_id,
    salary,
    RANK() OVER (
        PARTITION BY department_id
        ORDER BY salary DESC
    ) AS department_rank
FROM employees;
```

Now you can query:

```sql
SELECT *
FROM employee_rankings
WHERE department_rank <= 2;
```

This is particularly useful for reporting.

---

# 12. Views and CTEs

CTEs and views are related concepts but have an important difference.

A CTE:

```sql
WITH employee_data AS (...)
SELECT ...
```

exists only for the duration of one SQL statement.

A View:

```sql
CREATE VIEW employee_data AS
SELECT ...;
```

is stored as a database object and can be reused by later queries.

Think:

```text
CTE
→ temporary query-level definition

VIEW
→ reusable database-level definition
```

---

# 13. CTE vs View

Example CTE:

```sql
WITH high_salary AS (
    SELECT *
    FROM employees
    WHERE salary > 60000
)
SELECT *
FROM high_salary;
```

The CTE disappears after the statement finishes.

Example View:

```sql
CREATE VIEW high_salary AS
SELECT *
FROM employees
WHERE salary > 60000;
```

It can then be reused:

```sql
SELECT *
FROM high_salary;
```

and later:

```sql
SELECT COUNT(*)
FROM high_salary;
```

---

# 14. View vs Table

A table stores data.

A view stores a query definition.

Conceptually:

```text
TABLE
→ stores data

VIEW
→ stores a SELECT definition
```

For example:

```sql
CREATE TABLE employees (...);
```

creates a physical table.

Whereas:

```sql
CREATE VIEW employee_details AS
SELECT ...
FROM employees;
```

creates a virtual representation based on the underlying data.

---

# 15. Creating a View with `CREATE OR REPLACE`

If a view already exists, you can replace its definition.

```sql
CREATE OR REPLACE VIEW employee_details AS
SELECT
    employee_id,
    first_name,
    salary
FROM employees;
```

This is useful when updating an existing view.

---

# 16. Dropping a View

To remove a view:

```sql
DROP VIEW employee_details;
```

Safer:

```sql
DROP VIEW IF EXISTS employee_details;
```

This prevents an error if the view does not exist.

---

# 17. Viewing Existing Views

MySQL allows you to inspect available tables and views.

```sql
SHOW FULL TABLES;
```

You can identify views using the table type.

You can also inspect the definition:

```sql
SHOW CREATE VIEW employee_details;
```

This displays the SQL definition used to create the view.

---

# 18. Views with Aliases

Always use meaningful column aliases for calculated columns.

Example:

```sql
CREATE VIEW department_summary AS
SELECT
    department_id,
    COUNT(*) AS employee_count,
    AVG(salary) AS average_salary
FROM employees
GROUP BY department_id;
```

This makes the view easier to query.

---

# 19. Views with Multiple Tables

A view can combine several tables.

Example:

```sql
CREATE VIEW customer_order_details AS
SELECT
    c.customer_id,
    c.customer_name,
    o.order_id,
    o.order_date,
    o.total_amount
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id;
```

Now:

```sql
SELECT *
FROM customer_order_details;
```

provides a simplified reporting dataset.

---

# 20. Filtering Data Through a View

Suppose:

```sql
CREATE VIEW customer_order_details AS
SELECT
    c.customer_name,
    o.order_id,
    o.order_date,
    o.total_amount
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id;
```

You can then write:

```sql
SELECT *
FROM customer_order_details
WHERE total_amount > 2000;
```

The view becomes a reusable base layer.

---

# 21. Aggregated Reporting Views

A common real-world use of views is reporting.

Example:

```sql
CREATE VIEW customer_spending AS
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_spending,
    AVG(o.total_amount) AS average_order_value
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_name;
```

Now:

```sql
SELECT *
FROM customer_spending;
```

provides a ready-made customer report.

---

# 22. Views as a Reporting Layer

A useful database architecture can look like:

```text
Base Tables
     ↓
   Views
     ↓
Reports / Dashboards / Analysis
```

For example:

```text
employees
departments
     ↓
employee_details
     ↓
management report
```

The reporting query does not need to repeatedly reconstruct the underlying joins.

---

# 23. Security and Views

Views can sometimes be used to expose only selected columns.

Suppose a table contains:

```text
employee_id
first_name
last_name
salary
bank_account_number
```

You might create:

```sql
CREATE VIEW employee_public_info AS
SELECT
    employee_id,
    first_name,
    last_name
FROM employees;
```

The view excludes sensitive columns from the result.

However, views are only one part of database security. Proper user privileges are still required.

---

# 24. Updating Through a View

Some views can be updatable.

For example:

```sql
CREATE VIEW sales_employees AS
SELECT
    employee_id,
    first_name,
    salary
FROM employees
WHERE department_id = 1;
```

Under appropriate conditions, an UPDATE may be possible:

```sql
UPDATE sales_employees
SET salary = salary + 5000
WHERE employee_id = 101;
```

The underlying `employees` table is affected.

However, not every view is updatable.

---

# 25. Non-Updatable Views

Views containing certain constructs may not be directly updatable.

Examples include views involving:

* GROUP BY
* Aggregate functions
* DISTINCT
* UNION
* Certain joins
* Window functions
* Other complex query structures

For example:

```sql
CREATE VIEW department_totals AS
SELECT
    department_id,
    SUM(salary) AS total_salary
FROM employees
GROUP BY department_id;
```

This is an analytical view rather than a view intended for direct row updates.

---

# 26. `WITH CHECK OPTION`

A view can use `WITH CHECK OPTION`.

Example:

```sql
CREATE VIEW sales_employees AS
SELECT
    employee_id,
    first_name,
    salary,
    department_id
FROM employees
WHERE department_id = 1
WITH CHECK OPTION;
```

This helps ensure that modifications through the view continue to satisfy its WHERE condition.

Conceptually:

```text
View condition
      ↓
Modification
      ↓
Must still satisfy condition
```

---

# 27. Views with `ORDER BY`

A view definition can sometimes contain ORDER BY, but the final result ordering should generally be specified by the outer query.

For example:

```sql
SELECT *
FROM employee_details
ORDER BY salary DESC;
```

This makes the desired final ordering explicit.

---

# 28. Views and Performance

A normal view does not automatically make a query faster.

For example:

```sql
CREATE VIEW employee_details AS
SELECT ...
FROM employees
JOIN departments ...;
```

The database still has to execute the underlying query when the view is queried.

Views primarily provide:

* Reusability.
* Abstraction.
* Simplicity.
* Consistency.
* Security boundaries.

Performance depends on the underlying query, indexes, optimizer, data volume, and other factors.

---

# 29. Views vs Materialized Views

A standard MySQL view is virtual.

Some database systems support **materialized views**, which store the result physically and can be refreshed.

Conceptually:

```text
VIEW
→ query definition

MATERIALIZED VIEW
→ stored query result
```

MySQL does not provide native materialized views in the same way some other database systems do, so materialized-view behavior generally requires another design approach.

---

# 30. Nested Views

A view can sometimes be built on another view.

Example:

```sql
CREATE VIEW employee_details AS
SELECT
    employee_id,
    first_name,
    salary,
    department_id
FROM employees;
```

Then:

```sql
CREATE VIEW high_salary_employees AS
SELECT *
FROM employee_details
WHERE salary > 60000;
```

This creates:

```text
employees
    ↓
employee_details
    ↓
high_salary_employees
```

Be careful not to create unnecessarily deep chains because they can make debugging and maintenance harder.

---

# 31. Views and Data Abstraction

A view can hide implementation details.

Instead of users knowing:

```text
employees
JOIN departments
JOIN locations
JOIN ...
```

they may only need:

```sql
SELECT *
FROM employee_report;
```

The complexity is contained inside the view.

---

# 32. Naming Conventions

Good:

```text
employee_details
department_summary
customer_spending
customer_order_details
employee_rankings
```

Avoid:

```text
view1
temp_view
test_view
abc
```

Use names that describe the purpose of the view.

---

# 33. Common Mistakes

### Mistake 1 — Forgetting the view name

Incorrect:

```sql
CREATE VIEW AS
SELECT ...
```

Correct:

```sql
CREATE VIEW employee_details AS
SELECT ...
```

---

### Mistake 2 — Trying to query a view before creating it

Create it first:

```sql
CREATE VIEW ...
```

Then:

```sql
SELECT *
FROM view_name;
```

---

### Mistake 3 — Forgetting `DROP VIEW`

When rebuilding practice databases, old views may already exist.

Use:

```sql
DROP VIEW IF EXISTS employee_details;
```

before recreating them when appropriate.

---

### Mistake 4 — Assuming every view is updatable

Analytical and complex views may not support direct INSERT, UPDATE, or DELETE operations.

---

### Mistake 5 — Treating a view as a performance optimization

A view primarily provides abstraction and reuse.

It does not automatically improve query performance.

---

# 34. Important Syntax

### Create

```sql
CREATE VIEW view_name AS
SELECT ...
FROM ...;
```

### Create or replace

```sql
CREATE OR REPLACE VIEW view_name AS
SELECT ...;
```

### Query

```sql
SELECT *
FROM view_name;
```

### Drop

```sql
DROP VIEW IF EXISTS view_name;
```

### Inspect definition

```sql
SHOW CREATE VIEW view_name;
```

---

# 35. CTE + View

A view can also be created from a query containing a CTE when supported by the database/version.

Conceptually:

```sql
CREATE VIEW employee_analysis AS
WITH employee_data AS (
    SELECT ...
)
SELECT *
FROM employee_data;
```

This allows you to save a more sophisticated query as a reusable database object.

---

# 36. View Design Pattern

A useful pattern is:

```text
Base tables
     ↓
Clean / simplify
     ↓
View
     ↓
Filter / aggregate / analyze
     ↓
Final report
```

Example:

```text
employees + departments
          ↓
    employee_details
          ↓
    employee_rankings
          ↓
       report
```

---

# 37. When Should You Use a View?

Use a view when:

* The same query is used repeatedly.
* A query is complicated.
* Users need a simplified interface.
* You want to expose selected columns.
* You want a reusable reporting layer.
* You want consistent business logic.

---

# 38. When Should You Use a CTE Instead?

Use a CTE when:

* The intermediate result is needed only once.
* You are solving one complex query.
* You need multiple logical query stages.
* You need recursive query processing.

A simple rule:

```text
Reusable across queries?
→ View

Only needed in this query?
→ CTE
```

---

# 39. When Should You Use a Table?

Use a table when the data itself needs to be stored.

```text
Table
→ stores data

View
→ stores a query definition

CTE
→ temporary query definition
```

This distinction is fundamental.

---

# 40. Module 21 Key Takeaways

A view is a reusable virtual table based on a query.

Remember:

```text
CREATE VIEW
→ create a view

SELECT FROM view
→ query the view

CREATE OR REPLACE VIEW
→ update the view definition

DROP VIEW
→ remove the view

SHOW CREATE VIEW
→ inspect the definition
```

The most important comparison is:

```text
TABLE
→ stores data

VIEW
→ reusable query definition

CTE
→ temporary query definition
```

Views are especially useful for:

* Reporting.
* Data abstraction.
* Query reuse.
* Simplifying complex joins.
* Aggregated reports.
* Controlled data exposure.

Your next major SQL skill is learning how to build **reusable database layers**, rather than writing every query from scratch.
