CREATE DATABASE  IF NOT EXISTS `covid19docs` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `covid19docs`;
-- MySQL dump 10.13  Distrib 5.7.17, for macos10.12 (x86_64)
--
-- Host: 35.235.90.210    Database: covid19docs
-- ------------------------------------------------------
-- Server version	5.7.25-google-log

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
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED='59321c71-90b0-11ea-af2f-42010aa8001e:1-259222';

--
-- Table structure for table `document_types`
--

DROP TABLE IF EXISTS `document_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `document_types` (
  `unique_document_type_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `doc_type_name` varchar(45) NOT NULL,
  PRIMARY KEY (`unique_document_type_id`),
  UNIQUE KEY `doc_type_name_UNIQUE` (`doc_type_name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `files`
--

DROP TABLE IF EXISTS `files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `files` (
  `unique_file_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `doc_title` varchar(255) DEFAULT NULL COMMENT 'As appears on the Government’s COVID-19 website.',
  `doc_dt_utc` datetime DEFAULT NULL COMMENT 'As appears on the Government’s COVID-19 website. Converted to UTC with a default time of 12:01 AM.',
  `doc_type` varchar(255) DEFAULT NULL COMMENT 'As appears on the Government’s COVID-19 website. In the future, this should be converted to a foreign key as we’re repeating a lot of data here.',
  `doc_type_future` int(10) unsigned NOT NULL COMMENT 'Foreign key. Future use to consolidate records of document types.',
  `downloaded_dt_utc` datetime NOT NULL COMMENT 'Actual time this file was downloaded from the Government’s COVID-19 website.',
  `url_of_download` varchar(255) NOT NULL COMMENT 'Actual URL used to download from the Government’s COVID-19 website.',
  `added_by_user_id` int(10) unsigned NOT NULL COMMENT 'Foreign key. Who added this document to the database.',
  `doc_hash` varchar(255) NOT NULL COMMENT 'The MD5 hash of the file for comparison purposes.',
  `url_of_download_2` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`unique_file_id`),
  KEY `doc-type-id_idx` (`doc_type_future`),
  KEY `user-id_idx` (`added_by_user_id`),
  KEY `hash_idx` (`doc_hash`),
  CONSTRAINT `doc-type-id` FOREIGN KEY (`doc_type_future`) REFERENCES `document_types` (`unique_document_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user-id` FOREIGN KEY (`added_by_user_id`) REFERENCES `users` (`unique_user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=724 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `unique_user_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_name` varchar(45) NOT NULL,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  PRIMARY KEY (`unique_user_id`,`user_name`),
  UNIQUE KEY `user_name_UNIQUE` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-06-26 11:48:24
