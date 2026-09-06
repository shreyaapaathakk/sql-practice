# Module 21 — Advanced Views

## 1. Module Overview

Views were introduced in Module 16 as virtual tables based on SQL queries.

This module takes views further.

Instead of focusing on basic `CREATE VIEW` syntax, we will learn how views can be used to build reusable reporting layers, simplify complex queries, control access to data, and create cleaner database interfaces.

Topics covered:

* Complex views
* Views with joins
* Views with aggregations
* Views with subqueries
* Views using expressions
* Views for reporting
* Views for data abstraction
* Views for security
* Updatable views
* Non-updatable views
* `WITH CHECK OPTION`
* View dependencies
* Altering views
* Dropping views
* View limitations
* View design best practices
* Views vs CTEs
* Views vs temporary tables
* Views vs stored procedures

---

# 2. Review: What Is a View?

A view is a named SQL query that can be queried like a table.

```sql
CREATE VIEW active_customers AS
SELECT
    customer_id,
    customer_name,
    email
FROM customers
WHERE status = 'ACTIVE';
```

We can then query it:

```sql
SELECT *
FROM active_customers;
```

A view normally stores the query definition rather than storing a separate copy of the result data.

---

# 3. Why Use Views?

Views can provide:

### Reusability

A complex query can be written once and reused.

### Simplicity

Users can query a view without knowing the underlying tables and joins.

### Abstraction

A view can hide database implementation details.

### Security

A view can expose selected columns or rows instead of giving users direct access to an entire table.

### Reporting

Views can provide standardized datasets for reports and dashboards.

---

# 4. Creating a View from Multiple Tables

Views can combine multiple tables.

```sql
CREATE VIEW employee_details AS
SELECT
    e.employee_id,
    e.employee_name,
    d.department_name,
    e.salary
FROM employees e
JOIN departments d
    ON e.department_id = d.department_id;
```

Now:

```sql
SELECT *
FROM employee_details;
```

The user does not need to repeatedly write the join.

---

# 5. Views with Filtering

A view can contain filtering conditions.

```sql
CREATE VIEW active_employees AS
SELECT
    employee_id,
    employee_name,
    department_id,
    salary
FROM employees
WHERE status = 'ACTIVE';
```

The view automatically returns only active employees.

---

# 6. Views with Calculated Columns

Views can contain expressions.

```sql
CREATE VIEW employee_salary_info AS
SELECT
    employee_id,
    employee_name,
    salary,
    salary * 12 AS annual_salary
FROM employees;
```

The calculated column becomes available whenever the view is queried.

```sql
SELECT
    employee_name,
    annual_salary
FROM employee_salary_info;
```

---

# 7. Views with CASE Expressions

Views can contain conditional logic.

```sql
CREATE VIEW employee_salary_categories AS
SELECT
    employee_id,
    employee_name,
    salary,
    CASE
        WHEN salary >= 100000 THEN 'HIGH'
        WHEN salary >= 70000 THEN 'MEDIUM'
        ELSE 'LOW'
    END AS salary_category
FROM employees;
```

This allows classification logic to be reused.

---

# 8. Views with Aggregation

Views can contain aggregate functions.

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

We can then join the view with the departments table:

```sql
SELECT
    d.department_name,
    s.employee_count,
    s.total_salary,
    s.average_salary
FROM department_salary_summary s
JOIN departments d
    ON d.department_id = s.department_id;
```

---

# 9. Reporting Views

A reporting view can combine several database tables into a convenient reporting dataset.

Example:

```sql
CREATE VIEW customer_order_summary AS
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS order_count,
    COALESCE(SUM(o.total_amount), 0) AS total_spent
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_name;
```

Now reporting queries become much simpler:

```sql
SELECT *
FROM customer_order_summary
ORDER BY total_spent DESC;
```

---

# 10. Views for Data Abstraction

Suppose the underlying table contains many columns:

```text
employee_id
employee_name
department_id
salary
hire_date
status
internal_notes
bank_account
```

A view can expose only appropriate information:

```sql
CREATE VIEW public_employee_directory AS
SELECT
    employee_id,
    employee_name,
    department_id,
    hire_date
FROM employees;
```

Users querying the view do not need access to every underlying column.

---

# 11. Views for Security

Views can help implement column-level and row-level access patterns.

Example:

```sql
CREATE VIEW active_customer_directory AS
SELECT
    customer_id,
    customer_name,
    email
FROM customers
WHERE status = 'ACTIVE';
```

Instead of granting access to the entire `customers` table, an application can be designed around the view.

A view is not a complete replacement for database permissions, but it can be an important part of a security strategy.

---

# 12. Views with `WITH CHECK OPTION`

`WITH CHECK OPTION` can be used with an updatable view.

Example:

```sql
CREATE VIEW active_customers AS
SELECT
    customer_id,
    customer_name,
    email,
    status
FROM customers
WHERE status = 'ACTIVE'
WITH CHECK OPTION;
```

The check option prevents modifications through the view that would cause the modified row to no longer satisfy the view's condition.

