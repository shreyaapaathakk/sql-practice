# Module 24 — SQL Triggers

A **trigger** is a database object that automatically executes when a specified event occurs on a table.

A trigger can execute automatically when:

```text
INSERT
UPDATE
DELETE
```

occurs.

The basic idea is:

```text
SQL operation
     ↓
Trigger fires automatically
     ↓
Trigger action executes
```

For example, whenever an employee's salary is updated, a trigger can automatically record the old and new salary in an audit table.

---

# 1. Why Triggers Are Useful

Triggers are useful when an action should happen automatically whenever data changes.

Common uses include:

```text
Audit logging
Validation
Automatic timestamps
Maintaining derived data
Recording history
Preventing invalid changes
```

Example:

```text
Employee salary changes
        ↓
Trigger fires
        ↓
Salary history is recorded
```

The application does not need to explicitly insert the history record.

---

# 2. Basic Trigger Syntax

A MySQL trigger can be created with:

```sql
CREATE TRIGGER trigger_name
BEFORE INSERT
ON table_name
FOR EACH ROW
BEGIN
    -- trigger statements
END;
```

The important components are:

```text
CREATE TRIGGER
trigger_name
timing
event
ON table
FOR EACH ROW
```

---

# 3. Trigger Timing

There are two main trigger timings in MySQL:

```text
BEFORE
AFTER
```

Example:

```sql
BEFORE INSERT
```

means the trigger executes before the row is inserted.

```sql
AFTER INSERT
```

means the trigger executes after the row has been inserted.

---

# 4. Trigger Events

Triggers can respond to:

```text
INSERT
UPDATE
DELETE
```

Therefore, common combinations include:

```sql
BEFORE INSERT
AFTER INSERT

BEFORE UPDATE
AFTER UPDATE

BEFORE DELETE
AFTER DELETE
```

---

# 5. FOR EACH ROW

MySQL triggers use:

```sql
FOR EACH ROW
```

This means the trigger executes separately for every affected row.

Suppose:

```sql
UPDATE employees
SET salary = salary + 1000;
```

updates 10 employees.

A row-level trigger can execute once for each affected employee.

Conceptually:

```text
Employee 1 → Trigger
Employee 2 → Trigger
Employee 3 → Trigger
...
Employee 10 → Trigger
```

---

# 6. `NEW`

Inside an INSERT or UPDATE trigger, `NEW` refers to the new row value.

Example:

```sql
NEW.salary
```

means the salary value in the new version of the row.

For an INSERT:

```text
NEW = row being inserted
```

For an UPDATE:

```text
NEW = new version of the row
```

---

# 7. `OLD`

`OLD` refers to the previous version of a row.

It is especially useful with UPDATE and DELETE triggers.

For an UPDATE:

```text
OLD = value before update
NEW = value after update
```

For a DELETE:

```text
OLD = row being deleted
```

There is no `NEW` row after a DELETE.

---

# 8. OLD and NEW Comparison

For an UPDATE:

```sql
OLD.salary
```

is the salary before the update.

```sql
NEW.salary
```

is the salary after the update.

Example:

```text
OLD.salary = 50,000
NEW.salary = 55,000
```

This is extremely useful for audit logs.

---

# 9. INSERT Trigger

An INSERT trigger can access:

```sql
NEW.column_name
```

Example:

```sql
CREATE TRIGGER before_employee_insert
BEFORE INSERT
ON employees
FOR EACH ROW
BEGIN
    SET NEW.salary = ABS(NEW.salary);
END;
```

The trigger modifies the incoming value before insertion.

---

# 10. UPDATE Trigger

An UPDATE trigger can access both:

```text
OLD
NEW
```

Example:

```sql
CREATE TRIGGER before_employee_update
BEFORE UPDATE
ON employees
FOR EACH ROW
BEGIN
    SET NEW.salary = ABS(NEW.salary);
END;
```

---

# 11. DELETE Trigger

A DELETE trigger can access:

