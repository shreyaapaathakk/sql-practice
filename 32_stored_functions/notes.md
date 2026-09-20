# Module 32: Stored Functions in MySQL

## Overview

A stored function is a named database object that accepts input values, performs a calculation or operation, and returns a single value.

Stored functions are useful when the same calculation or transformation needs to be performed repeatedly inside SQL statements.

For example, instead of repeatedly writing a calculation such as:

```sql
price * quantity
````

a stored function can encapsulate the logic:

```sql
calculate_total(price, quantity)
```

The function can then be used directly inside SQL expressions such as `SELECT`, `WHERE`, `ORDER BY`, and other statements where expressions are allowed.

Stored functions are different from stored procedures. A procedure is normally executed using `CALL`, while a function returns a value and can be used as part of an SQL expression.

---

# 1. Stored Functions vs Stored Procedures

Both stored procedures and stored functions are stored programs in MySQL, but they serve different purposes.

A stored procedure is normally used to perform a sequence of operations.

A stored function is designed to calculate or return a value.

### Procedure

```sql
CALL calculate_employee_bonus(101);
```

### Function

```sql
SELECT calculate_bonus(75000);
```

The function can be embedded directly into an SQL expression.

```sql
SELECT
    employee_name,
    calculate_bonus(salary) AS bonus
FROM employees;
```

---

# 2. Basic Stored Function Syntax

The basic syntax is:

```sql
DELIMITER //

CREATE FUNCTION function_name (
    parameter_name data_type
)
RETURNS return_data_type
DETERMINISTIC
BEGIN
    RETURN expression;
END //

DELIMITER ;
```

For example:

```sql
DELIMITER //

CREATE FUNCTION add_numbers(
    a INT,
    b INT
)
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN a + b;
END //

DELIMITER ;
```

The function can then be called:

```sql
SELECT add_numbers(10, 20);
```

Result:

```text
30
```

---

# 3. Why DELIMITER Is Used

MySQL normally uses `;` to indicate the end of a statement.

Stored functions often contain multiple statements, each ending with `;`.

Therefore, the delimiter is temporarily changed.

```sql
DELIMITER //
```

The function definition can then contain normal semicolons:

```sql
BEGIN
    DECLARE total INT;

    SET total = 10 + 20;

    RETURN total;
END //
```

After creating the function, restore the normal delimiter:

```sql
DELIMITER ;
```

`DELIMITER` is a command used by the MySQL client and related tools. It is not part of the stored function itself.

---

# 4. Parameters

Stored functions can accept input parameters.

Example:

```sql
DELIMITER //

CREATE FUNCTION calculate_total(
    price DECIMAL(10, 2),
    quantity INT
)
RETURNS DECIMAL(12, 2)
DETERMINISTIC
BEGIN
    RETURN price * quantity;
END //

DELIMITER ;
```

Call the function:

```sql
SELECT calculate_total(25.50, 4);
```

Result:

```text
102.00
```

Function parameters are input values used by the function.

Unlike stored procedures, stored functions do not use `OUT` or `INOUT` parameters in their parameter list.

---

# 5. RETURN Type

Every stored function must specify the data type of the value it returns.

Example:

```sql
RETURNS INT
```

or:

```sql
RETURNS DECIMAL(10, 2)
```

or:

```sql
RETURNS VARCHAR(100)
```

or:

```sql
RETURNS DATE
```

The returned value should be compatible with the declared return type.

Example:

```sql
CREATE FUNCTION get_discount()
RETURNS DECIMAL(5, 2)
...
```

The function should return a value appropriate for a decimal result.

---

# 6. RETURN Statement

The `RETURN` statement specifies the value returned by a function.

Example:

```sql
DELIMITER //

CREATE FUNCTION square_number(
    number_value INT
)
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN number_value * number_value;
END //

DELIMITER ;
```

Usage:

```sql
SELECT square_number(7);
```

Result:

```text
49
```

A stored function must return a value.

---

# 7. Simple Calculation Functions

Functions are useful for reusable calculations.

Example:

```sql
DELIMITER //

CREATE FUNCTION calculate_tax(
    amount DECIMAL(10, 2)
)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    RETURN amount * 0.18;
END //

DELIMITER ;
```

Use it:

```sql
SELECT calculate_tax(1000.00);
```

The function can also be used with table data:

```sql
SELECT
    employee_name,
    salary,
    calculate_tax(salary) AS estimated_tax
