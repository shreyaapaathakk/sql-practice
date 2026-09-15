# Module 31 — Database Security & Access Control

## 1. Overview

Database security is the practice of protecting database systems, data, accounts, and database operations from unauthorized access, accidental changes, misuse, and other security risks.

In MySQL, database security mainly involves two related concepts:

* **Authentication** — determining who is connecting.
* **Authorization** — determining what that account is allowed to do.

A secure database should follow the **principle of least privilege**, meaning each user or application receives only the permissions required to perform its job.

This module focuses on MySQL 8.0+ user accounts, privileges, roles, access control, views as security layers, stored-routine security, and practical database security design.

---

## 2. Why Database Security Matters

Databases frequently contain sensitive and valuable information such as:

* Customer information
* Employee information
* Financial records
* Orders and payments
* Business reports
* Application data
* Authentication-related information

Giving every database user full access creates unnecessary risk.

For example, an application that only needs to read and update customer records should not automatically be allowed to:

* Drop databases
* Create users
* Grant privileges
* Delete unrelated tables
* Modify database structure

A good security model limits access according to responsibility.

---

## 3. Authentication vs Authorization

### Authentication

Authentication answers:

> Who are you?

For example, a user connects to MySQL using an account such as:

```sql
'app_user'@'localhost'
```

MySQL verifies the account and authentication credentials.

### Authorization

Authorization answers:

> What are you allowed to do?

For example:

```sql
GRANT SELECT ON sql_practice_security.products
TO 'app_user'@'localhost';
```

The account can authenticate, but its authorization determines whether it can execute particular operations.

---

## 4. MySQL User Accounts

A MySQL account is identified by both:

```text
'user'@'host'
```

The host is part of the account identity.

For example:

```sql
'report_user'@'localhost'
```

and:

```sql
'report_user'@'%'
```

are different account definitions.

The first restricts the account to connections matching `localhost`.

The second uses `%` as a broad host wildcard and should not be used casually because it can allow connections from many hosts depending on server/network configuration.

Use the narrowest appropriate host restriction.

---

## 5. Creating a User

Basic syntax:

```sql
CREATE USER 'username'@'host'
IDENTIFIED BY 'password';
```

Example:

```sql
CREATE USER 'report_user'@'localhost'
IDENTIFIED BY 'ExamplePassword123!';
```

A newly created account does not automatically receive normal database object privileges.

Privileges must be assigned separately.

### Important security rule

Never commit real passwords to GitHub.

For this learning repository, use clearly dummy credentials only, or use placeholders such as:

```sql
CREATE USER 'report_user'@'localhost'
IDENTIFIED BY '<strong-password>';
```

Production credentials should be supplied securely outside source control.

---

## 6. Authentication

Authentication verifies the identity of a connecting account.

Modern MySQL installations provide authentication mechanisms designed to securely verify users.

The exact authentication plugin and server configuration can vary between MySQL releases and deployments.

For application development, avoid hard-coding credentials into source code or SQL files stored in version control.

---

## 7. Password Management

Passwords should be:

* Strong
* Unique
* Stored securely
* Changed when necessary
* Never committed to public repositories

Avoid putting real passwords directly into:

```text
GitHub repositories
Source code
SQL scripts
Configuration files
Public documentation
```

For example, this should never contain a real production password:

```sql
CREATE USER 'production_app'@'localhost'
IDENTIFIED BY 'MyRealProductionPassword';
```

Instead, use secure secret-management mechanisms in real deployments.

---

## 8. Altering Users

`ALTER USER` modifies an existing account.

Example:

```sql
ALTER USER 'report_user'@'localhost'
IDENTIFIED BY '<new-password>';
```

Accounts can also be locked or unlocked.

```sql
ALTER USER 'report_user'@'localhost'
ACCOUNT LOCK;
```

Unlock:

```sql
ALTER USER 'report_user'@'localhost'
ACCOUNT UNLOCK;
```

