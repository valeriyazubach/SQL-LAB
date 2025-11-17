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