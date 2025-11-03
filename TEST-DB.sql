-- Create the test database:
CREATE DATABASE test;

-- Switch to the test database:
USE test;

-- Create a basic table:
CREATE TABLE employees (id char(1), name varchar(40));



-- Add two employees to the table:
INSERT INTO employees VALUES (1, "Alice");
INSERT INTO employees VALUES (2, "Bob");


-- Add two employees to the table:
SELECT * FROM employees