Account locking is useful when an account should temporarily remain defined but should not be allowed to authenticate.

---

## 9. Dropping Users

Use:

```sql
DROP USER 'report_user'@'localhost';
```

This removes the MySQL account and its associated grants.

It does **not** mean that the tables or data owned by the database suddenly disappear.

Always verify that the account is no longer needed before dropping it.

---

## 10. Privileges

A privilege is a permission that allows an account or role to perform an operation.

Common privileges include:

```text
SELECT
INSERT
UPDATE
DELETE
CREATE
ALTER
DROP
EXECUTE
INDEX
REFERENCES
```

Privileges can be granted at different levels.

Common levels include:

```text
Global
Database
Table
Column
Routine
```

---

## 11. GRANT

`GRANT` assigns privileges.

Basic structure:

```sql
GRANT privilege
ON object
TO 'user'@'host';
```

Example:

```sql
GRANT SELECT
ON sql_practice_security.products
TO 'report_user'@'localhost';
```

The user can now read the specified table if no other security restriction prevents the operation.

---

## 12. Database-Level Privileges

A database-level privilege applies to objects within a database.

Example:

```sql
GRANT SELECT
ON sql_practice_security.*
TO 'report_user'@'localhost';
```

This gives the account `SELECT` access to tables and views within that database, subject to MySQL's privilege behavior and object access.

Database-level privileges are useful when a user needs consistent access across many objects in one database.

---

## 13. Table-Level Privileges

A privilege can be limited to a specific table.

Example:

```sql
GRANT SELECT
ON sql_practice_security.customers
TO 'report_user'@'localhost';
```

The user receives `SELECT` access to `customers`, but this does not automatically give the same table privilege on every table in the database.

This is more restrictive than granting access to the entire database.

---

## 14. Column-Level Privileges

MySQL can restrict certain privileges to specific columns.

Example:

```sql
GRANT SELECT (customer_id, customer_name)
ON sql_practice_security.customers
TO 'report_user'@'localhost';
```

The account can be given access only to the selected columns for that privilege.

Column-level privileges can be useful when a table contains sensitive information.

For example, a customer table might contain:

```text
customer_id
customer_name
email
phone
password_hash
```

A reporting user may need:

```text
customer_id
customer_name
```

but should not automatically receive access to sensitive authentication-related information.

---

## 15. Column-Level UPDATE Privileges

Column-specific privileges can also be useful for controlled updates.

Example:

```sql
GRANT UPDATE (customer_name, phone)
ON sql_practice_security.customers
TO 'support_user'@'localhost';
```

This allows the account to be granted update permission for specified columns rather than unrestricted updates on the table.

This supports the principle of least privilege.

---

## 16. Common Data Privileges

### SELECT

Reads data.

```sql
GRANT SELECT
ON sql_practice_security.products
TO 'report_user'@'localhost';
```

### INSERT

Adds rows.

```sql
GRANT INSERT
ON sql_practice_security.orders
TO 'app_user'@'localhost';
```

### UPDATE

Modifies existing rows.

```sql
GRANT UPDATE
ON sql_practice_security.orders
TO 'app_user'@'localhost';
```

### DELETE

Removes rows.

```sql
GRANT DELETE
ON sql_practice_security.orders
TO 'app_user'@'localhost';
```

---

## 17. Combining Privileges

Multiple privileges can be granted in one statement.

```sql
GRANT SELECT, INSERT, UPDATE
ON sql_practice_security.orders
TO 'app_user'@'localhost';
```

The account receives only the listed privileges.

Avoid granting additional privileges simply because they might be convenient.

---

## 18. Administrative Privileges

Some privileges affect database structure or server administration.

Examples include privileges related to:

```text
CREATE
ALTER
DROP
CREATE USER
GRANT OPTION
```

These privileges should be carefully restricted.

An application account normally should not have unrestricted administrative privileges.

---

## 19. GRANT ALL PRIVILEGES

It is possible to grant many privileges using:

