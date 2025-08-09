/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.8.2-MariaDB, for osx10.20 (arm64)
--
-- Host: localhost    Database: motogp_wh
-- ------------------------------------------------------
-- Server version	11.8.2-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `dim_negara`
--

DROP TABLE IF EXISTS `dim_negara`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `dim_negara` (
  `negara_key` int(11) NOT NULL AUTO_INCREMENT,
  `id_negara_original` int(11) NOT NULL,
  `nama_negara` varchar(100) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`negara_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dim_negara`
--

LOCK TABLES `dim_negara` WRITE;
/*!40000 ALTER TABLE `dim_negara` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `dim_negara` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `dim_pembalap`
--

DROP TABLE IF EXISTS `dim_pembalap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `dim_pembalap` (
  `pembalap_key` int(11) NOT NULL AUTO_INCREMENT,
  `id_pembalap_original` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`pembalap_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dim_pembalap`
--

LOCK TABLES `dim_pembalap` WRITE;
/*!40000 ALTER TABLE `dim_pembalap` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `dim_pembalap` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `dim_status_pembalap`
--

DROP TABLE IF EXISTS `dim_status_pembalap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `dim_status_pembalap` (
  `status_key` int(11) NOT NULL AUTO_INCREMENT,
  `is_champion` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `status_description` varchar(50) NOT NULL,
  PRIMARY KEY (`status_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dim_status_pembalap`
--

LOCK TABLES `dim_status_pembalap` WRITE;
/*!40000 ALTER TABLE `dim_status_pembalap` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `dim_status_pembalap` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `dim_waktu`
--

DROP TABLE IF EXISTS `dim_waktu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `dim_waktu` (
  `waktu_key` int(11) NOT NULL AUTO_INCREMENT,
  `tahun` year(4) NOT NULL,
  `dekade` varchar(10) NOT NULL,
  `era` varchar(20) NOT NULL,
  PRIMARY KEY (`waktu_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dim_waktu`
--

LOCK TABLES `dim_waktu` WRITE;
/*!40000 ALTER TABLE `dim_waktu` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `dim_waktu` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `fact_kemenangan_pembalap`
--

DROP TABLE IF EXISTS `fact_kemenangan_pembalap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `fact_kemenangan_pembalap` (
  `fact_id` int(11) NOT NULL AUTO_INCREMENT,
  `pembalap_key` int(11) NOT NULL,
  `negara_key` int(11) NOT NULL,
  `waktu_key` int(11) NOT NULL,
  `status_key` int(11) NOT NULL,
  `total_kemenangan` int(11) NOT NULL DEFAULT 0,
  `kemenangan_pertama_tahun` year(4) DEFAULT NULL,
  `kemenangan_terakhir_tahun` year(4) DEFAULT NULL,
  `jumlah_balapan_diikuti` int(11) DEFAULT 0,
  `win_rate` decimal(5,2) DEFAULT 0.00,
  `last_updated` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `batch_date` date NOT NULL,
  PRIMARY KEY (`fact_id`),
  KEY `negara_key` (`negara_key`),
  KEY `waktu_key` (`waktu_key`),
  KEY `status_key` (`status_key`),
  KEY `idx_pembalap` (`pembalap_key`),
  KEY `idx_batch_date` (`batch_date`),
  KEY `idx_updated` (`last_updated`),
  CONSTRAINT `fact_kemenangan_pembalap_ibfk_1` FOREIGN KEY (`pembalap_key`) REFERENCES `dim_pembalap` (`pembalap_key`),
  CONSTRAINT `fact_kemenangan_pembalap_ibfk_2` FOREIGN KEY (`negara_key`) REFERENCES `dim_negara` (`negara_key`),
  CONSTRAINT `fact_kemenangan_pembalap_ibfk_3` FOREIGN KEY (`waktu_key`) REFERENCES `dim_waktu` (`waktu_key`),
  CONSTRAINT `fact_kemenangan_pembalap_ibfk_4` FOREIGN KEY (`status_key`) REFERENCES `dim_status_pembalap` (`status_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fact_kemenangan_pembalap`
--

LOCK TABLES `fact_kemenangan_pembalap` WRITE;
/*!40000 ALTER TABLE `fact_kemenangan_pembalap` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `fact_kemenangan_pembalap` ENABLE KEYS */;
UNLOCK TABLES;
commit;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2025-08-08 20:05:35
