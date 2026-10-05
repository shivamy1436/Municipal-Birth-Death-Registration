# Municipal Birth and Death Registration Database

## 1. Project Title

Municipal Birth and Death Registration Database Using SQL

---

## 2. Problem Statement

A municipal registrar records births and deaths reported by hospitals and households, issues certificates, and handles correction requests raised later by families.

The database stores registration details, informant information, issuing offices, certificates, and correction requests.

---

## 3. Objectives

The main objectives of this project are:

- Store birth and death registration records.
- Store informant details.
- Maintain issuing office information.
- Issue and track certificates.
- Record correction requests.
- Generate monthly registration reports.
- Retrieve information using SQL queries and JOIN operations.
- Demonstrate NULL handling in SQL.
- Demonstrate filtering, grouping, aggregation and subqueries.
- Generate reports from municipal registration data.

---

## 4. Technologies Used

- PostgreSQL
- SQL
- psql Terminal
- Visual Studio Code
- PostgreSQL Database

---

## 5. Database Tables

The database contains the following five tables:

1. `issuing_offices`
2. `informants`
3. `registrations`
4. `certificates`
5. `correction_requests`

---

## 6. Database Relationships

The database uses primary keys and foreign keys to establish relationships between tables.

### Main Relationships

- One issuing office can handle many registrations.
- One informant can be associated with many registrations.
- One registration can have a certificate.
- One registration can have correction requests.
- `registrations` is connected to `informants` using `informant_id`.
- `registrations` is connected to `issuing_offices` using `office_id`.
- `certificates` is connected to `registrations` using `registration_id`.
- `certificates` is connected to `issuing_offices` using `issuing_office_id`.
- `correction_requests` is connected to `registrations` using `registration_id`.

---

## 7. Project Files

The project contains the following files:

### `schema.sql`

Creates all database tables, primary keys, foreign keys and constraints.

The schema contains:

- `issuing_offices`
- `informants`
- `registrations`
- `certificates`
- `correction_requests`

It also uses constraints such as:

- `PRIMARY KEY`
- `FOREIGN KEY`
- `NOT NULL`
- `CHECK`
- `DEFAULT`

---

### `seed.sql`

Contains sample / fictional data for the database.

The seed file inserts data into:

- Issuing offices
- Informants
- Registrations
- Certificates
- Correction requests

---

### `queries.sql`

Contains SQL queries used for:

- Data filtering
- NULL checking
- Date calculations
- Pagination
- `BETWEEN`
- `IN`
- `LIKE`
- `DISTINCT`
- `GROUP BY`
- `HAVING`
- `JOIN`
- `LEFT JOIN`
- Subqueries
- Certificate reports
- Office-wise reports
- Correction request reports

---

### `README.md`

Contains project documentation, database structure, objectives, SQL operations, reports and conclusion.

---

## 8. Sample Data

The database contains sample / fictional municipal registration data.

The seed data includes:

- 5 issuing offices
- 12 informants
- 30 registration records
- Certificates for registrations
- 11 correction requests

The registration records include both:

- `BIRTH`
- `DEATH`

registration types.

Some registration records intentionally contain `NULL` values for `informant_id` to demonstrate NULL handling in SQL.

---

## 9. Important SQL Operations

The project demonstrates the following SQL operations:

- `CREATE TABLE`
- `DROP TABLE`
- `INSERT`
- `SELECT`
- `WHERE`
- `IS NULL`
- `= NULL` comparison example
- `ORDER BY`
- `LIMIT`
- `OFFSET`
- `BETWEEN`
- `IN`
- `LIKE`
- `DISTINCT`
- `GROUP BY`
- `HAVING`
- `JOIN`
- `LEFT JOIN`
- Subqueries
- Aggregate functions
- Date calculations

---

# 10. SQL Queries and Reports

## Q1. March Birth Registrations

Retrieves birth registrations where the event date falls in March 2026.

This query demonstrates:

- `WHERE`
- `DATE` filtering
- `ORDER BY`

---

## Q2. Registrations Without Informant

Retrieves registrations where no informant is associated with the registration.

```sql
SELECT
    registration_id,
    registration_type,
    recorded_person_name,
    informant_id
FROM registrations
WHERE informant_id IS NULL
ORDER BY registration_id;