FROM employees;
```

---

# 8. Functions Returning Strings

A function does not have to return a number.

Example:

```sql
DELIMITER //

CREATE FUNCTION full_name(
    first_name VARCHAR(50),
    last_name VARCHAR(50)
)
RETURNS VARCHAR(101)
DETERMINISTIC
BEGIN
    RETURN CONCAT(first_name, ' ', last_name);
END //

DELIMITER ;
```

Usage:

```sql
SELECT full_name('Aarav', 'Sharma');
```

Functions can therefore encapsulate reusable string transformations.

---

# 9. Functions Returning Dates

Functions can return date values.

Example:

```sql
DELIMITER //

CREATE FUNCTION add_days_to_date(
    input_date DATE,
    number_of_days INT
)
RETURNS DATE
DETERMINISTIC
BEGIN
    RETURN DATE_ADD(input_date, INTERVAL number_of_days DAY);
END //

DELIMITER ;
```

Usage:

```sql
SELECT add_days_to_date('2026-01-01', 30);
```

---

# 10. Variables Inside Functions

A function can declare local variables.

Example:

```sql
DELIMITER //

CREATE FUNCTION calculate_bonus(
    salary DECIMAL(10, 2)
)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE bonus DECIMAL(10, 2);

    SET bonus = salary * 0.10;

    RETURN bonus;
END //

DELIMITER ;
```

The `DECLARE` statement must appear before executable statements in the block.

---

# 11. Multiple Statements

A function can contain multiple statements.

Example:

```sql
DELIMITER //

CREATE FUNCTION calculate_final_price(
    price DECIMAL(10, 2),
    discount DECIMAL(5, 2)
)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE discount_amount DECIMAL(10, 2);
    DECLARE final_price DECIMAL(10, 2);

    SET discount_amount = price * discount / 100;
    SET final_price = price - discount_amount;

    RETURN final_price;
END //

DELIMITER ;
```

Usage:

```sql
SELECT calculate_final_price(1000.00, 15);
```

---

# 12. IF Statements in Functions

Functions can contain conditional logic.

Example:

```sql
DELIMITER //

CREATE FUNCTION salary_category(
    salary DECIMAL(10, 2)
)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    IF salary >= 80000 THEN
        RETURN 'High';
    ELSEIF salary >= 50000 THEN
        RETURN 'Medium';
    ELSE
        RETURN 'Low';
    END IF;
END //

DELIMITER ;
```

Usage:

```sql
SELECT
    employee_name,
    salary,
    salary_category(salary) AS category
FROM employees;
```

---

# 13. CASE Expressions in Functions

A `CASE` expression can also be useful.

```sql
DELIMITER //

CREATE FUNCTION order_category(
    amount DECIMAL(10, 2)
)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    RETURN CASE
        WHEN amount >= 10000 THEN 'Large'
        WHEN amount >= 5000 THEN 'Medium'
        ELSE 'Small'
    END;
END //

DELIMITER ;
```

---

# 14. Handling NULL Values

Functions should consider how `NULL` values affect calculations.

For example:

```sql
SELECT 100 + NULL;
```

returns:

```text
NULL
```

A function can explicitly handle `NULL`.

```sql
DELIMITER //

CREATE FUNCTION safe_bonus(
    salary DECIMAL(10, 2)
)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    IF salary IS NULL THEN
        RETURN 0;
    END IF;

    RETURN salary * 0.10;
END //

DELIMITER ;
```

Another approach is using `COALESCE()`:

```sql
RETURN COALESCE(salary, 0) * 0.10;
```

---

# 15. DETERMINISTIC Functions

A function can be declared:

```sql
DETERMINISTIC
```

A deterministic function returns the same result when given the same input values.

Example:

```sql
DELIMITER //

CREATE FUNCTION multiply_values(
    a INT,
    b INT
)
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN a * b;
END //

DELIMITER ;
```

For:

```sql
multiply_values(5, 10)
```

the result should consistently be:

```text
50
```

---

# 16. NONDETERMINISTIC Functions

A function is nondeterministic when its result can vary even when the same arguments are supplied.

Examples include functions involving:

```sql
NOW()
```

or:

```sql
RAND()
```

Example:

```sql
DELIMITER //

