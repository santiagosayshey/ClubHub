-- This query is used to fetch all details about a specific user from the users table.
SELECT * FROM users
WHERE user_id = ?;

-- This query is used to update a club's banner in the clubs table.
-- It targets a specific club to alter the club_banner field.
UPDATE clubs
SET club_banner = ?
WHERE club_id = ?;

-- This query is used to update a club's logo in the clubs table.
-- It targets a specific club to alter the club_logo field.
UPDATE clubs
SET club_logo = ?
WHERE club_id = ?;

-- This query is used to fetch all details about a specific club from the clubs table.
SELECT
clubs.club_id,
clubs.club_name,
clubs.club_logo,
clubs.club_banner,
clubs.club_description,
clubs.contact_information,
clubs.social_media_links,
DATE_FORMAT(clubs.created_at, '%d/%m/%Y') as created_at
FROM
clubs
WHERE
clubs.club_id = ?;

-- This query is used to fetch the updates of a specific club,
-- along with the names of the users who made those updates.
SELECT
club_updates.*,
users.first_name,
users.last_name
FROM
club_updates
INNER JOIN
users
ON
club_updates.user_id = users.user_id
WHERE
club_updates.club_id = ?
ORDER BY
club_updates.update_date DESC;

-- This query is used to fetch the events of a specific club.
SELECT
events.event_id,
events.event_name,
events.event_subtitle,
events.event_date,
events.event_time,
events.event_location,
events.event_description,
events.event_organizer_info,
events.created_at
FROM
events
WHERE
events.club_id = ?
ORDER BY
events.event_date ASC;

-- This query is used to count the number of active members in a specific club.
SELECT
COUNT(*) AS totalMembers
FROM
memberships
WHERE
club_id = ? AND
status = 'Active';

-- This query is used to fetch the membership details of a user in a specific club.
SELECT
memberships.membership_id,
memberships.user_id,
memberships.club_id,
memberships.status,
memberships.created_at
FROM
memberships
WHERE
memberships.club_id = ? AND
memberships.user_id = ?;

-- This query is used to either create a new membership or update an existing one.
-- It targets a specific user within a specific club to alter the status field.
INSERT INTO memberships(user_id, club_id, status)
VALUES (?, ?, ?)
ON DUPLICATE KEY UPDATE status = VALUES(status);

-- This query is used to fetch the events that a specific user is attending.
SELECT
events.event_id,
event_attendees.rsvp_status
FROM
events
INNER JOIN
event_attendees
ON
events.event_id = event_attendees.event_id
WHERE
event_attendees.user_id = ? AND
event_attendees.rsvp_status = 'Going';

-- This query is used to fetch the managers of a specific club.
SELECT
users.user_id,
users.first_name,
users.last_name,
users.email
FROM
memberships
INNER JOIN
users
ON
memberships.user_id = users.user_id
WHERE
memberships.club_id = ? AND
memberships.role = 'Manager';

-- This query is used to fetch the opt-in status of a user for a specific club.
SELECT opt_in_update, opt_in_event
FROM memberships
WHERE user_id = ? AND club_id = ?;

-- This query is used to delete a specific update from a specific club in the club_updates table.
DELETE FROM club_updates
WHERE club_id = ? AND update_id = ?;

-- This query is used to delete a specific event from a specific club in the events table.
DELETE FROM events
WHERE club_id = ? AND event_id = ?;

-- This query is used to insert a new event into the events table for a specific club.
-- It records various event details like name, subtitle, date, time, location, description, and organizer info.
INSERT INTO events (club_id, event_name, event_subtitle, event_date, event_time, event_location, event_description, event_organizer_info, is_private, created_at)
VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, NOW());

-- This query fetches all the members of a specific club who have opted to receive email notifications for events.
-- The members' emails and the club name are returned.
SELECT users.email, clubs.club_name
FROM users
INNER JOIN memberships ON memberships.user_id = users.user_id
INNER JOIN clubs ON clubs.club_id = memberships.club_id
WHERE memberships.club_id = ? AND memberships.opt_in_event = 1;

-- This query is used to remove a user's membership from a specific club in the memberships table.
DELETE FROM memberships
WHERE user_id = ? AND club_id = ?;

-- This query will update the opt_in_update field for a particular user in the memberships table.
-- The opt_in_update field determines if the user wants to receive update emails or not.
UPDATE memberships SET opt_in_update = ? WHERE club_id = ? AND user_id = ?;

-- This query will update the opt_in_event field for a particular user in the memberships table.
-- The opt_in_event field determines if the user wants to receive event emails or not.
UPDATE memberships SET opt_in_event = ? WHERE club_id = ? AND user_id = ?;

-- This query fetches all the details of a particular club from the clubs table using its ID.
SELECT * FROM clubs WHERE clubs.club_id = ?;

-- This query fetches all active members of a particular club from the users and memberships tables.
SELECT
users.user_id,
users.first_name,
users.last_name,
users.email,
users.profile_picture,
memberships.role
FROM users
INNER JOIN memberships ON users.user_id = memberships.user_id
WHERE memberships.club_id = ?
AND memberships.status = 'active'
ORDER BY CASE
WHEN memberships.role = 'manager' THEN 1
ELSE 2
END;

-- This query updates the details of a club including its name, description, contact info, and social media links.
UPDATE clubs SET club_name = ?, club_description = ?, contact_information = ?, social_media_links = ? WHERE club_id = ?;

-- This query inserts a new update post into the club_updates table for a specific club.
INSERT INTO club_updates(club_id, update_title, update_preview_content, update_content, update_date, user_id, is_private, created_at) VALUES (?, ?, ?, ?, NOW(), ?, ?, NOW());

-- This query fetches all members who have opted in to receive updates from a club.
SELECT users.email, clubs.club_name
FROM users
INNER JOIN memberships ON memberships.user_id = users.user_id
INNER JOIN clubs ON clubs.club_id = memberships.club_id
WHERE memberships.club_id = ? AND memberships.opt_in_update = 1;