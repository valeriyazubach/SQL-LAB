DROP DATABASE IF EXISTS company;
CREATE DATABASE company;
USE company;

CREATE TABLE IF NOT EXISTS `department` (
	`department_id` INT NOT NULL AUTO_INCREMENT,
	`department_name` VARCHAR(30) NOT NULL unique,
	`city` VARCHAR(30) NOT NULL DEFAULT 'Lviv', 
	`street` VARCHAR(50),          
	`building_no` INT NOT NULL,
	PRIMARY KEY (`department_id`)
);

CREATE TABLE IF NOT EXISTS `employee` (
	`employee_id` INT NOT NULL AUTO_INCREMENT,
	`user_name` VARCHAR(50) NOT NULL UNIQUE,
	`first_name` VARCHAR(30) NOT NULL,
	`last_name` VARCHAR(30) NOT NULL,
	`position` VARCHAR(30),         
	`employment_date` DATE,
	`department_id` INT,
	`manager_id` INT,
	`rate` decimal (10,2) NOT NULL,
	`bonus` decimal (10,2),
	PRIMARY KEY (`employee_id`)
);

CREATE TABLE IF NOT EXISTS `customer` (
	`customer_id` INT AUTO_INCREMENT NOT NULL,
	`first_name` VARCHAR(30) NOT NULL,
	`last_name` VARCHAR(30) NOT NULL,
	`gender` CHAR(1),          
	`birth_date` DATE,
	`phone_number` VARCHAR (20) unique,          
	`email` VARCHAR(100) unique,
	`discount` INT,
	PRIMARY KEY (`customer_id`)
);

CREATE TABLE IF NOT EXISTS `product` (
	`product_id` INT NOT NULL AUTO_INCREMENT,
	`product_name` VARCHAR(100) NOT NULL,
	`product_description` VARCHAR(255),
	`category` VARCHAR(50),
	`manufacture` VARCHAR(50),
	`product_type` VARCHAR(50),
	`amount` INT,
	`price` DECIMAL(10,2),
	PRIMARY KEY (`product_id`)
);

CREATE TABLE IF NOT EXISTS `invoice` (
    `invoice_id` BIGINT NOT NULL,
    `employee_id` INT,             
	`customer_id` INT,             
    `payment_method` TINYINT,
	`transaction_moment` DATETIME,
	`status` VARCHAR(10) NOT NULL,
	PRIMARY KEY (`invoice_id`)             
);

CREATE TABLE IF NOT EXISTS `orders` (
	`orders_id` INT AUTO_INCREMENT NOT NULL,
	`invoice_id` BIGINT NOT NULL,          
	`product_id` INT NOT NULL,
	`order_datetime` DATETIME NOT NULL,
	`quantity` INT NOT NULL,
	PRIMARY KEY (`orders_id`)
);

ALTER TABLE `employee` 
ADD CONSTRAINT `employee_fk_dept` FOREIGN KEY (`department_id`) REFERENCES `department`(`department_id`),
ADD CONSTRAINT `employee_fk_manager` FOREIGN KEY (`manager_id`) REFERENCES `employee`(`employee_id`); 

ALTER TABLE `invoice` 
ADD CONSTRAINT `invoice_fk_employee` FOREIGN KEY (`employee_id`) REFERENCES `employee`(`employee_id`),
ADD CONSTRAINT `invoice_fk_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer`(`customer_id`);

ALTER TABLE `orders` 
ADD CONSTRAINT `orders_fk_invoice` FOREIGN KEY (`invoice_id`) REFERENCES `invoice`(`invoice_id`),
ADD CONSTRAINT `orders_fk_product` FOREIGN KEY (`product_id`) REFERENCES `product`(`product_id`);

SELECT*FROM department;
SELECT*FROM employee;
SELECT*FROM customer;
SELECT*FROM product;
SELECT*FROM invoice;
SELECT*FROM orders;