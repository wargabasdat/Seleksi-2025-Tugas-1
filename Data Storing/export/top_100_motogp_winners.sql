/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.8.2-MariaDB, for osx10.20 (arm64)
--
-- Host: localhost    Database: motogp
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
-- Table structure for table `balapan`
--

DROP TABLE IF EXISTS `balapan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `balapan` (
  `id_balapan` int(11) NOT NULL,
  `tahun` year(4) DEFAULT NULL,
  `nama_balapan` varchar(100) NOT NULL,
  `id_pembalap_pemenang` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_balapan`),
  KEY `id_pembalap_pemenang` (`id_pembalap_pemenang`),
  CONSTRAINT `balapan_ibfk_1` FOREIGN KEY (`id_pembalap_pemenang`) REFERENCES `pembalap` (`id_pembalap`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `balapan`
--

LOCK TABLES `balapan` WRITE;
/*!40000 ALTER TABLE `balapan` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `balapan` VALUES
(1,2000,'British Grand Prix',1),
(2,2017,'Dutch TT',1),
(3,2013,'Grand Prix of the Americas',2),
(4,2025,'Czech Republic Grand Prix',2),
(5,1965,'Finnish Grand Prix',3),
(6,1976,'West German Grand Prix',3),
(7,1990,'Hungarian Grand Prix',4),
(8,1998,'Argentine Grand Prix',4),
(9,2008,'Portuguese Grand Prix',5),
(10,2018,'Austrian Grand Prix',5),
(11,2007,'Qatar Grand Prix',6),
(12,2012,'Australian Grand Prix',6),
(13,1961,'Isle of Man TT',7),
(14,1967,'Canadian Grand Prix',7),
(15,1984,'South African Grand Prix',8),
(16,1992,'Hungarian Grand Prix',8),
(17,2006,'Chinese Grand Prix',9),
(18,2017,'Valencian Grand Prix',9),
(19,2021,'Aragon Grand Prix',10),
(20,2025,'Grand Prix of the Americas',10),
(21,1988,'Japanese Grand Prix',11),
(22,1994,'British Grand Prix',11),
(23,1988,'British Grand Prix',12),
(24,1993,'Czech Republic Grand Prix',12),
(25,1950,'Isle of Man TT',13),
(26,1958,'Swedish Grand Prix',13),
(27,1956,'Isle of Man TT',14),
(28,1960,'Nations Grand Prix',14),
(29,1978,'Austrian Grand Prix',15),
(30,1983,'San Marino Grand Prix',15),
(31,1982,'Belgian Grand Prix',16),
(32,1985,'Swedish Grand Prix',16),
(33,1975,'Dutch TT',17),
(34,1981,'Swedish Grand Prix',17),
(35,1986,'Spanish Grand Prix',18),
(36,1992,'British Grand Prix',18),
(37,1992,'Dutch TT',19),
(38,2000,'French Grand Prix',19),
(39,2009,'British Grand Prix',20),
(40,2020,'Austrian Grand Prix',20),
(41,1980,'Belgian Grand Prix',21),
(42,1987,'San Marino Grand Prix',21),
(43,1998,'Japanese Grand Prix',22),
(44,2004,'German Grand Prix',22),
(45,1964,'Ulster Grand Prix',23),
(46,1975,'Czechoslovak Grand Prix',23),
(47,2020,'Spanish Grand Prix',24),
(48,2022,'German Grand Prix',24),
(49,2016,'British Grand Prix',25),
(50,2024,'Grand Prix of the Americas',25),
(51,2001,'Valencian Grand Prix',26),
(52,2004,'Qatar Grand Prix',26),
(53,1996,'Australian Grand Prix',27),
(54,2007,'Japanese Grand Prix',27),
(55,1961,'West German Grand Prix',28),
(56,1962,'Isle of Man TT',28),
(57,1993,'British Grand Prix',29),
(58,1996,'German Grand Prix',29),
(59,1999,'Malaysian Grand Prix',30),
(60,2000,'Pacific Grand Prix',30),
(61,2021,'Styrian Grand Prix',31),
(62,2024,'Indonesian Grand Prix',31),
(63,1993,'FIM Grand Prix',32),
(64,2005,'Portuguese Grand Prix',32),
(65,2022,'Qatar Grand Prix',33),
(66,2024,'Emilia Romagna Grand Prix',33),
(67,1950,'Belgian Grand Prix',34),
(68,1955,'Nations Grand Prix',34),
(69,1980,'German Grand Prix',35),
(70,1981,'Finnish Grand Prix',35),
(71,2019,'Grand Prix of the Americas',36),
(72,2023,'Grand Prix of the Americas',36),
(73,1949,'Swiss Grand Prix',37),
(74,1952,'Spanish Grand Prix',37),
(75,1977,'Dutch TT',38),
(76,1980,'Finnish Grand Prix',38),
(77,1982,'Austrian Grand Prix',39),
(78,1982,'British Grand Prix',39),
(79,2005,'Turkish Grand Prix',40),
(80,2006,'Australian Grand Prix',40),
(81,2020,'Styrian Grand Prix',41),
(82,2022,'Thailand Grand Prix',41),
(83,1952,'Isle of Man TT',42),
(84,1956,'West German Grand Prix',42),
(85,1957,'German Grand Prix',43),
(86,1957,'Nations Grand Prix',43),
(87,1991,'Malaysian Grand Prix',44),
(88,1994,'Australian Grand Prix',44),
(89,1997,'Indonesian Grand Prix',45),
(90,1999,'Australian Grand Prix',45),
(91,2016,'Dutch TT',46),
(92,2022,'Japanese Grand Prix',46),
(93,2023,'Argentine Grand Prix',47),
(94,2025,'British Grand Prix',47),
(95,1951,'French Grand Prix',48),
(96,1953,'Belgian Grand Prix',48),
(97,1956,'Ulster Grand Prix',49),
(98,1963,'Dutch TT',49),
(99,1969,'Nations Grand Prix',50),
(100,1972,'Yugoslavian Grand Prix',50),
(101,1971,'Ulster Grand Prix',51),
(102,1977,'Austrian Grand Prix',51),
(103,1976,'Finnish Grand Prix',52),
(104,1978,'Spanish Grand Prix',52),
(105,1977,'Finnish Grand Prix',53),
(106,1978,'Dutch TT',53),
(107,1993,'German Grand Prix',54),
(108,1995,'German Grand Prix',54),
(109,1996,'Japanese Grand Prix',55),
(110,2000,'Japanese Grand Prix',55),
(111,2000,'South African Grand Prix',56),
(112,2000,'Valencian Grand Prix',56),
(113,2005,'United States Grand Prix',57),
(114,2006,'United States Grand Prix',57),
(115,2016,'Czech Republic Grand Prix',58),
(116,2018,'Argentine Grand Prix',58),
(117,2020,'San Marino Grand Prix',59),
(118,2020,'Valencian Grand Prix',59),
(119,2022,'Argentine Grand Prix',60),
(120,2023,'Catalan Grand Prix',60),
(121,1949,'Dutch TT',61),
(122,1949,'Nations Grand Prix',61),
(123,1951,'Swiss Grand Prix',62),
(124,1953,'Spanish Grand Prix',62),
(125,1953,'Isle of Man TT',63),
(126,1954,'Isle of Man TT',63),
(127,1966,'West German Grand Prix',64),
(128,1966,'Dutch TT',64),
(129,1973,'French Grand Prix',65),
(130,1973,'Austrian Grand Prix',65),
(131,1978,'German Grand Prix',66),
(132,1979,'Dutch TT',66),
(133,1980,'Dutch TT',67),
(134,1981,'British Grand Prix',67),
(135,1996,'Catalan Grand Prix',68),
(136,1998,'Madrid Grand Prix',68),
(137,2004,'Rio de Janeiro Grand Prix',69),
(138,2004,'Japanese Grand Prix',69),
(139,2019,'Italian Grand Prix',70),
(140,2020,'French Grand Prix',70),
(141,2020,'Czech Republic Grand Prix',71),
(142,2021,'Austrian Grand Prix',71),
(143,2023,'Australian Grand Prix',72),
(144,2025,'French Grand Prix',72),
(145,1949,'Isle of Man TT',73),
(146,1949,'Belgian Grand Prix',74),
(147,1952,'Swiss Grand Prix',75),
(148,1952,'Ulster Grand Prix',76),
(149,1953,'Ulster Grand Prix',77),
(150,1954,'French Grand Prix',78),
(151,1954,'Spanish Grand Prix',79),
(152,1955,'Belgian Grand Prix',80),
(153,1955,'Ulster Grand Prix',81),
(154,1957,'Isle of Man TT',82),
(155,1960,'Dutch TT',83),
(156,1961,'Argentine Grand Prix',84),
(157,1962,'Finnish Grand Prix',85),
(158,1962,'Argentine Grand Prix',86),
(159,1964,'Finnish Grand Prix',87),
(160,1965,'Ulster Grand Prix',88),
(161,1966,'East German Grand Prix',89),
(162,1969,'Yugoslavian Grand Prix',90),
(163,1970,'Spanish Grand Prix',91),
(164,1971,'Spanish Grand Prix',92),
(165,1972,'Spanish Grand Prix',93),
(166,1973,'Yugoslavian Grand Prix',94),
(167,1974,'German Grand Prix',95),
(168,1974,'Nations Grand Prix',96),
(169,1974,'Isle of Man TT',97),
(170,1974,'Swedish Grand Prix',98),
(171,1975,'Austrian Grand Prix',99),
(172,1975,'Isle of Man TT',100);
/*!40000 ALTER TABLE `balapan` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `kerjasama_sponsor`
--

DROP TABLE IF EXISTS `kerjasama_sponsor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `kerjasama_sponsor` (
  `id_pembalap` int(11) NOT NULL,
  `id_sponsor` int(11) NOT NULL,
  `lama_tahun` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_pembalap`,`id_sponsor`),
  KEY `id_sponsor` (`id_sponsor`),
  CONSTRAINT `kerjasama_sponsor_ibfk_1` FOREIGN KEY (`id_pembalap`) REFERENCES `pembalap` (`id_pembalap`),
  CONSTRAINT `kerjasama_sponsor_ibfk_2` FOREIGN KEY (`id_sponsor`) REFERENCES `sponsor` (`id_sponsor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kerjasama_sponsor`
--

LOCK TABLES `kerjasama_sponsor` WRITE;
/*!40000 ALTER TABLE `kerjasama_sponsor` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `kerjasama_sponsor` VALUES
(1,14,3),
(2,6,1),
(2,8,1),
(3,15,1),
(3,18,4),
(3,19,3),
(4,8,4),
(4,15,2),
(4,19,1),
(5,1,5),
(6,7,1),
(6,9,4),
(7,6,3),
(7,7,5),
(7,19,5),
(8,6,3),
(9,10,5),
(10,17,1),
(11,1,2),
(12,3,1),
(12,6,3),
(13,12,3),
(14,1,4),
(14,12,1),
(14,16,5),
(15,3,5),
(15,9,5),
(15,14,4),
(16,9,5),
(16,13,1),
(16,15,3),
(17,7,5),
(17,11,3),
(17,16,2),
(18,13,1),
(18,14,4),
(18,17,3),
(19,10,3),
(19,12,2),
(20,19,3),
(21,6,1),
(21,7,2),
(21,10,4),
(22,4,2),
(22,6,4),
(22,11,1),
(23,13,4),
(23,19,1),
(24,7,5),
(24,10,3),
(25,20,4),
(26,6,4),
(27,3,3),
(27,13,1),
(27,20,3),
(28,12,3),
(28,19,5),
(29,1,5),
(29,8,5),
(29,10,3),
(30,14,4),
(31,7,2),
(31,9,5),
(31,16,4),
(32,2,3),
(32,5,3),
(32,14,3),
(33,3,1),
(33,16,5),
(34,5,4),
(34,14,2),
(35,12,2),
(35,19,3),
(36,7,1),
(37,4,1),
(37,7,1),
(37,20,5),
(38,3,2),
(38,10,2),
(39,5,1),
(39,16,3),
(39,18,1),
(40,1,1),
(40,11,5),
(40,20,2),
(41,19,5),
(41,20,1),
(42,12,5),
(43,3,5),
(43,11,5),
(43,16,1),
(44,14,2),
(45,9,4),
(46,3,2),
(46,15,2),
(47,7,1),
(47,10,1),
(48,4,5),
(48,8,1),
(48,17,1),
(49,9,4),
(50,16,1),
(51,2,5),
(51,3,3),
(51,8,4),
(52,7,4),
(53,9,2),
(54,6,1),
(54,15,2),
(54,19,4),
(55,14,3),
(56,8,4),
(56,20,3),
(57,13,4),
(57,17,3),
(57,18,1),
(58,17,3),
(59,11,1),
(59,14,3),
(60,9,3),
(61,9,3),
(61,13,1),
(62,1,2),
(62,15,2),
(63,5,2),
(63,12,3),
(63,13,2),
(64,19,3),
(65,6,3),
(66,5,5),
(67,7,5),
(68,1,3),
(68,2,1),
(68,18,1),
(69,17,3),
(70,2,1),
(70,11,4),
(70,20,1),
(71,11,4),
(71,13,5),
(72,9,2),
(72,16,2),
(72,20,1),
(73,2,1),
(73,14,1),
(73,15,1),
(74,1,2),
(74,5,2),
(74,12,4),
(75,3,1),
(75,4,3),
(75,8,1),
(76,8,3),
(76,10,3),
(76,19,3),
(77,12,3),
(77,15,2),
(78,20,2),
(79,12,1),
(79,14,5),
(80,2,2),
(80,6,5),
(80,11,5),
(81,16,4),
(82,3,5),
(82,6,1),
(82,14,2),
(83,7,3),
(83,9,2),
(84,2,1),
(84,3,4),
(84,13,1),
(85,20,4),
(86,6,5),
(87,6,3),
(87,12,5),
(88,7,2),
(88,8,4),
(89,8,1),
(89,20,5),
(90,11,1),
(91,3,2),
(92,6,1),
(92,13,3),
(92,15,4),
(93,4,3),
(93,11,1),
(93,18,5),
(94,10,1),
(94,13,4),
(95,3,1),
(96,8,5),
(96,15,4),
(96,20,1),
(97,10,4),
(98,13,5),
(98,19,3),
(99,6,3),
(100,3,3),
(100,9,4),
(100,15,1);
/*!40000 ALTER TABLE `kerjasama_sponsor` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `konstruktor`
--

DROP TABLE IF EXISTS `konstruktor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `konstruktor` (
  `id_konstruktor` int(11) NOT NULL,
  `nama_konstruktor` varchar(100) NOT NULL,
  `jenis_mesin` varchar(100) NOT NULL,
  PRIMARY KEY (`id_konstruktor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `konstruktor`
--

LOCK TABLES `konstruktor` WRITE;
/*!40000 ALTER TABLE `konstruktor` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `konstruktor` VALUES
(1,'Honda','Single Cylinder'),
(2,'Yamaha','Inline-4'),
(3,'Ducati','Inline-4'),
(4,'Suzuki','Parallel Twin'),
(5,'KTM','Parallel Twin'),
(6,'Aprilia','Single Cylinder'),
(7,'BMW','Single Cylinder'),
(8,'Kawasaki','Inline-4'),
(9,'MV Agusta','Single Cylinder'),
(10,'Husqvarna','Parallel Twin');
/*!40000 ALTER TABLE `konstruktor` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `negara`
--

DROP TABLE IF EXISTS `negara`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `negara` (
  `id_negara` int(11) NOT NULL,
  `nama_negara` varchar(100) NOT NULL,
  PRIMARY KEY (`id_negara`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `negara`
--

LOCK TABLES `negara` WRITE;
/*!40000 ALTER TABLE `negara` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `negara` VALUES
(1,'Italy'),
(2,'Spain'),
(3,'Australia'),
(4,'United Kingdom'),
(5,'United States'),
(6,'France'),
(7,'Federation of Rhodesia and Nyasaland'),
(8,'Brazil'),
(9,'Netherlands'),
(10,'Portugal'),
(11,'Republic of Ireland'),
(12,'Japan'),
(13,'Venezuela'),
(14,'Southern Rhodesia'),
(15,'Rhodesia'),
(16,'Finland'),
(17,'South Africa'),
(18,'Argentina'),
(19,'Czechoslovakia'),
(20,'New Zealand'),
(21,'Germany');
/*!40000 ALTER TABLE `negara` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `pembalap`
--

DROP TABLE IF EXISTS `pembalap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `pembalap` (
  `id_pembalap` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(100) NOT NULL,
  `jumlah_kemenangan` int(11) DEFAULT 0 CHECK (`jumlah_kemenangan` >= 0),
  `is_champion` tinyint(1) DEFAULT 0,
  `is_active` tinyint(1) DEFAULT 1,
  `id_negara` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_pembalap`),
  KEY `id_negara` (`id_negara`),
  CONSTRAINT `pembalap_ibfk_1` FOREIGN KEY (`id_negara`) REFERENCES `negara` (`id_negara`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pembalap`
--

LOCK TABLES `pembalap` WRITE;
/*!40000 ALTER TABLE `pembalap` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `pembalap` VALUES
(1,'Valentino Rossi',89,1,0,1),
(2,'Marc Márquez',70,1,1,2),
(3,'Giacomo Agostini',68,1,0,1),
(4,'Mick Doohan',54,1,0,3),
(5,'Jorge Lorenzo',47,1,0,2),
(6,'Casey Stoner',38,1,0,3),
(7,'Mike Hailwood',37,1,0,4),
(8,'Eddie Lawson',31,1,0,5),
(9,'Dani Pedrosa',31,1,0,2),
(10,'Francesco Bagnaia',30,1,1,1),
(11,'Kevin Schwantz',25,1,0,5),
(12,'Wayne Rainey',24,1,0,5),
(13,'Geoff Duke',22,1,0,4),
(14,'John Surtees',22,1,0,4),
(15,'Kenny Roberts',22,1,0,5),
(16,'Freddie Spencer',20,1,0,5),
(17,'Barry Sheene',19,1,0,4),
(18,'Wayne Gardner',18,1,0,3),
(19,'Àlex Crivillé',15,1,0,2),
(20,'Andrea Dovizioso',15,1,0,1),
(21,'Randy Mamola',13,0,0,5),
(22,'Max Biaggi',13,1,0,1),
(23,'Phil Read',11,1,0,4),
(24,'Fabio Quartararo',11,1,1,6),
(25,'Maverick Viñales',10,1,1,2),
(26,'Sete Gibernau',9,0,0,2),
(27,'Loris Capirossi',9,1,0,1),
(28,'Gary Hocking',8,1,0,7),
(29,'Luca Cadalora',8,1,0,1),
(30,'Kenny Roberts Jr.',8,1,0,5),
(31,'Jorge Martín',8,1,1,2),
(32,'Alex Barros',7,0,0,8),
(33,'Enea Bastianini',7,1,1,1),
(34,'Umberto Masetti',6,1,0,1),
(35,'Marco Lucchinelli',6,1,0,1),
(36,'Álex Rins',6,0,1,2),
(37,'Leslie Graham',5,1,0,4),
(38,'Wil Hartog',5,0,0,9),
(39,'Franco Uncini',5,1,0,1),
(40,'Marco Melandri',5,1,0,1),
(41,'Miguel Oliveira',5,0,1,10),
(42,'Reg Armstrong',4,0,0,11),
(43,'Libero Liberati',4,1,0,1),
(44,'John Kocinski',4,1,0,5),
(45,'Tadayuki Okada',4,0,0,12),
(46,'Jack Miller',4,0,1,3),
(47,'Marco Bezzecchi',4,0,1,1),
(48,'Alfredo Milani',3,0,0,1),
(49,'John Hartle',3,0,0,4),
(50,'Alberto Pagani',3,0,0,1),
(51,'Jack Findlay',3,0,0,3),
(52,'Pat Hennen',3,0,0,5),
(53,'Johnny Cecotto',3,1,0,13),
(54,'Daryl Beattie',3,0,0,3),
(55,'Norifumi Abe',3,0,0,12),
(56,'Garry McCoy',3,0,0,3),
(57,'Nicky Hayden',3,1,0,5),
(58,'Cal Crutchlow',3,0,0,4),
(59,'Franco Morbidelli',3,1,1,1),
(60,'Aleix Espargaró',3,0,0,2),
(61,'Nello Pagani',2,1,0,1),
(62,'Fergus Anderson',2,1,0,4),
(63,'Ray Amm',2,0,0,14),
(64,'Jim Redman',2,1,0,15),
(65,'Jarno Saarinen',2,1,0,16),
(66,'Virginio Ferrari',2,0,0,1),
(67,'Jack Middelburg',2,0,0,9),
(68,'Carlos Checa',2,0,0,2),
(69,'Makoto Tamada',2,0,0,12),
(70,'Danilo Petrucci',2,0,0,1),
(71,'Brad Binder',2,1,1,17),
(72,'Johann Zarco',2,1,1,6),
(73,'Harold Daniell',1,0,0,4),
(74,'Bill Doran',1,0,0,4),
(75,'Jack Brett',1,0,0,4),
(76,'Cromie McCandless',1,0,0,4),
(77,'Ken Kavanagh',1,0,0,3),
(78,'Pierre Monneret',1,0,0,6),
(79,'Dickie Dale',1,0,0,4),
(80,'Giuseppe Colnago',1,0,0,1),
(81,'Bill Lomas',1,1,0,4),
(82,'Bob McIntyre',1,0,0,4),
(83,'Remo Venturi',1,0,0,1),
(84,'Jorge Kissling',1,0,0,18),
(85,'Alan Shepherd',1,0,0,4),
(86,'Benedicto Caldarella',1,0,0,18),
(87,'Jack Ahearn',1,0,0,3),
(88,'Dick Creith',1,0,0,4),
(89,'František Šťastný',1,0,0,19),
(90,'Godfrey Nash',1,0,0,4),
(91,'Angelo Bergamonti',1,0,0,1),
(92,'Dave Simmonds',1,1,0,4),
(93,'Chas Mortimer',1,0,0,4),
(94,'Kim Newcombe',1,0,0,20),
(95,'Edmund Czihak',1,0,0,21),
(96,'Gianfranco Bonera',1,0,0,1),
(97,'Phil Carpenter',1,0,0,4),
(98,'Teuvo Länsivuori',1,0,0,16),
(99,'Hideo Kanaya',1,0,0,12),
(100,'Mick Grant',1,0,0,4);
/*!40000 ALTER TABLE `pembalap` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `pembalap_tim`
--

DROP TABLE IF EXISTS `pembalap_tim`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `pembalap_tim` (
  `id_pembalap` int(11) NOT NULL,
  `id_tim` int(11) NOT NULL,
  `tahun` year(4) DEFAULT NULL,
  PRIMARY KEY (`id_pembalap`,`id_tim`),
  KEY `id_tim` (`id_tim`),
  CONSTRAINT `pembalap_tim_ibfk_1` FOREIGN KEY (`id_pembalap`) REFERENCES `pembalap` (`id_pembalap`),
  CONSTRAINT `pembalap_tim_ibfk_2` FOREIGN KEY (`id_tim`) REFERENCES `tim_balap` (`id_tim`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pembalap_tim`
--

LOCK TABLES `pembalap_tim` WRITE;
/*!40000 ALTER TABLE `pembalap_tim` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `pembalap_tim` VALUES
(1,5,2008),
(1,9,2005),
(2,4,2008),
(2,15,2003),
(3,1,2016),
(4,3,2005),
(4,10,2000),
(5,1,2011),
(6,8,2010),
(6,11,2008),
(7,2,2022),
(7,8,2020),
(8,12,2013),
(9,9,2027),
(9,11,2024),
(10,7,2014),
(11,2,2017),
(12,3,2006),
(12,15,2011),
(13,1,2009),
(14,13,2000),
(15,5,2007),
(15,6,2004),
(16,6,2007),
(17,11,2011),
(18,5,2013),
(18,10,2008),
(19,12,2003),
(20,7,2029),
(20,9,2024),
(21,10,2018),
(22,9,2000),
(23,5,2010),
(23,13,2013),
(24,13,2002),
(25,5,2017),
(25,9,2019),
(26,3,2006),
(27,9,2021),
(27,13,2025),
(28,11,2017),
(28,15,2014),
(29,14,2011),
(29,15,2007),
(30,12,2013),
(31,5,2005),
(31,9,2000),
(32,13,2016),
(33,1,2004),
(33,4,2009),
(34,1,2002),
(34,10,2005),
(35,6,2015),
(36,1,2005),
(36,14,2003),
(37,12,2007),
(38,6,2002),
(38,14,2007),
(39,11,2001),
(39,13,2003),
(40,7,2004),
(41,1,2014),
(41,4,2009),
(42,2,2005),
(42,15,2008),
(43,9,2022),
(44,7,2017),
(45,6,2024),
(45,15,2027),
(46,12,2006),
(46,14,2003),
(47,7,2020),
(47,14,2022),
(48,3,2019),
(48,11,2016),
(49,10,2016),
(50,9,2021),
(51,7,2008),
(52,9,2005),
(53,11,2008),
(53,14,2006),
(54,5,2012),
(54,15,2015),
(55,2,2018),
(55,9,2022),
(56,9,2013),
(57,7,2012),
(58,11,2019),
(59,11,2005),
(60,15,2006),
(61,12,2021),
(62,2,2006),
(63,10,2009),
(64,13,2016),
(65,1,2011),
(65,2,2007),
(66,6,2024),
(66,8,2020),
(67,13,2003),
(68,9,2007),
(68,14,2010),
(69,2,2013),
(70,2,2015),
(70,3,2013),
(71,5,2019),
(71,12,2021),
(72,1,2025),
(72,13,2022),
(73,9,2016),
(73,15,2020),
(74,5,2010),
(75,1,2008),
(75,7,2010),
(76,2,2016),
(76,4,2014),
(77,5,2009),
(78,14,2016),
(79,10,2006),
(80,9,2014),
(80,14,2016),
(81,10,2021),
(82,11,2014),
(82,14,2017),
(83,14,2016),
(84,12,2000),
(85,12,2001),
(85,14,2003),
(86,1,2023),
(86,10,2028),
(87,8,2006),
(87,13,2004),
(88,8,2015),
(88,11,2010),
(89,14,2013),
(90,12,2021),
(91,1,2009),
(91,6,2007),
(92,6,2017),
(93,1,2014),
(93,11,2009),
(94,3,2011),
(95,10,2023),
(96,5,2002),
(96,6,2007),
(97,13,2021),
(98,13,2024),
(99,11,2010),
(100,3,2009);
/*!40000 ALTER TABLE `pembalap_tim` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `sponsor`
--

DROP TABLE IF EXISTS `sponsor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `sponsor` (
  `id_sponsor` int(11) NOT NULL,
  `nama_sponsor` varchar(100) NOT NULL,
  `nilai_sponsor` decimal(15,2) DEFAULT NULL,
  PRIMARY KEY (`id_sponsor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sponsor`
--

LOCK TABLES `sponsor` WRITE;
/*!40000 ALTER TABLE `sponsor` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sponsor` VALUES
(1,'Montgomery-Lee Tire',47322236.69),
(2,'Roth and Sons Banking',12439042.99),
(3,'Armstrong LLC Insurance',49822886.33),
(4,'Dunn-Perez Energy Drink',43005604.11),
(5,'Nichols, Strickland and Saunders Banking',4897693.56),
(6,'Mitchell PLC Energy Drink',7018870.27),
(7,'Valentine-Wallace Insurance',20809415.34),
(8,'Brown, Smith and Bray Banking',30056832.25),
(9,'Williamson, Walker and Perry Tire',41339403.47),
(10,'Davis and Sons Clothing',14624418.41),
(11,'Lopez-Nicholson Motorcycle',1775044.86),
(12,'Petersen, Todd and Hicks Insurance',4764516.60),
(13,'Garcia, Wells and Singleton Banking',28755224.79),
(14,'Jackson Ltd Electronics',23311728.81),
(15,'Lutz-Thompson Motorcycle',16922078.89),
(16,'Merritt-Howard Insurance',41130564.56),
(17,'Bowen-Lee Insurance',39018612.23),
(18,'Vasquez LLC Clothing',39243966.86),
(19,'Morales Group Energy Drink',2548003.56),
(20,'Duncan, Ortiz and Price Insurance',22195869.81);
/*!40000 ALTER TABLE `sponsor` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `tim_balap`
--

DROP TABLE IF EXISTS `tim_balap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tim_balap` (
  `id_tim` int(11) NOT NULL,
  `nama_tim` varchar(100) NOT NULL,
  `id_konstruktor` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_tim`),
  KEY `id_konstruktor` (`id_konstruktor`),
  CONSTRAINT `tim_balap_ibfk_1` FOREIGN KEY (`id_konstruktor`) REFERENCES `konstruktor` (`id_konstruktor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tim_balap`
--

LOCK TABLES `tim_balap` WRITE;
/*!40000 ALTER TABLE `tim_balap` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `tim_balap` VALUES
(1,'Squad Mercer-Pollard',10),
(2,'LCR Smith,',10),
(3,'Pramac Bryant-Jones',10),
(4,'Racing Blair',7),
(5,'Pramac Strong,',5),
(6,'Pramac Smith',7),
(7,'Squad Brown',4),
(8,'Team Logan',9),
(9,'Factory Flores,',10),
(10,'Gresini Guerrero-Taylor',10),
(11,'Pramac Garcia-Smith',3),
(12,'VR46 Kelley',9),
(13,'Pramac Middleton-Cooley',5),
(14,'Pramac Walton,',5),
(15,'Racing Hart-Stevens',9);
/*!40000 ALTER TABLE `tim_balap` ENABLE KEYS */;
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

-- Dump completed on 2025-08-08 19:19:06
