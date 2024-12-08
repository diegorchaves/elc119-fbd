-- MariaDB dump 10.19  Distrib 10.11.6-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: trabalho_fbd
-- ------------------------------------------------------
-- Server version	10.11.6-MariaDB-0+deb12u1

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
-- Table structure for table `CVLI`
--

DROP TABLE IF EXISTS `CVLI`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CVLI` (
  `IdCVLI` int(11) NOT NULL AUTO_INCREMENT,
  `IdCrime` int(11) NOT NULL,
  `TotalVitimas` int(11) NOT NULL,
  PRIMARY KEY (`IdCVLI`),
  KEY `idx_idcrime_cvli` (`IdCrime`),
  CONSTRAINT `CVLI_ibfk_1` FOREIGN KEY (`IdCrime`) REFERENCES `Crime` (`IdCrime`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Cidade`
--

DROP TABLE IF EXISTS `Cidade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Cidade` (
  `IdCidade` int(11) NOT NULL AUTO_INCREMENT,
  `Nome` varchar(50) NOT NULL,
  PRIMARY KEY (`IdCidade`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER log_cidade_insert
AFTER INSERT ON Cidade
FOR EACH ROW
BEGIN
    INSERT INTO LogAlteracoesCidade (IdRegistro, TipoOperacao, DescricaoAlteracao)
    VALUES (NEW.IdCidade, 'INSERT', CONCAT('Nova cidade adicionada: ', NEW.Nome));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER log_cidade_update
AFTER UPDATE ON Cidade
FOR EACH ROW
BEGIN
    
    IF OLD.Nome != NEW.Nome THEN
        INSERT INTO LogAlteracoesCidade (IdRegistro, TipoOperacao, DescricaoAlteracao)
        VALUES (NEW.IdCidade, 'UPDATE', 
                CONCAT('Nome alterado: ', OLD.Nome, ' para ', NEW.Nome));
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER log_cidade_delete
AFTER DELETE ON Cidade
FOR EACH ROW
BEGIN
    INSERT INTO LogAlteracoesCidade (IdRegistro, TipoOperacao, DescricaoAlteracao)
    VALUES (OLD.IdCidade, 'DELETE', CONCAT('Cidade excluida: ID ', CAST(OLD.IdCidade AS CHAR)));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Crime`
--

DROP TABLE IF EXISTS `Crime`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Crime` (
  `IdCrime` int(11) NOT NULL AUTO_INCREMENT,
  `IdTipoCrime` int(11) NOT NULL,
  `IdCidade` int(11) NOT NULL,
  `Mes` int(11) NOT NULL,
  `Ano` int(11) NOT NULL,
  PRIMARY KEY (`IdCrime`),
  KEY `fk_crime_cidade` (`IdCidade`),
  KEY `fk_crime_tipo_crime` (`IdTipoCrime`),
  CONSTRAINT `fk_crime_cidade` FOREIGN KEY (`IdCidade`) REFERENCES `Cidade` (`IdCidade`) ON DELETE CASCADE,
  CONSTRAINT `fk_crime_tipo_crime` FOREIGN KEY (`IdTipoCrime`) REFERENCES `TipoCrime` (`IdTipoCrime`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER log_crime_insert
AFTER INSERT ON Crime
FOR EACH ROW
BEGIN
    INSERT INTO LogAlteracoesCrime (IdRegistro, TipoOperacao, DescricaoAlteracao)
    VALUES (NEW.IdCrime, 'INSERT', CONCAT('Novo registro adicionado: ', CAST(NEW.IdCrime AS CHAR)));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER log_crime_update
AFTER UPDATE ON Crime
FOR EACH ROW
BEGIN
    
    IF OLD.Mes != NEW.Mes THEN
        INSERT INTO LogAlteracoesCrime (IdRegistro, TipoOperacao, DescricaoAlteracao)
        VALUES (NEW.IdCrime, 'UPDATE', 
                CONCAT('Mes alterado: ', CAST(OLD.Mes AS CHAR), ' para ', CAST(NEW.Mes AS CHAR)));
    END IF;

    
    IF OLD.Ano != NEW.Ano THEN
        INSERT INTO LogAlteracoesCrime (IdRegistro, TipoOperacao, DescricaoAlteracao)
        VALUES (NEW.IdCrime, 'UPDATE', 
                CONCAT('Ano alterado: ', CAST(OLD.Ano AS CHAR), ' para ', CAST(NEW.Ano AS CHAR)));
    END IF;
    
    
    IF OLD.IdCidade != NEW.IdCidade THEN
        INSERT INTO LogAlteracoesCrime (IdRegistro, TipoOperacao, DescricaoAlteracao)
        VALUES (NEW.IdCrime, 'UPDATE', 
                CONCAT('Cidade alterada: ', CAST(OLD.IdCidade AS CHAR), ' para ', CAST(NEW.IdCidade AS CHAR)));
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER log_crime_delete
AFTER DELETE ON Crime
FOR EACH ROW
BEGIN
    INSERT INTO LogAlteracoesCrime (IdRegistro, TipoOperacao, DescricaoAlteracao)
    VALUES (OLD.IdCrime, 'DELETE', CONCAT('Registro excluído: ID ', CAST(OLD.IdCrime AS CHAR)));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `LogAlteracoesCidade`
--

DROP TABLE IF EXISTS `LogAlteracoesCidade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LogAlteracoesCidade` (
  `IdLog` int(11) NOT NULL AUTO_INCREMENT,
  `IdRegistro` int(11) DEFAULT NULL,
  `TipoOperacao` varchar(10) DEFAULT NULL,
  `DescricaoAlteracao` text DEFAULT NULL,
  `DataHora` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`IdLog`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `LogAlteracoesCrime`
--

DROP TABLE IF EXISTS `LogAlteracoesCrime`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LogAlteracoesCrime` (
  `IdLog` int(11) NOT NULL AUTO_INCREMENT,
  `IdRegistro` int(11) DEFAULT NULL,
  `TipoOperacao` varchar(10) DEFAULT NULL,
  `DescricaoAlteracao` text DEFAULT NULL,
  `DataHora` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`IdLog`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `LogAlteracoesTipoCrime`
--

DROP TABLE IF EXISTS `LogAlteracoesTipoCrime`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LogAlteracoesTipoCrime` (
  `IdLog` int(11) NOT NULL AUTO_INCREMENT,
  `IdRegistro` int(11) DEFAULT NULL,
  `TipoOperacao` varchar(10) DEFAULT NULL,
  `DescricaoAlteracao` text DEFAULT NULL,
  `DataHora` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`IdLog`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `LogsCidades`
--

DROP TABLE IF EXISTS `LogsCidades`;
/*!50001 DROP VIEW IF EXISTS `LogsCidades`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `LogsCidades` AS SELECT
 1 AS `IdLog`,
  1 AS `IdRegistro`,
  1 AS `TipoOperacao`,
  1 AS `DescricaoAlteracao`,
  1 AS `DataHora` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `LogsCrimes`
--

DROP TABLE IF EXISTS `LogsCrimes`;
/*!50001 DROP VIEW IF EXISTS `LogsCrimes`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `LogsCrimes` AS SELECT
 1 AS `IdLog`,
  1 AS `IdRegistro`,
  1 AS `TipoOperacao`,
  1 AS `DescricaoAlteracao`,
  1 AS `DataHora` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `LogsTipoCrime`
--

DROP TABLE IF EXISTS `LogsTipoCrime`;
/*!50001 DROP VIEW IF EXISTS `LogsTipoCrime`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `LogsTipoCrime` AS SELECT
 1 AS `IdLog`,
  1 AS `IdRegistro`,
  1 AS `TipoOperacao`,
  1 AS `DescricaoAlteracao`,
  1 AS `DataHora` */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `TipoCrime`
--

DROP TABLE IF EXISTS `TipoCrime`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TipoCrime` (
  `IdTipoCrime` int(11) NOT NULL AUTO_INCREMENT,
  `Nome` varchar(50) NOT NULL,
  `CVLI` tinyint(1) NOT NULL,
  PRIMARY KEY (`IdTipoCrime`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER log_tipocrime_insert
AFTER INSERT ON TipoCrime
FOR EACH ROW
BEGIN
    INSERT INTO LogAlteracoesTipoCrime (IdRegistro, TipoOperacao, DescricaoAlteracao)
    VALUES (NEW.IdTipoCrime, 'INSERT', CONCAT('Novo tipo de crime adicionado: ', NEW.Nome));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER log_tipocrime_update
AFTER UPDATE ON TipoCrime
FOR EACH ROW
BEGIN
    
    IF OLD.Nome != NEW.Nome THEN
        INSERT INTO LogAlteracoesTipoCrime (IdRegistro, TipoOperacao, DescricaoAlteracao)
        VALUES (NEW.IdTipoCrime, 'UPDATE', 
                CONCAT('Nome alterado: ', OLD.Nome, ' para ', NEW.Nome));
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER log_tipocrime_delete
AFTER DELETE ON TipoCrime
FOR EACH ROW
BEGIN
    INSERT INTO LogAlteracoesTipoCrime (IdRegistro, TipoOperacao, DescricaoAlteracao)
    VALUES (OLD.IdTipoCrime, 'DELETE', CONCAT('Tipo de crime excluido: ID ', CAST(OLD.IdTipoCrime AS CHAR)));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary table structure for view `ViewCidade`
--

DROP TABLE IF EXISTS `ViewCidade`;
/*!50001 DROP VIEW IF EXISTS `ViewCidade`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `ViewCidade` AS SELECT
 1 AS `IdCidade`,
  1 AS `Nome` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `ViewCrime`
--

DROP TABLE IF EXISTS `ViewCrime`;
/*!50001 DROP VIEW IF EXISTS `ViewCrime`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `ViewCrime` AS SELECT
 1 AS `IdCrime`,
  1 AS `TipoCrime`,
  1 AS `Cidade`,
  1 AS `Mes`,
  1 AS `Ano`,
  1 AS `TotalVitimas` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `ViewTipoCrime`
--

DROP TABLE IF EXISTS `ViewTipoCrime`;
/*!50001 DROP VIEW IF EXISTS `ViewTipoCrime`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `ViewTipoCrime` AS SELECT
 1 AS `IdTipoCrime`,
  1 AS `Nome`,
  1 AS `CVLI` */;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `LogsCidades`
--

/*!50001 DROP VIEW IF EXISTS `LogsCidades`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb3 */;
/*!50001 SET character_set_results     = utf8mb3 */;
/*!50001 SET collation_connection      = utf8mb3_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `LogsCidades` AS select `LogAlteracoesCidade`.`IdLog` AS `IdLog`,`LogAlteracoesCidade`.`IdRegistro` AS `IdRegistro`,`LogAlteracoesCidade`.`TipoOperacao` AS `TipoOperacao`,`LogAlteracoesCidade`.`DescricaoAlteracao` AS `DescricaoAlteracao`,`LogAlteracoesCidade`.`DataHora` AS `DataHora` from `LogAlteracoesCidade` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `LogsCrimes`
--

/*!50001 DROP VIEW IF EXISTS `LogsCrimes`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb3 */;
/*!50001 SET character_set_results     = utf8mb3 */;
/*!50001 SET collation_connection      = utf8mb3_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `LogsCrimes` AS select `LogAlteracoesCrime`.`IdLog` AS `IdLog`,`LogAlteracoesCrime`.`IdRegistro` AS `IdRegistro`,`LogAlteracoesCrime`.`TipoOperacao` AS `TipoOperacao`,`LogAlteracoesCrime`.`DescricaoAlteracao` AS `DescricaoAlteracao`,`LogAlteracoesCrime`.`DataHora` AS `DataHora` from `LogAlteracoesCrime` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `LogsTipoCrime`
--

/*!50001 DROP VIEW IF EXISTS `LogsTipoCrime`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb3 */;
/*!50001 SET character_set_results     = utf8mb3 */;
/*!50001 SET collation_connection      = utf8mb3_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `LogsTipoCrime` AS select `LogAlteracoesTipoCrime`.`IdLog` AS `IdLog`,`LogAlteracoesTipoCrime`.`IdRegistro` AS `IdRegistro`,`LogAlteracoesTipoCrime`.`TipoOperacao` AS `TipoOperacao`,`LogAlteracoesTipoCrime`.`DescricaoAlteracao` AS `DescricaoAlteracao`,`LogAlteracoesTipoCrime`.`DataHora` AS `DataHora` from `LogAlteracoesTipoCrime` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `ViewCidade`
--

/*!50001 DROP VIEW IF EXISTS `ViewCidade`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb3 */;
/*!50001 SET character_set_results     = utf8mb3 */;
/*!50001 SET collation_connection      = utf8mb3_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `ViewCidade` AS select `Cidade`.`IdCidade` AS `IdCidade`,`Cidade`.`Nome` AS `Nome` from `Cidade` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `ViewCrime`
--

/*!50001 DROP VIEW IF EXISTS `ViewCrime`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb3 */;
/*!50001 SET character_set_results     = utf8mb3 */;
/*!50001 SET collation_connection      = utf8mb3_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `ViewCrime` AS select `c`.`IdCrime` AS `IdCrime`,`t`.`Nome` AS `TipoCrime`,`ci`.`Nome` AS `Cidade`,`c`.`Mes` AS `Mes`,`c`.`Ano` AS `Ano`,ifnull(`cv`.`TotalVitimas`,'Não aplicável') AS `TotalVitimas` from (((`Crime` `c` join `TipoCrime` `t` on(`c`.`IdTipoCrime` = `t`.`IdTipoCrime`)) join `Cidade` `ci` on(`c`.`IdCidade` = `ci`.`IdCidade`)) left join `CVLI` `cv` on(`c`.`IdCrime` = `cv`.`IdCrime`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `ViewTipoCrime`
--

/*!50001 DROP VIEW IF EXISTS `ViewTipoCrime`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb3 */;
/*!50001 SET character_set_results     = utf8mb3 */;
/*!50001 SET collation_connection      = utf8mb3_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `ViewTipoCrime` AS select `TipoCrime`.`IdTipoCrime` AS `IdTipoCrime`,`TipoCrime`.`Nome` AS `Nome`,case when `TipoCrime`.`CVLI` = 1 then 'Sim' else 'Não' end AS `CVLI` from `TipoCrime` */;
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

-- Dump completed on 2024-12-08 12:42:54