```sql
GRANT ALL PRIVILEGES
ON sql_practice_security.*
TO 'user'@'localhost';
```

However, this should not be the default security strategy.

A production application rarely needs every privilege.

Prefer explicitly granting only what the application requires.

---

## 20. GRANT OPTION

`WITH GRANT OPTION` allows a grantee to pass certain privileges to other accounts.

Example:

```sql
GRANT SELECT
ON sql_practice_security.products
TO 'report_admin'@'localhost'
WITH GRANT OPTION;
```

This should be used carefully.

Giving users the ability to grant privileges to others increases their security responsibility and can create privilege-escalation risks if poorly controlled.

---

## 21. REVOKE

`REVOKE` removes privileges.

Example:

```sql
REVOKE SELECT
ON sql_practice_security.products
FROM 'report_user'@'localhost';
```

Multiple privileges can also be revoked:

```sql
REVOKE INSERT, UPDATE, DELETE
ON sql_practice_security.orders
FROM 'app_user'@'localhost';
```

Use `REVOKE` when an account no longer requires a permission.

---

## 22. Checking User Privileges

Use:

```sql
SHOW GRANTS FOR 'report_user'@'localhost';
```

This displays the grants associated with the account.

`SHOW GRANTS` is extremely useful when investigating access-control problems.

For example, if a user reports:

> I cannot update this table.

Check the user's grants before changing anything.

---

## 23. Roles

A role is a named collection of privileges.

Roles make access control easier to manage when multiple users require the same permissions.

Instead of granting the same privileges separately:

```text
User A → SELECT
User B → SELECT
User C → SELECT
User D → SELECT
```

create one role:

```text
reporting_role → SELECT
```

and assign that role to the appropriate users.

---

## 24. Creating a Role

Example:

```sql
CREATE ROLE 'reporting_role';
```

A role can then receive privileges.

```sql
GRANT SELECT
ON sql_practice_security.*
TO 'reporting_role';
```

The role now represents the reporting permission set.

---

## 25. Granting Roles to Users

Example:

```sql
GRANT 'reporting_role'
TO 'report_user'@'localhost';
```

The user receives the role.

This creates a useful separation:

```text
Role
  ↓
Defines permissions

User
  ↓
Receives role
```

---

## 26. Default Roles

A role can be configured as the default role for a user.

Example:

```sql
SET DEFAULT ROLE 'reporting_role'
TO 'report_user'@'localhost';
```

This allows the role to be automatically activated when the user connects.

---

## 27. Active Roles

Roles can be activated for a session using:

```sql
SET ROLE 'reporting_role';
```

The active role can be inspected with:

```sql
SELECT CURRENT_ROLE();
```

The distinction between assigned roles and active roles is important when working with MySQL role-based access control.

---

## 28. Role-Based Access Control

Role-Based Access Control (RBAC) assigns permissions according to job responsibilities.

For example:

```text
Reporting Role
    ↓
SELECT access

Application Role
    ↓
SELECT, INSERT, UPDATE, DELETE

Support Role
    ↓
Limited customer-data access

Database Administrator Role
    ↓
Administrative privileges
```

Users are assigned roles according to what they need to accomplish.

This is easier to manage than individually configuring every user's privileges.

---

## 29. Principle of Least Privilege

The principle of least privilege means:

> Give an account only the permissions it needs to perform its required tasks.

For example, an application that only reads product information should not receive:

```text
DROP
ALTER
CREATE USER
GRANT OPTION
```

Instead:

```sql
GRANT SELECT
ON sql_practice_security.products
TO 'catalog_reader'@'localhost';
```

Least privilege reduces the impact of compromised accounts and accidental operations.

---

## 30. Read-Only Users

A reporting account often needs read access but should not modify data.

Example:

```sql
CREATE USER 'report_user'@'localhost'
IDENTIFIED BY '<strong-password>';

GRANT SELECT
ON sql_practice_security.*
TO 'report_user'@'localhost';
```

