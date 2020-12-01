-- MySQL dump 10.13  Distrib 5.7.12, for Win32 (AMD64)
--
-- Host: localhost    Database: onewaydb
-- ------------------------------------------------------
-- Server version	5.6.6-m9-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `descriptions`
--

DROP TABLE IF EXISTS `descriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `descriptions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_person` int(11) NOT NULL,
  `descriptions_string` varchar(200) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Person full descriptions.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `descriptions`
--

LOCK TABLES `descriptions` WRITE;
/*!40000 ALTER TABLE `descriptions` DISABLE KEYS */;
INSERT INTO `descriptions` VALUES (1,1,'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Voluptates explicabo nulla rerum odit debitis placeat, illum est, eligendi beatae ea laborum eum error non.'),(2,1,'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ducimus minus, voluptates ratione amet saepe quas!'),(3,2,'Полное имя - Дженнифер Шрейдер Лоуренс (Jennifer Shrader Lawrence).'),(4,2,'Окончила школу экстерном (на 2 года раньше), чтобы начать активно сниматься в кино.'),(5,2,'Дженнифер - левша.');
/*!40000 ALTER TABLE `descriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `images`
--

DROP TABLE IF EXISTS `images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `images` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `id_person` int(11) NOT NULL,
  `image_url` varchar(45) CHARACTER SET latin1 DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Persons slider images URLs.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `images`
--

LOCK TABLES `images` WRITE;
/*!40000 ALTER TABLE `images` DISABLE KEYS */;
INSERT INTO `images` VALUES (1,1,'img_slider-1.jpg'),(2,1,'img_slider-2.jpg'),(3,1,'img_slider-3.jpg'),(4,2,'img_slider-5.jpg'),(5,2,'img_slider-4.jpg'),(6,2,'img_slider-6.jpg');
/*!40000 ALTER TABLE `images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes`
--

DROP TABLE IF EXISTS `likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `likes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `image_name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `IP` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='likes for images + ip';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
INSERT INTO `likes` VALUES (1,'img_slider-1.jpg','192.168.0.1'),(2,'img_slider-1.jpg','192.168.0.2'),(4,'img_slider-1.jpg','192.168.0.4'),(5,'img_slider-2.jpg','192.168.0.1'),(6,'img_slider-2.jpg','192.168.0.2'),(7,'img_slider-3.jpg','192.168.0.1'),(8,'img_slider-3.jpg','192.168.0.2'),(9,'img_slider-3.jpg','192.168.0.3'),(10,'img_slider-4.jpg','192.168.0.1'),(11,'img_slider-4.jpg','192.168.0.2'),(13,'img_slider-6.jpg','192.168.0.2'),(14,'img_slider-6.jpg','192.168.0.3'),(95,'img_slider-6.jpg','::1'),(96,'img_slider-5.jpg','::1'),(99,'img_slider-3.jpg','::1'),(100,'img_slider-1.jpg','::1'),(101,'img_slider-2.jpg','::1');
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `persons`
--

DROP TABLE IF EXISTS `persons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `persons` (
  `id_person` int(11) NOT NULL,
  `name` varchar(45) CHARACTER SET utf8 DEFAULT NULL,
  `occupation` varchar(45) CHARACTER SET utf8 DEFAULT NULL,
  `birthplace` varchar(45) CHARACTER SET utf8 DEFAULT NULL,
  `birthdate` datetime DEFAULT NULL,
  `description` varchar(200) CHARACTER SET utf8 DEFAULT NULL,
  `backgr_img` varchar(45) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`id_person`),
  UNIQUE KEY `idpersons_UNIQUE` (`id_person`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='person data.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `persons`
--

LOCK TABLES `persons` WRITE;
/*!40000 ALTER TABLE `persons` DISABLE KEYS */;
INSERT INTO `persons` VALUES (1,'Emilia Clarke','актриса','Лондон, Великобритания','1986-10-26 00:00:00','Британская актриса. Наиболее известна по роли Дайнерис Таргарие в телесериале \"Игра престолов\" и Сары Коннор в фильме \"Терминатор: Генезис\".','img_person-1.jpg'),(2,'Jennifer Lawrence','актриса, продюсер','Луисвилл, Кентукки, США','1990-08-15 00:00:00','Лучшие фильмы: Люди Икс: Дни минувшего будущего, Люди Икс: Первый класс, Голодные игры: И вспыхнет пламя, Голодные игры, Мой парень — псих.','img_person-2.jpg');
/*!40000 ALTER TABLE `persons` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-11-22 16:11:11
