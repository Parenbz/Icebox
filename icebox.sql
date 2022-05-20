-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: icebox
-- ------------------------------------------------------
-- Server version	8.0.28

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Temporary view structure for view `allfoodtable`
--

DROP TABLE IF EXISTS `allfoodtable`;
/*!50001 DROP VIEW IF EXISTS `allfoodtable`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `allfoodtable` AS SELECT 
 1 AS `food_name`,
 1 AS `name`,
 1 AS `date`,
 1 AS `id_product`,
 1 AS `id`,
 1 AS `id_apart`,
 1 AS `exp_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `apartaments`
--

DROP TABLE IF EXISTS `apartaments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `apartaments` (
  `id` int NOT NULL,
  `pass` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `apartaments`
--

LOCK TABLES `apartaments` WRITE;
/*!40000 ALTER TABLE `apartaments` DISABLE KEYS */;
INSERT INTO `apartaments` VALUES (201,123),(202,456),(203,789),(204,987),(205,654),(206,321),(207,135),(208,790),(209,86),(210,421),(301,164),(302,643),(303,246),(304,164),(305,943),(306,948),(307,764),(308,42),(309,987),(310,38),(401,1),(402,893),(403,134),(404,136),(405,864),(406,93),(407,659),(408,982),(409,873),(410,301);
/*!40000 ALTER TABLE `apartaments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `available_dishes`
--

DROP TABLE IF EXISTS `available_dishes`;
/*!50001 DROP VIEW IF EXISTS `available_dishes`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `available_dishes` AS SELECT 
 1 AS `name`,
 1 AS `id_dish`,
 1 AS `id_apart`,
 1 AS `food_req`,
 1 AS `cnt`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `dishes`
--

DROP TABLE IF EXISTS `dishes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dishes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(40) DEFAULT NULL,
  `type` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dishes`
--

LOCK TABLES `dishes` WRITE;
/*!40000 ALTER TABLE `dishes` DISABLE KEYS */;
INSERT INTO `dishes` VALUES (1,'плов',NULL),(2,'борщ','суп'),(3,'куринный суп','суп'),(4,'блины','дессерт');
/*!40000 ALTER TABLE `dishes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `food`
--

DROP TABLE IF EXISTS `food`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `food` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_product` int NOT NULL,
  `id_apart` int NOT NULL,
  `date_manuf` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_product` (`id_product`),
  CONSTRAINT `food_ibfk_1` FOREIGN KEY (`id_product`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `food`
--

LOCK TABLES `food` WRITE;
/*!40000 ALTER TABLE `food` DISABLE KEYS */;
INSERT INTO `food` VALUES (1,1,203,'2022-05-02'),(2,2,303,'2022-05-02'),(3,1,403,'2022-05-02'),(4,3,404,'2022-05-02'),(5,4,302,'2022-05-02'),(6,5,310,'2022-05-02'),(7,6,404,'2022-05-03'),(8,7,209,'2022-05-03'),(9,8,210,'2022-05-03'),(10,12,310,'2022-05-03'),(11,11,410,'2022-05-03'),(12,13,302,'2022-05-03'),(13,12,108,'2022-05-03'),(14,15,208,'2022-05-03'),(15,5,207,'2022-05-03'),(16,12,207,'2022-01-03'),(17,12,404,'2022-05-19'),(18,8,302,'2022-05-20'),(19,13,404,'2000-01-01'),(20,8,404,'2000-01-01'),(21,10,204,'2000-01-01'),(22,9,307,'2000-01-01'),(23,18,307,'2000-01-01'),(24,1,201,'2022-05-20');
/*!40000 ALTER TABLE `food` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `food_apart`
--

DROP TABLE IF EXISTS `food_apart`;
/*!50001 DROP VIEW IF EXISTS `food_apart`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `food_apart` AS SELECT 
 1 AS `id_apart`,
 1 AS `type`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `food_for_dish`
--

DROP TABLE IF EXISTS `food_for_dish`;
/*!50001 DROP VIEW IF EXISTS `food_for_dish`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `food_for_dish` AS SELECT 
 1 AS `id_dish`,
 1 AS `food_req`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `food_types`
--

DROP TABLE IF EXISTS `food_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `food_types` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `food_types`
--

LOCK TABLES `food_types` WRITE;
/*!40000 ALTER TABLE `food_types` DISABLE KEYS */;
INSERT INTO `food_types` VALUES (1,'колбаса'),(2,'сыр'),(3,'молоко'),(4,'яйца'),(5,'курица'),(6,'кефир'),(7,'говядина'),(8,'конина'),(9,'огурцы'),(10,'помидоры'),(11,'лимоны'),(12,'бананы'),(13,'йогурт'),(14,'укроп'),(15,'свекла'),(16,'морковь'),(17,'капуста белокочанная');
/*!40000 ALTER TABLE `food_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `lend_dishes`
--

DROP TABLE IF EXISTS `lend_dishes`;
/*!50001 DROP VIEW IF EXISTS `lend_dishes`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `lend_dishes` AS SELECT 
 1 AS `name`,
 1 AS `id_dish`,
 1 AS `cnt`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `people`
--

DROP TABLE IF EXISTS `people`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `people` (
  `id` int NOT NULL AUTO_INCREMENT,
  `apartament` int NOT NULL,
  `name` varchar(40) NOT NULL,
  `contact` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `apartament` (`apartament`),
  CONSTRAINT `people_ibfk_1` FOREIGN KEY (`apartament`) REFERENCES `apartaments` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `people`
--

LOCK TABLES `people` WRITE;
/*!40000 ALTER TABLE `people` DISABLE KEYS */;
INSERT INTO `people` VALUES (1,201,'Белоковаленко Степан',NULL),(2,202,'Ахметжанов Игорь',NULL),(3,203,'Степан Сергеев',NULL),(4,204,'Никита Останин',NULL),(5,205,'Гусев Николай',NULL),(6,206,'Былинкин Дмитрий',NULL),(7,207,'Тюменев Радик',NULL),(8,208,'Ольга Нуриева',NULL),(9,209,'Красно-Солнышко Айбек',NULL),(10,210,'Тюрин Марин',NULL),(11,301,'Ткова Нина',NULL),(12,302,'Зарезина Елизавета',NULL),(13,303,'Степанов Володимир',NULL),(14,304,'Константинов Констанин',NULL),(15,305,'Редкозубов Андрей',NULL),(16,306,'Слуцкий Николай',NULL),(17,307,'Джугашвили Леонид',NULL),(18,308,'Болт Уссейн',NULL),(19,309,'Шарапова Дарья',NULL),(20,310,'Гаврилова Виктория',NULL),(21,401,'Кравец Валентин',NULL),(22,402,'Истомин Валентин',NULL),(23,403,'Лубин Николай',NULL),(24,404,'Оверчук Анна',NULL),(25,405,'Васюрина Варвара',NULL),(26,406,'Гущин Дмитрий',NULL),(27,407,'Александр Лукашев',NULL),(28,408,'Нурали Сыктыкбаев',NULL),(29,409,'Епифанцев Сергей',NULL),(30,410,'Садовина Мария',NULL);
/*!40000 ALTER TABLE `people` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `type` int NOT NULL,
  `expir_date` int DEFAULT NULL,
  `extr_propert` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `type` (`type`),
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`type`) REFERENCES `food_types` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Докторская (Папа может)',1,20,NULL),(2,'Сервелат (Останкинская)',1,21,NULL),(3,'Сырокопченая (Великорусский комбинат)',1,32,NULL),(4,'Гойя',2,90,NULL),(5,'Голландский(Скоробогатов',2,90,NULL),(6,'Бананы',12,7,NULL),(7,'укроп',14,14,NULL),(8,'свекла',15,18,NULL),(9,'морковь',16,21,NULL),(10,'говядина',7,3,NULL),(11,'ВкуссВилл',3,6,NULL),(12,'Домик в деревне',3,12,NULL),(13,'Мираторг',5,7,NULL),(14,'Белая птица',5,6,NULL),(15,'огурцы',9,6,NULL),(16,'помидоры',10,7,NULL),(17,'лимоны',11,15,NULL),(18,'капуста белокочанная',17,15,NULL);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recipes`
--

DROP TABLE IF EXISTS `recipes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recipes` (
  `id_dish` int NOT NULL,
  `id_food` int NOT NULL,
  `quantity` varchar(30) DEFAULT NULL,
  `commnt` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id_dish`,`id_food`),
  KEY `id_food` (`id_food`),
  CONSTRAINT `recipes_ibfk_1` FOREIGN KEY (`id_dish`) REFERENCES `dishes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `recipes_ibfk_2` FOREIGN KEY (`id_food`) REFERENCES `food_types` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recipes`
--

LOCK TABLES `recipes` WRITE;
/*!40000 ALTER TABLE `recipes` DISABLE KEYS */;
INSERT INTO `recipes` VALUES (1,7,'1кг','ещё нужен рис'),(1,14,'30г',NULL),(1,16,'200г',NULL),(2,7,'0,5 кг',NULL),(2,15,'300г',NULL),(2,17,'300г',NULL),(3,5,'900г',NULL),(3,15,'300г',NULL);
/*!40000 ALTER TABLE `recipes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `unavailable_dishes`
--

DROP TABLE IF EXISTS `unavailable_dishes`;
/*!50001 DROP VIEW IF EXISTS `unavailable_dishes`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `unavailable_dishes` AS SELECT 
 1 AS `name`,
 1 AS `id_dish`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `allfoodtable`
--

/*!50001 DROP VIEW IF EXISTS `allfoodtable`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `allfoodtable` AS select `food_types`.`type` AS `food_name`,`products`.`name` AS `name`,`food`.`date_manuf` AS `date`,`food`.`id_product` AS `id_product`,`food`.`id` AS `id`,`food`.`id_apart` AS `id_apart`,(`food`.`date_manuf` + interval `products`.`expir_date` day) AS `exp_date` from ((`food` join `products` on((`food`.`id_product` = `products`.`id`))) join `food_types` on((`food_types`.`id` = `products`.`type`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `available_dishes`
--

/*!50001 DROP VIEW IF EXISTS `available_dishes`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `available_dishes` AS select `dishes`.`name` AS `name`,`dishes`.`id` AS `id_dish`,`food_apart`.`id_apart` AS `id_apart`,`food_for_dish`.`food_req` AS `food_req`,count(0) AS `cnt` from (((`recipes` join `dishes` on((`dishes`.`id` = `recipes`.`id_dish`))) join `food_apart` on((`food_apart`.`type` = `recipes`.`id_food`))) join `food_for_dish` on((`food_for_dish`.`id_dish` = `dishes`.`id`))) group by `dishes`.`id`,`food_apart`.`id_apart`,`food_for_dish`.`food_req` having (`cnt` = `food_for_dish`.`food_req`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `food_apart`
--

/*!50001 DROP VIEW IF EXISTS `food_apart`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `food_apart` AS select distinct `apartaments`.`id` AS `id_apart`,`products`.`type` AS `type` from ((`products` join `food` on((`food`.`id_product` = `products`.`id`))) join `apartaments` on((`apartaments`.`id` = `food`.`id_apart`))) order by `apartaments`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `food_for_dish`
--

/*!50001 DROP VIEW IF EXISTS `food_for_dish`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `food_for_dish` AS select `recipes`.`id_dish` AS `id_dish`,count(0) AS `food_req` from `recipes` group by `recipes`.`id_dish` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `lend_dishes`
--

/*!50001 DROP VIEW IF EXISTS `lend_dishes`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `lend_dishes` AS select `dishes`.`name` AS `name`,`recipes`.`id_dish` AS `id_dish`,count(0) AS `cnt` from ((`recipes` join `dishes` on((`dishes`.`id` = `recipes`.`id_dish`))) join `food_for_dish` on((`food_for_dish`.`id_dish` = `dishes`.`id`))) where `recipes`.`id_food` in (select `food_apart`.`type` from `food_apart`) group by `recipes`.`id_dish`,`food_for_dish`.`food_req` having (`cnt` = `food_for_dish`.`food_req`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `unavailable_dishes`
--

/*!50001 DROP VIEW IF EXISTS `unavailable_dishes`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `unavailable_dishes` AS select `dishes`.`name` AS `name`,`dishes`.`id` AS `id_dish` from `dishes` where `dishes`.`id` in (select `lend_dishes`.`id_dish` from `lend_dishes`) is false */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-05-20  8:37:36