This account can be used for dashboards, reports, and analysis where data modification is unnecessary.

---

## 31. Application Users

An application account should receive the permissions required by the application.

For example:

```sql
CREATE USER 'app_user'@'localhost'
IDENTIFIED BY '<strong-password>';

GRANT SELECT, INSERT, UPDATE, DELETE
ON sql_practice_security.*
TO 'app_user'@'localhost';
```

However, the exact privileges should depend on the application.

If the application never deletes records, `DELETE` should not be granted simply for convenience.

---

## 32. Administrative Users

Administrative accounts require significantly greater privileges.

They may be responsible for:

* User management
* Database configuration
* Schema changes
* Security management
* Backup and recovery
* Performance administration

Administrative privileges should be restricted to trusted administrative accounts.

Do not use an administrative account for routine application queries.

---

## 33. Separation of Duties

Security is stronger when responsibilities are separated.

For example:

```text
Administrator
    ↓
Manages database and security

Application User
    ↓
Runs application operations

Reporting User
    ↓
Reads approved data

Support User
    ↓
Performs limited customer operations
```

An application should not normally connect using an administrator account.

---

## 34. Views as a Security Layer

Views can expose only the data that a user needs.

Suppose the underlying table contains:

```text
customer_id
customer_name
email
phone
password_hash
```

A public reporting view could expose only:

```sql
CREATE VIEW customer_public AS
SELECT
    customer_id,
    customer_name,
    city
FROM customers;
```

Then grant access to the view:

```sql
GRANT SELECT
ON sql_practice_security.customer_public
TO 'report_user'@'localhost';
```

This creates a controlled interface over the underlying data.

---

## 35. Protecting Sensitive Columns

Sensitive columns may include:

```text
password_hash
authentication_tokens
private notes
financial information
personal identifiers
internal security information
```

Do not automatically expose every column to every user.

Possible approaches include:

* Column-level privileges
* Views
* Separate tables
* Roles
* Application-level access control

A common security principle is:

> If a user does not need to see the data, do not give the user access to it.

---

## 36. Stored Procedure Security

Stored routines can have security implications because they may execute database operations on behalf of a caller.

MySQL supports routine security contexts including:

```sql
SQL SECURITY DEFINER
```

and:

```sql
SQL SECURITY INVOKER
```

These determine whose privileges are used when the routine executes.

---

## 37. SQL SECURITY DEFINER

With:

```sql
SQL SECURITY DEFINER
```

the routine executes using the privileges associated with its definer account.

Example:

```sql
CREATE DEFINER = 'routine_owner'@'localhost'
PROCEDURE get_customer_summary()
SQL SECURITY DEFINER
BEGIN
    SELECT customer_id, customer_name
    FROM customers;
END;
```

This can be useful when a user should be able to execute a controlled operation without receiving direct access to all underlying tables.

However, it must be designed carefully.

A routine running with elevated privileges can become a security risk if it accepts unsafe inputs or exposes operations that callers should not be allowed to perform.

---

## 38. SQL SECURITY INVOKER

With:

```sql
SQL SECURITY INVOKER
```

the routine executes using the privileges of the account that invokes it.

Example:

```sql
CREATE PROCEDURE get_customer_summary()
SQL SECURITY INVOKER
BEGIN
    SELECT customer_id, customer_name
    FROM customers;
END;
```

The caller therefore needs the required privileges to perform the operations used by the routine.

---

## 39. DEFINER vs INVOKER

Conceptually:

```text
SQL SECURITY DEFINER
        ↓
Uses definer privileges
```

while:

```text
SQL SECURITY INVOKER
        ↓
Uses invoker privileges
```

Use `DEFINER` carefully because the routine may operate with greater privileges than the calling account.

The definer account must also remain valid and appropriately secured.

---

## 40. Security Risks with DEFINER Routines

A poorly designed `SQL SECURITY DEFINER` routine can accidentally create a privilege-escalation path.

For example, a procedure with elevated privileges should not blindly execute arbitrary user-provided SQL.

