# Module 34: Cursors in MySQL

## Overview

A cursor in MySQL allows a stored program to process the rows returned by a query one row at a time.

SQL is designed to work with sets of rows. In many situations, a single SQL statement can process an entire result set efficiently. However, some tasks require row-by-row processing, such as applying different business rules to individual records, generating customized reports, or performing sequential operations.

MySQL cursors are available within stored programs, including stored procedures. They are read-only and non-scrollable, meaning you cannot use them to update rows directly through the cursor or move freely backward and forward through the result set.

In this module, you will learn how to declare, open, fetch from, and close cursors, as well as how to combine cursors with loops, conditions, and error handlers.

## 1. What Is a Cursor?

A cursor is a database object used by a stored program to navigate through the rows returned by a query.

Consider an employees table containing hundreds of employees. A regular SELECT statement retrieves the matching rows together. A cursor allows a stored procedure to retrieve one row, process it, retrieve the next row, and continue until no rows remain.

The general cursor workflow consists of four steps:

1. Declare the cursor.
2. Open the cursor.
3. Fetch rows from the cursor.
4. Close the cursor.

A cursor must be declared before it is opened. It must be opened before fetching rows, and it should be closed when processing is complete.

## 2. Declaring a Cursor

Use the DECLARE CURSOR statement to define the query that supplies the cursor's rows.

### Syntax

```sql
DECLARE cursor_name CURSOR FOR
SELECT column1, column2
FROM table_name;
````

For example:

SQL

```
DECLARE employee_cursor CURSOR FOR
SELECT employee_id, employee_name
FROM employees;
```

This declaration defines a cursor named employee_cursor. Its result set contains the employee ID and employee name of every row returned by the SELECT statement.

The cursor declaration does not execute the query immediately. The query is associated with the cursor and is processed when the cursor is opened.

## 3. Opening a Cursor

Use OPEN to open a declared cursor.

SQL

```
OPEN employee_cursor;
```

Opening the cursor makes its result set available for fetching. The cursor must be open before FETCH can be used.

A cursor should be opened only after its declaration and after any variables or handlers required by the procedure have been declared.

## 4. Fetching Rows

The FETCH statement retrieves the next row from an open cursor and assigns its column values to variables.

### Syntax

SQL

```
FETCH cursor_name
INTO variable1, variable2;
```

Example:

SQL

```
FETCH employee_cursor
INTO v_employee_id, v_employee_name;
```

The number and order of variables must correspond to the columns in the cursor's SELECT statement. Their data types should be compatible with the selected columns.

Each FETCH advances the cursor to the next row. When no more rows are available, MySQL raises the NOT FOUND condition.

## 5. Handling the End of a Cursor

A cursor loop must know when it has reached the end of its result set. MySQL signals this condition through NOT FOUND.

A common approach is to declare a CONTINUE handler that changes a flag when no more rows are available.

SQL

```
DECLARE v_done BOOLEAN DEFAULT FALSE;

DECLARE CONTINUE HANDLER FOR NOT FOUND
    SET v_done = TRUE;
```

When FETCH cannot retrieve another row, the handler sets v_done to TRUE. The loop can then stop.

The handler must be declared before executable statements in the stored-program block.

### Important

NOT FOUND is not exclusive to cursors. It can also be raised by a SELECT ... INTO statement that returns no rows. If both operations share the same handler scope, a missing SELECT result can accidentally mark the cursor as finished.

For this reason, keep cursor processing in a carefully designed block, and use separate handler scopes when necessary.

## 6. Closing a Cursor

Use CLOSE to release the cursor when processing is complete.

SQL

```
CLOSE employee_cursor;
```

Closing a cursor is important because it releases the resources associated with the cursor.

A cursor that has been closed cannot be fetched from again unless it is reopened.

## 7. The Complete Cursor Structure

The following example demonstrates the overall structure of a cursor-based stored procedure.

SQL

```
DELIMITER //

CREATE PROCEDURE process_employees()
BEGIN
    DECLARE v_done BOOLEAN DEFAULT FALSE;
    DECLARE v_employee_id INT;
    DECLARE v_employee_name VARCHAR(100);

    DECLARE employee_cursor CURSOR FOR
        SELECT employee_id, employee_name
        FROM employees;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET v_done = TRUE;

    OPEN employee_cursor;

    employee_loop: LOOP
        FETCH employee_cursor
        INTO v_employee_id, v_employee_name;

        IF v_done THEN
            LEAVE employee_loop;
        END IF;

        SELECT
            v_employee_id AS employee_id,
            v_employee_name AS employee_name;
    END LOOP;

    CLOSE employee_cursor;
END //

DELIMITER ;
```

The procedure declares its variables, cursor, and handler before executing any statements. It then opens the cursor and enters a loop.

Each iteration fetches one row. If the end-of-data handler sets v_done to TRUE, the loop exits. Otherwise, the current row is processed. Once all rows have been handled, the cursor is closed.

The SELECT inside this example produces a result set for each iteration. In real applications, consider accumulating results or writing to a destination table when returning a separate result set for every row would be inconvenient.

## 8. Using a Cursor with a WHILE Loop

A cursor can also be processed using a WHILE loop.

SQL

```
OPEN employee_cursor;

FETCH employee_cursor
INTO v_employee_id, v_employee_name;

WHILE v_done = FALSE DO
    -- Process the current row.

    FETCH employee_cursor
    INTO v_employee_id, v_employee_name;
END WHILE;

