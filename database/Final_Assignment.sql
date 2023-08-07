CREATE DATABASE rrgupta_practice;

USE rrgupta_practice;

START TRANSACTION;

CREATE TABLE customer (customer_id INT AUTO_INCREMENT PRIMARY KEY, customer_name VARCHAR(50) NOT NULL, customer_email VARCHAR(100), street_address VARCHAR(50), city VARCHAR(50), province CHAR(2), postal_code CHAR(6));

CREATE TABLE product (product_id INT AUTO_INCREMENT PRIMARY KEY, product_name VARCHAR(50) NOT NULL, product_description VARCHAR(200) NOT NULL, price DECIMAL(15,2) NOT NULL, quantity_in_stock INT NOT NULL);

CREATE TABLE order_header (order_header_id INT AUTO_INCREMENT PRIMARY KEY, customer_id INT NOT NULL, order_date DATE NOT NULL, total_price DECIMAL(15,2) NOT NULL, CONSTRAINT FOREIGN KEY (customer_id) REFERENCES customer(customer_id));

CREATE TABLE order_detail (order_detail_id INT AUTO_INCREMENT PRIMARY KEY, order_header_id INT NOT NULL, product_id INT NOT NULL, order_qty INT NOT NULL, sub_total DECIMAL(15,2) NOT NULL, CONSTRAINT FOREIGN KEY (order_header_id) REFERENCES order_header(order_header_id), CONSTRAINT FOREIGN KEY (product_id) REFERENCES product(product_id));

COMMIT;

START TRANSACTION;

INSERT INTO Customer (customer_name, customer_email, street_address, city, province, postal_code)
    VALUES 
        ('Aaron Champagne', 'achampag@ualberta.ca', '2317 138 A Avenue', 'Edmonton', 'AB', 'T5Y1B9'),
        ('James Grieve', 'jgrieve@ualberta.ca', '1234 123 Street', 'Edmonton', 'AB', 'T2B1G4'),
        ('Bo Cen', 'bcen@ualberta.ca', '5672 98 Avenue', 'Edmonton', 'AB', 'T3C4B7'),
        ('Stephanie Smothers', 'ssmoth@ualberta.ca', NULL, NULL, NULL, NULL),
        ('Emily Nelson', NULL, '1 Winston Churchill Square', 'Edmonton', 'AB', 'T4A1B7'),
        ('Sean Townsend', 'stown@ualberta.ca', NULL, NULL, NULL, NULL),
        ('Diana Hyland', NULL, NULL, NULL, NULL, NULL),
        ('Dennis Nylon', 'dnylon@ualberta.ca', '1298 76 Street', 'Edmonton', 'AB', 'T5R6F8'),
        ('Chloe Beale', NULL, '7393 78 Ave', 'Edmonton', 'AB', 'T8FW7C');


INSERT INTO Product (product_name, product_description, price, quantity_in_stock)
    VALUES
        ('Guitar', 'An acoustic guitar made by Epiphone.', 375.99, 5),
        ('Microphone', 'A Shure microphone ideal for stage.', 276.5, 3),
        ('Tambourine', 'Mother of pearl handle.', 23.60, 15),
        ('Bass Guitar', 'A four-string, fretless bass guitar by Ibanez.', 450.25, 2),
        ('Electric Guitar', 'An electric guitar made by Epiphone', 775.99, 1),
        ('MIDI Keyboard', 'A two-octave keyboard with USB cable for making digital music.', 550, 4),
        ('50-Watt Amplifier', 'A medium sized amp by Marshall.', 425.99, 6);

INSERT INTO Order_Header (customer_id, order_date, total_price)
    VALUES
        (1, '2022-01-01', 775.99),
        (2, '2022-01-02', 1177.97),
        (3, '2022-01-04', 1103),
        (1, '2022-01-12', 23.6),
        (4, '2022-01-14', 876.24),
        (5, '2022-01-20', 1951.98),
        (6, '2022-01-22', 375.99);
        
INSERT INTO Order_Detail (order_header_id, product_id, order_qty, sub_total)
    VALUES
        (1, 5, 1, 775.99),
        (2, 1, 2, 751.98),
        (2, 7, 1, 425.99),
        (3, 6, 1, 550),
        (3, 2, 2, 553),
        (4, 3, 1, 23.6),
        (5, 4, 1, 450.25),
        (5, 7, 1, 425.99),
        (6, 6, 2, 1100),
        (6, 7, 2, 851.98),
        (7, 1, 1, 375.99);

COMMIT;

START TRANSACTION;