Avoid designing routines that allow callers to:

* Execute arbitrary SQL
* Modify unauthorized tables
* Bypass intended restrictions
* Access sensitive data
* Perform administrative operations

Use tightly controlled procedures with clearly defined inputs and outputs.

---

## 41. Roles and Stored Procedures

Roles can be combined with stored routines to build controlled application interfaces.

For example:

```text
Application User
       ↓
Application Role
       ↓
EXECUTE on approved procedures
       ↓
Stored Procedure
       ↓
Controlled database operation
```

This can reduce the need to expose direct table privileges.

---

## 42. EXECUTE Privilege

Users may need the `EXECUTE` privilege to call stored routines.

Example:

```sql
GRANT EXECUTE
ON PROCEDURE sql_practice_security.get_customer_summary
TO 'app_user'@'localhost';
```

This can be useful when the application should interact with the database through approved routines.

---

## 43. Restricting Application Access

A secure application architecture can look like:

```text
Application
     |
     v
Application User
     |
     v
Application Role
     |
     +---- SELECT
     +---- INSERT
     +---- UPDATE
     |
     v
Required database objects only
```

The application does not need unrestricted administrative access.

---

## 44. Host Restrictions

Because MySQL accounts include a host component, host restrictions can be part of the security model.

For example:

```sql
'app_user'@'localhost'
```

is more specific than:

```sql
'app_user'@'%'
```

Avoid broad host patterns unless they are actually required by the architecture.

Network-level controls such as firewalls should also be used in production environments.

---

## 45. Avoid Shared Accounts

Avoid using one database account for many unrelated people.

Bad pattern:

```text
All developers
    ↓
shared_user
```

Better:

```text
developer_1
developer_2
developer_3
```

with access assigned through appropriate roles.

Individual accounts improve accountability and make access changes easier.

---

## 46. Development, Testing, and Production

Do not automatically reuse production credentials in development.

Maintain separate access models for:

```text
Development
Testing
Production
```

Production accounts should be more restricted and protected than development accounts.

Never copy real production credentials into a learning repository.

---

## 47. Secrets Must Stay Outside Git

A GitHub repository should never contain:

```text
Real database passwords
API keys
Private keys
Production connection strings
Authentication tokens
Cloud credentials
```

Use secure environment configuration or an appropriate secret-management system.

For learning examples, use placeholders:

```text
<database-password>
<production-host>
<username>
```

---

## 48. Database Security and GitHub

Because this project is intended to be hosted on GitHub, security hygiene is especially important.

Before committing SQL files, search for:

```text
password
secret
token
api_key
private_key
connection_string
```

Make sure that any credentials are clearly dummy values or placeholders.

Even a private repository should not be treated as a secure password-storage mechanism.

---

## 49. Privilege Auditing

Regularly review:

```sql
SHOW GRANTS FOR 'user'@'host';
```

Check:

* Which users exist
* Which roles exist
* Which privileges are assigned
* Whether privileges are still required
* Whether unused accounts should be locked or removed
* Whether excessive privileges exist

Security is not a one-time configuration task.

---

## 50. Common Security Mistake: Giving Everyone Full Access

Avoid:

```sql
GRANT ALL PRIVILEGES
ON *.*
TO 'app_user'@'localhost';
```

This can provide far more access than the application needs.

Instead, identify the actual operations required by the application.

For example:

```sql
GRANT SELECT, INSERT, UPDATE
ON sql_practice_security.orders
TO 'app_user'@'localhost';
```

---

## 51. Common Security Mistake: Using Administrative Accounts for Applications

Do not configure an application to connect as a highly privileged administrator simply because the connection works.

If the application is compromised, excessive privileges can greatly increase the damage.

Use a dedicated application account.

---

## 52. Common Security Mistake: Excessive GRANT OPTION

Avoid unnecessarily giving:

```sql
WITH GRANT OPTION
```

A user who can grant privileges to other accounts has greater authority than a normal data user.