CREATE FUNCTION current_timestamp_value()
RETURNS DATETIME
NOT DETERMINISTIC
BEGIN
    RETURN NOW();
END //

DELIMITER ;
```

The result can change each time the function is evaluated.

---

# 17. Function Data Access Characteristics

MySQL supports characteristics describing how a stored function interacts with data.

Common characteristics include:

```sql
NO SQL
```

```sql
CONTAINS SQL
```

```sql
READS SQL DATA
```

```sql
MODIFIES SQL DATA
```

These declarations communicate the function's relationship with SQL data.

For example, a function that performs only a calculation without accessing tables may use:

```sql
NO SQL
```

Example:

```sql
CREATE FUNCTION add_values(
    a INT,
    b INT
)
RETURNS INT
DETERMINISTIC
NO SQL
RETURN a + b;
```

A function that reads table data can be described with:

```sql
READS SQL DATA
```

These characteristics should accurately describe the function.

---

# 18. Functions That Read Data

A stored function can be designed to read database information.

For example, a function could return the number of employees in a department.

Conceptually:

```sql
DELIMITER //

CREATE FUNCTION employee_count(
    department_value INT
)
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE total_employees INT;

    SELECT COUNT(*)
    INTO total_employees
    FROM employees
    WHERE department_id = department_value;

    RETURN total_employees;
END //

DELIMITER ;
```

Usage:

```sql
SELECT employee_count(1);
```

This type of function should be designed carefully because repeatedly executing table-accessing functions can have performance implications.

---

# 19. SELECT ... INTO Inside Functions

A `SELECT ... INTO` statement can store a query result in a local variable.

Example:

```sql
DELIMITER //

CREATE FUNCTION get_employee_salary(
    employee_value INT
)
RETURNS DECIMAL(10, 2)
READS SQL DATA
BEGIN
    DECLARE employee_salary DECIMAL(10, 2);

    SELECT salary
    INTO employee_salary
    FROM employees
    WHERE employee_id = employee_value;

    RETURN employee_salary;
END //

DELIMITER ;
```

Usage:

```sql
SELECT get_employee_salary(1);
```

The query should be designed so that the expected result can be assigned correctly.

---

# 20. Handling Missing Rows

When retrieving data inside a function, consider what should happen if no matching row exists.

For example, a function could return `NULL` when an employee does not exist.

Business requirements should determine the appropriate behavior.

Do not assume that every input will always match a row.

---

# 21. Using Functions in SELECT

Stored functions can be used in `SELECT`.

```sql
SELECT
    employee_name,
    salary,
    calculate_bonus(salary) AS bonus
FROM employees;
```

This is one of the most common uses of stored functions.

---

# 22. Using Functions in WHERE

Functions can also be used in conditions.

```sql
SELECT
    employee_name,
    salary
FROM employees
WHERE calculate_bonus(salary) > 5000;
```

However, functions applied to columns can sometimes affect query performance and index usage.

For performance-sensitive queries, compare the function-based condition with an equivalent expression when possible.

---

# 23. Using Functions in ORDER BY

Functions can be used to calculate a value used for sorting.

```sql
SELECT
    employee_name,
    salary
FROM employees
ORDER BY calculate_bonus(salary) DESC;
```

---

# 24. Using Functions in Other Expressions

A stored function can participate in larger expressions.

```sql
SELECT
    employee_name,
    salary,
    salary + calculate_bonus(salary) AS total_compensation
