# Module 22 — SQL Stored Procedures

A **Stored Procedure** is a named collection of SQL statements stored inside a database.

Instead of repeatedly writing the same sequence of SQL statements, you can store the logic in a procedure and execute it whenever needed.

This module uses **MySQL 8.0+ syntax**.

---

## 1. What Is a Stored Procedure?

A stored procedure is a database object containing SQL statements.

Basic syntax:

```sql
CREATE PROCEDURE procedure_name()
BEGIN
    SQL statements;
END;
```

You execute it using:

```sql
CALL procedure_name();
```

For example:

```sql
CREATE PROCEDURE get_all_employees()
BEGIN
    SELECT *
    FROM employees;
END;
```

Then:

```sql
CALL get_all_employees();
```

---

# 2. Why Use Stored Procedures?

Stored procedures can be useful for:

* Reusing SQL logic.
* Automating repetitive database operations.
* Encapsulating business logic.
* Accepting parameters.
* Performing multiple SQL statements.
* Reducing repeated application-side SQL.
* Centralizing database operations.

Conceptually:

```text
Application
     ↓
CALL procedure
     ↓
Database
     ↓
Multiple SQL statements
```

---

# 3. Creating a Simple Procedure

Example:

```sql
CREATE PROCEDURE get_employees()
BEGIN
    SELECT *
    FROM employees;
END;
```

Execute:

```sql
CALL get_employees();
```

The procedure remains stored in the database until it is dropped.

---

# 4. `DELIMITER`

When creating procedures in MySQL, you will commonly see:

```sql
DELIMITER //
```

Then:

```sql
CREATE PROCEDURE get_employees()
BEGIN
    SELECT *
    FROM employees;
END //
```

Finally:

```sql
DELIMITER ;
```

Why?

The default SQL statement terminator is `;`.

But the procedure itself contains multiple statements ending with `;`.

Changing the delimiter temporarily tells the MySQL client where the entire `CREATE PROCEDURE` statement ends.

Typical pattern:

```sql
DELIMITER //

CREATE PROCEDURE procedure_name()
BEGIN
    SELECT * FROM employees;
    SELECT * FROM departments;
END //

DELIMITER ;
```

---

# 5. Calling a Procedure

Use:

```sql
CALL procedure_name();
```

Example:

```sql
CALL get_employees();
```

The parentheses are used even when the procedure has no parameters.

---

# 6. Procedure with an Input Parameter

Procedures become more powerful when they accept parameters.

Example:

```sql
CREATE PROCEDURE get_employee_by_id(
    IN p_employee_id INT
)
BEGIN
    SELECT *
    FROM employees
    WHERE employee_id = p_employee_id;
END;
```

Call it:

```sql
CALL get_employee_by_id(101);
```

Here:

```text
p_employee_id
```

is the procedure parameter.

---

# 7. `IN` Parameters

An `IN` parameter receives a value from the caller.

Example:

```sql
CREATE PROCEDURE get_employees_by_department(
    IN p_department_id INT
)
BEGIN
    SELECT *
    FROM employees
    WHERE department_id = p_department_id;
END;
```

Call:

```sql
CALL get_employees_by_department(2);
```

Conceptually:

```text
Caller
  ↓
value
  ↓
IN parameter
  ↓
procedure
```

---

# 8. Parameter Naming

A useful convention is to prefix procedure parameters with `p_`.

Examples:

```text
p_employee_id
p_department_id
p_min_salary
p_customer_id
p_amount
```

This helps distinguish parameters from table columns.

For example:

```sql
WHERE employee_id = p_employee_id
```

is clearer than using ambiguous names.

---

# 9. Multiple Parameters

A procedure can accept multiple parameters.

Example:

```sql
CREATE PROCEDURE get_salary_range(
    IN p_min_salary DECIMAL(10,2),
    IN p_max_salary DECIMAL(10,2)
)
BEGIN
    SELECT *
    FROM employees
    WHERE salary BETWEEN p_min_salary AND p_max_salary;
END;
```

Call:

```sql
CALL get_salary_range(50000, 70000);
```

---

# 10. Procedure with `INSERT`

Stored procedures can perform INSERT operations.

Example:

```sql
CREATE PROCEDURE add_customer(
    IN p_customer_id INT,
    IN p_customer_name VARCHAR(100),
    IN p_city VARCHAR(100)
)
BEGIN
    INSERT INTO customers (
        customer_id,
        customer_name,
        city
    )
    VALUES (
        p_customer_id,
        p_customer_name,
        p_city
    );
END;
```

Call:

```sql
CALL add_customer(
    10,
    'New Customer',
    'Delhi'
);
```

---

# 11. Procedure with `UPDATE`

Example:

```sql
CREATE PROCEDURE increase_salary(
    IN p_employee_id INT,
    IN p_amount DECIMAL(10,2)
)
BEGIN
    UPDATE employees
    SET salary = salary + p_amount
    WHERE employee_id = p_employee_id;
END;
```

Call:

```sql
CALL increase_salary(101, 5000);
```

---

# 12. Procedure with `DELETE`

Example:

```sql
CREATE PROCEDURE delete_customer(
    IN p_customer_id INT
)
BEGIN
    DELETE FROM customers
    WHERE customer_id = p_customer_id;
END;
```

Call:

```sql
CALL delete_customer(10);
```

Be careful with DELETE procedures because they can permanently modify data.

---

# 13. Multiple Statements

A stored procedure can contain multiple SQL statements.

Example:

```sql
CREATE PROCEDURE employee_report()
BEGIN

    SELECT *
    FROM employees;

    SELECT *
    FROM departments;

END;
```

Calling:

```sql
CALL employee_report();
```

can return multiple result sets.

---

# 14. Local Variables

Stored procedures can declare local variables.

Syntax:

```sql
DECLARE variable_name datatype;
```

Example:

```sql
CREATE PROCEDURE employee_count()
BEGIN

    DECLARE total_employees INT;

    SELECT COUNT(*)
    INTO total_employees
    FROM employees;

    SELECT total_employees AS employee_count;

END;
```

Call:

```sql
CALL employee_count();
```

---

# 15. `SELECT ... INTO`

`SELECT ... INTO` can store a query result inside a variable.

Example:

```sql
DECLARE avg_salary DECIMAL(10,2);

SELECT AVG(salary)
INTO avg_salary
FROM employees;
```

Then:

```sql
SELECT avg_salary;
```

The general pattern is:

```sql
SELECT expression
INTO variable
FROM table;
```

---

# 16. Variables vs Parameters

A parameter comes from the caller.

A local variable is created and used inside the procedure.

Example:

```sql
CREATE PROCEDURE salary_analysis(
    IN p_department_id INT
)
BEGIN

    DECLARE avg_salary DECIMAL(10,2);

    SELECT AVG(salary)
    INTO avg_salary
    FROM employees
    WHERE department_id = p_department_id;

    SELECT avg_salary;

END;
```

Here:

```text
p_department_id
→ input parameter

avg_salary
→ local variable
```

---

# 17. `IF` Statements

Stored procedures can contain conditional logic.

Example:

```sql
IF p_salary > 60000 THEN
    SELECT 'High Salary';
ELSE
    SELECT 'Standard Salary';
END IF;
```

Complete example:

```sql
CREATE PROCEDURE check_salary(
    IN p_salary DECIMAL(10,2)
)
BEGIN

    IF p_salary >= 80000 THEN
        SELECT 'High';
    ELSEIF p_salary >= 60000 THEN
        SELECT 'Medium';
    ELSE
        SELECT 'Low';
    END IF;

END;
```

Call:

```sql
CALL check_salary(75000);
```

---

# 18. `CASE` in Procedures

You can also use CASE expressions.

```sql
SELECT
    CASE
        WHEN p_salary >= 80000 THEN 'High'
        WHEN p_salary >= 60000 THEN 'Medium'
        ELSE 'Low'
    END AS salary_category;
```

`CASE` is particularly useful when returning calculated values.

---

# 19. `WHILE` Loops

Stored procedures support loops.

Example:

```sql
DECLARE counter INT DEFAULT 1;

WHILE counter <= 5 DO

    SELECT counter;

    SET counter = counter + 1;

END WHILE;
```

The loop continues while the condition is true.

Conceptually:

```text
counter = 1
   ↓
condition true?
   ↓
execute
   ↓
counter = counter + 1
   ↓
repeat
```

---

# 20. `SET`

Use `SET` to assign values to variables.

Example:

```sql
DECLARE total INT DEFAULT 0;

SET total = 100;
```

You can also perform calculations:

```sql
SET total = total + 50;
```

