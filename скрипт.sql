DROP DATABASE IF EXISTS company;
CREATE DATABASE company;
USE company;

CREATE TABLE IF NOT EXISTS department (
  department_id INT NOT NULL AUTO_INCREMENT,
  department_name VARCHAR(30) NOT NULL UNIQUE,
  city VARCHAR(30) NOT NULL DEFAULT 'Lviv',
  street VARCHAR(50),                  
  building_no INT NOT NULL,                     
  PRIMARY KEY (department_id)
);

CREATE TABLE IF NOT EXISTS employee (
  employee_id INT NOT NULL AUTO_INCREMENT,
  user_name VARCHAR(50) NOT NULL UNIQUE,
  first_name VARCHAR(30) NOT NULL,
  last_name VARCHAR(30) NOT NULL,
  position VARCHAR(50),
  employment_date DATE,
  department_id INT,          
  manager_id INT,
  rate DECIMAL(10,2) NOT NULL,
  bonus DECIMAL(10,2),
  PRIMARY KEY (employee_id)
);

CREATE TABLE IF NOT EXISTS customer (
  customer_id INT NOT NULL AUTO_INCREMENT,
  first_name VARCHAR(30) NOT NULL,
  last_name VARCHAR(30) NOT NULL,
  gender CHAR(1),
  birth_date DATE,
  phone_number VARCHAR(20) UNIQUE, 
  email VARCHAR(100) UNIQUE,
  discount INT,
  PRIMARY KEY (customer_id)
);

CREATE TABLE IF NOT EXISTS product (
  product_id INT NOT NULL AUTO_INCREMENT,
  product_name VARCHAR(100) NOT NULL,
  product_description VARCHAR(255),
  category VARCHAR(50),
  manufacture VARCHAR(50),
  product_type VARCHAR(50),
  amount INT,
  price DECIMAL(10,2),
  PRIMARY KEY (product_id)
);


CREATE TABLE IF NOT EXISTS invoice (
  invoice_id BIGINT NOT NULL,         
  employee_id INT,                      
  customer_id INT,                    
  payment_method TINYINT,
  transaction_moment DATETIME,
  status varchar(10) NOT NULL,
  PRIMARY KEY (invoice_id)
);


CREATE TABLE IF NOT EXISTS orders (
  orders_id INT NOT NULL AUTO_INCREMENT,
  invoice_id BIGINT NOT NULL,
  product_id INT NOT NULL,
  quantity INT NOT NULL,
  order_datetime DATETIME NOT NULL,   
  PRIMARY KEY (orders_id)
);


ALTER TABLE employee
  ADD CONSTRAINT fk_employee_department FOREIGN KEY (department_id) REFERENCES department(department_id),
  ADD CONSTRAINT fk_employee_manager FOREIGN KEY (manager_id) REFERENCES employee(employee_id);

ALTER TABLE invoice
  ADD CONSTRAINT fk_invoice_employee FOREIGN KEY (employee_id) REFERENCES employee(employee_id),
  ADD CONSTRAINT fk_invoice_customer FOREIGN KEY (customer_id) REFERENCES customer(customer_id);

ALTER TABLE orders
  ADD CONSTRAINT fk_orders_invoice FOREIGN KEY (invoice_id) REFERENCES invoice(invoice_id),
  ADD CONSTRAINT fk_orders_product FOREIGN KEY (product_id) REFERENCES product(product_id);
  
  
  -- Lab 3.1
  
SELECT * FROM department;
SELECT * FROM employee;
SELECT * FROM customer;
SELECT * FROM product;
SELECT * FROM invoice;
SELECT * FROM orders;


-- Lab 4

-- 1
USE company;
SELECT * FROM customer
ORDER BY last_name ASC;

-- 2
SELECT 
distinct
 manufacture 
FROM
 product
ORDER BY 
 manufacture ASC;
 
-- 3
SELECT
 product_name,
 manufacture,
 category,
 product_type,
 price
FROM
 product