FROM employees;
```

---

# 25. Function Naming

Use clear and descriptive names.

Good examples:

```text
calculate_bonus
calculate_tax
get_employee_count
get_employee_salary
format_employee_name
calculate_discount
```

Avoid vague names such as:

```text
func1
test
abc
calculate
```

A function name should communicate its purpose.

---

# 26. Dropping a Stored Function

To remove a function:

```sql
DROP FUNCTION function_name;
```

For example:

```sql
DROP FUNCTION IF EXISTS calculate_bonus;
```

Dropping a function permanently removes that database object.

---

# 27. Modifying a Function

MySQL does not use `ALTER FUNCTION` to rewrite the function body in the same way that a table can be altered.

A common approach is:

```sql
DROP FUNCTION IF EXISTS calculate_bonus;
```

followed by:

```sql
CREATE FUNCTION calculate_bonus(...)
...
```

Care should be taken because dependent objects or application code may rely on the function.

---

# 28. Function Security

Stored functions can have security implications.

A function may expose information that users otherwise could not easily access.

Therefore:

* Grant only required privileges.
* Avoid exposing sensitive data unnecessarily.
* Review who can execute functions.
* Be careful when functions access sensitive tables.
* Avoid using functions as a way to bypass authorization design.

Module 31 covered broader database security and access control. Stored functions should follow those same least-privilege principles.

---

# 29. Stored Functions and Permissions

Creating and using stored functions involves privileges.

The exact privileges required depend on the function definition, database configuration, and operations performed.

A user who can execute a function should not automatically be assumed to have unrestricted access to the underlying tables.

Security should therefore be tested explicitly in a controlled environment.

---

# 30. Functions Should Have a Focused Responsibility

A good stored function should generally perform one clearly defined operation.

Good:

```text
calculate_discount()
```

Good:

```text
get_employee_count()
```

Less desirable:

```text
process_everything()
```

Keeping functions focused makes them easier to understand, test, maintain, and reuse.

---

# 31. Avoid Unnecessary Database Access

A function that only performs a calculation does not need to query a table.

For example:

```sql
CREATE FUNCTION calculate_discount(
    price DECIMAL(10, 2),
    percentage DECIMAL(5, 2)
)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
NO SQL
RETURN price * percentage / 100;
```

This is simpler than querying a table for information that is already available as function input.

---

# 32. Functions and Performance

Stored functions can improve code reuse, but they can also introduce overhead.

Consider:

```sql
SELECT
    employee_name,
    calculate_bonus(salary)
FROM employees;
```

If the table contains millions of rows, the function may execute many times.

A function that performs additional table lookups can be especially expensive.

Before using a function in a large query, consider:

* Number of rows processed
* Whether the function accesses tables
* Whether indexes can still be used effectively
* Whether the calculation can be written directly
* Whether a join or derived result would be more efficient

Reusable logic should not automatically take priority over query performance.

---

# 33. Functions and Index Usage

Using a function around an indexed column can affect how MySQL optimizes a query.

For example:

```sql
WHERE YEAR(hire_date) = 2025
```

may behave differently from a range condition such as:

```sql
WHERE hire_date >= '2025-01-01'
  AND hire_date < '2026-01-01'
```

The second form can be more suitable for index-based filtering in many situations.

The same general principle applies to stored functions.

Always evaluate the execution plan when performance matters.

---

# 34. Testing a Stored Function

A function should be tested with:

* Normal values
* Boundary values
* Zero
* Negative values where applicable
* `NULL`
* Missing records when the function reads data
* Unexpected input
* Large values
* Different data types where relevant

Example:

```sql
SELECT calculate_discount(1000, 10);

SELECT calculate_discount(0, 10);

SELECT calculate_discount(NULL, 10);
```

Testing should verify both expected results and edge cases.

---

# 35. Example: Reusable Discount Function

A practical function:

```sql
DELIMITER //

CREATE FUNCTION calculate_discounted_price(
    original_price DECIMAL(10, 2),
    discount_percentage DECIMAL(5, 2)
)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
NO SQL
BEGIN
    IF original_price IS NULL
       OR discount_percentage IS NULL THEN
        RETURN NULL;
    END IF;

    RETURN original_price
           - (original_price * discount_percentage / 100);
END //

DELIMITER ;
```

Usage:

```sql
SELECT calculate_discounted_price(2500.00, 15);
```

---

# 36. Example: Employee Tenure Function

A function can calculate years of service.

```sql
DELIMITER //

CREATE FUNCTION employee_years_of_service(
    hire_date_value DATE
)
RETURNS INT
NOT DETERMINISTIC
NO SQL
BEGIN
    RETURN TIMESTAMPDIFF(
        YEAR,
        hire_date_value,
        CURRENT_DATE
    );
END //

DELIMITER ;
```

Usage:

```sql
SELECT
    employee_name,
    hire_date,
    employee_years_of_service(hire_date) AS years_of_service
FROM employees;
```

Because the result depends on the current date, the function is not deterministic.

---

# 37. Example: Department Employee Count

A function can retrieve related data.

```sql
DELIMITER //

CREATE FUNCTION department_employee_count(
    department_value INT
)
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE employee_total INT;

    SELECT COUNT(*)
    INTO employee_total
    FROM employees
    WHERE department_id = department_value;

    RETURN employee_total;
END //