---

# 21. `OUT` Parameters

A procedure can return a value through an `OUT` parameter.

Example:

```sql
CREATE PROCEDURE get_employee_count(
    OUT p_total INT
)
BEGIN

    SELECT COUNT(*)
    INTO p_total
    FROM employees;

END;
```

Call:

```sql
CALL get_employee_count(@total);
```

Then:

```sql
SELECT @total;
```

The value is stored in the session variable `@total`.

---

# 22. `INOUT` Parameters

An `INOUT` parameter can receive a value and return a modified value.

Example:

```sql
CREATE PROCEDURE add_bonus(
    INOUT p_amount DECIMAL(10,2)
)
BEGIN

    SET p_amount = p_amount + 5000;

END;
```

Call:

```sql
SET @amount = 10000;

CALL add_bonus(@amount);

SELECT @amount;
```

The value becomes:

```text
15000
```

---

# 23. Parameter Modes

There are three parameter modes:

```text
IN
OUT
INOUT
```

### IN

Input only.

```sql
IN p_id INT
```

### OUT

Output only.

```sql
OUT p_total INT
```

### INOUT

Input and output.

```sql
INOUT p_amount DECIMAL(10,2)
```

---

# 24. Procedure with Aggregation

Example:

```sql
CREATE PROCEDURE department_statistics(
    IN p_department_id INT
)
BEGIN

    SELECT
        COUNT(*) AS employee_count,
        SUM(salary) AS total_salary,
        AVG(salary) AS average_salary
    FROM employees
    WHERE department_id = p_department_id;

END;
```

Call:

```sql
CALL department_statistics(2);
```

---

# 25. Procedure with JOIN

Procedures can contain complex queries.

Example:

```sql
CREATE PROCEDURE department_employees(
    IN p_department_id INT
)
BEGIN

    SELECT
        e.employee_id,
        e.first_name,
        e.last_name,
        e.salary,
        d.department_name
    FROM employees AS e
    JOIN departments AS d
        ON e.department_id = d.department_id
    WHERE e.department_id = p_department_id;

END;
```

Call:

```sql
CALL department_employees(2);
```

---

# 26. Procedure with ORDER BY

Example:

```sql
CREATE PROCEDURE highest_paid_employees(
    IN p_limit INT
)
BEGIN

    SELECT
        employee_id,
        first_name,
        salary
    FROM employees
    ORDER BY salary DESC
    LIMIT p_limit;

END;
```

Call:

```sql
CALL highest_paid_employees(3);
```

---

# 27. Dropping a Procedure

Use:

```sql
DROP PROCEDURE procedure_name;
```

Safer:

```sql
DROP PROCEDURE IF EXISTS procedure_name;
```

Example:

```sql
DROP PROCEDURE IF EXISTS get_employees;
```

---

# 28. Viewing Procedures

To list stored procedures:

```sql
SHOW PROCEDURE STATUS;
```

You can also filter by database.

To inspect a procedure:

```sql
SHOW CREATE PROCEDURE get_employees;
```

This displays its definition.

---

# 29. Stored Procedure vs View

These are different database objects.

A View:

```text
VIEW
→ saved SELECT query
→ queried with SELECT
```

A Stored Procedure:

```text
PROCEDURE
→ saved SQL program
→ executed with CALL
```

Example:

```sql
SELECT *
FROM employee_details;
```

versus:

```sql
CALL get_employees();
```

---

# 30. Stored Procedure vs Function

A stored procedure is designed to perform operations and can return result sets or use output parameters.

A stored function returns a value and can be used inside expressions.

Procedure:

```sql
CALL get_employee_count();
```

Function:

```sql
SELECT calculate_bonus(salary)
FROM employees;
```

They serve different purposes.

---

# 31. Procedures for Business Logic

Stored procedures can encapsulate business operations.

For example:

```text
Process employee salary update
        ↓
Validate input
        ↓
Update employee
        ↓
Record operation
        ↓
Return result
```

Instead of implementing every database step separately in application code, the procedure can centralize the operation.

---

# 32. Procedures and Transactions

Stored procedures can work with transactions.

Example concept:

```sql
START TRANSACTION;

UPDATE ...;

INSERT ...;

COMMIT;
```

If something goes wrong, the transaction can potentially be rolled back.

Transactions will be studied more deeply in a later module.

---

# 33. Procedures and Error Handling

