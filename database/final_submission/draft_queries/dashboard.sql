-- Query 1: GetUserClubNames
-- This query fetches all the clubs that a user is a member of from the `clubs` and `memberships` tables.
SELECT
    clubs.club_name,
    clubs.club_id,
    clubs.club_logo
FROM
    clubs
INNER JOIN
    memberships
ON
    clubs.club_id = memberships.club_id
WHERE
    memberships.user_id = ?
ORDER BY
    clubs.club_name ASC;

-- Query 2: GetUserClubUpdates
-- This query fetches all the updates of the clubs where the user is a member.
SELECT
    club_updates.*,
    users.first_name,
    users.last_name,
    clubs.club_name,
    clubs.club_id
FROM
    club_updates
INNER JOIN
    users
ON
    club_updates.user_id = users.user_id
INNER JOIN
    memberships
ON
    club_updates.club_id = memberships.club_id
INNER JOIN
    clubs
ON
    club_updates.club_id = clubs.club_id
WHERE
    memberships.user_id = ?
ORDER BY
    club_updates.update_date DESC;

-- Query 3: GetUserClubEvents
-- This query fetches all the events of the clubs where the user is a member.
SELECT
    events.event_id,
    events.event_name,
    events.event_date,
    events.event_time
FROM
    events
INNER JOIN
    memberships
ON
    events.club_id = memberships.club_id
WHERE
    memberships.user_id = ?
ORDER BY
    events.event_date ASC;

-- Query 4: GetUserClubEventsAttending
-- This query fetches all the events the user is attending.
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

-- Query 5: GetUserDetails
-- This query fetches the user details from the `users` table.
SELECT * FROM users WHERE user_id = ?;