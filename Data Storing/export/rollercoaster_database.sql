/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.7.2-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: rollercoaster
-- ------------------------------------------------------
-- Server version	11.7.2-MariaDB

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
-- Table structure for table `city`
--

DROP TABLE IF EXISTS `city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `city` (
  `city_id` int(11) NOT NULL,
  `city_name` varchar(100) DEFAULT NULL,
  `region_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`city_id`),
  KEY `region_id` (`region_id`),
  CONSTRAINT `city_ibfk_1` FOREIGN KEY (`region_id`) REFERENCES `region` (`region_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `city`
--

LOCK TABLES `city` WRITE;
/*!40000 ALTER TABLE `city` DISABLE KEYS */;
INSERT INTO `city` VALUES
(1,'Vlodrop',1),
(2,'Rasdorf',2),
(3,'Baltimore',3),
(4,'Orlando',4),
(5,'Altendorf',5),
(6,'Reggio Emilia',6),
(7,'Deggendorf',7),
(8,'Casale di Scodosia',8),
(9,'Monthey',9),
(10,'Chaoyang',10),
(11,'Krasnogorsk',11),
(12,'Kirchzarten',12),
(13,'Altavilla Vicentina',8),
(14,'Münsterhausen',7),
(15,'Zhongshan',13),
(16,'Zhengzhou',14),
(17,'Sunbury',15),
(18,'Samois Cedex',16),
(19,'Xingtai',17),
(20,'Waldkirch',12),
(21,'Miami',4),
(22,'Gebze',18),
(23,'Hayden',19),
(24,'Suzzara',20),
(25,'Wichita',21),
(26,'Düngenheim',22),
(27,'Bergantino',8),
(28,'North Tonawanda',23),
(29,'Sainte-Hélène-du-Lac',24),
(30,'Merino',25),
(31,'Kazan',26),
(32,'München',7),
(33,'Odunpazarı',27),
(34,'Logan',28),
(35,'Dolná Streda',29),
(36,'Gloucestershire',30),
(37,'Imst',31),
(38,'Cohoes',23),
(39,'Xi\'an',32),
(40,'Treviso',8),
(41,'Baoding',17),
(42,'Al Muzahimiyah',33),
(43,'Canela',34),
(44,'Vaughan',35),
(45,'Genting Highlands',36),
(46,'Lipperswil',37),
(47,'Rzgów',38),
(48,'Las Jarretaderas',39),
(49,'Lubao',40),
(50,'Brojce',41),
(51,'Avion',42),
(52,'San Antonio',43),
(53,'Cotia',44),
(54,'Williamsburg',45),
(55,'Qingpu',46),
(56,'Balalyk Park',47),
(57,'Minden',48),
(58,'Princeton',49),
(59,'Groenlo',50),
(60,'Yokosuka',51),
(61,'Plailly',42),
(62,'Orcet',24),
(63,'Dhahran',52),
(64,'Pristina',53),
(65,'Egg Harbor Township',54),
(66,'Austin',43),
(67,'Clarksville',55),
(68,'Villa Park',56),
(69,'Ziyang',57),
(70,'Savio',6),
(71,'Middlebury',58),
(72,'Atlantic City',54),
(73,'Guangzhou',13),
(74,'Somerset',30),
(75,'Shijingshan',10),
(76,'North Richland Hills',43),
(77,'Paris',16),
(78,'Neukirchen',7),
(79,'Inagi',59),
(80,'Cornwall',30),
(81,'Goslar',60),
(82,'Pyrénées-Orientales',61),
(83,'Bremerhaven',62),
(84,'Westerstede',60),
(85,'Ajman',63),
(86,'Fréjus',64),
(87,'Waterloo',65),
(88,'Quarteira',66),
(89,'Jackson',54),
(90,'Changsha',67),
(91,'Austell',68),
(92,'Estes Park',25),
(93,'Hodenhagen',60),
(94,'East Sussex',30),
(95,'Strasswalchen',69),
(96,'Glendale',70),
(97,'Xianyang',32),
(98,'Kirchhundem',48),
(99,'Krynica Morska',71),
(100,'Aztlán Parque Urbano',72),
(101,'Anderson',73),
(102,'St. Louis',74),
(103,'Xiangyang',75),
(104,'São Paulo',44),
(105,'Tournehem-sur-la-Hem',42),
(106,'District 9',76),
(107,'Chuncheon',77),
(108,'Walloon Brabant',78),
(109,'Riyadh',33),
(110,'Campos do Jordão',44),
(111,'Massanutten',45),
(112,'Vienna',79),
(113,'Ocean City',3),
(114,'Coffs Harbour',80),
(115,'Féy',81),
(116,'Pigeon Forge',55),
(117,'Doswell',45),
(118,'Belgorod',82),
(119,'Kuusamo',83),
(120,'Hampshire',30),
(121,'Antrim',84),
(122,'Eurasia',47),
(123,'Sarbsk',71),
(124,'Saint-Avold',81),
(125,'Bodenmais',7),
(126,'Sandusky',85),
(127,'Osaka',86),
(128,'Charlotte',87),
(129,'Lincolnshire',30),
(130,'Thủy Nguyên',88),
(131,'Hanover',89),
(132,'Morsbronn-les-Bains',81),
(133,'Greenville',90),
(134,'Inuyama',91),
(135,'Udon Thani',92),
(136,'Jesolo',8),
(137,'Yanbu',93),
(138,'Shunyi',10),
(139,'Thornton',25),
(140,'Jiangmen',13),
(141,'Liptovský Mikuláš',94),
(142,'Ermenonville',42),
(143,'Subang Jaya',95),
(144,'Saint-Pierre-du-Perray',16),
(145,'Baraboo',96),
(146,'Gurnee',56),
(147,'Bracebridge',35),
(148,'Biddinghuizen',97),
(149,'Eschenbach',98),
(150,'Meishan',57),
(151,'Hòa Vang',99),
(152,'Wenzhou',100),
(153,'Ningbo',100),
(154,'Qingyuan',13),
(155,'Cullman',101),
(156,'Debiri',102),
(157,'Illalur',103),
(158,'Hassloch',22),
(159,'North Vancouver',104),
(160,'Taizhou',100),
(161,'Tamano',105),
(162,'Gagra',106),
(163,'Shenzhen',13),
(164,'Volgograd',107),
(165,'Taiyuan',108),
(166,'Liupanshui',109),
(167,'Ji\'An',110),
(168,'Wadumalla',111),
(169,'Shantou',13),
(170,'Jieyang',13),
(171,'Huai\'an',112),
(172,'Hangzhou',100),
(173,'Hengelo',113),
(174,'Hanstedt',60),
(175,'Zhangzhou',114),
(176,'Seven Devils',87),
(177,'Ya\'an',57),
(178,'Salem',115),
(179,'Sankt Georgen ob Judenburg',116),
(180,'Hi Space',117),
(181,'Siri Cafe Ranong',118);
/*!40000 ALTER TABLE `city` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `country`
--

DROP TABLE IF EXISTS `country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `country` (
  `country_id` int(11) NOT NULL,
  `country_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`country_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `country`
--

LOCK TABLES `country` WRITE;
/*!40000 ALTER TABLE `country` DISABLE KEYS */;
INSERT INTO `country` VALUES
(1,'Netherlands'),
(2,'Germany'),
(3,'United States'),
(4,'Switzerland'),
(5,'Italy'),
(6,'China'),
(7,'Russia'),
(8,'France'),
(9,'Turkey'),
(10,'Slovakia'),
(11,'United Kingdom'),
(12,'Austria'),
(13,'Saudi Arabia'),
(14,'Brazil'),
(15,'Canada'),
(16,'Malaysia'),
(17,'Poland'),
(18,'Mexico'),
(19,'Philippines'),
(20,'Kyrgyzstan'),
(21,'Japan'),
(22,'Kosovo'),
(23,'United Arab Emirates'),
(24,'Portugal'),
(25,'Vietnam'),
(26,'South Korea'),
(27,'Belgium'),
(28,'Australia'),
(29,'Finland'),
(30,'Thailand'),
(31,'Ethiopia'),
(32,'India'),
(33,'Georgia'),
(34,'Sri Lanka');
/*!40000 ALTER TABLE `country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manufacturer`
--

DROP TABLE IF EXISTS `manufacturer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `manufacturer` (
  `manufacturer_id` int(11) NOT NULL,
  `manufacturer_name` varchar(100) DEFAULT NULL,
  `city_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`manufacturer_id`),
  KEY `city_id` (`city_id`),
  CONSTRAINT `manufacturer_ibfk_1` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manufacturer`
--

LOCK TABLES `manufacturer` WRITE;
/*!40000 ALTER TABLE `manufacturer` DISABLE KEYS */;
INSERT INTO `manufacturer` VALUES
(6831,'Bolliger & Mabillard',9),
(6836,'Vekoma',1),
(6837,'Intamin Amusement Rides',NULL),
(6848,'Premier Rides',3),
(6856,'Mack Rides GmbH & Co KG',20),
(6860,'Great Coasters International',17),
(6861,'Zierer',7),
(6862,'Pinfari',24),
(6872,'Allan Herschell Company',28),
(6873,'S.D.C.',6),
(6887,'Chance Rides',25),
(6892,'Zamperla',13),
(6902,'Reverchon',18),
(6904,'Wisdom Rides',30),
(6905,'Maurer Rides GmbH',32),
(6914,'B. A. Schiff & Associates',21),
(6930,'S&S Worldwide',34),
(6948,'Gerstlauer Amusement Rides GmbH',14),
(6951,'BHS',NULL),
(6953,'Fabbri',27),
(6971,'Pax Company',11),
(7028,'SBF Visa Group',8),
(7042,'Preston & Barbieri',6),
(7125,'Beijing Shibaolai Amusement Equipment / 北京实宝来游乐设备有限公司',10),
(7140,'Sunkid GmbH',37),
(7243,'Interlink',36),
(7489,'Dynamic Attractions',4),
(7492,'Jinma Rides / 金马游乐',15),
(7514,'Wiegand',2),
(7536,'DAL Amusement Rides Company',22),
(7761,'Gosetto',40),
(7980,'Hebei Zhongye Metallurgical Equipment Manufacturing Co., Ltd / 河北中冶冶金设备制造有限公司',19),
(8770,'Chang Long / 昌龙',41),
(10583,'Rocky Mountain Construction',23),
(12029,'ART Engineering GmbH',12),
(12208,'Zhipao / 河北智跑游乐设备制造有限公司 / Zhìpǎo',19),
(12962,'Aquatic Development Group',38),
(14793,'MND Group',29),
(14971,'Güven Amusement Rides Factory',31),
(15977,'RES Rides AG',5),
(16578,'Modern Amusement Group',16),
(18869,'Kılıç Lunapark',33),
(20308,'InterTech',35),
(20692,'Xi\'an Shuobo Amusement Equipment / 西安硕博游乐设备技术开发有限',39),
(22121,'Risheng Amusement Rides / 日晟游乐',15),
(22708,'Inno-Heege GmbH & Co. KG',26);
/*!40000 ALTER TABLE `manufacturer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `park`
--

DROP TABLE IF EXISTS `park`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `park` (
  `park_id` int(11) NOT NULL,
  `park_name` varchar(100) DEFAULT NULL,
  `city_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`park_id`),
  KEY `city_id` (`city_id`),
  CONSTRAINT `park_ibfk_1` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `park`
--

LOCK TABLES `park` WRITE;
/*!40000 ALTER TABLE `park` DISABLE KEYS */;
INSERT INTO `park` VALUES
(4529,'Cedar Point',126),
(4530,'Six Flags Great America',146),
(4534,'Six Flags Great Adventure',89),
(4535,'Six Flags Over Georgia',91),
(4539,'Canada\'s Wonderland',44),
(4542,'Carowinds',128),
(4544,'Kings Dominion',117),
(4548,'Busch Gardens Williamsburg',54),
(4601,'SeaWorld San Antonio',52),
(4602,'Canobie Lake Park',178),
(4628,'Aztlán Parque Urbano',100),
(4647,'Quassy Amusement Park',71),
(4739,'Steel Pier',72),
(4749,'Jolly Roger Amusement Park',113),
(4754,'Santa\'s Village',147),
(4790,'Parc Astérix',61),
(4793,'Mirabilandia',70),
(4794,'Walibi Holland',148),
(4811,'Clarence Pier',120),
(4812,'Fantasy Island',129),
(4847,'Walibi Belgium',108),
(4862,'Brean Theme Park',74),
(4871,'Plopsaland Deutschland',158),
(4879,'Potts Park',57),
(4883,'Panorama Park Sauerland',98),
(4890,'Serengeti-Park',93),
(4926,'Wiener Prater',112),
(4968,'Yomiuriland',79),
(4976,'Sunway Lagoon',143),
(4977,'Genting SkyWorlds',45),
(4996,'Japan Monkey Park',134),
(5113,'Jardin d\'Acclimatation',77),
(5137,'Beijing Shijingshan Amusement Park',75),
(5142,'Safari Land',68),
(5166,'Happy Valley',163),
(5211,'Star World - Nanhu Amusement Park',73),
(5217,'Mer de Sable',142),
(5227,'De Waarbeek',173),
(5232,'Skytropolis Indoor Theme Park',45),
(5252,'Sun Park',10),
(5401,'Didi\'Land',132),
(5455,'Storybook Land',65),
(5492,'Universal Studios Japan',127),
(5591,'Fantasiana',95),
(5715,'Toy Kingdom',161),
(5745,'Aquashow Family Park',88),
(5761,'Banana Beach',63),
(5951,'Conny-Land',46),
(5999,'Flamingo Park',94),
(6148,'Lunapark Fréjus',86),
(6276,'Fééryland',105),
(6300,'Jin Ying Amusement Park',73),
(6359,'New Jesolandia',136),
(6737,'Jinping Park',160),
(6754,'Lewa Adventure',97),
(8697,'Squirrel Kingdom',160),
(8992,'Shantou Blue Mercury Happy World',169),
(9172,'Jiulong Park',175),
(9307,'Märchenwald Steiermark',179),
(9583,'Guangzhou Zoological Garden',73),
(11420,'Winnoland',144),
(12557,'Legoland Korea',107),
(13160,'ErlebnisBocksBerg',81),
(13367,'Edelwies',78),
(14026,'Peppa Pig Theme Park',76),
(14134,'Sun World Bà Nà Hills',151),
(15194,'Chanba National Wetland Park',39),
(16018,'Festival Land',85),
(17263,'LandErlebnis Janßen',84),
(17529,'Lost Island Theme Park',87),
(17569,'Universal Epic Universe',4),
(17706,'Fantasy Valley',103),
(17817,'Legoland Sichuan',150),
(17863,'Mandoria',47),
(17949,'Lunapark Volgograd',164),
(18057,'Animália Park',53),
(18708,'4D Farm',155),
(18828,'Cotaland',66),
(18867,'Chocolate Kingdom',154),
(19017,'Fermy Land',62),
(19049,'Silk Road Paradise',97),
(19050,'Fantázia Liptov Park',141),
(19161,'Happy Valley',39),
(19273,'Legoland Shanghai',55),
(19364,'Hastings Pier',94),
(19393,'Mattel Adventure Park',96),
(19561,'Ch\'ti Parc',51),
(19898,'Pradera Islands Park',49),
(20350,'T-Rex Park São Paulo',104),
(20452,'Historic Hawes Farms',101),
(20463,'Karls Erlebnis-Dorf Loxstedt',83),
(20519,'Chimelong Qingyuan International Forest Resort',154),
(20617,'BON Luxury Theme Park',48),
(20680,'Yueqing Happy Park',152),
(20757,'Hossoland',50),
(20875,'Bommelwereld',59),
(20940,'China Hiin City',153),
(21135,'Silberbergbahn Bodenmais',125),
(21222,'Sea Park Sarbsk',123),
(21225,'Park Rozrywki Kyrnica Morska',99),
(21275,'Six Flags Qiddiya City',42),
(21318,'Seven Yanbu',137),
(21374,'Wonderla Amusement Park Chennai',157),
(21410,'Atzmännig',149),
(21412,'Font-Romeu Pyrénées 2000',82),
(21709,'Brush Creek Falls Resort',58),
(21773,'GAST Conference & Wellness City Resort',156),
(21786,'Massanutten Family Adventure Park',111),
(21864,'Coco Park',124),
(21879,'Fun City',92),
(21894,'Union Station',102),
(22042,'Grouse Mountain',159),
(22189,'Bondinhos Canela',43),
(22253,'Malibu Park',162),
(22255,'Pigeon Forge Racing Coaster',116),
(22260,'Kaleidoscope Park',118),
(22337,'Balalyk Park',56),
(22361,'VinWonders Grand Park',106),
(22371,'Frankie\'s Fun Park',133),
(22421,'Starland Sportsplex & Fun Park',131),
(22430,'Jinyang Lake Happy World',165),
(22445,'Panzhou Happy World',166),
(22450,'Ji’an Happy World',167),
(22476,'New Saniro Airport Sports Complex',168),
(22478,'Big Banana Fun Park',114),
(22545,'Prishtina Park',64),
(22634,'Pokeyland',115),
(22653,'Xingmei Amusement Park',15),
(22667,'Meiyuan Little Doctor Parent-Child Paradise',170),
(22671,'Candy Fruit Amusement Park',73),
(22674,'Xin Xi Tong Paradise',140),
(22694,'Little Yellow Duck Theme Park',171),
(22701,'Little Yellow Duck Theme Park',172),
(22719,'Wisconsin Dells Mountain Coaster',145),
(22728,'Nagai Uminote Park Soleil Hill',60),
(22737,'Fantawild National Colors Spring and Autumn',69),
(22743,'City Forum',67),
(22748,'YoYoland',135),
(22757,'Malibu Jack\'s',76),
(22768,'VinWonders Vũ Yên',130),
(22774,'Wildpark Lüneburger Heide',174),
(22786,'Hawksnest Adventures',176),
(22823,'Springfields Fun Park & Pony Centre',80),
(22853,'1869 China Giant Panda Ecological World',177),
(22919,'Guangxinxing Baby Playground',90),
(22951,'Malibu Jack\'s',139),
(22969,'Saffori Land',109),
(22981,'Bendito Cacao Resort & Spa',110),
(22988,'Tiger Park',138),
(22992,'Kiddieland',121),
(22996,'Hi Space',180),
(22999,'Siri Cafe Ranong',181),
(23013,'Eurasia',122),
(23037,'Ruka Ski Resort & Ski Inn',119);
/*!40000 ALTER TABLE `park` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `region`
--

DROP TABLE IF EXISTS `region`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `region` (
  `region_id` int(11) NOT NULL,
  `region_name` varchar(100) DEFAULT NULL,
  `country_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`region_id`),
  KEY `country_id` (`country_id`),
  CONSTRAINT `region_ibfk_1` FOREIGN KEY (`country_id`) REFERENCES `country` (`country_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `region`
--

LOCK TABLES `region` WRITE;
/*!40000 ALTER TABLE `region` DISABLE KEYS */;
INSERT INTO `region` VALUES
(1,'Limburg',1),
(2,'Hesse',2),
(3,'Maryland',3),
(4,'Florida',3),
(5,'Schwyz',4),
(6,'Emilia-Romagna',5),
(7,'Bavaria',2),
(8,'Veneto',5),
(9,'Valais',4),
(10,'Beijing',6),
(11,'Moscow',7),
(12,'Baden-Württemberg',2),
(13,'Guangdong',6),
(14,'Henan',6),
(15,'Pennsylvania',3),
(16,'Île-de-France',8),
(17,'Hebei',6),
(18,'Kocaeli',9),
(19,'Idaho',3),
(20,'Lombardy',5),
(21,'Kansas',3),
(22,'Rhineland-Palatinate',2),
(23,'New York',3),
(24,'Auvergne-Rhône-Alpes',8),
(25,'Colorado',3),
(26,'Ankara',9),
(27,'Eskişehir',9),
(28,'Utah',3),
(29,'Trnava',10),
(30,'England',11),
(31,'Tyrol',12),
(32,'Shaanxi',6),
(33,'Ar Riyadh',13),
(34,'Rio Grande do Sul',14),
(35,'Ontario',15),
(36,'Pahang',16),
(37,'Thurgau',4),
(38,'Łódzkie',17),
(39,'Nayarit',18),
(40,'Pampanga',19),
(41,'Zachodniopomorskie',17),
(42,'Hauts-de-France',8),
(43,'Texas',3),
(44,'São Paulo',14),
(45,'Virginia',3),
(46,'Shanghai',6),
(47,'Bishkek',20),
(48,'North Rhine-Westphalia',2),
(49,'West Virginia',3),
(50,'Gelderland',1),
(51,'Kanagawa',21),
(52,'Eastern Province',13),
(53,'Pristina',22),
(54,'New Jersey',3),
(55,'Tennessee',3),
(56,'Illinois',3),
(57,'Sichuan',6),
(58,'Connecticut',3),
(59,'Tokyo',21),
(60,'Lower Saxony',2),
(61,'Occitanie',8),
(62,'Bremen',2),
(63,'Ajman',23),
(64,'Provence-Alpes-Côte d\'Azur',8),
(65,'Iowa',3),
(66,'Faro',24),
(67,'Hunan',6),
(68,'Georgia',3),
(69,'Salzburg',12),
(70,'Arizona',3),
(71,'Pomorskie',17),
(72,'Mexico City',18),
(73,'California',3),
(74,'Missouri',3),
(75,'Hubei',6),
(76,'Ho Chi Minh',25),
(77,'Gangwon-do',26),
(78,'Wallonia',27),
(79,'Vienna',12),
(80,'New South Wales',28),
(81,'Grand Est',8),
(82,'Belgorod',7),
(83,'North Ostrobothnia',29),
(84,'Northern Ireland',11),
(85,'Ohio',3),
(86,'Osaka',21),
(87,'North Carolina',3),
(88,'Hải Phòng',25),
(89,'Massachusetts',3),
(90,'South Carolina',3),
(91,'Aichi',21),
(92,'Udon Thani',30),
(93,'Al Madinah',13),
(94,'Žilina',10),
(95,'Selangor',16),
(96,'Wisconsin',3),
(97,'Flevoland',1),
(98,'St. Gallen',4),
(99,'Đà Nẵng',25),
(100,'Zhejiang',6),
(101,'Alabama',3),
(102,'Tigray',31),
(103,'Tamil Nadu',32),
(104,'British Columbia',15),
(105,'Okayama',21),
(106,'Abkhazia',33),
(107,'Volgograd',7),
(108,'Shanxi',6),
(109,'Guizhou',6),
(110,'Jiangxi',6),
(111,'Sabaragamuwa',34),
(112,'Jiangsu',6),
(113,'Overijssel',1),
(114,'Fujian',6),
(115,'New Hampshire',3),
(116,'Styria',12),
(117,'Chongqing',6),
(118,'Ranong',30);
/*!40000 ALTER TABLE `region` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rollercoaster`
--

DROP TABLE IF EXISTS `rollercoaster`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `rollercoaster` (
  `coaster_id` int(11) NOT NULL,
  `park_id` int(11) DEFAULT NULL,
  `manufacturer_id` int(11) DEFAULT NULL,
  `coaster_name` varchar(100) DEFAULT NULL,
  `coaster_type` varchar(50) DEFAULT NULL CHECK (`coaster_type` in ('Steel','Wood')),
  `coaster_design` varchar(50) DEFAULT NULL CHECK (`coaster_design` in ('Sit Down','Inverted','Suspended','Wing','Flying','Stand Up','Bobsled','Pipeline')),
  `coaster_status` varchar(50) DEFAULT NULL CHECK (`coaster_status` in ('Under Construction','In Business','In Production','Living','Operating','SBNO','In Storage')),
  `opened` date DEFAULT NULL,
  PRIMARY KEY (`coaster_id`),
  KEY `park_id` (`park_id`),
  KEY `manufacturer_id` (`manufacturer_id`),
  CONSTRAINT `rollercoaster_ibfk_1` FOREIGN KEY (`park_id`) REFERENCES `park` (`park_id`) ON DELETE SET NULL,
  CONSTRAINT `rollercoaster_ibfk_2` FOREIGN KEY (`manufacturer_id`) REFERENCES `manufacturer` (`manufacturer_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rollercoaster`
--

LOCK TABLES `rollercoaster` WRITE;
/*!40000 ALTER TABLE `rollercoaster` DISABLE KEYS */;
INSERT INTO `rollercoaster` VALUES
(13470,4976,7243,'Wild Chase Coaster','Steel','Sit Down','Operating','2025-05-10'),
(15485,4977,7489,'Mad Ramp Peak','Steel','Sit Down','Under Construction','2025-01-01'),
(15999,4977,7489,'Andromeda Base','Steel','Sit Down','Under Construction','2025-01-01'),
(17539,19161,7492,'unknown','Steel','Sit Down','Under Construction','2025-01-01'),
(18058,18057,7028,'Cyclone','Steel','Sit Down','Under Construction','2025-01-01'),
(18347,18057,7028,'Big Air Coaster','Steel','Sit Down','Under Construction','2025-01-01'),
(18394,5232,7125,'Bolt','Steel','Sit Down','Under Construction','2025-01-01'),
(18851,21410,7140,'unknown','Steel','Sit Down','Under Construction','2025-01-01'),
(18854,21412,7514,'Draco´Snow','Steel','Sit Down','Operating','2025-07-05'),
(19013,17706,6860,'Mad Racers','Wood','Sit Down','Under Construction','2025-01-01'),
(19051,19050,20308,'Vesmír','Steel','Sit Down','Under Construction','2025-01-01'),
(19269,17817,NULL,'unknown','Steel','Sit Down','Under Construction','2025-01-01'),
(19270,17817,NULL,'unknown','Steel','Sit Down','Under Construction','2025-01-01'),
(19271,17817,NULL,'unknown','Steel','Sit Down','Under Construction','2025-01-01'),
(19272,17817,6831,'unknown','Steel','Inverted','Under Construction','2025-01-01'),
(19394,19393,6887,'Hot Wheels Twin Mill Racer','Steel','Sit Down','Under Construction','2025-01-01'),
(19395,5591,6856,'Helios','Steel','Sit Down','Operating','2025-04-12'),
(19715,18828,6948,'Palindrome','Steel','Sit Down','Under Construction','2025-10-19'),
(19724,19393,6887,'Hot Wheels Boneshaker: The Ultimate Ride','Steel','Sit Down','Under Construction','2025-01-01'),
(19899,19898,7042,'Attack of the Aswang','Steel','Sit Down','Under Construction','2025-01-01'),
(19903,4890,15977,'Gozimba','Steel','Inverted','Under Construction','2025-01-01'),
(19998,18828,6836,'Circuit Breaker','Steel','Sit Down','Under Construction','2025-10-19'),
(20199,4739,6848,'Crazy Crab','Steel','Sit Down','Operating','2025-05-24'),
(20216,5113,6948,'Défi du Dragon','Steel','Sit Down','Operating','2025-03-22'),
(20263,19161,6856,'unknown','Steel','Sit Down','Under Construction','2025-01-01'),
(20267,5455,7028,'Cinderoller Coaster','Steel','Sit Down','Operating','2025-05-01'),
(20464,20463,7028,'Erdbeer Raupenbahn','Steel','Sit Down','Operating','2025-05-15'),
(20472,4628,6836,'Serpentikha','Steel','Suspended','Operating','2025-03-25'),
(20476,19161,6860,'unknown','Wood','Sit Down','Under Construction','2025-01-01'),
(20504,14134,6861,'unknown','Steel','Sit Down','Under Construction','2025-01-01'),
(20505,14134,6856,'unknown','Steel','Sit Down','Under Construction','2025-01-01'),
(20549,17569,6856,'Stardust Racers','Steel','Sit Down','Operating','2025-05-22'),
(20550,17569,6837,'Hiccup\'s Wing Gliders','Steel','Sit Down','Operating','2025-05-22'),
(20551,17569,6856,'Curse of the Werewolf','Steel','Sit Down','Operating','2025-05-22'),
(20618,20617,6836,'Izari\'s Flight','Steel','Sit Down','Under Construction','2025-01-01'),
(20669,4794,10583,'YoY','Steel','Sit Down','Operating','2025-04-05'),
(20681,20680,NULL,'unknown','Steel','Sit Down','Under Construction','2025-01-01'),
(20683,19049,6837,'Inverse Time and Space Roller Coaster','Steel','Wing','Under Construction','2025-01-01'),
(20825,5951,15977,'Antares','Steel','Sit Down','Operating','2025-05-31'),
(20850,20617,6836,'Speed of Light','Steel','Suspended','Under Construction','2025-01-01'),
(20864,20617,6836,'Tecuani Beast','Steel','Sit Down','Under Construction','2025-01-01'),
(20876,20875,6836,'Bulderbaan','Steel','Sit Down','Under Construction','2025-10-01'),
(20894,4926,6951,'Olympia Looping','Steel','Sit Down','Operating','2025-03-15'),
(20941,20940,6892,'unknown','Steel','Sit Down','Operating','2025-05-01'),
(20970,11420,6836,'Wild West Coaster','Steel','Sit Down','Under Construction','2025-01-01'),
(20995,20519,6856,'unknown','Steel','Sit Down','Under Construction','2025-01-01'),
(21005,14026,6892,'Daddy Pig\'s Roller Coaster','Steel','Sit Down','Operating','2025-03-01'),
(21088,4534,6836,'Flash: Vertical Velocity','Steel','Sit Down','Operating','2025-03-29'),
(21112,4535,6837,'Georgia Gold Rusher','Steel','Sit Down','Operating','2025-03-15'),
(21136,21135,7514,'Silberberg Coaster','Steel','Sit Down','Operating','2025-07-06'),
(21236,18708,NULL,'unknown','Steel','Sit Down','Under Construction','2025-01-01'),
(21250,20452,6872,'Lil Dipper Roller Coaster','Steel','Sit Down','Under Construction','2025-01-01'),
(21294,5745,6856,'Flash Coaster','Steel','Sit Down','Operating','2025-07-23'),
(21308,21275,6905,'Sea Stallion','Steel','Sit Down','Under Construction','2025-01-01'),
(21309,21275,6856,'Saw Mill Falls','Steel','Sit Down','Under Construction','2025-01-01'),
(21310,21275,6836,'Twilight Express','Steel','Sit Down','Under Construction','2025-01-01'),
(21311,21275,6836,'Adrena-Line','Steel','Suspended','Under Construction','2025-01-01'),
(21312,21275,6836,'Iron Rattler','Steel','Sit Down','Under Construction','2025-01-01'),
(21313,21275,6837,'Spitfire','Steel','Sit Down','Under Construction','2025-01-01'),
(21314,21275,6860,'Colossus','Wood','Sit Down','Under Construction','2025-01-01'),
(21315,21275,6837,'Falcons Flight','Steel','Sit Down','Under Construction','2025-01-01'),
(21320,21318,6930,'Transformers','Steel','Sit Down','Under Construction','2025-01-01'),
(21321,19273,6861,'Dragon','Steel','Sit Down','Operating','2025-07-05'),
(21330,17863,6836,'Aquila','Steel','Sit Down','Operating','2025-01-19'),
(21380,17569,NULL,'Mine-Cart Madness','Steel','Sit Down','Operating','2025-05-22'),
(21398,20757,6836,'Thor','Steel','Sit Down','Operating','2025-06-27'),
(21399,5401,7028,'Spinning Coaster','Steel','Sit Down','Operating','2025-04-05'),
(21576,4812,NULL,'Snow Drift','Steel','Sit Down','Operating','2025-08-03'),
(21662,4628,6953,'Laka Laka','Steel','Sit Down','Operating','2025-04-12'),
(21667,13160,7514,'Drachenblitz','Steel','Sit Down','Operating','2025-06-06'),
(21673,4926,6856,'Wiener Looping','Steel','Sit Down','Operating','2025-05-23'),
(21710,21709,7514,'Brush Creek Holl\'r','Steel','Sit Down','Operating','2025-07-04'),
(21756,12557,6856,'Masters of Spinjitzu','Steel','Sit Down','Operating','2025-04-11'),
(21774,21773,12208,'unknown','Steel','Sit Down','Under Construction','2025-01-01'),
(21783,5217,6860,'Wild Buffalo','Wood','Sit Down','Operating','2025-04-26'),
(21785,4601,6861,'Beach Rescue Racer','Steel','Sit Down','Operating','2025-03-08'),
(21787,21786,14793,'Mountain Mayhem Fun Coaster','Steel','Sit Down','Under Construction','2025-01-01'),
(21793,4847,6948,'Mecalodon','Steel','Sit Down','Operating','2025-04-05'),
(21809,4790,6948,'Cétautomatix','Steel','Sit Down','Under Construction','2025-01-01'),
(21820,21374,6831,'unknown','Steel','Inverted','Under Construction','2025-09-01'),
(21838,19561,NULL,'Balade Enchantée','Steel','Sit Down','Operating','2025-04-05'),
(21866,4871,6948,'unknown','Steel','Sit Down','Under Construction','2025-01-01'),
(21880,21879,7028,'Gold Rush','Steel','Sit Down','Operating','2025-06-27'),
(21885,4544,6831,'Rapterra','Steel','Wing','Operating','2025-03-29'),
(21886,20940,7492,'unknown','Steel','Sit Down','Operating','2025-05-01'),
(21887,20940,NULL,'unknown','Steel','Inverted','Under Construction','2025-07-01'),
(21892,6754,NULL,'Tortoise and the Hare','Steel','Sit Down','Operating','2025-01-10'),
(21895,21894,6892,'Loco Motion Mini Spinning Roller Coaster','Steel','Sit Down','Under Construction','2025-08-28'),
(21928,4793,6861,'Cowabunga Carts','Steel','Sit Down','Operating','2025-04-17'),
(21937,19017,NULL,'Chenille','Steel','Sit Down','Operating','2025-04-19'),
(21976,20617,6836,'Ashara: Goddess of Fire','Steel','Sit Down','Under Construction','2025-01-01'),
(21983,4879,12029,'Braus & Saus','Steel','Sit Down','Operating','2025-07-12'),
(21997,5211,7492,'Quantum Trek','Steel','Sit Down','Operating','2025-01-23'),
(22005,19561,16578,'Ch\'ti Turbo','Steel','Sit Down','Under Construction','2025-01-01'),
(22011,4542,12029,'Snoopy’s Racing Railway','Steel','Sit Down','Operating','2025-05-24'),
(22016,4539,6848,'AlpenFury','Steel','Sit Down','Operating','2025-07-12'),
(22031,4530,6831,'Wrath of Rakshasa','Steel','Sit Down','Operating','2025-05-31'),
(22033,17529,10583,'Fire Runner','Steel','Sit Down','Operating','2025-07-18'),
(22043,22042,12962,'unknown','Steel','Sit Down','Under Construction','2025-01-01'),
(22053,4754,6836,'Yeti Trek','Steel','Sit Down','Operating','2025-07-03'),
(22054,13367,7028,'Dinoachterbahn','Steel','Sit Down','Operating','2025-04-05'),
(22055,19273,6831,'Big LEGO Coaster','Steel','Inverted','Operating','2025-07-05'),
(22090,8697,NULL,'unknown','Steel','Sit Down','Operating','2025-01-01'),
(22111,4548,6831,'Big Bad Wolf: The Wolf’s Revenge','Steel','Inverted','Operating','2025-05-23'),
(22118,5715,NULL,'unknown','Steel','Sit Down','Under Construction','2025-01-01'),
(22122,20463,NULL,'Knollis Hafenflitzer','Steel','Sit Down','Operating','2025-05-15'),
(22124,4529,6836,'Siren’s Curse','Steel','Sit Down','Operating','2025-06-28'),
(22136,20617,6856,'Delia\'s Adventure','Steel','Inverted','Under Construction','2025-01-01'),
(22167,4647,7028,'Crazy 8 Family Coaster','Steel','Sit Down','Operating','2025-07-01'),
(22190,22189,7514,'Aerozuum','Steel','Suspended','Operating','2025-01-01'),
(22205,19273,6892,'Dragon\'s Apprentice Coaster','Steel','Sit Down','Operating','2025-07-05'),
(22241,18828,7028,'unknown','Steel','Sit Down','Under Construction','2025-10-19'),
(22254,22253,6836,'unknown','Steel','Sit Down','Under Construction','2025-01-01'),
(22256,22255,7514,'Racing Coaster','Steel','Sit Down','Operating','2025-06-20'),
(22257,5166,7492,'unknown','Steel','Sit Down','Under Construction','2025-09-01'),
(22261,22260,6892,'Roller Coaster','Steel','Sit Down','Operating','2025-06-25'),
(22262,17949,12208,'unknown','Steel','Sit Down','Under Construction','2025-01-01'),
(22338,22337,6971,'Boomerang','Steel','Wing','Operating','2025-01-01'),
(22363,22361,6836,'Marvelous Adventure','Steel','Sit Down','Under Construction','2025-01-01'),
(22372,22371,7028,'Spinning Coaster','Steel','Sit Down','Operating','2025-01-01'),
(22376,5137,7980,'Cupid Roller Coaster','Steel','Sit Down','Under Construction','2025-01-01'),
(22377,5137,7125,'Space Roller Coaster','Steel','Inverted','Operating','2025-06-01'),
(22382,19364,6862,'Happy Caterpillar','Steel','Sit Down','Operating','2025-01-01'),
(22412,20350,6892,'Magic Tornado','Steel','Sit Down','Operating','2025-01-01'),
(22422,22421,7028,'Spin Coaster','Steel','Sit Down','Operating','2025-07-19'),
(22427,17263,7028,'Familienachterbahn','Steel','Sit Down','Operating','2025-05-24'),
(22428,9583,NULL,'Family Roller Coaster','Steel','Sit Down','Operating','2025-01-02'),
(22429,9583,NULL,'Fruit Worm Pulley','Steel','Sit Down','Operating','2025-01-02'),
(22431,22430,7492,'unknown','Steel','Sit Down','Operating','2025-05-03'),
(22446,22445,NULL,'unknown','Steel','Sit Down','Under Construction','2025-02-01'),
(22447,6737,NULL,'unknown','Steel','Sit Down','Operating','2025-01-01'),
(22451,22450,7492,'unknown','Steel','Inverted','Under Construction','2025-01-01'),
(22458,5761,NULL,'Chicken Coop','Steel','Sit Down','Operating','2025-01-01'),
(22461,4749,6904,'Orient Express','Steel','Sit Down','Operating','2025-01-01'),
(22473,6300,NULL,'Crazy Mouse','Steel','Sit Down','Operating','2025-01-01'),
(22479,22476,20692,'unknown','Steel','Sit Down','Under Construction','2025-01-01'),
(22480,22478,NULL,'Plantation Coaster','Steel','Sit Down','Under Construction','2025-01-01'),
(22547,22545,NULL,'Roller Coaster','Steel','Sit Down','Under Construction','2025-07-24'),
(22612,4883,22708,'Katta-Kutter Panorama','Steel','Sit Down','Under Construction','2025-01-01'),
(22615,21222,7028,'Shark Coaster','Steel','Sit Down','Operating','2025-01-01'),
(22623,4968,NULL,'DinoRunner','Steel','Sit Down','Operating','2025-05-18'),
(22635,22634,14971,'Pomme','Steel','Sit Down','Operating','2025-04-05'),
(22636,4811,14971,'Runaway Train','Steel','Sit Down','Operating','2025-01-01'),
(22637,20757,6836,'Aurora','Steel','Suspended','Operating','2025-06-27'),
(22644,20757,6836,'Mermaid Ride','Steel','Sit Down','Operating','2025-06-27'),
(22649,8992,NULL,'unknown','Steel','Sit Down','Under Construction','2025-03-01'),
(22654,22653,NULL,'Crazy Roller Coaster','Steel','Sit Down','Operating','2025-01-01'),
(22668,22667,NULL,'unknown','Steel','Sit Down','Operating','2025-01-01'),
(22672,22671,22121,'Undersea Adventure','Steel','Sit Down','Operating','2025-01-01'),
(22675,22674,NULL,'UFO Tour','Steel','Sit Down','Operating','2025-01-01'),
(22695,22694,NULL,'unknown','Steel','Sit Down','Operating','2025-01-01'),
(22702,22701,NULL,'unknown','Steel','Sit Down','Operating','2025-04-04'),
(22703,22701,NULL,'unknown','Steel','Sit Down','Operating','2025-04-04'),
(22706,22430,NULL,'unknown','Steel','Sit Down','Operating','2025-05-03'),
(22707,22430,NULL,'unknown','Steel','Sit Down','Operating','2025-05-03'),
(22712,6359,6873,'Superman','Steel','Sit Down','Operating','2025-01-01'),
(22713,4996,7028,'Spinning  Coaster','Steel','Sit Down','Operating','2025-04-19'),
(22714,18867,7492,'unknown','Steel','Sit Down','Under Construction','2025-05-01'),
(22716,20757,7042,'Veyron','Steel','Sit Down','Operating','2025-06-27'),
(22720,22719,7514,'Wisconsin Dells Mountain Coaster','Steel','Sit Down','Operating','2025-05-24'),
(22729,22728,6892,'Capybara Coaster','Steel','Sit Down','Operating','2025-05-03'),
(22730,5227,7761,'unknown','Steel','Sit Down','Under Construction','2025-01-01'),
(22738,22737,7492,'Cosmic Coaster','Steel','Sit Down','Under Construction','2025-08-08'),
(22739,22737,7492,'Soaring Dragon','Steel','Inverted','Under Construction','2025-08-08'),
(22740,22737,7492,'Puppy Coaster','Steel','Sit Down','Under Construction','2025-08-08'),
(22745,22743,7028,'City Spinner','Steel','Sit Down','Operating','2025-03-01'),
(22749,22748,7492,'Spinning UFO','Steel','Sit Down','Under Construction','2025-01-01'),
(22758,22757,7028,'Twist-N-Shout','Steel','Sit Down','Operating','2025-06-16'),
(22775,22774,7140,'unknown','Steel','Sit Down','Operating','2025-01-01'),
(22777,9172,8770,'unknown','Steel','Sit Down','Under Construction','2025-01-01'),
(22787,22786,7514,'unknown','Steel','Sit Down','Under Construction','2025-01-01'),
(22788,4862,6902,'Crazy Mouse','Steel','Sit Down','Operating','2025-01-01'),
(22824,22823,6914,'Disney Rollercoaster','Steel','Sit Down','Operating','2025-01-01'),
(22829,16018,7536,'Family Ride','Steel','Sit Down','Operating','2025-01-01'),
(22837,5142,NULL,'Congo Cruizer','Steel','Sit Down','Under Construction','2025-01-01'),
(22839,21864,18869,'Shark Trip','Steel','Sit Down','Operating','2025-01-01'),
(22852,5999,NULL,'unknown','Steel','Sit Down','Under Construction','2025-01-01'),
(22854,22853,NULL,'unknown','Steel','Inverted','Under Construction','2025-10-01'),
(22871,4602,7028,'unknown','Steel','Sit Down','Under Construction','2025-01-01'),
(22872,21225,NULL,'Kyrnica Expres','Steel','Sit Down','Operating','2025-05-01'),
(22892,22545,22121,'Chicken Coop','Steel','Sit Down','Under Construction','2025-07-24'),
(22915,15194,NULL,'Space Shuttle','Steel','Sit Down','Operating','2025-01-01'),
(22920,22919,NULL,'Fruit Worm Pulley','Steel','Sit Down','Operating','2025-01-01'),
(22945,6276,7028,'Magic Twist','Steel','Sit Down','Operating','2025-01-01'),
(22950,20680,7492,'unknown','Steel','Inverted','Under Construction','2025-01-01'),
(22952,22951,7028,'Twist-N-Shout','Steel','Sit Down','Under Construction','2025-09-01'),
(22956,5252,NULL,'unknown','Steel','Sit Down','Under Construction','2025-01-01'),
(22957,22768,6836,'Warrior Challenge','Steel','Sit Down','Operating','2025-07-18'),
(22964,22992,NULL,'Runaway Train','Steel','Sit Down','Operating','2025-01-01'),
(22970,22969,7028,'Mixed Coaster','Steel','Sit Down','Operating','2025-07-12'),
(22971,22768,NULL,'Spellbound Storm','Steel','Sit Down','Under Construction','2025-07-01'),
(22973,5492,6836,'Snoopy\'s Flying Ace Adventure','Steel','Sit Down','Operating','2025-07-18'),
(22979,9307,NULL,'unknown','Steel','Sit Down','Operating','2025-07-16'),
(22982,22981,NULL,'Montanha Russa','Steel','Sit Down','Operating','2025-07-11'),
(22989,22988,22121,'Travel Duck','Steel','Sit Down','Operating','2025-01-01'),
(22997,22996,6905,'unknown','Steel','Sit Down','Under Construction','2025-01-01'),
(22998,6148,NULL,'Family Roller Coaster','Steel','Sit Down','Operating','2025-01-01'),
(23000,22999,NULL,'unknown','Steel','Sit Down','Operating','2025-07-01'),
(23014,23013,NULL,'Ulan','Steel','Sit Down','Under Construction','2025-08-29'),
(23015,23013,NULL,'Sayakat','Steel','Sit Down','Under Construction','2025-08-29'),
(23031,21225,7028,'Roller Coaster F1','Steel','Sit Down','Operating','2025-07-01'),
(23038,23037,7514,'Ruka Coaster','Steel','Sit Down','Operating','2025-07-17');
/*!40000 ALTER TABLE `rollercoaster` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER check_opened_insert
BEFORE INSERT ON RollerCoaster
FOR EACH ROW
BEGIN
    IF NEW.opened > CURDATE() AND NEW.coaster_status <> 'Under Construction' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Opened date cannot be in the future unless status is Under Construction';
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
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER check_opened_update
BEFORE UPDATE ON RollerCoaster
FOR EACH ROW
BEGIN
    IF NEW.opened > CURDATE() AND NEW.coaster_status <> 'Under Construction' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Opened date cannot be in the future unless status is Under Construction';
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
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER check_status_update
BEFORE UPDATE ON RollerCoaster
FOR EACH ROW
BEGIN
    IF OLD.coaster_status = 'Under Construction'
       AND NEW.coaster_status <> 'Under Construction'
       AND NEW.opened > CURDATE() THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'You cannot update the status before the opened date. Please update the opened date first or wait until the date arrives.';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2025-08-08 17:41:44