MySQL stored procedures can use handlers for conditions and errors.

For example:

```sql
DECLARE CONTINUE HANDLER
FOR SQLEXCEPTION
BEGIN
    -- error handling
END;
```

Error handling becomes especially important for procedures that modify multiple tables.

---

# 34. Security Considerations

Stored procedures can help centralize database operations and control how certain operations are exposed.

However, simply placing SQL inside a procedure does not automatically make a database secure.

Proper:

* User privileges.
* Access control.
* Validation.
* Transaction handling.
* Error handling.

are still necessary.

---

# 35. Good Procedure Naming

Prefer descriptive names:

```text
get_employee_by_id
get_department_employees
add_customer
increase_salary
delete_customer
calculate_department_stats
```

Avoid:

```text
proc1
test_proc
abc
data
```

The procedure name should communicate what it does.

---

# 36. Naming Parameters

A useful convention:

```text
p_employee_id
p_customer_id
p_department_id
p_min_salary
p_max_salary
p_amount
```

This makes code easier to read.

Example:

```sql
WHERE employee_id = p_employee_id
```

is immediately understandable.

---

# 37. Avoid Overusing Stored Procedures

Stored procedures are powerful, but they should not automatically be used for every query.

A simple SELECT does not necessarily need a procedure.

For example:

```sql
SELECT *
FROM employees;
```

does not need to become a stored procedure unless there is a specific reason.

Use procedures when they provide meaningful reuse, abstraction, validation, or business logic.

---

# 38. Stored Procedure Design Pattern

A useful mental model:

```text
INPUT
  ↓
Validation
  ↓
Business Logic
  ↓
Database Operations
  ↓
OUTPUT
```

For example:

```text
p_employee_id
      ↓
Find employee
      ↓
Calculate salary change
      ↓
UPDATE employees
      ↓
Return employee information
```

---

# 39. Common Mistakes

### Mistake 1 — Forgetting DELIMITER

When working in the MySQL command-line client or compatible tools, forgetting to change the delimiter can cause procedure creation problems.

Typical pattern:

```sql
DELIMITER //

CREATE PROCEDURE ...
BEGIN
    ...
END //

DELIMITER ;
```

---

### Mistake 2 — Forgetting `CALL`

Incorrect:

```sql
SELECT get_employees();
```

for a stored procedure.

Correct:

```sql
CALL get_employees();
```

---

### Mistake 3 — Confusing Parameters and Columns

Use clear parameter names:

```sql
WHERE employee_id = p_employee_id;
```

rather than ambiguous names.

---

### Mistake 4 — Forgetting `IN`, `OUT`, or `INOUT`

Parameters need an appropriate mode.

```sql
IN p_id INT
```

---

### Mistake 5 — Forgetting `END IF`

An IF block needs:

```sql
END IF;
```

---

### Mistake 6 — Forgetting `END WHILE`

A WHILE block needs:

```sql
END WHILE;
```

---

### Mistake 7 — Not Dropping an Existing Procedure

During development, use:

```sql
DROP PROCEDURE IF EXISTS procedure_name;
```

before recreating it when appropriate.

---

# 40. Important Syntax

### Create

```sql
CREATE PROCEDURE procedure_name()
BEGIN
    ...
END;
```

### Execute

```sql
CALL procedure_name();
```

### Input parameter

```sql
IN p_value INT
```

### Output parameter

```sql
OUT p_value INT
```

### Input/output parameter

```sql
INOUT p_value INT
```

### Drop

```sql
DROP PROCEDURE IF EXISTS procedure_name;
```

### Inspect

```sql
SHOW CREATE PROCEDURE procedure_name;
```

---

# 41. Module 22 Key Takeaways

A stored procedure is a reusable program stored inside the database.

Remember:

```text
CREATE PROCEDURE
→ create procedure

CALL
→ execute procedure

IN
→ input

OUT
→ output

INOUT
→ input + output

DECLARE
→ create local variable

SET
→ assign variable

IF
→ conditional logic

WHILE
→ loop

DROP PROCEDURE
→ remove procedure
```

The important distinction is:

```text
TABLE
→ stores data

VIEW
→ reusable SELECT definition

CTE
→ temporary query definition

PROCEDURE
→ reusable SQL program
```

Stored procedures move you beyond writing individual SQL queries and toward **database programming and reusable business logic**.