Grant this capability only when the role genuinely requires it.

---

## 53. Common Security Mistake: Exposing Sensitive Columns

Avoid granting broad access to tables containing sensitive information.

Instead of:

```sql
GRANT SELECT
ON sql_practice_security.customers
TO 'report_user'@'localhost';
```

consider whether a controlled view is more appropriate.

For example:

```sql
CREATE VIEW customer_report AS
SELECT
    customer_id,
    customer_name,
    city
FROM customers;
```

Then grant access to the view.

---

## 54. Common Security Mistake: Ignoring Unused Accounts

Unused accounts increase the attack surface.

Accounts that are no longer required should be:

* Locked
* Reviewed
* Removed when appropriate

Example:

```sql
ALTER USER 'old_user'@'localhost'
ACCOUNT LOCK;
```

---

## 55. Common Security Mistake: Assuming Roles Automatically Solve Security

Roles make privilege management easier, but they do not automatically create a secure system.

You still need to:

* Design appropriate roles
* Grant only required privileges
* Review role membership
* Protect administrative roles
* Test permissions
* Remove unnecessary access

---

## 56. Common Security Mistake: Confusing Authentication with Authorization

A successful login does not mean the user should be able to access everything.

Think:

```text
Authentication
     ↓
Who is this?

Authorization
     ↓
What can this account do?
```

Both are required for a secure database.

---

## 57. Practical Security Model

A simple production-style model can be:

```text
Database Administrator
        |
        +-- Administrative privileges

Reporting User
        |
        +-- SELECT on approved tables/views

Application User
        |
        +-- SELECT
        +-- INSERT
        +-- UPDATE
        +-- DELETE
        |   only where required

Support User
        |
        +-- Limited customer operations
```

Roles can be used to represent these permission sets.

---

## 58. Example RBAC Design

Imagine an e-commerce database.

Possible roles:

```text
reporting_role
application_role
support_role
```

### Reporting role

```sql
GRANT SELECT
ON sql_practice_security.orders
TO 'reporting_role';
```

### Application role

```sql
GRANT SELECT, INSERT, UPDATE
ON sql_practice_security.orders
TO 'application_role';
```

### Support role

```sql
GRANT SELECT, UPDATE
ON sql_practice_security.customers
TO 'support_role';
```

The exact privileges should always be based on actual business requirements.

---

## 59. Testing Security

Security should be tested rather than assumed.

For each user or role, test:

```text
Can the user SELECT?
Can the user INSERT?
Can the user UPDATE?
Can the user DELETE?
Can the user access restricted tables?
Can the user access sensitive columns?
Can the user execute required procedures?
Can the user perform administrative operations?
```

A good security test verifies both:

```text
Allowed operations
```

and:

```text
Denied operations
```

---

## 60. Least-Privilege Design Process

A practical process is:

### Step 1 — Identify the user

Example:

```text
Reporting analyst
```

### Step 2 — Identify required tasks

```text
Read sales reports
```

### Step 3 — Identify required objects

```text
sales_summary
customer_report
```

### Step 4 — Grant minimum privileges

```sql
GRANT SELECT
ON sql_practice_security.sales_summary
TO 'report_user'@'localhost';
```

### Step 5 — Test access

Confirm that required queries work.

### Step 6 — Test restrictions

Confirm that unnecessary operations fail.

---

## 61. Security Through Views

Views can act as controlled data interfaces.

Instead of:

```text
User → Full Table
```

you can use:

```text
User
  ↓
Approved View
  ↓
Underlying Table
```

This is especially useful for:

* Reporting
* Sensitive data
* Public-facing data
* Data masking strategies
* Limiting exposed columns

---

## 62. Security Through Roles

Roles provide a reusable permission layer.

Instead of:

```text
User A → SELECT
User B → SELECT
User C → SELECT
```

use:

```text
reporting_role
      ↓
   SELECT
      ↓
User A
User B
User C
```