For example, changing an active customer to inactive through this view would be rejected.

---

# 13. Updatable Views

Some views allow `INSERT`, `UPDATE`, or `DELETE` operations.

A simple view based on one table may be updatable.

Example:

```sql
CREATE VIEW active_customer_list AS
SELECT
    customer_id,
    customer_name,
    email,
    status
FROM customers
WHERE status = 'ACTIVE';
```

An update may be possible:

```sql
UPDATE active_customer_list
SET customer_name = 'Updated Name'
WHERE customer_id = 1;
```

The exact rules for updatability depend on the query structure and database system.

---

# 14. Non-Updatable Views

Many complex views cannot be directly modified.

Views commonly become non-updatable when they contain features such as:

* Aggregate functions
* `GROUP BY`
* `DISTINCT`
* Set operations
* Certain joins
* Window functions
* Subqueries
* Other constructs that prevent direct mapping to base-table rows

Example:

```sql
CREATE VIEW department_totals AS
SELECT
    department_id,
    SUM(salary) AS total_salary
FROM employees
GROUP BY department_id;
```

It does not represent individual employee rows, so updating an employee through this view is not straightforward.

---

# 15. View with a JOIN vs Simple View

Simple view:

```sql
CREATE VIEW active_customers AS
SELECT *
FROM customers
WHERE status = 'ACTIVE';
```

More complex view:

```sql
CREATE VIEW employee_department_details AS
SELECT
    e.employee_id,
    e.employee_name,
    e.salary,
    d.department_name
FROM employees e
JOIN departments d
    ON e.department_id = d.department_id;
```

The second view provides a more convenient representation but may have different update characteristics.

---

# 16. Altering a View

MySQL supports replacing a view definition with:

```sql
CREATE OR REPLACE VIEW view_name AS
SELECT ...
```

Example:

```sql
CREATE OR REPLACE VIEW active_customers AS
SELECT
    customer_id,
    customer_name,
    email,
    status
FROM customers
WHERE status = 'ACTIVE';
```

This avoids having to drop the view first.

---

# 17. Dropping a View

To remove a view:

```sql
DROP VIEW view_name;
```

Safer version:

```sql
DROP VIEW IF EXISTS view_name;
```

Dropping a view does not normally delete the underlying table data.

---

# 18. Viewing a View Definition

MySQL provides:

```sql
SHOW CREATE VIEW view_name;
```

Example:

```sql
SHOW CREATE VIEW active_customers;
```

This is useful when maintaining an existing database.

---

# 19. View Dependencies

A view may depend on one or more tables.

Another view may depend on the first view.

For example:

```text
employees
     ↓
active_employees
     ↓
active_employee_summary
```

If an underlying table or column is changed, dependent views may be affected.

Therefore, database changes should consider view dependencies.

---

# 20. Views Built on Other Views

A view can reference another view.

Example:

```sql
CREATE VIEW active_employees AS
SELECT *
FROM employees
WHERE status = 'ACTIVE';
```

Then:

```sql
CREATE VIEW active_department_summary AS
SELECT
    department_id,
    COUNT(*) AS employee_count,
    AVG(salary) AS average_salary
FROM active_employees
GROUP BY department_id;
```

This can improve organization, but excessive layers of views can make debugging and performance analysis difficult.

---

# 21. Views vs CTEs

A CTE:

```sql
WITH customer_totals AS (...)
SELECT ...
```

is temporary and exists only for the current statement.

A view:

```sql
CREATE VIEW customer_totals AS ...
```

is a persistent database object.

Use a CTE when:

* The query is needed once.
* You are breaking a complex query into steps.
* The intermediate result does not need to be reused independently.

Use a view when:

* The query will be reused.
* A standard dataset should be available to multiple queries.
* You want to hide query complexity.
* You are creating a reporting or abstraction layer.

---

# 22. Views vs Temporary Tables

A temporary table physically stores rows for the session.

A view generally stores the query definition.

Temporary table:

```sql
CREATE TEMPORARY TABLE temp_customer_totals AS
SELECT ...
```

View:

```sql
CREATE VIEW customer_totals AS
SELECT ...
```

Temporary tables are useful when intermediate data needs to be materialized and reused during a session.

Views are useful for reusable logical datasets.

---

# 23. Views vs Stored Procedures

A view primarily represents a dataset.

A stored procedure represents a programmable sequence of SQL statements.

View:

```text
Reusable dataset
```

Stored procedure:

```text
Reusable database program
```

A view is generally queried with:

```sql
SELECT *
FROM customer_summary;
```

A stored procedure can accept parameters and perform multiple operations.

---

# 24. Views and Parameters

Traditional MySQL views do not work like parameterized functions.

For example, you cannot normally create:

```text
customer_orders(customer_id)
```

as a parameterized view.

Instead, create a general view:

```sql
CREATE VIEW customer_order_summary AS
SELECT ...
```

Then filter it:

```sql
SELECT *
FROM customer_order_summary
WHERE customer_id = 5;
```

For parameterized operations, stored procedures or application queries may be more appropriate.

