# Module 33: Error Handling & Diagnostics in MySQL

## Overview

Error handling is an essential part of writing reliable database programs. SQL statements can fail for many reasons, including duplicate values, missing records, invalid input, constraint violations, and unexpected database conditions.

Without appropriate error handling, a stored program may terminate unexpectedly or leave an operation incomplete.

MySQL provides several mechanisms for handling and investigating errors inside stored programs:

- `DECLARE ... HANDLER`
- `CONTINUE` handlers
- `EXIT` handlers
- `SQLEXCEPTION`
- `SQLWARNING`
- `NOT FOUND`
- `SIGNAL`
- `RESIGNAL`
- `GET DIAGNOSTICS`
- Named conditions
- Transaction-aware error handling

These mechanisms allow developers to detect errors, respond appropriately, communicate meaningful messages, and inspect diagnostic information.

---

## 1. What Is Error Handling?

Error handling is the process of detecting an error or exceptional condition and deciding what the program should do next.

Consider an attempt to insert a duplicate primary key:

```sql
INSERT INTO employees (
    employee_id,
    employee_name
)
VALUES (
    1,
    'Aarav Sharma'
);
````

If employee ID `1` already exists, MySQL raises a duplicate-key error.

Without a suitable handler, the statement fails and the stored program may terminate.

A handler can allow the program to respond to the error in a controlled way.

Error handling is especially useful in:

* Stored procedures

* Stored functions

* Transactions

* Data imports

* Batch processing

* Automated database operations

* Data validation

* Application-facing database routines

## 2. Types of SQL Conditions

MySQL conditions can represent errors, warnings, and other exceptional situations.

Three commonly used condition classes are:

|
Condition

|

Meaning

|
| --- | --- |
|

`SQLEXCEPTION`

|

An SQL exception other than an SQL warning or `NOT FOUND` condition

|
|

`SQLWARNING`

|

An SQL warning condition

|
|

`NOT FOUND`

|

A condition commonly raised when a query or cursor fetch finds no row

|

These condition classes are frequently used with `DECLARE ... HANDLER`.

## 3. The DECLARE ... HANDLER Statement

A handler specifies what MySQL should do when a particular condition occurs.

Basic syntax:

SQL

```
DECLARE handler_type HANDLER
FOR condition_value
handler_statement;
```

The handler type determines how execution continues.

The two primary handler types are:

* `CONTINUE`

* `EXIT`

Example:

SQL

```
DECLARE CONTINUE HANDLER
FOR SQLEXCEPTION
BEGIN
    SET error_occurred = TRUE;
END;
```

This handler sets a variable when an SQL exception occurs and allows execution to continue after the statement that raised the condition.

A handler does not automatically fix the underlying error. The program must decide what response is appropriate.

## 4. CONTINUE Handler

A `CONTINUE` handler handles the condition and allows execution to continue after the statement that raised it.

Example:

SQL

```
DELIMITER //

CREATE PROCEDURE continue_handler_example()
BEGIN
    DECLARE error_occurred BOOLEAN DEFAULT FALSE;

    DECLARE CONTINUE HANDLER
    FOR SQLEXCEPTION
    BEGIN
        SET error_occurred = TRUE;
    END;

    INSERT INTO employees (
        employee_id,
        employee_name
    )
    VALUES (
        1,
        'Example Employee'
    );

    SELECT error_occurred AS error_occurred;
END //

DELIMITER ;
```

If the insert raises an SQL exception, the handler sets the flag. Execution then continues with the next statement.

The insert itself is not automatically repeated or corrected.

Use `CONTINUE` when the program can safely continue after handling the condition.

## 5. EXIT Handler

An `EXIT` handler handles the condition and terminates execution of the `BEGIN ... END` block in which the handler is declared.

Example:

SQL

```
DELIMITER //

CREATE PROCEDURE exit_handler_example()
BEGIN
    DECLARE error_occurred BOOLEAN DEFAULT FALSE;

    DECLARE EXIT HANDLER
    FOR SQLEXCEPTION
    BEGIN
        SET error_occurred = TRUE;
        SELECT error_occurred AS error_occurred;
    END;

    INSERT INTO employees (
        employee_id,
        employee_name
    )
    VALUES (
        1,
        'Example Employee'
    );

    SELECT 'This statement may not execute'
    AS message;
END //

