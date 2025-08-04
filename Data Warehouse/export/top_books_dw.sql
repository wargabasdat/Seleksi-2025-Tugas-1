/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.4.5-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: books_dw
-- ------------------------------------------------------
-- Server version	11.4.5-MariaDB

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
-- Table structure for table `dim_author`
--

DROP TABLE IF EXISTS `dim_author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `dim_author` (
  `author_id` int(11) NOT NULL AUTO_INCREMENT,
  `author_name` varchar(255) NOT NULL,
  PRIMARY KEY (`author_id`)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dim_author`
--

LOCK TABLES `dim_author` WRITE;
/*!40000 ALTER TABLE `dim_author` DISABLE KEYS */;
INSERT INTO `dim_author` VALUES
(1,'Walt Whitman'),
(2,'Doris May Lessing'),
(3,'Raymond Chandler'),
(4,'Louisa May Alcott'),
(5,'Mary Shelley'),
(6,'Sylvia Plath'),
(7,'Marcel Proust'),
(8,'Ernest Hemingway'),
(9,'Fyodor Dostoevsky'),
(10,'George Eliot'),
(11,'Oscar Wilde'),
(12,'T. S. Eliot'),
(13,'Boris Pasternak'),
(14,'Johann Wolfgang von Goethe'),
(15,'Jonathan Swift'),
(16,'Thomas Mann'),
(17,'Malcolm Lowry'),
(18,'Robert Louis Stevenson'),
(19,'Bram Stoker'),
(20,'Dante Alighieri'),
(21,'Stendhal'),
(22,'Samuel Beckett'),
(23,'George Orwell'),
(24,'Carson McCullers'),
(25,'Robert Musil'),
(26,'Giuseppe Tomasi di Lampedusa'),
(27,'Daphne du Maurier'),
(28,'Herman Melville'),
(29,'Homer'),
(30,'Mark Twain'),
(31,'Margaret Mitchell'),
(32,'Louis-Ferdinand Céline'),
(33,'Jack Kerouac'),
(34,'Mikhail Bulgakov'),
(35,'J. D. Salinger'),
(36,'Emily Brontë'),
(37,'John Steinbeck'),
(38,'F. Scott Fitzgerald'),
(39,'Edgar Allan Poe'),
(40,'Gabriel García Márquez'),
(41,'Gustave Flaubert'),
(42,'Milan Kundera'),
(43,'Albert Camus'),
(44,'William Makepeace Thackeray'),
(45,'J. R. R. Tolkien'),
(46,'Laurence Sterne'),
(47,'Alexandre Dumas'),
(48,'Franz Kafka'),
(49,'Truman Capote'),
(50,'Vladimir Nabokov'),
(51,'Michel de Montaigne'),
(52,'Jorge Luis Borges'),
(53,'Ford Madox Ford'),
(54,'Virginia Woolf'),
(55,'Lewis Carroll'),
(56,'Frank Herbert'),
(57,'Henry David Thoreau'),
(58,'Edith Wharton'),
(59,'Joseph Conrad'),
(60,'Geoffrey Chaucer'),
(61,'E. B. White'),
(62,'Jane Austen'),
(63,'E. M. Forster'),
(64,'Harper Lee'),
(65,'Virgil'),
(66,'Kurt Vonnegut'),
(67,'Toni Morrison'),
(68,'Antoine de Saint-Exupéry'),
(69,'William Shakespeare'),
(70,'Ralph Ellison'),
(71,'Charlotte Brontë'),
(72,'Sophocles'),
(73,'Nikolai Gogol'),
(74,'Anton Chekhov'),
(75,'Charles Dickens'),
(76,'Leo Tolstoy'),
(77,'Chinua Achebe'),
(78,'Voltaire'),
(79,'Günter Grass'),
(80,'Zora Neale Hurston'),
(81,'James Joyce'),
(82,'Thomas Hardy'),
(83,'William Faulkner'),
(84,'Anne Frank'),
(85,'Henry James'),
(86,'Nathaniel Hawthorne'),
(87,'Richard Wright'),
(88,'Unknown'),
(89,'Aldous Huxley'),
(90,'Joseph Heller'),
(91,'Salman Rushdie'),
(92,'Erich Maria Remarque'),
(93,'Daniel Defoe'),
(94,'Victor Hugo'),
(95,'William Golding'),
(96,'Miguel de Cervantes');
/*!40000 ALTER TABLE `dim_author` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dim_book`
--

DROP TABLE IF EXISTS `dim_book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `dim_book` (
  `book_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `year` int(11) NOT NULL,
  `pages` varchar(255) NOT NULL,
  PRIMARY KEY (`book_id`)
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dim_book`
--

LOCK TABLES `dim_book` WRITE;
/*!40000 ALTER TABLE `dim_book` DISABLE KEYS */;
INSERT INTO `dim_book` VALUES
(1,'Ulysses',1922,'730-1000'),
(2,'In Search of Lost Time',1913,'3000-4300'),
(3,'The Great Gatsby',1925,'47-180'),
(4,'The Catcher in the Rye',1951,'220-277'),
(5,'One Hundred Years of Solitude',1967,'300-500'),
(6,'Nineteen Eighty Four',1949,'300-400'),
(7,'Moby-Dick',1851,'600-700'),
(8,'The Sound and the Fury',1929,'320'),
(9,'Don Quixote',1605,'800-1000'),
(10,'Anna Karenina',1877,'800-1000'),
(11,'Crime and Punishment',1866,'430-600'),
(12,'Pride and Prejudice',1813,'432'),
(13,'War and Peace',1869,'1225-1500'),
(14,'Lolita',1955,'300-400'),
(15,'Wuthering Heights',1847,'300-400'),
(16,'The Lord of the Rings',1954,'1000-1500'),
(17,'To Kill a Mockingbird',1960,'281-500'),
(18,'The Bible',-1400,'1200-1600'),
(19,'The Brothers Karamazov',1880,'700-800'),
(20,'Adventures of Huckleberry Finn',1884,'200-400'),
(21,'The Trial',1925,'200-300'),
(22,'The Stranger',1942,'120-160'),
(23,'Madame Bovary',1857,'300-450'),
(24,'The Odyssey',-740,'300-500'),
(25,'The Grapes of Wrath',1939,'464'),
(26,'The Magic Mountain',1924,'700-1000'),
(27,'The Divine Comedy',1308,'300-500'),
(28,'To the Lighthouse',1927,'200-300'),
(29,'Jane Eyre',1847,'300-500'),
(30,'Middlemarch',1871,'700-900'),
(31,'Heart of Darkness',1899,'70-200'),
(32,'Alice\'s Adventures in Wonderland',1865,'92-202'),
(33,'Invisible Man',1952,'200-600'),
(34,'The Master and Margarita',1967,'250-500'),
(35,'Catch-22',1961,'450-550'),
(36,'Mrs. Dalloway',1925,'150-200'),
(37,'The Iliad',-750,'300-700'),
(38,'Les Misérables',1862,'1200-1500'),
(39,'Great Expectations',1860,'500-600'),
(40,'On the Road',1957,'310'),
(41,'The Red and the Black',1830,'300-500'),
(42,'Frankenstein',1818,'280-320'),
(43,'Absalom, Absalom!',1936,'300-400'),
(44,'Fictions',1944,'174'),
(45,'The Little Prince',1943,'93-96'),
(46,'One Thousand and One Nights',800,'800-1000'),
(47,'Journey to the End of The Night',1932,'400-600'),
(48,'David Copperfield',1849,'600-900'),
(49,'Brave New World',1932,'200-300'),
(50,'The Old Man and the Sea',1952,'120-140'),
(51,'Lord of the Flies',1954,'224'),
(52,'Beloved',1987,'275-350'),
(53,'Gone With the Wind',1936,'959-1037'),
(54,'Animal Farm',1945,'50-150'),
(55,'The Idiot',1869,'600-800'),
(56,'Under the Volcano',1947,'300-400'),
(57,'Dracula',1897,'398'),
(58,'The Life And Opinions Of Tristram Shandy',1759,'500-600'),
(59,'The Leopard',1958,'200-300'),
(60,'The Golden Notebook',1962,'576-640'),
(61,'The Sun Also Rises',1926,'200-300'),
(62,'Things Fall Apart',1958,'200-250'),
(63,'Gulliver\'s Travels',1726,'300-400'),
(64,'Rebecca',1938,'300-400'),
(65,'The Aeneid',-19,'395'),
(66,'Leaves of Grass',1855,'95-438'),
(67,'Essays',1580,'800-1500'),
(68,'Their Eyes Were Watching God',1937,'200-300'),
(69,'Midnight\'s Children',1981,'450-550'),
(70,'The Scarlet Letter',1850,'200-300'),
(71,'Hamlet',1600,'100-200'),
(72,'A Passage to India',1924,'200-400'),
(73,'A Farewell to Arms',1929,'300-500'),
(74,'Robinson Crusoe',1719,'200-300'),
(75,'The Plague',1947,'200-300'),
(76,'Candide',1759,'100-200'),
(77,'The Portrait of a Lady',1881,'400-600'),
(78,'Pale Fire',1962,'200-300'),
(79,'The Castle',1926,'200-300'),
(80,'The Metamorphosis',1915,'40-100'),
(81,'Slaughterhouse-Five',1969,'275-320'),
(82,'All Quiet on the Western Front',1928,'200-300'),
(83,'The Count of Monte Cristo',1844,'1200-1400'),
(84,'The Tin Drum',1959,'500-600'),
(85,'The Good Soldier',1915,'200-300'),
(86,'As I Lay Dying',1930,'200-300'),
(87,'The Picture of Dorian Gray',1890,'208'),
(88,'Little Women',1868,'300-500'),
(89,'A Portrait of the Artist as a Young Man',1916,'200-300'),
(90,'Faust',1808,'327'),
(91,'Buddenbrooks',1901,'700-1000'),
(92,'The Man Without Qualities',1930,'1000-2000'),
(93,'Waiting for Godot',1953,'60-128'),
(94,'Emma',1815,'300-500'),
(95,'Demons',1872,'500-800'),
(96,'The Age of Innocence',1920,'300-400'),
(97,'For Whom the Bell Tolls',1940,'450-500'),
(98,'Dead Souls',1842,'300-550'),
(99,'Orlando',1928,'200-300'),
(100,'Oedipus the King',-429,'128'),
(101,'The Complete Tales and Poems of Edgar Allan Poe',1902,'1000-1500'),
(102,'Native Son',1940,'350-500'),
(103,'Dune',1965,'400-500'),
(104,'The Waste Land',1922,'64-88'),
(105,'The Unbearable Lightness of Being',1984,'200-400'),
(106,'Walden',1854,'200-350'),
(107,'Doctor Zhivago',1957,'450-700'),
(108,'Charlotte\'s Web',1952,'192'),
(109,'The Canterbury Tales',1400,'300-500'),
(110,'The Bell Jar',1963,'200-300'),
(111,'In Cold Blood',1966,'300-400'),
(112,'Treasure Island',1883,'192'),
(113,'Vanity Fair',1847,'900-1000'),
(114,'The Big Sleep',1939,'200-300'),
(115,'The Heart Is A Lonely Hunter',1940,'300-400'),
(116,'Tess of the d\'Urbervilles',1891,'400-500'),
(117,'The Three Musketeers',1844,'400-700'),
(118,'The Stories of Anton Chekhov',1900,'460'),
(119,'Antigone',-441,'80'),
(120,'The Diary of a Young Girl',1947,'220-340');
/*!40000 ALTER TABLE `dim_book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dim_country`
--

DROP TABLE IF EXISTS `dim_country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `dim_country` (
  `country_id` int(11) NOT NULL AUTO_INCREMENT,
  `country_name` varchar(255) NOT NULL,
  PRIMARY KEY (`country_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dim_country`
--

LOCK TABLES `dim_country` WRITE;
/*!40000 ALTER TABLE `dim_country` DISABLE KEYS */;
INSERT INTO `dim_country` VALUES
(1,'Dutch'),
(2,'French'),
(3,'Jewish'),
(4,'Colombian'),
(5,'Multiple'),
(6,'Italian'),
(7,'Indian'),
(8,'American'),
(9,'Spanish'),
(10,'German'),
(11,'Austrian'),
(12,'Nigerian'),
(13,'Russian'),
(14,'Irish'),
(15,'Argentinian'),
(16,'Roman'),
(17,'British'),
(18,'Greek'),
(19,'Czech');
/*!40000 ALTER TABLE `dim_country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dim_date`
--

DROP TABLE IF EXISTS `dim_date`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `dim_date` (
  `date_id` int(11) NOT NULL,
  `month` int(11) NOT NULL,
  `year` int(11) NOT NULL,
  PRIMARY KEY (`date_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dim_date`
--

LOCK TABLES `dim_date` WRITE;
/*!40000 ALTER TABLE `dim_date` DISABLE KEYS */;
INSERT INTO `dim_date` VALUES
(20250804,8,2025);
/*!40000 ALTER TABLE `dim_date` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dim_genre`
--

DROP TABLE IF EXISTS `dim_genre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `dim_genre` (
  `genre_id` int(11) NOT NULL AUTO_INCREMENT,
  `genre_name` varchar(255) NOT NULL,
  PRIMARY KEY (`genre_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dim_genre`
--

LOCK TABLES `dim_genre` WRITE;
/*!40000 ALTER TABLE `dim_genre` DISABLE KEYS */;
INSERT INTO `dim_genre` VALUES
(1,'Adventure'),
(2,'Experimental'),
(3,'Drama'),
(4,'Dystopian'),
(5,'Children\'s books'),
(6,'Banned books'),
(7,'Crime'),
(8,'Allegorical'),
(9,'Poetry'),
(10,'Dark'),
(11,'Family & Relationships'),
(12,'Absurdist'),
(13,'Cultural'),
(14,'Fiction'),
(15,'20th century'),
(16,'Fantasy'),
(17,'Existentialist'),
(18,'Coming of age'),
(19,'Mythological'),
(20,'Nonfiction');
/*!40000 ALTER TABLE `dim_genre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dim_language`
--

DROP TABLE IF EXISTS `dim_language`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `dim_language` (
  `language_id` int(11) NOT NULL AUTO_INCREMENT,
  `language_name` varchar(255) NOT NULL,
  PRIMARY KEY (`language_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dim_language`
--

LOCK TABLES `dim_language` WRITE;
/*!40000 ALTER TABLE `dim_language` DISABLE KEYS */;
INSERT INTO `dim_language` VALUES
(1,'Ancient greek'),
(2,'Dutch'),
(3,'Spanish'),
(4,'Russian'),
(5,'German'),
(6,'Italian'),
(7,'French'),
(8,'Hebrew'),
(9,'English'),
(10,'Arabic'),
(11,'Czech'),
(12,'Latin'),
(13,'Middle english');
/*!40000 ALTER TABLE `dim_language` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dim_length`
--

DROP TABLE IF EXISTS `dim_length`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `dim_length` (
  `length_id` int(11) NOT NULL AUTO_INCREMENT,
  `length_name` varchar(255) NOT NULL,
  PRIMARY KEY (`length_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dim_length`
--

LOCK TABLES `dim_length` WRITE;
/*!40000 ALTER TABLE `dim_length` DISABLE KEYS */;
INSERT INTO `dim_length` VALUES
(1,'Short'),
(2,'Long'),
(3,'Very Long'),
(4,'Very Short'),
(5,'Medium'),
(6,'Moderate');
/*!40000 ALTER TABLE `dim_length` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dim_subject`
--

DROP TABLE IF EXISTS `dim_subject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `dim_subject` (
  `subject_id` int(11) NOT NULL AUTO_INCREMENT,
  `subject_name` varchar(255) NOT NULL,
  PRIMARY KEY (`subject_id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dim_subject`
--

LOCK TABLES `dim_subject` WRITE;
/*!40000 ALTER TABLE `dim_subject` DISABLE KEYS */;
INSERT INTO `dim_subject` VALUES
(1,'Christianity'),
(2,'Asian History'),
(3,'Deception'),
(4,'Courage'),
(5,'Beauty'),
(6,'Animals'),
(7,'Courtship'),
(8,'Love'),
(9,'Bureaucracy'),
(10,'African American'),
(11,'Forgiveness'),
(12,'Fate'),
(13,'History'),
(14,'Civilization'),
(15,'Death & Grief'),
(16,'Hypocrisy'),
(17,'Adultery'),
(18,'Betrayal'),
(19,'Ambition'),
(20,'Chivalry'),
(21,'Desire'),
(22,'Birth'),
(23,'Community'),
(24,'Death'),
(25,'Addiction'),
(26,'Exploration'),
(27,'Modernity'),
(28,'Criticism'),
(29,'Conformity'),
(30,'Education'),
(31,'Defeat'),
(32,'Blindness'),
(33,'Business'),
(34,'Alcohol'),
(35,'Classical Studies'),
(36,'Dreams'),
(37,'Cultural Conflict'),
(38,'American dream'),
(39,'Existentialism'),
(40,'Creativity'),
(41,'Case studies'),
(42,'Communism'),
(43,'Despair'),
(44,'Comradeship'),
(45,'Divine Intervention'),
(46,'Control'),
(47,'Civil War'),
(48,'Culture'),
(49,'Adolescence'),
(50,'African American History'),
(51,'Freedom'),
(52,'Friendship'),
(53,'Alienation'),
(54,'Beat Generation'),
(55,'Family'),
(56,'Afterlife');
/*!40000 ALTER TABLE `dim_subject` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dim_type`
--

DROP TABLE IF EXISTS `dim_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `dim_type` (
  `type_id` int(11) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(255) NOT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dim_type`
--

LOCK TABLES `dim_type` WRITE;
/*!40000 ALTER TABLE `dim_type` DISABLE KEYS */;
INSERT INTO `dim_type` VALUES
(1,'Nonfiction'),
(2,'Fiction'),
(3,'Religious'),
(4,'Poetry');
/*!40000 ALTER TABLE `dim_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fact_top_books`
--

DROP TABLE IF EXISTS `fact_top_books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `fact_top_books` (
  `book_id` int(11) NOT NULL,
  `type_id` int(11) DEFAULT NULL,
  `length_id` int(11) DEFAULT NULL,
  `author_id` int(11) DEFAULT NULL,
  `country_id` int(11) DEFAULT NULL,
  `language_id` int(11) DEFAULT NULL,
  `genre_id` int(11) DEFAULT NULL,
  `subject_id` int(11) DEFAULT NULL,
  `date_id` int(11) NOT NULL,
  `rank` int(11) DEFAULT NULL,
  `avg_rating` float DEFAULT NULL,
  PRIMARY KEY (`book_id`,`date_id`),
  KEY `type_id` (`type_id`),
  KEY `length_id` (`length_id`),
  KEY `author_id` (`author_id`),
  KEY `country_id` (`country_id`),
  KEY `language_id` (`language_id`),
  KEY `genre_id` (`genre_id`),
  KEY `subject_id` (`subject_id`),
  KEY `date_id` (`date_id`),
  CONSTRAINT `fact_top_books_ibfk_1` FOREIGN KEY (`book_id`) REFERENCES `dim_book` (`book_id`),
  CONSTRAINT `fact_top_books_ibfk_2` FOREIGN KEY (`type_id`) REFERENCES `dim_type` (`type_id`),
  CONSTRAINT `fact_top_books_ibfk_3` FOREIGN KEY (`length_id`) REFERENCES `dim_length` (`length_id`),
  CONSTRAINT `fact_top_books_ibfk_4` FOREIGN KEY (`author_id`) REFERENCES `dim_author` (`author_id`),
  CONSTRAINT `fact_top_books_ibfk_5` FOREIGN KEY (`country_id`) REFERENCES `dim_country` (`country_id`),
  CONSTRAINT `fact_top_books_ibfk_6` FOREIGN KEY (`language_id`) REFERENCES `dim_language` (`language_id`),
  CONSTRAINT `fact_top_books_ibfk_7` FOREIGN KEY (`genre_id`) REFERENCES `dim_genre` (`genre_id`),
  CONSTRAINT `fact_top_books_ibfk_8` FOREIGN KEY (`subject_id`) REFERENCES `dim_subject` (`subject_id`),
  CONSTRAINT `fact_top_books_ibfk_9` FOREIGN KEY (`date_id`) REFERENCES `dim_date` (`date_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fact_top_books`
--

LOCK TABLES `fact_top_books` WRITE;
/*!40000 ALTER TABLE `fact_top_books` DISABLE KEYS */;
INSERT INTO `fact_top_books` VALUES
(1,1,1,44,12,5,14,8,20250804,1,3.8),
(2,1,5,59,8,6,4,48,20250804,2,4.2),
(3,1,6,24,1,5,11,10,20250804,3,4),
(4,1,4,41,1,5,7,2,20250804,4,3.9),
(5,1,3,29,5,13,10,48,20250804,5,4.3),
(6,1,2,32,4,5,12,30,20250804,6,4.4),
(7,1,1,39,1,5,3,49,20250804,7,3.9),
(8,1,2,92,1,5,4,37,20250804,8,4),
(9,1,1,64,19,13,4,21,20250804,9,4.3),
(10,1,1,54,18,12,11,48,20250804,10,4.2),
(11,1,1,28,18,12,8,8,20250804,11,4.5),
(12,1,3,45,4,5,11,32,20250804,13,4.2),
(13,1,5,54,18,12,17,42,20250804,12,4.4),
(14,1,2,89,1,5,2,41,20250804,14,4.1),
(15,1,2,21,4,5,17,38,20250804,15,3.9),
(16,1,5,42,4,5,3,31,20250804,16,4.5),
(17,1,3,36,1,5,7,31,20250804,17,4.4),
(18,4,5,85,14,8,18,22,20250804,18,4.2),
(19,1,1,28,18,12,11,46,20250804,19,4.5),
(20,1,2,61,1,5,3,51,20250804,20,3.7),
(21,1,4,27,6,7,2,8,20250804,21,3.9),
(22,1,6,1,8,6,1,8,20250804,22,4.1),
(23,1,3,34,8,6,11,3,20250804,23,4.1),
(24,3,3,40,10,1,3,39,20250804,24,4.1),
(25,1,3,47,1,5,17,27,20250804,25,4.4),
(26,1,1,82,9,7,4,24,20250804,26,3.9),
(27,3,3,14,13,9,17,6,20250804,27,3.9),
(28,1,4,88,4,5,4,37,20250804,28,3.8),
(29,1,3,11,4,5,7,45,20250804,29,4.2),
(30,1,1,31,4,5,17,9,20250804,30,4.1),
(31,1,6,50,4,5,4,8,20250804,31,3.6),
(32,1,6,55,4,5,2,11,20250804,32,3.9),
(33,1,3,70,1,5,4,5,20250804,33,4),
(34,1,3,65,18,12,4,37,20250804,34,4.3),
(35,1,3,51,1,5,2,18,20250804,35,4.1),
(36,1,4,88,4,5,11,37,20250804,36,3.5),
(37,3,3,40,10,1,17,43,20250804,37,3.9),
(38,1,5,86,8,6,4,50,20250804,38,4.4),
(39,1,1,10,4,5,7,9,20250804,39,3.9),
(40,1,2,43,1,5,4,13,20250804,40,3.5),
(41,1,3,78,8,6,17,3,20250804,41,4),
(42,1,2,62,4,5,17,9,20250804,42,4.2),
(43,1,2,92,1,5,4,15,20250804,43,4.1),
(44,1,4,49,2,13,17,44,20250804,44,4.3),
(45,1,6,5,8,6,4,47,20250804,45,4.1),
(46,1,1,85,15,2,3,15,20250804,46,4.3),
(47,1,3,56,8,6,4,42,20250804,47,4.1),
(48,1,1,10,4,5,7,9,20250804,48,4),
(49,1,4,2,4,5,12,29,20250804,49,3.8),
(50,1,6,23,1,5,17,40,20250804,50,3.8),
(51,1,4,93,4,5,4,24,20250804,51,3.8),
(52,1,2,83,1,5,17,4,20250804,53,4),
(53,1,1,60,1,5,17,23,20250804,52,4.4),
(54,1,6,32,4,5,4,15,20250804,54,4.1),
(55,1,1,28,18,12,17,37,20250804,55,4),
(56,1,2,58,4,5,4,37,20250804,56,3.5),
(57,1,3,8,4,5,17,52,20250804,57,3.8),
(58,1,1,53,4,5,14,16,20250804,58,4.1),
(59,1,4,33,13,9,17,37,20250804,59,4.1),
(60,1,1,16,4,5,17,26,20250804,60,3.4),
(61,1,4,23,1,5,4,7,20250804,61,3.9),
(62,1,4,12,16,5,7,27,20250804,62,3.8),
(63,1,2,48,4,5,3,36,20250804,63,3.5),
(64,1,2,15,4,5,17,37,20250804,64,4.4),
(65,3,3,87,17,10,17,25,20250804,66,3.9),
(66,3,2,91,1,5,20,51,20250804,65,4),
(67,2,5,63,8,6,9,25,20250804,67,4),
(68,1,4,96,1,5,7,4,20250804,68,3.8),
(69,1,3,75,11,5,4,12,20250804,69,4),
(70,1,4,67,1,5,4,50,20250804,70,3.5),
(71,1,4,95,4,5,11,15,20250804,71,4.3),
(72,1,2,18,4,5,17,35,20250804,72,3.7),
(73,1,3,23,1,5,17,31,20250804,73,3.9),
(74,1,4,13,4,5,3,24,20250804,74,3.3),
(75,1,4,1,8,6,4,46,20250804,75,4),
(76,1,4,90,8,6,4,54,20250804,76,3.8),
(77,1,3,38,1,5,7,15,20250804,77,3.6),
(78,1,4,89,1,5,14,34,20250804,78,4.1),
(79,1,4,27,6,7,4,8,20250804,79,3.8),
(80,1,6,27,6,7,4,8,20250804,80,4.1),
(81,1,2,52,1,5,10,38,20250804,82,4.2),
(82,1,4,22,9,7,17,28,20250804,81,4.2),
(83,1,5,3,8,6,3,15,20250804,83,4.6),
(84,1,1,35,9,7,4,55,20250804,84,3.6),
(85,1,4,25,4,5,4,3,20250804,85,3.8),
(86,1,4,92,1,5,4,37,20250804,86,3.7),
(87,1,4,69,4,5,4,14,20250804,87,4),
(88,1,3,57,1,5,7,48,20250804,89,4),
(89,1,4,44,12,5,4,33,20250804,90,3.7),
(90,1,2,46,9,7,17,9,20250804,88,3.7),
(91,1,1,82,9,7,15,19,20250804,91,3.9),
(92,1,5,74,3,7,17,56,20250804,92,4.8),
(93,1,6,76,12,6,2,42,20250804,93,3.7),
(94,1,3,45,4,5,17,32,20250804,95,3.7),
(95,1,1,28,18,12,17,48,20250804,94,3.8),
(96,1,2,20,1,5,11,29,20250804,96,4.2),
(97,1,3,23,1,5,17,15,20250804,97,3.7),
(98,1,3,68,18,12,17,18,20250804,98,3.8),
(99,1,4,88,4,5,4,53,20250804,99,3.9),
(100,1,6,77,10,1,11,17,20250804,100,4.1),
(101,1,5,19,1,5,17,38,20250804,101,4.4),
(102,1,3,72,1,5,17,8,20250804,102,4.2),
(103,1,3,26,1,5,16,15,20250804,103,3.9),
(104,3,6,80,4,5,14,38,20250804,104,3.8),
(105,1,2,66,6,3,13,46,20250804,105,4),
(106,2,2,37,1,5,19,53,20250804,106,3.8),
(107,1,1,7,18,12,17,15,20250804,107,4.1),
(108,1,4,17,1,5,6,11,20250804,108,3.9),
(109,3,3,30,4,11,4,21,20250804,109,3.3),
(110,1,4,79,1,5,7,9,20250804,110,3.9),
(111,2,2,84,1,5,8,20,20250804,111,4.4),
(112,1,4,73,4,5,3,15,20250804,112,3.7),
(113,1,1,94,4,5,17,9,20250804,114,3.5),
(114,1,4,71,1,5,8,1,20250804,113,3.9),
(115,1,2,9,1,5,17,8,20250804,117,3.9),
(116,1,3,81,4,5,11,48,20250804,116,4),
(117,1,1,3,8,6,3,15,20250804,115,4.1),
(118,1,3,6,18,12,11,18,20250804,118,3.8),
(119,1,6,77,10,1,11,37,20250804,119,4.1),
(120,2,2,4,7,4,5,2,20250804,120,4);
/*!40000 ALTER TABLE `fact_top_books` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2025-08-04 23:43:47
