# Security Policy

## Overview

The `sql-practice` repository is a learning and portfolio project focused on MySQL 8.0+ and practical SQL development. The repository contains educational SQL examples, practice exercises, database schemas, sample datasets, and standalone SQL projects.

Although the repository is primarily educational, good security practices are important when working with databases. This document explains how security issues should be handled and provides guidelines for keeping the repository safe.

---

## Supported Scope

Security concerns related to the following areas are within the scope of this project:

* SQL scripts included in the repository
* Database schemas and constraints
* Database permissions and access-control examples
* Authentication and authorization examples
* SQL injection risks demonstrated by project code
* Accidental exposure of credentials or secrets
* Sensitive information accidentally committed to the repository
* Unsafe database configuration examples

---

## Reporting a Security Issue

If you discover a security issue in this repository, please do not publicly disclose sensitive information in a GitHub issue.

Instead, report the issue privately to the repository owner through the appropriate GitHub security reporting mechanism or private communication channel.

When reporting an issue, provide:

* A clear description of the problem
* The affected file or SQL script
* Steps required to reproduce the issue
* The potential security impact
* A suggested solution, if available

Please avoid including passwords, API keys, access tokens, personal information, or other sensitive data in the report.

---

## Sensitive Information

This repository should never contain real credentials or confidential information.

Do not commit:

* Database passwords
* API keys
* Access tokens
* Private keys
* Authentication secrets
* Production database credentials
* Real customer information
* Personal identification information
* Payment information
* Confidential business data

Use fictional data for all examples and practice projects.

For example, use:

```text
student@example.com
```

instead of a real person's email address.

Similarly, database credentials should never be hard-coded into SQL scripts.

Avoid code such as:

```sql
CREATE USER 'admin'@'localhost'
IDENTIFIED BY 'RealPassword123!';
```

For learning purposes, use placeholders when credentials need to be demonstrated:

```sql
CREATE USER 'example_user'@'localhost'
IDENTIFIED BY '<REPLACE_WITH_SECURE_PASSWORD>';
```

---

## SQL Injection Prevention

SQL injection occurs when untrusted user input is directly incorporated into SQL statements.

Avoid constructing SQL statements by concatenating user-provided values.

Unsafe example:

```text
SELECT * FROM users
WHERE username = '<user_input>';
```

Applications using this repository should use parameterized queries or prepared statements.

For example, conceptually:

```text
SELECT *
FROM users
WHERE username = ?;
```

The application should provide the user value separately as a parameter.

The SQL examples in this repository are primarily educational and are not intended to replace application-level security controls.

---

## Database Access Control

Database users should receive only the permissions they actually need.

The principle of least privilege should be followed whenever database permissions are configured.

For example, an account that only needs to read data should not automatically receive write or administrative privileges.

Example:

```sql
GRANT SELECT
ON sales_analysis.*
TO 'report_user'@'localhost';
```

Avoid unnecessarily granting broad privileges such as:

```sql
GRANT ALL PRIVILEGES
ON *.*
TO 'report_user'@'localhost';
```

Administrative privileges should be restricted to trusted database administrators.

---

## Production Database Safety

The SQL scripts in this repository are designed for learning and practice.

Before running any script against a production database:

1. Review the entire script.
2. Confirm the selected database.
3. Back up important data.
4. Test the script in a development environment.
5. Verify destructive statements such as `DROP`, `DELETE`, and `TRUNCATE`.
6. Confirm that the database user has appropriate permissions.
7. Review transaction behavior where applicable.

Be particularly careful with statements such as:

```sql
DROP DATABASE
```

```sql
DROP TABLE
```

```sql
TRUNCATE TABLE
```

```sql
DELETE FROM
```

These operations can permanently remove data.

---

## Use of Sample Data

All datasets included in the repository should be fictional or generated specifically for educational purposes.

The projects currently included in the repository use fictional datasets for:

* Student databases
* Library management
* Sales analysis

Do not replace these datasets with real personal, customer, employee, financial, or confidential information.

---

## Secure Configuration

Database configuration should be kept outside the repository whenever possible.

If an application connects to MySQL, credentials should preferably be supplied through environment variables or a secure secrets-management system rather than committed directly to source control.

For example:

```text
DB_HOST=localhost
DB_NAME=sales_analysis
DB_USER=example_user
DB_PASSWORD=<SECURE_PASSWORD>
```

A local environment file containing real credentials should not be committed to Git.

A `.gitignore` file should be configured to prevent accidental commits of files containing local secrets.

---

## Dependency and Tool Security

When using external tools, libraries, database clients, or application frameworks with this repository:

* Keep software reasonably up to date.
* Download tools from trusted sources.
* Review third-party SQL scripts before execution.
* Avoid executing unknown database scripts against important databases.
* Do not grant unnecessary system or database privileges to third-party tools.

---

## Security Best Practices for SQL Development

The following practices are recommended throughout this repository:

* Use primary keys to uniquely identify records.
* Use foreign keys to maintain referential integrity.
* Use appropriate `NOT NULL` constraints.
* Use `UNIQUE` constraints where appropriate.
* Validate data using `CHECK` constraints where supported.
* Use transactions for operations that must succeed or fail together.
* Follow the principle of least privilege.
* Use prepared statements in applications.
* Avoid exposing sensitive information in query results.
* Validate and sanitize external input at the application layer.
* Regularly review database permissions.
* Back up important databases before destructive operations.
* Avoid unnecessary administrative privileges.

---

## Security Education

Some modules in this repository intentionally demonstrate database security concepts, including:

* Database users
* Roles
* Privileges
* `GRANT`
* `REVOKE`
* Access control
* Least privilege

These examples are intended for educational purposes and should be adapted appropriately before being used in a real production environment.

---

## Disclaimer

This repository is an educational SQL learning project.

The examples are not intended to provide complete production-grade database security. Real-world systems require additional controls such as secure application development, authentication, authorization, encryption, network security, auditing, monitoring, backup strategies, and secure infrastructure configuration.

Users are responsible for reviewing and testing SQL scripts before executing them against important databases.

---

## Contact

For security-related concerns, please contact the repository owner through the private contact or security-reporting mechanism associated with the GitHub repository.

Do not publicly post sensitive security information in GitHub issues, discussions, pull requests, or commit messages.
