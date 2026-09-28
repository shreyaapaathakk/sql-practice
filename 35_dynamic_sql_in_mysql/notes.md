# Module 35: Dynamic SQL in MySQL

## Overview

Dynamic SQL allows a SQL statement to be constructed and executed at runtime. Instead of writing every possible query in advance, an application or stored procedure can build a statement based on supplied parameters.

For example, a reporting procedure might allow users to choose a department to filter by or a column to sort by. Dynamic SQL can make this possible without creating a separate procedure for every combination.

In MySQL, dynamic SQL is commonly implemented using prepared statements with `PREPARE`, `EXECUTE`, and `DEALLOCATE PREPARE`.

## Learning Objectives

By the end of this module, you should be able to:

- Explain when dynamic SQL is useful.
- Create and execute prepared statements.
- Use placeholders to pass values safely.
- Build dynamic queries inside stored procedures.
- Select tables and columns dynamically.
- Validate dynamic identifiers.
- Handle prepared statement cleanup.
- Recognize SQL injection risks.
- Choose between dynamic SQL and static SQL.

## 1. Static SQL vs. Dynamic SQL

Static SQL is written in advance. Its table names, column names, and query structure are fixed.

```sql
SELECT employee_id, employee_name, salary
FROM employees
WHERE department = 'IT';
````

Dynamic SQL constructs part or all of a statement at runtime. It is useful when the structure of a query must change based on an input.

For example, a reporting procedure may allow the caller to select a table or a sorting column.

Dynamic SQL adds flexibility, but it also introduces complexity. Use it only when a fixed query or a normal parameterized statement cannot meet the requirement.

## 2. Prepared Statements

A prepared statement separates the preparation of a SQL statement from its execution.

The basic lifecycle is:

1. Build the SQL statement.

2. Prepare the statement.

3. Execute it.

4. Deallocate the prepared statement when it is no longer needed.

SQL

```
SET @sql = 'SELECT employee_id, employee_name FROM employees';

PREPARE stmt FROM @sql;

EXECUTE stmt;

DEALLOCATE PREPARE stmt;
```

`PREPARE` parses the statement and creates a prepared statement. `EXECUTE` runs it. `DEALLOCATE PREPARE` releases the prepared statement.

Always clean up prepared statements after use.

## 3. Parameterized Dynamic SQL

Prepared statements can use `?` placeholders for values.

SQL

```
SET @sql = '
    SELECT employee_id, employee_name, salary
    FROM employees
    WHERE department = ?
';

SET @department = 'IT';

PREPARE stmt FROM @sql;

EXECUTE stmt USING @department;

DEALLOCATE PREPARE stmt;
```

The placeholder represents a value, not a table name or column name.

Using placeholders keeps data separate from the SQL statement and helps prevent SQL injection through values.

## 4. Dynamic SQL Inside Stored Procedures

MySQL supports prepared statements inside stored procedures. However, prepared statements cannot directly reference a procedure's local variables.

Use session user-defined variables to pass values to a prepared statement.

SQL

```
DELIMITER $$

CREATE PROCEDURE sp_employees_by_department(
    IN p_department VARCHAR(50)
)
BEGIN
    SET @sql = '
        SELECT employee_id, employee_name, salary
        FROM employees
        WHERE department = ?
    ';

    SET @p_department = p_department;

    PREPARE stmt FROM @sql;
    EXECUTE stmt USING @p_department;
    DEALLOCATE PREPARE stmt;
END$$

DELIMITER ;
```

The procedure parameter is copied into `@p_department`, which is available to `EXECUTE ... USING`.

Use distinct, descriptive names for user-defined variables to avoid accidental conflicts with other session code.

## 5. Dynamic Table Names

Placeholders cannot represent table names. If the table name must vary, it must be incorporated into the SQL string.

SQL

```
SET @table_name = 'employees';

SET @sql = CONCAT(
    'SELECT * FROM ',
    @table_name
);
```

Never insert an arbitrary user-provided table name directly into a query. Validate it against an explicit allowlist before constructing the statement.

SQL

```
IF p_table_name NOT IN ('employees', 'departments') THEN
    SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid table name';
