# SQL Learning Repository

This repository contains various SQL commands and queries that I wrote while learning SQL. The files demonstrate different SQL techniques and practices. Below is an overview of the files included in this repository.

## 📂 Repository Contents

### AggregateFunctionsAndGroupBy

This file includes examples of SQL aggregate functions and the `GROUP BY` clause. Aggregate functions such as `COUNT()`, `SUM()`, `AVG()`, `MAX()`, and `MIN()` are used to perform calculations on a set of values and return a single value.

### DataDefinitionLanguage

This file showcases examples of SQL commands related to Data Definition Language (DDL), including creating, altering, and dropping tables, schemas, and other database objects.

### RelationalDatabase

This file contains SQL queries that demonstrate relational database concepts, such as joining tables and querying data across multiple related tables.

**Examples in `relationaldatabase.sql`:**

- **Basic query to select all columns from the `USERS` table:**

    ```sql
    SELECT * FROM USERS;
    ```

- **Query using traditional methods to join tables:**

    ```sql
    SELECT
    U.USERNAME_, U.NAMESURNAME, U.EMAIL, C.COUNTRY, CT.CITY, T.TOWN, A.ADDRESSTEXT
    FROM USERS U, ADDRESS A, COUNTRIES C, CITIES CT, TOWNS T
    WHERE U.ID = A.USERID AND A.COUNTRYID = C.ID AND A.CITYID = CT.ID AND A.TOWNID = T.ID
    ORDER BY 1, 2, 5;
    ```

- **Using `JOIN` syntax to achieve the same result:**

    ```sql
    SELECT
    U.USERNAME_, U.NAMESURNAME, U.EMAIL, A.ADDRESSTEXT
    FROM USERS U
    JOIN ADDRESS A ON U.ID = A.USERID
    ORDER BY 1;
    ```

- **Query combining multiple `JOIN`s to retrieve detailed information:**

    ```sql
    SELECT
    U.USERNAME_, U.NAMESURNAME, U.EMAIL, C.COUNTRY, CT.CITY, T.TOWN, A.ADDRESSTEXT
    FROM USERS U
    JOIN ADDRESS A ON U.ID = A.USERID
    JOIN COUNTRIES C ON A.COUNTRYID = C.ID
    JOIN CITIES CT ON A.CITYID = CT.ID
    JOIN TOWNS T ON A.TOWNID = T.ID
    ORDER BY 1, 2, 5;
    ```

## 📚 Learning Objectives

The files in this repository cover a range of SQL concepts including:

- Basic SQL commands
- Aggregate functions and grouping
- Relational database querying and joins
- Data Definition Language (DDL) operations

Feel free to explore and use these SQL commands as examples for learning and reference.