WHERE 
 manufacture LIKE 'DELL'
ORDER BY
 product_name ASC;

-- 4
SELECT
 first_name,
 last_name,
 gender,
 birth_date,
 phone_number
FROM
 customer
WHERE 
 gender = 'F'
AND
 birth_date
 BETWEEN '1989-12-31'
 AND '2000-12-31'
ORDER BY
 last_name ASC;
 
-- 5
SELECT * FROM product
WHERE 
 category = 'NOTEBOOK'
AND product_description LIKE '%512GB%'
AND amount > 0;
 
 -- 6
 SELECT * FROM product
 WHERE
  amount > 0
  AND category IN ('NOTEBOOK', 'DesKtops')
  AND (product_description LIKE '%512GB%' OR product_description LIKE '%1 TB%');

-- 7
SELECT * FROM invoice
WHERE customer_id is NULL;



-- Lab 5

-- 1

-- I method

USE company;
SELECT 
    o.orders_id AS 'Orders ID',
    p.product_name AS 'Product name',
    p.category AS 'Product category',
    i.invoice_id AS 'Invoice ID',
    i.transaction_moment AS 'Transaction moment',
    c.last_name AS 'Customer last name',
    c.first_name AS 'Customer first name'
FROM 
    orders AS o
JOIN 
    invoice i ON o.invoice_id = i.invoice_id
JOIN 
    customer c ON i.customer_id = c.customer_id
JOIN 
    product p ON o.product_id = p.product_id
ORDER BY 
    o.orders_id;
    
-- II method

SELECT 
   o.orders_id AS 'Orders ID',
    p.product_name AS 'Product name',
    p.category AS 'Product category',
    i.invoice_id AS 'Invoice ID',
    i.transaction_moment AS 'Transaction moment',
    c.last_name AS 'Customer last name',
    c.first_name AS 'Customer first name'
FROM
   orders AS o,
   invoice AS i,
   product AS p,
   customer AS c
WHERE 
    o.invoice_id = i.invoice_id
AND i.customer_id = c.customer_id
AND o.product_id = p.product_id

ORDER BY o.orders_id;


-- 2
-- part.1
USE company;
SELECT 
  e.first_name AS 'Employee first name',
  e.last_name AS 'Employee last name',
  d.department_name AS 'Department'
FROM
  employee AS e
JOIN
  department AS d ON e.department_id = d.department_id
WHERE 
  d.department_name = 'Mercury';
  
  
  -- part.2
SELECT 
  o.orders_id AS 'Orders ID', 
  p.product_name AS 'Product name',
  p.category AS 'Product category',
  i.invoice_id AS 'Invoice ID',
  i.transaction_moment AS 'Transaction moment',
  c.last_name AS 'Customer last name',
  c.first_name AS 'Customer first name'
FROM
  orders AS o
JOIN
  invoice AS i ON i.invoice_id = o.invoice_id
JOIN
  customer AS c ON i.customer_id = c.customer_id
JOIN
  product AS p ON o.product_id = p.product_id
WHERE
  i.transaction_moment 
  BETWEEN '2023-07-01'
  AND '2023-11-01'
ORDER BY o.orders_id;


-- 3

USE company;
SELECT
  c.customer_id AS 'Customer ID',
  c.last_name AS 'Last Name', 
  c.first_name AS 'First Name', 
  i.invoice_id AS 'Invoice ID', 
  i.transaction_moment AS 'Transaction Moment'
FROM 
  customer AS c
LEFT JOIN
    invoice AS i ON c.customer_id = i.customer_id

UNION

SELECT
  c.customer_id AS 'Customer ID',
  c.last_name AS 'Last Name', 
  c.first_name AS 'First Name', 
  i.invoice_id AS 'Invoice ID', 
  i.transaction_moment AS 'Transaction Moment'
FROM 
  customer AS c
RIGHT JOIN
    invoice AS i ON c.customer_id = i.customer_id
WHERE 
    c.customer_id IS NULL
ORDER BY 'Invoice ID';