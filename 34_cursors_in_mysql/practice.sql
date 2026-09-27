/*
File: 34_cursors_in_mysql/practice.sql
Module 34: Cursors in MySQL

Instructions:
1. Run the setup script.
2. Solve each task in solutions.sql.
3. Use MySQL 8.0+.
*/

-- ============================================================
-- SETUP: PRACTICE DATA
-- ============================================================

DROP TEMPORARY TABLE IF EXISTS practice_employees;

CREATE TEMPORARY TABLE practice_employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    department VARCHAR(50) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    performance_rating INT NOT NULL
);

INSERT INTO practice_employees (
    employee_id,
    employee_name,
    department,
    salary,
    performance_rating
)
VALUES
    (101, 'Aarav', 'IT', 55000.00, 5),
    (102, 'Diya', 'HR', 42000.00, 3),
    (103, 'Kabir', 'IT', 68000.00, 4),
    (104, 'Anaya', 'Finance', 49000.00, 5),
    (105, 'Ishaan', 'HR', 46000.00, 2),
    (106, 'Meera', 'Finance', 61000.00, 4);


-- ============================================================
-- TASK 1: BASIC CURSOR
-- ============================================================

/*
Create a procedure named sp_practice_list_employees.

Requirements:
- Declare a cursor selecting employee_id and employee_name.
- Order employees by employee_id.
- Use a NOT FOUND handler and a LOOP.
- Return each employee's ID and name using SELECT.
- Close the cursor after processing.
*/


-- ============================================================
-- TASK 2: CONDITIONAL PROCESSING
-- ============================================================

/*
Create a temporary table named practice_bonus_results with:
- employee_id
- employee_name
- salary
- bonus_amount

Create a procedure named sp_practice_calculate_bonus.

Requirements:
- Use a cursor to read all employees.
- Employees with performance_rating >= 4 receive a
  15% bonus.
- All other employees receive a 5% bonus.
- Insert each employee and their calculated bonus
  into practice_bonus_results.
- Do not modify the original employee salaries.
*/


-- ============================================================
-- TASK 3: FILTERED CURSOR
-- ============================================================

/*
Create a procedure named sp_practice_it_employees.

Requirements:
- Use a cursor that selects only employees in the IT
  department.
- Process employees in descending order of salary.
- Return employee_id, employee_name, and salary.
- Handle the end of the cursor correctly.
*/


-- ============================================================
-- TASK 4: CURSOR-BASED CLASSIFICATION
-- ============================================================

/*
Create a temporary table named practice_salary_categories
with:
- employee_id
- employee_name
- salary_category

Create a procedure named sp_practice_salary_categories.

Requirements:
- Read every employee using a cursor.
- Classify salary as:
    'High'   when salary >= 60000
    'Medium' when salary >= 45000 and < 60000
    'Low'    when salary < 45000
- Insert each employee's classification into the
  temporary results table.
- Return the results ordered by employee_id.
*/


-- ============================================================
-- CLEANUP
-- ============================================================

/*
After completing and testing the solutions, you may remove
the procedures and temporary tables:

DROP PROCEDURE IF EXISTS sp_practice_list_employees;
DROP PROCEDURE IF EXISTS sp_practice_calculate_bonus;
DROP PROCEDURE IF EXISTS sp_practice_it_employees;
DROP PROCEDURE IF EXISTS sp_practice_salary_categories;

DROP TEMPORARY TABLE IF EXISTS practice_salary_categories;
DROP TEMPORARY TABLE IF EXISTS practice_bonus_results;
DROP TEMPORARY TABLE IF EXISTS practice_employees;
*/