```sql
OLD.column_name
```

Example:

```sql
CREATE TRIGGER after_employee_delete
AFTER DELETE
ON employees
FOR EACH ROW
BEGIN
    INSERT INTO employee_delete_log (
        employee_id,
        employee_name
    )
    VALUES (
        OLD.employee_id,
        OLD.employee_name
    );
END;
```

Once the employee is deleted, the trigger records information about the deleted row.

---

# 12. BEFORE INSERT

A `BEFORE INSERT` trigger runs before the new row is stored.

This is useful for:

```text
Validation
Data normalization
Setting values
Applying defaults
```

Example:

```sql
CREATE TRIGGER before_customer_insert
BEFORE INSERT
ON customers
FOR EACH ROW
BEGIN
    SET NEW.customer_name = TRIM(NEW.customer_name);
END;
```

---

# 13. AFTER INSERT

An `AFTER INSERT` trigger runs after the row is successfully inserted.

This is useful for:

```text
Audit logging
Creating related records
Updating summary information
```

Example:

```sql
CREATE TRIGGER after_customer_insert
AFTER INSERT
ON customers
FOR EACH ROW
BEGIN
    INSERT INTO customer_log (
        customer_id,
        action_type
    )
    VALUES (
        NEW.customer_id,
        'INSERT'
    );
END;
```

---

# 14. BEFORE UPDATE

`BEFORE UPDATE` executes before the updated row is stored.

Example:

```sql
CREATE TRIGGER before_employee_salary_update
BEFORE UPDATE
ON employees
FOR EACH ROW
BEGIN
    IF NEW.salary < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Salary cannot be negative';
    END IF;
END;
```

The trigger prevents an invalid salary.

---

# 15. AFTER UPDATE

`AFTER UPDATE` executes after the row has been updated.

It is commonly used for audit history.

Example:

```sql
CREATE TRIGGER after_employee_update
AFTER UPDATE
ON employees
FOR EACH ROW
BEGIN
    INSERT INTO salary_history (
        employee_id,
        old_salary,
        new_salary
    )
    VALUES (
        OLD.employee_id,
        OLD.salary,
        NEW.salary
    );
END;
```

---

# 16. BEFORE DELETE

A `BEFORE DELETE` trigger runs before a row is deleted.

It can be used to prevent deletion.

Example:

```sql
CREATE TRIGGER before_employee_delete
BEFORE DELETE
ON employees
FOR EACH ROW
BEGIN
    IF OLD.employee_id = 1 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'This employee cannot be deleted';
    END IF;
END;
```

---

# 17. AFTER DELETE

An `AFTER DELETE` trigger runs after the deletion succeeds.

This is useful for audit records.

Example:

```sql
CREATE TRIGGER after_employee_delete
AFTER DELETE
ON employees
FOR EACH ROW
BEGIN
    INSERT INTO employee_delete_log (
        employee_id,
        employee_name
    )
    VALUES (
        OLD.employee_id,
        OLD.employee_name
    );
END;
```

---

# 18. DELIMITER

MySQL normally uses:

```text
;
```

as the statement delimiter.

A trigger often contains multiple statements.

For example:

```sql
BEGIN
    SET ...;
    INSERT ...;
END;
```

To allow MySQL to recognize the complete trigger definition, we commonly change the delimiter temporarily.

Example:

```sql
DELIMITER //

CREATE TRIGGER example_trigger
AFTER INSERT
ON employees
FOR EACH ROW
BEGIN
    INSERT INTO employee_log (...)
    VALUES (...);
END//

DELIMITER ;
```

The delimiter is a client-side instruction used to define the trigger cleanly.

---

# 19. Creating a Trigger

Example:

```sql
DELIMITER //

CREATE TRIGGER after_employee_insert
AFTER INSERT
ON employees
FOR EACH ROW
BEGIN
    INSERT INTO employee_log (
        employee_id,
        action_type
    )
    VALUES (
        NEW.employee_id,
        'INSERT'
    );
END//

DELIMITER ;
```

