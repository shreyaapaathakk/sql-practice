SQL

```
/*
File: 36_sql_interview_practice/practice.sql
Module 36: SQL Interview Practice

Complete the questions in solutions.sql.
*/

-- ============================================================
-- SETUP
-- ============================================================

DROP TEMPORARY TABLE IF EXISTS practice_orders;
DROP TEMPORARY TABLE IF EXISTS practice_employees;
DROP TEMPORARY TABLE IF EXISTS practice_customers;

CREATE TEMPORARY TABLE practice_customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL
);

CREATE TEMPORARY TABLE practice_employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    department VARCHAR(50) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL
);

CREATE TEMPORARY TABLE practice_orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    amount DECIMAL(10, 2) NOT NULL
);

INSERT INTO practice_customers VALUES
    (1, 'Aarav', 'Delhi'),
    (2, 'Diya', 'Mumbai'),
    (3, 'Kabir', 'Delhi'),
    (4, 'Anaya', 'Pune'),
    (5, 'Meera', 'Mumbai');

INSERT INTO practice_employees VALUES
    (201, 'Rohan', 'IT', 75000.00),
    (202, 'Sara', 'IT', 90000.00),
    (203, 'Ishaan', 'HR', 50000.00),
    (204, 'Tara', 'HR', 60000.00),
    (205, 'Vikram', 'Finance', 65000.00),
    (206, 'Neha', 'Finance', 65000.00);

INSERT INTO practice_orders VALUES
    (501, 1, '2026-01-10', 1000.00),
    (502, 1, '2026-01-15', 1500.00),
    (503, 2, '2026-02-05', 2000.00),
    (504, 3, '2026-02-20', 500.00),
    (505, 1, '2026-03-01', 750.00),
    (506, 4, '2026-03-12', 1200.00);


-- ============================================================
-- TASK 1: SECOND-HIGHEST DISTINCT SALARY
-- ============================================================

/*
Return the second-highest distinct salary from
practice_employees.

Requirements:
- Return one column named second_highest_salary.
- Return NULL if fewer than two distinct salaries exist.
*/


-- ============================================================
-- TASK 2: HIGHEST-PAID EMPLOYEE PER DEPARTMENT
-- ============================================================

/*
Return every employee earning the highest salary
in their department.

Requirements:
- Include ties.
- Return employee_id, employee_name, department, salary.
- Use a window function.
*/


-- ============================================================
-- TASK 3: CUSTOMERS WITHOUT ORDERS
-- ============================================================

/*
Find customers who have never placed an order.

Requirements:
- Return customer_id and customer_name.
- Use a LEFT JOIN or NOT EXISTS.
- Do not return customers who have at least one order.
*/


-- ============================================================
-- TASK 4: DEPARTMENT SALARY SUMMARY
-- ============================================================

/*
For each department, return:
- department
- employee_count
- average_salary

Include only departments with at least two employees
and an average salary greater than 60000.

Use GROUP BY and HAVING.
*/


-- ============================================================
-- TASK 5: RUNNING ORDER TOTAL
-- ============================================================

/*
Return each order with:
- order_id
- order_date
- amount
- running_total

Order by order_date and order_id.
Use a window function with an explicit ROWS frame.
*/


-- ============================================================
-- TASK 6: MONTHLY REVENUE
-- ============================================================

/*
Return monthly revenue and the previous available
month's revenue.

Requirements:
- Group orders by calendar month.
- Use LAG().
- Return order_month, revenue, previous_revenue.
- Sort chronologically.
*/


-- ============================================================
-- CLEANUP
-- ============================================================

/*
DROP TEMPORARY TABLE IF EXISTS practice_orders;
DROP TEMPORARY TABLE IF EXISTS practice_employees;
DROP TEMPORARY TABLE IF EXISTS practice_customers;
*/
```

Once Module 36 is complete, we'll move to Module 37 and finish the planned 37-module learning roadmap for `sql-practice`.