CLOSE employee_cursor;
```

This pattern performs the first FETCH before entering the loop. Each iteration processes the current row and fetches the next one.

If the first FETCH finds no rows, the handler sets v_done to TRUE and the loop is skipped.

The LOOP pattern is often easier to follow because the FETCH and end-of-data check appear together.

## 9. Using a Cursor with Conditional Logic

Cursor processing can include IF and CASE statements to apply different operations to different rows.

For example, a procedure could apply one adjustment to employees earning below a threshold and another adjustment to employees earning above it.

SQL

```
IF v_salary < 40000 THEN
    -- Apply the first business rule.
ELSE
    -- Apply the alternative business rule.
END IF;
```

The appropriate action depends on the business requirements. Whenever possible, prefer a set-based UPDATE with CASE when the same transformation can be expressed in one SQL statement.

## 10. Cursors and Temporary Tables

A cursor can read rows from a temporary table, allowing a stored procedure to process an intermediate result set.

This can be useful when the rows to process are first selected, filtered, or transformed into a working dataset.

SQL

```
CREATE TEMPORARY TABLE temp_employee_work AS
SELECT employee_id, employee_name
FROM employees
WHERE department_id = 10;
```

A cursor can then be declared over temp_employee_work.

Temporary tables and cursors solve different problems: a temporary table stores an intermediate result, while a cursor provides sequential access to its rows.

## 11. Cursors and Error Handling

Cursors should be used with appropriate error handling.

The NOT FOUND handler is commonly used to detect the end of the result set. Other SQL errors may require an SQLEXCEPTION handler.

When a procedure fails after opening a cursor, ensure that the cursor is closed where appropriate. An EXIT handler can be used to perform cleanup before propagating an error with RESIGNAL.

Be careful with handler scope. A handler declared in an outer block may affect statements executed within nested blocks. Narrow handler scopes can make cursor behavior easier to reason about.

## 12. Nested Blocks and Cursor Scope

A cursor must be declared within a stored-program block. Its scope is limited to that block and its applicable nested statements.

Nested BEGIN ... END blocks can be useful when a procedure needs separate handlers for different operations.

For example, a nested block can contain a SELECT ... INTO statement with its own NOT FOUND handler, while the cursor loop uses a different handler.

This prevents a missing lookup row from being confused with the end of the cursor's result set.

## 13. Cursor Limitations

MySQL cursors have several important limitations:

* They are read-only.

* They are non-scrollable.

* They process rows sequentially.

* They are available within stored programs rather than as general-purpose client-side cursor objects.

* They can introduce overhead when processing large result sets row by row.

Because cursors process rows sequentially, they are generally less efficient than set-based SQL operations for large-scale data transformations.

## 14. Cursors vs. Set-Based SQL

A set-based statement operates on multiple rows as a single SQL operation. A cursor processes rows one at a time.

For example, increasing every employee's salary by 5% is usually best handled with:

SQL

```
UPDATE employees
SET salary = salary * 1.05;
```

A cursor would require fetching each employee and applying the change individually. That adds complexity and overhead without providing a benefit for this simple task.

Use a cursor when individual row-by-row processing is genuinely required, not simply because it is possible.

## 15. Common Mistakes

### Forgetting to open the cursor

FETCH cannot be used on a cursor that has not been opened.

### Forgetting to close the cursor

Close the cursor after processing is complete, and consider cleanup if an exception occurs.

### Incorrect FETCH variable order

The variables must match the selected columns in number and order.

### Missing NOT FOUND handler

Without an appropriate handler, reaching the end of the result set can terminate the procedure with an unhandled condition.

### Checking the completion flag too late

Always check the flag immediately after FETCH and before processing the fetched variables. When no row is returned, those variables must not be treated as a newly fetched record.

### Using one NOT FOUND handler for unrelated operations

A missing SELECT ... INTO result can trigger the same handler used for cursor completion. Use separate blocks and handlers when needed.

### Using cursors for simple updates

Prefer a set-based UPDATE, INSERT ... SELECT, or DELETE when the task can be performed directly in SQL.

## 16. Best Practices

* Prefer set-based SQL whenever it can solve the problem clearly.

* Use descriptive cursor and variable names.

* Keep cursor queries focused and return only the columns required.

* Declare variables, cursors, and handlers in the correct order.

* Use a NOT FOUND handler to detect the end of the result set.

* Check the completion flag immediately after FETCH.

* Close cursors when processing is complete.

* Keep handler scopes narrow when a procedure contains multiple operations that can raise NOT FOUND.

* Avoid returning a separate result set for every fetched row unless that behavior is intentional.

* Test procedures with zero rows, one row, and multiple rows.

* Test exception paths as well as successful execution.

## 17. Practice Checklist

By the end of this module, you should be able to:

* Explain what a cursor is and when it is useful.

* Declare a cursor using DECLARE ... CURSOR FOR.

* Open and close a cursor.

* Fetch cursor rows into variables.

* Use a NOT FOUND handler to detect the end of a result set.

* Process cursor rows with LOOP and WHILE.

* Combine cursors with IF and CASE statements.

* Use nested blocks to manage handler scope.

* Apply error handling and cleanup to cursor-based procedures.

* Explain when set-based SQL is preferable to a cursor.

## Summary

Cursors allow MySQL stored programs to process query results one row at a time. Their core workflow is DECLARE, OPEN, FETCH, and CLOSE. A NOT FOUND handler is commonly used to detect when no additional rows remain.

Cursors are useful for certain sequential business processes, but they should not replace set-based SQL when a single statement can perform the same task more efficiently.
