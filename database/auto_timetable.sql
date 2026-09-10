/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.8.8-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: auto_timetable
-- ------------------------------------------------------
-- Server version	11.8.8-MariaDB-1 from Debian

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
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lecturer_username` varchar(100) NOT NULL,
  `message` text NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES
(1,'john@mapoly.edu.ng','hello','2026-08-12 16:32:59'),
(2,'john@mapoly.edu.ng','hello comments','2026-08-14 00:37:39'),
(3,'john@mapoly.edu.ng','this is nice\r\n','2026-08-19 00:43:50');
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `course_requirements`
--

DROP TABLE IF EXISTS `course_requirements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_requirements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_code` varchar(50) NOT NULL,
  `level` varchar(20) NOT NULL,
  `programme` varchar(20) DEFAULT NULL,
  `lectures_per_week` int(11) DEFAULT 1,
  `practicals_per_week` int(11) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_requirements`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `course_requirements` WRITE;
/*!40000 ALTER TABLE `course_requirements` DISABLE KEYS */;
INSERT INTO `course_requirements` VALUES
(1,'COM221','ND2',NULL,1,1),
(2,'COM223','ND2',NULL,1,1),
(3,'COM224','ND2',NULL,1,1),
(4,'COM225','ND2',NULL,1,1),
(5,'COM227','ND2',NULL,1,0),
(6,'COM228','ND2',NULL,1,0);
/*!40000 ALTER TABLE `course_requirements` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `lecturer_courses`
--

DROP TABLE IF EXISTS `lecturer_courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `lecturer_courses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lecturer_id` int(11) NOT NULL,
  `course_code` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `lecturer_id` (`lecturer_id`),
  CONSTRAINT `lecturer_courses_ibfk_1` FOREIGN KEY (`lecturer_id`) REFERENCES `lecturers` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lecturer_courses`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `lecturer_courses` WRITE;
/*!40000 ALTER TABLE `lecturer_courses` DISABLE KEYS */;
INSERT INTO `lecturer_courses` VALUES
(1,1,'COM223'),
(2,2,'COM221'),
(3,3,'COM228'),
(4,4,'COM224'),
(5,5,'COM225'),
(6,5,'COM221'),
(7,6,'COM227');
/*!40000 ALTER TABLE `lecturer_courses` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `lecturers`
--

DROP TABLE IF EXISTS `lecturers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `lecturers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `full_name` varchar(100) NOT NULL,
  `title` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lecturers`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `lecturers` WRITE;
/*!40000 ALTER TABLE `lecturers` DISABLE KEYS */;
INSERT INTO `lecturers` VALUES
(1,'Mr Adebesin','T'),
(2,'Mr Raji','L'),
(3,'Dr Orunsolu','L'),
(4,'Mr Olatunji','T'),
(5,'Mr Paul','T'),
(6,'Mr Salawu','L');
/*!40000 ALTER TABLE `lecturers` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `timetable`
--

DROP TABLE IF EXISTS `timetable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `timetable` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_code` varchar(50) NOT NULL,
  `session_type` enum('Lecture','Practical') DEFAULT 'Lecture',
  `programme` varchar(20) DEFAULT NULL,
  `level` varchar(20) NOT NULL,
  `day` varchar(20) NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `venue` varchar(100) DEFAULT NULL,
  `lecturer_name` varchar(100) DEFAULT NULL,
  `lecturer_title` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timetable`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `timetable` WRITE;
/*!40000 ALTER TABLE `timetable` DISABLE KEYS */;
INSERT INTO `timetable` VALUES
(18,'COM221','Lecture',NULL,'ND2','Monday','08:00:00','10:00:00','COM RM 2','Mr Raji','L'),
(19,'COM221','Practical',NULL,'ND2','Monday','10:00:00','12:00:00','LAB 10','Mr Raji','L'),
(20,'COM223','Lecture',NULL,'ND2','Monday','12:00:00','14:00:00','COM RM 2','Mr Adebesin','T'),
(21,'COM223','Practical',NULL,'ND2','Monday','14:00:00','16:00:00','LAB 10','Mr Adebesin','T'),
(22,'COM224','Lecture',NULL,'ND2','Tuesday','08:00:00','10:00:00','COM RM 2','Mr Olatunji','T'),
(23,'COM224','Practical',NULL,'ND2','Tuesday','10:00:00','12:00:00','LAB 10','Mr Olatunji','T'),
(24,'COM225','Lecture',NULL,'ND2','Tuesday','12:00:00','14:00:00','COM RM 2','Mr Paul','T'),
(25,'COM225','Practical',NULL,'ND2','Tuesday','14:00:00','16:00:00','LAB 10','Mr Paul','T'),
(26,'COM227','Lecture',NULL,'ND2','Wednesday','08:00:00','10:00:00','COM RM 2','Mr Salawu','L'),
(27,'COM228','Lecture',NULL,'ND2','Wednesday','10:00:00','12:00:00','COM RM 2','Dr Orunsolu','L');
/*!40000 ALTER TABLE `timetable` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('Admin','Lecturer','Student') NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `level` varchar(20) DEFAULT NULL,
  `programme` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=206 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES
(1,'admin@mapoly.edu.ng','scrypt:32768:8:1$gkffQE4ArYXYeXOF$ed6ff77075b60d74ca18f5a9bad070f091b0f632ae13c24b71328f9de03c5c2edf873714a8f727e0072c4314cb47ffde0f80752e6c71a6ff405d7a153780d58c','Admin','System Administrator','admin@mapoly.edu.ng',NULL,NULL),
(2,'john@mapoly.edu.ng','scrypt:32768:8:1$47KdRPeiM4Xn3HbU$16c26a1a6785ead20e67c9f2f9dfaaac31dfb20ec3cbf5f6d132860d1fc2984fb3323b26bf5912d9a16c69f65aab3cc871c5d5fab648af523555f7aa4b34a11e','Lecturer','John Williams','john@mapoly.edu.ng','',NULL),
(4,'obito465','scrypt:32768:8:1$4v8so6Dygqiu3OpQ$cc496b486cb49a9cfaff025829fbfc7369bc361e801396da6d567d43e0c2f90a632b823523e32590b1be322b1ba53940cccfb9ed4a9ac7caa3894a905a9566ea','Admin','Obito Uchiha','obito@example.com',NULL,NULL),
(6,'MAP/CSC/24/001','scrypt:32768:8:1$M3wOZXVEg87IiFcG$170967b88e679fc618fc0e129ff19a7227279e1a03b450363adabd62d79f5df036587fbfd7a17a7fbeafcb572934dcf22a735f745b6fae9ffb2f795a259fa44b','Student','Tama Example','student@mapoly','ND1',NULL),
(7,'Madara465','scrypt:32768:8:1$JtHcszWpdf0iBtYG$19f05ce55c38e47b3f25320ed0a91013b481a9e3dae418e9b976120b62e1f8dd583256b16376ca23c9e060c8e0bb36a1d5b4d6a0126c9138b5cc4267004d9c73','Student','Madara Uchiha','ghost@uchiha.com','ND1',NULL),
(12,'okarin','scrypt:32768:8:1$fUw1N1DphNdoeRmB$4bab6e43f276160b51174fb8b2d685fb6ec91dc8d9404826d3694793052fd7512ba68e07215e550b33d624c9959281b25c04381c350979ea466abc44eff5d78c','Student','Okarin Ritarou','Ok@st.com','HND2',NULL),
(13,'lords','scrypt:32768:8:1$1DNc2WImbAdypQPG$a0358147580e0ae5a20ea5978f57588113bc25d6a9d96d7f65c3b5402b65e891d303b89477961c75d4670a9c0a73e3a77e8c2ce87f6f1508b7d1bdb6268c9078','Student','lords lords','lords@example','ND1',NULL),
(15,'Itachi465','scrypt:32768:8:1$yyvdLiOGJuGXCKUJ$bb4b79da77e5b0d5fd594cba755c93f37f38938733468c62df19d7c63f06fadbb489eead9acb99a38f371a106757e05811a7a132a4756b754e11a5ab20252519','Student','Itachi Uchiha','itachi@Uchiha.com','ND1',NULL),
(16,'Bpanther','scrypt:32768:8:1$IIObl82JwoKGwYHN$1755009094f94e787d0fbc62aecc1e052133cddb81288d12c77a6eaa2dd4646dddd4ebb4b288ab445dd23dfbc5b30e98e0b7912aba37adafdfacaa163c215e51','Lecturer','Tchala Ogona','panther@wakanda','',NULL),
(17,'Triumph','scrypt:32768:8:1$pmOJKZbWRkfuBwRs$47d9b7173831307ed642ffa5006acfa86c69222a28e26fa73d90f59d82d18e08b3493e97cd5c9bc5ac99328b415f48dd4ba58090d02d023d3e57e0be999d88fc','Lecturer','Olatunji','Trium.Ot@mapoly.com','',NULL),
(18,'21/69/0002','scrypt:32768:8:1$59tKXBquiwZXkNYJ$67475097e68fc47464b3d202b8272c6ed2c525f430b4a9fe96f1a5f60c334a7fea4192634665e93e6280e8f46812cf5ba3a7c3c66fb9e1db2c78c432b9146669','Student','Shittu Oluwaseun Gbenga','','HND1','NCC'),
(19,'21/69/0026','scrypt:32768:8:1$VI0V7WEMQPYvI5sq$938441080a00c97cb4d3fc25dd5005e9e652073f240ce5c55c5693dccc922112f52d1ae78f5436b23292cb5207762615757e5f5e7d6f34e5d787897812be8b05','Student','Bankole Adebowale Ebenezer','','HND1','NCC'),
(20,'21/69/0040','scrypt:32768:8:1$xAWYoDYzT1yzfikk$7e6d522b7977733b5f9a113726b7dbcc54534fa5ec6d109b89552707bc589ea009f0138202c292d36c1f81f97250555e96b54a98bbabcb816587a9e09a0f22c1','Student','Bankole Lateef Damilare','','HND1','NCC'),
(21,'21/69/0051','scrypt:32768:8:1$2Z7aeJI9EpTg0MRk$892b41940c90d4749619c04725bae071d937f108d9f8c46eefdec4f2d915995f76d895d1209c9c1216b8ca73309fe1cc3fac82937a6140447ed0ee7873627203','Student','Basorun Rabiu Aramide','','HND1','NCC'),
(22,'21/69/0052','scrypt:32768:8:1$ixjflCJ2IxJ9fwPF$7ea1fc20c1f9ba78bc8b1a3872b24205017db865e2b959e59c64fb266a9ac9755ec9339eec5871d2ae277ca47c4591d7f75fa0b706c267b8c279f490df06d1c8','Student','Akinyemi Daniel Olayinka','','HND1','NCC'),
(23,'21/69/0055','scrypt:32768:8:1$RJmDKVS1Dwbe3NeE$1f3d982eaf0e6a6cc64cefc72cf5a5536adeb61f72779bdc0ac007a42098beb4c68fdffd6b8fd4de98b9d3812104019bcf8ca9ab39885dd8e1db5dd7d26c1af1','Student','Itabiyi Samuel Kolawole','','HND1','NCC'),
(24,'21/69/0058','scrypt:32768:8:1$eluDyXfD8PdQ5YfY$5b7698e150b74ebe3a102465243aadb67018735d7abae5e1042547bd9fbbe6d95e03a7762f7fadea7a0491ff15012bbf69f47b5b5976dd0a1b35280f601c4288','Student','Lawal Olanrewaju Oreoluwa','','HND1','NCC'),
(25,'21/69/0066','scrypt:32768:8:1$TNpK2Gwuak3gPAzf$6fee4e41dd99d3258a4deae934b68efb09543df3bd917cf398728aa53f1ffd2fd839f98fe1ebc5287ab89367308e0e0cb45fd54401ec30888ea7147ab0772606','Student','Akanni Ibrahim Ayobami','','HND1','NCC'),
(26,'21/69/0068','scrypt:32768:8:1$YJgW93LfyCe1sBkn$c9ef1ff554bdacc4ffea3a2ecac3c205eef2a4643fbfa25cfdb980170798acef4cb25f079104838435bd9ef71cafcd5589ece6821b71266c6b09016bcbf8d21d','Student','Akinyele Sodiq Olamilekan','','HND1','NCC'),
(27,'21/69/0069','scrypt:32768:8:1$HggdTsyWhLjBRlA9$3c592c933b892ba5781545f05db93eb94ff5a7828e46585b448e035ca2c92742f614c522239876ba5123ccab0dc7505b0b702a25f9210b2b18e02e307ecc0793','Student','Ayebo Oluwasegun Micheal','','HND1','NCC'),
(28,'21/69/0071','scrypt:32768:8:1$IuazPfLKJqXNFWjW$50a494e72fb44dc3d888704cdeef2eab69007da4071e11aa79b5ece8af4a0ed11031249d1067fefcd97d58d889f8bdfd55ffdcb7727aab2946cdf01ff1fdfaf8','Student','Ahmad Toheeb Olamilekan','','HND1','NCC'),
(29,'21/69/0072','scrypt:32768:8:1$aoJMoe4a3LZjhvGt$d7334cc78969ab2e46af2464f5fde7118c4b7e3fa76827f085db11b03bce569ff534e87550dad263f6cd01f1531e77187766e1ef112031a785ae6dbceace4230','Student','Adeniyi John Adedeji','','HND1','NCC'),
(30,'21/69/0076','scrypt:32768:8:1$H92kJ5CrZk6ShzSE$a9cae085d1fa6970f850560606f572c1e58440ffd9c3d9ad4ef4ceb7eaead61ac5b458ef62df9d43aa1f8df4eeff508ab545801eb42d0bde5b0b830a3c23975f','Student','Durosinmi Eniola Francis','','HND1','NCC'),
(31,'21/69/0082','scrypt:32768:8:1$fvovsyYM6m7we5uA$5bf55dcdd2805dac62f4cb6c8c30bf5c1453c6b158c49b3b0796ed3eda19284fe82d166b83eb43defbfd5e8e4176404686ce18798717f2113ef59d932f8f0b5a','Student','Salako Kafayat Ayomide','','HND1','NCC'),
(32,'21/69/0087','scrypt:32768:8:1$kzIxjakapn4sQeLW$813c8beb5a21291907296c2d94a7b5df3eb5b201531d40189df44ad278121cfae6517fa5ec0c9179de9ca50b9d0cb0c56404e06fde4bb916328baae5e6299f76','Student','Okoli-Igwe Victor Chukwudinma','','HND1','NCC'),
(33,'21/69/0089','scrypt:32768:8:1$XSXxbOkVDpcRQbAR$a1f311016f5425185e7e6539744ab9fedc0a2607b48800127b77e00d21be082f3286e238f2699171aac58bc8bf439069ee19fa46f7f8947cdf2d2457b0814974','Student','Adegoke Mariam Adebimpe','','HND1','NCC'),
(34,'21/69/0101','scrypt:32768:8:1$xrHIZ0dR5FZv3vzk$a04a9fd0f886c68a11c5e6311031f9a393a25c87f331717497d45c684d46d2bf4cd4b4dbfe9d2a99463fd60dcac8138fe5f50816390d0c5bff3e906c4339a787','Student','Ayodele Quam Olaitan','','HND1','NCC'),
(35,'21/69/0110','scrypt:32768:8:1$JIAaNYzqJJQUYHy4$465d80525d30e68d36f775a79fe4f4bc8e02325a3e40a4e1c10d143cab84391743313ff0933deb7ae7ce7ac1d949ea3b7309b62b42f32253c1bebeccfd6a07ef','Student','Oloyede Ganiyu Omogbolahan','','HND1','NCC'),
(36,'21/85/0004','scrypt:32768:8:1$3xrPN8HFRIctWlcQ$b84db94c1cfd488655c506807334d7e4d992886e665c41630a041df0514b1e759e350e0e26edb2b46d66d2a20934e2b63d45062d08df352d6aa4668552f0eeb4','Student','Awakan Wareez Temitope','','HND1','NCC'),
(37,'21/85/0007','scrypt:32768:8:1$HA1BsQA1B86Z64zQ$4bb086286df5e7c3afb0e752e69c2e5badfc70762c70fc7f8745fd446f67c6ec5d5673d7d6f3f74c119171b35548280f719ee2c2fe98b54524cdf3bd6c7f358e','Student','Otun Taiwo Abeeb','','HND1','NCC'),
(38,'21/85/0011','scrypt:32768:8:1$J6eH9keSZ1im8MTv$25dc18420d25235c6a284f7bfc97fda2b7d4e5093e25dc3c9d1e6543a0b4048105d93691554f9d11cbdeac216e43cdd7f917efcb4d35a44791e324d9b2bd4b85','Student','Ajileye Taiwo Tawakalitu','','HND1','NCC'),
(39,'21/85/0021','scrypt:32768:8:1$q6BVeNZdBUCN2zo2$90586f1dc47342d432aee364b3a95eb8f296c2315a320b4eb5804835d9ff750005437ea8a9f0742a27bcd6449e9a9cbfd50f261cad17dd446477fa519a3928f6','Student','Atewologun Opeyemi Ayomide','','HND1','NCC'),
(40,'21/85/0027','scrypt:32768:8:1$68H7kk5N6cIOYibo$287573905b015f0175208afb37f5d6095caa4070b998d3499ba085e54b54a094b230143a888d5b5ea6e5978677d7f0183cd1ebbd452fb416ca308323d15849c9','Student','Babatunde Abisoye Elizabeth','','HND1','NCC'),
(41,'21/85/0029','scrypt:32768:8:1$tmooliwYDEYykkUB$54013cb37412603057797494c5173a482fbfbd68177e5493c9799fae7e57a14e8fe219f2f245d135848c05df9ddfa775aef71e47947ffd81cbbad97a3611d99e','Student','Idowu Jubril Oluwatobiloba','','HND1','NCC'),
(42,'21/85/0048','scrypt:32768:8:1$3Rj4kAdcPqSsfxOv$6e36ce9fccc70542e402102f4e0306283baf60d7d4db73ee5ef19bee7ac5e7ef041103a666c905cff95944b0ea5605b93ee0923b52b8d5624159dbc10f30e59a','Student','Adesanmi Ibrahim Gbolahan','','HND1','NCC'),
(43,'21/85/0064','scrypt:32768:8:1$ChKUs4uiQtTsfwSI$cb95f32de88d9be9d9b0a6397f4570406c5a58e71a9a681088d4dac347ffc4025b194b314a042810f490af9bdfa7e525c7698a1af31304495b192830a33e69b4','Student','Johnson Eniola Bobola','','HND1','NCC'),
(44,'21/85/0071','scrypt:32768:8:1$HmhJPyufZh26ueby$f41a208d676e7f8905a2c811f7d552771fc85e5b0bf54b05d98c353c12a0441496b4ce01e7d7a64398d28dfd3f5ed3e813b4dcd1c5deddfeee6c6d2065bab209','Student','Akanni Mary Oluwakemi','','HND1','NCC'),
(45,'21/85/0079','scrypt:32768:8:1$oiyhpae2SOrIC8y9$3cac0a5d748855a03ac0ac1ee7950fd0cd9ce8d621ca99c7a3cb19e7e0f8a885ac7eb9eed63dadd8e01af1b684577d5a4719285635efff95cec4bed031d81cf2','Student','Ajose Abdulmaalik Abiodun','','HND1','NCC'),
(46,'21/85/0080','scrypt:32768:8:1$A0PsjdhLAIQAwNma$c38538d8707e5ab8da7677a5236a9141f9031549d7a10ac0f93d9fcbeba68bfe1173aa674e0738d3cb4138322c91043e7ed2c5ae2b1f74f0661ab509b4b758f2','Student','Ogundeji Anuoluwapo Abigeal','','HND1','NCC'),
(47,'21/85/0098','scrypt:32768:8:1$s26KrPyjb1fe9Y88$415ce8e3d20ff848cdaf9f8c8cf0634f92de016e431d184140ca463ce11b480f4b82e0c4fb8f48821f0a0909479f65bafda3da189f2bdf67377fe2eb37a0096f','Student','Ogunsiku Isaiah Mayowa','','HND1','NCC'),
(48,'21/69/0080','scrypt:32768:8:1$cWYSxQusZMmvrEzg$a487bc2695b722bc7b90d7ae5293d98110ff548a081dd240c787ae10a7404a953b7783ef3696c65e2ad1a7ee098fa2d24e5c8395a5801b61929ac25491c557fe','Student','Abdulmalik Kabiru Choiceson','','HND1','NCC'),
(49,'21/69/0006','scrypt:32768:8:1$w5qEeJa03od8IBGb$472e59ff8d106f20bf43733d7dbc2ab03c7d22bbfa5406aefe73acd3819128a4a099707ea40c468c80aa09ab1a169fb76d9533da449ff9cce03870c4e2b16d80','Student','Mustapha Musa Arinola','','HND1','NCC'),
(50,'19/85/0045','scrypt:32768:8:1$V0h9KGjSDGrKYBBB$ed7aeb8cd502391be0b6429d1368c346a80b5c4341e0d88a224e386737e82a2741c523df67654b21fe20c37352c80ce0171278d1efb2e3aa8f254c38cb4a84ab','Student','Adepoju Michael Ibukunoluwa','','HND1','NCC'),
(51,'20/69/0069','scrypt:32768:8:1$dIDpZiXG0HMi2uLZ$b1660d95822e1895294f565aad363823446c8e7014a0c0296d57c8e4e0ba3d97a0d585174aa444bb8b5358b91b405ba9c2310881fd88a1f455f66a23093950df','Student','Abeleje Tosin Bolaji','','HND1','NCC'),
(52,'24/345/0008','scrypt:32768:8:1$X2WnGhbyqrjum39F$17255c5705e1734c6bb17082e4785854bd54ab8262c30a8401a63799163f1af6475e4ccadeec45e8ada61425a62172cdeac6fd6b2d8ffe40d710ed07aa836463','Student','Fabunmi Esther Oluwaseun','','HND1','NCC'),
(53,'19/85/0036','scrypt:32768:8:1$drrzBQD2stKS976R$578a5df14195c373a0e8aff5ec58829dececf56ad874a9ccf7eac402c1e2bbe2e87a5e45cd5c84f12e2d08d83e54e7869b583c9488169d69f0759921d4a28726','Student','Adewuyi Emmanuel Olawale','','HND1','NCC'),
(54,'24/345/0007','scrypt:32768:8:1$uDLT11gSGPOB17C7$bee3aa36c9f44d3461607d72934cd3a85d7aec5a660c5d24b6d358b115c0c5294ffb3e1c5f8367d589d9bf1e2e855a12d0c5b33d54a952d09a17c5ef41029a2f','Student','Fasipe Folake Rebecca','','HND1','NCC'),
(55,'20/85/0088','scrypt:32768:8:1$3OzZwc4wGsYsaI6G$fd04c2d81c3a28550e5e8c0a5f3ebf6c80391034d0b48a415d6ecb082554fb617f8819cc98e59bfe2c3c4169df6342cc4f97d9e83d82269c799f160ce0854fbf','Student','Olanrewaju Modiu Ayomikun','','HND1','NCC'),
(56,'24/345/0004','scrypt:32768:8:1$x0Gmj9613w3dMzOA$f71baebfb039f6c73ede08ff4cae933e9e38d7973d318af2c8f3597c1a97ab99170a9b48d269215960eec4bea3c5e9351c9e8c5c598b178776f8e1a8f9a67539','Student','Ola Oluwadamilare Abiodun','','HND1','NCC'),
(57,'20/85/0032','scrypt:32768:8:1$UW5X55qwikMxBhuB$76691479a9049375e2f2d195ac4095860f05663b51e06c7470f3b98007ead55c931665d1c163a1efd68477450093ea355f99ffdba2bc465701893ba7fa966e4e','Student','Ayorinde Islamiat Omotoyosi','','HND1','NCC'),
(58,'20/85/0022','scrypt:32768:8:1$iSNfgJ2hiww8FEIT$467f104688740cab0276ea75902aa6acd67d077ee683483e2a66563ea174a2bab5d15b00aa3307ea38f7a9151014df7ce0acd1fde2375cde81b9c5ac30858359','Student','Olatunbosun Gideon Adeola','','HND1','NCC'),
(59,'24/345/0010','scrypt:32768:8:1$ct1bZxdu9lnWQAvO$5766e5ac75c6727c4e7f048f5b0448b43af700939a1f7507886784d61b4e0bdd616da8bc10e5df5ab942bb7fbc775c60f8e0e769f7fdcffaff2e65486439e122','Student','Olatunji Damilare Emmanuel','','HND1','NCC'),
(60,'19/69/0184','scrypt:32768:8:1$G8DEIzXe0poXA0A7$0a62b291408f94b37b3642d11ef2af71f213a4524fe4060d6496eeecf549f071a1dd953bd165255e406ea9aa3c03c03df6a9bd4573a938f3631817d4c83c7294','Student','Alani Stephen Adeyemi','','HND1','NCC'),
(61,'24/345/0012','scrypt:32768:8:1$FVzPJ10fjsetPZ04$de2b33cd79177ba870688101b2337ae0e64114d600629abda68df93f23d056a9e6a4d4e67e613dc4912579f1d9ae48f24f473fd9680f1b3ac4c199692210af95','Student','Popoola Oluwafemi Adeoluwa','','HND1','NCC'),
(62,'24/345/0014','scrypt:32768:8:1$lpVoNv1HBopjXz4g$65b16db5e20e4aaa2ddb38eef642334e3d79b88134ca0fe990ae1e8b219f322ec6b10714ab9eac811db7b5623915c3838707a7ccd3dba595f0777de5612a926d','Student','Sholanke Abdul-Fareed Oluwafemi','','HND1','NCC'),
(63,'20/85/0030','scrypt:32768:8:1$5kwh2MrtlZ9j4HMc$48af31bf3058a8737b5e4fd5caccd41b4c1c8472e615a47ec5cb632703d52d8708a9fd431c6ba575f6d338b8870b3a31445cc2830866268d01537be1c7a83a71','Student','Sulaimon Wahab Afolabi','','HND1','NCC'),
(64,'20/85/0061','scrypt:32768:8:1$fkjt5JieVbW3O9O7$e9c817197addbfafcd2e268c8921025a53de546de06110995e0d60000a82e731c42287c2af924d0efa295f5cb22c13be3dffa36477b88e7767dc5b6293613e38','Student','Ogundele John Oluwajuwonlo','','HND1','NCC'),
(65,'20/85/0090','scrypt:32768:8:1$JT7uozjDyZCony8s$1ec34aa8c27a1cdf7d13875735e577c619ff0c92976bfd36f5933d132e2439cce159bc1269c74fa26e69cff9ab94ce03cd12e8d9435b4290e35122d52b045737','Student','Abiola Habeeblahi Olamilekan','','HND1','NCC'),
(66,'24/345/0018','scrypt:32768:8:1$ZUOL4VNfBi8QvnwF$9c53e491105f940f2de73d22d9d038e6f1edbd1da59f6a205cdb9845afcc8fbcdd74c8b11f0ad252d1d7c617e4fd898f5044e0aae064ce6755e7dc7bf2f087b7','Student','Ogundeji Anuoluwapo Abigeal','','HND1','NCC'),
(67,'24/345/0046','scrypt:32768:8:1$MfxdaZcN60fZQ6q4$d10d0ef9054bb00fb4a9074552b6d9788aad41ccb5428c8c8dfedf02b6f794f5fa41a8181bbe1721f9b5c21f983622c28141c8156b8731ec0112b3c40c363bd3','Student','Amidu Sodiq Oluwatobi','','HND1','NCC'),
(68,'24/345/0021','scrypt:32768:8:1$USrcE4Xg6V12MzRy$67b401f58dd297b32937ed0981c6ad8999c45fdddbac8058ebf603cd6783f7c6dc136318e0d7640a32300d5f6f5c85a4eb37dc09c11671d74fe08d969d727e6d','Student','Omoniyi Sunday Joel','','HND1','NCC'),
(69,'24/345/0044','scrypt:32768:8:1$AorraMy9MpTSLvvU$feec1a06a3026df7f191bab81f553ba980f15507b90df898591f22bd417b623275bbdd5d7a8d4b4ba44c7a4fbb128b6526ab57fff0bde66d20f53d478383e6d4','Student','Adefalu Sherif Abiodun','','HND1','NCC'),
(70,'20/85/0021','scrypt:32768:8:1$bNvr3BQ4BL3u25r4$8c6d6434616afcccb2606ec64d317328ab6ebcf74a85323d215628e88865867a91e2bcb95ba3d4dd954af40f74b784b116a8913ab7b8332bc52f1dd6f7d78ad9','Student','Ogunbela Oluwaseyi Dolapo','','HND1','NCC'),
(71,'24/345/0023','scrypt:32768:8:1$9UenIMMVh1aR7dKD$a8ef99a250f49464e6dbce6bb66da1d1e055063edd4de5bf766f096e0dc5aacf1f2c5a13b2f9de74015e272adf2bdd36134468599587ee557fc3f2852b1c78e0','Student','Salami Jeremiah Gbolahan','','HND1','NCC'),
(72,'24/345/0045','scrypt:32768:8:1$aP0E8dyhnP7Mr5wo$f0f300023877ac0208179218e4f313892b4e4c4569049130dfd021c5bbc7516e65ba677422694b9e0dafab56eea848cbacce59a0382cce9a314996e582fed324','Student','Raji Ridwan Ayomide','','HND1','NCC'),
(73,'20/85/0131','scrypt:32768:8:1$gnoWWAvY112KypOB$e2aecd8541f5e8e1b97b4d4be97a0bb07932f1fa91c33fee1c016f22bb3da867d2b004d5e382d7501f019b259dd1be92fbf9ee2ca507dab7b2c195959b1ead0a','Student','Dahud Abdullahi Akorede','','HND1','NCC'),
(74,'19/85/0041','scrypt:32768:8:1$72RS5Wdzwq1ZaKa3$3efdf0d9c9f9df1334029b08f0d67cde9bfca6fb8f5ec85dc88a2b1224994367042e1c4802c37574f7d595cbad54fcb171b5596485770ab1def09c85f695ab90','Student','Akinrinola Daniel Oluwayomife','','HND1','NCC'),
(75,'20/69/0058','scrypt:32768:8:1$VWHkj3pKIuqtGzun$042c025e7f8a3200da5cef06b72d345e0d85fcef50c9e950a10113b533528b5d09249acefd6dad033ecf9cf4ba15c91f621b467f4bf9faeda36349ff75c48e75','Student','Adeola Mujeeb Ayomide','','HND1','NCC'),
(76,'24/345/0029','scrypt:32768:8:1$59OalSwjGkdL84cl$3cb19a1cb95b02399360a45c5e4f19a6aedd668d624f76fe63a1a1afa3da2a3ea9698b0d3e6bc136331dee91ef98aa713713a717166f9d5723e44941ec9e3975','Student','Odole Joshua Adimula','','HND1','NCC'),
(77,'20/85/0129','scrypt:32768:8:1$P7zElXrOSyZejxq7$eb9ba67959e89c75fbdca4ada0dbae90a335d6342b9af0d68f7da55a5397dbe7d823b63b52ef983b2774319b3e62132efd8ff9b9bd472224e73394e438ae67d9','Student','Adekunle Usman Akanni','','HND1','NCC'),
(78,'20/85/0100','scrypt:32768:8:1$yVSiSHMMFV6KhWq1$c29a490f5cc7ed53aabafbf637e056627ee0e6219be9746e6d18a8bf4069c3a225db27f012dbcf150e800737dae88d9b0442a65cd94b49f5d47936233981944f','Student','Famuyiwa Olamide Ebenezer','','HND1','NCC'),
(79,'24/345/0040','scrypt:32768:8:1$sJeOQwWJUlVVelXA$7deefe9a2df2074017ef02a061d5efd60162b0374159e8a7bf50c6a081940c92d08df5a44b3c629ad03e1a5b9cacd3509426f539660ba5bab6d97cb55392a3a0','Student','Idatsaba Emmanuel Onoshoze','','HND1','NCC'),
(80,'21/69/0001','scrypt:32768:8:1$5xBujurXwJdX5JOR$75712854b69b7d25844c5d9cc83585530a552281e7d8ee0da10862b13607b022064faf51e617ae8335035a07136928f5af7c29c8a61441dc26b4066afc159231','Student','Okeola Alaba Onome','','HND1','SWD'),
(81,'21/69/0004','scrypt:32768:8:1$4OB1HOWuCjlEwYN8$19a554a0e9b6122cf0711e6e9402d733b2360a1ac553e81626e45cffe7648d858dc9a0cf2ea62024e83f1f7f257d835e4823eb7cecacbfd1a143ff2e625995ee','Student','Akinwunmi Oladimeji Oluwatobi','','HND1','SWD'),
(82,'21/69/0007','scrypt:32768:8:1$2G548BpSMOXmXau2$e1ef98bbeaa8a40ea885b830aeb7c2bba612e89789e43466b04e252056835a3c1cbb606d7651ad62056e29d500fac236094dfbfea6f11f64a7ccf31904c5f4e4','Student','Aina Toluwalase Moses','','HND1','SWD'),
(83,'21/69/0009','scrypt:32768:8:1$ZN0136ENnpnQvLwj$894dd4eafd78dc159e687898815d502afad7915b2737e619fd7c83901f4cd2d0da8dc26c43fa67b7825500415df376d48db0ee0d242adceaa6221b939d5d8d6b','Student','Jawando Mubarak Oladipupo','','HND1','SWD'),
(84,'21/69/0010','scrypt:32768:8:1$qSLblc0Sl973pSlA$cb872e1f2c5fea8235e9adb509ca89713597290f2a4900f755ebf3395d4482890c2b520929d80bed8027b0110a4bbfa7d9232636312876fc5058ff4a9af72abf','Student','Eseigbe Godswill Oserhieme','','HND1','SWD'),
(85,'21/69/0015','scrypt:32768:8:1$ZAYCts1VNDA5TbpJ$5900e409e89978d3c253cbd09e0828715ef8141d44c55b389c65a82fb695ead2e3268ad0af5ca5d2b8918c573d689f2a6d1436ce10101f6c236db80db9b2354f','Student','Olanrewaju Olasunmbo Kehinde','','HND1','SWD'),
(86,'21/69/0019','scrypt:32768:8:1$wWGUCUgK0pjvO9vG$18121525e6d9f8ee6e86c5ae4b785fcea682ff465b5c7ee1d5188a3dc666eb4d0f4ba00a09bcbded0f732c370b30ee2114e8084bca9b51a388eb5b210ca60947','Student','Salaudeen Faruq Opeyemi','','HND1','SWD'),
(87,'21/69/0020','scrypt:32768:8:1$kFlwL8mOtn553vfo$cc1e49d524f88f58c0e94dcf41c1c6b9604b1e7d084c3d68af95ef17a1a6b237faf46d7be44e9b40bb17c68f86ba7dfe8f7c15323e2e1ed9117c666f379269a6','Student','Agbaje Olamilekan Sodiq','','HND1','SWD'),
(88,'21/69/0022','scrypt:32768:8:1$9BdgwwyD1DjSytKt$99a3dec2d4df5fc88f90fc6c599805b1891d278b67060a355fae649be16cb9b9313aedf7a90084373d1b32f58fcd61bd679b18a458f90faa0c5479e2fd6733e3','Student','Adisa Solomon Qudus','','HND1','SWD'),
(89,'21/69/0023','scrypt:32768:8:1$22iOrsX8TAE8FU4K$8d270c485fad7c24f2d5a529bbba2775f6f615a1495ca223641d71209219e161f3b793dc72067c076d00023c93477720f8fc363f14ee01c62d62e99cf3fa4ec0','Student','Adeniji Samuel Oluwadamilare','','HND1','SWD'),
(90,'21/69/0028','scrypt:32768:8:1$rNVuiZExusLOJlvZ$05b65d40efd683bceeb05555137f590abe2d3213d010d5ea77a45a06bf0dc54d462137eb0957f6f4d3be1aa87b32fc16203706e92322188a38fe801e116d96aa','Student','Okolie Arinze Frank','','HND1','SWD'),
(91,'21/69/0029','scrypt:32768:8:1$eOugWqKOxI0UYkHF$d4d5307f1678446cdb9122e9b4b15976c827d7df463664013ccf8b898482878f7c7f8c01d9806e04a34ead6f9e089e55c76d96d26a909732a3ac3b4d358eed67','Student','Adeoti Damilare Lawrence','','HND1','SWD'),
(92,'21/69/0031','scrypt:32768:8:1$ocRNyXJzJbznMcWf$3f5b8c231f920e21db0025a90ea84baf0acc26e4ac529b185069aa3287cdd110993d795e9f235fbc5bfa3c096ae5b4286670cf546623acb7c3e5efb78d980664','Student','Olatunji Jephthah Babatunde','','HND1','SWD'),
(93,'21/69/0036','scrypt:32768:8:1$8uvckVyLWyOmlmfk$54eed96435d17f16d21a56c842f0a848250f11aea9edba00720b0e103b77c6c3cc2522ced325d7667364168a54e6d6035792004f5925ef56cae59b7ebd767ea4','Student','Emmanuel Olajuwon Oreoluwa','','HND1','SWD'),
(94,'21/69/0039','scrypt:32768:8:1$eLbolHo6szVqx3vv$ffe8eb73c10e23ab86933ece6e033fcfb46e84c4f8fd97d96120e8930d735c84b351f74817ef35fd613760ae12a2d4b98fd67cd7fb60b3120de910a5e63e34dc','Student','Sobande Quadri Adejare','','HND1','SWD'),
(95,'21/69/0041','scrypt:32768:8:1$yLU6LvyFRiYOauQt$e0c22ceb125e69af961d15c498f9fc6355ef07aea35e2d51e1bfed72d588df6f28f2652787cf073b558deccfcd83f5ad77a6fb2aa524ba914063a82d8fc93c9e','Student','Yusuf Sodiq Oluwasegun','','HND1','SWD'),
(96,'21/69/0044','scrypt:32768:8:1$Vq1Qm3Fbt81dq2cH$775301dd80c5103fc478d661a65a7b05ab1b7b5380031807400e5ccdceae413240e85e03c72d25a6f955e68f9648b2709ec54fbe738fba91daf506601dd2e1dc','Student','Adegboye Ibrahim Omogbolahan','','HND1','SWD'),
(97,'21/69/0045','scrypt:32768:8:1$xxK0tiXqja6l435M$baf0eea7e37935c7351a0a37b657dbaa2a37129b0ca8c94b238d620a059b4d09fb78fe2e19703238b53bce04ccb2feabf311f406207dc5f36564667343ff1217','Student','Obadina Al-Ameen Adedeji','','HND1','SWD'),
(98,'21/69/0046','scrypt:32768:8:1$e7mxaDb7E2xfe5rM$2a5f9aa13da95947a65c7829d41fc92ff5e33612c3e6f4235e99197d6faa9df6073ad5b4fb86c6e8c94969c91d9aaee539248146013a9990e0203e4563c6b426','Student','Adeniran Oluwadamilare Emmanuel','','HND1','SWD'),
(99,'21/69/0048','scrypt:32768:8:1$oxUAhVdsauttxNIe$48957f3b97a1d9a19792f120f289eb88a4c94011e201b3c475b8d6d6d8c3b3b6b746d1c6ceaa377de97b988ff08aba34000716eb59be1cc9f0032629590df80c','Student','Taiwo Adeshewa Ifeoluwa','','HND1','SWD'),
(100,'21/69/0049','scrypt:32768:8:1$eKC6631yT0PQ8ZcD$ccc358113854928e93c18ba29885881b90a4803cf5e8bc17d2215f6f914de6968fff2e4ca5d62b8bdd24c668b0480bc2a5e5030004cbb61ce9400f92512d2150','Student','Oriyomi Nifemi David','','HND1','SWD'),
(101,'21/69/0050','scrypt:32768:8:1$15jVOBXONm3bU8qf$637b33ad96d848db0924b28bca5ad44628b8246dece27a6266123a7a153fdd2dd0347e4d83c6b18d5e3715e0cc80e2a9bd8f7b622b979f4f3f15ac54e3d48e2c','Student','Akinbambo Samuel Fiyinfoluwa','','HND1','SWD'),
(102,'21/69/0053','scrypt:32768:8:1$UmRdwfYQuJhLGk8n$91310d2b5a22fca6d28931267c745eee5e32f77d58c77f98113bdaa81868062417be4fe64336dd1ac7e3421b643cf03f7b5d7988644701985c3e55558d3e5f39','Student','Omikunle Sarah Oluwadamilare','','HND1','SWD'),
(103,'21/69/0054','scrypt:32768:8:1$GBpPZjRtcMRLbLWr$4f2d7898d6be173290386f346539676e153ffe791acf91c175165a9b518a486833d28e51ee7c33154c0fa4f024a476ed4f6ac439106fece92c501003facd806b','Student','Alagbe Samuel Oluwaseun','','HND1','SWD'),
(104,'21/69/0060','scrypt:32768:8:1$Kz3gPi8rCYGfZ5AD$2e4f948bb2eca93b1420b4e01d9a9742a7de9b14b19453a758fa1ab731b1890ed31248db21b5c6da3ca0cd7cb989e722c83d42a5e5cc6e7dda4c00be943550b7','Student','Adeagbo Abdulbasit Opeyemi','','HND1','SWD'),
(105,'21/69/0061','scrypt:32768:8:1$ycgjcikLddtjGKTx$638ca8d7c7d56662517a955a8cbcf087c17f93d69a13d6a7bc4526e8a525fb3be4b9db68e9aa5777895e58026cac7e4a74989a5241c43caf2e53eb836c3b9bb5','Student','Oduwole Joshua Oreoluwa','','HND1','SWD'),
(106,'21/69/0063','scrypt:32768:8:1$rRg5Mpjj0qXawdRy$9f27e2bc819948e6528080b681dc8a20128e621e9b4ec762ee705da160a462e69881ee63d82bda87599dc05f30a0a959d98714b95834c9d7f50a6152ddbf47e9','Student','Adenugba Oyinkansola Mary','','HND1','SWD'),
(107,'21/69/0064','scrypt:32768:8:1$4u7HAWEmbwNvjmP8$2d14469d88c5be78389799601cfd0e3d72071528dbaec28a9c92936fdc6b80a943b4cba3cfed5af73c55179906c4978089180e788e66360c1f82474ae2b76804','Student','Ayoola Oluwabukola Oluwafisayo','','HND1','SWD'),
(108,'21/69/0102','scrypt:32768:8:1$NxSb0UukHsMDUzyM$06b14e1fc58230dbbf031e22e59438c4050a88499194e491d5b9e8c7bccb87e6be12c13672f8681fd6e427f97f4a1faac3477d511f747462b2840f5af0466c98','Student','Olawale Idris Olamilekan','','HND1','SWD'),
(109,'21/69/0104','scrypt:32768:8:1$qjMOx11YoN823KLJ$3409214e93938baab03823a2db61d422802bcea08cf61645276b8919fd3f404f1de894ef6dfaf3f75273da0fe3705275dda47af06b3defae6ccb94372397bcb6','Student','Bello Ayomide Mariam','','HND1','SWD'),
(110,'21/69/0113','scrypt:32768:8:1$sc0FFOxmY6r38X7C$97f542482b7353306fb5d52acc22bb203d284fdd80d98c0d0378dd55aa0aef8552a8be03399a4df56594e77d2978b4e822d5e66c89ef65f8f63ecc9e665d0ded','Student','Ojetokun Yusuff Olaitan','','HND1','SWD'),
(111,'21/85/0001','scrypt:32768:8:1$o36PMCj9e84KRSss$a18c302228fd3cfa0faa5d38c3c32c1f7a45fd636807685b8c26558446e4a0f66882c6377936a37c3d628ce0f7b11ff3d071c8e948daa89fe258eb1029026e1c','Student','Oyedele Sunday Aduragbemi','','HND1','SWD'),
(112,'21/85/0010','scrypt:32768:8:1$2wajB9QcaWmkadXG$7d65ab4f25e034e4823b70630fe1ec11139718a1cf05269e524bd356768018e11bce5f7d9469814d1d392393da7c3acf0128dc599a9d6614bb2d808305a28144','Student','Adesungboye Olaoluwa Tobi','','HND1','SWD'),
(113,'21/85/0014','scrypt:32768:8:1$29f5VhEMq5yehA7B$48b723473559264f62b7453a8761418b7488122b772c04f2924eeb4ac5254b6c71f00705c76a2453fa541da93453f9703385b79a1efd0215c15b7aca1abda969','Student','Okoro Kosisochukwu Kristy','','HND1','SWD'),
(114,'21/85/0016','scrypt:32768:8:1$7FNFGkAuYITSpqE0$0e8b21a481d98e80613783cf071dd64920cd2551a394489243eee9576f51301cf45aab04091fe5483a2fc3064947f322c4d671b47ef19dabf3d09ae4bf3f677c','Student','Olajuwon Francis Olabisi','','HND1','SWD'),
(115,'21/85/0020','scrypt:32768:8:1$lumx6oN5wleFai62$dbc8c3f1c21df07a9955e3753fbd0d4431d792b7c175a4d21d1781a3aac216e6b7cbbff9559b60476bb2c340cdf8c7e6b47cdb4d503d17fdaed5c1a9bfb02c65','Student','Arole Samuel Ayomide','','HND1','SWD'),
(116,'21/85/0022','scrypt:32768:8:1$N8hY2prX9pmnR7Sa$c9c32c7a31d85fd350e2eaebdb069d1c49b443b223c98699dc75e5f4234534d3e2b5be8da9f646d66756148c4e7149c7c03586748183c2793161f95892100eec','Student','Bello Abdulazeez Ayinde','','HND1','SWD'),
(117,'21/85/0024','scrypt:32768:8:1$RtG72fqzux0AwTvv$40098d44a4eb062c68cdef77656d4c5042766a56fc9d5bc272c0c97411a75ef2cb5840cedd1989b7f12a11c8fa7aca40d11851f0e5d65d5a87a52988035aea0b','Student','Adenuga Ezekiel Oluwaseyi','','HND1','SWD'),
(118,'21/85/0026','scrypt:32768:8:1$2R792TCWguwLeCM9$a749e19f8741fcb3d4dd4592987b5db8e858ba6412b23948d34bd04049876e112605765a6e3922bb8695a5d27df92ac420ded12479ac47615fbb2e7a6182b697','Student','Olusoji Sunday Rotimi','','HND1','SWD'),
(119,'21/85/0030','scrypt:32768:8:1$GqPIofknBlCZt2zf$cfd5c71b179491aea3ec9a733a9de28c3f4b4d830bcf9b6a75009f1744857e45f6c44125101c028ec71be5f3992961bf916ddc66ff7d07da002c8c144c6c5c8b','Student','Rotimi Waris Adegboyega','','HND1','SWD'),
(120,'21/85/0034','scrypt:32768:8:1$qcUM4atAnTX9JWTC$53531dfea5f65cd291cc9924c48d485405719fb271df57adc20f8a659b498e1ccc0b4a1fcf3e8509f7205397b26c10ff20d7aef8dba839525741e94bf90d427f','Student','John Sandra Imeh','','HND1','SWD'),
(121,'21/85/0038','scrypt:32768:8:1$KKN0BEqsyIsLuEOQ$3b0dda9da923b95fa0b0bc70036011f4656d7045982c3aa38088b51af91f6001372b07fb3c1280e42d7b30404bfc07f7a529e42ac113bf2729bf153cc76c81ff','Student','Abdul Elizabeth Ojubayo','','HND1','SWD'),
(122,'21/85/0042','scrypt:32768:8:1$og1pamflaH45pnfi$9f355d2368c3c0a5fd9a63d03007f91df73556893ea482e8d388d44c4e91f25eb2750784a54b9e03a547eba15e818fca180036c3f87f98f92ad08e1ec3c539cc','Student','Olaniran Success Darasimi','','HND1','SWD'),
(123,'21/85/0045','scrypt:32768:8:1$iIgNzjDletpE6ftf$bf7aa11f6e991b5954f205c2c75be0ebf50280d5022138498e8f86abc112e1b212b488d3337ecfde467c1f6018fe28b2a265a6c25a2f9f167b3a81cb0cb97a4c','Student','Oluwole Precious Tobiloba','','HND1','SWD'),
(124,'21/85/0046','scrypt:32768:8:1$YAY6lXlYy1qtCL8M$9e258db7596fb28e00d4c89a6e04aa72f0d01f89ee9ad0a1e7f7ed5e95a12719a9d5cadfd44e6905acead117aa92b7612413cad234f334991f8ddc105ec4ddf5','Student','Rafiu Sanni Olorunjuwon','','HND1','SWD'),
(125,'21/85/0047','scrypt:32768:8:1$JWFb8GgMik5yT4S1$0a49b2523203f227f1913ca1d2d1b34a247bb7032885ea5882a34fe08485aadd4a95db51fcd98618d8702462f5894df63aa6cf4039f88b31e2bc1f37a4120563','Student','Bambe Ademola Olamide','','HND1','SWD'),
(126,'21/85/0054','scrypt:32768:8:1$XFkQS9JqcQrC1fWO$4daeaf793698f89e9663917fe76cbe834817280b31d5835b82aaa35e046fc5a0d888e00217965e4c3398e949c73ad36bfafa9292cf6edf02f4a6fd183883cfed','Student','Olatunji Lateef Korede','','HND1','SWD'),
(127,'21/85/0057','scrypt:32768:8:1$ySRQ5d0E8pWuNWVk$5f1b2af54bba370cee9eab768c5332dce7bcbe1abdb15f3de8ed5bf602a2c337e5c69cddd3a8dc7b08709e5af70585e5deb6c5929c400874554f6f5975e17275','Student','Olaleye Matthew Seun','','HND1','SWD'),
(128,'21/85/0066','scrypt:32768:8:1$3uuCs9Bcmiky0kAn$17138a60ff7a6d719544f8ac5587bfcd47ee37f0f910525a6d9ce3d3a8940d18803eb8f039976de5dadb3043fa09d08e13a6c68e5400294a699bddc1fd554cbd','Student','Olatunji Wuraola Funmilayo','','HND1','SWD'),
(129,'21/85/0076','scrypt:32768:8:1$lhhTGFHbAIhnZoh9$58b884b74130494bce9961bd6d0ce728907968886cfe9ebe5c5e607fd2385c19bc842fc0eddd35006e6ad98536d80c85f228343bc9187498a97299a251b902ab','Student','Raji Abdulwahab Ayomide','','HND1','SWD'),
(130,'21/85/0077','scrypt:32768:8:1$sTXGCQjuYGQ9rKO7$b1ebd505a7f75a9ce4a49100579143990abff1f2ad5897b20c2c1a24d02eb2104510d584498469eb8bdcbe69bed9722b1fb70be5b59cb4c17c6b34b9c0e71370','Student','Omigbire Imisioluwanimi Adediwura','','HND1','SWD'),
(131,'21/85/0086','scrypt:32768:8:1$zsQEWnh8LtM0Hi8J$80e00dc0d761eaf091dfa85d36a9a65faa031e436c75c402b11fe2170f1de677df61fc291ed129bae2873fc977642b1a3a518c198f51454d18872cb378a4c34d','Student','Umeocha Joy Chidinma','','HND1','SWD'),
(132,'21/85/0095','scrypt:32768:8:1$SlXMdasq77HRx2k2$c4011adbc14a37209bb3d8214f3cb5c1275c4720497ba4370d8074c431a0cf3779680fda5a9380e87aa066d60f5a5f3436b7be87846d4d13b29efa05d4cfb09c','Student','Joseph Oluwasegun Olumide','','HND1','SWD'),
(133,'21/69/0056','scrypt:32768:8:1$YAkbh6l2GQyb8Uht$d0f5080acebced62530da77b2e28adef08e567986daa84fb9286f923a04cf0e075054f3a79b7c59e300653fed57bd8bbee2083d26653ded0a8706fb2429f3a28','Student','Mustapha Habeeb Oluwatosin','','HND1','SWD'),
(134,'21/69/0074','scrypt:32768:8:1$zOuK3YAr2bHTd6WT$fd96727ac2e2317d2f27236ba93aa79bf73784aa7dd4654e29dc41a39b2fcb0499df6c7b99f372537f4d92517024af24ac627f4af9131f1b29322e27f9d31efd','Student','Anifowose Emmanuel Iyanuoluwa','','HND1','SWD'),
(135,'24/347/0003','scrypt:32768:8:1$K7uDjsxpU6lqZr20$1b1a09cb48e9ccc785a55e78fe227255c55aef437d8ccb3bf97978383dccf7532501e5c51bb74d0fee7fd8f749da41a406352d78484fc358aad7da5e35352d63','Student','Ayoola Oluwabukola Oluwafisayo','','HND1','SWD'),
(136,'19/69/0123','scrypt:32768:8:1$jNi1b90I9PoTHm3L$4ec24cc0f9d196396bc6dc828f8f823a22fe2050ce2f88cbc6f0a509a6066a0981c677fc9f2cd919ef07f2370613fd404cf3f8750959d790903b6e756a3ecd4e','Student','Oyeneye Samuel Oluwafemi','','HND1','SWD'),
(137,'20/69/0072','scrypt:32768:8:1$j3l4EFxghz1t2G6k$87bdb977e389dcbf7b9bb0191482fc7ceed3a23a02e51e1d34aa5121a28aef7116752302d8c99850935a13957a82ba3d659a2ba0da519b098544ffa528fc3d77','Student','Ojotijani Sultan Akorede','','HND1','SWD'),
(138,'20/69/0066','scrypt:32768:8:1$FQKNo91RakCa5Gya$923b52f425e4e2d560367608eaba351e433d9c0687fdaf592174b962ce15c8d8286fde3169d7addd2828b039d639ded550e0508696556b72b696c0e478cb56d3','Student','Oyedunmola Olajumoke Adeola','','HND1','SWD'),
(139,'19/69/0350','scrypt:32768:8:1$QQ3GtDHg5TZCTtmC$6b4de603ad156adc2ac1c208f515f6cfdb09d1b8ca07fab5efa5df4c7430ff71c8c7a43a0333cc204129f98b9b68c9d7ff845c93bab39915b1ce51f273307c06','Student','Osunniyi Tawakalitu Olaitan','','HND1','SWD'),
(140,'24/347/0008','scrypt:32768:8:1$jKzDpZ3hKhYqS1gL$aff176de5de08b5161ab91b6256c85d43217226f09d8793d461621f49c98538f5eefdc1407c42cc3c2c9a87dd4256f3120925503360f27acc4d4b5abd6ede046','Student','Awosanya Zainab Ololade','','HND1','SWD'),
(141,'24/347/0017','scrypt:32768:8:1$QNx1z5uvqoPWXyj6$7635b3557f319a798e0c10183e10ff2a84fd31c3a080d4c0012858f1ab362bce1e86529c7f9616ac60166784ab75c8ec76fa10586e147af2c832cdbbe5c59c24','Student','Oreh Monday Hagbolarhan','','HND1','SWD'),
(142,'24/347/0012','scrypt:32768:8:1$D8O69XRbO9k2JoDq$18a02f6c9aee68681dd084d931e97862f841e3f45161271979c859a5ef98327f0343aacf32024e6a3512a985af860f99b06e0ad9a34c3f4b0d4239154aca6b0d','Student','Adeyanju Marvelous Boluwatife','','HND1','SWD'),
(143,'24/347/0011','scrypt:32768:8:1$JMqM34EDsnKn9f5x$a83aa82740a7409c906e4ec50ff7f7fede425cd70a9174bf4402bc795d3ecf6ed3251c38fcbce51942df501bec9e992394ed8c8d362abb44f3acbf9dd8f15be1','Student','Sunday Paul Taiye','','HND1','SWD'),
(144,'20/85/0186','scrypt:32768:8:1$lvEOLrur38K7dRJG$0ce5f9519ea4e43b397627059ce1c1f4183423874b5746d78751c6c6cea86f7d8b93e07b2c1a64ab90e16b2a44b9b4f7da03d618bc721391552b0f1f3b092ef3','Student','Fayomi Odunayo Felix','','HND1','SWD'),
(145,'24/347/0013','scrypt:32768:8:1$0cumALvA03fDvDqq$2eb2b35de46ff5b17052c5c92ad9d92f54ef318ee86252660d01cef35b732b725053a0e07a566fa1cb5d9d3bc53607d8c6163359ba7665973a211f238217f38f','Student','Olujimi Michael Olawale','','HND1','SWD'),
(146,'24/347/0015','scrypt:32768:8:1$PpsnPUOO3N1iTYGB$e6b3559b6e7832f8e703541a3af8943bbc566395edb34f4ded33f0f151d59b84b254c326e872c5d9c1b4d7f2785f25d21d765cb1cea8bd439ad01acb00c81a2a','Student','Ganiu Shukurat Olamide','','HND1','SWD'),
(147,'24/347/0014','scrypt:32768:8:1$oNqfTi0FeRPUqSHQ$3ed530f8e0e3dc120e0b3d999b9cc61fc13a3be867a3a052add10701382fbe26d3129f1f80aff4c0bcf89035569b3e6100cefe601600b141fdbd0db40791480d','Student','Akinmusira Olatunkanmi Olamide','','HND1','SWD'),
(148,'20/85/0180','scrypt:32768:8:1$Mhrflfuf2pM1H66b$915cb9149501ba55f34b6980217f06824061ca98ee405fa5dda92dcbaf762cdd15e4548334bd48e8f9ba57ea4a6f2af864aa6dc75b815ada9f209437792a582d','Student','Olorunfemi Dorcas Omowunmi','','HND1','SWD'),
(149,'24/347/0020','scrypt:32768:8:1$Cu5PCwvWeud0j8KL$0ca125de106900870d71cc1afb0241a69eaef90240a62130fcbab416a3a915e94ad4f2ff4b7af4cb40c924d077a44627fb0ccacee650bbcd963e7fc03114706a','Student','Olatunji Isaiah Temitope','','HND1','SWD'),
(150,'24/347/0022','scrypt:32768:8:1$cEG4kEGWuiAHKpUi$06ac57c69715a42355a295a4a03d6f77eed9226ab0f602f7ea1bf9264146790abc1f7b5c32def444210ed79de5f6eeb058aeaddd182b7740da9c202258a9ed21','Student','Agoro Muniru Adeleke','','HND1','SWD'),
(151,'20/85/0026','scrypt:32768:8:1$6P0hdvHnVxj0bsxq$5005c1e484fdc49d0addda22d3924547a4c423e0a81ad3cf82ecdce76ff5705cd91c47ae540e9db1ea70f024b374638efb8d258a08e45218d752b828fb00fc9a','Student','Agbaje Suliyat Morenikeji','','HND1','SWD'),
(152,'20/85/0138','scrypt:32768:8:1$F1ZxrBEdJlyuU80h$8b5d152ff040cd39ba2b9474fe9891b5c339e1f61fa7f008ce293e677bbf06bb9224d5838dd4d34e51d2121d354584333194a4d71d42cebab3eaf18b15ce83ba','Student','Ekeledo Blessing Chidinma','','HND1','SWD'),
(153,'20/85/0130','scrypt:32768:8:1$cHhZKpmL5V3yli5z$2d4d3fcccf571c6a5586771ea4449a09e69f74189daaa4959bccef4fb4f0fa73302befae3f7b1a107fcc75230cc3e86fe76267cca6e2aa1e6f6ff7cfeb5823af','Student','Taiwo Oluwabukola Mary','','HND1','SWD'),
(154,'24/347/0026','scrypt:32768:8:1$VX8owFh037l8KLNV$bc68143d0e5bb5f507ce898f92663f97b43bc20259c43b598bc2bb7d6dd059a14a61cbe525e0d818f65c3b71c45242210b4408339ee403fcfb86e2d89357cec6','Student','Yusuff Damilare Folorunsho','','HND1','SWD'),
(155,'15/69/0262','scrypt:32768:8:1$0FKNFh4p3xsBzef2$3c1d72132dd011b2cb11a0db28b626dbef2cba5523793d5a0edafaea064ef44e8569c05bdac25b1bed328aacd12bd288a4f96f5e1d808684ae4174903b7f486f','Student','Onwuyali Gabriel Emeka','','HND1','SWD'),
(156,'24/347/0030','scrypt:32768:8:1$hZNij62slJuU5hf4$af43eebedcb7aab9c09b25335f9ff87bb01b387a976bad19ab9455dcbfdf1a84b392c959207e72db14b0c66898b6431b5225ed8cae3b7e05a7badd97315b7356','Student','Alabi Ayomide Emmanuel','','HND1','SWD'),
(157,'20/85/0064','scrypt:32768:8:1$HQBNkXozCwxpyZWI$73182a79ba5fda5d13be689e330ddeaf6df2d3a57a5cf95071eb3ff55214eaa7b2c764b057840c5cde61fa78a8f3773b2a3dbe5219d0225342ac5d158ef98af9','Student','Garuba Muyideen Oluwadamilare','','HND1','SWD'),
(158,'20/85/0041','scrypt:32768:8:1$13JTMbgvjBKmk1R8$f9ac1fb3e8def9c72512b5d08150f3301f2fd793c942a039d7136ef614e9b7a546dbed2a075cfa64c19a617a11b41358b101897dc586e832c09354d3ba06b1c6','Student','Obasan Mathew Olumide','','HND1','SWD'),
(159,'24/347/0034','scrypt:32768:8:1$XivlZ3wLxRa1vPEY$4cbf202abbd6c92fcc282d249d34f4a1564017ae5244488b818698004d154ea689c77cb0721067a1a411ad2a2ded32a2595ae8e5b646ecad5ace4671c58e00d9','Student','Oyelowo Ronke Khodijat','','HND1','SWD'),
(160,'20/85/0128','scrypt:32768:8:1$DLYk8GlfqVct0oT9$98066c2e9abdcb637193374348c73634fa23c6f6d5c16a68e1944ddc421ff1f041f15aee07aed180157a62c83145d9ed5b8d2ec3f23f5ec38a24d0ed46389485','Student','Adesoji Boluwatife Johnson','','HND1','SWD'),
(161,'20/69/0037','scrypt:32768:8:1$QUXA5pAsBSvgFnEf$2eebe158d20bef8fd9c80fe4be653f0dd366a7731a9cdf13e30d3763d0cd3464a4a58fddbbac61de68d1a5801fac846c45edc8528c0203e63002020f000eb180','Student','Idowu Timileyin Pelumi','','HND1','SWD'),
(162,'19/69/0129','scrypt:32768:8:1$tErXhs79fTJWy37e$0e05999e16ecd4133e061b0b2c418362f30d3df05dfb5cb06d682b4df40b442c84b8173366874418c09d41e283b7864df573d1afbed6e70d57807ea487eb4d82','Student','Durojaye Taiwo Kayode','','HND1','SWD'),
(163,'19/69/0061','scrypt:32768:8:1$q1sAfZzq3SsDNJ61$8c67d9791839a223008fe8b6c744c3b45958452c5605a508584f5c5f5003c1ffc225048a08a8d7a3a88285032b9ea933588989849ebf68deb30654f25f5c20d7','Student','Bello Hayatullahi Oluwatosin','','HND1','SWD'),
(164,'24/347/0050','scrypt:32768:8:1$7G8Rdk9hLwYKA51g$fcb83515878eeae6231b897206ce731c3cd6ddd5eb3c1b3fcc9f3ddcdf3f3d2d7b7b42142f5022c9f42e6161336862b316ae0227d9be9a960fa00237ac835532','Student','Omomila Sunday Ikpemhinogena','','HND1','SWD'),
(165,'19/69/0294','scrypt:32768:8:1$PsBrnRhRMnUq4gkf$8664b0d1fa331ea7eeaf0b4dfcef3bd1fc991692e5206e62a0991ace88d15f62cea64d0a87581e8f1e73218b364c613c66c91a30bafc446130b783bad7edfbc5','Student','Oladele Julius Oluwabusayo','','HND1','SWD'),
(166,'24/347/0039','scrypt:32768:8:1$YrcofppIiCaesfig$d42bfa76dd7d195cd6bc7de4bd193a4eb05eb9c3cf672b215e080700dcdda74283ea18642f8c713b58e0a9abb668538c4912e8200d76450c7dc83485fa950912','Student','Balogun Memunat Ololade','','HND1','SWD'),
(167,'24/347/0045','scrypt:32768:8:1$pBjMxBVSzBscu8j5$6393f4c8a966f15c947714368e7f6ae7756b0ed1ead6b8f09cf94dde788ae217be0b3cd5e7320f30104c173b64330b5dbb6e6e0fcaa33a70a34d00b4994633eb','Student','Obadina Al-Ameen Adedeji','','HND1','SWD'),
(168,'20/85/0101','scrypt:32768:8:1$CQi9fDhUncUogWs3$ceffce44d42ccf8b3b975b742f416345626830b0329e771f331c4c1f51e83f1965b737149a66883e8a1c59eac9f5006d8cdf7fd6435373f1d6265dacaf01255a','Student','Abu Azeez Olamilekan','','HND1','SWD'),
(169,'24/347/0049','scrypt:32768:8:1$7NQZTGjrBaET9d2X$3e2eba3528c5eabc07577e16bab4afc5c14bf7563351047758543161f8fb427b5957ea25f74a66f84f913958c22e0e0bf03184307e33f297455603233496bc0d','Student','Ajayi Christianah Omoyeni','','HND1','SWD'),
(170,'24/347/0052','scrypt:32768:8:1$01ZQsYqBKjlnFF5G$5c25047644962a6784407ea095520b8f9cd4a6f25d3d18c41a73fa0233d23d5355ac8084ea20bc3cc26b6b559b4db5784de97da9203dc2c847d0caac2e5a887f','Student','Shodunke Alimot Opeyemi','','HND1','SWD'),
(171,'20/69/0057','scrypt:32768:8:1$AeUc9jG3154YSNMY$0eb463853b39af70bb603c1eeb70529838ea82da0ee12707c62b155c6b24349a40ddcb69aaa18d7569ba6f2c85d02570fb419776bc56ec617692006449327583','Student','Hassan Ibrahim Oluwabusayo','','HND1','SWD'),
(172,'20/85/0109','scrypt:32768:8:1$0UyXeFrn0vqhN8z0$337154f1d30eea8bea350dc593aa4521931f03ff8d87d817caae8e3ac77376065f7a0ae95ab7a03bf1a75439908851d83d21ed7d32cf81f6dca3febf403ef371','Student','Ebelamu Olamilekan Opeyemi','','HND1','SWD'),
(173,'24/347/0086','scrypt:32768:8:1$LfjySOwj5RRmaEHn$a5fef9fbfe55cb29948a5c91dd8c2bfdb97f43a75faacc71fd4bd6aef3c6d5d1e776ed435f4094752fc15eac6b2af0d96962a8dba65380ec0057a8b7863e4e71','Student','Gbetoho Jonah Sunday','','HND1','SWD'),
(174,'20/69/0030','scrypt:32768:8:1$IMrJj4fdi06X4DYt$f6bdc5209d5b1c5a880ea1915a4805a204eeb4294d2ee69393b8d2df106278b5a7dba753222ecb21734af0cecc5eb969e79c88efb11ca49cf7128a8abb0ccdad','Student','George Rapheal Olamilekan','','HND1','SWD'),
(175,'24/347/0106','scrypt:32768:8:1$wqmtAgq8FhyqMhYP$20f5e4776b533bc070dd1128235d7aa84be7dc71e5b7f7dfe69be45c210b94453139ab380c809298654d1452c4785d9d8062f71ad874883a56f831d9a4ff194f','Student','Nuberu Faithia Temiloluwa','','HND1','SWD'),
(176,'24/347/0080','scrypt:32768:8:1$0bqa2dqZBg5wwZ5Y$3c92f41516fb61ed8768722a6bea3e51dd12db00fefb49d2cca5b01af06bc252112eb75949fc319b96c5f21413717c1bda427d6d5cba2974eb9c1ffc02e40754','Student','Paul Comfort Idongesit','','HND1','SWD'),
(177,'24/347/0105','scrypt:32768:8:1$Z4tfRh8jMRAncxd1$687ed822cdf1e01f72235209e327f3191597e952997ef7204edffd66605a3244d6cae379eb24ec38ca12fd2ac912f967a827812d87cfc7ddae2917db28e5ee3a','Student','Ailenbuade Emmanuel Eseose','','HND1','SWD'),
(178,'24/347/0087','scrypt:32768:8:1$oBDXm9O7ivof7Rip$89c44447c4e12b399ff40c3813dcee525b77ee274344ff29761dba141de95cebf216af13b800b1b571b25c424437e1f02043ad696c99cf09ab97ad07ce27ed18','Student','Bakare Hakeem Olayiwola','','HND1','SWD'),
(179,'24/347/0109','scrypt:32768:8:1$4Vl5BBSGEXClmaKt$8c31de10a62ff75d66b69f1957cf3fdeb745461df5f2e6389e6e144447ced0e9090a666af0cd291d69c67ef731c81c2967a7cbea185d1f19fcb78482d618d8c5','Student','Lawal Sulaimon Olamilekan','','HND1','SWD'),
(180,'20/85/0148','scrypt:32768:8:1$roouTJtP1QRM6Ziv$370c1c9aae2446bdbccc28d8ef23f3b9197f472af6cf098e7ceb558eddf6134684a65cfaf04cb48fe0238846bd79af42bcd6a7a6ac157d1dfe2a65bb200a8ac8','Student','Balogun Deborah Iyabo','','HND1','SWD'),
(181,'20/85/0019','scrypt:32768:8:1$r4HTfbOlWt8ZOeSe$c299bd3b058bcc576a9866817c574e7e09520d0be29d31fdc9d6ebc2ff759d52fb137c96e3cd2bec7b558059187a156942ddc7e83d4cdebe74188c321e30d1ff','Student','Folawole Olasubomi Oreoluwa','','HND1','SWD'),
(182,'24/347/0088','scrypt:32768:8:1$ZfRudX1VvdTFquvC$a885548051575a87098fb49ad52d20897a67703b9fe4a598bcbb4c8bd915a0457c323c125d1c3b8017d50429eb8ef7d7598eee69869d7f936dca8f02cddc0aca','Student','Isikalu Olajide Richard','','HND1','SWD'),
(183,'20/85/0018','scrypt:32768:8:1$lnMY7XQuKYbE8KQJ$8cac6f71ace9ae3c86ef5a7c2003f72a66d60a16c18e1f6d32b3900cef6eb2559057cb42abb0ac68ebd64e54078d137d9002fada45db2685c3ee04af00b9d153','Student','Popoola Quadri Olashina','','HND1','SWD'),
(184,'20/85/0181','scrypt:32768:8:1$zu3KxOl1LAmwLxua$3af5987bc9b23c73943cb327c8e325603d6ca4a3df0321b33b85bb2341a0bd7c04d34748804a5ba7985f2a3c7d6e9c56b779aeb08d279d8c6ebbcce641d48d49','Student','Odugbemi Benjamin Kolawole','','HND1','SWD'),
(185,'20/85/0077','scrypt:32768:8:1$bvy9F5nxXQExmI8J$56413e8ee2c506d6e2cd36acf672dd92a88c77e0e13092229b3a0fb6f9dd82928e490248239ea51dafc34364f6bc0bf25b21da40244dcf4e442c95f23e190784','Student','Ajibode Musa Ajani','','HND1','SWD'),
(186,'24/347/0071','scrypt:32768:8:1$0L3FIapLmWVf4UBk$13306aa27a6bcc68fafc32981182b5b4939e3690169af932363611978ea54b0b81a3c795438a7687bf3f31e95b6cfa2ac339039c968fbaba4052ea7ddacab145','Student','Jolaosho Mary Arinola','','HND1','SWD'),
(187,'24/347/0084','scrypt:32768:8:1$eS8v7sdENcaQjUfG$7dd5b51edbea0ee205d614c124058ba4362f09e9bc4a06d90a850db8c6fb6f02da1fb619d613aa9cefccae2c2b789b4e73eae647238f95a4fa48b5196466acb0','Student','Ogunlade Olumide Ayuba','','HND1','SWD'),
(188,'20/69/0031','scrypt:32768:8:1$EVssuEWEtgSeQQ4Z$e067ebb204a2e75e4ceef8d8189a082235a376b0e09adb772a5cae95befe06a92705c94ed2d08eab822e4bce82e2620f11bcf3ebf3277107e40677975d0e0431','Student','Ajibade Nurudeen Adeyemi','','HND1','SWD'),
(189,'20/85/0189','scrypt:32768:8:1$YCh12OwnEPLSLHcv$194ecd6d2c95a0b307e1a3b761ed85a69a01a335d123fdce3585c43843f1701892b339ab96d523c90a4dda5b1f9836f4983d05d0ccd29b65ddaa46b9ec84e40b','Student','Afere Ayomide John','','HND1','SWD'),
(190,'15/71/0144','scrypt:32768:8:1$JnncWioZU6hcZZL0$e276c26466515efd06fdc45ab8e7ae94570599adabdc1ed8f14504aada28d4259efa3595f89ac3e4d2ea57f363cbe1ff409d69ee808906ebfe2205f893e21a96','Student','Amuda Kafayat Titilope','','HND1','SWD'),
(191,'20/85/0121','scrypt:32768:8:1$6uSUqBpjd5p1IqSw$561045e1372aed6d9da7aa1fb8c80b9bfa94274da4f57be7fa28d04867754b97aff9f902657f93a2a47ba3595aa4afbf3ffe71eb03be63c07b4605ebe9b99c9e','Student','Balogun Oladipupo Hameed','','HND1','SWD'),
(192,'24/347/0001','scrypt:32768:8:1$l2y7xRWZjmC8vu79$eac26ece8bf657ff6a6b8b4294fcbbaf799e050442fe7f3a5f263c0d065cd11bf082042e344933bf9ac0cece46272955ef00af707fc1e3d42a76128e30c269b5','Student','Ajibode Aminat Oluwakemisola','','HND1','SWD'),
(193,'24/347/0085','scrypt:32768:8:1$fHkLxRfUICyO13VC$f01773a41843135ac5fc1fef3c01ec8b8a87ce9c1e39df21826e1185c74d998f69b7f32b8cbc84e12700e16907f64a7ad7aac6ec2cdd0a6e7f56166c60550228','Student','Ajewole Gbolahan Opeyemi','','HND1','SWD'),
(194,'20/85/0168','scrypt:32768:8:1$mzVKnaeMXv1JPwvQ$752476f09630685b1e3ae2a020b7a4ebaac975ab0514d1b8653f435306d85829a8907d47b5d10093254eb88245a2d5cabca91b5893ef9b87ed2f58081206ab4b','Student','Sanyaolu John Oluwatobiloba','','HND1','SWD'),
(195,'19/69/0255','scrypt:32768:8:1$51UIZSwpf4h3705O$79f31bcbfe4cf99711ebb2889e93f4c1fd8b6939a565f32526fcd9c2d3a8397d0b9b09382d34fc89b939f00a69f80b2d8f4cc8f6bbfc0101fd7ccc02efa8b685','Student','Chilaka Micheal Ovie','','HND1','SWD'),
(196,'19/69/0226','scrypt:32768:8:1$TY7q2JJ1Oe7jVWkd$7548ae4ab83cfdec8b21c6459c87e104e4891c70db730d7195ed9c77e37ed476ebbb131867eab5d181b05975f4578e38c9f0daffb1bcbb538f5ab191007a6c78','Student','Bashorun Roqeeb Funsho','','HND1','SWD'),
(197,'24/347/0076','scrypt:32768:8:1$3D11VRVCXeMMMOfg$077dfee312fd941e3fa67d554a63d90d7450b2ce18be7277b1c75ccb26d6af7df33698aa51ab751464c5f0fdb3d7d16fed9a81fd1b48426f9b8415e6cc4aeca7','Student','Adeoye Zaynab Oluwatobiloba','','HND1','SWD'),
(198,'24/347/0100','scrypt:32768:8:1$oYKOFewsavSW63Y1$8e07a827c22c244574a090107a569ffc2b8773e6d29fb874e78c7c0065b7400195bc17b257df014f40680401324f64565888335d91b84b19814544220aa91308','Student','Agbaje Jamiu Kayode','','HND1','SWD'),
(199,'24/347/0082','scrypt:32768:8:1$LrvPWj4k5dweTwv9$b3246f03225094b4ef366827cf6eee2d2e4f8a1e0430fd400dc3f48675e2c724e10f584cda078b8cc6f3fed96fabebc845abdf856daa69c205db696c50f65c63','Student','Ibiloye Oluwatimileyin Isreal','','HND1','SWD'),
(200,'24/347/0091','scrypt:32768:8:1$6KvjMjFj87OYTIBW$fcd7599930992666793ca4d0de6bdcf16d3a817486e9eaf81c11f0a09c5bdabafd00b1fb6379f104ebd5171a0827dd2c92e0f053525944e4e184e6efae753a92','Student','Olugbade Ifeoluwa Samson','','HND1','SWD'),
(201,'24/347/0092','scrypt:32768:8:1$QQXIDYitnHYpWKX3$acc94b5d10fa1188569d699cd2129147ba699bd0d709152d8e1e210ae5d46bad31fd1c5cee1f8e31d790f7c8315adc090244f37fb93cf6c6e224a6ae6db23c99','Student','Odeh Christopher Friday','','HND1','SWD'),
(202,'24/347/0096','scrypt:32768:8:1$lFBv90rcVouYDF6x$2c208a91fca8a22b5a64bd65f1b7c14a6fa3ad571a3dd1ec1254c69e10c9abe65ce79fc65e0d3bc5d2fc0e1079334fe7ff0ee3762e4385dabee0f644aee4d05b','Student','Ajayi Oluwayomi Rotimi','','HND1','SWD'),
(203,'24/347/0111','scrypt:32768:8:1$Gm88olDdgoYYSXQs$8e4a577ba9215060e7dd60320c5341d631f330a4f6625e1b9a10102789095dd9d7493af1ef05bf3d16e5e1707bc5b4b383a23383ba555771a1a205756920538c','Student','Taiwo Titilayo Abisola','','HND1','SWD'),
(204,'20/85/0054','scrypt:32768:8:1$OWtQj44Jqx8IVRAu$f5466663a19fb616a68aebac11e202a20f99a9df3f3cb7a8a544d0778ec67385646e3b22ec397c8ae7bc55fde3f1dd4d8a501f68d5408a458af85699b6d21a9f','Student','Alaye Oluwarotimi Ayobami','','HND1','SWD'),
(205,'20/85/0055','scrypt:32768:8:1$Ct48TNlVwK6dsGUW$7e6c41d95243b37c77598ed83cc8da03dd4d4e08df71eac6c32bf017801b6cb607973ddeca8d9e19b90895044e38fce9e4db7d61b62c0caf08d3eb685d38d7c5','Student','Oyelowo Ronke Khodijat','','HND1','SWD');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `venues`
--

DROP TABLE IF EXISTS `venues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `venues` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `venue_type` enum('Lecture Room','Lab') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `venues`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `venues` WRITE;
/*!40000 ALTER TABLE `venues` DISABLE KEYS */;
INSERT INTO `venues` VALUES
(1,'COM RM 2','Lecture Room'),
(2,'ICT RM 7','Lecture Room'),
(3,'ICT RM 8','Lecture Room'),
(4,'SCI COM RM 1A','Lecture Room'),
(5,'LAB 10','Lab'),
(6,'LAB 11','Lab'),
(7,'LAB 12','Lab');
/*!40000 ALTER TABLE `venues` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2026-09-10 10:07:59
