-- MySQL dump 10.13  Distrib 8.0.32, for Linux (x86_64)
--
-- Host: localhost    Database: clubhub
-- ------------------------------------------------------
-- Server version	8.0.32-0ubuntu0.22.04.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `clubhub`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `clubhub` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `clubhub`;

--
-- Table structure for table `club_interests`
--

DROP TABLE IF EXISTS `club_interests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `club_interests` (
  `club_interest_id` int NOT NULL AUTO_INCREMENT,
  `club_id` int NOT NULL,
  `interest_id` int NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`club_interest_id`),
  KEY `club_id` (`club_id`),
  KEY `interest_id` (`interest_id`),
  CONSTRAINT `club_interests_ibfk_1` FOREIGN KEY (`club_id`) REFERENCES `clubs` (`club_id`),
  CONSTRAINT `club_interests_ibfk_2` FOREIGN KEY (`interest_id`) REFERENCES `interests` (`interest_id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `club_interests`
--

LOCK TABLES `club_interests` WRITE;
/*!40000 ALTER TABLE `club_interests` DISABLE KEYS */;
INSERT INTO `club_interests` VALUES (1,1,1,'2023-05-30 04:42:43'),(2,1,11,'2023-05-30 04:42:43'),(3,1,12,'2023-05-30 04:42:43'),(4,1,1,'2023-05-30 04:42:43'),(5,1,3,'2023-05-30 04:42:43'),(6,2,2,'2023-05-30 04:42:43'),(7,2,1,'2023-05-30 04:42:43'),(8,2,11,'2023-05-30 04:42:43'),(9,2,1,'2023-05-30 04:42:43'),(10,2,3,'2023-05-30 04:42:43'),(11,3,2,'2023-05-30 04:42:43'),(12,3,4,'2023-05-30 04:42:43'),(13,3,13,'2023-05-30 04:42:43'),(14,3,14,'2023-05-30 04:42:43'),(15,3,15,'2023-05-30 04:42:43'),(16,4,2,'2023-05-30 04:42:43'),(17,4,4,'2023-05-30 04:42:43'),(18,4,25,'2023-05-30 04:42:43'),(19,4,26,'2023-05-30 04:42:43'),(20,5,2,'2023-05-30 04:42:43'),(21,5,4,'2023-05-30 04:42:43'),(22,5,27,'2023-05-30 04:42:43'),(23,5,28,'2023-05-30 04:42:43'),(24,5,29,'2023-05-30 04:42:43'),(25,6,6,'2023-05-30 04:42:43'),(26,6,16,'2023-05-30 04:42:43'),(27,6,30,'2023-05-30 04:42:43'),(28,6,31,'2023-05-30 04:42:43'),(29,7,7,'2023-05-30 04:42:43'),(30,7,4,'2023-05-30 04:42:43'),(31,7,32,'2023-05-30 04:42:43'),(32,7,33,'2023-05-30 04:42:43'),(33,8,8,'2023-05-30 04:42:43'),(34,8,17,'2023-05-30 04:42:43'),(35,8,34,'2023-05-30 04:42:43'),(36,8,35,'2023-05-30 04:42:43'),(37,8,35,'2023-05-30 04:42:43'),(38,9,9,'2023-05-30 04:42:43'),(39,9,18,'2023-05-30 04:42:43'),(40,9,28,'2023-05-30 04:42:43'),(41,9,29,'2023-05-30 04:42:43'),(42,10,31,'2023-05-30 04:42:43'),(43,10,32,'2023-05-30 04:42:43'),(44,10,33,'2023-05-30 04:42:43'),(45,10,34,'2023-05-30 04:42:43'),(46,10,35,'2023-05-30 04:42:43');
/*!40000 ALTER TABLE `club_interests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `club_updates`
--

DROP TABLE IF EXISTS `club_updates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `club_updates` (
  `update_id` int NOT NULL,
  `club_id` int DEFAULT NULL,
  `update_title` varchar(255) DEFAULT NULL,
  `update_content` varchar(255) DEFAULT NULL,
  `update_date` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`update_id`),
  KEY `club_id` (`club_id`),
  CONSTRAINT `club_updates_ibfk_1` FOREIGN KEY (`club_id`) REFERENCES `clubs` (`club_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `club_updates`
--

LOCK TABLES `club_updates` WRITE;
/*!40000 ALTER TABLE `club_updates` DISABLE KEYS */;
INSERT INTO `club_updates` VALUES (1,1,'Upcoming Tournament','We are organizing a sports tournament next month. Register now!','2023-05-20 09:00:00','2023-05-19 15:30:00'),(2,1,'New Training Schedule','Check out our updated training schedule for the upcoming season.','2023-05-21 13:30:00','2023-05-20 11:45:00'),(3,2,'Basketball Tryouts','Join our basketball tryouts and showcase your skills!','2023-05-22 10:00:00','2023-05-21 14:15:00'),(4,2,'Game Schedule Change','Please note the updated schedule for the upcoming basketball games.','2023-05-23 15:30:00','2023-05-22 13:45:00'),(5,3,'Art Exhibition','Visit our art exhibition featuring the works of local artists.','2023-05-24 11:00:00','2023-05-23 16:30:00'),(6,3,'Workshop Announcement','Join our upcoming art workshop and learn new techniques.','2023-05-25 14:30:00','2023-05-24 12:45:00'),(7,4,'Music Concert','Experience a mesmerizing music concert by our talented musicians.','2023-05-26 17:00:00','2023-05-25 15:15:00'),(8,4,'Instrumental Classes','Enroll in our instrumental classes and enhance your musical skills.','2023-05-27 10:30:00','2023-05-26 18:45:00'),(9,5,'Photography Workshop','Join our photography workshop and learn from industry experts.','2023-05-28 13:00:00','2023-05-27 11:30:00'),(10,5,'Photo Contest','Participate in our photo contest and showcase your photography skills.','2023-05-29 16:30:00','2023-05-28 14:45:00'),(11,6,'Chess Tournament','Compete in our chess tournament and prove your strategic prowess.','2023-05-30 09:00:00','2023-05-29 15:30:00'),(12,6,'Chess Club Meeting','Join us for our weekly chess club meeting to practice and discuss strategies.','2023-05-31 12:30:00','2023-05-30 10:45:00'),(13,7,'Dance Workshop','Enroll in our dance workshop and learn various dance styles.','2023-06-01 15:00:00','2023-05-31 13:15:00'),(14,7,'Performance Rehearsal','We have an upcoming performance. Attend the rehearsal sessions.','2023-06-02 18:30:00','2023-06-01 16:45:00'),(15,8,'Gaming Tournament','Participate in our gaming tournament and compete for exciting prizes.','2023-06-03 10:00:00','2023-06-02 14:30:00'),(16,8,'Game Night','Join us for a fun-filled game night with various gaming activities.','2023-06-04 13:30:00','2023-06-03 11:45:00'),(17,9,'Film Screening','Attend our film screening showcasing acclaimed movies from around the world.','2023-06-05 16:00:00','2023-06-04 12:15:00'),(18,9,'Filmmaking Workshop','Join our filmmaking workshop and learn the art of storytelling through films.','2023-06-06 09:30:00','2023-06-05 17:45:00'),(19,10,'Cooking Masterclass','Join our cooking masterclass and learn to prepare delicious dishes.','2023-06-07 12:00:00','2023-06-06 10:30:00'),(20,10,'Food Tasting Event','Experience a culinary journey with our food tasting event.','2023-06-08 15:30:00','2023-06-07 13:45:00');
/*!40000 ALTER TABLE `club_updates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clubs`
--

DROP TABLE IF EXISTS `clubs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clubs` (
  `club_id` int NOT NULL,
  `club_name` varchar(255) DEFAULT NULL,
  `club_logo` varchar(255) DEFAULT NULL,
  `club_banner` varchar(255) DEFAULT NULL,
  `club_description` text,
  `contact_information` varchar(255) DEFAULT NULL,
  `social_media_links` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`club_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clubs`
--

LOCK TABLES `clubs` WRITE;
/*!40000 ALTER TABLE `clubs` DISABLE KEYS */;
INSERT INTO `clubs` VALUES (1,'Sports Club','file-1685714001852.jpg','file-1685383082197.jpg','A club for sports enthusiasts','contact@sportsclub.com','@sportsclubofficial','2023-05-18 10:20:00'),(2,'Basketball Club','file-1685563465156.png','banner_basketball.png','A club for basketball lovers','contact@basketballclub.com','@basketballclubofficial','2023-05-19 14:45:00'),(3,'Art Club','file-1685467372688.png','banner_art.png','The Art Explorers Club is an enriching and inclusive community dedicated to fostering the creative spirit in members of all skill levels and interests. We embrace a diverse range of art forms, from traditional mediums like painting, drawing, and sculpture, to digital art, photography, and mixed media. In our club, every member has the opportunity to express their unique artistic perspectives and expand their horizons. We host a variety of engaging activities such as weekly art workshops, where beginners can learn the basics and experienced artists can refine their skills. These workshops cover a wide array of topics, such as color theory, perspective drawing, portraiture, and landscape painting. Members also have the chance to showcase their work in our monthly art exhibits. These events provide an opportunity for artists to receive constructive feedback, gain exposure, and draw inspiration from the creativity of others. Apart from practical activities, we invite guest speakers from the art industry to share insights about art history, contemporary trends, and career paths in the arts. These sessions provide a deeper understanding of the art world and can guide those interested in pursuing art professionally. The Art Explorers Club is more than just a place to create art—it\'s a space for members to connect with like-minded individuals, collaborate on artistic projects, and celebrate the power of creativity. Regardless of your artistic experience or style, if you have a passion for art, the Art Explorers Club welcomes you!','contact@artclub.com','@artclubofficial','2023-05-20 09:30:00'),(4,'Music Club','file-1685433623621.png','banner_music.png','A club for music lovers and musicians','contact@musicclub.com','@musicclubofficial','2023-05-21 11:15:00'),(5,'Photography Club','file-1685433572414.png','banner_photography.png','A club for photography enthusiasts','contact@photographyclub.com','@photographyclubofficial','2023-05-22 13:45:00'),(6,'Chess Club','file-1685434187440.png','banner_chess.png','A club for chess players and enthusiasts','contact@chessclub.com','@chessclubofficial','2023-05-23 16:20:00'),(7,'Dance Club','file-1685467583869.webp','banner_dance.png','A club for dance lovers and dancers','contact@danceclub.com','@danceclubofficial','2023-05-24 18:10:00'),(8,'Gaming Club','file-1685433744466.png','banner_gaming.png','A club for gamers and gaming enthusiasts','contact@gamingclub.com','@gamingclubofficial','2023-05-25 20:30:00'),(9,'Film Club','file-1685433805523.png','banner_film.png','A club for film enthusiasts and filmmakers','contact@filmclub.com','@filmclubofficial','2023-05-26 22:15:00'),(10,'Cooking Club','file-1685467420126.png','banner_cooking.png','A club for cooking enthusiasts and food lovers','contact@cookingclub.com','@cookingclubofficial','2023-05-27 09:45:00');
/*!40000 ALTER TABLE `clubs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_attendees`
--

DROP TABLE IF EXISTS `event_attendees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `event_attendees` (
  `event_attendee_id` int NOT NULL AUTO_INCREMENT,
  `event_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `rsvp_status` enum('Going','Not Going') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`event_attendee_id`),
  UNIQUE KEY `event_id` (`event_id`,`user_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `event_attendees_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`),
  CONSTRAINT `event_attendees_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=595 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_attendees`
--

LOCK TABLES `event_attendees` WRITE;
/*!40000 ALTER TABLE `event_attendees` DISABLE KEYS */;
INSERT INTO `event_attendees` VALUES (1,1,1,'Going','2023-06-02 15:50:10'),(2,1,2,'Going','2023-06-02 15:50:10'),(3,1,3,'Going','2023-06-02 15:50:10'),(4,1,4,'Going','2023-06-02 15:50:10'),(5,1,5,'Going','2023-06-02 15:50:10'),(6,1,6,'Going','2023-06-02 15:50:10'),(7,1,7,'Going','2023-06-02 15:50:10'),(8,1,8,'Going','2023-06-02 15:50:10'),(9,1,9,'Going','2023-06-02 15:50:10'),(10,1,10,'Going','2023-06-02 15:50:10'),(11,2,11,'Going','2023-06-02 15:50:10'),(12,2,12,'Going','2023-06-02 15:50:10'),(13,2,13,'Going','2023-06-02 15:50:10'),(14,2,14,'Going','2023-06-02 15:50:10'),(15,2,15,'Going','2023-06-02 15:50:10'),(16,2,16,'Going','2023-06-02 15:50:10'),(17,2,17,'Going','2023-06-02 15:50:10'),(18,2,18,'Going','2023-06-02 15:50:10'),(19,2,19,'Going','2023-06-02 15:50:10'),(20,2,20,'Going','2023-06-02 15:50:10'),(21,3,21,'Going','2023-06-02 15:50:10'),(22,3,22,'Going','2023-06-02 15:50:10'),(23,3,23,'Going','2023-06-02 15:50:10'),(24,3,24,'Going','2023-06-02 15:50:10'),(25,3,25,'Going','2023-06-02 15:50:10'),(26,3,26,'Going','2023-06-02 15:50:10'),(27,3,27,'Going','2023-06-02 15:50:10'),(28,3,28,'Going','2023-06-02 15:50:10'),(29,3,29,'Going','2023-06-02 15:50:10'),(30,3,30,'Going','2023-06-02 15:50:10'),(31,4,1,'Going','2023-06-02 15:50:10'),(32,4,2,'Going','2023-06-02 15:50:10'),(33,4,3,'Going','2023-06-02 15:50:10'),(34,4,4,'Going','2023-06-02 15:50:10'),(35,4,5,'Going','2023-06-02 15:50:10'),(36,4,6,'Going','2023-06-02 15:50:10'),(37,4,7,'Going','2023-06-02 15:50:10'),(38,4,8,'Going','2023-06-02 15:50:10'),(39,4,9,'Going','2023-06-02 15:50:10'),(40,4,10,'Going','2023-06-02 15:50:10'),(41,5,11,'Going','2023-06-02 15:50:10'),(42,5,12,'Going','2023-06-02 15:50:10'),(43,5,13,'Going','2023-06-02 15:50:10'),(44,5,14,'Going','2023-06-02 15:50:10'),(45,5,15,'Going','2023-06-02 15:50:10'),(46,5,16,'Going','2023-06-02 15:50:10'),(47,5,17,'Going','2023-06-02 15:50:10'),(48,5,18,'Going','2023-06-02 15:50:10'),(49,5,19,'Going','2023-06-02 15:50:10'),(50,5,20,'Going','2023-06-02 15:50:10'),(51,6,21,'Going','2023-06-02 15:50:10'),(52,6,22,'Going','2023-06-02 15:50:10'),(53,6,23,'Going','2023-06-02 15:50:10'),(54,6,24,'Going','2023-06-02 15:50:10'),(55,6,25,'Going','2023-06-02 15:50:10'),(56,6,26,'Going','2023-06-02 15:50:10'),(57,6,27,'Going','2023-06-02 15:50:10'),(58,6,28,'Going','2023-06-02 15:50:10'),(59,6,29,'Going','2023-06-02 15:50:10'),(60,6,30,'Going','2023-06-02 15:50:10'),(61,7,1,'Going','2023-06-02 15:50:10'),(62,7,2,'Going','2023-06-02 15:50:10'),(63,7,3,'Going','2023-06-02 15:50:10'),(64,7,4,'Going','2023-06-02 15:50:10'),(65,7,5,'Going','2023-06-02 15:50:10'),(66,7,6,'Going','2023-06-02 15:50:10'),(67,7,7,'Going','2023-06-02 15:50:10'),(68,7,8,'Going','2023-06-02 15:50:10'),(69,7,9,'Going','2023-06-02 15:50:10'),(70,7,10,'Going','2023-06-02 15:50:10'),(71,8,11,'Going','2023-06-02 15:50:10'),(72,8,12,'Going','2023-06-02 15:50:10'),(73,8,13,'Going','2023-06-02 15:50:10'),(74,8,14,'Going','2023-06-02 15:50:10'),(75,8,15,'Going','2023-06-02 15:50:10'),(76,8,16,'Going','2023-06-02 15:50:10'),(77,8,17,'Going','2023-06-02 15:50:10'),(78,8,18,'Going','2023-06-02 15:50:10'),(79,8,19,'Going','2023-06-02 15:50:10'),(80,8,20,'Going','2023-06-02 15:50:10'),(81,9,21,'Going','2023-06-02 15:50:10'),(82,9,22,'Going','2023-06-02 15:50:10'),(83,9,23,'Going','2023-06-02 15:50:10'),(84,9,24,'Going','2023-06-02 15:50:10'),(85,9,25,'Going','2023-06-02 15:50:10'),(86,9,26,'Going','2023-06-02 15:50:10'),(87,9,27,'Going','2023-06-02 15:50:10'),(88,9,28,'Going','2023-06-02 15:50:10'),(89,9,29,'Going','2023-06-02 15:50:10'),(90,9,30,'Going','2023-06-02 15:50:10'),(91,10,1,'Going','2023-06-02 15:50:10'),(92,10,2,'Going','2023-06-02 15:50:10'),(93,10,3,'Going','2023-06-02 15:50:10'),(94,10,4,'Going','2023-06-02 15:50:10'),(95,10,5,'Going','2023-06-02 15:50:10'),(96,10,6,'Going','2023-06-02 15:50:10'),(97,10,7,'Going','2023-06-02 15:50:10'),(98,10,8,'Going','2023-06-02 15:50:10'),(99,10,9,'Going','2023-06-02 15:50:10'),(100,10,10,'Going','2023-06-02 15:50:10'),(101,11,11,'Going','2023-06-02 15:50:10'),(102,11,12,'Going','2023-06-02 15:50:10'),(103,11,13,'Going','2023-06-02 15:50:10'),(104,11,14,'Going','2023-06-02 15:50:10'),(105,11,15,'Going','2023-06-02 15:50:10'),(106,11,16,'Going','2023-06-02 15:50:10'),(107,11,17,'Going','2023-06-02 15:50:10'),(108,11,18,'Going','2023-06-02 15:50:10'),(109,11,19,'Going','2023-06-02 15:50:10'),(110,11,20,'Going','2023-06-02 15:50:10'),(111,12,21,'Going','2023-06-02 15:50:10'),(112,12,22,'Going','2023-06-02 15:50:10'),(113,12,23,'Going','2023-06-02 15:50:10'),(114,12,24,'Going','2023-06-02 15:50:10'),(115,12,25,'Going','2023-06-02 15:50:10'),(116,12,26,'Going','2023-06-02 15:50:10'),(117,12,27,'Going','2023-06-02 15:50:10'),(118,12,28,'Going','2023-06-02 15:50:10'),(119,12,29,'Going','2023-06-02 15:50:10'),(120,12,30,'Going','2023-06-02 15:50:10'),(121,13,1,'Going','2023-06-02 15:50:10'),(122,13,2,'Going','2023-06-02 15:50:10'),(123,13,3,'Going','2023-06-02 15:50:10'),(124,13,4,'Going','2023-06-02 15:50:10'),(125,13,5,'Going','2023-06-02 15:50:10'),(126,13,6,'Going','2023-06-02 15:50:10'),(127,13,7,'Going','2023-06-02 15:50:10'),(128,13,8,'Going','2023-06-02 15:50:10'),(129,13,9,'Going','2023-06-02 15:50:10'),(130,13,10,'Going','2023-06-02 15:50:10'),(131,14,11,'Going','2023-06-02 15:50:10'),(132,14,12,'Not Going','2023-06-02 15:50:10'),(133,14,13,'Going','2023-06-02 15:50:10'),(134,14,14,'Going','2023-06-02 15:50:10'),(135,14,15,'Going','2023-06-02 15:50:10'),(136,14,16,'Going','2023-06-02 15:50:10'),(137,14,17,'Going','2023-06-02 15:50:10'),(138,14,18,'Going','2023-06-02 15:50:10'),(139,14,19,'Going','2023-06-02 15:50:10'),(140,14,20,'Going','2023-06-02 15:50:10'),(141,15,21,'Going','2023-06-02 15:50:10'),(142,15,22,'Going','2023-06-02 15:50:10'),(143,15,23,'Going','2023-06-02 15:50:10'),(144,15,24,'Going','2023-06-02 15:50:10'),(145,15,25,'Going','2023-06-02 15:50:10'),(146,15,26,'Going','2023-06-02 15:50:10'),(147,15,27,'Going','2023-06-02 15:50:10'),(148,15,28,'Going','2023-06-02 15:50:10'),(149,15,29,'Going','2023-06-02 15:50:10'),(150,15,30,'Going','2023-06-02 15:50:10'),(151,16,1,'Going','2023-06-02 15:50:10'),(152,16,2,'Going','2023-06-02 15:50:10'),(153,16,3,'Going','2023-06-02 15:50:10'),(154,16,4,'Going','2023-06-02 15:50:10'),(155,16,5,'Going','2023-06-02 15:50:10'),(156,16,6,'Going','2023-06-02 15:50:10'),(157,16,7,'Going','2023-06-02 15:50:10'),(158,16,8,'Going','2023-06-02 15:50:10'),(159,16,9,'Going','2023-06-02 15:50:10'),(160,16,10,'Going','2023-06-02 15:50:10'),(161,17,11,'Going','2023-06-02 15:50:10'),(162,17,12,'Going','2023-06-02 15:50:10'),(163,17,13,'Going','2023-06-02 15:50:10'),(164,17,14,'Going','2023-06-02 15:50:10'),(165,17,15,'Going','2023-06-02 15:50:10'),(166,17,16,'Going','2023-06-02 15:50:10'),(167,17,17,'Going','2023-06-02 15:50:10'),(168,17,18,'Going','2023-06-02 15:50:10'),(169,17,19,'Going','2023-06-02 15:50:10'),(170,17,20,'Going','2023-06-02 15:50:10'),(171,18,21,'Going','2023-06-02 15:50:10'),(172,18,22,'Going','2023-06-02 15:50:10'),(173,18,23,'Going','2023-06-02 15:50:10'),(174,18,24,'Going','2023-06-02 15:50:10'),(175,18,25,'Going','2023-06-02 15:50:10'),(176,18,26,'Going','2023-06-02 15:50:10'),(177,18,27,'Going','2023-06-02 15:50:10'),(178,18,28,'Going','2023-06-02 15:50:10'),(179,18,29,'Going','2023-06-02 15:50:10'),(180,18,30,'Going','2023-06-02 15:50:10'),(181,19,1,'Going','2023-06-02 15:50:10'),(182,19,2,'Going','2023-06-02 15:50:10'),(183,19,3,'Going','2023-06-02 15:50:10'),(184,19,4,'Going','2023-06-02 15:50:10'),(185,19,5,'Going','2023-06-02 15:50:10'),(186,19,6,'Going','2023-06-02 15:50:10'),(187,19,7,'Going','2023-06-02 15:50:10'),(188,19,8,'Going','2023-06-02 15:50:10'),(189,19,9,'Going','2023-06-02 15:50:10'),(190,19,10,'Going','2023-06-02 15:50:10'),(191,20,11,'Going','2023-06-02 15:50:10'),(192,20,12,'Going','2023-06-02 15:50:10'),(193,20,13,'Going','2023-06-02 15:50:10'),(194,20,14,'Going','2023-06-02 15:50:10'),(195,20,15,'Going','2023-06-02 15:50:10'),(196,20,16,'Going','2023-06-02 15:50:10'),(197,20,17,'Going','2023-06-02 15:50:10'),(198,20,18,'Going','2023-06-02 15:50:10'),(199,20,19,'Going','2023-06-02 15:50:10'),(200,20,20,'Going','2023-06-02 15:50:10'),(201,3,12,'Going','2023-06-02 15:51:24'),(455,7,12,'Not Going','2023-06-02 16:43:02'),(459,4,12,'Going','2023-06-02 16:43:41'),(512,3,1,'Going','2023-06-02 16:47:31'),(523,2,1,'Not Going','2023-06-02 16:47:51'),(533,13,12,'Not Going','2023-06-02 16:49:45');
/*!40000 ALTER TABLE `event_attendees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `events` (
  `event_id` int NOT NULL,
  `club_id` int DEFAULT NULL,
  `event_name` varchar(255) DEFAULT NULL,
  `event_subtitle` varchar(255) DEFAULT NULL,
  `event_date` timestamp NULL DEFAULT NULL,
  `event_time` varchar(255) DEFAULT NULL,
  `event_location` varchar(255) DEFAULT NULL,
  `event_description` varchar(255) DEFAULT NULL,
  `event_organizer_info` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`event_id`),
  KEY `club_id` (`club_id`),
  CONSTRAINT `events_ibfk_1` FOREIGN KEY (`club_id`) REFERENCES `clubs` (`club_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events`
--

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
INSERT INTO `events` VALUES (1,1,'Sports Tournament','Battle for the Championship','2023-06-15 00:00:00','09:00 AM','Sports Stadium','Join us for an exciting sports tournament. Show your skills and compete for the championship.','For more information, contact events@sportsclub.com','2023-05-20 11:30:00'),(2,1,'Sports Workshop','Mastering Sports Techniques','2023-06-20 00:00:00','02:00 PM','Sports Center','Learn from expert coaches and improve your sports techniques. Join our workshop and take your athletic performance to the next level.','For workshop registration, email workshops@sportsclub.com','2023-05-22 09:45:00'),(3,2,'Basketball Tryouts','Find the Next Star Player','2023-06-10 00:00:00','02:00 PM','Basketball Court','Come showcase your basketball talent at our tryouts. We are looking for skilled players to join our team.','For tryout registration, email tryouts@basketballclub.com','2023-05-24 13:30:00'),(4,2,'Basketball Training Session','Skills Enhancement Workshop','2023-06-18 00:00:00','04:00 PM','Basketball Court','Join our training session to enhance your basketball skills. Learn from experienced trainers and improve your game.','For more information, contact events@basketballclub.com','2023-05-26 11:45:00'),(5,3,'Art Exhibition','Celebrating Artistic Expression','2023-06-18 00:00:00','10:00 AM','Art Gallery','Experience an extraordinary art exhibition showcasing talented artists and their captivating creations. Appreciate the beauty of artistic expression.','For more information, contact events@artclub.com','2023-05-28 12:00:00'),(6,3,'Art Workshop','Exploring Creative Techniques','2023-06-22 00:00:00','02:00 PM','Art Studio','Unleash your creativity and explore various art techniques in our interactive workshop. Join us and create your own masterpiece.','For workshop registration, email workshops@artclub.com','2023-06-01 14:15:00'),(7,4,'Music Concert','Melodies in Harmony','2023-06-12 00:00:00','07:00 PM','Concert Hall','Immerse yourself in the enchanting melodies of our music concert. Join us for an evening filled with captivating performances.','For ticket information, email tickets@musicclub.com','2023-06-02 16:30:00'),(8,4,'Music Workshop','Exploring Musical Instruments','2023-06-19 00:00:00','04:00 PM','Music Studio','Discover the world of music instruments in our workshop. Learn to play different instruments and unlock your musical potential.','For workshop registration, email workshops@musicclub.com','2023-06-04 18:45:00'),(9,5,'Photography Workshop','Mastering the Art of Photography','2023-06-20 00:00:00','02:00 PM','Photography Studio','Enhance your photography skills with our professional workshop. Learn valuable techniques and capture stunning photographs.','For workshop registration, email workshops@photographyclub.com','2023-06-06 21:00:00'),(10,5,'Photography Exhibition','Showcasing Moments in Frames','2023-06-24 00:00:00','11:00 AM','Photography Gallery','Immerse yourself in a stunning exhibition of photography. Discover captivating moments captured by talented photographers.','For exhibition details, email exhibitions@photographyclub.com','2023-06-08 10:15:00'),(11,6,'Chess Tournament','Strategize Your Moves','2023-06-16 00:00:00','10:00 AM','Chess Club','Compete in our chess tournament and challenge skilled players. Sharpen your strategic thinking and make your moves count.','For tournament registration, email tournaments@chessclub.com','2023-06-10 13:30:00'),(12,6,'Chess Workshop','Improving Chess Skills','2023-06-22 00:00:00','03:00 PM','Chess Club','Join our chess workshop and learn advanced chess strategies. Develop your skills and become a formidable chess player.','For workshop registration, email workshops@chessclub.com','2023-06-12 15:45:00'),(13,7,'Dance Showcase','Rhythmic Movements','2023-06-19 00:00:00','07:00 PM','Dance Studio','Witness a captivating dance showcase featuring talented dancers. Experience the beauty and grace of various dance forms.','For ticket information, email tickets@danceclub.com','2023-06-14 18:30:00'),(14,7,'Dance Workshop','Exploring Dance Styles','2023-06-25 00:00:00','05:00 PM','Dance Studio','Join our dance workshop and learn different dance styles. Express yourself through dance and discover your passion for movement.','For workshop registration, email workshops@danceclub.com','2023-06-16 20:45:00'),(15,8,'Gaming Tournament','Battle in Virtual Realms','2023-06-22 00:00:00','02:00 PM','Gaming Arena','Participate in our gaming tournament and compete against skilled gamers. Test your skills and claim victory in virtual worlds.','For tournament registration, email tournaments@gamingclub.com','2023-06-18 16:00:00'),(16,8,'Gaming Workshop','Exploring Game Development','2023-06-29 00:00:00','04:00 PM','Gaming Club','Join our gaming workshop and learn game development techniques. Create your own games and embark on a journey of creativity.','For workshop registration, email workshops@gamingclub.com','2023-06-20 18:15:00'),(17,9,'Film Screening','Discover Cinematic Gems','2023-06-24 00:00:00','07:00 PM','Movie Theater','Experience the magic of cinema with our film screening. Explore outstanding movies and immerse yourself in captivating storytelling.','For ticket information, email tickets@filmclub.com','2023-06-22 11:30:00'),(18,9,'Film Workshop','Unveiling Filmmaking Techniques','2023-06-30 00:00:00','03:00 PM','Film Club','Join our film workshop and learn filmmaking techniques from industry professionals. Unleash your creativity and tell compelling stories.','For workshop registration, email workshops@filmclub.com','2023-06-24 14:45:00'),(19,10,'Cooking Class','Culinary Delights','2023-06-23 00:00:00','06:00 PM','Cooking School','Join our cooking class and learn to prepare delicious dishes. Explore different flavors and techniques in the art of cooking.','For class registration, email classes@cookingclub.com','2023-06-26 17:30:00'),(20,10,'Food Festival','A Gastronomic Celebration','2023-06-29 00:00:00','12:00 PM','Food Park','Indulge in a food festival featuring a wide variety of culinary delights. Explore diverse cuisines and satisfy your taste buds.','For more information, contact events@cookingclub.com','2023-06-28 09:45:00');
/*!40000 ALTER TABLE `events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interests`
--

DROP TABLE IF EXISTS `interests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `interests` (
  `interest_id` int NOT NULL AUTO_INCREMENT,
  `interest_name` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`interest_id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interests`
--

LOCK TABLES `interests` WRITE;
/*!40000 ALTER TABLE `interests` DISABLE KEYS */;
INSERT INTO `interests` VALUES (1,'Outdoor Activities','2023-05-30 04:41:43'),(2,'Indoor Activities','2023-05-30 04:41:43'),(3,'Physical Fitness','2023-05-30 04:41:43'),(4,'Creativity','2023-05-30 04:41:43'),(5,'Performing Arts','2023-05-30 04:41:43'),(6,'Board Games','2023-05-30 04:41:43'),(7,'Digital Arts','2023-05-30 04:41:43'),(8,'Cinema','2023-05-30 04:41:43'),(9,'Electronic Sports','2023-05-30 04:41:43'),(10,'Strategy Games','2023-05-30 04:41:43'),(11,'Team Sports','2023-05-30 04:41:43'),(12,'Solo Sports','2023-05-30 04:41:43'),(13,'Painting','2023-05-30 04:41:43'),(14,'Drawing','2023-05-30 04:41:43'),(15,'Sculpture','2023-05-30 04:41:43'),(16,'Classical Music','2023-05-30 04:41:43'),(17,'Modern Music','2023-05-30 04:41:43'),(18,'Film Making','2023-05-30 04:41:43'),(19,'Film Appreciation','2023-05-30 04:41:43'),(20,'Digital Photography','2023-05-30 04:41:43'),(21,'Portrait Photography','2023-05-30 04:41:43'),(22,'Landscape Photography','2023-05-30 04:41:43'),(23,'Strategic Thinking','2023-05-30 04:41:43'),(24,'Problem Solving','2023-05-30 04:41:43'),(25,'Rhythm and Movement','2023-05-30 04:41:43'),(26,'Social Dance','2023-05-30 04:41:43'),(27,'Classical Dance','2023-05-30 04:41:43'),(28,'Role-playing Games','2023-05-30 04:41:43'),(29,'Action Games','2023-05-30 04:41:43'),(30,'Simulation Games','2023-05-30 04:41:43'),(31,'Food','2023-05-30 04:41:43'),(32,'Baking','2023-05-30 04:41:43'),(33,'Nutrition','2023-05-30 04:41:43'),(34,'International Cuisine','2023-05-30 04:41:43'),(35,'Cooking Techniques','2023-05-30 04:41:43');
/*!40000 ALTER TABLE `interests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `memberships`
--

DROP TABLE IF EXISTS `memberships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `memberships` (
  `membership_id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `club_id` int DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`membership_id`),
  KEY `user_id` (`user_id`),
  KEY `club_id` (`club_id`),
  CONSTRAINT `memberships_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `memberships_ibfk_2` FOREIGN KEY (`club_id`) REFERENCES `clubs` (`club_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `memberships`
--

LOCK TABLES `memberships` WRITE;
/*!40000 ALTER TABLE `memberships` DISABLE KEYS */;
INSERT INTO `memberships` VALUES (1,1,1,'Active','2023-05-19 10:00:00'),(2,2,1,'Active','2023-05-19 11:30:00'),(3,1,2,'Active','2023-05-20 14:30:00'),(4,3,2,'Active','2023-05-21 09:45:00'),(5,4,3,'Active','2023-05-22 11:00:00'),(6,5,3,'Inactive','2023-05-23 12:15:00'),(7,6,4,'Active','2023-05-24 13:30:00'),(8,7,4,'Inactive','2023-05-25 14:45:00'),(9,8,5,'Active','2023-05-26 16:00:00'),(10,9,5,'Active','2023-05-27 17:15:00'),(11,10,6,'Active','2023-05-28 18:30:00'),(12,11,6,'Inactive','2023-05-29 19:45:00'),(13,12,7,'Active','2023-05-30 21:00:00'),(14,13,7,'Active','2023-05-31 22:15:00'),(15,14,8,'Active','2023-06-01 10:30:00'),(16,15,8,'Inactive','2023-06-02 11:45:00'),(17,16,9,'Active','2023-06-03 13:00:00'),(18,17,9,'Active','2023-06-04 14:15:00'),(19,18,10,'Active','2023-06-05 15:30:00'),(20,19,10,'Inactive','2023-06-06 16:45:00'),(21,20,1,'Active','2023-06-07 18:00:00'),(22,21,2,'Active','2023-06-08 19:15:00'),(23,22,3,'Active','2023-06-09 20:30:00'),(24,23,4,'Inactive','2023-06-10 21:45:00'),(25,24,5,'Active','2023-06-11 23:00:00'),(26,25,6,'Active','2023-06-12 10:15:00'),(27,26,7,'Active','2023-06-13 11:30:00'),(28,27,8,'Active','2023-06-14 12:45:00'),(29,28,9,'Inactive','2023-06-15 14:00:00'),(30,29,10,'Active','2023-06-16 15:15:00'),(31,30,1,'Active','2023-06-17 16:30:00'),(32,31,2,'Active','2023-06-18 17:45:00'),(34,11,1,'Active','2023-06-17 10:23:00'),(35,12,2,'Active','2023-06-17 11:45:00'),(36,13,3,'Inactive','2023-06-17 14:32:00'),(37,14,4,'Active','2023-06-17 15:17:00'),(38,15,5,'Active','2023-06-17 17:58:00'),(39,16,6,'Inactive','2023-06-17 19:40:00'),(40,17,7,'Active','2023-06-17 22:01:00'),(41,18,8,'Active','2023-06-17 23:30:00'),(42,19,9,'Inactive','2023-06-18 12:47:00'),(43,20,10,'Active','2023-06-18 13:59:00'),(44,21,1,'Inactive','2023-06-18 16:28:00'),(45,22,2,'Active','2023-06-18 17:53:00'),(46,23,3,'Active','2023-06-18 19:06:00'),(47,24,4,'Inactive','2023-06-18 21:17:00'),(48,25,5,'Active','2023-06-18 22:44:00'),(49,26,6,'Active','2023-06-19 10:55:00'),(50,27,7,'Inactive','2023-06-19 12:13:00'),(51,28,8,'Active','2023-06-19 14:27:00'),(52,29,9,'Active','2023-06-19 15:45:00'),(53,30,10,'Inactive','2023-06-19 18:03:00'),(54,31,1,'Active','2023-06-19 19:18:00'),(55,32,2,'Active','2023-06-19 20:41:00'),(56,11,3,'Inactive','2023-06-19 22:03:00'),(57,12,4,'Active','2023-06-19 23:24:00'),(58,13,5,'Active','2023-06-20 11:38:00'),(59,14,6,'Inactive','2023-06-20 12:51:00'),(60,15,7,'Active','2023-06-20 15:06:00'),(61,16,8,'Active','2023-06-20 16:21:00'),(62,17,9,'Inactive','2023-06-20 18:35:00'),(63,18,10,'Active','2023-06-20 19:53:00');
/*!40000 ALTER TABLE `memberships` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `notification_id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `notification_type` varchar(255) DEFAULT NULL,
  `notification_content` varchar(255) DEFAULT NULL,
  `is_read` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`notification_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
INSERT INTO `notifications` VALUES (1,1,'Event Reminder','Don\'t forget to attend the upcoming sports tournament on June 15th.',0,'2023-06-10 09:00:00'),(2,2,'Club Update','Check out the new training schedule for Sports Club.',0,'2023-05-21 15:30:00'),(3,1,'Membership Approval','Your membership request for Basketball Club is pending.',0,'2023-05-20 14:30:00');
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_linked_accounts`
--

DROP TABLE IF EXISTS `user_linked_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_linked_accounts` (
  `linked_account_id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `platform` varchar(255) DEFAULT NULL,
  `account_identifier` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`linked_account_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `user_linked_accounts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_linked_accounts`
--

LOCK TABLES `user_linked_accounts` WRITE;
/*!40000 ALTER TABLE `user_linked_accounts` DISABLE KEYS */;
INSERT INTO `user_linked_accounts` VALUES (1,1,'Facebook','example_user1','2023-05-19 10:15:00'),(2,1,'Twitter','example_user1_twitter','2023-05-19 11:30:00'),(3,2,'Facebook','example_user2','2023-05-20 10:30:00'),(4,2,'Twitter','example_user2_twitter','2023-05-20 12:00:00'),(5,3,'Facebook','example_user3','2023-05-21 09:45:00'),(6,3,'Instagram','example_user3_instagram','2023-05-21 12:15:00'),(7,4,'Twitter','example_user4_twitter','2023-05-22 11:00:00'),(8,4,'LinkedIn','example_user4_linkedin','2023-05-22 13:30:00'),(9,5,'Facebook','example_user5','2023-05-23 10:45:00'),(10,5,'Instagram','example_user5_instagram','2023-05-23 12:00:00'),(11,6,'Twitter','example_user6_twitter','2023-05-24 09:30:00'),(12,6,'LinkedIn','example_user6_linkedin','2023-05-24 11:00:00'),(13,7,'Facebook','example_user7','2023-05-25 10:00:00'),(14,7,'Instagram','example_user7_instagram','2023-05-25 11:15:00'),(15,8,'Twitter','example_user8_twitter','2023-05-26 10:30:00'),(16,8,'LinkedIn','example_user8_linkedin','2023-05-26 12:00:00'),(17,9,'Facebook','example_user9','2023-05-27 09:45:00'),(18,9,'Twitter','example_user9_twitter','2023-05-27 11:00:00'),(19,10,'Facebook','example_user10','2023-05-28 10:00:00'),(20,10,'Instagram','example_user10_instagram','2023-05-28 11:15:00'),(21,11,'Facebook','example_user11','2023-06-17 10:15:00'),(22,11,'Twitter','example_user11_twitter','2023-06-17 11:30:00'),(23,12,'Facebook','example_user12','2023-06-17 10:30:00'),(24,12,'Twitter','example_user12_twitter','2023-06-17 12:00:00'),(25,13,'Facebook','example_user13','2023-06-17 09:45:00'),(26,13,'Reddit','example_user13_reddit','2023-06-17 11:30:00'),(27,14,'Twitter','example_user14_twitter','2023-06-17 10:00:00'),(28,14,'Meetup','example_user14_meetup','2023-06-17 11:15:00'),(29,15,'Facebook','example_user15','2023-06-17 10:30:00'),(30,15,'Reddit','example_user15_reddit','2023-06-17 12:00:00'),(31,16,'Twitter','example_user16_twitter','2023-06-17 09:45:00'),(32,16,'Reddit','example_user16_reddit','2023-06-17 11:00:00'),(33,17,'LinkedIn','example_user17_linkedin','2023-06-17 10:00:00'),(34,17,'Meetup','example_user17_meetup','2023-06-17 11:15:00'),(35,18,'Facebook','example_user18','2023-06-17 10:30:00'),(36,18,'Reddit','example_user18_reddit','2023-06-17 12:00:00'),(37,19,'Twitter','example_user19_twitter','2023-06-17 09:45:00'),(38,19,'Reddit','example_user19_reddit','2023-06-17 11:00:00'),(39,20,'LinkedIn','example_user20_linkedin','2023-06-17 10:00:00'),(40,20,'Meetup','example_user20_meetup','2023-06-17 11:15:00'),(41,21,'Facebook','example_user21','2023-06-17 10:15:00'),(42,21,'Reddit','example_user21_reddit','2023-06-17 11:30:00'),(43,22,'Twitter','example_user22_twitter','2023-06-17 10:00:00'),(44,22,'Reddit','example_user22_reddit','2023-06-17 11:15:00'),(45,23,'LinkedIn','example_user23_linkedin','2023-06-17 10:00:00'),(46,23,'Meetup','example_user23_meetup','2023-06-17 11:15:00'),(47,24,'Facebook','example_user24','2023-06-17 10:30:00'),(48,24,'Reddit','example_user24_reddit','2023-06-17 12:00:00'),(49,25,'Twitter','example_user25_twitter','2023-06-17 09:45:00'),(50,25,'Reddit','example_user25_reddit','2023-06-17 11:00:00'),(51,26,'LinkedIn','example_user26_linkedin','2023-06-17 10:00:00'),(52,26,'Meetup','example_user26_meetup','2023-06-17 11:15:00'),(53,27,'Facebook','example_user27','2023-06-17 10:15:00'),(54,27,'Reddit','example_user27_reddit','2023-06-17 11:30:00'),(55,28,'Twitter','example_user28_twitter','2023-06-17 10:00:00'),(56,28,'Meetup','example_user28_meetup','2023-06-17 11:15:00'),(57,29,'Facebook','example_user29','2023-06-17 10:30:00'),(58,29,'Reddit','example_user29_reddit','2023-06-17 12:00:00'),(59,30,'Twitter','example_user30_twitter','2023-06-17 09:45:00'),(60,30,'Reddit','example_user30_reddit','2023-06-17 11:00:00'),(61,31,'LinkedIn','example_user31_linkedin','2023-06-17 10:00:00'),(62,31,'Meetup','example_user31_meetup','2023-06-17 11:15:00'),(63,32,'Facebook','example_user32','2023-06-17 10:30:00'),(64,32,'Reddit','example_user32_reddit','2023-06-17 12:00:00');
/*!40000 ALTER TABLE `user_linked_accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `profile_picture` varchar(255) DEFAULT NULL,
  `interests` varchar(255) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'johndoe@example.com','password1','profile_pic1.png','Sports, Fitness','Manager','2023-05-19 10:00:00','John','Doe'),(2,'janesmith@example.com','password2','profile_pic2.png','Basketball, Athletics','Admin','2023-05-20 11:00:00','Jane','Smith'),(3,'emma@example.com','password3','profile_pic3.png','Soccer, Tennis','Manager','2023-05-21 12:00:00','Emma','Thompson'),(4,'noah@example.com','password4','profile_pic4.png','Basketball, Volleyball','Member','2023-05-22 13:00:00','Noah','Walker'),(5,'ava@example.com','password5','profile_pic5.png','Swimming, Gymnastics','Manager','2023-05-23 14:00:00','Ava','Lewis'),(6,'liam@example.com','password6','profile_pic6.png','Cricket, Badminton','Member','2023-05-24 15:00:00','Liam','Carter'),(7,'sophia@example.com','password7','profile_pic7.png','Dance, Yoga','Manager','2023-05-25 16:00:00','Sophia','Johnson'),(8,'lucas@example.com','password8','profile_pic8.png','Music, Painting','Member','2023-05-26 17:00:00','Lucas','Wilson'),(9,'isabella@example.com','password9','profile_pic9.png','Photography, Writing','Manager','2023-05-27 18:00:00','Isabella','Anderson'),(10,'elijah@example.com','password10','profile_pic10.png','Chess, Coding','Member','2023-05-28 19:00:00','Elijah','Martinez'),(11,'mia@example.com','password11','profile_pic11.png','Art, Crafts','Member','2023-05-29 20:00:00','Mia','Robinson'),(12,'oliver@example.com','password12','profile_pic12.png','Cooking, Baking','Member','2023-05-30 21:00:00','Oliver','Clark'),(13,'amelia@example.com','password13','profile_pic13.png','Film, Theater','Member','2023-05-31 22:00:00','Amelia','Taylor'),(14,'aiden@example.com','password14','profile_pic14.png','Gaming, Technology','Member','2023-06-01 23:00:00','Aiden','Brown'),(15,'charlotte@example.com','password15','profile_pic15.png','Fashion, Design','Member','2023-06-02 10:00:00','Charlotte','Lee'),(16,'ethan@example.com','password16','profile_pic16.png','Travel, Adventure','Member','2023-06-03 11:00:00','Ethan','Garcia'),(17,'harper@example.com','password17','profile_pic17.png','Reading, Writing','Member','2023-06-04 12:00:00','Harper','Martinez'),(18,'james@example.com','password18','profile_pic18.png','Soccer, Tennis','Member','2023-06-05 13:00:00','James','Rodriguez'),(19,'sophia@example.com','password19','profile_pic19.png','Basketball, Athletics','Member','2023-06-06 14:00:00','Sophia','Wright'),(20,'benjamin@example.com','password20','profile_pic20.png','Swimming, Gymnastics','Member','2023-06-07 15:00:00','Benjamin','Scott'),(21,'mia@example.com','password21','profile_pic21.png','Cricket, Badminton','Member','2023-06-08 16:00:00','Mia','Green'),(22,'henry@example.com','password22','profile_pic22.png','Dance, Yoga','Member','2023-06-09 17:00:00','Henry','Davis'),(23,'elizabeth@example.com','password23','profile_pic23.png','Music, Painting','Member','2023-06-10 18:00:00','Elizabeth','Lopez'),(24,'alexander@example.com','password24','profile_pic24.png','Photography, Writing','Member','2023-06-11 19:00:00','Alexander','Hall'),(25,'emily@example.com','password25','profile_pic25.png','Chess, Coding','Member','2023-06-12 20:00:00','Emily','Martinez'),(26,'sebastian@example.com','password26','profile_pic26.png','Art, Crafts','Member','2023-06-13 21:00:00','Sebastian','Hill'),(27,'scarlett@example.com','password27','profile_pic27.png','Cooking, Baking','Member','2023-06-14 22:00:00','Scarlett','King'),(28,'jack@example.com','password28','profile_pic28.png','Film, Theater','Member','2023-06-15 23:00:00','Jack','Turner'),(29,'avery@example.com','password29','profile_pic29.png','Gaming, Technology','Member','2023-06-16 10:00:00','Avery','Hernandez'),(30,'michael@example.com','password30','profile_pic30.png','Fashion, Design','Member','2023-06-17 11:00:00','Michael','Young'),(31,'evelyn@example.com','password31','profile_pic31.png','Travel, Adventure','Member','2023-06-18 12:00:00','Evelyn','Collins'),(32,'daniel@example.com','password32','profile_pic32.png','Reading, Writing','Member','2023-06-19 13:00:00','Daniel','Adams'),(100,'chaucted@gmail.com','admin','sam.png',NULL,'admin','2023-05-31 23:13:10','Samuel','Chau');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-06-02 17:22:15