END IF;
```

An allowlist restricts the possible identifiers to known, permitted values.

## 6. Dynamic Column Names and Sorting

Column names also cannot be supplied through `?` placeholders.

For dynamic sorting, map a caller's input to a known column name.

SQL

```
CASE p_sort_column
    WHEN 'name' THEN
        SET v_sort_column = 'employee_name';
    WHEN 'salary' THEN
        SET v_sort_column = 'salary';
    ELSE
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Invalid sort column';
END CASE;
```

Then use the validated column in the SQL string.

SQL

```
SET @sql = CONCAT(
    'SELECT employee_id, employee_name, salary ',
    'FROM employees ORDER BY ',
    v_sort_column
);
```

Sorting direction such as `ASC` or `DESC` must also be validated because it is part of the SQL syntax, not a data value.

## 7. SQL Injection

SQL injection occurs when untrusted input changes the intended structure of a SQL statement.

Unsafe example:

SQL

```
SET @sql = CONCAT(
    'SELECT * FROM employees WHERE department = ''',
    @department,
    ''''
);
```

If `@department` contains crafted SQL text, the resulting statement may behave differently than intended.

Safer approach:

SQL

```
SET @sql = '
    SELECT *
    FROM employees
    WHERE department = ?
';

PREPARE stmt FROM @sql;
EXECUTE stmt USING @department;
DEALLOCATE PREPARE stmt;
```

Use placeholders for values. For identifiers that cannot be parameterized, validate against an allowlist.

## 8. Dynamic SQL and Transactions

Dynamic SQL can execute statements that read or modify data. Transaction behavior depends on the statement being executed and the surrounding transaction.

Be careful with statements such as `INSERT`, `UPDATE`, and `DELETE`. Validate inputs, test with sample data, and use transactions where appropriate.

Some statements, including many DDL statements, cause implicit commits. Do not assume every dynamically executed statement can be rolled back.

## 9. Error Handling and Cleanup

A prepared statement should be deallocated after successful execution. If an error occurs, cleanup may also be necessary.

Stored procedures can use an exception handler to release a prepared statement and then re-signal the error.

SQL

```
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
    DEALLOCATE PREPARE stmt;
    RESIGNAL;
END;
```

This pattern is appropriate only when the prepared statement is known to exist when the handler runs. If preparation itself can fail, track whether the statement was successfully prepared before attempting to deallocate it.

Prepared statement names are session-level resources. Avoid reusing names that may belong to unrelated code in the same session.

## 10. Limitations of Dynamic SQL

* Placeholders represent values, not identifiers.

* Prepared statements inside stored programs cannot directly use local variables.

* Dynamic SQL is harder to read, debug, and maintain.

* Incorrect string construction can produce syntax errors.

* Unvalidated identifiers can create security vulnerabilities.

* Prepared statements require explicit lifecycle management.

## 11. Dynamic SQL vs. Static SQL

Use static SQL when the query structure is known in advance. It is usually simpler and easier to maintain.

Use dynamic SQL when the query structure genuinely needs to change at runtime, such as selecting among approved tables or choosing a report column.

Do not use dynamic SQL merely to make a fixed query look more flexible.

## 12. Best Practices

1. Prefer static SQL whenever possible.

2. Use placeholders for data values.

3. Never concatenate untrusted values into SQL.

4. Validate dynamic table and column names with allowlists.

5. Validate sorting direction and other SQL keywords.

6. Use clear prepared statement names.

7. Deallocate prepared statements after use.

8. Handle errors and cleanup deliberately.

9. Test invalid inputs as well as valid inputs.

10. Keep dynamically generated SQL readable and easy to inspect.

## Summary

Dynamic SQL allows MySQL statements to be constructed at runtime. Prepared statements provide a controlled way to execute these statements, while placeholders separate data values from SQL syntax.

The most important distinction is that values can be parameterized, but identifiers such as table and column names must be validated before being inserted into a query string.

Dynamic SQL is powerful when query structure must vary, but static SQL remains preferable whenever it can solve the problem.
