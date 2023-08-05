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
  `update_id` int NOT NULL AUTO_INCREMENT,
  `club_id` int DEFAULT NULL,
  `update_title` varchar(255) DEFAULT NULL,
  `update_preview_content` varchar(255) DEFAULT NULL,
  `update_content` text,
  `update_date` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `is_private` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`update_id`),
  KEY `club_id` (`club_id`),
  CONSTRAINT `club_updates_ibfk_1` FOREIGN KEY (`club_id`) REFERENCES `clubs` (`club_id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `club_updates`
--

LOCK TABLES `club_updates` WRITE;
/*!40000 ALTER TABLE `club_updates` DISABLE KEYS */;
INSERT INTO `club_updates` VALUES (7,6,'Chess Player Spotlight',NULL,'<p>Attention all chess enthusiasts!</p><p>We are excited to introduce a new segment called <strong>\"Chess Player Spotlight\"</strong> where we highlight the achievements and stories of our talented club members. Each month, we will select a member to feature and share their chess journey, favorite strategies, and memorable games.</p><p>Stay tuned for our first spotlight, which will be posted on our website <a href=\"https://www.grandmastershaven.com/player-spotlight\" rel=\"noopener noreferrer\" target=\"_blank\">here</a> next week. Discover the diverse talents within our club and get inspired by their passion for the game.</p>','2023-06-04 17:06:14','2023-06-04 17:06:14',0),(8,6,'Chess Puzzle of the Week',NULL,'<p>Hello, chess lovers!</p><p>Get ready to put your skills to the test with our brand new <strong>\"Chess Puzzle of the Week\"</strong> challenge. Every Monday, we will post a mind-bending puzzle on our social media platforms to keep your tactical instincts sharp and provide an opportunity for friendly competition among our members.</p><p>Follow us on Instagram <a href=\"https://www.instagram.com/chessmasterhaven\" rel=\"noopener noreferrer\" target=\"_blank\">@ChessMasterHaven</a> and stay updated with the latest puzzles. Don\'t forget to share your solutions in the comments section and tag us with <strong><em>#ChessPuzzleChallenge</em></strong>. Let\'s see who can crack the puzzle first!</p>','2023-06-04 17:06:47','2023-06-04 17:06:47',0),(9,6,'Chess Strategy Tips',NULL,'<p>Greetings, strategic thinkers!</p><p>We believe in continuous improvement, and to help you enhance your chess skills, we will be sharing weekly <strong>\"Chess Strategy Tips\"</strong> on our club\'s blog. These bite-sized insights, curated by our experienced players, will cover various aspects of the game, including:</p><ul><li><strong>Openings</strong>: Unleash your creativity and surprise your opponents.</li><li><strong>Middle Game Tactics</strong>: Master the art of strategic maneuvers and positional play.</li><li><strong>Endgame Techniques</strong>: Polish your endgame skills and convert advantages into victories.</li></ul><p>Stay tuned to our website <a href=\"https://www.grandmastershaven.com/strategy-tips\" rel=\"noopener noreferrer\" target=\"_blank\">here</a> for regular updates. Whether you\'re a beginner or an advanced player, these tips will provide valuable guidance to elevate your game to new heights.</p><p>Enjoy the journey of learning and mastering the art of chess!</p><p>Warm regards, The Grandmaster\'s Haven Team</p>','2023-06-04 17:07:09','2023-06-04 17:07:09',0),(10,6,'Chess Club Online Community',NULL,'<p>Dear chess enthusiasts,</p><p>We are excited to announce the launch of our new online community platform exclusively for members of our chess club. The platform aims to foster a vibrant and engaging space where chess lovers can connect, share insights, and participate in stimulating discussions.</p><p>🌐 Connect with fellow members: Join a thriving community of chess enthusiasts who share your passion for the game. Engage in conversations, exchange ideas, and form connections with like-minded individuals.</p><p>💡 Learn and grow: The online community offers a wealth of knowledge and resources to help you enhance your chess skills. Access learning materials, tutorials, and strategy guides shared by experienced players and coaches within the club.</p><p>🏆 Participate in challenges and tournaments: Test your skills against other club members in friendly online challenges and mini-tournaments. Challenge yourself, improve your gameplay, and celebrate the joy of friendly competition.</p><p>📣 Stay updated: Get the latest club news, updates, and announcements directly on the platform. Be the first to know about upcoming events, workshops, and exciting opportunities within the club.</p><p>Joining the online community is easy. Simply visit our club\'s website and navigate to the \"Community\" section to create your account. Connect with fellow chess enthusiasts, immerse yourself in chess-related discussions, and embark on a rewarding journey of growth and camaraderie.</p><p>We believe that this online community will become a thriving hub for chess enthusiasts to come together, inspire each other, and foster a shared love for the game. We can\'t wait to see the vibrant interactions and friendships that will emerge within our chess club\'s online community.</p><p>Best regards, The Grandmaster\'s Haven Team</p>','2023-06-04 18:43:57','2023-06-04 18:43:57',0),(11,9,'Celebrating Creative Short Films',NULL,'<p><strong>Dear club members,</strong></p><p>Today, we celebrate the art of concise storytelling as we highlight some exceptional <strong>one-minute films</strong> created by our talented club members. These films showcase the incredible <strong>creativity, innovation, and storytelling abilities</strong> within the constraints of just <strong>60 seconds</strong>. Get ready to be inspired by the remarkable talent and the ability to convey meaningful stories in such a short duration.</p><p>We invite you to watch these incredible one-minute films on our club\'s website. Prepare to be captivated by the diversity of genres, unique perspectives, and the artistry exhibited by our talented filmmakers. Take a moment to appreciate the hard work and dedication that went into creating these mini-masterpieces.</p><p>Let\'s congratulate our fellow club members on their outstanding achievements and their ability to make a lasting impact in just one minute. Stay tuned for more updates and future opportunities to showcase your own one-minute films.</p>','2023-06-04 18:54:39','2023-06-04 18:54:39',0),(12,9,'Filmmaking Tips and Tricks',NULL,'<p><strong>Attention aspiring filmmakers!</strong></p><p>In our continuous effort to support and nurture your filmmaking skills, we are delighted to present a series of <strong>filmmaking tips and tricks</strong>. Each week, we will share valuable insights and practical advice to help you improve your craft and create compelling one-minute films.</p><p>From storytelling techniques to cinematography tips, editing tricks, and more, our aim is to provide you with a wealth of knowledge that you can apply to your own projects. We believe that learning and sharing our expertise will contribute to the growth and success of all our club members.</p><p>Stay tuned for our first installment of filmmaking tips, coming soon to our club\'s website. Get ready to <strong>elevate your filmmaking skills</strong> and unlock your creative potential!</p>','2023-06-04 18:54:55','2023-06-04 18:54:55',0),(13,9,'Featured Filmmaker Spotlight',NULL,'<p>Today, we shine the spotlight on one of our talented club members who has consistently impressed us with their exceptional one-minute films. Meet <strong>[Filmmaker Name]</strong>, a visionary storyteller who has mastered the art of concise storytelling.</p><p><strong>[Filmmaker Name]</strong> has consistently captivated us with their unique perspective, powerful narratives, and exceptional execution within the one-minute format. Their films have touched hearts, sparked conversations, and left a lasting impression on our club members.</p><p>We encourage you to explore <strong>[Filmmaker Name]\'s work</strong> and draw inspiration from their incredible talent. Check out their films on our club\'s website and take a moment to appreciate their contribution to the world of one-minute filmmaking.</p><p>Let\'s congratulate <strong>[Filmmaker Name]</strong> on their remarkable achievements and thank them for sharing their passion and creativity with our club. We look forward to seeing more of their outstanding work in the future.</p><p>Stay tuned for more spotlights on talented filmmakers within our club, as we continue to celebrate their contributions and inspire each other in the world of one-minute films.</p>','2023-06-04 18:55:15','2023-06-04 18:55:15',0),(14,5,'Embrace the Challenge: Monthly Photo Challenge Winners!',NULL,'<p>Congratulations to our talented <em>Snap Capture Photography Club</em> members who participated in our <strong>May \'Capture Light\'</strong> photo challenge!</p><p>We\'d like to share the Top 3 winning photos:</p><ol><li><em>Golden Hour at the Bay</em> by Sarah Martinez</li><li><em>Lanterns in the Night</em> by Jake Miller</li><li><em>Lighthouse at Dawn</em> by Lily Green</li></ol><p>We\'re excited to see more of your creative captures for our next challenge!</p>','2023-06-05 09:50:55','2023-06-05 09:50:55',0),(15,5,' New Tutorial Alert: Mastering Black & White Photography',NULL,'<p>We have recently uploaded a comprehensive tutorial on <strong><em>Mastering Black &amp; White Photography</em></strong> on our club website. Whether you\'re a beginner or an experienced shutterbug, this tutorial offers valuable insights and techniques to help you excel in this timeless art form. Don\'t forget to check it out!</p>','2023-06-05 09:51:18','2023-06-05 09:51:18',0),(16,5,'Our Club\'s Achievements: Snap Capture Photography Club in Focus',NULL,'<p>We\'re thrilled to share that our club has recently been featured in the local newspaper, lauding our efforts in promoting photography as an art form. We are so proud of the positive impact our members are making within the photography community. Read the full article on our website to discover more about our journey.</p>','2023-06-05 09:51:29','2023-06-05 09:51:29',0);
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
INSERT INTO `clubs` VALUES (1,'Sports Club','file-1685799316408.jpg','file-1685383082197.jpg','A club for sports enthusiasts','contact@sportsclub.com','@sportsclubofficial','2023-05-18 10:20:00'),(2,'Basketball Club','file-1685799327311.jpg','banner_basketball.png','A club for basketball lovers','contact@basketballclub.com','@basketballclubofficial','2023-05-19 14:45:00'),(3,'Art Club','file-1685837597557.jpg','banner_art.png','The Art Explorers Club is an enriching and inclusive community dedicated to fostering the creative spirit in members of all skill levels and interests. We embrace a diverse range of art forms, from traditional mediums like painting, drawing, and sculpture, to digital art, photography, and mixed media. In our club, every member has the opportunity to express their unique artistic perspectives and expand their horizons. We host a variety of engaging activities such as weekly art workshops, where beginners can learn the basics and experienced artists can refine their skills. These workshops cover a wide array of topics, such as color theory, perspective drawing, portraiture, and landscape painting. Members also have the chance to showcase their work in our monthly art exhibits. These events provide an opportunity for artists to receive constructive feedback, gain exposure, and draw inspiration from the creativity of others. Apart from practical activities, we invite guest speakers from the art industry to share insights about art history, contemporary trends, and career paths in the arts. These sessions provide a deeper understanding of the art world and can guide those interested in pursuing art professionally. The Art Explorers Club is more than just a place to create art—it\'s a space for members to connect with like-minded individuals, collaborate on artistic projects, and celebrate the power of creativity. Regardless of your artistic experience or style, if you have a passion for art, the Art Explorers Club welcomes you!','contact@artclub.com','@artclubofficial','2023-05-20 09:30:00'),(4,'Music Club','file-1685801286818.jpg','banner_music.png','A club for music lovers and musicians','contact@musicclub.com','@musicclubofficial','2023-05-21 11:15:00'),(5,'Snap Capture Photography Club','file-1685959335561.png','file-1685958424934.jpg','The Snap Capture Photography Club is an inclusive community dedicated to embracing the art and science of photography. We aim to inspire and equip our members to explore the world through the lens of a camera, promoting creativity, technical mastery, and a profound appreciation of light and composition. Our members range from hobbyists to professional photographers, creating an environment of shared learning and passion for the art of photography.','snapcaptureclub@gmail.com','@snapcaptureclub','2023-05-22 13:45:00'),(6,'Grandmaster Lodge','file-1685903587792.png','file-1685847195523.jpeg','Welcome to Grandmaster Lodge, where chess enthusiasts gather to sharpen their skills and engage in friendly battles of wit and strategy. Our club is dedicated to promoting the timeless game of chess and fostering a vibrant community of players of all ages and skill levels. Join us to embark on an exciting journey through the intricacies of the royal game.','grandmastershaven@gmail.com','@ChessMasterHaven','2023-05-23 16:20:00'),(7,'Dance Club','file-1685467583869.webp','banner_dance.png','A club for dance lovers and dancers','contact@danceclub.com','@danceclubofficial','2023-05-24 18:10:00'),(8,'Gaming Club','file-1685878008320.png','file-1685878409929.jpeg','A club for gamers and gaming enthusiasts','contact@gamingclub.com','@gamingclubofficial','2023-05-25 20:30:00'),(9,'One Minute Film Club','file-1685905630840.png','file-1685904654161.jpg','Welcome to the One Minute Film Club, where we embrace the creativity and storytelling power of short films. We believe that great stories can be told in just one minute, and our club is dedicated to exploring and appreciating the art of concise filmmaking. Whether you\'re an aspiring filmmaker, a film enthusiast, or simply curious about the world of short films, our club offers a space to connect, share, and celebrate the magic of one-minute films.','oneminutefilmclub@example.com','@oneminutefilmclub','2023-05-26 22:15:00'),(10,'Cooking Club','file-1685797986907.png','banner_cooking.png','A club for cooking enthusiasts and food lovers','contact@cookingclub.com','@cookingclubofficial','2023-05-27 09:45:00');
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
  CONSTRAINT `event_attendees_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=809 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_attendees`
--

LOCK TABLES `event_attendees` WRITE;
/*!40000 ALTER TABLE `event_attendees` DISABLE KEYS */;
INSERT INTO `event_attendees` VALUES (1,1,1,'Going','2023-06-02 15:50:10'),(2,1,2,'Going','2023-06-02 15:50:10'),(3,1,3,'Going','2023-06-02 15:50:10'),(6,1,6,'Going','2023-06-02 15:50:10'),(8,1,8,'Going','2023-06-02 15:50:10'),(9,1,9,'Going','2023-06-02 15:50:10'),(10,1,10,'Going','2023-06-02 15:50:10'),(12,2,12,'Going','2023-06-02 15:50:10'),(13,2,13,'Going','2023-06-02 15:50:10'),(14,2,14,'Going','2023-06-02 15:50:10'),(15,2,15,'Going','2023-06-02 15:50:10'),(16,2,16,'Going','2023-06-02 15:50:10'),(17,2,17,'Going','2023-06-02 15:50:10'),(18,2,18,'Going','2023-06-02 15:50:10'),(20,2,20,'Going','2023-06-02 15:50:10'),(22,3,22,'Going','2023-06-02 15:50:10'),(23,3,23,'Going','2023-06-02 15:50:10'),(24,3,24,'Going','2023-06-02 15:50:10'),(25,3,25,'Going','2023-06-02 15:50:10'),(26,3,26,'Going','2023-06-02 15:50:10'),(27,3,27,'Going','2023-06-02 15:50:10'),(28,3,28,'Going','2023-06-02 15:50:10'),(29,3,29,'Going','2023-06-02 15:50:10'),(30,3,30,'Going','2023-06-02 15:50:10'),(31,4,1,'Going','2023-06-02 15:50:10'),(32,4,2,'Going','2023-06-02 15:50:10'),(33,4,3,'Going','2023-06-02 15:50:10'),(36,4,6,'Going','2023-06-02 15:50:10'),(38,4,8,'Going','2023-06-02 15:50:10'),(39,4,9,'Going','2023-06-02 15:50:10'),(40,4,10,'Going','2023-06-02 15:50:10'),(42,5,12,'Going','2023-06-02 15:50:10'),(43,5,13,'Going','2023-06-02 15:50:10'),(44,5,14,'Going','2023-06-02 15:50:10'),(45,5,15,'Going','2023-06-02 15:50:10'),(46,5,16,'Going','2023-06-02 15:50:10'),(47,5,17,'Going','2023-06-02 15:50:10'),(48,5,18,'Going','2023-06-02 15:50:10'),(50,5,20,'Going','2023-06-02 15:50:10'),(52,6,22,'Going','2023-06-02 15:50:10'),(53,6,23,'Going','2023-06-02 15:50:10'),(54,6,24,'Going','2023-06-02 15:50:10'),(55,6,25,'Going','2023-06-02 15:50:10'),(56,6,26,'Going','2023-06-02 15:50:10'),(57,6,27,'Going','2023-06-02 15:50:10'),(58,6,28,'Going','2023-06-02 15:50:10'),(59,6,29,'Going','2023-06-02 15:50:10'),(60,6,30,'Going','2023-06-02 15:50:10'),(61,7,1,'Going','2023-06-02 15:50:10'),(62,7,2,'Going','2023-06-02 15:50:10'),(63,7,3,'Going','2023-06-02 15:50:10'),(66,7,6,'Going','2023-06-02 15:50:10'),(68,7,8,'Going','2023-06-02 15:50:10'),(69,7,9,'Going','2023-06-02 15:50:10'),(70,7,10,'Going','2023-06-02 15:50:10'),(72,8,12,'Going','2023-06-02 15:50:10'),(73,8,13,'Going','2023-06-02 15:50:10'),(74,8,14,'Going','2023-06-02 15:50:10'),(75,8,15,'Going','2023-06-02 15:50:10'),(76,8,16,'Going','2023-06-02 15:50:10'),(77,8,17,'Going','2023-06-02 15:50:10'),(78,8,18,'Going','2023-06-02 15:50:10'),(80,8,20,'Going','2023-06-02 15:50:10'),(82,9,22,'Going','2023-06-02 15:50:10'),(83,9,23,'Going','2023-06-02 15:50:10'),(84,9,24,'Going','2023-06-02 15:50:10'),(85,9,25,'Going','2023-06-02 15:50:10'),(86,9,26,'Going','2023-06-02 15:50:10'),(87,9,27,'Going','2023-06-02 15:50:10'),(88,9,28,'Going','2023-06-02 15:50:10'),(89,9,29,'Going','2023-06-02 15:50:10'),(90,9,30,'Going','2023-06-02 15:50:10'),(91,10,1,'Going','2023-06-02 15:50:10'),(92,10,2,'Going','2023-06-02 15:50:10'),(93,10,3,'Going','2023-06-02 15:50:10'),(96,10,6,'Going','2023-06-02 15:50:10'),(98,10,8,'Going','2023-06-02 15:50:10'),(99,10,9,'Going','2023-06-02 15:50:10'),(100,10,10,'Going','2023-06-02 15:50:10'),(121,13,1,'Going','2023-06-02 15:50:10'),(122,13,2,'Going','2023-06-02 15:50:10'),(123,13,3,'Going','2023-06-02 15:50:10'),(126,13,6,'Going','2023-06-02 15:50:10'),(128,13,8,'Going','2023-06-02 15:50:10'),(129,13,9,'Going','2023-06-02 15:50:10'),(130,13,10,'Going','2023-06-02 15:50:10'),(132,14,12,'Not Going','2023-06-02 15:50:10'),(133,14,13,'Going','2023-06-02 15:50:10'),(134,14,14,'Going','2023-06-02 15:50:10'),(135,14,15,'Going','2023-06-02 15:50:10'),(136,14,16,'Going','2023-06-02 15:50:10'),(137,14,17,'Going','2023-06-02 15:50:10'),(138,14,18,'Going','2023-06-02 15:50:10'),(140,14,20,'Going','2023-06-02 15:50:10'),(142,15,22,'Going','2023-06-02 15:50:10'),(143,15,23,'Going','2023-06-02 15:50:10'),(144,15,24,'Going','2023-06-02 15:50:10'),(145,15,25,'Going','2023-06-02 15:50:10'),(146,15,26,'Going','2023-06-02 15:50:10'),(147,15,27,'Going','2023-06-02 15:50:10'),(148,15,28,'Going','2023-06-02 15:50:10'),(149,15,29,'Going','2023-06-02 15:50:10'),(150,15,30,'Going','2023-06-02 15:50:10'),(151,16,1,'Going','2023-06-02 15:50:10'),(152,16,2,'Going','2023-06-02 15:50:10'),(153,16,3,'Going','2023-06-02 15:50:10'),(156,16,6,'Going','2023-06-02 15:50:10'),(158,16,8,'Going','2023-06-02 15:50:10'),(159,16,9,'Going','2023-06-02 15:50:10'),(160,16,10,'Going','2023-06-02 15:50:10'),(162,17,12,'Not Going','2023-06-02 15:50:10'),(163,17,13,'Going','2023-06-02 15:50:10'),(164,17,14,'Going','2023-06-02 15:50:10'),(165,17,15,'Going','2023-06-02 15:50:10'),(166,17,16,'Going','2023-06-02 15:50:10'),(167,17,17,'Going','2023-06-02 15:50:10'),(168,17,18,'Going','2023-06-02 15:50:10'),(170,17,20,'Going','2023-06-02 15:50:10'),(172,18,22,'Going','2023-06-02 15:50:10'),(173,18,23,'Going','2023-06-02 15:50:10'),(174,18,24,'Going','2023-06-02 15:50:10'),(175,18,25,'Going','2023-06-02 15:50:10'),(176,18,26,'Going','2023-06-02 15:50:10'),(177,18,27,'Going','2023-06-02 15:50:10'),(178,18,28,'Going','2023-06-02 15:50:10'),(179,18,29,'Going','2023-06-02 15:50:10'),(180,18,30,'Going','2023-06-02 15:50:10'),(181,19,1,'Going','2023-06-02 15:50:10'),(182,19,2,'Going','2023-06-02 15:50:10'),(183,19,3,'Going','2023-06-02 15:50:10'),(186,19,6,'Going','2023-06-02 15:50:10'),(188,19,8,'Going','2023-06-02 15:50:10'),(189,19,9,'Going','2023-06-02 15:50:10'),(190,19,10,'Going','2023-06-02 15:50:10'),(192,20,12,'Going','2023-06-02 15:50:10'),(193,20,13,'Going','2023-06-02 15:50:10'),(194,20,14,'Going','2023-06-02 15:50:10'),(195,20,15,'Going','2023-06-02 15:50:10'),(196,20,16,'Going','2023-06-02 15:50:10'),(197,20,17,'Going','2023-06-02 15:50:10'),(198,20,18,'Going','2023-06-02 15:50:10'),(200,20,20,'Going','2023-06-02 15:50:10'),(201,3,12,'Going','2023-06-02 15:51:24'),(455,7,12,'Not Going','2023-06-02 16:43:02'),(459,4,12,'Going','2023-06-02 16:43:41'),(512,3,1,'Going','2023-06-02 16:47:31'),(523,2,1,'Not Going','2023-06-02 16:47:51'),(533,13,12,'Not Going','2023-06-02 16:49:45'),(600,3,100,'Going','2023-06-03 14:17:59'),(601,7,100,'Going','2023-06-03 14:18:03'),(602,8,100,'Going','2023-06-03 14:18:10'),(603,14,100,'Going','2023-06-03 14:18:14'),(619,28,100,'Not Going','2023-06-04 17:29:20'),(620,26,100,'Going','2023-06-04 18:17:49'),(621,28,12,'Going','2023-06-04 19:01:07'),(622,24,12,'Going','2023-06-04 19:01:15'),(698,30,100,'Going','2023-06-05 11:30:29'),(780,24,100,'Going','2023-06-05 12:02:32'),(781,32,100,'Going','2023-06-05 12:21:03'),(782,34,100,'Going','2023-06-05 12:28:14'),(789,33,100,'Going','2023-06-05 14:37:15'),(791,18,12,'Going','2023-06-05 14:39:08'),(802,17,100,'Going','2023-06-05 19:01:44');
/*!40000 ALTER TABLE `event_attendees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `events` (
  `event_id` int NOT NULL AUTO_INCREMENT,
  `club_id` int DEFAULT NULL,
  `event_name` varchar(255) DEFAULT NULL,
  `event_subtitle` varchar(255) DEFAULT NULL,
  `event_date` timestamp NULL DEFAULT NULL,
  `event_time` varchar(255) DEFAULT NULL,
  `event_location` varchar(255) DEFAULT NULL,
  `event_description` text,
  `event_organizer_info` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `is_private` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`event_id`),
  KEY `club_id` (`club_id`),
  CONSTRAINT `events_ibfk_1` FOREIGN KEY (`club_id`) REFERENCES `clubs` (`club_id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events`
--

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
INSERT INTO `events` VALUES (1,1,'Sports Tournament','Battle for the Championship','2023-06-15 00:00:00','09:00 AM','Sports Stadium','Join us for an exciting sports tournament. Show your skills and compete for the championship.','For more information, contact events@sportsclub.com','2023-05-20 11:30:00',0),(2,1,'Sports Workshop','Mastering Sports Techniques','2023-06-20 00:00:00','02:00 PM','Sports Center','Learn from expert coaches and improve your sports techniques. Join our workshop and take your athletic performance to the next level.','For workshop registration, email workshops@sportsclub.com','2023-05-22 09:45:00',0),(3,2,'Basketball Tryouts','Find the Next Star Player','2023-06-10 00:00:00','02:00 PM','Basketball Court','Come showcase your basketball talent at our tryouts. We are looking for skilled players to join our team.','For tryout registration, email tryouts@basketballclub.com','2023-05-24 13:30:00',0),(4,2,'Basketball Training Session','Skills Enhancement Workshop','2023-06-18 00:00:00','04:00 PM','Basketball Court','Join our training session to enhance your basketball skills. Learn from experienced trainers and improve your game.','For more information, contact events@basketballclub.com','2023-05-26 11:45:00',0),(5,3,'Art Exhibition','Celebrating Artistic Expression','2023-06-18 00:00:00','10:00 AM','Art Gallery','Experience an extraordinary art exhibition showcasing talented artists and their captivating creations. Appreciate the beauty of artistic expression.','For more information, contact events@artclub.com','2023-05-28 12:00:00',0),(6,3,'Art Workshop','Exploring Creative Techniques','2023-06-22 00:00:00','02:00 PM','Art Studio','Unleash your creativity and explore various art techniques in our interactive workshop. Join us and create your own masterpiece.','For workshop registration, email workshops@artclub.com','2023-06-01 14:15:00',0),(7,4,'Music Concert','Melodies in Harmony','2023-06-12 00:00:00','07:00 PM','Concert Hall','Immerse yourself in the enchanting melodies of our music concert. Join us for an evening filled with captivating performances.','For ticket information, email tickets@musicclub.com','2023-06-02 16:30:00',0),(8,4,'Music Workshop','Exploring Musical Instruments','2023-06-19 00:00:00','04:00 PM','Music Studio','Discover the world of music instruments in our workshop. Learn to play different instruments and unlock your musical potential.','For workshop registration, email workshops@musicclub.com','2023-06-04 18:45:00',0),(9,5,'Photography Workshop','Mastering the Art of Photography','2023-06-20 00:00:00','02:00 PM','Photography Studio','Enhance your photography skills with our professional workshop. Learn valuable techniques and capture stunning photographs.','For workshop registration, email workshops@photographyclub.com','2023-06-06 21:00:00',0),(10,5,'Photography Exhibition','Showcasing Moments in Frames','2023-06-24 00:00:00','11:00 AM','Photography Gallery','Immerse yourself in a stunning exhibition of photography. Discover captivating moments captured by talented photographers.','For exhibition details, email exhibitions@photographyclub.com','2023-06-08 10:15:00',0),(13,7,'Dance Showcase','Rhythmic Movements','2023-06-19 00:00:00','07:00 PM','Dance Studio','Witness a captivating dance showcase featuring talented dancers. Experience the beauty and grace of various dance forms.','For ticket information, email tickets@danceclub.com','2023-06-14 18:30:00',0),(14,7,'Dance Workshop','Exploring Dance Styles','2023-06-25 00:00:00','05:00 PM','Dance Studio','Join our dance workshop and learn different dance styles. Express yourself through dance and discover your passion for movement.','For workshop registration, email workshops@danceclub.com','2023-06-16 20:45:00',0),(15,8,'Gaming Tournament','Battle in Virtual Realms','2023-06-22 00:00:00','02:00 PM','Gaming Arena','Participate in our gaming tournament and compete against skilled gamers. Test your skills and claim victory in virtual worlds.','For tournament registration, email tournaments@gamingclub.com','2023-06-18 16:00:00',0),(16,8,'Gaming Workshop','Exploring Game Development','2023-06-29 00:00:00','04:00 PM','Gaming Club','Join our gaming workshop and learn game development techniques. Create your own games and embark on a journey of creativity.','For workshop registration, email workshops@gamingclub.com','2023-06-20 18:15:00',0),(17,9,'Film Screening','Discover Cinematic Gems','2023-06-24 00:00:00','07:00 PM','Movie Theater','Experience the magic of cinema with our film screening. Explore outstanding movies and immerse yourself in captivating storytelling.','For ticket information, email tickets@filmclub.com','2023-06-22 11:30:00',0),(18,9,'Film Workshop','Unveiling Filmmaking Techniques','2023-06-30 00:00:00','03:00 PM','Film Club','Join our film workshop and learn filmmaking techniques from industry professionals. Unleash your creativity and tell compelling stories.','For workshop registration, email workshops@filmclub.com','2023-06-24 14:45:00',0),(19,10,'Cooking Class','Culinary Delights','2023-06-23 00:00:00','06:00 PM','Cooking School','Join our cooking class and learn to prepare delicious dishes. Explore different flavors and techniques in the art of cooking.','For class registration, email classes@cookingclub.com','2023-06-26 17:30:00',0),(20,10,'Food Festival','A Gastronomic Celebration','2023-06-29 00:00:00','12:00 PM','Food Park','Indulge in a food festival featuring a wide variety of culinary delights. Explore diverse cuisines and satisfy your taste buds.','For more information, contact events@cookingclub.com','2023-06-28 09:45:00',0),(24,6,' Grandmaster\'s Clash','Unleash your speed and outwit your opponents!','2023-07-10 00:00:00','14:00','Grandmaster\'s Haven Clubhouse','Prepare for an adrenaline-fueled chess experience like no other! We are thrilled to announce our upcoming Blitz Chess Tournament, titled \"Grandmaster\'s Clash.\" Test your skills in rapid-fire matches and challenge fellow chess enthusiasts to exhilarating battles of strategy and quick thinking.\n\n🏆 Tournament Format:\n\n    Time Control: 5 minutes per player, with a 3-second increment.\n    Multiple rounds followed by playoffs for the top performers.\n    Participants will be grouped by rating to ensure fair competition.\n\n📅 Date: July 10, 2023\n⏰ Time: 2:00 PM - 6:00 PM\n📍 Location: Grandmaster\'s Haven Clubhouse\n\nBring your A-game, as the stakes are high and the competition fierce. Trophies and exclusive prizes await the top performers. Don\'t miss this opportunity to showcase your speed chess prowess and make a name for yourself within the chess community.\n\nTo secure your spot in the \"Grandmaster\'s Clash\" Blitz Chess Tournament, register online at www.grandmastershaven.com/tournaments. Limited spots available, so sign up early to avoid disappointment.','This event is proudly organized by the Grandmaster\'s Haven Chess Club. For any inquiries or further information, please contact us at tournamentinfo@grandmastershaven.com or call our event hotline at (123) 456-7890.','2023-06-04 17:09:12',0),(25,6,'Chess Simultaneous Exhibition','Challenge the Mastermind','2023-08-05 00:00:00','16:00','Grandmaster\'s Haven Clubhouse','Prepare to test your skills against a chess prodigy! Join us for a thrilling Chess Simultaneous Exhibition where our resident Grandmaster will take on multiple opponents simultaneously. It\'s a rare opportunity to match wits with a mastermind. Will you be the one to outmaneuver our Grandmaster?','Limited slots available. To secure your spot, email us at events@grandmastershaven.com or call (123) 456-7890.','2023-06-04 17:10:39',0),(26,6,'Chess Strategy Workshop','Master the Art of Positional Play','2023-09-15 00:00:00','18:00','Grandmaster\'s Haven Clubhouse','Enhance your strategic thinking and positional understanding in our Chess Strategy Workshop. Led by our experienced coaches, this workshop will delve into key concepts such as pawn structures, piece coordination, and long-term planning. Open to players of all levels. ','Register online at www.grandmastershaven.com/workshops to reserve your spot.','2023-06-04 17:12:39',0),(27,6,'Chess Movie Night','Where Chess Meets Cinema','2023-10-30 00:00:00','19:00','Grandmaster\'s Haven Clubhouse','Join us for an entertaining evening of \"Chess Movie Night\" where we will be screening classic films inspired by the game of chess. Sit back, relax, and enjoy a cinematic journey that celebrates the art, drama, and intrigue of chess. Popcorn and refreshments will be provided. ','RSVP by emailing events@grandmastershaven.com or calling (123) 456-7890.','2023-06-04 17:13:39',0),(28,6,'Chess Open Day','Explore the World of Chess','2023-06-28 00:00:00','10:00','Grandmaster\'s Haven Clubhouse','Curious about chess? Join us for our Chess Open Day, a fun-filled event for players of all ages and skill levels. Engage in casual games, learn from experienced players, and participate in mini-tournaments. We\'ll also have interactive chess demonstrations and activities for children','No registration required. Just drop by and discover the wonders of the royal game!','2023-06-04 17:14:32',0),(29,6,'Test','Test','2023-06-10 00:00:00','11:11','Test, Test, Test, Test','Test','Test','2023-06-04 21:12:28',0),(30,6,'Adelaide Chess Tournament','Beginners\' Welcome!','2023-06-10 00:00:00','10:00','Room 204, Barr Smith Library, Adelaide University, North Terrace','Greetings, strategic thinkers!\nWe believe in continuous improvement, and to help you enhance your chess skills, we will be sharing weekly \"Chess Strategy Tips\" on our club\'s blog. These bite-sized insights, curated by our experienced players, will cover various aspects of the game, including:\nOpenings: Unleash your creativity and surprise your opponents.\nMiddle Game Tactics: Master the art of strategic maneuvers and positional play.\nEndgame Techniques: Polish your endgame skills and convert advantages into victories.\nStay tuned to our website here for regular updates. Whether you\'re a beginner or an advanced player, these tips will provide valuable guidance to elevate your game to new heights.\nEnjoy the journey of learning and mastering the art of chess!\nWarm regards, The Grandmaster\'s Haven Team','Entry fee: Free!\nRegistration: Sign up at the event, or email us to pre-register (details below)','2023-06-04 21:19:32',0),(31,6,'a','a','2023-12-12 00:00:00','11:01','a, a, a, a','Greetings, strategic thinkers!\nWe believe in continuous improvement, and to help you enhance your chess skills, we will be sharing weekly \"Chess Strategy Tips\" on our club\'s blog. These bite-sized insights, curated by our experienced players, will cover various aspects of the game, including:\nOpenings: Unleash your creativity and surprise your opponents.\nMiddle Game Tactics: Master the art of strategic maneuvers and positional play.\nEndgame Techniques: Polish your endgame skills and convert advantages into victories.\nStay tuned to our website here for regular updates. Whether you\'re a beginner or an advanced player, these tips will provide valuable guidance to elevate your game to new heights.\nEnjoy the journey of learning and mastering the art of chess!\nWarm regards, The Grandmaster\'s Haven Team','a','2023-06-04 21:23:30',0),(32,6,'a','a','2023-06-15 00:00:00','11:11','a, a, a, a','<p>Greetings, strategic thinkers!</p><p>We believe in continuous improvement, and to help you enhance your chess skills, we will be sharing weekly <strong>\"Chess Strategy Tips\"</strong> on our club\'s blog. These bite-sized insights, curated by our experienced players, will cover various aspects of the game, including:</p><ul><li><strong>Openings</strong>: Unleash your creativity and surprise your opponents.</li><li><strong>Middle Game Tactics</strong>: Master the art of strategic maneuvers and positional play.</li><li><strong>Endgame Techniques</strong>: Polish your endgame skills and convert advantages into victories.</li></ul><p>Stay tuned to our website <a href=\"https://www.grandmastershaven.com/strategy-tips\" rel=\"noopener noreferrer\" target=\"_blank\">here</a> for regular updates. Whether you\'re a beginner or an advanced player, these tips will provide valuable guidance to elevate your game to new heights.</p><p>Enjoy the journey of learning and mastering the art of chess!</p><p>Warm regards, The Grandmaster\'s Haven Team</p>','a','2023-06-04 21:30:28',0),(33,5,'Capture the Magic: A Night Sky Photography Workshop','Learn to photograph the celestial wonders!','2023-07-15 00:00:00','20:00','205, Braggs, 1 AAA, North Terrace','<p>Join us under the stars for a hands-on night sky photography workshop. This event will be led by renowned astrophotographer James Sullivan, who will guide participants on capturing stunning images of the starry sky and milky way. Please bring your camera, tripod, and a wide-angle lens if possible.</p>','Jane Smith, Event Coordinator, email: jane.smith@snapcaptureclub.com','2023-06-05 09:52:34',0),(34,6,'Checkmate Challenge: Chess Club Tournament','Chess Club Annual Tournament - Unleash the Grandmaster within!','2023-06-10 00:00:00','10:00','Room 204, Barr Smith Library, Adelaide University, North Terrace','<p>Hello chess enthusiasts! 🎉 Get ready for our <strong style=\"color: var(--tw-prose-bold);\">Checkmate Challenge</strong> Chess Club Tournament!🏆 Whether you\'re a <em>seasoned chess player</em> or a complete <em>beginner</em>, there\'s a place for you.</p><p>Join us in Room 204 at the Barr Smith Library 📚. Improve your skills, meet like-minded individuals, and above all, have <em>fun</em>! 🙌 So, grab your chessboard and let the games begin. <a href=\"mailto:chessclub@university.edu\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"color: var(--tw-prose-links);\">Sign up</a> today!</p>','Entry fee is free! Sign up at the event or email us at chessclub@university.edu to pre-register. We look forward to seeing you there!','2023-06-05 12:28:07',0),(35,6,'PRIVATE EVENT','a','2023-12-01 00:00:00','11:11','a, a, a, a','<p>a</p>','a','2023-06-05 16:51:34',1);
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
  `membership_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `club_id` int DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`membership_id`),
  KEY `user_id` (`user_id`),
  KEY `club_id` (`club_id`),
  CONSTRAINT `memberships_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `memberships_ibfk_2` FOREIGN KEY (`club_id`) REFERENCES `clubs` (`club_id`)
) ENGINE=InnoDB AUTO_INCREMENT=134 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `memberships`
--

LOCK TABLES `memberships` WRITE;
/*!40000 ALTER TABLE `memberships` DISABLE KEYS */;
INSERT INTO `memberships` VALUES (1,1,1,'Active','2023-05-19 10:00:00'),(2,2,1,'Active','2023-05-19 11:30:00'),(3,1,2,'Active','2023-05-20 14:30:00'),(4,3,2,'Active','2023-05-21 09:45:00'),(7,6,4,'Active','2023-05-24 13:30:00'),(9,8,5,'Active','2023-05-26 16:00:00'),(10,9,5,'Active','2023-05-27 17:15:00'),(11,10,6,'Active','2023-05-28 18:30:00'),(13,12,7,'Active','2023-05-30 21:00:00'),(14,13,7,'Active','2023-05-31 22:15:00'),(15,14,8,'Active','2023-06-01 10:30:00'),(16,15,8,'Inactive','2023-06-02 11:45:00'),(17,16,9,'Active','2023-06-03 13:00:00'),(18,17,9,'Active','2023-06-04 14:15:00'),(19,18,10,'Active','2023-06-05 15:30:00'),(21,20,1,'Active','2023-06-07 18:00:00'),(23,22,3,'Active','2023-06-09 20:30:00'),(24,23,4,'Inactive','2023-06-10 21:45:00'),(25,24,5,'Active','2023-06-11 23:00:00'),(26,25,6,'Active','2023-06-12 10:15:00'),(27,26,7,'Active','2023-06-13 11:30:00'),(28,27,8,'Active','2023-06-14 12:45:00'),(29,28,9,'Inactive','2023-06-15 14:00:00'),(30,29,10,'Active','2023-06-16 15:15:00'),(31,30,1,'Active','2023-06-17 16:30:00'),(32,31,2,'Active','2023-06-18 17:45:00'),(35,12,2,'Active','2023-06-17 11:45:00'),(36,13,3,'Inactive','2023-06-17 14:32:00'),(37,14,4,'Active','2023-06-17 15:17:00'),(38,15,5,'Active','2023-06-17 17:58:00'),(39,16,6,'Inactive','2023-06-17 19:40:00'),(40,17,7,'Active','2023-06-17 22:01:00'),(41,18,8,'Active','2023-06-17 23:30:00'),(43,20,10,'Active','2023-06-18 13:59:00'),(45,22,2,'Active','2023-06-18 17:53:00'),(46,23,3,'Active','2023-06-18 19:06:00'),(47,24,4,'Inactive','2023-06-18 21:17:00'),(48,25,5,'Active','2023-06-18 22:44:00'),(49,26,6,'Active','2023-06-19 10:55:00'),(50,27,7,'Inactive','2023-06-19 12:13:00'),(51,28,8,'Active','2023-06-19 14:27:00'),(52,29,9,'Active','2023-06-19 15:45:00'),(53,30,10,'Inactive','2023-06-19 18:03:00'),(54,31,1,'Active','2023-06-19 19:18:00'),(55,32,2,'Active','2023-06-19 20:41:00'),(57,12,4,'Active','2023-06-19 23:24:00'),(58,13,5,'Active','2023-06-20 11:38:00'),(59,14,6,'Inactive','2023-06-20 12:51:00'),(60,15,7,'Active','2023-06-20 15:06:00'),(61,16,8,'Active','2023-06-20 16:21:00'),(62,17,9,'Inactive','2023-06-20 18:35:00'),(63,18,10,'Active','2023-06-20 19:53:00'),(69,1,10,'Active',NULL),(74,100,9,'Active',NULL),(110,12,9,'Active',NULL),(132,100,6,'Active',NULL),(133,12,6,'Active',NULL);
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
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `session_id` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `expires` int unsigned NOT NULL,
  `data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  PRIMARY KEY (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES ('W2N7Gg7Gk5rn9kV7JIRGAzirY9g2ytdS',1686084263,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"secure\":false,\"httpOnly\":true,\"path\":\"/\"},\"user_id\":100,\"user\":{\"user_id\":100,\"first_name\":\"Samuel\",\"last_name\":\"Chau\",\"role\":\"Admin\",\"profile_picture\":\"file-1685847512318.jpg\",\"email\":\"chaucted@gmail.com\",\"isAdmin\":true,\"isManager\":false}}'),('p7y3TbReDtaXsmI3Z2V1y_uARzH5fD_H',1686089306,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"secure\":false,\"httpOnly\":true,\"path\":\"/\"},\"user_id\":100,\"user\":{\"user_id\":100,\"first_name\":\"Samuel\",\"last_name\":\"Chau\",\"role\":\"Admin\",\"profile_picture\":\"file-1685847512318.jpg\",\"email\":\"chaucted@gmail.com\",\"isAdmin\":true,\"isManager\":false}}');
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
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
  CONSTRAINT `user_linked_accounts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_linked_accounts`
--

LOCK TABLES `user_linked_accounts` WRITE;
/*!40000 ALTER TABLE `user_linked_accounts` DISABLE KEYS */;
INSERT INTO `user_linked_accounts` VALUES (1,1,'Facebook','example_user1','2023-05-19 10:15:00'),(2,1,'Twitter','example_user1_twitter','2023-05-19 11:30:00'),(3,2,'Facebook','example_user2','2023-05-20 10:30:00'),(4,2,'Twitter','example_user2_twitter','2023-05-20 12:00:00'),(5,3,'Facebook','example_user3','2023-05-21 09:45:00'),(6,3,'Instagram','example_user3_instagram','2023-05-21 12:15:00'),(11,6,'Twitter','example_user6_twitter','2023-05-24 09:30:00'),(12,6,'LinkedIn','example_user6_linkedin','2023-05-24 11:00:00'),(15,8,'Twitter','example_user8_twitter','2023-05-26 10:30:00'),(16,8,'LinkedIn','example_user8_linkedin','2023-05-26 12:00:00'),(17,9,'Facebook','example_user9','2023-05-27 09:45:00'),(18,9,'Twitter','example_user9_twitter','2023-05-27 11:00:00'),(19,10,'Facebook','example_user10','2023-05-28 10:00:00'),(20,10,'Instagram','example_user10_instagram','2023-05-28 11:15:00'),(23,12,'Facebook','example_user12','2023-06-17 10:30:00'),(24,12,'Twitter','example_user12_twitter','2023-06-17 12:00:00'),(25,13,'Facebook','example_user13','2023-06-17 09:45:00'),(26,13,'Reddit','example_user13_reddit','2023-06-17 11:30:00'),(27,14,'Twitter','example_user14_twitter','2023-06-17 10:00:00'),(28,14,'Meetup','example_user14_meetup','2023-06-17 11:15:00'),(29,15,'Facebook','example_user15','2023-06-17 10:30:00'),(30,15,'Reddit','example_user15_reddit','2023-06-17 12:00:00'),(31,16,'Twitter','example_user16_twitter','2023-06-17 09:45:00'),(32,16,'Reddit','example_user16_reddit','2023-06-17 11:00:00'),(33,17,'LinkedIn','example_user17_linkedin','2023-06-17 10:00:00'),(34,17,'Meetup','example_user17_meetup','2023-06-17 11:15:00'),(35,18,'Facebook','example_user18','2023-06-17 10:30:00'),(36,18,'Reddit','example_user18_reddit','2023-06-17 12:00:00'),(39,20,'LinkedIn','example_user20_linkedin','2023-06-17 10:00:00'),(40,20,'Meetup','example_user20_meetup','2023-06-17 11:15:00'),(43,22,'Twitter','example_user22_twitter','2023-06-17 10:00:00'),(44,22,'Reddit','example_user22_reddit','2023-06-17 11:15:00'),(45,23,'LinkedIn','example_user23_linkedin','2023-06-17 10:00:00'),(46,23,'Meetup','example_user23_meetup','2023-06-17 11:15:00'),(47,24,'Facebook','example_user24','2023-06-17 10:30:00'),(48,24,'Reddit','example_user24_reddit','2023-06-17 12:00:00'),(49,25,'Twitter','example_user25_twitter','2023-06-17 09:45:00'),(50,25,'Reddit','example_user25_reddit','2023-06-17 11:00:00'),(51,26,'LinkedIn','example_user26_linkedin','2023-06-17 10:00:00'),(52,26,'Meetup','example_user26_meetup','2023-06-17 11:15:00'),(53,27,'Facebook','example_user27','2023-06-17 10:15:00'),(54,27,'Reddit','example_user27_reddit','2023-06-17 11:30:00'),(55,28,'Twitter','example_user28_twitter','2023-06-17 10:00:00'),(56,28,'Meetup','example_user28_meetup','2023-06-17 11:15:00'),(57,29,'Facebook','example_user29','2023-06-17 10:30:00'),(58,29,'Reddit','example_user29_reddit','2023-06-17 12:00:00'),(59,30,'Twitter','example_user30_twitter','2023-06-17 09:45:00'),(60,30,'Reddit','example_user30_reddit','2023-06-17 11:00:00'),(61,31,'LinkedIn','example_user31_linkedin','2023-06-17 10:00:00'),(62,31,'Meetup','example_user31_meetup','2023-06-17 11:15:00'),(63,32,'Facebook','example_user32','2023-06-17 10:30:00'),(64,32,'Reddit','example_user32_reddit','2023-06-17 12:00:00');
/*!40000 ALTER TABLE `user_linked_accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `profile_picture` varchar(255) DEFAULT NULL,
  `role` enum('Admin','Member','Manager') DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'mb@e.com','password','file-1685799709056.jpg','Manager','2023-05-19 10:00:00','Menno','Brandt'),(2,'janesmith@example.com','password2','profile_pic2.png','Admin','2023-05-20 11:00:00','Jane','Smith'),(3,'emma@example.com','password3','profile_pic3.png','Manager','2023-05-21 12:00:00','Emma','Thompson'),(6,'liam@example.com','password6','profile_pic6.png','Member','2023-05-24 15:00:00','Liam','Carter'),(8,'lucas@example.com','password8','profile_pic8.png','Member','2023-05-26 17:00:00','Lucas','Wilson'),(9,'isabella@example.com','password9','profile_pic9.png','Manager','2023-05-27 18:00:00','Isabella','Anderson'),(10,'elijah@example.com','password10','profile_pic10.png','Member','2023-05-28 19:00:00','Elijah','Martinez'),(12,'oliver@example.com','password12','file-1685801267126.jpg','Member','2023-05-30 21:00:00','Oliver','Clark'),(13,'amelia@example.com','password13','profile_pic13.png','Member','2023-05-31 22:00:00','Amelia','Taylor'),(14,'aiden@example.com','password14','profile_pic14.png','Member','2023-06-01 23:00:00','Aiden','Brown'),(15,'charlotte@example.com','password15','profile_pic15.png','Member','2023-06-02 10:00:00','Charlotte','Lee'),(16,'ethan@example.com','password16','profile_pic16.png','Member','2023-06-03 11:00:00','Ethan','Garcia'),(17,'harper@example.com','password17','profile_pic17.png','Member','2023-06-04 12:00:00','Harper','Martinez'),(18,'james@example.com','password18','profile_pic18.png','Member','2023-06-05 13:00:00','James','Rodriguez'),(20,'benjamin@example.com','password20','profile_pic20.png','Member','2023-06-07 15:00:00','Benjamin','Scott'),(22,'henry@example.com','password22','profile_pic22.png','Member','2023-06-09 17:00:00','Henry','Davis'),(23,'elizabeth@example.com','password23','profile_pic23.png','Member','2023-06-10 18:00:00','Elizabeth','Lopez'),(24,'alexander@example.com','password24','profile_pic24.png','Member','2023-06-11 19:00:00','Alexander','Hall'),(25,'emily@example.com','password25','profile_pic25.png','Member','2023-06-12 20:00:00','Emily','Martinez'),(26,'sebastian@example.com','password26','profile_pic26.png','Member','2023-06-13 21:00:00','Sebastian','Hill'),(27,'scarlett@example.com','password27','profile_pic27.png','Member','2023-06-14 22:00:00','Scarlett','King'),(28,'jack@example.com','password28','profile_pic28.png','Member','2023-06-15 23:00:00','Jack','Turner'),(29,'avery@example.com','password29','profile_pic29.png','Member','2023-06-16 10:00:00','Avery','Hernandez'),(30,'michael@example.com','password30','profile_pic30.png','Member','2023-06-17 11:00:00','Michael','Young'),(31,'evelyn@example.com','password31','profile_pic31.png','Member','2023-06-18 12:00:00','Evelyn','Collins'),(32,'daniel@example.com','password32','profile_pic32.png','Member','2023-06-19 13:00:00','Daniel','Adams'),(100,'chaucted@gmail.com','kusabimaru','file-1685847512318.jpg','Admin','2023-05-31 23:13:10','Samuel','Chau'),(101,'chaucte.com','kusabimaru',NULL,'Member','2023-06-05 08:13:39','Example','e'),(102,'sam@gmail.com','',NULL,'Member','2023-06-05 08:42:49','',''),(103,'saM@gmasdil.com','password','file-1685954699293.png','Member','2023-06-05 08:44:33','Samuel','Bruh'),(104,'mb@example.com','iamadmin',NULL,'Member','2023-06-05 08:58:36','Menno','Brandt');
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

-- Dump completed on 2023-06-05 22:09:31
