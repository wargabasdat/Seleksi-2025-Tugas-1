-- MySQL dump 10.13  Distrib 5.7.24, for osx11.1 (x86_64)
--
-- Host: localhost    Database: boardgame_db
-- ------------------------------------------------------
-- Server version	9.2.0

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
-- Current Database: `boardgame_db`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `boardgame_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `boardgame_db`;

--
-- Table structure for table `artists`
--

DROP TABLE IF EXISTS `artists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `artists` (
  `artist_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`artist_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=823 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artists`
--

LOCK TABLES `artists` WRITE;
/*!40000 ALTER TABLE `artists` DISABLE KEYS */;
INSERT INTO `artists` (`artist_id`, `name`) VALUES (1,'Adam S. Doyle'),(2,'Adrian Smith'),(3,'Adrien Rives'),(4,'Aidan Roberts'),(5,'Alain Viesca'),(6,'Alexandr Elichev'),(7,'Aline Kirrmann'),(8,'Allison Litchfield'),(203,'Álvaro Calvo Escudero'),(9,'Alvaro Nebot'),(10,'Amelie Hutt'),(11,'Ana Maria Martinez Jaramillo'),(12,'Anailis Dorta'),(13,'Anders Finér'),(14,'Andreas Resch'),(15,'Andrew Bosley'),(16,'Andrzej Półtoranos'),(17,'Anika Burrell'),(18,'Anthony LeTourneau'),(19,'Antonio De Luca'),(20,'Antonio Dessi'),(21,'Arden Beckwith'),(22,'Atha Kanaani'),(23,'Balaskas'),(24,'Beth Sobel'),(25,'Brett Nienburg'),(26,'Bruce Brenneise'),(27,'Bruno Balixa'),(28,'Cari Corene'),(29,'Chechu Nieto'),(30,'Chris Quilliams'),(31,'Chris Raimo'),(32,'Christof Tisch'),(33,'Christopher Burdett'),(34,'Christopher Hosch'),(35,'Claus Stephan'),(36,'Clay Brooks'),(37,'Clément Masson'),(38,'Cody Jones'),(39,'Cole Wehrle'),(40,'Corey Konieczka'),(41,'Cristi Balanescu'),(42,'Cyrille Daujean'),(43,'Damien Mammoliti'),(44,'Dan Gerlach'),(45,'Dan Hallagan'),(46,'Dan Roff'),(47,'Daniel Fryxelius'),(48,'Dann May'),(49,'Danny Beck'),(50,'David Ardila'),(51,'David Demaret'),(52,'David Forest'),(53,'David Montgomery'),(54,'Del Borovic'),(55,'Dennis Lohausen'),(56,'Derek Herring'),(57,'Dimitris Anastasiadis'),(58,'Dominik Mayer'),(59,'Domonkos Bence'),(60,'Dongbiao Lu'),(61,'Dongjun Lu'),(62,'Doris Matthäus'),(63,'Eckhard Freytag'),(64,'Elizabeth Hargrave'),(65,'Eric Belisle'),(66,'Eric Deschamps'),(67,'Eric Hibbeler'),(68,'Ewa Labak'),(69,'Fabio Maiorana'),(70,'Filip Murmak'),(71,'Fiore GmbH'),(72,'Francesca Baerald'),(73,'František Sedláček'),(74,'Franz Vohwinkel'),(75,'Franz-Georg Stämmele'),(76,'Gavan Brown'),(77,'Gjermund Bohne'),(78,'Gong Studios'),(79,'Grace VanFleet'),(80,'Greg May'),(81,'Gui Landgraf'),(82,'Guillaume Ries'),(83,'Harald Lieske'),(84,'Henning Ludvigsen'),(85,'Ian O\'Toole'),(86,'Ignacio Bazán Lazcano'),(87,'Iris de Haan'),(88,'Isaac Fryxelius'),(89,'J. Lonnee'),(90,'Jacob Murray'),(91,'Jacqui Davis'),(92,'Jakub Lang'),(93,'Jakub Politzer'),(94,'Jakub Rozalski'),(95,'Jakub Skop'),(96,'Jason Behnke'),(97,'Javier González Cava'),(98,'Jere Kasanen'),(99,'Jessy Töpfer'),(100,'Jiří Kůs'),(101,'Jiří Mikovec'),(612,'Jo Hartwig'),(102,'Joan Guardiet'),(103,'Joel Hustak'),(104,'John Howe'),(105,'John VanFleet'),(106,'Jorge Barrero'),(107,'Jose David Lanza Cebrian'),(611,'Josh McDowell'),(108,'Josh T. McDowell'),(109,'Jukka Rajaniemi'),(110,'Julien Delval'),(111,'Karl Kopinski'),(112,'Kat G Birmelin'),(113,'Katerina Xerovasila'),(114,'Klemens Franz'),(115,'Kyle Ferrin'),(116,'Lars-Arne \"Maura\" Kalusky'),(117,'Laslo Forgach'),(125,'László Fejes'),(118,'Lina Cossette'),(121,'Loïc Berger'),(122,'Loïc Billiau'),(119,'Lokman Lam'),(120,'Lorinda Tomko'),(123,'Lucas Durham'),(124,'Lukas Siegmon'),(126,'Mac Gerdts'),(137,'Maëva da Silva'),(127,'Marcin Jakubowski'),(128,'Marco Armbruster'),(129,'Marina Fahrenbach'),(130,'Mark Simonitch'),(131,'Martin Hoffmann'),(132,'Martin Mottet'),(147,'Márton Gyula Kiss'),(614,'Mateusz Bielski'),(133,'Matt Allsopp'),(134,'Matt Paquette & Co.'),(135,'Matt Tolman'),(136,'Mauro Alocci'),(138,'Mercedes Opheim'),(139,'Micaela Dawn'),(140,'Michaela Lovecká'),(141,'Michal Ivan'),(142,'Miguel Coimbra'),(143,'Mihajlo Dimitrievski'),(144,'Mike McVey'),(145,'Milan Vavroň'),(146,'Monica Helland'),(148,'Natalia Rojas'),(149,'Nate Storm'),(150,'Nicolas Fructus'),(151,'Noah Adelman'),(152,'Noah Bradley'),(153,'Ondřej Hrdina'),(154,'Orlando Ramirez'),(155,'Ossi Hiekkala'),(156,'Oto Kandera'),(157,'Paolo Voto'),(158,'Patryk Jędraszek'),(159,'Peter Dennis'),(163,'Péter Meszlényi'),(160,'Philippe Guérin'),(161,'Piotr Foksowicz'),(162,'Prapach Lapamnuaysap'),(164,'Radim Pech'),(165,'Ralph Beisner'),(166,'Rastislav Le'),(167,'Raul Ramos'),(168,'Rayph Beisner'),(169,'Richard Wright'),(170,'Rodger B. MacGowan'),(171,'Roman Roland Kuteynikov'),(172,'Rovina Cai'),(173,'Ryan Barger'),(174,'Ryan Laukat'),(175,'Ryogo Toyoda'),(176,'Sampo Sikiö'),(177,'Samuel R. Shimota'),(178,'Sarah Kelly'),(179,'Scott Schomburg'),(180,'Sean Jackson'),(181,'Sensit Communication GmbH'),(182,'Snow Conrad'),(183,'Stefan Sonnberger'),(184,'Steffen Bieker'),(185,'Steven Belledin'),(613,'Tanja Donner'),(186,'Thierry Masson'),(187,'Thomas Lishman'),(188,'Tiziano Baracchi'),(610,'Tomáš Kučerovský'),(189,'Tony Foti'),(190,'Tysen Henderson'),(191,'Uildrim'),(192,'Victor Maristane'),(193,'Viktor Csete'),(194,'Villő Farkas'),(195,'Vincent Dutrait'),(196,'Vladimir Buchyk'),(197,'Wayne England'),(198,'Ynze Moedt'),(199,'Yoann Boissonnet'),(200,'Zeen Chin'),(201,'Zoe Robinson'),(202,'Zoltan Boros');
/*!40000 ALTER TABLE `artists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `awards`
--

DROP TABLE IF EXISTS `awards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `awards` (
  `award_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`award_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=1561 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `awards`
--

LOCK TABLES `awards` WRITE;
/*!40000 ALTER TABLE `awards` DISABLE KEYS */;
INSERT INTO `awards` (`award_id`, `name`) VALUES (1,'1995 Meeples Choice Award Nominee'),(2,'1995 Meeples Choice Award Winner'),(1159,'1995 Spiel des Jahres Winner'),(3,'1996 Deutscher Spiele Preis Best Family/Adult Game Winner'),(4,'1996 Spiel des Jahres Winner'),(5,'1997 Årets Spil Best Adult Game Winner'),(1157,'1999 Spiel des Jahres Winner'),(6,'2002 Deutscher Spiele Preis Best Family/Adult Game Winner'),(7,'2002 Essener Feder Best Written Rules Winner'),(8,'2002 Japan Boardgame Prize Best Advanced Game Nominee'),(9,'2002 Japan Boardgame Prize Best Advanced Game Winner'),(10,'2002 Meeples Choice Award Nominee'),(11,'2002 Meeples Choice Award Winner'),(1158,'2003 Deutscher Spiele Preis Best Family/Adult Game Winner'),(12,'2004 International Gamers Awards - General Strategy; Multi-player Nominee'),(13,'2004 Meeples Choice Award Nominee'),(14,'2004 Meeples Choice Award Winner'),(16,'2004 Tric Trac d\'Argent'),(15,'2004 Tric Trac Nominee'),(17,'2005 Charles S. Roberts Best Modern Era Boardgame Nominee'),(18,'2005 Charles S. Roberts Best Modern Era Boardgame Winner'),(19,'2005 James F. Dunnigan Award Nominee'),(20,'2005 James F. Dunnigan Award Winner'),(21,'2005 Meeples Choice Award Nominee'),(22,'2005 Spiel des Jahres Recommended'),(23,'2006 Golden Geek Best 2-Player Board Game Nominee'),(1151,'2006 Spiel des Jahres Winner'),(1153,'2007 Deutscher Spiele Preis Best Family/Adult Game Winner'),(24,'2007 Jogo do Ano Nominee'),(25,'2007 Jogo do Ano Winner'),(26,'2007 Meeples Choice Award Nominee'),(27,'2007 Meeples Choice Award Winner'),(28,'2008 Deutscher Spiele Preis Best Family/Adult Game Winner'),(29,'2008 Fairplay À la carte Winner'),(30,'2008 Golden Geek Best 2-Player Board Game Nominee'),(31,'2008 Golden Geek Best Board Game Artwork/Presentation Nominee'),(32,'2008 Golden Geek Best Card Game Nominee'),(33,'2008 Golden Geek Best Family Board Game Nominee'),(34,'2008 Golden Geek Best Gamer\'s Board Game Nominee'),(35,'2008 International Gamers Awards - General Strategy; Multi-player Nominee'),(36,'2008 Jogo do Ano Nominee'),(37,'2008 Meeples Choice Award Nominee'),(38,'2008 Meeples Choice Award Winner'),(39,'2009 Deutscher Spiele Preis Best Family/Adult Game 2nd Place'),(40,'2009 Golden Geek Best 2-Player Board Game Nominee'),(41,'2009 Golden Geek Best Gamer\'s Board Game Winner'),(1150,'2010 International Gamers Award - General Strategy; Multi-player Nominee'),(1160,'2010 Kennerspiel des Jahres Winner'),(42,'2011 Charles S. Roberts Best Science-Fiction or Fantasy Board Wargame Nominee'),(43,'2011 Deutscher Spiele Preis Best Family/Adult Game 2nd Place'),(44,'2011 Golden Geek Best Strategy Board Game Nominee'),(45,'2011 International Gamers Award - General Strategy; Multi-player Nominee'),(46,'2011 Jocul Anului în România Advanced Finalist'),(47,'2011 Jocul Anului în România Advanced Winner'),(48,'2011 Jocul Anului în România Finalist'),(49,'2011 Jocul Anului în România Winner'),(50,'2011 Jogo do Ano Nominee'),(51,'2011 Meeples Choice Award Nominee'),(52,'2011 Meeples Choice Award Winner'),(53,'2012 Charles S. Roberts Best Science-Fiction or Fantasy Board Wargame Nominee'),(54,'2012 ENnie for Best RPG Related Product Nominee'),(55,'2012 ENnie for Best RPG Related Product Silver Winner'),(56,'2012 Golden Geek Best 2-Player Board Game Nominee'),(57,'2012 Golden Geek Best 2-Player Board Game Winner'),(58,'2012 Golden Geek Best Board Game Artwork/Presentation Nominee'),(59,'2012 Golden Geek Best Card Game Nominee'),(60,'2012 Golden Geek Best Card Game Winner'),(61,'2012 Golden Geek Best Family Board Game Nominee'),(62,'2012 Golden Geek Best Strategy Board Game Nominee'),(63,'2012 Golden Geek Best Thematic Board Game Nominee'),(1161,'2012 Golden Geek Best Thematic Board Game Winner'),(64,'2012 Jocul Anului în România Advanced Finalist'),(65,'2012 Jocul Anului în România Advanced Winner'),(66,'2012 Jogo do Ano Nominee'),(67,'2012 Meeples Choice Award Nominee'),(68,'2012 Meeples Choice Award Winner'),(69,'2012 Swiss Gamers Award Winner'),(70,'2013 Board Game Quest Awards Best Production Values Nominee'),(71,'2013 Board Game Quest Awards Best Strategy/Euro Game Nominee'),(72,'2013 Board Game Quest Awards Best Strategy/Euro Game Winner'),(73,'2013 Board Game Quest Awards Game of the Year Nominee'),(74,'2013 Deutscher Spiele Preis Best Family/Adult Game Winner'),(75,'2013 Golden Geek Best Board Game Artwork/Presentation Nominee'),(1155,'2013 Golden Geek Best Strategy Board Game Nominee'),(76,'2013 Jocul Anului în România Advanced Finalist'),(77,'2013 Meeples Choice Award Nominee'),(78,'2013 Meeples Choice Award Winner'),(79,'2014 Board Game Quest Awards Best Production Values Nominee'),(80,'2014 Board Game Quest Awards Best Strategy/Euro Game Nominee'),(81,'2014 Board Game Quest Awards Best Tactical/Combat Game Nominee'),(82,'2014 Board Game Quest Awards Best Tactical/Combat Game Winner'),(83,'2014 Board Game Quest Awards Best Thematic Game Nominee'),(84,'2014 Board Game Quest Awards Game of the Year Nominee'),(85,'2014 Board Game Quest Awards Game of the Year Winner'),(86,'2014 Golden Geek Best 2-Player Board Game Nominee'),(87,'2014 Golden Geek Best Board Game Artwork & Presentation Nominee'),(88,'2014 Golden Geek Best Solo Board Game Nominee'),(89,'2014 Golden Geek Best Strategy Board Game Nominee'),(90,'2014 Golden Geek Best Strategy Board Game Winner'),(91,'2014 Golden Geek Board Game of the Year Nominee'),(92,'2014 Golden Geek Most Innovative Board Game Nominee'),(93,'2014 International Gamers Award - General Strategy: Multi-player Nominee'),(95,'2014 Jogo do Ano Nominee'),(94,'2014 JUG Adult Game of the Year Finalist'),(96,'2014 Meeples Choice Award Nominee'),(97,'2015 Board Game Quest Awards Best Card Game Nominee'),(98,'2015 Board Game Quest Awards Best Card Game Winner'),(99,'2015 Board Game Quest Awards Best Coop Game Nominee'),(100,'2015 Board Game Quest Awards Best Production Values Nominee'),(101,'2015 Board Game Quest Awards Best Strategy/Euro Game Nominee'),(102,'2015 Board Game Quest Awards Best Tactical/Combat Game Nominee'),(103,'2015 Board Game Quest Awards Best Tactical/Combat Game Winner'),(104,'2015 Board Game Quest Awards Best Thematic Game Nominee'),(105,'2015 Board Game Quest Awards Game of the Year Nominee'),(106,'2015 Board Game Quest Awards Game of the Year Winner'),(107,'2015 Cardboard Republic Architect Laurel Nominee'),(108,'2015 Cardboard Republic Immersionist Laurel Nominee'),(109,'2015 Cardboard Republic Immersionist Laurel Winner'),(110,'2015 Cardboard Republic Striker Laurel Nominee'),(111,'2015 Cardboard Republic Tactician Laurel Nominee'),(112,'2015 Cardboard Republic Tactician Laurel Winner'),(113,'2015 Golden Geek Best 2-Player Board Game Nominee'),(114,'2015 Golden Geek Best 2-Player Board Game Winner'),(115,'2015 Golden Geek Best Board Game Artwork/Presentation Nominee'),(116,'2015 Golden Geek Best Card Game Nominee'),(117,'2015 Golden Geek Best Card Game Winner'),(1144,'2015 Golden Geek Best Cooperative Game Winner'),(118,'2015 Golden Geek Best Innovative Board Game Winner'),(119,'2015 Golden Geek Best Solo Board Game Nominee'),(120,'2015 Golden Geek Best Strategy Board Game Nominee'),(121,'2015 Golden Geek Best Thematic Board Game Nominee'),(122,'2015 Golden Geek Board Game of the Year Nominee'),(1145,'2015 Golden Geek Game of the Year Winner'),(123,'2015 Golden Geek Most Innovative Board Game Nominee'),(124,'2015 International Gamers Award - General Strategy: Multi-player Nominee'),(125,'2015 International Gamers Award - General Strategy: Two-players Nominee'),(127,'2015 Jocul Anului în România Advanced Finalist'),(126,'2015 JUG Adult Game of the Year Finalist'),(128,'2015 Kennerspiel des Jahres Recommended'),(129,'2015 Meeples Choice Award Nominee'),(130,'2015 Meeples Choice Award Winner'),(131,'2016 Best Science Fiction or Fantasy Board Game Nominee'),(132,'2016 Board Game Quest Awards Best Coop Game Nominee'),(133,'2016 Board Game Quest Awards Best Coop Game Winner'),(134,'2016 Board Game Quest Awards Best Production Values Nominee'),(135,'2016 Board Game Quest Awards Best Production Values Winner'),(136,'2016 Board Game Quest Awards Best Strategy/Euro Game Nominee'),(137,'2016 Board Game Quest Awards Best Strategy/Euro Game Winner'),(138,'2016 Board Game Quest Awards Best Tactical/Combat Game Nominee'),(139,'2016 Board Game Quest Awards Best Two Player Game Nominee'),(140,'2016 Board Game Quest Awards Best Two Player Game Winner'),(141,'2016 Board Game Quest Awards Game of the Year Nominee'),(142,'2016 Board Game Quest Awards Game of the Year Winner'),(143,'2016 Cardboard Republic Architect Laurel Nominee'),(144,'2016 Cardboard Republic Architect Laurel Winner'),(145,'2016 Cardboard Republic Daredevil Laurel Nominee'),(146,'2016 Cardboard Republic Daredevil Laurel Winner'),(147,'2016 Cardboard Republic Immersionist Laurel Nominee'),(148,'2016 Cardboard Republic Tactician Laurel Nominee'),(149,'2016 Dragon Awards Best Science Fiction or Fantasy Board Game Winner'),(150,'2016 Golden Geek Best 2-Player Board Game Nominee'),(151,'2016 Golden Geek Best Board Game Artwork & Presentation Nominee'),(1148,'2016 Golden Geek Best Board Game Artwork and Presentation Winner'),(152,'2016 Golden Geek Best Card Game Nominee'),(153,'2016 Golden Geek Best Card Game Winner'),(154,'2016 Golden Geek Best Cooperative Game Nominee'),(155,'2016 Golden Geek Best Family Board Game Nominee'),(156,'2016 Golden Geek Best Solo Board Game Nominee'),(157,'2016 Golden Geek Best Strategy Board Game Nominee'),(158,'2016 Golden Geek Best Thematic Board Game Nominee'),(1149,'2016 Golden Geek Best Thematic Board Game Winner'),(159,'2016 Golden Geek Board Game of the Year Nominee'),(160,'2016 Golden Geek Most Innovative Board Game Nominee'),(161,'2016 International Gamers Award - General Strategy: Multi-player Nominee'),(163,'2016 Jocul Anului în România Advanced Finalist'),(164,'2016 Jogo do Ano Nominee'),(162,'2016 JUG Adult Game of the Year Finalist'),(1156,'2016 Kennerspiel des Jahres Nominee'),(165,'2016 SXSW Best Crowdfunded Game of the Year Nominee'),(166,'2017 Best Science Fiction or Fantasy Board Game Nominee'),(167,'2017 Board Game Quest Awards Best Coop Game Nominee'),(168,'2017 Board Game Quest Awards Best Coop Game Winner'),(169,'2017 Board Game Quest Awards Best Game from a Small Publisher Nominee'),(170,'2017 Board Game Quest Awards Best Game from a Small Publisher Winner'),(171,'2017 Board Game Quest Awards Best Production Values Nominee'),(172,'2017 Board Game Quest Awards Best Strategy/Euro Game Nominee'),(173,'2017 Board Game Quest Awards Best Strategy/Euro Game Winner'),(174,'2017 Board Game Quest Awards Best Thematic Game Nominee'),(175,'2017 Board Game Quest Awards Game of the Year Nominee'),(176,'2017 Board Game Quest Awards Game of the Year Winner'),(177,'2017 Cardboard Republic Architect Laurel Nominee'),(178,'2017 Cardboard Republic Architect Laurel Winner'),(179,'2017 Cardboard Republic Striker Laurel Nominee'),(180,'2017 Cardboard Republic Tactician Laurel Nominee'),(181,'2017 Cardboard Republic Tactician Laurel Winner'),(182,'2017 Diana Jones Award for Excellence in Gaming Nominee'),(183,'2017 Golden Geek Best Board Game Artwork & Presentation Nominee'),(184,'2017 Golden Geek Best Cooperative Game Nominee'),(185,'2017 Golden Geek Best Family Board Game Winner'),(186,'2017 Golden Geek Best Solo Board Game Nominee'),(1152,'2017 Golden Geek Best Solo Board Game Winner'),(187,'2017 Golden Geek Best Strategy Board Game Nominee'),(188,'2017 Golden Geek Best Thematic Board Game Nominee'),(189,'2017 Golden Geek Board Game of the Year Nominee'),(190,'2017 Juego del Año Recommended'),(191,'2017 Meeples Choice Award Nominee'),(192,'2017 Meeples Choice Award Winner'),(193,'2017 The Golden Elephant Award Finalist'),(194,'2018 As d\'Or - Jeu de l\'Année Winner'),(195,'2018 Board Game Quest Awards Best Family Game Nominee'),(196,'2018 Board Game Quest Awards Best Production Values Nominee'),(197,'2018 Board Game Quest Awards Best Production Values Winner'),(198,'2018 Board Game Quest Awards Best Strategy/Euro Game Nominee'),(199,'2018 Board Game Quest Awards Game of the Year Winner'),(200,'2018 Cardboard Republic Architect Laurel Nominee'),(201,'2018 Cardboard Republic Architect Laurel Winner'),(202,'2018 Cardboard Republic Daredevil Laurel Nominee'),(203,'2018 Cardboard Republic Daredevil Laurel Winner'),(204,'2018 Cardboard Republic Immersionist Laurel Nominee'),(205,'2018 Cardboard Republic Striker Laurel Winner'),(206,'2018 Goblin Magnifico Nominee'),(207,'2018 Golden Geek Best Board Game Artwork & Presentation Nominee'),(1154,'2018 Golden Geek Best Board Game Artwork and Presentation Winner'),(208,'2018 Golden Geek Best Family Board Game Nominee'),(209,'2018 Golden Geek Best Family Board Game Winner'),(210,'2018 Golden Geek Best Strategy Board Game Nominee'),(211,'2018 Golden Geek Best Strategy Board Game Winner'),(212,'2018 Golden Geek Best Thematic Board Game Nominee'),(213,'2018 Golden Geek Best Thematic Board Game Winner'),(214,'2018 Golden Geek Board Game of the Year Nominee'),(215,'2018 Golden Geek Board Game of the Year Winner'),(216,'2018 Golden Geek Most Innovative Board Game Winner'),(217,'2018 Meeples Choice Award Nominee'),(218,'2018 Origins Awards Best Card Game Nominee'),(219,'2018 Swiss Gamers Award Nominee'),(220,'2018 Swiss Gamers Award Winner'),(221,'2019 5 Seasons Best International Strategy Nominee'),(222,'2019 5 Seasons Best International Strategy Winner'),(223,'2019 Board Game Quest Awards Best Cooperative Game Nominee'),(224,'2019 Board Game Quest Awards Best Cooperative Game Winner'),(225,'2019 Board Game Quest Awards Best Production Values Nominee'),(226,'2019 Board Game Quest Awards Best Production Values Winner'),(227,'2019 Board Game Quest Awards Best Strategy/Euro Game Nominee'),(228,'2019 Board Game Quest Awards Best Strategy/Euro Game Winner'),(229,'2019 Board Game Quest Awards Best Thematic Game Nominee'),(230,'2019 Board Game Quest Awards Best Thematic Game Winner'),(231,'2019 Board Game Quest Awards Game of the Year Nominee'),(232,'2019 Cardboard Republic Architect Laurel Nominee'),(233,'2019 Cardboard Republic Daredevil Laurel Nominee'),(234,'2019 Cardboard Republic Daredevil Laurel Winner'),(235,'2019 Cardboard Republic Immersionist Laurel Nominee'),(236,'2019 Cardboard Republic Immersionist Laurel Winner'),(237,'2019 Cardboard Republic Tactician Laurel Nominee'),(238,'2019 Cardboard Republic Tactician Laurel Winner'),(239,'2019 Deutscher Spiele Preis Best Family/Adult Game Winner'),(240,'2019 Dragon Awards Best Science Fiction or Fantasy Board Game Nominee'),(241,'2019 Goblin Magnifico Winner'),(242,'2019 Golden Geek Best Board Game Artwork & Presentation Nominee'),(243,'2019 Golden Geek Best Card Game Nominee'),(244,'2019 Golden Geek Best Cooperative Game Nominee'),(245,'2019 Golden Geek Best Cooperative Game Winner'),(246,'2019 Golden Geek Best Family Board Game Nominee'),(247,'2019 Golden Geek Best Solo Board Game Nominee'),(248,'2019 Golden Geek Best Strategy Board Game Nominee'),(249,'2019 Golden Geek Best Thematic Board Game Nominee'),(250,'2019 Golden Geek Board Game of the Year Nominee'),(251,'2019 Golden Geek Most Innovative Board Game Nominee'),(252,'2019 Gra Roku Advanced Game of the Year Nominee'),(253,'2019 International Gamers Award - General Strategy: Multi-player Nominee'),(1147,'2019 Kennerspiel des Jahres Winner'),(254,'2019 Meeples Choice Award Nominee'),(255,'2019 Meeples Choice Award Winner'),(256,'2019 Swiss Gamers Award Nominee'),(257,'2020 5 Seasons Best Portuguese Complex Game Nominee'),(258,'2020 5 Seasons Best Portuguese Expansion Nominee'),(259,'2020 5 Seasons Best Solo Mode Nominee'),(260,'2020 American Tabletop Complex Games Nominee'),(261,'2020 American Tabletop Strategy Games Recommended'),(262,'2020 Board Game Quest Awards Best Strategy/Euro Game Nominee'),(263,'2020 Board Game Quest Awards Game of the Year Nominee'),(264,'2020 Board Game Quest Awards Game of the Year Winner'),(265,'2020 Cardboard Republic Daredevil Laurel Nominee'),(266,'2020 Cardboard Republic Immersionist Laurel Nominee'),(267,'2020 Cardboard Republic Tactician Laurel Nominee'),(268,'2020 Charles S. Roberts Best SciFi Fantasy Board Wargame Nominee'),(269,'2020 Charles S. Roberts Best SciFi Fantasy Board Wargame Winner'),(270,'2020 Dragon Awards Best Science Fiction or Fantasy Board Game Nominee'),(271,'2020 Golden Geek Best Board Game Artwork & Presentation Nominee'),(272,'2020 Golden Geek Best Board Game Artwork & Presentation Winner'),(273,'2020 Golden Geek Best Card Game Nominee'),(274,'2020 Golden Geek Best Card Game Winner'),(275,'2020 Golden Geek Best Cooperative Game Nominee'),(276,'2020 Golden Geek Best Cooperative Game Winner'),(277,'2020 Golden Geek Best Solo Board Game Nominee'),(278,'2020 Golden Geek Best Thematic Board Game Nominee'),(279,'2020 Golden Geek Best Thematic Board Game Winner'),(280,'2020 Golden Geek Heavy Game of the Year Nominee'),(281,'2020 Golden Geek Medium Game of the Year Nominee'),(282,'2020 Japan Boardgame Prize Voters\' Selection Nominee'),(283,'2020 Kennerspiel des Jahres Recommended'),(284,'2020 Meeples Choice Award Nominee'),(285,'2021 Board Game Quest Awards Best Card Game Nominee'),(286,'2021 Board Game Quest Awards Best Cooperative Game Nominee'),(287,'2021 Board Game Quest Awards Best Production Values Nominee'),(288,'2021 Board Game Quest Awards Best Thematic Game Nominee'),(289,'2021 Board Game Quest Awards Best Thematic Game Winner'),(290,'2021 Board Game Quest Awards Game of the Year Nominee'),(291,'2021 Board Game Quest Awards Most Innovative Game Nominee'),(292,'2021 Cardboard Republic Architect Laurel Nominee'),(293,'2021 Fairplay À la carte Runner-up'),(294,'2021 Geek Media Awards Game of the Year for Experienced Gamers Nominee'),(295,'2021 Geek Media Awards Game of the Year for Experienced Gamers Winner'),(296,'2021 Golden Geek Best Board Game Artwork & Presentation Nominee'),(297,'2021 Golden Geek Best Cooperative Game Nominee'),(298,'2021 Golden Geek Best Cooperative Game Winner'),(299,'2021 Golden Geek Best Solo Board Game Nominee'),(300,'2021 Golden Geek Heavy Game of the Year Nominee'),(301,'2021 Golden Geek Heavy Game of the Year Winner'),(302,'2021 Golden Geek Light Game of the Year Nominee'),(303,'2021 Golden Geek Light Game of the Year Winner'),(304,'2021 Golden Geek Medium Game of the Year Nominee'),(305,'2021 Golden Geek Medium Game of the Year Winner'),(306,'2021 Gra Roku Best Thematic Game Nominee'),(307,'2021 Kanga Best Gameplay Finalist'),(1146,'2021 Kennerspiel des Jahres Nominee'),(308,'2021 Meeples Choice Award Nominee'),(309,'2021 Meeples Choice Award Winner'),(310,'2022 Board Game Quest Awards Best Cooperative Game Nominee'),(311,'2022 Board Game Quest Awards Best Cooperative Game Winner'),(312,'2022 Board Game Quest Awards Best Game Expansion Nominee'),(313,'2022 Board Game Quest Awards Best Game from a Small Publisher Nominee'),(314,'2022 Board Game Quest Awards Best Production Values Nominee'),(315,'2022 Board Game Quest Awards Best Strategy/Euro Game Nominee'),(316,'2022 Board Game Quest Awards Best Thematic Game Nominee'),(317,'2022 Golden Geek Best 2-Player Board Game Nominee'),(318,'2022 Golden Geek Best Board Game Artwork & Presentation Nominee'),(319,'2022 Golden Geek Best Board Game Expansion Nominee'),(320,'2022 Golden Geek Best Cooperative Game Nominee'),(321,'2022 Golden Geek Best Party Game Nominee'),(322,'2022 Golden Geek Best Thematic Board Game Nominee'),(323,'2022 Golden Geek Best Thematic Board Game Winner'),(324,'2022 Golden Geek Heavy Game of the Year Nominee'),(325,'2022 Golden Geek Medium Game of the Year Nominee'),(326,'2022 Golden Geek Medium Game of the Year Winner'),(327,'2022 Golden Geek Most Innovative Board Game Nominee'),(328,'2022 Meeples Choice Award Nominee'),(329,'2023 5 Seasons Best Portuguese Expert Game Nominee'),(330,'2023 5 Seasons Best Portuguese Expert Game Winner'),(331,'2023 5 Seasons Best Solo Mode Nominee'),(332,'2023 American Tabletop Complex Games Recommended'),(333,'2023 Board Game Quest Awards Best Cooperative Game Nominee'),(334,'2023 Board Game Quest Awards Best Cooperative Game Winner'),(335,'2023 Board Game Quest Awards Best Game from a Small Publisher Nominee'),(336,'2023 Board Game Quest Awards Best Strategy/Euro Game Nominee'),(337,'2023 Board Game Quest Awards Best Strategy/Euro Game Winner'),(338,'2023 Board Game Quest Awards Game of the Year Nominee'),(339,'2023 Geek Media Awards Game of the Year for Experienced Gamers Nominee'),(340,'2023 Goblin Magnifico Nominee'),(341,'2023 Golden Geek Best 2-Player Board Game Nominee'),(342,'2023 Golden Geek Best 2-Player Board Game Winner'),(343,'2023 Golden Geek Best Board Game Artwork & Presentation Nominee'),(344,'2023 Golden Geek Best Cooperative Game Nominee'),(345,'2023 Golden Geek Best Cooperative Game Winner'),(346,'2023 Golden Geek Best Thematic Board Game Nominee'),(347,'2023 Golden Geek Best Thematic Board Game Winner'),(348,'2023 Golden Geek Heavy Game of the Year Nominee'),(349,'2023 Golden Geek Medium Game of the Year Nominee'),(350,'2023 Golden Geek Most Innovative Board Game Nominee'),(351,'2023 International Gamers Award Multi-player Nominee'),(352,'2023 International Gamers Award Multi-player Winner'),(353,'2023 International Gamers Award Two-player Nominee'),(354,'2023 Japan Boardgame Prize Voters\' Selection Nominee'),(355,'2023 Meeples Choice Award Nominee'),(356,'2023 Meeples Choice Award Winner'),(357,'2023 Origins Awards Best Heavy Strategy Game Winner'),(358,'2024 American Tabletop Complex Games Nominee'),(359,'2024 Board Game Quest Awards Best Casual Game Nominee'),(360,'2024 Board Game Quest Awards Best Cooperative Game Nominee'),(361,'2024 Board Game Quest Awards Best Cooperative Game Winner'),(362,'2024 Board Game Quest Awards Best Strategy/Euro Game Nominee'),(363,'2024 Board Game Quest Awards Best Strategy/Euro Game Winner'),(364,'2024 Board Game Quest Awards Game of the Year Nominee'),(365,'2024 Geek Media Awards Family Game of the Year Nominee'),(366,'2024 Golden Geek Best 2-Player Board Game Nominee'),(367,'2024 Golden Geek Best 2-Player Board Game Winner'),(368,'2024 Golden Geek Best Board Game Artwork & Presentation Nominee'),(369,'2024 Golden Geek Best Cooperative Game Nominee'),(370,'2024 Golden Geek Best Solo Board Game Nominee'),(371,'2024 Golden Geek Best Solo Board Game Winner'),(372,'2024 Golden Geek Best Thematic Board Game Nominee'),(373,'2024 Golden Geek Best Thematic Board Game Winner'),(374,'2024 Golden Geek Medium Game of the Year Nominee'),(375,'2024 Golden Geek Medium Game of the Year Winner'),(376,'2024 Gra Roku Advanced Game of the Year Nominee'),(377,'2024 Gra Roku Best Adventure Game Nominee'),(378,'2024 Gra Roku Expert Game of the Year Nominee'),(379,'2024 Guldbrikken Best Adult Game Nominee'),(380,'2024 Kennerspiel des Jahres Nominee'),(381,'2024 Spiel des Jahres Recommended');
/*!40000 ALTER TABLE `awards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `boardgames`
--

DROP TABLE IF EXISTS `boardgames`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `boardgames` (
  `game_id` int NOT NULL AUTO_INCREMENT,
  `rank_position` int NOT NULL,
  `title` varchar(255) NOT NULL,
  `bgg_url` varchar(500) NOT NULL,
  `year_published` smallint DEFAULT NULL,
  `geek_rating` decimal(4,3) DEFAULT NULL,
  `avg_rating` decimal(4,3) DEFAULT NULL,
  `users_voted` int DEFAULT NULL,
  `min_players` tinyint unsigned DEFAULT NULL,
  `max_players` tinyint unsigned DEFAULT NULL,
  `min_playtime` smallint unsigned DEFAULT NULL,
  `max_playtime` smallint unsigned DEFAULT NULL,
  `min_age` tinyint unsigned DEFAULT NULL,
  `complexity_rating` decimal(3,2) DEFAULT NULL,
  `community_owned` int unsigned DEFAULT '0',
  `community_wishlist` int unsigned DEFAULT '0',
  `num_comments` int unsigned DEFAULT '0',
  `num_plays` int unsigned DEFAULT '0',
  `fans` int unsigned DEFAULT '0',
  PRIMARY KEY (`game_id`),
  UNIQUE KEY `rank_position` (`rank_position`),
  UNIQUE KEY `bgg_url` (`bgg_url`),
  KEY `idx_boardgames_rank` (`rank_position`),
  KEY `idx_boardgames_year` (`year_published`),
  KEY `idx_boardgames_rating` (`geek_rating`),
  KEY `idx_boardgames_complexity` (`complexity_rating`),
  KEY `idx_boardgames_players` (`min_players`,`max_players`),
  FULLTEXT KEY `ft_boardgames_title` (`title`),
  CONSTRAINT `chk_avg_rating_range` CHECK (((`avg_rating` >= 0) and (`avg_rating` <= 10))),
  CONSTRAINT `chk_complexity_range` CHECK (((`complexity_rating` >= 0) and (`complexity_rating` <= 5))),
  CONSTRAINT `chk_players` CHECK ((`min_players` <= `max_players`)),
  CONSTRAINT `chk_playtime` CHECK ((`min_playtime` <= `max_playtime`)),
  CONSTRAINT `chk_rating_range` CHECK (((`geek_rating` >= 0) and (`geek_rating` <= 10))),
  CONSTRAINT `chk_year` CHECK (((`year_published` >= 1800) and (`year_published` <= 2030)))
) ENGINE=InnoDB AUTO_INCREMENT=401 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `boardgames`
--

LOCK TABLES `boardgames` WRITE;
/*!40000 ALTER TABLE `boardgames` DISABLE KEYS */;
INSERT INTO `boardgames` (`game_id`, `rank_position`, `title`, `bgg_url`, `year_published`, `geek_rating`, `avg_rating`, `users_voted`, `min_players`, `max_players`, `min_playtime`, `max_playtime`, `min_age`, `complexity_rating`, `community_owned`, `community_wishlist`, `num_comments`, `num_plays`, `fans`) VALUES (1,1,'Brass: Birmingham','https://boardgamegeek.com/boardgame/224517/brass-birmingham',2018,8.401,8.580,53240,2,4,60,120,14,3.87,75797,20216,7312,151523,6665),(2,2,'Pandemic Legacy: Season 1','https://boardgamegeek.com/boardgame/161936/pandemic-legacy-season-1',2015,8.359,8.510,55990,2,4,60,60,13,2.83,87236,14443,8363,301052,4211),(3,3,'Ark Nova','https://boardgamegeek.com/boardgame/342942/ark-nova',2021,8.351,8.540,54111,1,4,90,150,14,3.79,78953,15979,7159,521868,7390),(4,4,'Gloomhaven','https://boardgamegeek.com/boardgame/174430/gloomhaven',2017,8.320,8.560,65334,1,4,60,120,14,3.92,101771,21555,11383,541419,10762),(5,5,'Twilight Imperium: Fourth Edition','https://boardgamegeek.com/boardgame/233078/twilight-imperium-fourth-edition',2017,8.227,8.570,26565,3,6,240,480,14,4.33,31882,12406,3956,49146,3520),(6,6,'Dune: Imperium','https://boardgamegeek.com/boardgame/316554/dune-imperium',2020,8.225,8.420,53709,1,4,60,120,14,3.07,72249,14722,7031,209475,6351),(7,7,'Terraforming Mars','https://boardgamegeek.com/boardgame/167791/terraforming-mars',2016,8.198,8.350,107669,1,5,120,120,12,3.27,150814,25658,15162,736835,11923),(8,8,'War of the Ring: Second Edition','https://boardgamegeek.com/boardgame/115746/war-of-the-ring-second-edition',2011,8.193,8.550,23631,2,4,150,240,13,4.22,39079,12374,4052,42226,3395),(9,9,'Star Wars: Rebellion','https://boardgamegeek.com/boardgame/187645/star-wars-rebellion',2016,8.169,8.420,34893,2,4,180,240,14,3.75,54743,14427,5231,55175,3782),(10,10,'Dune: Imperium – Uprising','https://boardgamegeek.com/boardgame/397598/dune-imperium-uprising',2023,8.152,8.710,13176,1,6,60,120,13,3.50,21019,6500,1762,38826,2290),(11,11,'Spirit Island','https://boardgamegeek.com/boardgame/162886/spirit-island',2017,8.142,8.340,58600,1,4,90,120,13,4.08,89976,23713,9016,387679,7715),(12,12,'Gloomhaven: Jaws of the Lion','https://boardgamegeek.com/boardgame/291457/gloomhaven-jaws-of-the-lion',2020,8.120,8.380,38491,1,4,30,120,14,3.64,83527,8847,5514,193821,4111),(13,13,'Gaia Project','https://boardgamegeek.com/boardgame/220308/gaia-project',2017,8.095,8.360,29763,1,4,60,150,12,4.40,36629,12423,4200,124859,2951),(14,14,'Twilight Struggle','https://boardgamegeek.com/boardgame/12333/twilight-struggle',2005,8.051,8.240,50822,2,2,120,180,13,3.61,71645,12770,10380,133106,5361),(15,15,'Through the Ages: A New Story of Civilization','https://boardgamegeek.com/boardgame/182028/through-the-ages-a-new-story-of-civilization',2015,8.031,8.260,33661,2,4,120,120,14,4.44,38914,9872,4980,144558,2573),(16,16,'The Castles of Burgundy','https://boardgamegeek.com/boardgame/84876/the-castles-of-burgundy',2011,8.022,8.150,66601,2,4,30,90,12,2.97,81345,13356,10120,407928,4610),(17,17,'Great Western Trail','https://boardgamegeek.com/boardgame/193738/great-western-trail',2016,7.994,8.170,42749,2,4,75,150,12,3.70,46316,9964,5493,152784,2607),(18,18,'Eclipse: Second Dawn for the Galaxy','https://boardgamegeek.com/boardgame/246900/eclipse-second-dawn-for-the-galaxy',2020,7.966,8.410,15923,2,6,60,200,14,3.65,20517,8557,2222,32584,2225),(19,19,'Scythe','https://boardgamegeek.com/boardgame/169786/scythe',2016,7.964,8.120,89589,1,5,90,115,14,3.45,122637,25363,13156,327321,10353),(20,20,'Brass: Lancashire','https://boardgamegeek.com/boardgame/28720/brass-lancashire',2007,7.961,8.200,26348,2,4,60,120,14,3.85,34492,6210,5372,80146,2167),(21,21,'7 Wonders Duel','https://boardgamegeek.com/boardgame/173346/7-wonders-duel',2015,7.961,8.090,103411,2,2,30,30,10,2.23,173887,11670,13538,601534,6407),(22,22,'Frosthaven','https://boardgamegeek.com/boardgame/295770/frosthaven',2022,7.957,8.770,8942,1,4,90,180,14,4.41,22105,6161,1972,100835,2534),(23,23,'Nemesis','https://boardgamegeek.com/boardgame/167355/nemesis',2018,7.949,8.250,34638,1,5,90,180,12,3.48,46840,14733,5233,82513,5432),(24,24,'Clank! Legacy: Acquisitions Incorporated','https://boardgamegeek.com/boardgame/266507/clank-legacy-acquisitions-incorporated',2019,7.944,8.510,10633,2,4,90,120,13,2.74,18438,6507,1641,62685,1072),(25,25,'A Feast for Odin','https://boardgamegeek.com/boardgame/177736/a-feast-for-odin',2016,7.944,8.170,31570,1,4,30,120,12,3.86,41290,15735,4829,122628,2719),(26,26,'Concordia','https://boardgamegeek.com/boardgame/124361/concordia',2013,7.932,8.080,43307,2,5,100,100,13,2.99,49473,12130,6687,143989,2682),(27,27,'Great Western Trail: Second Edition','https://boardgamegeek.com/boardgame/341169/great-western-trail-second-edition',2021,7.905,8.290,15983,1,4,75,150,12,3.71,23078,4926,1725,59074,1280),(28,28,'Lost Ruins of Arnak','https://boardgamegeek.com/boardgame/312484/lost-ruins-of-arnak',2020,7.902,8.070,51641,1,4,30,120,12,2.93,78211,14910,6384,282899,5074),(29,29,'Arkham Horror: The Card Game','https://boardgamegeek.com/boardgame/205637/arkham-horror-the-card-game',2016,7.898,8.130,46113,1,2,60,120,14,3.56,80986,11110,7141,346044,6137),(30,30,'Root','https://boardgamegeek.com/boardgame/237182/root',2018,7.884,8.070,59069,2,4,60,90,14,3.83,92658,22735,8579,213669,7992),(31,31,'Too Many Bones','https://boardgamegeek.com/boardgame/192135/too-many-bones',2017,7.873,8.320,15798,1,4,60,120,12,3.86,24207,12539,2712,79934,3557),(32,32,'Terra Mystica','https://boardgamegeek.com/boardgame/120677/terra-mystica',2012,7.869,8.040,49867,2,5,60,150,12,3.98,53906,14150,7190,169864,4203),(33,33,'The Lord of the Rings: Duel for Middle-earth','https://boardgamegeek.com/boardgame/421006/the-lord-of-the-rings-duel-for-middle-earth',2024,7.869,8.380,12424,2,2,30,45,10,2.07,27405,5762,1668,48839,2270),(34,34,'Sky Team','https://boardgamegeek.com/boardgame/373106/sky-team',2023,7.865,8.150,22975,2,2,20,20,10,2.05,47578,9183,2705,230741,2837),(35,35,'Wingspan','https://boardgamegeek.com/boardgame/266192/wingspan',2019,7.863,8.010,105205,1,5,40,70,10,2.47,166417,20615,14012,764745,10302),(36,36,'Orléans','https://boardgamegeek.com/boardgame/164928/orleans',2014,7.861,8.050,34037,2,5,90,90,12,3.01,41389,9212,4799,115502,2123),(37,37,'Slay the Spire: The Board Game','https://boardgamegeek.com/boardgame/338960/slay-the-spire-the-board-game',2024,7.844,8.690,7870,1,4,30,150,12,2.92,13363,7096,1372,44256,2200),(38,38,'Mage Knight Board Game','https://boardgamegeek.com/boardgame/96848/mage-knight-board-game',2011,7.842,8.080,34459,1,4,60,240,14,4.37,47163,12695,6568,79721,5107),(39,39,'Barrage','https://boardgamegeek.com/boardgame/251247/barrage',2019,7.841,8.150,20115,1,4,90,180,14,4.12,24436,7086,2856,72222,1832),(40,40,'SETI: Search for Extraterrestrial Intelligence','https://boardgamegeek.com/boardgame/418059/seti-search-for-extraterrestrial-intelligence',2024,7.833,8.390,11325,1,4,40,160,14,3.78,18746,8077,1528,39882,2775),(41,41,'Everdell','https://boardgamegeek.com/boardgame/199792/everdell',2018,7.822,8.000,63158,1,4,40,80,10,2.82,96346,21964,7982,253182,7413),(42,42,'The Crew: Mission Deep Sea','https://boardgamegeek.com/boardgame/324856/the-crew-mission-deep-sea',2021,7.821,8.080,22490,2,5,20,20,10,2.04,45153,6332,2857,271387,1440),(43,43,'Viticulture Essential Edition','https://boardgamegeek.com/boardgame/183394/viticulture-essential-edition',2015,7.819,7.970,52759,1,6,45,90,13,2.89,74188,13081,6945,190689,3397),(44,44,'Hegemony: Lead Your Class to Victory','https://boardgamegeek.com/boardgame/321608/hegemony-lead-your-class-to-victory',2023,7.807,8.420,10068,2,4,90,180,14,4.22,16268,6219,1658,21199,2234),(45,45,'Heat: Pedal to the Metal','https://boardgamegeek.com/boardgame/366013/heat-pedal-to-the-metal',2022,7.796,8.020,34052,1,6,30,60,10,2.20,49828,13617,4189,200168,4217),(46,46,'Marvel Champions: The Card Game','https://boardgamegeek.com/boardgame/285774/marvel-champions-the-card-game',2019,7.792,8.110,26272,1,4,45,90,14,2.95,45243,6057,3572,582965,3501),(47,47,'Crokinole','https://boardgamegeek.com/boardgame/521/crokinole',1876,7.791,8.060,19963,2,4,30,30,8,1.22,19249,6695,3713,239119,1050),(48,48,'Kanban EV','https://boardgamegeek.com/boardgame/284378/kanban-ev',2020,7.788,8.390,9219,1,4,60,180,14,4.30,15233,5901,1452,23280,1998),(49,49,'Food Chain Magnate','https://boardgamegeek.com/boardgame/175914/food-chain-magnate',2015,7.780,8.040,21966,2,5,120,240,14,4.19,26721,10429,3770,56146,1922),(50,50,'Underwater Cities','https://boardgamegeek.com/boardgame/247763/underwater-cities',2018,7.776,8.050,21667,1,4,80,150,12,3.58,28419,8244,3021,83530,1554),(51,51,'Pax Pamir: Second Edition','https://boardgamegeek.com/boardgame/256960/pax-pamir-second-edition',2019,7.775,8.140,16302,1,5,45,120,13,3.85,23173,6617,2775,65746,1892),(52,52,'Puerto Rico','https://boardgamegeek.com/boardgame/3076/puerto-rico',2002,7.761,7.900,72968,3,5,90,150,12,3.27,83668,9941,13111,202785,4439),(53,53,'Cthulhu: Death May Die','https://boardgamegeek.com/boardgame/253344/cthulhu-death-may-die',2019,7.755,8.190,15359,1,5,90,120,14,2.49,26157,7584,2388,65181,2482),(54,54,'Cascadia','https://boardgamegeek.com/boardgame/295947/cascadia',2021,7.751,7.910,48946,1,4,30,45,10,1.85,81620,14256,6131,311298,4736),(55,55,'Caverna: The Cave Farmers','https://boardgamegeek.com/boardgame/102794/caverna-the-cave-farmers',2013,7.744,7.930,36445,1,7,30,210,12,3.77,47156,11821,5798,90903,2509),(56,56,'Pandemic Legacy: Season 0','https://boardgamegeek.com/boardgame/314040/pandemic-legacy-season-0',2020,7.744,8.360,8885,2,4,45,60,14,3.16,19685,4076,1267,65110,576),(57,57,'On Mars','https://boardgamegeek.com/boardgame/184267/on-mars',2020,7.744,8.170,14019,1,4,90,150,14,4.63,21824,8197,2277,36981,2951),(58,58,'Anachrony','https://boardgamegeek.com/boardgame/185343/anachrony',2017,7.742,8.050,20499,1,4,30,120,15,4.00,25783,8680,3350,54495,3353),(59,59,'Blood Rage','https://boardgamegeek.com/boardgame/170216/blood-rage',2015,7.735,7.910,50050,2,4,60,90,14,2.88,59998,13874,7368,110834,4021),(60,60,'Agricola','https://boardgamegeek.com/boardgame/31260/agricola',2007,7.734,7.860,75177,1,5,30,150,12,3.63,88462,12743,14067,287408,6818),(61,61,'Age of Innovation','https://boardgamegeek.com/boardgame/383179/age-of-innovation',2023,7.732,8.520,6995,1,5,40,200,14,4.26,9605,4058,982,23005,1133),(62,62,'Oathsworn: Into the Deepwood','https://boardgamegeek.com/boardgame/251661/oathsworn-into-the-deepwood',2022,7.724,8.830,6130,1,4,30,90,14,3.68,11972,5875,1638,35705,2583),(63,63,'Lisboa','https://boardgamegeek.com/boardgame/161533/lisboa',2017,7.712,8.180,12199,1,4,60,120,12,4.57,18093,6540,2188,31104,1431),(64,64,'Sleeping Gods','https://boardgamegeek.com/boardgame/255984/sleeping-gods',2021,7.710,8.130,14509,1,4,60,120,13,3.25,33239,16287,2781,46522,3420),(65,65,'Obsession','https://boardgamegeek.com/boardgame/231733/obsession',2018,7.708,8.090,15917,1,4,30,90,14,3.10,22514,8488,2927,86077,2230),(66,66,'Grand Austria Hotel','https://boardgamegeek.com/boardgame/182874/grand-austria-hotel',2015,7.707,7.960,23433,2,4,60,120,12,3.20,30331,6863,3606,115721,1547),(67,67,'Pandemic Legacy: Season 2','https://boardgamegeek.com/boardgame/221107/pandemic-legacy-season-2',2017,7.702,8.020,17794,2,4,60,60,14,3.25,34005,4771,2773,128494,808),(68,68,'Clank!: Catacombs','https://boardgamegeek.com/boardgame/365717/clank-catacombs',2022,7.698,8.250,10366,2,4,45,90,13,2.50,18492,5571,1423,40154,1242),(69,69,'Mansions of Madness: Second Edition','https://boardgamegeek.com/boardgame/205059/mansions-of-madness-second-edition',2016,7.691,7.930,38862,1,5,120,180,14,2.70,62993,13404,5227,100018,3787),(70,70,'Tzolk\'in: The Mayan Calendar','https://boardgamegeek.com/boardgame/126163/tzolkin-the-mayan-calendar',2012,7.688,7.850,41243,2,4,90,90,13,3.66,48850,9503,5938,130841,2267),(71,71,'Power Grid','https://boardgamegeek.com/boardgame/2651/power-grid',2004,7.686,7.800,67965,2,6,120,120,12,3.25,84247,12071,11921,161828,3949),(72,72,'Harmonies','https://boardgamegeek.com/boardgame/414317/harmonies',2024,7.678,8.030,19311,1,4,30,45,10,2.00,32199,8026,2319,190587,3035),(73,73,'Quacks','https://boardgamegeek.com/boardgame/244521/quacks',2018,7.671,7.810,55611,2,4,45,45,10,1.94,87781,12415,7286,277028,3382),(74,74,'Clans of Caledonia','https://boardgamegeek.com/boardgame/216132/clans-of-caledonia',2017,7.669,7.930,21573,1,4,30,120,12,3.47,22606,7299,3208,78163,1557),(75,75,'Paladins of the West Kingdom','https://boardgamegeek.com/boardgame/266810/paladins-of-the-west-kingdom',2019,7.667,7.960,19512,1,4,90,120,12,3.72,31492,6195,2768,59053,1612),(76,76,'Le Havre','https://boardgamegeek.com/boardgame/35677/le-havre',2008,7.665,7.840,33070,1,5,30,150,12,3.71,38883,9933,6218,89447,2133),(77,77,'The Gallerist','https://boardgamegeek.com/boardgame/125153/the-gallerist',2015,7.665,8.010,15801,1,4,60,150,13,4.22,21396,6632,2573,38456,1385),(78,78,'Ticket to Ride Legacy: Legends of the West','https://boardgamegeek.com/boardgame/390092/ticket-to-ride-legacy-legends-of-the-west',2023,7.662,8.670,5193,2,5,20,90,10,2.58,12749,3564,781,61226,751),(79,79,'Maracaibo','https://boardgamegeek.com/boardgame/276025/maracaibo',2019,7.661,7.970,17906,1,4,30,120,12,3.91,24147,6552,2647,71059,1410),(80,80,'Star Wars: Imperial Assault','https://boardgamegeek.com/boardgame/164153/star-wars-imperial-assault',2014,7.659,7.960,25449,2,5,60,120,14,3.30,44151,7437,3929,96676,3397),(81,81,'Android: Netrunner','https://boardgamegeek.com/boardgame/124742/android-netrunner',2012,7.657,7.890,30906,2,2,45,45,14,3.41,46805,5821,6415,352873,4393),(82,82,'Agricola (Revised Edition)','https://boardgamegeek.com/boardgame/200680/agricola-revised-edition',2016,7.647,7.950,19999,1,4,30,120,12,3.44,27606,3896,2590,66810,1232),(83,83,'The White Castle','https://boardgamegeek.com/boardgame/371942/the-white-castle',2023,7.645,7.990,17425,1,4,80,80,12,3.04,30956,6416,2248,98483,2550),(84,84,'Mechs vs. Minions','https://boardgamegeek.com/boardgame/209010/mechs-vs-minions',2016,7.640,7.960,18002,2,4,60,120,14,2.45,24794,8307,2834,67874,1405),(85,85,'The Crew: The Quest for Planet Nine','https://boardgamegeek.com/boardgame/284083/the-crew-the-quest-for-planet-nine',2019,7.632,7.770,45991,2,5,20,20,10,1.96,88188,5922,6049,618229,1926),(86,86,'Kingdom Death: Monster','https://boardgamegeek.com/boardgame/55690/kingdom-death-monster',2015,7.628,8.480,10125,1,4,60,180,17,4.27,13447,7349,2268,56413,3355),(87,87,'Race for the Galaxy','https://boardgamegeek.com/boardgame/28143/race-for-the-galaxy',2007,7.622,7.740,57619,2,4,30,60,12,2.99,72287,11299,11379,759260,4278),(88,88,'Azul','https://boardgamegeek.com/boardgame/230802/azul',2017,7.618,7.730,101295,2,4,30,45,8,1.77,168475,15289,12622,812685,5903),(89,89,'Blood on the Clocktower','https://boardgamegeek.com/boardgame/240980/blood-on-the-clocktower',2022,7.617,8.370,8773,6,21,30,120,15,3.04,8794,5893,1679,101472,1754),(90,90,'Great Western Trail: New Zealand','https://boardgamegeek.com/boardgame/380607/great-western-trail-new-zealand',2023,7.616,8.510,5608,1,4,75,150,12,4.00,10137,2244,772,17291,547),(91,91,'Five Tribes: The Djinns of Naqala','https://boardgamegeek.com/boardgame/157354/five-tribes-the-djinns-of-naqala',2014,7.615,7.770,43861,2,4,40,80,13,2.84,57711,11383,6455,136987,2307),(92,92,'Revive','https://boardgamegeek.com/boardgame/332772/revive',2022,7.614,8.100,10818,1,4,90,120,14,3.45,16191,6258,1421,46110,1531),(93,93,'Darwin\'s Journey','https://boardgamegeek.com/boardgame/322289/darwins-journey',2023,7.606,8.120,10350,1,4,60,120,14,3.90,14830,4659,1546,43257,1567),(94,94,'Clank!: A Deck-Building Adventure','https://boardgamegeek.com/boardgame/201808/clank-a-deck-building-adventure',2016,7.605,7.770,45503,2,4,30,60,12,2.23,59665,12169,5889,168602,2873),(95,95,'Fields of Arle','https://boardgamegeek.com/boardgame/159675/fields-of-arle',2014,7.602,8.030,11893,1,2,60,120,13,3.85,18041,6233,2207,37388,924),(96,96,'Wingspan Asia','https://boardgamegeek.com/boardgame/366161/wingspan-asia',2022,7.601,8.240,8548,1,2,40,70,10,2.67,30087,3403,1196,25200,734),(97,97,'Eclipse: New Dawn for the Galaxy','https://boardgamegeek.com/boardgame/72125/eclipse-new-dawn-for-the-galaxy',2011,7.599,7.820,28827,2,6,60,180,14,3.71,28227,6827,5130,55545,3052),(98,98,'Aeon\'s End','https://boardgamegeek.com/boardgame/191189/aeons-end',2016,7.593,7.880,22798,1,4,60,60,14,2.81,33227,8352,3545,129448,2440),(99,99,'El Grande','https://boardgamegeek.com/boardgame/93/el-grande',1995,7.589,7.770,31522,2,5,60,120,12,2.94,33173,7371,6345,63088,1388),(100,100,'Lords of Waterdeep','https://boardgamegeek.com/boardgame/110327/lords-of-waterdeep',2012,7.587,7.730,57927,2,5,60,120,12,2.45,72897,11111,9502,189766,4137);
/*!40000 ALTER TABLE `boardgames` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=229 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` (`category_id`, `name`) VALUES (1,'Abstract Strategy'),(2,'Action / Dexterity'),(3,'Adventure'),(4,'Age of Reason'),(5,'American West'),(6,'Ancient'),(7,'Animals'),(8,'Arabian'),(9,'Aviation / Flight'),(10,'Bluffing'),(11,'Card Game'),(12,'City Building'),(13,'Civil War'),(14,'Civilization'),(15,'Collectible Components'),(16,'Comic Book / Strip'),(169,'Cooperative'),(17,'Deduction'),(18,'Dice'),(19,'Economic'),(20,'Educational'),(21,'Environmental'),(22,'Exploration'),(23,'Fantasy'),(24,'Farming'),(25,'Fighting'),(26,'Horror'),(27,'Industry / Manufacturing'),(170,'Legacy'),(28,'Mature / Adult'),(29,'Medical'),(30,'Medieval'),(31,'Miniatures'),(32,'Modern Warfare'),(33,'Movies / TV / Radio theme'),(34,'Murder / Mystery'),(35,'Mythology'),(36,'Nautical'),(37,'Negotiation'),(38,'Novel-based'),(39,'Party Game'),(40,'Pirates'),(41,'Political'),(42,'Post-Napoleonic'),(43,'Puzzle'),(44,'Racing'),(45,'Religious'),(46,'Renaissance'),(47,'Science Fiction'),(48,'Space Exploration'),(49,'Spies / Secret Agents'),(50,'Sports'),(51,'Territory Building'),(52,'Trains'),(53,'Transportation'),(54,'Travel'),(55,'Video Game Theme'),(56,'Wargame');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `designers`
--

DROP TABLE IF EXISTS `designers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `designers` (
  `designer_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`designer_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=439 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `designers`
--

LOCK TABLES `designers` WRITE;
/*!40000 ALTER TABLE `designers` DISABLE KEYS */;
INSERT INTO `designers` (`designer_id`, `name`) VALUES (1,'(Uncredited)'),(2,'Adam Carlson'),(3,'Adam Kwapiński'),(4,'Adam Poots'),(5,'Alan R. Moon'),(6,'Alan Stone'),(7,'Alexander Pfister'),(8,'Ananda Gupta'),(9,'Andreas Seyfarth'),(324,'Andreas Steding'),(10,'Andy Clautice'),(11,'Anna Wermlund'),(12,'Anthony Giovannetti'),(13,'Antoine Bauza'),(14,'Asger Harding Granerud'),(15,'Bruno Cathala'),(16,'Caleb Grace'),(17,'Casey Yano'),(18,'Chris Cantrell'),(19,'Christian T. Petersen'),(20,'Cole Wehrle'),(21,'Corey Konieczka'),(22,'Dan Hallagan'),(23,'Dane Beltrami'),(24,'Daniel Skjold Pedersen'),(25,'Daniele Tascini'),(26,'Dávid Turczi'),(27,'Eilif Svensson'),(28,'Elizabeth Hargrave'),(29,'Elwen'),(30,'Eric M. Lang'),(31,'Francesco Nepitello'),(32,'Friedemann Friese'),(33,'Gary Dworetsky'),(34,'Gavan Brown'),(35,'Helge Meissner'),(36,'Helge Ostertag'),(326,'Ignacy Trzewiczek'),(37,'Isaac Childres'),(38,'Isra C.'),(39,'Jacob Fryxelius'),(40,'James A. Wilson'),(41,'Jamey Stegmaier'),(42,'Jamie Jolly'),(43,'Jason Matthews'),(44,'Jenny Iglesias'),(45,'Jens Drögemüller'),(46,'Jeroen Doumen'),(47,'Johan Benvenuto'),(48,'Jonathan Ying'),(49,'Joris Wiersinga'),(50,'Josh J. Carlson'),(51,'Juma Al-JouJou'),(52,'Justin Kemppainen'),(53,'Kevin Riley'),(325,'Klaus Teuber'),(54,'Kristian Amundsen Østby'),(55,'Luc Rémond'),(56,'Lukas Litzsinger'),(58,'Mac Gerdts'),(59,'Marco Maggi'),(60,'Martin Wallace'),(61,'Mathias Wigge'),(62,'Matt Leacock'),(63,'Matt Tolman'),(64,'Michael Boggs'),(65,'Michael Kiesling'),(66,'Mín'),(57,'MJ Newman'),(67,'Nate French'),(68,'Nathan Tiras'),(69,'Nestore Mangone'),(70,'Nick Little (I)'),(71,'Nikki Valens'),(72,'Paul Dennen'),(73,'Peter Lee'),(74,'Prashant Saraswat'),(75,'R. Eric Reuss'),(76,'Randy Flynn'),(323,'Reiner Knizia'),(77,'Reiner Stockhausen'),(80,'Richard Ámann'),(78,'Richard Garfield'),(79,'Richard Ulrich'),(81,'Rick Ernst'),(82,'Rob Daviau'),(83,'Roberto Di Meglio'),(84,'Rodney Thompson'),(85,'Ryan Laukat'),(86,'S J Macdonald'),(87,'Shei S.'),(88,'Shem Phillips'),(89,'Simone Luciani'),(90,'Stefan Feld'),(91,'Steven Medway'),(92,'Stone Librande'),(93,'Thomas Lehmann'),(94,'Thomas Sing'),(96,'Tomáš Holek'),(95,'Tommaso Battista'),(322,'Tony Fanchi'),(97,'Touko Tahkokallio'),(98,'Uwe Rosenberg'),(99,'Vangelis Bagiartakis'),(100,'Varnavas Timotheou'),(101,'Viktor Péter'),(102,'Virginio Gigli'),(103,'Vital Lacerda'),(104,'Vlaada Chvátil'),(105,'Vladimír Suchý'),(106,'Wolfgang Kramer'),(107,'Wolfgang Warsch');
/*!40000 ALTER TABLE `designers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `families`
--

DROP TABLE IF EXISTS `families`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `families` (
  `family_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`family_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=919 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `families`
--

LOCK TABLES `families` WRITE;
/*!40000 ALTER TABLE `families` DISABLE KEYS */;
INSERT INTO `families` (`family_id`, `name`) VALUES (678,'7 Wonders'),(1,'Admin: Better Description Needed!'),(667,'Age of Steam'),(675,'Alhambra'),(2,'Ancient: Babylon'),(3,'Ancient: Egypt'),(4,'Ancient: Greece'),(5,'Ancient: Rome'),(6,'Animals: Badgers'),(7,'Animals: Bats'),(8,'Animals: Bears'),(9,'Animals: Beavers'),(10,'Animals: Birds'),(11,'Animals: Camels'),(12,'Animals: Cats'),(13,'Animals: Cattle / Cows'),(14,'Animals: Chickens / Roosters'),(15,'Animals: Crows / Ravens / Magpies'),(16,'Animals: Dogs'),(17,'Animals: Donkeys'),(18,'Animals: Ducks'),(19,'Animals: Eagles'),(20,'Animals: Fish / Fishes'),(21,'Animals: Foxes'),(22,'Animals: Geese'),(23,'Animals: Hedgehogs / Porcupines'),(24,'Animals: Horses'),(25,'Animals: Lizards'),(26,'Animals: Mice'),(664,'Animals: Miscellaneous'),(27,'Animals: Moose / Elk'),(28,'Animals: Okapi'),(29,'Animals: Owls'),(30,'Animals: Pigs'),(31,'Animals: Rabbits / Hares'),(32,'Animals: Sheep'),(33,'Animals: Wild boar'),(34,'Authors: J.R.R. Tolkien'),(35,'Books: Dune'),(36,'Brands: Restaurants'),(661,'Brass'),(677,'Catan'),(37,'Category: Autonomous simulation'),(38,'Category: Combinatorial'),(39,'Category: Dized Tutorial'),(40,'Category: Dungeon Crawler'),(41,'Category: Two-Player Fighting Games'),(42,'Cities: Birmingham (England)'),(43,'Cities: Kansas City (Missouri, USA)'),(44,'Cities: Le Havre (France)'),(45,'Cities: Lisbon (Portugal)'),(46,'Cities: Manchester (England, UK)'),(47,'Cities: Maracaibo (Venezuela)'),(48,'Cities: Orléans (France)'),(49,'Cities: Vienna (Austria)'),(50,'Collectible: Living Card Game (Fantasy Flight Games)'),(51,'Comic Books: Marvel Universe'),(52,'Components:  Meeples'),(53,'Components: 3-Dimensional (3D)'),(54,'Components: 4 x 4 Grids'),(55,'Components: 5 x 5 Grids'),(56,'Components: Book as Board'),(57,'Components: Calendars'),(58,'Components: Clix'),(59,'Components: Control Boards'),(60,'Components: Dice with Icons'),(61,'Components: Digital Hybrid – App/Website Required'),(62,'Components: Dynamic Event Boards'),(63,'Components: Game Box Used In Play'),(64,'Components: Game Trayz Inside'),(65,'Components: Gears'),(66,'Components: Gems/Crystals'),(67,'Components: Hexagonal Tiles'),(68,'Components: Map (City Scale)'),(69,'Components: Map (Continental / National scale)'),(70,'Components: Map (Global Scale)'),(71,'Components: Map (Interplanetary or Interstellar scale)'),(72,'Components: Map (Regional scale)'),(73,'Components: Meeples (Animal) / Animeeples'),(74,'Components: Miniatures'),(75,'Components: Multi-Use Cards'),(76,'Components: Official Music Soundtrack'),(78,'Components: Polyhedral (not D6) dice'),(79,'Components: Polyominoes'),(77,'Components: PVC Cards'),(80,'Components: RE-Wood'),(81,'Components: Sand Timers'),(82,'Components: Standees'),(83,'Components: Wooden pieces & boards'),(84,'Constructions: Pyramids'),(85,'Containers: Drawstring Bag'),(86,'Containers: Tin/Metal Box'),(87,'Continents: Africa'),(88,'Continents: Asia'),(89,'Continents: Europe'),(90,'Continents: North America'),(91,'Country: Afghanistan'),(92,'Country: Austria'),(93,'Country: England'),(94,'Country: France'),(95,'Country: Germany'),(96,'Country: India'),(97,'Country: Italy'),(98,'Country: Japan'),(99,'Country: Mexico'),(100,'Country: New Zealand'),(101,'Country: Portugal'),(102,'Country: Puerto Rico'),(103,'Country: Scotland'),(104,'Country: Soviet Union'),(105,'Country: Spain'),(107,'Country: United Kingdom'),(106,'Country: USA'),(108,'Creatures: Aliens / Extraterrestrials'),(109,'Creatures: Demons'),(110,'Creatures: Dragons'),(111,'Creatures: Dwarves & Gnomes'),(112,'Creatures: Goblins'),(113,'Creatures: Monsters'),(114,'Crowdfunding: Gamefound'),(115,'Crowdfunding: Giochistarter'),(116,'Crowdfunding: Kickstarter'),(117,'Crowdfunding: Spieleschmiede'),(118,'Crowdfunding: Wspieram'),(119,'Decades: The 1920\'s'),(120,'Decades: The 1950\'s'),(121,'Decades: The 1960\'s'),(122,'Decades: The 2000\'s'),(123,'Digital Implementations: Apple App Store'),(124,'Digital Implementations: Board Game Arena'),(126,'Digital Implementations: Boardgamecore'),(125,'Digital Implementations: BoardSpace'),(127,'Digital Implementations: Boiteajeux'),(128,'Digital Implementations: BrettspielWelt'),(129,'Digital Implementations: Dire Wolf Game Room'),(130,'Digital Implementations: Google Play'),(131,'Digital Implementations: Steam'),(132,'Digital Implementations: TableTop Simulator Mod (TTS)'),(133,'Digital Implementations: Tabletopia'),(134,'Digital Implementations: VASSAL'),(135,'Digital Implementations: Yucata'),(136,'Food & Drink: Beer'),(672,'Gallerist'),(137,'Game: 7 Wonders Duel'),(138,'Game: Aeon\'s End'),(139,'Game: Anachrony'),(140,'Game: Android – Netrunner (LCG)'),(141,'Game: Arkham Horror – The Card Game'),(142,'Game: Azul'),(143,'Game: Barrage'),(144,'Game: Clank!'),(145,'Game: Dune: Imperium'),(146,'Game: Eclipse (Lautapelit.fi)'),(147,'Game: Five Tribes'),(148,'Game: Great Western Trail'),(149,'Game: Heat – Pedal to the Metal'),(150,'Game: Hegemony'),(151,'Game: Kingdom Death Monster'),(152,'Game: Le Havre'),(153,'Game: Lords of Waterdeep'),(154,'Game: Mansions of Madness (Second Edition)'),(155,'Game: Marvel Champions – The Card Game'),(156,'Game: Obsession'),(157,'Game: On Mars'),(158,'Game: Pandemic'),(159,'Game: Puerto Rico'),(160,'Game: Race for the Galaxy'),(161,'Game: Revive'),(162,'Game: Star Wars Imperial Assault'),(163,'Game: Terraforming Mars'),(164,'Game: The Crew'),(165,'Game: The Gallerist'),(166,'Game: The Quacks of Quedlinburg'),(167,'Game: Through the Ages'),(168,'Game: Ticket to Ride (Official)'),(169,'Game: Too Many Bones'),(170,'Game: Twilight Imperium'),(171,'Game: Tzolk\'in – The Mayan Calendar'),(172,'Game: Werewolf / Mafia'),(173,'Game: Wingspan'),(669,'Gloomhaven'),(676,'Great Western Trail'),(670,'Harvest'),(174,'Historical Figures: Charles Darwin'),(175,'Historical Figures: Various'),(176,'History: Cold War'),(177,'History: Francia'),(178,'Islands: Galápagos (Ecuador)'),(663,'Legacy'),(674,'Lorenzo il Magnifico'),(666,'Mansions of Madness'),(179,'Mechanism: 4X'),(180,'Mechanism: Artificial Player'),(181,'Mechanism: Campaign Games'),(182,'Mechanism: Dice Drafting'),(183,'Mechanism: Finger Flicking Games'),(184,'Mechanism: Legacy'),(185,'Mechanism: Tableau Building'),(186,'Medical: Diseases'),(187,'Misc: Dice Tower Hall of Fame'),(188,'Misc: GettingGames Tutorial Videos'),(189,'Misc: Limited Replayability'),(190,'Misc: LongPack Games'),(191,'Misc: Made by Panda'),(192,'Misc: Mensa Select'),(193,'Misc: Watch It Played How To Videos'),(194,'Movies: Star Wars'),(195,'Mythology: Arabian'),(196,'Occupation: Architect'),(662,'Pandemic'),(197,'Players: Games with Solitaire Rules'),(198,'Players: Two-Player Only Games'),(673,'Red Raven Games'),(199,'Region: Middle East'),(200,'Region: Normandy (France)'),(679,'Robinson Crusoe'),(671,'Root'),(665,'Scythe'),(201,'Series: Arkham Horror Files (Fantasy Flight Games)'),(202,'Series: Harvest (Uwe Rosenberg)'),(203,'Series: Medieval Trilogies (Garphill Games)'),(204,'Series: Terra Mystica'),(205,'Series: Two-player games (Kosmos)'),(206,'Series: War of the Ring (Nexus/Ares Games)'),(207,'Setting: Android'),(208,'Setting: Dungeons & Dragons'),(209,'Setting: Mage Knight'),(210,'Space: Colonization / Extraterrestrial Colonisation'),(211,'Space: Earth\'s Solar System'),(212,'Sports: Auto Racing'),(213,'Sports: Formula 1'),(214,'Theme: Astronomy'),(215,'Theme: Automotive Industry'),(216,'Theme: Boss Battle'),(217,'Theme: Colonial'),(218,'Theme: Nature'),(219,'Theme: Under the Sea'),(668,'Through the Ages'),(220,'Traditional Games: Crokinole');
/*!40000 ALTER TABLE `families` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_artists`
--

DROP TABLE IF EXISTS `game_artists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_artists` (
  `game_id` int NOT NULL,
  `artist_id` int NOT NULL,
  PRIMARY KEY (`game_id`,`artist_id`),
  KEY `idx_game_artists_artist` (`artist_id`),
  CONSTRAINT `game_artists_ibfk_1` FOREIGN KEY (`game_id`) REFERENCES `boardgames` (`game_id`) ON DELETE CASCADE,
  CONSTRAINT `game_artists_ibfk_2` FOREIGN KEY (`artist_id`) REFERENCES `artists` (`artist_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_artists`
--

LOCK TABLES `game_artists` WRITE;
/*!40000 ALTER TABLE `game_artists` DISABLE KEYS */;
INSERT INTO `game_artists` (`game_id`, `artist_id`) VALUES (5,1),(16,1),(18,1),(11,2),(18,2),(3,3),(12,3),(14,3),(19,3),(20,3),(1,4),(2,4),(6,4),(8,4),(13,4),(3,5),(7,5),(13,5),(6,6),(9,6),(11,6),(9,7),(10,7),(19,7),(4,8),(15,8),(1,9),(9,9),(17,9),(4,11),(6,13),(17,14),(2,30),(1,52),(3,55),(16,55),(6,84),(12,85),(5,94),(10,114),(14,114),(11,115),(1,118),(3,122),(19,142),(4,148),(7,159),(13,174),(7,203),(15,203),(8,610),(9,611),(15,612),(18,613),(20,614);
/*!40000 ALTER TABLE `game_artists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_awards`
--

DROP TABLE IF EXISTS `game_awards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_awards` (
  `game_id` int NOT NULL,
  `award_id` int NOT NULL,
  `year_awarded` year DEFAULT NULL,
  PRIMARY KEY (`game_id`,`award_id`),
  KEY `award_id` (`award_id`),
  CONSTRAINT `game_awards_ibfk_1` FOREIGN KEY (`game_id`) REFERENCES `boardgames` (`game_id`) ON DELETE CASCADE,
  CONSTRAINT `game_awards_ibfk_2` FOREIGN KEY (`award_id`) REFERENCES `awards` (`award_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_awards`
--

LOCK TABLES `game_awards` WRITE;
/*!40000 ALTER TABLE `game_awards` DISABLE KEYS */;
INSERT INTO `game_awards` (`game_id`, `award_id`, `year_awarded`) VALUES (1,211,2018),(2,1144,2015),(2,1145,2015),(3,1146,2021),(4,1147,2019),(5,1148,2016),(6,1149,2016),(7,1150,2010),(8,1151,2006),(9,1152,2017),(10,1153,2007),(11,1154,2018),(12,1155,2013),(13,119,2015),(14,1156,2016),(15,1157,1999),(16,1158,2003),(17,157,2016),(18,1159,1995),(19,1160,2010),(20,1161,2012);
/*!40000 ALTER TABLE `game_awards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_categories`
--

DROP TABLE IF EXISTS `game_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_categories` (
  `game_id` int NOT NULL,
  `category_id` int NOT NULL,
  PRIMARY KEY (`game_id`,`category_id`),
  KEY `idx_game_categories_category` (`category_id`),
  CONSTRAINT `game_categories_ibfk_1` FOREIGN KEY (`game_id`) REFERENCES `boardgames` (`game_id`) ON DELETE CASCADE,
  CONSTRAINT `game_categories_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_categories`
--

LOCK TABLES `game_categories` WRITE;
/*!40000 ALTER TABLE `game_categories` DISABLE KEYS */;
INSERT INTO `game_categories` (`game_id`, `category_id`) VALUES (2,1),(7,1),(11,1),(16,1),(1,2),(3,2),(5,2),(6,2),(15,2),(19,2),(6,3),(9,3),(11,3),(13,3),(14,3),(20,3),(2,4),(5,4),(8,4),(9,4),(15,4),(17,4),(19,4),(20,4),(10,5),(14,5),(7,6),(8,6),(9,6),(15,6),(18,6),(3,7),(4,7),(20,7),(8,8),(10,8),(11,8),(17,8),(19,8),(20,8),(1,9),(2,9),(10,9),(12,9),(14,9),(2,10),(13,10),(14,10),(1,11),(6,11),(8,11),(19,11),(1,12),(8,12),(16,12),(18,12),(7,13),(12,13),(17,13),(18,13),(5,14),(6,14),(7,14),(8,14),(10,14),(15,14),(18,14),(19,14),(3,15),(4,15),(6,15),(13,15),(16,15),(1,19),(7,19),(10,19),(12,19),(14,19),(17,19),(3,20),(4,20),(3,21),(6,22),(13,22),(20,22),(9,23),(10,24),(5,25),(6,26),(1,27),(12,27),(2,29),(16,30),(5,31),(9,31),(18,37),(11,41),(14,46),(5,47),(1,53),(7,53),(17,53),(11,56),(2,169),(2,170);
/*!40000 ALTER TABLE `game_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_designers`
--

DROP TABLE IF EXISTS `game_designers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_designers` (
  `game_id` int NOT NULL,
  `designer_id` int NOT NULL,
  PRIMARY KEY (`game_id`,`designer_id`),
  KEY `idx_game_designers_designer` (`designer_id`),
  CONSTRAINT `game_designers_ibfk_1` FOREIGN KEY (`game_id`) REFERENCES `boardgames` (`game_id`) ON DELETE CASCADE,
  CONSTRAINT `game_designers_ibfk_2` FOREIGN KEY (`designer_id`) REFERENCES `designers` (`designer_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_designers`
--

LOCK TABLES `game_designers` WRITE;
/*!40000 ALTER TABLE `game_designers` DISABLE KEYS */;
INSERT INTO `game_designers` (`game_id`, `designer_id`) VALUES (1,1),(2,1),(13,1),(16,1),(13,2),(14,2),(20,2),(6,3),(5,4),(9,4),(17,4),(4,5),(8,5),(12,5),(6,6),(15,6),(3,7),(8,7),(10,7),(15,7),(18,7),(7,8),(11,9),(14,9),(17,9),(19,9),(4,10),(5,10),(18,10),(19,13),(11,20),(6,21),(14,25),(4,28),(1,34),(9,37),(5,41),(1,60),(7,60),(3,61),(2,62),(1,63),(2,82),(13,85),(14,89),(16,90),(10,98),(12,103),(8,104),(6,322),(15,323),(17,324),(18,325),(20,326);
/*!40000 ALTER TABLE `game_designers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_families`
--

DROP TABLE IF EXISTS `game_families`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_families` (
  `game_id` int NOT NULL,
  `family_id` int NOT NULL,
  PRIMARY KEY (`game_id`,`family_id`),
  KEY `family_id` (`family_id`),
  CONSTRAINT `game_families_ibfk_1` FOREIGN KEY (`game_id`) REFERENCES `boardgames` (`game_id`) ON DELETE CASCADE,
  CONSTRAINT `game_families_ibfk_2` FOREIGN KEY (`family_id`) REFERENCES `families` (`family_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_families`
--

LOCK TABLES `game_families` WRITE;
/*!40000 ALTER TABLE `game_families` DISABLE KEYS */;
INSERT INTO `game_families` (`game_id`, `family_id`) VALUES (15,3),(4,10),(1,93),(1,661),(2,662),(2,663),(3,664),(5,665),(6,666),(7,667),(8,668),(9,669),(10,670),(11,671),(12,672),(13,673),(14,674),(16,675),(17,676),(18,677),(19,678),(20,679);
/*!40000 ALTER TABLE `game_families` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_mechanisms`
--

DROP TABLE IF EXISTS `game_mechanisms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_mechanisms` (
  `game_id` int NOT NULL,
  `mechanism_id` int NOT NULL,
  PRIMARY KEY (`game_id`,`mechanism_id`),
  KEY `idx_game_mechanisms_mechanism` (`mechanism_id`),
  CONSTRAINT `game_mechanisms_ibfk_1` FOREIGN KEY (`game_id`) REFERENCES `boardgames` (`game_id`) ON DELETE CASCADE,
  CONSTRAINT `game_mechanisms_ibfk_2` FOREIGN KEY (`mechanism_id`) REFERENCES `mechanisms` (`mechanism_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_mechanisms`
--

LOCK TABLES `game_mechanisms` WRITE;
/*!40000 ALTER TABLE `game_mechanisms` DISABLE KEYS */;
INSERT INTO `game_mechanisms` (`game_id`, `mechanism_id`) VALUES (2,1),(7,1),(9,1),(15,1),(19,1),(9,2),(13,2),(16,2),(17,2),(19,2),(5,3),(8,3),(9,3),(11,3),(20,3),(2,4),(6,4),(14,4),(15,4),(16,4),(17,4),(18,4),(2,5),(4,5),(5,5),(8,5),(16,5),(3,6),(12,6),(1,7),(5,7),(17,7),(20,7),(2,8),(8,8),(11,8),(4,9),(5,9),(6,9),(11,9),(14,9),(15,9),(16,9),(19,9),(1,10),(2,10),(12,10),(15,10),(8,11),(10,11),(15,11),(17,11),(6,12),(10,12),(13,12),(14,12),(7,13),(9,13),(11,13),(14,13),(19,13),(3,14),(7,14),(17,14),(19,14),(8,15),(9,15),(11,15),(14,15),(18,15),(2,29),(6,29),(9,29),(6,35),(16,35),(18,35),(3,38),(4,38),(8,38),(10,38),(14,38),(4,43),(1,45),(2,45),(2,57),(1,64),(7,64),(17,64),(6,66),(9,66),(20,66),(1,71),(7,71),(12,71),(3,89),(4,89),(8,89),(13,89),(15,89),(19,89),(3,97),(8,97),(5,104),(10,108),(12,108),(13,108),(14,108),(16,108),(17,108),(11,328),(18,329),(19,330);
/*!40000 ALTER TABLE `game_mechanisms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_prices`
--

DROP TABLE IF EXISTS `game_prices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_prices` (
  `price_id` int NOT NULL AUTO_INCREMENT,
  `game_id` int NOT NULL,
  `store_id` int NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `currency` varchar(3) DEFAULT 'USD',
  `condition_type` enum('New','Like New','Very Good','Good','Acceptable','Poor','Unknown') DEFAULT 'Unknown',
  `location` varchar(100) DEFAULT NULL,
  `price_date` date DEFAULT '2025-08-07',
  PRIMARY KEY (`price_id`),
  KEY `store_id` (`store_id`),
  KEY `idx_game_store` (`game_id`,`store_id`),
  KEY `idx_price_date` (`price_date`),
  CONSTRAINT `game_prices_ibfk_1` FOREIGN KEY (`game_id`) REFERENCES `boardgames` (`game_id`) ON DELETE CASCADE,
  CONSTRAINT `game_prices_ibfk_2` FOREIGN KEY (`store_id`) REFERENCES `stores` (`store_id`) ON DELETE CASCADE,
  CONSTRAINT `chk_positive_price` CHECK ((`price` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=345 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_prices`
--

LOCK TABLES `game_prices` WRITE;
/*!40000 ALTER TABLE `game_prices` DISABLE KEYS */;
INSERT INTO `game_prices` (`price_id`, `game_id`, `store_id`, `price`, `currency`, `condition_type`, `location`, `price_date`) VALUES (1,1,2,12.00,'USD','Unknown',NULL,'2025-08-07'),(2,2,2,20.00,'USD','Unknown',NULL,'2025-08-07'),(3,3,2,18.00,'USD','Unknown',NULL,'2025-08-07'),(4,4,2,30.00,'USD','Unknown',NULL,'2025-08-07'),(5,5,2,13.00,'USD','Unknown',NULL,'2025-08-07'),(6,6,2,15.00,'USD','Unknown',NULL,'2025-08-07'),(7,7,2,20.00,'USD','Unknown',NULL,'2025-08-07'),(8,8,2,18.00,'USD','Unknown',NULL,'2025-08-07'),(9,9,2,7.00,'USD','Unknown',NULL,'2025-08-07'),(10,11,2,18.00,'USD','Unknown',NULL,'2025-08-07'),(11,12,2,16.00,'USD','Unknown',NULL,'2025-08-07'),(12,13,2,15.00,'USD','Unknown',NULL,'2025-08-07'),(13,14,1,30.00,'USD','Unknown',NULL,'2025-08-07'),(14,15,2,10.00,'USD','Unknown',NULL,'2025-08-07'),(15,16,1,12.00,'USD','Unknown',NULL,'2025-08-07'),(16,17,2,25.00,'USD','Unknown',NULL,'2025-08-07'),(17,18,2,18.00,'USD','Unknown',NULL,'2025-08-07'),(18,19,2,50.00,'USD','Unknown',NULL,'2025-08-07'),(19,20,2,18.00,'USD','Unknown',NULL,'2025-08-07'),(20,21,2,7.00,'USD','Unknown',NULL,'2025-08-07'),(21,22,2,50.00,'USD','Unknown',NULL,'2025-08-07'),(22,23,2,15.00,'USD','Unknown',NULL,'2025-08-07'),(23,24,2,14.00,'USD','Unknown',NULL,'2025-08-07'),(24,25,2,200.00,'USD','Unknown',NULL,'2025-08-07'),(25,26,1,10.00,'USD','Unknown',NULL,'2025-08-07'),(26,27,2,15.00,'USD','Unknown',NULL,'2025-08-07'),(27,28,2,15.00,'USD','Unknown',NULL,'2025-08-07'),(28,29,2,30.00,'USD','Unknown',NULL,'2025-08-07'),(29,30,1,14.00,'USD','Unknown',NULL,'2025-08-07'),(30,31,2,10.00,'USD','Unknown',NULL,'2025-08-07'),(31,32,1,16.00,'USD','Unknown',NULL,'2025-08-07'),(32,33,2,8.00,'USD','Unknown',NULL,'2025-08-07'),(33,35,1,35.00,'USD','Unknown',NULL,'2025-08-07'),(34,36,1,35.00,'USD','Unknown',NULL,'2025-08-07'),(35,38,2,120.00,'USD','Unknown',NULL,'2025-08-07'),(36,39,2,125.00,'USD','Unknown',NULL,'2025-08-07'),(37,40,2,18.00,'USD','Unknown',NULL,'2025-08-07'),(38,41,2,25.00,'USD','Unknown',NULL,'2025-08-07'),(39,43,2,18.00,'USD','Unknown',NULL,'2025-08-07'),(40,44,2,19.00,'USD','Unknown',NULL,'2025-08-07'),(41,45,2,95.00,'USD','Unknown',NULL,'2025-08-07'),(42,46,2,7.00,'USD','Unknown',NULL,'2025-08-07'),(43,48,2,14.00,'USD','Unknown',NULL,'2025-08-07'),(44,49,2,17.00,'USD','Unknown',NULL,'2025-08-07'),(45,50,1,32.00,'USD','Unknown',NULL,'2025-08-07'),(46,51,2,20.00,'USD','Unknown',NULL,'2025-08-07'),(47,52,2,30.00,'USD','Unknown',NULL,'2025-08-07'),(48,53,2,69.95,'USD','Unknown',NULL,'2025-08-07'),(49,54,2,13.00,'USD','Unknown',NULL,'2025-08-07'),(50,55,2,30.00,'USD','Unknown',NULL,'2025-08-07'),(51,57,2,12.00,'USD','Unknown',NULL,'2025-08-07'),(52,58,2,6.99,'USD','Unknown',NULL,'2025-08-07'),(53,59,2,30.00,'USD','Unknown',NULL,'2025-08-07'),(54,60,2,45.00,'USD','Unknown',NULL,'2025-08-07'),(55,61,2,15.00,'USD','Unknown',NULL,'2025-08-07'),(56,62,2,40.00,'USD','Unknown',NULL,'2025-08-07'),(57,63,2,20.00,'USD','Unknown',NULL,'2025-08-07'),(58,64,2,315.00,'USD','Unknown',NULL,'2025-08-07'),(59,66,2,18.00,'USD','Unknown',NULL,'2025-08-07'),(60,67,2,48.99,'USD','Unknown',NULL,'2025-08-07'),(61,69,2,7.00,'USD','Unknown',NULL,'2025-08-07'),(62,70,2,18.00,'USD','Unknown',NULL,'2025-08-07'),(63,71,2,13.00,'USD','Unknown',NULL,'2025-08-07'),(64,72,2,8.00,'USD','Unknown',NULL,'2025-08-07'),(65,73,1,42.00,'USD','Unknown',NULL,'2025-08-07'),(66,74,2,20.00,'USD','Unknown',NULL,'2025-08-07'),(67,75,2,18.00,'USD','Unknown',NULL,'2025-08-07'),(68,76,1,40.00,'USD','Unknown',NULL,'2025-08-07'),(69,77,2,25.00,'USD','Unknown',NULL,'2025-08-07'),(70,78,2,8.00,'USD','Unknown',NULL,'2025-08-07'),(71,79,2,14.00,'USD','Unknown',NULL,'2025-08-07'),(72,80,2,100.00,'USD','Unknown',NULL,'2025-08-07'),(73,81,2,16.00,'USD','Unknown',NULL,'2025-08-07'),(74,82,2,10.00,'USD','Unknown',NULL,'2025-08-07'),(75,84,2,200.00,'USD','Unknown',NULL,'2025-08-07'),(76,85,2,16.00,'USD','Unknown',NULL,'2025-08-07'),(77,86,2,15.00,'USD','Unknown',NULL,'2025-08-07'),(78,87,1,13.00,'USD','Unknown',NULL,'2025-08-07'),(79,88,2,13.00,'USD','Unknown',NULL,'2025-08-07'),(80,90,2,15.00,'USD','Unknown',NULL,'2025-08-07'),(81,92,2,8.00,'USD','Unknown',NULL,'2025-08-07'),(82,94,2,16.00,'USD','Unknown',NULL,'2025-08-07'),(83,95,2,15.00,'USD','Unknown',NULL,'2025-08-07'),(84,97,2,20.00,'USD','Unknown',NULL,'2025-08-07'),(85,98,2,400.00,'USD','Unknown',NULL,'2025-08-07'),(86,100,2,18.00,'USD','Unknown',NULL,'2025-08-07'),(87,1,2,12.00,'USD','Unknown',NULL,'2025-08-07'),(88,2,2,20.00,'USD','Unknown',NULL,'2025-08-07'),(89,3,2,18.00,'USD','Unknown',NULL,'2025-08-07'),(90,4,2,30.00,'USD','Unknown',NULL,'2025-08-07'),(91,5,2,13.00,'USD','Unknown',NULL,'2025-08-07'),(92,6,2,15.00,'USD','Unknown',NULL,'2025-08-07'),(93,7,2,20.00,'USD','Unknown',NULL,'2025-08-07'),(94,8,2,18.00,'USD','Unknown',NULL,'2025-08-07'),(95,9,2,7.00,'USD','Unknown',NULL,'2025-08-07'),(96,11,2,18.00,'USD','Unknown',NULL,'2025-08-07'),(97,12,2,16.00,'USD','Unknown',NULL,'2025-08-07'),(98,13,2,15.00,'USD','Unknown',NULL,'2025-08-07'),(99,14,1,30.00,'USD','Unknown',NULL,'2025-08-07'),(100,15,2,10.00,'USD','Unknown',NULL,'2025-08-07'),(101,16,1,12.00,'USD','Unknown',NULL,'2025-08-07'),(102,17,2,25.00,'USD','Unknown',NULL,'2025-08-07'),(103,18,2,18.00,'USD','Unknown',NULL,'2025-08-07'),(104,19,2,50.00,'USD','Unknown',NULL,'2025-08-07'),(105,20,2,18.00,'USD','Unknown',NULL,'2025-08-07'),(106,21,2,7.00,'USD','Unknown',NULL,'2025-08-07'),(107,22,2,50.00,'USD','Unknown',NULL,'2025-08-07'),(108,23,2,15.00,'USD','Unknown',NULL,'2025-08-07'),(109,24,2,14.00,'USD','Unknown',NULL,'2025-08-07'),(110,25,2,200.00,'USD','Unknown',NULL,'2025-08-07'),(111,26,1,10.00,'USD','Unknown',NULL,'2025-08-07'),(112,27,2,15.00,'USD','Unknown',NULL,'2025-08-07'),(113,28,2,15.00,'USD','Unknown',NULL,'2025-08-07'),(114,29,2,30.00,'USD','Unknown',NULL,'2025-08-07'),(115,30,1,14.00,'USD','Unknown',NULL,'2025-08-07'),(116,31,2,10.00,'USD','Unknown',NULL,'2025-08-07'),(117,32,1,16.00,'USD','Unknown',NULL,'2025-08-07'),(118,33,2,8.00,'USD','Unknown',NULL,'2025-08-07'),(119,35,1,35.00,'USD','Unknown',NULL,'2025-08-07'),(120,36,1,35.00,'USD','Unknown',NULL,'2025-08-07'),(121,38,2,120.00,'USD','Unknown',NULL,'2025-08-07'),(122,39,2,125.00,'USD','Unknown',NULL,'2025-08-07'),(123,40,2,18.00,'USD','Unknown',NULL,'2025-08-07'),(124,41,2,25.00,'USD','Unknown',NULL,'2025-08-07'),(125,43,2,18.00,'USD','Unknown',NULL,'2025-08-07'),(126,44,2,19.00,'USD','Unknown',NULL,'2025-08-07'),(127,45,2,95.00,'USD','Unknown',NULL,'2025-08-07'),(128,46,2,7.00,'USD','Unknown',NULL,'2025-08-07'),(129,48,2,14.00,'USD','Unknown',NULL,'2025-08-07'),(130,49,2,17.00,'USD','Unknown',NULL,'2025-08-07'),(131,50,1,32.00,'USD','Unknown',NULL,'2025-08-07'),(132,51,2,20.00,'USD','Unknown',NULL,'2025-08-07'),(133,52,2,30.00,'USD','Unknown',NULL,'2025-08-07'),(134,53,2,69.95,'USD','Unknown',NULL,'2025-08-07'),(135,54,2,13.00,'USD','Unknown',NULL,'2025-08-07'),(136,55,2,30.00,'USD','Unknown',NULL,'2025-08-07'),(137,57,2,12.00,'USD','Unknown',NULL,'2025-08-07'),(138,58,2,6.99,'USD','Unknown',NULL,'2025-08-07'),(139,59,2,30.00,'USD','Unknown',NULL,'2025-08-07'),(140,60,2,45.00,'USD','Unknown',NULL,'2025-08-07'),(141,61,2,15.00,'USD','Unknown',NULL,'2025-08-07'),(142,62,2,40.00,'USD','Unknown',NULL,'2025-08-07'),(143,63,2,20.00,'USD','Unknown',NULL,'2025-08-07'),(144,64,2,315.00,'USD','Unknown',NULL,'2025-08-07'),(145,66,2,18.00,'USD','Unknown',NULL,'2025-08-07'),(146,67,2,48.99,'USD','Unknown',NULL,'2025-08-07'),(147,69,2,7.00,'USD','Unknown',NULL,'2025-08-07'),(148,70,2,18.00,'USD','Unknown',NULL,'2025-08-07'),(149,71,2,13.00,'USD','Unknown',NULL,'2025-08-07'),(150,72,2,8.00,'USD','Unknown',NULL,'2025-08-07'),(151,73,1,42.00,'USD','Unknown',NULL,'2025-08-07'),(152,74,2,20.00,'USD','Unknown',NULL,'2025-08-07'),(153,75,2,18.00,'USD','Unknown',NULL,'2025-08-07'),(154,76,1,40.00,'USD','Unknown',NULL,'2025-08-07'),(155,77,2,25.00,'USD','Unknown',NULL,'2025-08-07'),(156,78,2,8.00,'USD','Unknown',NULL,'2025-08-07'),(157,79,2,14.00,'USD','Unknown',NULL,'2025-08-07'),(158,80,2,100.00,'USD','Unknown',NULL,'2025-08-07'),(159,81,2,16.00,'USD','Unknown',NULL,'2025-08-07'),(160,82,2,10.00,'USD','Unknown',NULL,'2025-08-07'),(161,84,2,200.00,'USD','Unknown',NULL,'2025-08-07'),(162,85,2,16.00,'USD','Unknown',NULL,'2025-08-07'),(163,86,2,15.00,'USD','Unknown',NULL,'2025-08-07'),(164,87,1,13.00,'USD','Unknown',NULL,'2025-08-07'),(165,88,2,13.00,'USD','Unknown',NULL,'2025-08-07'),(166,90,2,15.00,'USD','Unknown',NULL,'2025-08-07'),(167,92,2,8.00,'USD','Unknown',NULL,'2025-08-07'),(168,94,2,16.00,'USD','Unknown',NULL,'2025-08-07'),(169,95,2,15.00,'USD','Unknown',NULL,'2025-08-07'),(170,97,2,20.00,'USD','Unknown',NULL,'2025-08-07'),(171,98,2,400.00,'USD','Unknown',NULL,'2025-08-07'),(172,100,2,18.00,'USD','Unknown',NULL,'2025-08-07'),(173,1,2,12.00,'USD','Unknown',NULL,'2025-08-07'),(174,2,2,20.00,'USD','Unknown',NULL,'2025-08-07'),(175,3,2,18.00,'USD','Unknown',NULL,'2025-08-07'),(176,4,2,30.00,'USD','Unknown',NULL,'2025-08-07'),(177,5,2,13.00,'USD','Unknown',NULL,'2025-08-07'),(178,6,2,15.00,'USD','Unknown',NULL,'2025-08-07'),(179,7,2,20.00,'USD','Unknown',NULL,'2025-08-07'),(180,8,2,18.00,'USD','Unknown',NULL,'2025-08-07'),(181,9,2,7.00,'USD','Unknown',NULL,'2025-08-07'),(182,11,2,18.00,'USD','Unknown',NULL,'2025-08-07'),(183,12,2,16.00,'USD','Unknown',NULL,'2025-08-07'),(184,13,2,15.00,'USD','Unknown',NULL,'2025-08-07'),(185,14,1,30.00,'USD','Unknown',NULL,'2025-08-07'),(186,15,2,10.00,'USD','Unknown',NULL,'2025-08-07'),(187,16,1,12.00,'USD','Unknown',NULL,'2025-08-07'),(188,17,2,25.00,'USD','Unknown',NULL,'2025-08-07'),(189,18,2,18.00,'USD','Unknown',NULL,'2025-08-07'),(190,19,2,50.00,'USD','Unknown',NULL,'2025-08-07'),(191,20,2,18.00,'USD','Unknown',NULL,'2025-08-07'),(192,21,2,7.00,'USD','Unknown',NULL,'2025-08-07'),(193,22,2,50.00,'USD','Unknown',NULL,'2025-08-07'),(194,23,2,15.00,'USD','Unknown',NULL,'2025-08-07'),(195,24,2,14.00,'USD','Unknown',NULL,'2025-08-07'),(196,25,2,200.00,'USD','Unknown',NULL,'2025-08-07'),(197,26,1,10.00,'USD','Unknown',NULL,'2025-08-07'),(198,27,2,15.00,'USD','Unknown',NULL,'2025-08-07'),(199,28,2,15.00,'USD','Unknown',NULL,'2025-08-07'),(200,29,2,30.00,'USD','Unknown',NULL,'2025-08-07'),(201,30,1,14.00,'USD','Unknown',NULL,'2025-08-07'),(202,31,2,10.00,'USD','Unknown',NULL,'2025-08-07'),(203,32,1,16.00,'USD','Unknown',NULL,'2025-08-07'),(204,33,2,8.00,'USD','Unknown',NULL,'2025-08-07'),(205,35,1,35.00,'USD','Unknown',NULL,'2025-08-07'),(206,36,1,35.00,'USD','Unknown',NULL,'2025-08-07'),(207,38,2,120.00,'USD','Unknown',NULL,'2025-08-07'),(208,39,2,125.00,'USD','Unknown',NULL,'2025-08-07'),(209,40,2,18.00,'USD','Unknown',NULL,'2025-08-07'),(210,41,2,25.00,'USD','Unknown',NULL,'2025-08-07'),(211,43,2,18.00,'USD','Unknown',NULL,'2025-08-07'),(212,44,2,19.00,'USD','Unknown',NULL,'2025-08-07'),(213,45,2,95.00,'USD','Unknown',NULL,'2025-08-07'),(214,46,2,7.00,'USD','Unknown',NULL,'2025-08-07'),(215,48,2,14.00,'USD','Unknown',NULL,'2025-08-07'),(216,49,2,17.00,'USD','Unknown',NULL,'2025-08-07'),(217,50,1,32.00,'USD','Unknown',NULL,'2025-08-07'),(218,51,2,20.00,'USD','Unknown',NULL,'2025-08-07'),(219,52,2,30.00,'USD','Unknown',NULL,'2025-08-07'),(220,53,2,69.95,'USD','Unknown',NULL,'2025-08-07'),(221,54,2,13.00,'USD','Unknown',NULL,'2025-08-07'),(222,55,2,30.00,'USD','Unknown',NULL,'2025-08-07'),(223,57,2,12.00,'USD','Unknown',NULL,'2025-08-07'),(224,58,2,6.99,'USD','Unknown',NULL,'2025-08-07'),(225,59,2,30.00,'USD','Unknown',NULL,'2025-08-07'),(226,60,2,45.00,'USD','Unknown',NULL,'2025-08-07'),(227,61,2,15.00,'USD','Unknown',NULL,'2025-08-07'),(228,62,2,40.00,'USD','Unknown',NULL,'2025-08-07'),(229,63,2,20.00,'USD','Unknown',NULL,'2025-08-07'),(230,64,2,315.00,'USD','Unknown',NULL,'2025-08-07'),(231,66,2,18.00,'USD','Unknown',NULL,'2025-08-07'),(232,67,2,48.99,'USD','Unknown',NULL,'2025-08-07'),(233,69,2,7.00,'USD','Unknown',NULL,'2025-08-07'),(234,70,2,18.00,'USD','Unknown',NULL,'2025-08-07'),(235,71,2,13.00,'USD','Unknown',NULL,'2025-08-07'),(236,72,2,8.00,'USD','Unknown',NULL,'2025-08-07'),(237,73,1,42.00,'USD','Unknown',NULL,'2025-08-07'),(238,74,2,20.00,'USD','Unknown',NULL,'2025-08-07'),(239,75,2,18.00,'USD','Unknown',NULL,'2025-08-07'),(240,76,1,40.00,'USD','Unknown',NULL,'2025-08-07'),(241,77,2,25.00,'USD','Unknown',NULL,'2025-08-07'),(242,78,2,8.00,'USD','Unknown',NULL,'2025-08-07'),(243,79,2,14.00,'USD','Unknown',NULL,'2025-08-07'),(244,80,2,100.00,'USD','Unknown',NULL,'2025-08-07'),(245,81,2,16.00,'USD','Unknown',NULL,'2025-08-07'),(246,82,2,10.00,'USD','Unknown',NULL,'2025-08-07'),(247,84,2,200.00,'USD','Unknown',NULL,'2025-08-07'),(248,85,2,16.00,'USD','Unknown',NULL,'2025-08-07'),(249,86,2,15.00,'USD','Unknown',NULL,'2025-08-07'),(250,87,1,13.00,'USD','Unknown',NULL,'2025-08-07'),(251,88,2,13.00,'USD','Unknown',NULL,'2025-08-07'),(252,90,2,15.00,'USD','Unknown',NULL,'2025-08-07'),(253,92,2,8.00,'USD','Unknown',NULL,'2025-08-07'),(254,94,2,16.00,'USD','Unknown',NULL,'2025-08-07'),(255,95,2,15.00,'USD','Unknown',NULL,'2025-08-07'),(256,97,2,20.00,'USD','Unknown',NULL,'2025-08-07'),(257,98,2,400.00,'USD','Unknown',NULL,'2025-08-07'),(258,100,2,18.00,'USD','Unknown',NULL,'2025-08-07'),(259,1,2,12.00,'USD','Unknown',NULL,'2025-08-07'),(260,2,2,20.00,'USD','Unknown',NULL,'2025-08-07'),(261,3,2,18.00,'USD','Unknown',NULL,'2025-08-07'),(262,4,2,30.00,'USD','Unknown',NULL,'2025-08-07'),(263,5,2,13.00,'USD','Unknown',NULL,'2025-08-07'),(264,6,2,15.00,'USD','Unknown',NULL,'2025-08-07'),(265,7,2,20.00,'USD','Unknown',NULL,'2025-08-07'),(266,8,2,18.00,'USD','Unknown',NULL,'2025-08-07'),(267,9,2,7.00,'USD','Unknown',NULL,'2025-08-07'),(268,11,2,18.00,'USD','Unknown',NULL,'2025-08-07'),(269,12,2,16.00,'USD','Unknown',NULL,'2025-08-07'),(270,13,2,15.00,'USD','Unknown',NULL,'2025-08-07'),(271,14,1,30.00,'USD','Unknown',NULL,'2025-08-07'),(272,15,2,10.00,'USD','Unknown',NULL,'2025-08-07'),(273,16,1,12.00,'USD','Unknown',NULL,'2025-08-07'),(274,17,2,25.00,'USD','Unknown',NULL,'2025-08-07'),(275,18,2,18.00,'USD','Unknown',NULL,'2025-08-07'),(276,19,2,50.00,'USD','Unknown',NULL,'2025-08-07'),(277,20,2,18.00,'USD','Unknown',NULL,'2025-08-07'),(278,21,2,7.00,'USD','Unknown',NULL,'2025-08-07'),(279,22,2,50.00,'USD','Unknown',NULL,'2025-08-07'),(280,23,2,15.00,'USD','Unknown',NULL,'2025-08-07'),(281,24,2,14.00,'USD','Unknown',NULL,'2025-08-07'),(282,25,2,200.00,'USD','Unknown',NULL,'2025-08-07'),(283,26,1,10.00,'USD','Unknown',NULL,'2025-08-07'),(284,27,2,15.00,'USD','Unknown',NULL,'2025-08-07'),(285,28,2,15.00,'USD','Unknown',NULL,'2025-08-07'),(286,29,2,30.00,'USD','Unknown',NULL,'2025-08-07'),(287,30,1,14.00,'USD','Unknown',NULL,'2025-08-07'),(288,31,2,10.00,'USD','Unknown',NULL,'2025-08-07'),(289,32,1,16.00,'USD','Unknown',NULL,'2025-08-07'),(290,33,2,8.00,'USD','Unknown',NULL,'2025-08-07'),(291,35,1,35.00,'USD','Unknown',NULL,'2025-08-07'),(292,36,1,35.00,'USD','Unknown',NULL,'2025-08-07'),(293,38,2,120.00,'USD','Unknown',NULL,'2025-08-07'),(294,39,2,125.00,'USD','Unknown',NULL,'2025-08-07'),(295,40,2,18.00,'USD','Unknown',NULL,'2025-08-07'),(296,41,2,25.00,'USD','Unknown',NULL,'2025-08-07'),(297,43,2,18.00,'USD','Unknown',NULL,'2025-08-07'),(298,44,2,19.00,'USD','Unknown',NULL,'2025-08-07'),(299,45,2,95.00,'USD','Unknown',NULL,'2025-08-07'),(300,46,2,7.00,'USD','Unknown',NULL,'2025-08-07'),(301,48,2,14.00,'USD','Unknown',NULL,'2025-08-07'),(302,49,2,17.00,'USD','Unknown',NULL,'2025-08-07'),(303,50,1,32.00,'USD','Unknown',NULL,'2025-08-07'),(304,51,2,20.00,'USD','Unknown',NULL,'2025-08-07'),(305,52,2,30.00,'USD','Unknown',NULL,'2025-08-07'),(306,53,2,69.95,'USD','Unknown',NULL,'2025-08-07'),(307,54,2,13.00,'USD','Unknown',NULL,'2025-08-07'),(308,55,2,30.00,'USD','Unknown',NULL,'2025-08-07'),(309,57,2,12.00,'USD','Unknown',NULL,'2025-08-07'),(310,58,2,6.99,'USD','Unknown',NULL,'2025-08-07'),(311,59,2,30.00,'USD','Unknown',NULL,'2025-08-07'),(312,60,2,45.00,'USD','Unknown',NULL,'2025-08-07'),(313,61,2,15.00,'USD','Unknown',NULL,'2025-08-07'),(314,62,2,40.00,'USD','Unknown',NULL,'2025-08-07'),(315,63,2,20.00,'USD','Unknown',NULL,'2025-08-07'),(316,64,2,315.00,'USD','Unknown',NULL,'2025-08-07'),(317,66,2,18.00,'USD','Unknown',NULL,'2025-08-07'),(318,67,2,48.99,'USD','Unknown',NULL,'2025-08-07'),(319,69,2,7.00,'USD','Unknown',NULL,'2025-08-07'),(320,70,2,18.00,'USD','Unknown',NULL,'2025-08-07'),(321,71,2,13.00,'USD','Unknown',NULL,'2025-08-07'),(322,72,2,8.00,'USD','Unknown',NULL,'2025-08-07'),(323,73,1,42.00,'USD','Unknown',NULL,'2025-08-07'),(324,74,2,20.00,'USD','Unknown',NULL,'2025-08-07'),(325,75,2,18.00,'USD','Unknown',NULL,'2025-08-07'),(326,76,1,40.00,'USD','Unknown',NULL,'2025-08-07'),(327,77,2,25.00,'USD','Unknown',NULL,'2025-08-07'),(328,78,2,8.00,'USD','Unknown',NULL,'2025-08-07'),(329,79,2,14.00,'USD','Unknown',NULL,'2025-08-07'),(330,80,2,100.00,'USD','Unknown',NULL,'2025-08-07'),(331,81,2,16.00,'USD','Unknown',NULL,'2025-08-07'),(332,82,2,10.00,'USD','Unknown',NULL,'2025-08-07'),(333,84,2,200.00,'USD','Unknown',NULL,'2025-08-07'),(334,85,2,16.00,'USD','Unknown',NULL,'2025-08-07'),(335,86,2,15.00,'USD','Unknown',NULL,'2025-08-07'),(336,87,1,13.00,'USD','Unknown',NULL,'2025-08-07'),(337,88,2,13.00,'USD','Unknown',NULL,'2025-08-07'),(338,90,2,15.00,'USD','Unknown',NULL,'2025-08-07'),(339,92,2,8.00,'USD','Unknown',NULL,'2025-08-07'),(340,94,2,16.00,'USD','Unknown',NULL,'2025-08-07'),(341,95,2,15.00,'USD','Unknown',NULL,'2025-08-07'),(342,97,2,20.00,'USD','Unknown',NULL,'2025-08-07'),(343,98,2,400.00,'USD','Unknown',NULL,'2025-08-07'),(344,100,2,18.00,'USD','Unknown',NULL,'2025-08-07');
/*!40000 ALTER TABLE `game_prices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_publishers`
--

DROP TABLE IF EXISTS `game_publishers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_publishers` (
  `game_id` int NOT NULL,
  `publisher_id` int NOT NULL,
  PRIMARY KEY (`game_id`,`publisher_id`),
  KEY `idx_game_publishers_publisher` (`publisher_id`),
  CONSTRAINT `game_publishers_ibfk_1` FOREIGN KEY (`game_id`) REFERENCES `boardgames` (`game_id`) ON DELETE CASCADE,
  CONSTRAINT `game_publishers_ibfk_2` FOREIGN KEY (`publisher_id`) REFERENCES `publishers` (`publisher_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_publishers`
--

LOCK TABLES `game_publishers` WRITE;
/*!40000 ALTER TABLE `game_publishers` DISABLE KEYS */;
INSERT INTO `game_publishers` (`game_id`, `publisher_id`) VALUES (13,1),(18,1),(15,2),(1,3),(19,3),(2,4),(3,4),(5,4),(7,4),(16,4),(6,5),(11,5),(12,6),(10,7),(20,7),(14,8),(4,9),(8,11),(9,11),(17,11),(14,45),(9,49),(8,61),(12,75),(6,82),(3,84),(18,130),(11,141),(15,159),(13,162),(1,167),(4,173),(5,173),(2,181),(16,182),(17,186),(1,562),(7,563),(10,564),(19,566),(20,567);
/*!40000 ALTER TABLE `game_publishers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_reimplementations`
--

DROP TABLE IF EXISTS `game_reimplementations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_reimplementations` (
  `game_id` int NOT NULL,
  `reimplementation_id` int NOT NULL,
  PRIMARY KEY (`game_id`,`reimplementation_id`),
  KEY `reimplementation_id` (`reimplementation_id`),
  CONSTRAINT `game_reimplementations_ibfk_1` FOREIGN KEY (`game_id`) REFERENCES `boardgames` (`game_id`) ON DELETE CASCADE,
  CONSTRAINT `game_reimplementations_ibfk_2` FOREIGN KEY (`reimplementation_id`) REFERENCES `reimplemented_games` (`reimplementation_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_reimplementations`
--

LOCK TABLES `game_reimplementations` WRITE;
/*!40000 ALTER TABLE `game_reimplementations` DISABLE KEYS */;
INSERT INTO `game_reimplementations` (`game_id`, `reimplementation_id`) VALUES (8,24),(1,88),(7,89),(15,90);
/*!40000 ALTER TABLE `game_reimplementations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mechanisms`
--

DROP TABLE IF EXISTS `mechanisms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mechanisms` (
  `mechanism_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`mechanism_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=443 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mechanisms`
--

LOCK TABLES `mechanisms` WRITE;
/*!40000 ALTER TABLE `mechanisms` DISABLE KEYS */;
INSERT INTO `mechanisms` (`mechanism_id`, `name`) VALUES (1,'Action / Event'),(2,'Action Drafting'),(3,'Action Points'),(4,'Action Queue'),(5,'Action Retrieval'),(6,'Advantage Token'),(7,'Alliances'),(8,'Area Majority / Influence'),(9,'Area Movement'),(10,'Area-Impulse'),(328,'Asymmetric Player Powers'),(11,'Auction / Bidding'),(12,'Auction: Dutch'),(13,'Auction: Turn Order Until Pass'),(14,'Automatic Resource Growth'),(15,'Betting and Bluffing'),(16,'Bias'),(17,'Bribery'),(18,'Campaign / Battle Card Driven'),(19,'Card Play Conflict Resolution'),(20,'Catch the Leader'),(21,'Chaining'),(22,'Chit-Pull System'),(23,'Closed Drafting'),(24,'Commodity Speculation'),(25,'Communication Limits'),(26,'Connections'),(27,'Constrained Bidding'),(28,'Contracts'),(29,'Cooperative Game'),(30,'Critical Hits and Failures'),(31,'Deck Construction'),(32,'Deck, Bag, and Pool Building'),(33,'Deduction'),(34,'Delayed Purchase'),(35,'Dice Rolling'),(36,'Die Icon Resolution'),(330,'Drafting'),(37,'Enclosure'),(38,'End Game Bonuses'),(39,'Events'),(40,'Flicking'),(41,'Follow'),(42,'Force Commitment'),(43,'Grid Coverage'),(44,'Grid Movement'),(45,'Hand Management'),(46,'Hexagon Grid'),(47,'Hidden Roles'),(48,'Hidden Victory Points'),(49,'Highest-Lowest Scoring'),(50,'Hot Potato'),(51,'Income'),(52,'Increase Value of Unchosen Resources'),(53,'Interrupts'),(54,'Investment'),(55,'Kill Steal'),(56,'Layering'),(57,'Legacy Game'),(58,'Line of Sight'),(59,'Loans'),(60,'Mancala'),(61,'Map Addition'),(62,'Map Deformation'),(63,'Map Reduction'),(64,'Market'),(65,'Melding and Splaying'),(66,'Modular Board'),(67,'Movement Points'),(68,'Multi-Use Cards'),(69,'Narrative Choice / Paragraph'),(70,'Negotiation'),(71,'Network and Route Building'),(72,'Once-Per-Game Abilities'),(73,'Open Drafting'),(74,'Ownership'),(75,'Pattern Building'),(76,'Pick-up and Deliver'),(77,'Player Elimination'),(78,'Point to Point Movement'),(79,'Prisoner\'s Dilemma'),(80,'Programmed Movement'),(81,'Push Your Luck'),(82,'Race'),(83,'Resource to Move'),(84,'Role Playing'),(85,'Roles with Asymmetric Information'),(86,'Scenario / Mission / Campaign Game'),(87,'Secret Unit Deployment'),(88,'Selection Order Bid'),(89,'Set Collection'),(90,'Simulation'),(91,'Simultaneous Action Selection'),(92,'Solo / Solitaire Game'),(93,'Square Grid'),(94,'Tags'),(95,'Take That'),(96,'Team-Based Game'),(97,'Tile Placement'),(98,'Track Movement'),(329,'Trading'),(99,'Trick-taking'),(100,'Turn Order: Auction'),(101,'Turn Order: Claim Action'),(102,'Turn Order: Progressive'),(103,'Variable Phase Order'),(104,'Variable Player Powers'),(105,'Variable Set-up'),(106,'Victory Points as a Resource'),(107,'Voting'),(108,'Worker Placement'),(109,'Worker Placement, Different Worker Types');
/*!40000 ALTER TABLE `mechanisms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publishers`
--

DROP TABLE IF EXISTS `publishers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `publishers` (
  `publisher_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`publisher_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=761 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publishers`
--

LOCK TABLES `publishers` WRITE;
/*!40000 ALTER TABLE `publishers` DISABLE KEYS */;
INSERT INTO `publishers` (`publisher_id`, `name`) VALUES (1,'(Public Domain)'),(2,'(Self-Published)'),(3,'(Unknown)'),(4,'2F-Spiele'),(5,'2Tomatoes Games'),(6,'4GAMES'),(7,'999 Games'),(8,'A-Z kiadó'),(9,'ABACUSSPIELE'),(11,'Abraxas'),(12,'Ace Studios'),(13,'Across the Board'),(14,'Action Phase Games'),(10,'ADC Blackfire Entertainment'),(15,'Albi'),(16,'Albi Polska'),(17,'Alderac Entertainment Group'),(182,'alea'),(183,'alfaset'),(18,'Angry Lion Games'),(19,'Användbart Litet Företag'),(20,'Aporta Games'),(21,'Arclight Games'),(22,'Ares Games'),(23,'Arrakis Games'),(184,'asmodee'),(24,'Asterion Press'),(25,'Atalia'),(26,'Automa Factory'),(27,'Awaken Realms'),(29,'Baldar'),(30,'Banana Games'),(31,'Bard Centrum Gier'),(32,'Belleville (Бельвіль)'),(28,'BGA Plus'),(33,'Black Sea Games'),(34,'Blackrock Games'),(35,'Bluebird Games'),(36,'Board Game Rookie'),(38,'Boardgame Mall'),(39,'Boardgame Space'),(37,'BoardM Factory'),(43,'Brädspel.se'),(40,'Brain Games'),(41,'Broadway Toys LTD'),(42,'BrownCastle Games'),(44,'Bumble3ee Interactive'),(47,'Capstone Games'),(48,'Carrom Company'),(49,'Cephalofair Games'),(50,'Chip Theory Games'),(51,'Chrononauts Games'),(45,'CMON Global Limited'),(46,'CMYK'),(52,'Cogitate Games'),(53,'Compaya.hu: Gamer Café Kft.'),(54,'Conclave Editora'),(55,'Contention Games'),(56,'Cool Mini Or Not'),(57,'CoolPlay'),(58,'Cranio Creations'),(59,'CrowD Games'),(60,'Czacha Games'),(61,'Czech Games Edition'),(64,'Days of Wonder'),(65,'Delicious Games'),(66,'Delirium Games'),(67,'Delta Vision Publishing'),(68,'Descartes Editeur'),(69,'Devir'),(70,'Dice Realm'),(71,'DiceTree Games'),(72,'Dire Wolf'),(73,'Divercentro'),(185,'dlp games'),(74,'Don\'t Panic Games'),(62,'DSV Games'),(63,'DV Games'),(75,'Eagle-Gryphon Games'),(76,'Edge Entertainment'),(77,'Ediciones MasQueOca'),(78,'Editions Philibert'),(186,'eggertspiele'),(79,'Egmont Polska'),(80,'Engames'),(81,'Fantasmagoria'),(82,'Fantasy Flight Games'),(83,'Feelindigo'),(84,'Feuerland Spiele'),(85,'Fever Games'),(86,'Filosofia Éditions'),(87,'Fire on Board Jogos'),(88,'Fishbone Games'),(89,'Flatout Games'),(90,'Fox in the Box'),(91,'Frosted Games'),(92,'Fruhling-Honpo'),(93,'FryxGames'),(94,'Funforge'),(95,'Funtails'),(99,'Gabinete Lúdico'),(98,'GaGa Games'),(100,'Galakta'),(101,'Galápagos Jogos'),(102,'Game Harbor'),(103,'Game\'s Up'),(104,'Gameland 游戏大陆'),(105,'Games Factory Publishing'),(106,'Games Warehouse'),(107,'Games4you'),(108,'Games7Days'),(109,'Garphill Games'),(110,'Geekach LLC'),(122,'Gém Klub Kft.'),(111,'Gen-X Games'),(112,'Ghenos Games'),(113,'Giant Roc'),(114,'Giochi Uniti'),(115,'Giochix.it'),(96,'GMT Games'),(116,'GoKids 玩樂小子'),(97,'GP Games'),(117,'Greater Than Games, LLC'),(118,'Green Elephant Games'),(119,'Grok Games'),(120,'Grow Jogos e Brinquedos'),(121,'Guillotine Games'),(123,'Hans im Glück'),(124,'Hegemonic Project Games'),(125,'Heidelberger Spieleverlag'),(187,'hobbity.eu'),(126,'Hobby Japan'),(127,'Hobby World'),(128,'Indie Boards & Cards'),(129,'Intrafin Games'),(562,'Iron Clays'),(131,'Kaissa Chess & Games'),(132,'Karma Games'),(133,'Kayenta Games'),(134,'Keep Exploring Games'),(135,'Kilogames'),(136,'Kingdom Death'),(137,'Korea Boardgames'),(130,'KOSMOS'),(138,'Lacerta'),(139,'Lautapelit.fi'),(140,'Lavka Games'),(141,'Leder Games'),(142,'Libellud'),(143,'Lifestyle Boardgames Ltd'),(144,'Lookout Games'),(564,'Lookout Spiele'),(145,'Lucky Duck Games'),(146,'Lucrum Games'),(147,'Maldito Games'),(148,'Mandala Jogos'),(149,'Matagot'),(150,'MeepleBR'),(151,'Mindclash Games'),(152,'NECA'),(153,'NeoTroy Games'),(154,'Next Move Games'),(155,'Old Dawg'),(156,'PD-Verlag'),(157,'Penny Arcade'),(158,'Plan B Games'),(567,'Portal Games'),(159,'Ravensburger'),(160,'Rawstone'),(161,'Rebel Sp. z o.o.'),(162,'Red Raven Games'),(163,'Renegade Game Studios'),(164,'Repos Production'),(165,'Rio Grande Games'),(166,'Riot Games'),(167,'Roxley'),(168,'Schmidt Spiele'),(169,'Scorpion Masqué'),(170,'Shadowborne Games'),(566,'Space Cowboys'),(171,'Splotter Spellen'),(172,'Starling Games (II)'),(173,'Stonemaier Games'),(174,'The Pandemonium Institute'),(175,'ThunderGryph Games'),(563,'Treefrog Games'),(176,'Warfrog Games'),(177,'Wehrlegig Games'),(179,'Wizards of the Coast'),(178,'WizKids (I)'),(180,'Ystari Games'),(181,'Z-Man Games');
/*!40000 ALTER TABLE `publishers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reimplemented_games`
--

DROP TABLE IF EXISTS `reimplemented_games`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reimplemented_games` (
  `reimplementation_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`reimplementation_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=123 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reimplemented_games`
--

LOCK TABLES `reimplemented_games` WRITE;
/*!40000 ALTER TABLE `reimplemented_games` DISABLE KEYS */;
INSERT INTO `reimplemented_games` (`reimplementation_id`, `name`) VALUES (1,'7 Wonders'),(2,'7 Wonders Duel'),(89,'Age of Steam'),(3,'Agricola'),(88,'Brass'),(4,'Brass: Lancashire'),(5,'Clank!: A Deck-Building Adventure'),(6,'Descent: Journeys in the Dark'),(7,'Descent: Journeys in the Dark (Second Edition)'),(8,'Eclipse: New Dawn for the Galaxy'),(9,'Funkenschlag'),(10,'Great Western Trail'),(11,'Great Western Trail: Second Edition'),(12,'Great Western Trail: The Eleventh Building Tile'),(13,'Kanban: Driver\'s Edition'),(14,'Mansions of Madness'),(15,'Midgard'),(16,'Netrunner'),(17,'Pandemic'),(18,'Pandemic Legacy: Season 1'),(19,'Pandemic Legacy: Season 2'),(20,'Pax Pamir'),(21,'Pax Pamir: Khyber Knives'),(90,'Ra'),(22,'Terra Mystica'),(23,'The Crew: The Quest for Planet Nine'),(24,'Through the Ages: A Story of Civilization'),(25,'Ticket to Ride'),(26,'Twilight Imperium: Third Edition'),(27,'Viticulture'),(28,'War of the Ring'),(29,'Weapons of Zombie Destruction');
/*!40000 ALTER TABLE `reimplemented_games` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stores`
--

DROP TABLE IF EXISTS `stores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stores` (
  `store_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text,
  `website_url` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`store_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stores`
--

LOCK TABLES `stores` WRITE;
/*!40000 ALTER TABLE `stores` DISABLE KEYS */;
INSERT INTO `stores` (`store_id`, `name`, `description`, `website_url`) VALUES (1,'GeekMarket','BoardGameGeek official marketplace','https://boardgamegeek.com/geekmarket'),(2,'GeekMarket API','BoardGameGeek marketplace via API','https://boardgamegeek.com/api/geekmarket'),(3,'GeekMarket Section','BoardGameGeek marketplace section','https://boardgamegeek.com/geekmarket'),(4,'GeekMarket JS','BoardGameGeek marketplace JavaScript','https://boardgamegeek.com/geekmarket'),(5,'Community Marketplace','Community-driven marketplace',NULL);
/*!40000 ALTER TABLE `stores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `v_game_details`
--

DROP TABLE IF EXISTS `v_game_details`;
/*!50001 DROP VIEW IF EXISTS `v_game_details`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_game_details` AS SELECT 
 1 AS `game_id`,
 1 AS `rank_position`,
 1 AS `title`,
 1 AS `year_published`,
 1 AS `geek_rating`,
 1 AS `avg_rating`,
 1 AS `users_voted`,
 1 AS `min_players`,
 1 AS `max_players`,
 1 AS `min_playtime`,
 1 AS `max_playtime`,
 1 AS `min_age`,
 1 AS `complexity_rating`,
 1 AS `community_owned`,
 1 AS `community_wishlist`,
 1 AS `num_comments`,
 1 AS `num_plays`,
 1 AS `fans`,
 1 AS `designers`,
 1 AS `artists`,
 1 AS `publishers`,
 1 AS `categories`,
 1 AS `mechanisms`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_game_pricing`
--

DROP TABLE IF EXISTS `v_game_pricing`;
/*!50001 DROP VIEW IF EXISTS `v_game_pricing`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_game_pricing` AS SELECT 
 1 AS `game_id`,
 1 AS `title`,
 1 AS `rank_position`,
 1 AS `price_count`,
 1 AS `min_price`,
 1 AS `max_price`,
 1 AS `avg_price`,
 1 AS `available_stores`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'boardgame_db'
--

--
-- Current Database: `boardgame_db`
--

USE `boardgame_db`;

--
-- Final view structure for view `v_game_details`
--

/*!50001 DROP VIEW IF EXISTS `v_game_details`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_game_details` AS select `bg`.`game_id` AS `game_id`,`bg`.`rank_position` AS `rank_position`,`bg`.`title` AS `title`,`bg`.`year_published` AS `year_published`,`bg`.`geek_rating` AS `geek_rating`,`bg`.`avg_rating` AS `avg_rating`,`bg`.`users_voted` AS `users_voted`,`bg`.`min_players` AS `min_players`,`bg`.`max_players` AS `max_players`,`bg`.`min_playtime` AS `min_playtime`,`bg`.`max_playtime` AS `max_playtime`,`bg`.`min_age` AS `min_age`,`bg`.`complexity_rating` AS `complexity_rating`,`bg`.`community_owned` AS `community_owned`,`bg`.`community_wishlist` AS `community_wishlist`,`bg`.`num_comments` AS `num_comments`,`bg`.`num_plays` AS `num_plays`,`bg`.`fans` AS `fans`,group_concat(distinct `d`.`name` separator ', ') AS `designers`,group_concat(distinct `a`.`name` separator ', ') AS `artists`,group_concat(distinct `p`.`name` separator ', ') AS `publishers`,group_concat(distinct `c`.`name` separator ', ') AS `categories`,group_concat(distinct `m`.`name` separator ', ') AS `mechanisms` from ((((((((((`boardgames` `bg` left join `game_designers` `gd` on((`bg`.`game_id` = `gd`.`game_id`))) left join `designers` `d` on((`gd`.`designer_id` = `d`.`designer_id`))) left join `game_artists` `ga` on((`bg`.`game_id` = `ga`.`game_id`))) left join `artists` `a` on((`ga`.`artist_id` = `a`.`artist_id`))) left join `game_publishers` `gp` on((`bg`.`game_id` = `gp`.`game_id`))) left join `publishers` `p` on((`gp`.`publisher_id` = `p`.`publisher_id`))) left join `game_categories` `gc` on((`bg`.`game_id` = `gc`.`game_id`))) left join `categories` `c` on((`gc`.`category_id` = `c`.`category_id`))) left join `game_mechanisms` `gm` on((`bg`.`game_id` = `gm`.`game_id`))) left join `mechanisms` `m` on((`gm`.`mechanism_id` = `m`.`mechanism_id`))) group by `bg`.`game_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_game_pricing`
--

/*!50001 DROP VIEW IF EXISTS `v_game_pricing`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_game_pricing` AS select `bg`.`game_id` AS `game_id`,`bg`.`title` AS `title`,`bg`.`rank_position` AS `rank_position`,count(`gp`.`price_id`) AS `price_count`,min(`gp`.`price`) AS `min_price`,max(`gp`.`price`) AS `max_price`,avg(`gp`.`price`) AS `avg_price`,group_concat(distinct `s`.`name` separator ', ') AS `available_stores` from ((`boardgames` `bg` left join `game_prices` `gp` on((`bg`.`game_id` = `gp`.`game_id`))) left join `stores` `s` on((`gp`.`store_id` = `s`.`store_id`))) group by `bg`.`game_id` */;
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

-- Dump completed on 2025-08-08  8:45:34
