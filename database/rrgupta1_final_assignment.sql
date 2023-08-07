-- MariaDB dump 10.19-11.2.0-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: rrgupta1
-- ------------------------------------------------------
-- Server version	11.2.0-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer` (
  `customer_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_name` varchar(50) NOT NULL,
  `customer_email` varchar(100) DEFAULT NULL,
  `street_address` varchar(50) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `province` char(2) DEFAULT NULL,
  `postal_code` char(6) DEFAULT NULL,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES
(1,'Aaron Champagne','achampag@ualberta.ca','2317 138 A Avenue','Edmonton','AB','T5Y1B9'),
(2,'James Grieve','jgrieve@ualberta.ca','1234 123 Street','Edmonton','AB','T2B1G4'),
(3,'Bo Cen','bcen@ualberta.ca','5672 98 Avenue','Edmonton','AB','T3C4B7'),
(4,'Stephanie Smothers','ssmoth@ualberta.ca',NULL,NULL,NULL,NULL),
(5,'Emily Nelson',NULL,'1 Winston Churchill Square','Edmonton','AB','T4A1B7'),
(6,'Sean Townsend','stown@ualberta.ca',NULL,NULL,NULL,NULL),
(7,'Diana Hyland',NULL,NULL,NULL,NULL,NULL),
(8,'Dennis Nylon','dnylon@ualberta.ca','1298 76 Street','Edmonton','AB','T5R6F8'),
(9,'Chloe Beale',NULL,'7393 78 Ave','Edmonton','AB','T8FW7C');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_detail`
--

DROP TABLE IF EXISTS `order_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_detail` (
  `order_detail_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_header_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `order_qty` int(11) NOT NULL,
  `sub_total` decimal(15,2) NOT NULL,
  PRIMARY KEY (`order_detail_id`),
  KEY `order_header_id` (`order_header_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `order_detail_ibfk_1` FOREIGN KEY (`order_header_id`) REFERENCES `order_header` (`order_header_id`),
  CONSTRAINT `order_detail_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_detail`
--

LOCK TABLES `order_detail` WRITE;
/*!40000 ALTER TABLE `order_detail` DISABLE KEYS */;
INSERT INTO `order_detail` VALUES
(1,1,5,1,775.99),
(2,2,1,2,751.98),
(3,2,7,1,425.99),
(4,3,6,1,550.00),
(5,3,2,2,553.00),
(6,4,3,1,23.60),
(7,5,4,1,450.25),
(8,5,7,1,425.99),
(9,6,6,2,1100.00),
(10,6,7,2,851.98),
(11,7,1,1,375.99);
/*!40000 ALTER TABLE `order_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_header`
--

DROP TABLE IF EXISTS `order_header`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_header` (
  `order_header_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `order_date` date NOT NULL,
  `total_price` decimal(15,2) NOT NULL,
  PRIMARY KEY (`order_header_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `order_header_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_header`
--

LOCK TABLES `order_header` WRITE;
/*!40000 ALTER TABLE `order_header` DISABLE KEYS */;
INSERT INTO `order_header` VALUES
(1,1,'2022-01-01',775.99),
(2,2,'2022-01-02',1177.97),
(3,3,'2022-01-04',1103.00),
(4,1,'2022-01-12',23.60),
(5,4,'2022-01-14',876.24),
(6,5,'2022-01-20',1951.98),
(7,6,'2022-01-22',375.99);
/*!40000 ALTER TABLE `order_header` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product` (
  `product_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_name` varchar(50) NOT NULL,
  `product_description` varchar(200) NOT NULL,
  `price` decimal(15,2) NOT NULL,
  `quantity_in_stock` int(11) NOT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES
(1,'Guitar','An acoustic guitar made by Epiphone.',375.99,5),
(2,'Microphone','A Shure microphone ideal for stage.',276.50,3),
(3,'Tambourine','Mother of pearl handle.',23.60,15),
(4,'Bass Guitar','A four-string, fretless bass guitar by Ibanez.',450.25,2),
(5,'Electric Guitar','An electric guitar made by Epiphone',775.99,1),
(6,'MIDI Keyboard','A two-octave keyboard with USB cable for making digital music.',550.00,4),
(7,'50-Watt Amplifier','A medium sized amp by Marshall.',425.99,6);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-08-06 17:45:48




--Above are the queries from the assignment STEP 1 to STEP 3

--STEP 4 QUERIES:

START TRANSACTION;

--Query 1: Select our most frequent customers - the customers who have made the most transactions.

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

--Query 2: Select the customer who has spent the most money.

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

--Query 3: Select the product_name, and the total quantity sold

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

--Query 4: Select the order_header_id, product_name, order_qty, customer_name, order_date, and total_price for all the orders between 2022-01-01 and 2022-01-07.

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

--Query 5: Find out how many guitars we have sold (include both electrics, and acoustics)

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

COMMIT;

--STEP 5 QUERIES:

START TRANSACTION;

-- query 1: Insert a new record with the appropriate information into the order_header table

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

-- query 2: Insert two new records with the appropriate information into the order_detail table

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

-- query 3: Update the product table to show the new quantity_in_stock values for the bass guitars and amplifiers.

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