DELIMITER ;
```

If an SQL exception occurs within the handled block, the handler executes and control exits that block.

The exact scope matters: an `EXIT` handler exits the block in which it was declared, not necessarily the entire stored program.

## 6. CONTINUE vs EXIT

|
Feature

|

CONTINUE

|

EXIT

|
| --- | --- | --- |
|

Handles the condition

|

Yes

|

Yes

|
|

Continues after the failing statement

|

Yes

|

No

|
|

Exits the handler's enclosing block

|

No

|

Yes

|
|

Useful for recoverable conditions

|

Yes

|

Yes, when the block should stop

|

The correct choice depends on whether execution can safely continue.

For example, a duplicate optional record may be handled with `CONTINUE`. A failed payment or incomplete financial operation may require an `EXIT` handler and transaction rollback.

## 7. Handler Declaration Order

MySQL requires declarations in a specific order within a stored program block.

The general order is:

1. Local variables

2. Named conditions

3. Cursors

4. Handlers

5. Executable statements

Example:

SQL

```
BEGIN
    DECLARE total INT DEFAULT 0;
    DECLARE no_more_rows BOOLEAN DEFAULT FALSE;

    DECLARE CONTINUE HANDLER
    FOR NOT FOUND
        SET no_more_rows = TRUE;

    -- Executable statements begin here.
END;
```

Declaring a handler after executable statements causes a syntax error.

This rule is important when combining variables, cursors, conditions, and handlers.

## 8. Handling SQLEXCEPTION

`SQLEXCEPTION` is commonly used to handle SQL errors.

Example:

SQL

```
DELIMITER //

CREATE PROCEDURE handle_sql_exception()
BEGIN
    DECLARE CONTINUE HANDLER
    FOR SQLEXCEPTION
    BEGIN
        SELECT 'An SQL exception occurred'
        AS error_message;
    END;

    INSERT INTO departments (
        department_id,
        department_name
    )
    VALUES (
        1,
        'Engineering'
    );
END //

DELIMITER ;
```

This example catches SQL exceptions raised within the handler's scope.

In production code, a generic message is often insufficient. Consider recording diagnostic information or re-raising the error when the caller needs to know that the operation failed.

## 9. Handling SQLWARNING

`SQLWARNING` handles SQL warning conditions.

Example:

SQL

```
DECLARE CONTINUE HANDLER
FOR SQLWARNING
BEGIN
    SET warning_occurred = TRUE;
END;
```

Warnings can indicate issues such as data truncation or other nonfatal conditions, depending on the statement and SQL mode.

Warnings are different from errors. A statement can complete while producing a warning.

Use warning handlers when the program needs to detect and respond to warning conditions.

## 10. Handling NOT FOUND

`NOT FOUND` is frequently used with cursors and `SELECT ... INTO`.

For example, a `SELECT ... INTO` statement that returns no rows raises a `NOT FOUND` condition.

Example:

SQL

```
DELIMITER //

CREATE PROCEDURE find_employee(
    IN employee_id_value INT
)
BEGIN
    DECLARE employee_name_value VARCHAR(100);
    DECLARE employee_not_found BOOLEAN DEFAULT FALSE;

    DECLARE CONTINUE HANDLER
    FOR NOT FOUND
        SET employee_not_found = TRUE;

    SELECT employee_name
    INTO employee_name_value
    FROM employees
    WHERE employee_id = employee_id_value;

    IF employee_not_found THEN
        SELECT 'Employee not found' AS message;
    ELSE
        SELECT employee_name_value AS employee_name;
    END IF;
END //

DELIMITER ;
```

The handler allows the procedure to detect the missing row without immediately terminating.

A query that returns multiple rows into a single scalar variable raises a different error. A `NOT FOUND` handler does not handle that error.

## 11. Named Conditions

A named condition gives a meaningful name to an SQL condition.

Syntax:

SQL

```
DECLARE condition_name CONDITION
FOR condition_value;
```

A condition can be associated with an SQLSTATE or a MySQL error number.

Example using SQLSTATE:

SQL

```
DECLARE duplicate_condition CONDITION
FOR SQLSTATE '23000';
```

Example using a MySQL error number:

SQL

```
DECLARE duplicate_key_condition CONDITION
FOR 1062;
```

The named condition can then be used in a handler.

SQL

```
DECLARE CONTINUE HANDLER
FOR duplicate_key_condition
BEGIN
    SET duplicate_found = TRUE;