When the permission set changes, the role can be updated rather than individually editing every user.

---

## 63. Security Through Stored Procedures

Stored procedures can provide controlled operations.

For example:

```text
Application
    ↓
EXECUTE permission
    ↓
Stored Procedure
    ↓
Controlled UPDATE
```

This can be useful when direct table modification should be restricted.

However, stored procedures should not be treated as automatically secure. Their SQL, parameters, privileges, and security context must be designed carefully.

---

## 64. Object Privileges vs Administrative Privileges

It is useful to distinguish:

### Object privileges

Permissions on database objects such as:

```text
Tables
Views
Procedures
```

Examples:

```text
SELECT
INSERT
UPDATE
DELETE
EXECUTE
```

### Administrative privileges

Permissions that affect broader database administration.

Examples can include capabilities related to:

```text
User management
Server configuration
Privilege management
Database administration
```

Administrative access should be much more restricted.

---

## 65. Security Checklist

Before considering a database access model complete, check:

* [ ] Every account has a specific purpose.
* [ ] Users receive only necessary privileges.
* [ ] Application accounts are separate from administrative accounts.
* [ ] Reporting accounts are preferably read-only.
* [ ] Roles are used where permissions are shared.
* [ ] Sensitive columns are protected.
* [ ] Views are considered for restricted data exposure.
* [ ] Stored routines use appropriate security contexts.
* [ ] `GRANT OPTION` is restricted.
* [ ] Unused accounts are locked or removed.
* [ ] Host restrictions are appropriately narrow.
* [ ] Real passwords are never committed to GitHub.
* [ ] Production credentials are kept outside source control.
* [ ] Privileges are reviewed regularly.
* [ ] Both allowed and denied operations are tested.

---

## 66. Recommended Security Workflow

A practical workflow is:

```text
Identify users
      ↓
Identify responsibilities
      ↓
Identify required database objects
      ↓
Define roles
      ↓
Grant minimum privileges
      ↓
Assign roles to users
      ↓
Protect sensitive data
      ↓
Test allowed operations
      ↓
Test denied operations
      ↓
Review privileges regularly
```

This workflow can be applied to both small learning databases and larger production systems.

---

## 67. Key Takeaways

The most important concepts from this module are:

1. Authentication determines who is connecting.
2. Authorization determines what the account can do.
3. A MySQL account is identified by `user@host`.
4. `CREATE USER` creates accounts.
5. `ALTER USER` modifies account configuration.
6. `DROP USER` removes accounts.
7. `GRANT` assigns privileges.
8. `REVOKE` removes privileges.
9. `SHOW GRANTS` helps inspect access.
10. Privileges can be granted at different scopes.
11. Roles group reusable permission sets.
12. `SET DEFAULT ROLE` controls automatic role activation.
13. Least privilege reduces security risk.
14. Application users should not normally be administrators.
15. Reporting users often need read-only access.
16. Views can limit which data users can access.
17. Column-level privileges can restrict access to specific columns.
18. Stored routines can execute using `DEFINER` or `INVOKER` security contexts.
19. `SQL SECURITY DEFINER` must be designed carefully because it can use elevated privileges.
20. Real passwords and secrets should never be committed to GitHub.
21. Security requires regular privilege reviews and testing.

---

## 68. Learning Goal

After completing Module 31, you should be able to:

* Create and manage MySQL users.
* Understand MySQL authentication and authorization.
* Grant and revoke privileges.
* Understand global, database, table, and column-level permissions.
* Inspect user grants.
* Create and use roles.
* Apply role-based access control.
* Design read-only, application, reporting, and administrative access models.
* Apply the principle of least privilege.
* Protect sensitive columns.
* Use views as a security layer.
* Understand `SQL SECURITY DEFINER` and `SQL SECURITY INVOKER`.
* Design safer stored-routine access.
* Avoid common database security mistakes.
* Build a practical MySQL access-control model suitable for a real-world application.
* Keep credentials and secrets out of a GitHub repository.
