-- queries.sql
-- This file contains the SQL queries used in the application

-- Named Query: Get User by Email
-- Used in: GET '/' endpoint and POST '/authenticate' endpoint
-- Purpose: This query is used to fetch user information based on the provided email address.
SELECT * FROM users WHERE email = ?;

-- Named Query: Check User by Email
-- Used in: POST '/create' endpoint and GoogleStrategy
-- Purpose: This query is used to check if a user already exists in the database with the provided email address.
SELECT user_id FROM users WHERE email = ?;

-- Named Query: Create User
-- Used in: POST '/create' endpoint and GoogleStrategy
-- Purpose: This query is used to insert a new user's details into the users table.
INSERT INTO users (first_name, last_name, email, password, role, created_at) VALUES (?, ?, ?, ?, ?, ?);

-- Named Query: Create OAuth User
-- Used in: GoogleStrategy
-- Purpose: This query is used to insert a new OAuth user's details into the users table.
INSERT INTO users (first_name, last_name, email, role, created_at, is_oauth_user) VALUES (?, ?, ?, ?, ?, TRUE);