--Select our most frequent customers - the customers who have made the most transactions.
SELECT customer_name, COUNT(order_header_id) AS 'Number of Purchases'
FROM customer
INNER JOIN order_header ON customer.customer_id = order_header.customer_id
GROUP BY customer_name;

--Select the customer who has spent the most money.

SELECT customer_name, SUM(total_price) AS 'Sum of Purchase Totals'
FROM customer
INNER JOIN order_header ON customer.customer_id = order_header.customer_id
GROUP BY customer_name
ORDER BY SUM(total_price) DESC;


--Select the product_name, and the total quantity sold
SELECT SUM(order_qty) AS 'Number of Products Sold',product_name FROM product
INNER JOIN order_detail ON product.product_id = order_detail.product_id
GROUP BY product_name
ORDER BY SUM(order_qty) DESC;

--Select the order_header_id, product_name, order_qty, customer_name, order_date, and total_price for all the orders between 2022-01-01 and 2022-01-07.
SELECT order_header.order_header_id, product_name, order_qty, customer_name, order_date, total_price FROM order_header
INNER JOIN order_detail ON order_detail.order_header_id = order_header.order_header_id
INNER JOIN product ON order_detail.product_id = product.product_id
INNER JOIN customer ON order_header.customer_id = customer.customer_id
WHERE order_date BETWEEN '2022-01-01' AND '2022-01-07';
 
 -- Find out how many guitars we have sold (include both electrics, and acoustics)

SELECT SUM(order_qty) AS 'Number of Guitars Sold' 
FROM product
INNER JOIN order_detail ON product.product_id = order_detail.product_id
WHERE product_name LIKE '%Guitar%';


COMMIT;

START TRANSACTION;

--In the fourth transaction you will have to write several SQL statements. Chloe Beale will be purchasing a bass guitar, and an amplifier on February 22, 2022.
--Insert a new record with the appropriate information into the order_header table

INSERT INTO order_header (customer_id, order_date, total_price)
    VALUES
        ((Select customer_id from customer where customer_name = "Chloe Beale"), '2022-02-22', (SELECT SUM(price) FROM product WHERE product_name LIKE '%Bass Guitar%' OR product_name LIKE '%Amplifier%'));
        
--Insert two new records with the appropriate information into the order_detail table

INSERT INTO order_detail (order_header_id, product_id, order_qty, sub_total)
    VALUES
        ((SELECT order_header_id FROM order_header WHERE customer_id = (SELECT customer_id FROM customer WHERE customer_name = "Chloe Beale") AND order_date = '2022-02-22'), (select product_id from product where product_name = "Bass Guitar"), 1, (select price from product where product_name = "Bass Guitar")),
        ((SELECT order_header_id FROM order_header WHERE customer_id = (SELECT customer_id FROM customer WHERE customer_name = "Chloe Beale") AND order_date = '2022-02-22'), (select product_id from product where product_name LIKE "%Amplifier"), 1, (select price from product where product_name LIKE "%Amplifier"));


--Update the product table to show the new quantity_in_stock values for the bass guitars and amplifiers.

UPDATE product
SET quantity_in_stock = quantity_in_stock-1
WHERE product_id = (select product_id from product where product_name = "Bass Guitar") OR product_id = (select product_id from product where product_name LIKE "%Amplifier");

--Select the order_header_id, order_date, customer_name, product_name, quantity_in_stock,sub_total, total_price from the order_header, order_detail, customer, and product tables to verify that the purchase has been saved to the database.

SELECT order_header.order_header_id, order_date, customer_name, product_name, quantity_in_stock, sub_total, total_price
FROM order_header
INNER JOIN order_detail ON order_header.order_header_id = order_detail.order_header_id
INNER JOIN product ON order_detail.product_id = product.product_id
INNER JOIN customer ON order_header.customer_id = customer.customer_id
WHERE order_header.order_header_id = 8;

COMMIT;

----- WORKING SQL STATEMENTS -------
create database rrgupta1;

START TRANSACTION;

CREATE TABLE customer (
  customer_id INT AUTO_INCREMENT PRIMARY KEY, 
  customer_name VARCHAR(50) NOT NULL, 
  customer_email VARCHAR(100), 
  street_address VARCHAR(50), 
  city VARCHAR(50), 
  province CHAR(2), 
  postal_code CHAR(6)
);

CREATE TABLE product (
  product_id INT AUTO_INCREMENT PRIMARY KEY, 
  product_name VARCHAR(50) NOT NULL, 
  product_description VARCHAR(200) NOT NULL, 
  price DECIMAL(15, 2) NOT NULL, 
  quantity_in_stock INT NOT NULL
);

