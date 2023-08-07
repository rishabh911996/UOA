-- MariaDB dump 10.19-11.2.0-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: exsm_3937_a1
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
-- Table structure for table `renters`
--

DROP TABLE IF EXISTS `renters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `renters` (
  `renter_id` int(11) NOT NULL AUTO_INCREMENT,
  `renter_name` char(100) NOT NULL,
  `renter_phone_number` bigint(9) DEFAULT NULL,
  `renter_address` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`renter_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `renters`
--

LOCK TABLES `renters` WRITE;
/*!40000 ALTER TABLE `renters` DISABLE KEYS */;
INSERT INTO `renters` VALUES
(1,'Jillian Bob',9873214560,'001 Broadway Avenue'),
(2,'Barry Smith',123478595,'4142 Main Street'),
(3,'Jaina Thomas',1579345687,'0235 Boardwalk'),
(4,'Robert Gerald,',9874530145,'1 North Street'),
(5,'David Wong',9532147035,'501 Skywalk');
/*!40000 ALTER TABLE `renters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicles`
--

DROP TABLE IF EXISTS `vehicles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehicles` (
  `vehicle_model` varchar(30) DEFAULT NULL,
  `vehicle_make` varchar(50) DEFAULT NULL,
  `vehicle_vin` varchar(17) NOT NULL,
  `vehicle_color` varchar(30) DEFAULT NULL,
  `renter_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`vehicle_vin`),
  KEY `renter_id` (`renter_id`),
  CONSTRAINT `vehicles_ibfk_1` FOREIGN KEY (`renter_id`) REFERENCES `renters` (`renter_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicles`
--

LOCK TABLES `vehicles` WRITE;
/*!40000 ALTER TABLE `vehicles` DISABLE KEYS */;
INSERT INTO `vehicles` VALUES
('F150','Ford','1G6KF57923U237842','Blue',2),
('Toyota','Prius','2C8GM68444R370097','Red',1),
('Cherokee','Jeep','SALME15496A258923','orange',5);
/*!40000 ALTER TABLE `vehicles` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-07-23 19:06:51


-- ADDITIONAL QUERIES USED

--I TRIED BOTH THE QUERIES, THE SECOND QUERY IS USING A SUBQUERY TO FETCH RENTER ID FROM RENTER TABLE WHERE RENTER NAME IS JANIA.

Update vehicles SET renter_id=2 WHERE vehicle_model='F150';

--OR

Update vehicles SET renter_id=2 WHERE vehicle_model='F150' AND renter_id = (SELECT renter_id from renters WHERE renter_name = "JANIA%");


UPDATE vehicles SET vehicle_color='orange' WHERE vehicle_color = 'blorange';