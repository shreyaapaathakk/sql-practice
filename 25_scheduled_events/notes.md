# Module 25 — Scheduled Events

MySQL provides the **Event Scheduler** to execute SQL statements automatically at scheduled times.

An event is similar to a scheduled task inside the database.

Instead of manually executing:

```sql
DELETE FROM logs
WHERE created_at < NOW() - INTERVAL 30 DAY;
```

you can create an event that performs the cleanup automatically every day.

---

# 1. What Is a Scheduled Event?

A MySQL event is a database object containing SQL that runs automatically according to a schedule.

Conceptually:

```text
Time arrives
    ↓
Event Scheduler
    ↓
Event executes
    ↓
SQL statements run
```

Events are useful for database-side automation.

Common examples include:

```text
Deleting old records
Generating reports
Updating summary tables
Archiving data
Refreshing statistics
Cleaning temporary data
Calling stored procedures
```

---

# 2. Event Scheduler

MySQL's Event Scheduler controls whether scheduled events execute.

Check its status:

```sql
SHOW VARIABLES LIKE 'event_scheduler';
```

To enable it:

```sql
SET GLOBAL event_scheduler = ON;
```

The exact availability of this setting can depend on your MySQL installation and permissions.

---

# 3. Basic Event Syntax

A simple event looks like:

```sql
CREATE EVENT event_name
ON SCHEDULE schedule
DO
    SQL_statement;
```

Example:

```sql
CREATE EVENT delete_old_logs
ON SCHEDULE EVERY 1 DAY
DO
    DELETE FROM logs
    WHERE created_at < NOW() - INTERVAL 30 DAY;
```

---

# 4. One-Time Events

A one-time event runs once.

Syntax:

```sql
CREATE EVENT event_name
ON SCHEDULE AT 'YYYY-MM-DD HH:MM:SS'
DO
    SQL_statement;
```

Example:

```sql
CREATE EVENT one_time_cleanup
ON SCHEDULE AT '2030-01-01 00:00:00'
DO
    DELETE FROM temporary_data;
```

After execution, a one-time event may be automatically removed depending on its configuration.

---

# 5. Recurring Events

Recurring events execute repeatedly.

Example:

```sql
CREATE EVENT daily_cleanup
ON SCHEDULE EVERY 1 DAY
DO
    DELETE FROM temporary_data;
```

Possible intervals include:

```text
SECOND
MINUTE
HOUR
DAY
WEEK
MONTH
YEAR
```

Examples:

```sql
EVERY 10 MINUTE
EVERY 2 HOUR
EVERY 1 DAY
EVERY 1 WEEK
EVERY 1 MONTH
```

---

# 6. STARTS

`STARTS` specifies when a recurring event should begin.

Example:

```sql
CREATE EVENT daily_report
ON SCHEDULE
    EVERY 1 DAY
    STARTS '2030-01-01 08:00:00'
DO
    CALL generate_daily_report();
```

The event begins according to the specified schedule.

---

# 7. ENDS

`ENDS` specifies when a recurring event should stop.

Example:

```sql
CREATE EVENT temporary_job
ON SCHEDULE
    EVERY 1 DAY
    STARTS '2030-01-01 08:00:00'
    ENDS '2030-01-31 08:00:00'
DO
    CALL daily_task();
```

The event operates only within the specified scheduling period.

---

# 8. STARTS and ENDS Together

You can combine both:

```sql
CREATE EVENT monthly_task
ON SCHEDULE
    EVERY 1 MONTH
    STARTS '2030-01-01 00:00:00'
    ENDS '2030-12-31 23:59:59'
DO
    CALL monthly_process();
```

This creates a recurring event with a defined active period.

---

# 9. ENABLE and DISABLE

Events can be enabled or disabled.

Create an enabled event:

```sql
CREATE EVENT example_event
ON SCHEDULE EVERY 1 DAY
ENABLE
DO
    CALL daily_task();
```

Create a disabled event:

```sql
CREATE EVENT example_event
ON SCHEDULE EVERY 1 DAY
DISABLE
DO
    CALL daily_task();
```

A disabled event remains defined in the database but does not execute.

---

# 10. ALTER EVENT

You can modify an existing event.

Example:

```sql
ALTER EVENT daily_cleanup
ON SCHEDULE EVERY 12 HOUR;
```

You can also enable or disable it:

```sql
ALTER EVENT daily_cleanup ENABLE;
```

```sql
ALTER EVENT daily_cleanup DISABLE;
```

---

# 11. DROP EVENT

To remove an event:

```sql
DROP EVENT event_name;
```

Example:

```sql
DROP EVENT daily_cleanup;
```

This permanently removes the event definition.

---

# 12. SHOW EVENTS

To list events:

```sql
SHOW EVENTS;
```

You can also specify a database:

```sql
SHOW EVENTS FROM module25_events;
```

---

# 13. SHOW CREATE EVENT

To inspect an event's definition:

```sql
SHOW CREATE EVENT event_name;
```

This is useful for debugging and documentation.