CREATE TABLE order_header (
  order_header_id INT AUTO_INCREMENT PRIMARY KEY, 
  customer_id INT NOT NULL, 
  order_date DATE NOT NULL, 
  total_price DECIMAL(15, 2) NOT NULL, 
  CONSTRAINT FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

CREATE TABLE order_detail (
  order_detail_id INT AUTO_INCREMENT PRIMARY KEY, 
  order_header_id INT NOT NULL, 
  product_id INT NOT NULL, 
  order_qty INT NOT NULL, 
  sub_total DECIMAL(15, 2) NOT NULL, 
  CONSTRAINT FOREIGN KEY (order_header_id) REFERENCES order_header(order_header_id), 
  CONSTRAINT FOREIGN KEY (product_id) REFERENCES product(product_id)
);

COMMIT;

START TRANSACTION;

INSERT INTO Customer (
  customer_name, customer_email, street_address, 
  city, province, postal_code
) 
VALUES 
  (
    'Aaron Champagne', 'achampag@ualberta.ca', 
    '2317 138 A Avenue', 'Edmonton', 
    'AB', 'T5Y1B9'
  ), 
  (
    'James Grieve', 'jgrieve@ualberta.ca', 
    '1234 123 Street', 'Edmonton', 'AB', 
    'T2B1G4'
  ), 
  (
    'Bo Cen', 'bcen@ualberta.ca', '5672 98 Avenue', 
    'Edmonton', 'AB', 'T3C4B7'
  ), 
  (
    'Stephanie Smothers', 'ssmoth@ualberta.ca', 
    NULL, NULL, NULL, NULL
  ), 
  (
    'Emily Nelson', NULL, '1 Winston Churchill Square', 
    'Edmonton', 'AB', 'T4A1B7'
  ), 
  (
    'Sean Townsend', 'stown@ualberta.ca', 
    NULL, NULL, NULL, NULL
  ), 
  (
    'Diana Hyland', NULL, NULL, NULL, NULL, 
    NULL
  ), 
  (
    'Dennis Nylon', 'dnylon@ualberta.ca', 
    '1298 76 Street', 'Edmonton', 'AB', 
    'T5R6F8'
  ), 
  (
    'Chloe Beale', NULL, '7393 78 Ave', 
    'Edmonton', 'AB', 'T8FW7C'
  );

INSERT INTO Product (
  product_name, product_description, 
  price, quantity_in_stock
) 
VALUES 
  (
    'Guitar', 'An acoustic guitar made by Epiphone.', 
    375.99, 5
  ), 
  (
    'Microphone', 'A Shure microphone ideal for stage.', 
    276.5, 3
  ), 
  (
    'Tambourine', 'Mother of pearl handle.', 
    23.60, 15
  ), 
  (
    'Bass Guitar', 'A four-string, fretless bass guitar by Ibanez.', 
    450.25, 2
  ), 
  (
    'Electric Guitar', 'An electric guitar made by Epiphone', 
    775.99, 1
  ), 
  (
    'MIDI Keyboard', 'A two-octave keyboard with USB cable for making digital music.', 
    550, 4
  ), 
  (
    '50-Watt Amplifier', 'A medium sized amp by Marshall.', 
    425.99, 6
  );

INSERT INTO Order_Header (
  customer_id, order_date, total_price
) 
VALUES 
  (1, '2022-01-01', 775.99), 
  (2, '2022-01-02', 1177.97), 
  (3, '2022-01-04', 1103), 
  (1, '2022-01-12', 23.6), 
  (4, '2022-01-14', 876.24), 
  (5, '2022-01-20', 1951.98), 
  (6, '2022-01-22', 375.99);

INSERT INTO Order_Detail (
  order_header_id, product_id, order_qty, 
  sub_total
) 
VALUES 
  (1, 5, 1, 775.99), 
  (2, 1, 2, 751.98), 
  (2, 7, 1, 425.99), 
  (3, 6, 1, 550), 
  (3, 2, 2, 553), 
  (4, 3, 1, 23.6), 
  (5, 4, 1, 450.25), 
  (5, 7, 1, 425.99), 
  (6, 6, 2, 1100), 
  (6, 7, 2, 851.98), 
  (7, 1, 1, 375.99);

  COMMIT;

START TRANSACTION;

SELECT 
  RPAD(customer_name, 20) AS 'Customer', 
  RPAD(
    COUNT(order_header_id), 
    20
  ) AS 'Number of Purchases' 
FROM 
  customer 
  INNER JOIN order_header ON customer.customer_id = order_header.customer_id 
GROUP BY 
  customer_name;


SELECT 
  RPAD(customer_name, 20) AS 'Customer', 
  SUM(total_price) AS 'Sum of Purchase Totals' 
FROM 
  customer 
  INNER JOIN order_header ON customer.customer_id = order_header.customer_id 
GROUP BY 
  customer_name 
ORDER BY 
  SUM(total_price) DESC;



SELECT 
  RPAD(
    SUM(order_qty), 
    1
  ) AS 'Number of Products Sold', 
  product_name 
FROM 
  product 
  INNER JOIN order_detail ON product.product_id = order_detail.product_id 
GROUP BY 
  product_name 
ORDER BY 
  SUM(order_qty) DESC;


SELECT 
  RPAD(order_header.order_header_id, 2) AS 'order_header_id', 
  RPAD(product_name, 20) AS 'product_name', 
  RPAD(order_qty, 2) AS 'order_qty', 
  RPAD(customer_name, 20) AS 'customer_name', 
  RPAD(order_date, 12) AS 'order_date', 
  RPAD(total_price, 10) AS 'total_price' 
FROM 
  order_header 
  INNER JOIN order_detail ON order_detail.order_header_id = order_header.order_header_id 
  INNER JOIN product ON order_detail.product_id = product.product_id 
  INNER JOIN customer ON order_header.customer_id = customer.customer_id 
WHERE 
  order_date BETWEEN '2022-01-01' 
  AND '2022-01-07' 
ORDER BY 
  order_date;



SELECT 
  RPAD(
    SUM(order_qty), 
    2
  ) AS 'Number of Guitars Sold' 
FROM 
  product 
  INNER JOIN order_detail ON product.product_id = order_detail.product_id 
WHERE 
  product_name LIKE '%Guitar%';


START TRANSACTION;

INSERT INTO order_header (
  customer_id, order_date, total_price
) 
VALUES 
  (
    (
      Select 
        customer_id 
      from 
        customer 
      where 
        customer_name = "Chloe Beale"
    ), 
    '2022-02-22', 
    (
      SELECT 
        SUM(price) 
      FROM 
        product 
      WHERE 
        product_name LIKE '%Bass Guitar%' 
        OR product_name LIKE '%Amplifier%'
    )
  );

SAVEPOINT query1;

INSERT INTO order_detail (
  order_header_id, product_id, order_qty, 
  sub_total
) 
VALUES 
  (
    (
      SELECT 
        order_header_id 
      FROM 
        order_header 
      WHERE 
        customer_id = (
          SELECT 
            customer_id 
          FROM 
            customer 
          WHERE 
            customer_name = "Chloe Beale"
        ) 
        AND order_date = '2022-02-22'
    ), 
    (
      select 
        product_id 
      from 
        product 
      where 
        product_name = "Bass Guitar"
    ), 
    1, 
    (
      select 
        price 
      from 
        product 
      where 
        product_name = "Bass Guitar"
    )
  ), 
  (
    (
      SELECT 
        order_header_id 
      FROM 
        order_header 
      WHERE 
        customer_id = (
          SELECT 
            customer_id 
          FROM 
            customer 
          WHERE 
            customer_name = "Chloe Beale"
        ) 
        AND order_date = '2022-02-22'
    ), 
    (
      select 
        product_id 
      from 
        product 
      where 
        product_name LIKE "%Amplifier"
    ), 
    1, 
    (
      select 
        price 
      from 
        product 
      where 
        product_name LIKE "%Amplifier"
    )
  );

SAVEPOINT query2;


UPDATE 
  product 
SET 
  quantity_in_stock = quantity_in_stock - 1 
WHERE 
  product_id = (
    select 
      product_id 
    from 
      product 
    where 
      product_name = "Bass Guitar"
  ) 
  OR product_id = (
    select 
      product_id 
    from 
      product 
    where 
      product_name LIKE "%Amplifier"
  );

SAVEPOINT query3;

SELECT 
  order_header.order_header_id, 
  order_date, 
  customer_name, 
  product_name, 
  quantity_in_stock, 
  sub_total, 
  total_price 
FROM 
  order_header 
  INNER JOIN order_detail ON order_header.order_header_id = order_detail.order_header_id 
  INNER JOIN product ON order_detail.product_id = product.product_id 
  INNER JOIN customer ON order_header.customer_id = customer.customer_id 
WHERE 
  order_header.order_header_id = 8;

COMMIT;
