/*
File: 34_cursors_in_mysql/challenge.sql
Module 34: Cursors in MySQL

Challenge: Customer Overdue-Payment Processing System

MySQL Version: 8.0+

Objectives:
- Process eligible invoices using a cursor.
- Apply conditional business rules.
- Calculate late fees.
- Record processing results.
- Handle the end of the cursor safely.
- Keep the original invoice data unchanged.

Complete the TODO sections yourself.
*/

-- ============================================================
-- SECTION 1: SETUP
-- ============================================================

DROP PROCEDURE IF EXISTS sp_process_overdue_invoices;

DROP TEMPORARY TABLE IF EXISTS overdue_processing_log;
DROP TEMPORARY TABLE IF EXISTS challenge_invoices;

CREATE TEMPORARY TABLE challenge_invoices (
    invoice_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    invoice_amount DECIMAL(10, 2) NOT NULL,
    days_overdue INT NOT NULL,
    payment_status VARCHAR(20) NOT NULL
);

INSERT INTO challenge_invoices (
    invoice_id,
    customer_name,
    invoice_amount,
    days_overdue,
    payment_status
)
VALUES
    (1001, 'Aarav Sharma', 12000.00, 10, 'UNPAID'),
    (1002, 'Diya Verma', 8500.00, 35, 'UNPAID'),
    (1003, 'Kabir Singh', 15000.00, 5, 'PAID'),
    (1004, 'Anaya Gupta', 22000.00, 65, 'UNPAID'),
    (1005, 'Ishaan Mehta', 6000.00, 20, 'UNPAID'),
    (1006, 'Meera Joshi', 17500.00, 45, 'UNPAID'),
    (1007, 'Rohan Das', 9500.00, 0, 'UNPAID'),
    (1008, 'Sara Khan', 11000.00, 90, 'UNPAID');


-- ============================================================
-- SECTION 2: PROCESSING LOG
-- ============================================================

CREATE TEMPORARY TABLE overdue_processing_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    invoice_id INT NOT NULL,
    customer_name VARCHAR(100) NOT NULL,
    invoice_amount DECIMAL(10, 2) NOT NULL,
    days_overdue INT NOT NULL,
    late_fee DECIMAL(10, 2) NOT NULL,
    total_due DECIMAL(10, 2) NOT NULL,
    processing_category VARCHAR(30) NOT NULL,
    processed_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY uq_log_invoice (invoice_id)
);


-- ============================================================
-- SECTION 3: BUSINESS RULES
-- ============================================================

/*
Process only invoices that satisfy BOTH conditions:

1. payment_status = 'UNPAID'
2. days_overdue > 0

Late-fee rules:

- 1–30 days overdue:
  2% of the invoice amount.

- 31–60 days overdue:
  5% of the invoice amount.

- More than 60 days overdue:
  10% of the invoice amount.

The total due is:

invoice_amount + late_fee

Processing categories:

- 'STANDARD' for 1–30 days overdue.
- 'ELEVATED' for 31–60 days overdue.
- 'CRITICAL' for more than 60 days overdue.

Round late fees to two decimal places.
*/


-- ============================================================
-- SECTION 4: YOUR TASK
-- ============================================================

/*
Create a stored procedure named:

    sp_process_overdue_invoices

Requirements:

1. Declare variables to hold the invoice information,
   calculated late fee, total due, and processing category.

2. Declare a cursor selecting eligible invoices from
   challenge_invoices.

3. Sort the cursor by invoice_id in ascending order.

4. Declare a NOT FOUND handler that signals the end
   of the cursor.

5. Open the cursor and process each eligible invoice
   inside a labeled LOOP.

6. Calculate the late fee using the business rules above.

7. Insert the calculated results into
   overdue_processing_log.

8. Leave the loop when no more rows are available.

9. Close the cursor after processing.

10. Call the procedure and display the processing log.

11. Verify that paid invoices and invoices with zero
    days overdue were excluded.

12. Verify that challenge_invoices was not modified.

Expected eligible invoice IDs:
1001, 1002, 1004, 1005, 1006, 1008

Expected number of processed invoices: 6

Expected late fees:
- Invoice 1001: 240.00
- Invoice 1002: 425.00
- Invoice 1004: 2200.00
- Invoice 1005: 120.00
- Invoice 1006: 875.00
- Invoice 1008: 1100.00

Expected total due:
- Invoice 1001: 12240.00
- Invoice 1002: 8925.00
- Invoice 1004: 24200.00
- Invoice 1005: 6120.00
- Invoice 1006: 18375.00
- Invoice 1008: 12100.00

Expected total late fees: 4960.00
Expected total amount due: 91960.00
*/


-- ============================================================
-- SECTION 5: VALIDATION QUERIES
-- ============================================================

/*
After implementing and calling your procedure, run:

-- Inspect every processed invoice.
SELECT *
FROM overdue_processing_log
ORDER BY invoice_id;

-- Confirm the number of processed invoices.
SELECT COUNT(*) AS processed_invoice_count
FROM overdue_processing_log;

-- Summarize the processing results.
SELECT
    processing_category,
    COUNT(*) AS invoice_count,
    SUM(late_fee) AS total_late_fees,
    SUM(total_due) AS total_amount_due
FROM overdue_processing_log
GROUP BY processing_category
ORDER BY processing_category;

-- Confirm that paid invoices were excluded.
SELECT *
FROM overdue_processing_log
WHERE invoice_id = 1003;

-- Confirm that the invoice with zero days overdue
-- was excluded.
SELECT *
FROM overdue_processing_log
WHERE invoice_id = 1007;

-- Confirm the source data remains unchanged.
SELECT *
FROM challenge_invoices
ORDER BY invoice_id;

-- Cleanup after testing.
DROP PROCEDURE IF EXISTS sp_process_overdue_invoices;
DROP TEMPORARY TABLE IF EXISTS overdue_processing_log;
DROP TEMPORARY TABLE IF EXISTS challenge_invoices;
*/