DELIMITER ;
```

Usage:

```sql
SELECT
    department_name,
    department_employee_count(department_id) AS employee_count
FROM departments;
```

This is convenient, but for large datasets a join or grouped query may be more efficient.

---

# 38. Stored Functions vs Built-In Functions

MySQL already provides many built-in functions:

```sql
CONCAT()
```

```sql
COALESCE()
```

```sql
ROUND()
```

```sql
DATE_ADD()
```

```sql
TIMESTAMPDIFF()
```

A custom stored function should be created when it provides reusable business logic that is not already adequately handled by built-in functions.

Do not create custom functions unnecessarily.

---

# 39. When to Use a Stored Function

Stored functions are useful when:

* A calculation is repeated frequently.
* Business logic needs to be centralized.
* The result is naturally a single value.
* The logic should be reusable inside SQL expressions.
* A database-level calculation is appropriate.

Examples:

```text
calculate_tax()
calculate_discount()
calculate_bonus()
get_employee_count()
get_customer_balance()
format_identifier()
```

---

# 40. When Not to Use a Stored Function

A stored function may not be appropriate when:

* The logic is very complex.
* The operation modifies many rows.
* A stored procedure is more appropriate.
* The application layer should own the business logic.
* The function causes repeated expensive queries.
* The calculation prevents efficient index usage.
* A built-in MySQL function already solves the problem.

Choosing between SQL, a stored function, a procedure, and application code should depend on the responsibility and performance requirements.

---

# 41. Best Practices

### 1. Use descriptive names

```text
calculate_discount
```

is clearer than:

```text
calc1
```

### 2. Keep functions focused

A function should have one clear responsibility.

### 3. Declare the correct return type

Choose a return type that accurately represents the result.

### 4. Handle NULL values deliberately

Do not accidentally propagate or hide `NULL`.

### 5. Document deterministic behavior

Use `DETERMINISTIC` only when appropriate.

### 6. Declare SQL data access accurately

Use characteristics such as:

```text
NO SQL
CONTAINS SQL
READS SQL DATA
MODIFIES SQL DATA
```

according to what the function actually does.

### 7. Avoid unnecessary table access

A simple calculation should not require a database query.

### 8. Consider performance

Be especially careful with functions that execute once for every row.

### 9. Test edge cases

Test `NULL`, zero, boundaries, missing records, and unusual inputs.

### 10. Follow least privilege

Functions should not become an accidental way to expose sensitive information.

### 11. Never hard-code secrets

Do not store passwords, API keys, tokens, or connection credentials inside functions.

### 12. Use version control carefully

Store function definitions in SQL files so changes can be reviewed and reproduced.

---

# 42. Key Syntax Summary

### Create a simple function

```sql
DELIMITER //

CREATE FUNCTION function_name(
    parameter_name DATA_TYPE
)
RETURNS RETURN_TYPE
DETERMINISTIC
BEGIN
    RETURN expression;
END //

DELIMITER ;
```

### Create a single-expression function

```sql
CREATE FUNCTION add_numbers(
    a INT,
    b INT
)
RETURNS INT
DETERMINISTIC
NO SQL
RETURN a + b;
```

### Call a function

```sql
SELECT function_name(value);
```

### Use a function with a table

```sql
SELECT
    column_name,
    function_name(column_name)
FROM table_name;
```

### Drop a function

```sql
DROP FUNCTION IF EXISTS function_name;
```

---

# 43. Important Takeaways

* A stored function returns a single value.
* Functions can be used inside SQL expressions.
* Functions use `RETURN` to provide their result.
* Every function must declare a return data type.
* Function parameters are input values.
* Functions can contain variables and conditional logic.
* `DETERMINISTIC` describes functions whose results depend predictably on their inputs.
* `NO SQL`, `READS SQL DATA`, and related characteristics describe SQL data interaction.
* Functions can read database data, but this should be used carefully.
* Functions that perform table lookups repeatedly can affect performance.
* Functions can be used in `SELECT`, `WHERE`, `ORDER BY`, and other expressions.
* Stored functions are different from stored procedures.
* A procedure is generally called with `CALL`; a function returns a value as part of an expression.
* Stored functions should have focused responsibilities.
* Built-in MySQL functions should be preferred when they already solve the problem.
* Security and least-privilege principles still apply to stored functions.
* Never store real passwords or secrets in SQL files.
