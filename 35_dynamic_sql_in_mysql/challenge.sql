SQL

```
/*
File: 35_dynamic_sql_in_mysql/challenge.sql
Module 35: Dynamic SQL in MySQL

Challenge: Dynamic Employee Reporting System

MySQL Version: 8.0+
*/

-- ============================================================
-- SECTION 1: SETUP
-- ============================================================

DROP PROCEDURE IF EXISTS sp_dynamic_employee_report;

DROP TEMPORARY TABLE IF EXISTS challenge_employees;

CREATE TEMPORARY TABLE challenge_employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    department VARCHAR(50) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    hire_date DATE NOT NULL
);

INSERT INTO challenge_employees (
    employee_id,
    employee_name,
    department,
    salary,
    hire_date
)
VALUES
    (301, 'Aarav Sharma', 'IT', 72000.00, '2021-03-15'),
    (302, 'Diya Verma', 'HR', 48000.00, '2022-07-10'),
    (303, 'Kabir Singh', 'IT', 85000.00, '2020-11-01'),
    (304, 'Anaya Gupta', 'Finance', 61000.00, '2023-01-20'),
    (305, 'Ishaan Mehta', 'HR', 52000.00, '2021-09-05'),
    (306, 'Meera Joshi', 'Finance', 68000.00, '2019-06-12'),
    (307, 'Rohan Das', 'IT', 59000.00, '2024-02-01'),
    (308, 'Sara Khan', 'Marketing', 56000.00, '2022-04-18');


-- ============================================================
-- SECTION 2: CHALLENGE REQUIREMENTS
-- ============================================================

/*
Create this stored procedure:

sp_dynamic_employee_report(
    IN p_department VARCHAR(50),
    IN p_sort_column VARCHAR(30),
    IN p_sort_direction VARCHAR(4)
)

Requirements:

1. OPTIONAL DEPARTMENT FILTER

   - If p_department is NULL or an empty string,
     return employees from all departments.
   - Otherwise, filter by the supplied department.
   - Use a parameter placeholder for the department value.

2. DYNAMIC SORTING

   Permit only these sort options:

   'id'     -> employee_id
   'name'   -> employee_name
   'salary' -> salary
   'date'   -> hire_date

   Permit only ASC or DESC, case-insensitively.

3. SECURITY

   - Do not concatenate p_department into the SQL.
   - Do not insert arbitrary p_sort_column into the SQL.
   - Map sort options to approved column names.
   - Reject invalid sort columns and directions using
     SIGNAL SQLSTATE '45000'.

4. EXECUTION

   - Build the SQL statement using CONCAT.
   - Use PREPARE and EXECUTE.
   - Pass the department value using EXECUTE ... USING.
   - Deallocate the prepared statement.

5. OUTPUT

   Return:
   employee_id, employee_name, department,
   salary, and hire_date.

6. TESTING

   Test all the calls in Section 3.
*/


-- ============================================================
-- SECTION 3: TEST CASES
-- ============================================================

/*
After creating the procedure, run these tests.

TEST 1:
All employees, sorted by salary descending.

CALL sp_dynamic_employee_report(
    NULL,
    'salary',
    'DESC'
);

TEST 2:
Only IT employees, sorted by name ascending.

CALL sp_dynamic_employee_report(
    'IT',
    'name',
    'ASC'
);

TEST 3:
Only HR employees, sorted by hire date descending.

CALL sp_dynamic_employee_report(
    'HR',
    'date',
    'DESC'
);

TEST 4:
Empty department filter, sorted by employee ID.

CALL sp_dynamic_employee_report(
    '',
    'id',
    'ASC'
);

TEST 5:
Invalid sort column. This should raise an error.

CALL sp_dynamic_employee_report(
    'IT',
    'password',
    'ASC'
);

TEST 6:
Invalid sort direction. This should raise an error.

CALL sp_dynamic_employee_report(
    'IT',
    'salary',
    'SIDEWAYS'
);

TEST 7:
Try a department value containing SQL-like text.
It must be treated as a value, not executable SQL.

CALL sp_dynamic_employee_report(
    'IT'' OR 1=1 -- ',
    'id',
    'ASC'
);
*/


-- ============================================================
-- SECTION 4: VALIDATION
-- ============================================================

/*
After testing, verify the source data remains unchanged.

SELECT *
FROM challenge_employees
ORDER BY employee_id;

Expected row count: 8

Expected departments:
- IT
- HR
- Finance
- Marketing

Cleanup:

DROP PROCEDURE IF EXISTS sp_dynamic_employee_report;
DROP TEMPORARY TABLE IF EXISTS challenge_employees;
*/
```

For the next module, a natural continuation would be Module 36: MySQL Metadata and the Information Schema, covering how to inspect databases, tables, columns, constraints, and indexes programmatically.