---

# 20. Viewing Triggers

You can list triggers with:

```sql
SHOW TRIGGERS;
```

You can also inspect a particular trigger:

```sql
SHOW CREATE TRIGGER after_employee_insert;
```

---

# 21. Dropping a Trigger

Use:

```sql
DROP TRIGGER trigger_name;
```

Example:

```sql
DROP TRIGGER after_employee_insert;
```

Use this carefully because the trigger will no longer execute automatically.

---

# 22. Trigger Example — Audit Log

Suppose we have:

```sql
CREATE TABLE employee_salary_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT,
    old_salary DECIMAL(10,2),
    new_salary DECIMAL(10,2),
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

Create a trigger:

```sql
DELIMITER //

CREATE TRIGGER after_salary_update
AFTER UPDATE
ON employees
FOR EACH ROW
BEGIN
    IF OLD.salary <> NEW.salary THEN
        INSERT INTO employee_salary_history (
            employee_id,
            old_salary,
            new_salary
        )
        VALUES (
            OLD.employee_id,
            OLD.salary,
            NEW.salary
        );
    END IF;
END//

DELIMITER ;
```

Now:

```sql
UPDATE employees
SET salary = salary + 5000
WHERE employee_id = 101;
```

automatically creates a history record.

---

# 23. Conditional Triggers

Triggers can contain conditional logic.

Example:

```sql
IF NEW.salary < 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Salary cannot be negative';
END IF;
```

This allows triggers to enforce business rules.

---

# 24. SIGNAL

MySQL's:

```sql
SIGNAL
```

statement can raise a custom error.

Example:

```sql
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Invalid salary';
```

The application receives an error instead of the invalid change being accepted.

---

# 25. Trigger Validation

Suppose product quantity cannot be negative.

A trigger could enforce:

```sql
IF NEW.quantity < 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Quantity cannot be negative';
END IF;
```

This creates a database-level validation rule.

---

# 26. Automatic Timestamps

A trigger can automatically update timestamps.

For example:

```sql
CREATE TRIGGER before_employee_update
BEFORE UPDATE
ON employees
FOR EACH ROW
BEGIN
    SET NEW.updated_at = CURRENT_TIMESTAMP;
END;
```

Whenever the row changes, `updated_at` is updated automatically.

Note that modern MySQL can often handle this using column definitions such as `DEFAULT CURRENT_TIMESTAMP` and `ON UPDATE CURRENT_TIMESTAMP`, so a trigger is not always necessary.

---

# 27. Trigger for Audit Logging

Audit systems often store:

```text
Who
What
When
Old value
New value
```

Example:

```text
employee_id = 101
old_salary = 55000
new_salary = 60000
changed_at = current timestamp
```

Triggers are useful for automatically creating these records.

---

# 28. Trigger for Deleted Records

Suppose an employee is deleted.

A trigger can preserve information:

```text
employees
   ↓ DELETE
employee_delete_history
```

The original record can be copied to a history table before or after deletion, depending on the design.

---

# 29. Trigger Restrictions and Considerations

Triggers should be used carefully.

Too many triggers can make database behavior difficult to understand.

For example:

```text
INSERT
  ↓
Trigger A
  ↓
Trigger B
  ↓
Another table changes
  ↓
Another trigger fires
```

This can create complicated dependencies.

---

# 30. Hidden Side Effects

One disadvantage of triggers is that SQL statements can cause additional actions that are not obvious from the original query.

For example:

```sql
UPDATE employees
SET salary = salary + 5000;
```

may appear simple, but an AFTER UPDATE trigger could also insert records into a history table.

Developers need to know which triggers exist.

---

# 31. Triggers vs Application Logic

Some business rules are better implemented in application code.

Triggers are particularly useful when a rule must be enforced directly at the database level.

Good trigger candidates include:

```text
Audit logging
Automatic history
Database-level validation
Simple automatic derived changes
```

Avoid using triggers for unnecessarily complicated application workflows.

---

# 32. Trigger and Transaction Interaction

Triggers execute as part of the statement that activates them.

For example:

```sql
START TRANSACTION;

