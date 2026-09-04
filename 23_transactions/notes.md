# Module 23 — SQL Transactions

A **transaction** is a sequence of SQL operations treated as one logical unit of work.

The main idea is simple:

```text
Transaction starts
      ↓
SQL operation 1
      ↓
SQL operation 2
      ↓
SQL operation 3
      ↓
COMMIT
```

If something goes wrong before the transaction is committed:

```text
Transaction starts
      ↓
SQL operation 1
      ↓
SQL operation 2
      ↓
ERROR
      ↓
ROLLBACK
```

Transactions are especially important when several related changes must remain consistent.

---

## 1. Why Transactions Matter

Imagine transferring ₹5,000 from Account A to Account B.

The operation requires two changes:

```sql
UPDATE accounts
SET balance = balance - 5000
WHERE account_id = 1;

UPDATE accounts
SET balance = balance + 5000
WHERE account_id = 2;
```

What happens if the first UPDATE succeeds but the second fails?

Without a transaction:

```text
Account A → -₹5,000
Account B → no change
```

The database becomes inconsistent.

With a transaction:

```text
START TRANSACTION
      ↓
Subtract from A
      ↓
Add to B
      ↓
COMMIT
```

Or, if something fails:

```text
ROLLBACK
```

Both changes are undone.

---

# 2. ACID Properties

Transactions are commonly described using four properties:

```text
A → Atomicity
C → Consistency
I → Isolation
D → Durability
```

Together they are called **ACID**.

---

# 3. Atomicity

Atomicity means:

> A transaction is treated as one indivisible unit.

Either all required operations succeed or the transaction is rolled back.

Example:

```text
Operation 1 ✓
Operation 2 ✓
Operation 3 ✗
       ↓
ROLLBACK
       ↓
All changes undone
```

---

# 4. Consistency

Consistency means a transaction should move the database from one valid state to another valid state.

For example, suppose:

```text
Total money before transfer = ₹100,000
```

After transferring money:

```text
Total money after transfer = ₹100,000
```

The transaction should not violate the database's defined rules and constraints.

---

# 5. Isolation

Isolation controls how transactions interact with each other when multiple transactions execute at the same time.

For example:

```text
Transaction A
       ↕
Transaction B
```

The database needs rules determining what changes one transaction can see from another.

Isolation levels are covered later in this module.

---

# 6. Durability

Once a transaction is committed:

```sql
COMMIT;
```

its changes are intended to persist even if the database server subsequently experiences a failure.

Conceptually:

```text
COMMIT
  ↓
Changes become permanent
```

---

# 7. Starting a Transaction

In MySQL you can use:

```sql
START TRANSACTION;
```

Example:

```sql
START TRANSACTION;

UPDATE accounts
SET balance = balance - 5000
WHERE account_id = 1;

UPDATE accounts
SET balance = balance + 5000
WHERE account_id = 2;

COMMIT;
```

---

# 8. `COMMIT`

`COMMIT` permanently applies the changes made by the current transaction.

Example:

```sql
START TRANSACTION;

UPDATE accounts
SET balance = balance - 1000
WHERE account_id = 1;

COMMIT;
```

After `COMMIT`, the update is saved.

---

# 9. `ROLLBACK`

`ROLLBACK` cancels changes made during the current transaction.

Example:

```sql
START TRANSACTION;

UPDATE accounts
SET balance = balance - 1000
WHERE account_id = 1;

ROLLBACK;
```

The UPDATE is undone.

---

# 10. Basic Transaction Pattern

Memorize this pattern:

```sql
START TRANSACTION;

-- SQL operations

COMMIT;
```

Or:

```sql
START TRANSACTION;

-- SQL operations

ROLLBACK;
```

The choice depends on whether you want to save or undo the transaction.

---

# 11. Transaction Example — Bank Transfer

Suppose:

```text
Account 1 → ₹20,000
Account 2 → ₹10,000
```

Transfer ₹5,000:

```sql
START TRANSACTION;

UPDATE accounts
SET balance = balance - 5000
WHERE account_id = 1;

UPDATE accounts
SET balance = balance + 5000
WHERE account_id = 2;

COMMIT;
```

Final balances:

```text
Account 1 → ₹15,000
Account 2 → ₹15,000
```

---

