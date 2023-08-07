CREATE DATABASE exsm_3937_a4;

USE exsm_3937_a4;

-- Create table customers:
CREATE TABLE customers (customer_id INT AUTO_INCREMENT PRIMARY KEY, customer_name VARCHAR(20) NOT NULL, customer_phone_number BIGINT(9));

--Create customers orders:
CREATE TABLE orders (order_id INT AUTO_INCREMENT PRIMARY KEY, customer_id INT, order_date DATE NOT NULL, total_amt FLOAT(7,2) NOt NULL, order_status varchar(9), CONSTRAINT FOREIGN KEY (customer_id) REFERENCES customers(customer_id), CONSTRAINT CHECK (order_status in ('pending','completed')));

--Create inventory
CREATE TABLE inventory (product_id INT AUTO_INCREMENT PRIMARY KEY, product_name varchar(30) NOT NULL, quantity_in_stock INT(5) NOT NULL CHECK (quantity_in_Stock >= 0));

--Start Transactions:
 START TRANSACTION;
 INSERT INTO customers values(1,"Jane Doe",7801234567);
 
 SAVEPOINT created_customer;

 INSERT INTO customers values (101,"Devi Jonas",7807878998);

 INSERT INTO orders values (1,101, CURRENT_DATE(),59.99,"pending");

 INSERT INTO INVENTORY VALUES (202,"Mysterious_Object",6);

 Update inventory SET quantity_in_stock = IF((quantity_in_Stock-5) >= 0,(quantity_in_stock-5),(quantity_in_Stock-5)) where product_id = 202;

 ROLLBACK TO created_customer;