UPDATE employees
SET salary = salary + 1000
WHERE employee_id = 101;

ROLLBACK;
```

If the UPDATE caused an appropriate trigger to insert an audit record as part of the same transactional operation, that trigger-generated change is also rolled back with the transaction.

This is one reason triggers can be useful for transactional audit logging.

---

# 33. BEFORE vs AFTER

Use `BEFORE` when you need to:

```text
Validate
Modify incoming values
Prevent an operation
```

Use `AFTER` when you need to:

```text
Record the completed operation
Create audit records
React to a successful change
```

A useful mental model:

```text
BEFORE
  ↓
Check / modify
  ↓
Database operation
  ↓
AFTER
  ↓
Record / react
```

---

# 34. NEW vs OLD

Remember this table:

| Event  | OLD | NEW |
| ------ | --- | --- |
| INSERT | No  | Yes |
| UPDATE | Yes | Yes |
| DELETE | Yes | No  |

This is one of the most important concepts in triggers.

---

# 35. Common Trigger Mistakes

### Mistake 1 — Forgetting DELIMITER

Complex trigger definitions often require temporary delimiter changes in MySQL clients.

### Mistake 2 — Using NEW in DELETE

DELETE triggers do not have a NEW row.

Use:

```sql
OLD.column_name
```

### Mistake 3 — Using OLD in INSERT

INSERT triggers do not have an OLD row.

Use:

```sql
NEW.column_name
```

### Mistake 4 — Creating unnecessary triggers

A trigger should have a clear reason to exist.

### Mistake 5 — Forgetting that triggers are automatic

An UPDATE may cause additional database operations because of a trigger.

---

# 36. Trigger Debugging

When debugging unexpected behavior, check:

```sql
SHOW TRIGGERS;
```

Then inspect a specific trigger:

```sql
SHOW CREATE TRIGGER trigger_name;
```

Look for:

```text
BEFORE / AFTER
INSERT / UPDATE / DELETE
NEW / OLD
conditions
additional SQL statements
```

---

# 37. Practical Example

Suppose:

```text
employees
```

contains employee information.

We create:

```text
employee_salary_history
```

Whenever salary changes:

```text
employees
   ↓
UPDATE
   ↓
AFTER UPDATE trigger
   ↓
employee_salary_history
```

The trigger records:

```text
employee_id
old_salary
new_salary
timestamp
```

This is a practical use of triggers.

---

# 38. When Not to Use a Trigger

Avoid triggers when:

```text
The logic is extremely complex
The behavior is difficult to document
Application logic is clearly more appropriate
The trigger creates unnecessary cascading changes
```

A database should remain understandable and maintainable.

---

# 39. Trigger Checklist

Before creating a trigger, ask:

```text
1. What event activates it?
2. Should it run BEFORE or AFTER?
3. Do I need OLD or NEW?
4. Should it modify the incoming row?
5. Should it create an audit record?
6. Should it reject invalid data?
7. Could it cause another trigger to fire?
8. Does the database really need this rule?
```

---

# 40. Module 24 Key Takeaways

Remember:

```text
TRIGGER
→ automatic database action

BEFORE
→ runs before the event completes

AFTER
→ runs after the event succeeds

INSERT
→ NEW

UPDATE
→ OLD + NEW

DELETE
→ OLD
```

Important commands:

```sql
CREATE TRIGGER
SHOW TRIGGERS
SHOW CREATE TRIGGER
DROP TRIGGER
```

Important concepts:

```text
NEW
OLD
FOR EACH ROW
DELIMITER
SIGNAL
audit logging
validation
```

The most important mental model is:

```text
INSERT / UPDATE / DELETE
          ↓
       TRIGGER
          ↓
   Automatic action
```

Triggers are powerful, but they should be used deliberately because they create automatic behavior inside the database.