# 12. Rolling Back a Transfer

Suppose we test the transfer but do not want to save it:

```sql
START TRANSACTION;

UPDATE accounts
SET balance = balance - 5000
WHERE account_id = 1;

UPDATE accounts
SET balance = balance + 5000
WHERE account_id = 2;

ROLLBACK;
```

The balances return to their previous values.

---

# 13. Checking Data During a Transaction

You can query the data before committing.

Example:

```sql
START TRANSACTION;

UPDATE accounts
SET balance = balance - 5000
WHERE account_id = 1;

SELECT *
FROM accounts;

ROLLBACK;
```

The SELECT can be used to inspect the temporary transaction state.

---

# 14. Transactions with INSERT

Transactions can include INSERT statements.

```sql
START TRANSACTION;

INSERT INTO customers (
    customer_id,
    customer_name,
    city
)
VALUES (
    10,
    'Test Customer',
    'Delhi'
);

COMMIT;
```

The INSERT becomes permanent after COMMIT.

---

# 15. Transactions with DELETE

Example:

```sql
START TRANSACTION;

DELETE FROM customers
WHERE customer_id = 10;

ROLLBACK;
```

The deletion is undone.

---

# 16. Transactions with Multiple Operations

A transaction can contain different types of operations.

Example:

```sql
START TRANSACTION;

INSERT INTO orders (...);

UPDATE customers
SET ...
WHERE ...;

INSERT INTO order_items (...);

COMMIT;
```

This is useful when several changes represent one business operation.

---

# 17. Savepoints

A **SAVEPOINT** allows you to create a point inside a transaction to which you can partially roll back.

Example:

```sql
START TRANSACTION;

UPDATE accounts
SET balance = balance - 1000
WHERE account_id = 1;

SAVEPOINT after_first_update;

UPDATE accounts
SET balance = balance - 2000
WHERE account_id = 2;

ROLLBACK TO SAVEPOINT after_first_update;

COMMIT;
```

The first UPDATE remains, while the second UPDATE is undone.

---

# 18. Creating a Savepoint

Syntax:

```sql
SAVEPOINT savepoint_name;
```

Example:

```sql
SAVEPOINT before_order_update;
```

You can create multiple savepoints.

```sql
SAVEPOINT point_one;

SAVEPOINT point_two;

SAVEPOINT point_three;
```

---

# 19. Rolling Back to a Savepoint

Use:

```sql
ROLLBACK TO SAVEPOINT savepoint_name;
```

Example:

```sql
ROLLBACK TO SAVEPOINT point_two;
```

This rolls back changes made after that savepoint.

It does not necessarily end the entire transaction.

---

# 20. Releasing a Savepoint

Use:

```sql
RELEASE SAVEPOINT savepoint_name;
```

Example:

```sql
RELEASE SAVEPOINT point_two;
```

This removes the savepoint.

---

# 21. `START TRANSACTION` vs `COMMIT`

These commands have opposite roles.

```text
START TRANSACTION
→ begins a transaction

COMMIT
→ saves the transaction
```

Example:

```sql
START TRANSACTION;

UPDATE employees
SET salary = salary + 5000
WHERE employee_id = 101;

COMMIT;
```

---

# 22. Autocommit

MySQL commonly operates with **autocommit enabled** by default.

You can inspect it with:

```sql
SELECT @@autocommit;
```

If the result is:

```text
1
```

autocommit is enabled.

If:

```text
0
```

autocommit is disabled.

---

# 23. Disabling Autocommit

You can use:

```sql
SET autocommit = 0;
```

Then changes are not automatically committed.

Example:

```sql
SET autocommit = 0;

UPDATE employees
SET salary = salary + 1000
WHERE employee_id = 101;

COMMIT;
```

For learning, however, explicitly using:

```sql
START TRANSACTION;
```

is often easier to understand.

---

# 24. Re-enabling Autocommit

Use:

```sql
SET autocommit = 1;
```

This restores the normal autocommit behavior.

---

# 25. DDL and Transactions

DDL statements such as:

```sql
CREATE TABLE
ALTER TABLE
DROP TABLE
```

can behave differently from ordinary DML with respect to transactions in MySQL.

Some DDL statements cause implicit commits.

Therefore, do not assume that every SQL statement can be safely rolled back.

