-- MariaDB dump 10.19-11.2.0-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: exsm_3937_a3
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
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customers` (
  `customer_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_name` varchar(60) DEFAULT NULL,
  `customer_address` varchar(100) DEFAULT NULL,
  `customer_phone_number` bigint(9) DEFAULT NULL,
  `customer_join_date` date DEFAULT NULL,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES
(1,'Jane Doe','123 Main Street',7801234567,'2021-02-02'),
(2,'Li Wei','985 Boardwalk',4061584198,'2001-12-11'),
(3,'Jane Simons','523 Example Way',1583654589,'2022-12-01'),
(4,'John Doe','123 Main Street',7801234567,'2000-09-23');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) DEFAULT NULL,
  `order_ammount` int(7) DEFAULT NULL,
  `order_total_cost` float(7,2) DEFAULT NULL,
  `order_date` date DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES
(1,1,5,25.00,'2021-02-02'),
(2,1,20,100.00,'2023-07-03'),
(3,2,9,45.00,'2023-07-02'),
(4,4,11,55.00,'2022-09-23');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-07-30 20:13:29

-- SELECT QUERY

-- I have written the qeury with JOIN and where clause, as well as just where clause.

SELECT Query 1

	SELECT customers.customer_name,customers.customer_address FROM customers LEFT JOIN orders ON customers.customer_id = orders.customer_id WHERE orders.order_total_cost > 50.00;
	
	SELECT customers.customer_name,customers.customer_address FROM customers ,orders WHERE customers.customer_id = orders.customer_id AND orders.order_total_cost > 50.00;
	
SELECT Query 2

	 SELECT customers.customer_name,customers.customer_address FROM customers LEFT JOIN orders ON customers.customer_id = orders.customer_id WHERE customers.customer_join_date = orders.order_date;
	 
	 SELECT customers.customer_name,customers.customer_address FROM customers ,orders WHERE customers.customer_id = orders.customer_id AND customers.customer_join_date = orders.order_date;
	 
SELECT Query 3

	SELECT customers.customer_name,customers.customer_address FROM customers LEFT JOIN orders ON customers.customer_id = orders.customer_id WHERE YEAR(orders.order_date) = YEAR(CURRENT_DATE) ORDER BY customers.customer_name ASC;
	
	SELECT customers.customer_name,customers.customer_address FROM customers ,orders WHERE customers.customer_id = orders.customer_id AND YEAR(orders.order_date) = YEAR(CURRENT_DATE) ORDER BY customers.customer_name ASC;