---

# 25. Views and Window Functions

Views can contain window functions.

Example:

```sql
CREATE VIEW employee_salary_ranking AS
SELECT
    employee_id,
    employee_name,
    department_id,
    salary,
    RANK() OVER (
        PARTITION BY department_id
        ORDER BY salary DESC
    ) AS salary_rank
FROM employees;
```

Then:

```sql
SELECT *
FROM employee_salary_ranking
WHERE salary_rank <= 2;
```

This creates a reusable analytical dataset.

---

# 26. Views and Complex Reporting

A view can act as a reporting layer.

For example:

```text
Base tables
     ↓
Business logic
     ↓
Reporting view
     ↓
Dashboard / Report / Query
```

This can prevent the same business logic from being implemented differently in multiple reports.

---

# 27. Business Logic in Views

Views can centralize business logic.

For example, suppose customers are classified as:

```text
VIP      → spending >= 20000
PREMIUM  → spending >= 10000
REGULAR  → spending >= 5000
LOW      → otherwise
```

Instead of repeating the classification in multiple reports, a view can define it once.

This helps maintain consistency.

---

# 28. View Naming Conventions

Use descriptive names.

Good:

```text
active_customers
customer_order_summary
department_salary_summary
employee_department_details
employee_salary_ranking
```

Avoid:

```text
view1
temp_view
data
test
abc
```

A view name should communicate what the view represents.

---

# 29. Avoid `SELECT *` in Production Views

Although this works:

```sql
CREATE VIEW active_customers AS
SELECT *
FROM customers;
```

explicit columns are generally preferable:

```sql
CREATE VIEW active_customers AS
SELECT
    customer_id,
    customer_name,
    email,
    status
FROM customers;
```

Benefits include:

* Clear schema
* Better documentation
* Reduced accidental exposure
* More predictable behavior when tables change

---

# 30. Avoid Overly Complex Views

Views should simplify database access.

A view containing many nested views, complicated subqueries, window functions, joins, and calculations may become difficult to maintain.

If a view becomes extremely complex, reconsider whether:

* The logic should be split.
* A reporting table is more appropriate.
* A stored procedure is better.
* The application should perform part of the processing.

---

# 31. Performance Considerations

A view does not automatically make a query faster.

For many standard views, querying the view causes the database optimizer to work with the underlying query.

Performance depends on:

* Indexes
* Joins
* Filters
* Aggregations
* Data volume
* Query structure
* Database optimizer
* Execution plan

Use:

```sql
EXPLAIN
```

to investigate query performance.

---

# 32. Views as an API-Like Database Layer

A useful architectural idea is to treat carefully designed views as a stable interface.

Instead of applications knowing every underlying table:

```text
Application
     ↓
Reporting View
     ↓
Base Tables
```

The application can depend on the view's output.

This can reduce coupling between applications and database implementation details.

---

# 33. When Not to Use a View

A view may not be appropriate when:

* The query is only used once.
* A CTE is sufficient.
* The result needs to be physically stored.
* Complex procedural logic is required.
* Parameters are essential.
* Performance requires materialized intermediate data.
* The view becomes excessively complicated.

---

# 34. Advanced View Design Pattern

A useful reporting architecture is:

```text
Base Tables
     ↓
Simple Business Views
     ↓
Aggregated Reporting Views
     ↓
Final Reports
```

For example:

```text
customers + orders
       ↓
customer_order_summary
       ↓
customer_performance
       ↓
dashboard
```

This creates layers of abstraction.

---

# 35. Key Takeaways

Views are more than saved SELECT statements.

They can provide:

* Reusable datasets
* Data abstraction
* Security boundaries
* Reporting layers
* Centralized business logic
* Simplified application queries
* Analytical datasets

Important concepts from this module include:

```text
CREATE OR REPLACE VIEW
DROP VIEW
SHOW CREATE VIEW
WITH CHECK OPTION
Updatable views
Non-updatable views
Views with JOINs
Views with GROUP BY
Views with window functions
Views built on views
View dependencies
Views vs CTEs
Views vs temporary tables
Views vs stored procedures
```

The key question is not:

> "Can I create a view?"

The better question is:

> "Would making this query a persistent, reusable database interface improve the design?"

---

# Module 21 Completion Checklist

Before moving to the next module, you should be able to:

* Create complex views.
* Create views using multiple tables.
* Create views using aggregation.
* Create reporting views.
* Create views with calculated columns.
* Use CASE expressions inside views.
* Use window functions inside views.
* Understand updatable views.
* Understand non-updatable views.
* Use `WITH CHECK OPTION`.
* Replace an existing view.
* Drop a view safely.
* Inspect a view definition.
* Understand view dependencies.
* Build a view on another view.
* Compare views and CTEs.
* Compare views and temporary tables.
* Compare views and stored procedures.
* Design views for security and abstraction.
* Recognize when a view is inappropriate.
* Consider performance when designing views.

At this point, you should be comfortable treating views as a **reusable database design and reporting tool**, not merely as an alternative syntax for a SELECT query.
