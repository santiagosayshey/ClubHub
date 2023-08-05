CREATE DATABASE clubhub;

USE clubhub;

CREATE TABLE club_interests (
  club_interest_id INT PRIMARY KEY AUTO_INCREMENT,
  club_id INT NOT NULL,
  interest_id INT NOT NULL,
  created_at DATETIME NOT NULL
);

CREATE TABLE club_updates (
  update_id INT PRIMARY KEY AUTO_INCREMENT,
  club_id INT,
  user_id INT,
  update_title VARCHAR(255),
  update_preview_content VARCHAR(255),
  update_content MEDIUMTEXT,
  update_date TIMESTAMP,
  created_at TIMESTAMP,
  is_private TINYINT(1) DEFAULT 0
);

CREATE TABLE clubs (
  club_id INT PRIMARY KEY AUTO_INCREMENT,
  club_name VARCHAR(255),
  club_logo VARCHAR(255),
  club_banner VARCHAR(255),
  club_description TEXT,
  contact_information VARCHAR(255),
  social_media_links VARCHAR(255),
  created_at TIMESTAMP
);

CREATE TABLE event_attendees (
  event_attendee_id INT PRIMARY KEY AUTO_INCREMENT,
  event_id INT,
  user_id INT,
  rsvp_status ENUM('Going','Not Going') NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE events (
  event_id INT PRIMARY KEY AUTO_INCREMENT,
  club_id INT,
  event_name VARCHAR(255),
  event_subtitle VARCHAR(255),
  event_date TIMESTAMP,
  event_time VARCHAR(255),
  event_location VARCHAR(255),
  event_description TEXT,
  event_organizer_info VARCHAR(255),
  created_at TIMESTAMP,
  is_private TINYINT(1) DEFAULT 0
);

CREATE TABLE interests (
  interest_id INT PRIMARY KEY AUTO_INCREMENT,
  interest_name VARCHAR(255) NOT NULL,
  created_at DATETIME NOT NULL
);

CREATE TABLE memberships (
  membership_id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT,
  club_id INT,
  status VARCHAR(255),
  created_at TIMESTAMP,
  role ENUM('Member','Manager') DEFAULT 'Member',
  opt_in_update TINYINT(1) DEFAULT 0,
  opt_in_event TINYINT(1) DEFAULT 0
);

-- no need to create this as its automatically generated
/* CREATE TABLE sessions (
  session_id VARCHAR(128) PRIMARY KEY,
  expires INT UNSIGNED NOT NULL,
  data MEDIUMTEXT
); */


CREATE TABLE users (
  user_id INT PRIMARY KEY AUTO_INCREMENT,
  email VARCHAR(255) UNIQUE,
  password VARCHAR(255),
  profile_picture VARCHAR(255),
  role ENUM('Admin','Member'),
  created_at TIMESTAMP,
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  is_oauth_user TINYINT(1) DEFAULT 0,
  status VARCHAR(255) DEFAULT 'Active'
);