---

# 14. Event with Multiple Statements

An event can execute multiple SQL statements.

Use `BEGIN ... END`:

```sql
CREATE EVENT archive_event
ON SCHEDULE EVERY 1 DAY
DO
BEGIN
    INSERT INTO archived_orders
    SELECT *
    FROM orders
    WHERE order_date < CURRENT_DATE - INTERVAL 1 YEAR;

    DELETE FROM orders
    WHERE order_date < CURRENT_DATE - INTERVAL 1 YEAR;
END;
```

When using a MySQL client, a temporary delimiter is normally required.

Example:

```sql
DELIMITER //

CREATE EVENT archive_event
ON SCHEDULE EVERY 1 DAY
DO
BEGIN
    INSERT INTO archived_orders
    SELECT *
    FROM orders
    WHERE order_date < CURRENT_DATE - INTERVAL 1 YEAR;

    DELETE FROM orders
    WHERE order_date < CURRENT_DATE - INTERVAL 1 YEAR;
END//

DELIMITER ;
```

---

# 15. Events and Stored Procedures

An event can call a stored procedure.

Example:

```sql
CREATE EVENT daily_report
ON SCHEDULE EVERY 1 DAY
DO
    CALL generate_daily_report();
```

This is often cleaner than placing a large amount of SQL directly inside the event.

Conceptually:

```text
Scheduled Event
      ↓
Stored Procedure
      ↓
Multiple SQL operations
```

---

# 16. Event Scheduler vs Trigger

A trigger executes because of a table event.

An event executes because of a schedule.

### Trigger

```text
INSERT / UPDATE / DELETE
          ↓
       Trigger
```

### Scheduled Event

```text
Time / Schedule
       ↓
      Event
```

Triggers react to data changes.

Events react to time.

---

# 17. Event Scheduler vs Application Scheduler

Scheduled work can be implemented in several places.

For example:

```text
Database Event Scheduler
Application scheduler
Operating-system scheduler
Cloud scheduler
```

A database event is useful when the operation is tightly related to database data and should run independently of an application server.

---

# 18. Cleanup Example

Suppose a table contains temporary sessions:

```sql
CREATE TABLE sessions (
    session_id INT PRIMARY KEY,
    user_id INT,
    created_at DATETIME
);
```

An event can remove expired sessions:

```sql
CREATE EVENT cleanup_sessions
ON SCHEDULE EVERY 1 HOUR
DO
    DELETE FROM sessions
    WHERE created_at < NOW() - INTERVAL 24 HOUR;
```

The database can now perform this cleanup automatically.

---

# 19. Scheduled Summary Updates

Suppose an application has a sales table and a daily summary table.

An event can periodically calculate summary information.

For example:

```text
sales
  ↓
Scheduled Event
  ↓
daily_sales_summary
```

This can reduce the need to repeatedly calculate expensive reports.

---

# 20. Events Calling Procedures

A practical architecture is:

```text
Event
  ↓
Stored Procedure
  ↓
INSERT / UPDATE / DELETE
  ↓
Triggers, if applicable
```

This combines several database automation features.

---

# 21. Events and Transactions

An event can contain transactional operations.

Example:

```sql
CREATE EVENT process_pending_orders
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
    START TRANSACTION;

    UPDATE orders
    SET status = 'PROCESSED'
    WHERE status = 'PENDING';

    COMMIT;
END;
```

Transaction design should be used carefully, especially when many rows are processed.

---

# 22. Events and Triggers

An event can modify a table that has triggers.

For example:

```text
Scheduled Event
      ↓
UPDATE employees
      ↓
UPDATE Trigger
      ↓
Audit table
```

Therefore, an event may indirectly cause trigger actions.

This is important when debugging automated database behavior.

---

# 23. Event Status

The `SHOW EVENTS` command provides information such as:

```text
Event name
Definer
Time zone
Event type
Execute at
Interval
Starts
Ends
Status
```

This helps determine whether an event is active and how it is scheduled.

---

# 24. One-Time vs Recurring Events

### One-time

```sql
ON SCHEDULE AT ...
```

Use when an operation should happen once.

### Recurring

```sql
ON SCHEDULE EVERY ...
```

Use when an operation should repeat.

Mental model:

```text
AT
→ once

EVERY
→ repeatedly
```

---

# 25. Common Event Intervals

Examples:

```sql
EVERY 10 SECOND
EVERY 5 MINUTE
EVERY 2 HOUR
EVERY 1 DAY
EVERY 1 WEEK
EVERY 1 MONTH
```

Choose an interval based on the business requirement.

---

# 26. Event Naming

Use descriptive names.

Good:

```text
cleanup_expired_sessions
generate_daily_sales_summary
archive_old_orders
process_pending_orders
```

Avoid vague names such as:

```text
event1
test_event
job
```

Clear names make database administration easier.

---

# 27. Events Should Be Idempotent When Possible

An operation is idempotent when running it multiple times does not create unintended repeated effects.

For example, a cleanup operation:

```sql
DELETE FROM sessions
WHERE created_at < NOW() - INTERVAL 24 HOUR;
```

is naturally safe to repeat because already-deleted rows are no longer present.

When designing scheduled jobs, consider what happens if the event executes again.

---

# 28. Avoiding Duplicate Processing

Suppose an event processes pending orders:

```sql
UPDATE orders
SET status = 'PROCESSED'
WHERE status = 'PENDING';
```

Changing the status makes it clear which rows have already been processed.

This prevents the same rows from being processed repeatedly.

---

# 29. Event Scheduler Security

Creating and modifying events requires appropriate MySQL privileges.

Not every database user will be able to:

```text
Create events
Alter events
Drop events
Enable or disable events
```

Permissions should be managed appropriately in production systems.

---

# 30. Time Zones

Events operate according to MySQL's time-zone configuration and event schedule.

When designing production schedules, make sure the expected time zone is clear.

This is especially important for applications serving users in multiple countries.

---

# 31. Debugging Events

When an event does not appear to execute, check:

```sql
SHOW VARIABLES LIKE 'event_scheduler';
```

Then:

```sql
SHOW EVENTS;
```

Then inspect the event:

```sql
SHOW CREATE EVENT event_name;
```

Check:

```text
Scheduler status
Event status
Schedule
Start time
End time
SQL definition
Privileges
```

---

# 32. Common Mistakes

### Mistake 1 — Event Scheduler is disabled

An event may exist but not execute if the scheduler is disabled.

### Mistake 2 — Incorrect schedule

Always verify:

```sql
SHOW CREATE EVENT event_name;
```

### Mistake 3 — Event is disabled

Check its status using:

```sql
SHOW EVENTS;
```

### Mistake 4 — Incorrect time assumptions

Verify the server/session time-zone configuration.

### Mistake 5 — Forgetting to remove test events

Test events should be removed after experimentation.

---

# 33. Event Lifecycle

A typical event lifecycle is:

```text
CREATE EVENT
     ↓
ENABLE
     ↓
EXECUTE
     ↓
ALTER
     ↓
DISABLE
     ↓
DROP
```

You should understand every stage.

---

# 34. Event + Procedure + Trigger

A more advanced database automation system can look like:

```text
                TIME
                 ↓
          Scheduled Event
                 ↓
        Stored Procedure
                 ↓
          UPDATE / INSERT
                 ↓
              Trigger
                 ↓
            Audit Table
```

This demonstrates how different database features can work together.

---

# 35. When to Use Scheduled Events

Good use cases include:

```text
Regular cleanup
Archiving
Periodic summaries
Maintenance
Refreshing derived data
Processing database queues
Deleting expired records
```

---

# 36. When Not to Use Scheduled Events

Avoid unnecessary events when:

```text
The task belongs clearly in application logic
The schedule is controlled externally
The operation is extremely complex
The event would create difficult hidden behavior
A simpler database feature is sufficient
```

Database automation should remain understandable.

---

# 37. Scheduled Events vs Triggers vs Procedures

| Feature                  | Trigger | Stored Procedure | Event |
| ------------------------ | ------- | ---------------- | ----- |
| Runs automatically       | Yes     | No               | Yes   |
| Triggered by data change | Yes     | No               | No    |
| Triggered by time        | No      | No               | Yes   |
| Called manually          | No      | Yes              | No    |
| Can contain SQL          | Yes     | Yes              | Yes   |
| Useful for automation    | Yes     | Indirectly       | Yes   |

---

# 38. Important Commands

Remember these:

```sql
CREATE EVENT
ALTER EVENT
DROP EVENT
SHOW EVENTS
SHOW CREATE EVENT
```

And:

```sql
SET GLOBAL event_scheduler = ON;
```

when you have the required permissions and your MySQL environment supports changing it dynamically.

---

# 39. Key Syntax

One-time:

```sql
CREATE EVENT event_name
ON SCHEDULE AT '2030-01-01 00:00:00'
DO
    SQL_statement;
```

Recurring:

```sql
CREATE EVENT event_name
ON SCHEDULE EVERY 1 DAY
DO
    SQL_statement;
```

Recurring with start and end:

```sql
CREATE EVENT event_name
ON SCHEDULE
    EVERY 1 DAY
    STARTS '2030-01-01 00:00:00'
    ENDS '2030-01-31 00:00:00'
DO
    SQL_statement;
```

---

# 40. Module 25 Key Takeaways

The most important concepts are:

```text
Event
→ database task scheduled by time

AT
→ one-time execution

EVERY
→ recurring execution

STARTS
→ when recurring execution begins

ENDS
→ when recurring execution stops

ENABLE
→ event is active

DISABLE
→ event remains defined but inactive
```

Important commands:

```sql
CREATE EVENT
ALTER EVENT
DROP EVENT
SHOW EVENTS
SHOW CREATE EVENT
```

The core mental model:

```text
TRIGGER
→ reacts to a data change

PROCEDURE
→ executes when called

EVENT
→ executes according to a schedule
```
