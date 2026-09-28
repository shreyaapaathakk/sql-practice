SQL

```
/*
File: 35_dynamic_sql_in_mysql/practice.sql
Module 35: Dynamic SQL in MySQL

Instructions:
1. Run the setup.
2. Complete the four tasks.
3. Write your answers in solutions.sql.
*/

-- ============================================================
-- SETUP
-- ============================================================

DROP PROCEDURE IF EXISTS sp_practice_dynamic_filter;
DROP PROCEDURE IF EXISTS sp_practice_dynamic_sort;
DROP PROCEDURE IF EXISTS sp_practice_dynamic_table;
DROP PROCEDURE IF EXISTS sp_practice_dynamic_salary_update;

DROP TEMPORARY TABLE IF EXISTS practice_dynamic_employees;
DROP TEMPORARY TABLE IF EXISTS practice_dynamic_departments;

CREATE TEMPORARY TABLE practice_dynamic_departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL
);

CREATE TEMPORARY TABLE practice_dynamic_employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    department_id INT NOT NULL,
    salary DECIMAL(10, 2) NOT NULL
);

INSERT INTO practice_dynamic_departments
    (department_id, department_name)
VALUES
    (1, 'IT'),
    (2, 'HR'),
    (3, 'Finance');

INSERT INTO practice_dynamic_employees
    (employee_id, employee_name, department_id, salary)
VALUES
    (201, 'Aarav', 1, 65000.00),
    (202, 'Diya', 2, 48000.00),
    (203, 'Kabir', 1, 72000.00),
    (204, 'Anaya', 3, 58000.00),
    (205, 'Ishaan', 2, 45000.00);


-- ============================================================
-- TASK 1: PARAMETERIZED FILTER
-- ============================================================

/*
Create sp_practice_dynamic_filter(IN p_department_id INT).

Requirements:
- Use a prepared statement.
- Filter employees by department_id using a ? placeholder.
- Pass the department ID through EXECUTE ... USING.
- Sort results by employee_id.
- Deallocate the prepared statement.
*/


-- ============================================================
-- TASK 2: VALIDATED DYNAMIC SORTING
-- ============================================================

/*
Create sp_practice_dynamic_sort(
    IN p_sort_column VARCHAR(30),
    IN p_sort_direction VARCHAR(4)
).

Requirements:
- Allow 'name', 'salary', and 'id' as sort options.
- Map these inputs to actual column names.
- Allow only ASC and DESC, case-insensitively.
- Reject invalid inputs using SIGNAL SQLSTATE '45000'.
- Construct the ORDER BY clause dynamically.
- Do not concatenate arbitrary input into the query.
*/


-- ============================================================
-- TASK 3: DYNAMIC TABLE SELECTION
-- ============================================================

/*
Create sp_practice_dynamic_table(IN p_table_name VARCHAR(50)).

Requirements:
- Allow only these tables:
    practice_dynamic_employees
    practice_dynamic_departments
- Reject any other table name.
- Build a SELECT * query dynamically.
- Execute and deallocate the prepared statement.
- Validate the identifier before constructing the query.
*/


-- ============================================================
-- TASK 4: PARAMETERIZED UPDATE
-- ============================================================

/*
Create sp_practice_dynamic_salary_update(
    IN p_employee_id INT,
    IN p_increase DECIMAL(10, 2)
).

Requirements:
- Increase the salary of the selected employee by p_increase.
- Use a prepared UPDATE statement.
- Use placeholders for both values.
- Pass values with EXECUTE ... USING.
- Reject a negative increase.
- Do not concatenate parameter values into SQL.
- Display the updated employee record.
*/


-- ============================================================
-- CLEANUP
-- ============================================================

/*
After testing:

DROP PROCEDURE IF EXISTS sp_practice_dynamic_filter;
DROP PROCEDURE IF EXISTS sp_practice_dynamic_sort;
DROP PROCEDURE IF EXISTS sp_practice_dynamic_table;
DROP PROCEDURE IF EXISTS sp_practice_dynamic_salary_update;

DROP TEMPORARY TABLE IF EXISTS practice_dynamic_employees;
DROP TEMPORARY TABLE IF EXISTS practice_dynamic_departments;
*/
```

For the next module, a natural continuation would be Module 36: MySQL Metadata and the Information Schema, covering how to inspect databases, tables, columns, constraints, and indexes programmatically.