For transaction practice, focus primarily on:

```text
INSERT
UPDATE
DELETE
```

---

# 26. DML vs DDL

DML:

```text
INSERT
UPDATE
DELETE
```

These are commonly used inside transactions.

DDL:

```text
CREATE
ALTER
DROP
```

These have different transaction behavior in MySQL.

---

# 27. Isolation Levels

Transaction isolation determines how transactions interact with each other.

MySQL InnoDB supports:

```text
READ UNCOMMITTED
READ COMMITTED
REPEATABLE READ
SERIALIZABLE
```

---

# 28. READ UNCOMMITTED

The lowest isolation level.

A transaction may be able to see changes made by another transaction before those changes are committed.

This can result in:

```text
Dirty reads
```

It provides less isolation and potentially more concurrency.

---

# 29. READ COMMITTED

A transaction sees data committed by other transactions.

Uncommitted changes from another transaction are not normally visible.

This prevents dirty reads.

However, repeated queries can potentially see different committed values if another transaction commits changes between the queries.

---

# 30. REPEATABLE READ

A transaction can obtain a consistent view of data for repeated reads.

MySQL's default isolation level for InnoDB is:

```text
REPEATABLE READ
```

This provides stronger isolation than READ COMMITTED.

---

# 31. SERIALIZABLE

The strictest standard isolation level.

Transactions behave more like they are executed sequentially.

This provides stronger protection against concurrency anomalies but can reduce concurrency.

---

# 32. Isolation Level Comparison

Conceptually:

| Isolation Level  | Dirty Reads | Non-repeatable Reads | Phantom Reads        |
| ---------------- | ----------- | -------------------- | -------------------- |
| READ UNCOMMITTED | Possible    | Possible             | Possible             |
| READ COMMITTED   | Prevented   | Possible             | Possible             |
| REPEATABLE READ  | Prevented   | Prevented            | DB-specific behavior |
| SERIALIZABLE     | Prevented   | Prevented            | Prevented            |

The exact behavior can depend on the database engine and implementation.

For this repository, the important point is understanding the trade-off:

```text
More isolation
→ stronger consistency
→ potentially less concurrency
```

---

# 33. Viewing the Current Isolation Level

You can check it with:

```sql
SELECT @@transaction_isolation;
```

Depending on your MySQL version, you may also encounter:

```sql
SELECT @@tx_isolation;
```

---

# 34. Changing Isolation Level

Example:

```sql
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
```

Other choices:

```sql
SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;

SET SESSION TRANSACTION ISOLATION LEVEL SERIALIZABLE;
```

---

# 35. Transactions and Locks

When transactions modify data, the database may acquire locks.

Locks help coordinate concurrent access.

Conceptually:

```text
Transaction A
     ↓
locks row
     ↓
Transaction B
     ↓
waits / interacts according to isolation and locking rules
```

Locking is an important part of database concurrency.

---

# 36. Row-Level Locking

In InnoDB, operations can use row-level locking.

For example:

```sql
SELECT *
FROM accounts
WHERE account_id = 1
FOR UPDATE;
```

This is commonly used when a transaction needs to safely read and then modify a row.

Example:

```sql
START TRANSACTION;

SELECT balance
FROM accounts
WHERE account_id = 1
FOR UPDATE;

UPDATE accounts
SET balance = balance - 5000
WHERE account_id = 1;

COMMIT;
```

---

# 37. `FOR UPDATE`

`FOR UPDATE` is useful when a transaction intends to modify the selected rows.

Conceptually:

```text
SELECT row
    ↓
lock row
    ↓
perform calculation
    ↓
UPDATE
    ↓
COMMIT
```

This can help prevent conflicting concurrent modifications.

---

# 38. Transaction Workflow

A real-world transaction might look like:

```text
BEGIN
  ↓
Validate request
  ↓
Read required data
  ↓
Lock required rows if necessary
  ↓
Perform UPDATE/INSERT/DELETE
  ↓
Check result
  ↓
COMMIT
```

If an error occurs:

```text
ROLLBACK
```

---

# 39. Transactions and Stored Procedures

Stored procedures from Module 22 can contain transactions.

For example:

```sql
CREATE PROCEDURE transfer_money(...)
BEGIN

    START TRANSACTION;

    UPDATE accounts
    SET balance = balance - amount
    WHERE account_id = source_account;

    UPDATE accounts
    SET balance = balance + amount
    WHERE account_id = destination_account;

    COMMIT;

END;
```

In real systems, error handling should also be included.

---

# 40. Transaction Error Handling

A robust stored procedure can use handlers.

Conceptually:

```sql
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
    ROLLBACK;
END;
```

Then:

```sql
START TRANSACTION;

-- operations

COMMIT;
```

If a SQL exception occurs, the handler can roll back the transaction.

---

# 41. Why Rollback Is Important

Imagine an order-processing operation:

```text
1. Create order
2. Reduce inventory
3. Create payment record
4. Update customer total
```

If step 3 fails:

```text
Order created
Inventory reduced
Payment failed
Customer not updated
```

This is inconsistent.

A transaction can group the operations:

```text
START TRANSACTION
      ↓
Create order
      ↓
Reduce inventory
      ↓
Create payment
      ↓
Update customer
      ↓
COMMIT
```

If something fails:

```text
ROLLBACK
```

---

# 42. Transaction Best Practices

Keep transactions reasonably short.

Avoid:

```text
START TRANSACTION
      ↓
wait for user input
      ↓
wait 10 minutes
      ↓
UPDATE
      ↓
COMMIT
```

Long-running transactions can hold resources and interfere with other transactions.

Prefer:

```text
BEGIN
 ↓
required operations
 ↓
COMMIT
```

---

# 43. Don't Forget to Commit or Roll Back

A transaction should have a clear ending.

```sql
START TRANSACTION;

UPDATE ...;

COMMIT;
```

or:

```sql
START TRANSACTION;

UPDATE ...;

ROLLBACK;
```

Leaving transactions open unintentionally can cause locking and consistency problems.

---

# 44. Transaction Safety Pattern

For important operations:

```text
START TRANSACTION
      ↓
Validate
      ↓
Read
      ↓
Modify
      ↓
Verify
      ↓
COMMIT
```

If anything fails:

```text
ROLLBACK
```

---

# 45. Common Mistakes

### Mistake 1 — Forgetting COMMIT

```sql
START TRANSACTION;

UPDATE employees
SET salary = salary + 1000
WHERE employee_id = 101;
```

The intended transaction has not been explicitly committed.

---

### Mistake 2 — Using ROLLBACK After COMMIT

Once changes have been committed, a later rollback cannot normally undo that already committed transaction.

```sql
COMMIT;

ROLLBACK;
```

The rollback does not undo the committed transaction.

---

### Mistake 3 — Assuming Every SQL Statement Is Rollback-Safe

DDL can have implicit-commit behavior in MySQL.

Do not treat:

```text
CREATE
ALTER
DROP
```

the same way as ordinary DML.

---

### Mistake 4 — Making Transactions Too Long

Long transactions can hold locks and increase contention.

---

### Mistake 5 — Updating Multiple Related Records Without a Transaction

If several operations belong to one logical action, consider grouping them in a transaction.

---

# 46. Important Commands

Start:

```sql
START TRANSACTION;
```

Commit:

```sql
COMMIT;
```

Rollback:

```sql
ROLLBACK;
```

Savepoint:

```sql
SAVEPOINT point_name;
```

Rollback to savepoint:

```sql
ROLLBACK TO SAVEPOINT point_name;
```

Release savepoint:

```sql
RELEASE SAVEPOINT point_name;
```

Check autocommit:

```sql
SELECT @@autocommit;
```

Check isolation:

```sql
SELECT @@transaction_isolation;
```

---

# 47. Module 23 Key Takeaways

Remember:

```text
TRANSACTION
→ group of SQL operations treated as one unit

START TRANSACTION
→ begin

COMMIT
→ save

ROLLBACK
→ undo

SAVEPOINT
→ create a partial rollback point

ROLLBACK TO SAVEPOINT
→ undo changes after that savepoint

ACID
→ Atomicity
→ Consistency
→ Isolation
→ Durability
```

The most important practical pattern is:

```sql
START TRANSACTION;

-- related operations

COMMIT;
```

And when the operation cannot safely continue:

```sql
ROLLBACK;
```

Transactions are the foundation for building reliable database operations involving multiple changes.