END;
```

Named conditions improve readability, especially when a stored program contains several handlers.

## 12. SQLSTATE

SQLSTATE is a five-character code that identifies a class of SQL conditions.

For example:

```
23000
```

represents an integrity constraint violation class.

Another important value is:

```
45000
```

which is commonly used for user-defined exceptions raised with `SIGNAL`.

SQLSTATE codes are useful because they provide a standardized way to identify conditions.

The specific MySQL error number and message can provide additional information.

## 13. MySQL Error Numbers

MySQL assigns numeric error codes to specific errors.

For example:

```
1062
```

represents a duplicate-entry error.

A handler can target that specific error:

SQL

```
DECLARE CONTINUE HANDLER
FOR 1062
BEGIN
    SET duplicate_found = TRUE;
END;
```

Error numbers can be useful when a program needs to respond to one particular MySQL error rather than every SQL exception.

However, SQLSTATE-based conditions can be more portable across database systems.

## 14. SIGNAL

`SIGNAL` allows a stored program to raise a condition deliberately.

It is useful for enforcing business rules and rejecting invalid input.

Basic syntax:

SQL

```
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'A meaningful error message';
```

Example:

SQL

```
DELIMITER //

CREATE PROCEDURE validate_salary(
    IN salary_value DECIMAL(10, 2)
)
BEGIN
    IF salary_value < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Salary cannot be negative';
    END IF;

    SELECT salary_value AS validated_salary;
END //

DELIMITER ;
```

Calling the procedure with a negative salary raises a user-defined error.

SQL

```
CALL validate_salary(-1000);
```

The procedure does not continue normally after the unhandled signal.

## 15. SIGNAL with Business Rules

`SIGNAL` can enforce application-specific rules.

For example, an order total must be positive.

SQL

```
DELIMITER //

CREATE PROCEDURE validate_order_total(
    IN total_value DECIMAL(10, 2)
)
BEGIN
    IF total_value IS NULL OR total_value <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Order total must be positive';
    END IF;

    SELECT total_value AS valid_total;
END //

DELIMITER ;
```

This prevents invalid values from proceeding through the procedure's normal execution path.

Validation should also be supported by appropriate table constraints whenever possible.

## 16. SIGNAL with Named Conditions

A named condition can be used with `SIGNAL`.

Example:

SQL

```
DELIMITER //

CREATE PROCEDURE check_quantity(
    IN quantity_value INT
)
BEGIN
    DECLARE invalid_quantity CONDITION
        FOR SQLSTATE '45000';

    IF quantity_value <= 0 THEN
        SIGNAL invalid_quantity
        SET MESSAGE_TEXT = 'Quantity must be greater than zero';
    END IF;

    SELECT quantity_value AS valid_quantity;
END //

DELIMITER ;
```

Named conditions make business-rule errors easier to identify in the code.

## 17. RESIGNAL

`RESIGNAL` is used inside a condition handler to raise the condition again.

It allows a handler to perform additional work before allowing the error to propagate.

Example:

SQL

```
DELIMITER //

CREATE PROCEDURE rethrow_error_example()
BEGIN
    DECLARE EXIT HANDLER
    FOR SQLEXCEPTION
    BEGIN
        SELECT 'An error occurred' AS diagnostic_message;
        RESIGNAL;
    END;

    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Example failure';
END //

DELIMITER ;
```

The handler executes its diagnostic statement and then re-raises the original condition.

`RESIGNAL` is intended for use within an active condition handler.

Do not confuse it with `SIGNAL`, which raises a condition explicitly.

## 18. Changing an Error Message with RESIGNAL

`RESIGNAL` can also specify condition information.

Example:

SQL

```
RESIGNAL
SET MESSAGE_TEXT = 'The operation could not be completed';
```

This changes the message associated with the condition being re-raised.

Use this carefully. Replacing the original message can hide useful information about the underlying failure.

Where appropriate, preserve the original condition details.

## 19. GET DIAGNOSTICS

`GET DIAGNOSTICS` retrieves information about the most recent statement's diagnostic area.

It can retrieve information such as:

* The number of conditions

* The number of affected rows

* The MySQL error number

* The returned SQLSTATE

* The error message

Example:

SQL

```
GET DIAGNOSTICS
    condition_count = NUMBER;
```

This retrieves the number of conditions in the current diagnostics area.

To retrieve information about a particular condition:

SQL

```
GET DIAGNOSTICS CONDITION 1
    error_number = MYSQL_ERRNO,
    error_message = MESSAGE_TEXT,
    error_state = RETURNED_SQLSTATE;
```

These diagnostics can be stored in local variables and used for logging or reporting.

## 20. Retrieving Error Details in a Handler

A handler can capture diagnostic information.

Example:

SQL

```
DELIMITER //

