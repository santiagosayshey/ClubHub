-- Query 1: GetAllClubs
-- This query fetches all the clubs from the `clubs` table ordered by club name.
SELECT * FROM clubs ORDER BY clubs.club_name ASC;

-- Query 2: GetAllClubInterests
-- This query fetches all the interests of all clubs from the `club_interests` and `interests` tables.
SELECT club_interests.club_id, interests.interest_name FROM club_interests JOIN interests ON club_interests.interest_id = interests.interest_id ORDER BY interests.interest_name ASC;

-- Query 3: SearchClubsByName
-- This query searches for clubs by club name.
SELECT * FROM clubs WHERE club_name LIKE ? ORDER BY club_name ASC;

-- Query 4: GetAllInterests
-- This query fetches all the interests from the `interests` table ordered by interest name.
SELECT * FROM interests ORDER BY interest_name ASC;

-- Query 5: InsertNewClub
-- This query inserts a new club into the `clubs` table.
INSERT INTO clubs (club_name, club_description, contact_information, social_media_links, created_at)
VALUES (?, ?, ?, ?, NOW());

-- Query 6: InsertNewClubManager
-- This query inserts a new manager into the `memberships` table for a specific club.
INSERT INTO memberships (user_id, club_id, status, role, created_at)
VALUES (?, ?, 'Active', 'Manager', NOW());

-- Query 7: InsertNewClubInterests
-- This query inserts new club interests into the `club_interests` table.
INSERT INTO club_interests (club_id, interest_id, created_at)
VALUES (?, ?, NOW());

-- Query 8: GetUserDetails
-- This query fetches the user details from the `users` table.
SELECT * FROM users WHERE user_id = ?;