CREATE PROCEDURE capture_error_details()
BEGIN
    DECLARE error_number INT;
    DECLARE error_message TEXT;
    DECLARE error_state CHAR(5);

    DECLARE EXIT HANDLER
    FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            error_number = MYSQL_ERRNO,
            error_message = MESSAGE_TEXT,
            error_state = RETURNED_SQLSTATE;

        SELECT
            error_number AS mysql_error_number,
            error_state AS sqlstate_code,
            error_message AS error_message;

        RESIGNAL;
    END;

    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Example diagnostic error';
END //

DELIMITER ;
```

The handler captures the diagnostic details and then re-raises the error.

The caller still receives an error, while the handler can inspect the original condition.

## 21. GET DIAGNOSTICS and Affected Rows

`GET DIAGNOSTICS` can retrieve the number of rows affected by a statement.

Example:

SQL

```
DECLARE affected_rows INT DEFAULT 0;

UPDATE employees
SET salary = salary + 1000
WHERE department_id = 1;

GET DIAGNOSTICS affected_rows = ROW_COUNT;
```

The variable stores the number of rows affected by the update.

Use this when a procedure needs to report or validate the result of a data modification.

Retrieve diagnostics immediately after the relevant statement, before executing another statement that could replace the diagnostic information you need.

## 22. Error Logging Tables

A database application may store error information in a dedicated logging table.

Example:

SQL

```
CREATE TABLE error_log (
    log_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    error_number INT,
    sqlstate_code CHAR(5),
    error_message TEXT,
    logged_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

A handler could capture diagnostic information and insert it into this table.

However, error logging must be designed carefully.

If a transaction is rolled back, an error-log insert performed within that same transaction may also be rolled back.

A logging design should account for transaction boundaries and the importance of preserving the original error.

## 23. Transactions and Error Handling

Transactions group related database operations into one logical unit.

For example:

SQL

```
START TRANSACTION;

UPDATE accounts
SET balance = balance - 500
WHERE account_id = 1;

UPDATE accounts
SET balance = balance + 500
WHERE account_id = 2;

COMMIT;
```

If one of the operations fails, committing a partial transfer would be incorrect.

An error handler can roll back the transaction.

Example:

SQL

```
DELIMITER //

CREATE PROCEDURE transfer_example()
BEGIN
    DECLARE EXIT HANDLER
    FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    -- Perform related updates here.

    COMMIT;
END //

DELIMITER ;
```

The handler rolls back and re-raises the error.

This pattern is useful for transactional operations that must succeed or fail as a unit.

## 24. Why ROLLBACK Matters

`ROLLBACK` undoes changes made in the current transaction that have not been committed.

It helps prevent partial updates when an operation fails.

For transactional tables such as InnoDB, rollback can undo transactional data modifications.

However, not every database operation is necessarily transactional. Some statements cause implicit commits, and changes to nontransactional tables cannot be rolled back in the same way.

Design transaction boundaries carefully.

## 25. Avoid Swallowing Errors

A handler that catches an error and simply continues can make a failed operation appear successful.

For example:

SQL

```
DECLARE CONTINUE HANDLER
FOR SQLEXCEPTION
BEGIN
    SET error_occurred = TRUE;
END;
```

This may be appropriate when the program explicitly checks the flag and responds correctly.

It is dangerous when the program ignores the flag and reports success.

For critical operations, consider using an `EXIT` handler and `RESIGNAL` so the caller is informed of the failure.

## 26. Handling Duplicate Entries

Duplicate-key errors are common when inserting records into tables with primary keys or unique constraints.

A handler can respond to MySQL error `1062`.

Example:

SQL

```
DELIMITER //

CREATE PROCEDURE insert_department(
    IN department_id_value INT,
    IN department_name_value VARCHAR(100)
)
BEGIN
    DECLARE duplicate_found BOOLEAN DEFAULT FALSE;

    DECLARE CONTINUE HANDLER
    FOR 1062
        SET duplicate_found = TRUE;

    INSERT INTO departments (
        department_id,
        department_name
    )
    VALUES (
        department_id_value,
        department_name_value
    );

    IF duplicate_found THEN
        SELECT 'Duplicate department' AS message;
    ELSE
        SELECT 'Department inserted' AS message;
    END IF;
END //

DELIMITER ;
```

This example illustrates how a specific error can be handled without catching every SQL exception.

## 27. Cursor Error Handling

Cursors process query results one row at a time.

When a cursor has no more rows to fetch, MySQL raises a `NOT FOUND` condition.

A common pattern is:

SQL

```
DECLARE done BOOLEAN DEFAULT FALSE;

DECLARE employee_cursor CURSOR FOR
    SELECT employee_id
    FROM employees;

DECLARE CONTINUE HANDLER
FOR NOT FOUND
    SET done = TRUE;
```

The processing loop checks the flag after each fetch.

Example:

SQL

```
OPEN employee_cursor;

read_loop: LOOP
    FETCH employee_cursor INTO employee_id_value;

    IF done THEN
        LEAVE read_loop;
    END IF;

    -- Process the current row.
END LOOP;

CLOSE employee_cursor;
```

The cursor, variables, and handler must be declared in the correct order.

A `NOT FOUND` handler can also be triggered by other statements in the same block. In more complex routines, use nested blocks to keep handler scope precise.

## 28. Nested Blocks and Handler Scope

Handlers apply to the block in which they are declared and its applicable nested execution.

Nested blocks can be used to isolate error handling.

Example:

SQL

```
BEGIN
    DECLARE outer_error BOOLEAN DEFAULT FALSE;

    DECLARE CONTINUE HANDLER
    FOR SQLEXCEPTION
        SET outer_error = TRUE;

    BEGIN
        DECLARE inner_error BOOLEAN DEFAULT FALSE;

        DECLARE CONTINUE HANDLER
        FOR SQLEXCEPTION
            SET inner_error = TRUE;

        -- Statements in the inner block.
    END;

    -- Statements in the outer block.
END;
```

A more local handler can handle a condition before an outer handler is considered.

Use nested blocks when different parts of a procedure require different recovery behavior.

## 29. Handler Precedence

When more than one handler could apply to a condition, MySQL uses handler precedence rules.

In general:

1. A handler for a specific MySQL error code has higher precedence than a handler for an SQLSTATE.

2. A handler for a specific SQLSTATE has higher precedence than a handler for a general condition class such as `SQLEXCEPTION`.

If multiple applicable handlers have the same precedence, the result may be indeterminate.

Avoid ambiguous handler designs.

Prefer clear, specific conditions and deliberate handler scopes.

## 30. Error Handling in Stored Functions

Stored functions can also declare handlers.

Example:

SQL

```
DELIMITER //

CREATE FUNCTION safe_divide(
    numerator DECIMAL(10, 2),
    denominator DECIMAL(10, 2)
)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
NO SQL
BEGIN
    IF denominator IS NULL OR denominator = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Denominator must not be zero or NULL';
    END IF;

    RETURN numerator / denominator;
END //

DELIMITER ;
```

This function deliberately raises an error when the denominator is invalid.

Alternatively, a function could return `NULL` for invalid input, depending on the business requirements.

Choose and document one behavior rather than allowing it to happen accidentally.

## 31. Input Validation

Input validation checks whether supplied values satisfy the required rules.

For example, an order quantity should be positive.

SQL

```
IF quantity_value IS NULL OR quantity_value <= 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Quantity must be greater than zero';
END IF;
```

Validation should occur before performing operations that depend on the input.

Database constraints should also enforce data integrity wherever possible.

## 32. Error Messages and Sensitive Information

Error messages should be useful without exposing confidential information.

Avoid returning:

* Passwords

* Authentication tokens

* Private connection details

* Sensitive personal information

* Unnecessary internal implementation details

Detailed diagnostics are useful for controlled debugging and logging.

Applications may need to return a safer, more general message to end users while preserving technical details in an appropriately protected log.

## 33. Common Mistakes

### Mistake 1: Declaring handlers after executable statements

Declarations must appear before executable statements within a block.

### Mistake 2: Using CONTINUE without checking the result

The program may continue after a failure and produce incorrect results.

### Mistake 3: Using EXIT without understanding scope

An EXIT handler exits its enclosing block, which may be a nested block rather than the entire routine.

### Mistake 4: Catching every exception unnecessarily

A broad handler may hide errors that should be handled differently.

### Mistake 5: Forgetting RESIGNAL

A handler may accidentally suppress an error that the caller needs to know about.

### Mistake 6: Ignoring transaction rollback

A failed operation may leave partial changes if transactional work is not rolled back.

### Mistake 7: Losing diagnostic information

Executing other statements before retrieving diagnostics can make it harder to inspect the original error.

### Mistake 8: Using handlers as a replacement for constraints

Primary keys, foreign keys, unique constraints, and check constraints remain important for data integrity.

### Mistake 9: Assuming every SQL statement is transactional

Some statements cause implicit commits, and nontransactional tables do not provide ordinary rollback behavior.

### Mistake 10: Exposing sensitive diagnostics

Error messages and logs should be designed with security in mind.

## 34. Best Practices

1. Use specific handlers when possible.

2. Choose `CONTINUE` or `EXIT` based on the required control flow.

3. Declare variables, conditions, cursors, and handlers in the correct order.

4. Use `SIGNAL` to reject invalid business inputs.

5. Use `RESIGNAL` when an error must propagate to the caller.

6. Capture diagnostics when useful.

7. Retrieve diagnostic information promptly.

8. Use transactions for operations that must succeed or fail together.

9. Roll back failed transactional operations.

10. Do not silently ignore errors.

11. Use table constraints to enforce data integrity.

12. Keep error messages clear and safe.

13. Avoid ambiguous handlers with equal precedence.

14. Test both successful and unsuccessful execution paths.

15. Keep handler scopes as narrow as practical.

## 35. Testing Error Handling

A stored program should be tested with both valid and invalid inputs.

Useful test cases include:

* A valid employee ID

* A nonexistent employee ID

* A duplicate primary key

* A duplicate unique value

* A `NULL` input

* A negative quantity

* A zero denominator

* A foreign-key violation

* A failed update inside a transaction

* A warning-producing statement

For each test, verify:

* Whether an error or warning occurs

* Which handler executes

* Whether execution continues or exits

* Whether changes are committed or rolled back

* Whether the caller receives the expected error

* Whether diagnostic information is accurate

## 36. Key Syntax Summary

### CONTINUE handler

SQL

```
DECLARE CONTINUE HANDLER
FOR SQLEXCEPTION
BEGIN
    -- Handle the condition.
END;
```

### EXIT handler

SQL

```
DECLARE EXIT HANDLER
FOR SQLEXCEPTION
BEGIN
    -- Handle the condition.
END;
```

### Specific error handler

SQL

```
DECLARE CONTINUE HANDLER
FOR 1062
BEGIN
    -- Handle duplicate-entry error.
END;
```

### Named condition

SQL

```
DECLARE duplicate_condition CONDITION
FOR SQLSTATE '23000';
```

### SIGNAL

SQL

```
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Invalid input';
```

### RESIGNAL

SQL

```
RESIGNAL;
```

### Retrieve diagnostic information

SQL

```
GET DIAGNOSTICS CONDITION 1
    error_number = MYSQL_ERRNO,
    error_message = MESSAGE_TEXT,
    error_state = RETURNED_SQLSTATE;
```

### Retrieve affected row count

SQL

```
GET DIAGNOSTICS affected_rows = ROW_COUNT;
```

### Roll back and re-raise an error

SQL

```
DECLARE EXIT HANDLER
FOR SQLEXCEPTION
BEGIN
    ROLLBACK;
    RESIGNAL;
END;
```

## 37. Important Takeaways

* Error handling makes stored programs more reliable.

* `DECLARE ... HANDLER` specifies how conditions are handled.

* `CONTINUE` allows execution to proceed after the failing statement.

* `EXIT` exits the handler's enclosing block.

* `SQLEXCEPTION`, `SQLWARNING`, and `NOT FOUND` represent different condition classes.

* Named conditions make stored programs easier to read.

* `SIGNAL` raises an error deliberately.

* `RESIGNAL` re-raises a condition from within a handler.

* `GET DIAGNOSTICS` retrieves information about conditions and statement results.

* `NOT FOUND` is useful for handling missing rows and cursor completion.

* Transactions and rollback help prevent partial changes.

* Handlers should not silently hide important failures.

* Diagnostic information should be retrieved promptly.

* Error messages should not expose sensitive information.

* Error handling complements, but does not replace, database constraints.

* Reliable routines should be tested with both valid and invalid inputs.

## 38. Module Completion Checklist

By completing this module, you should be able to:

* Explain the purpose of SQL error handling.

* Distinguish `CONTINUE` and `EXIT` handlers.

* Handle `SQLEXCEPTION`, `SQLWARNING`, and `NOT FOUND`.

* Declare and use named conditions.

* Raise custom errors using `SIGNAL`.

* Re-raise errors using `RESIGNAL`.

* Retrieve error information using `GET DIAGNOSTICS`.

* Handle duplicate entries and missing rows.

* Use handlers with transactions and rollback.

* Avoid silently swallowing errors.

* Design and test reliable stored programs.
  
