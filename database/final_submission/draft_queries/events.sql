-- Query: getEventDetails
-- This query fetches the details of a specific event by event_id.
-- It includes fields from the events table and the associated club's name and id from the clubs table.
SELECT
    events.event_id,
    events.event_name,
    events.event_description,
    events.event_location,
    events.event_date,
    events.event_time,
    events.event_organizer_info,
    clubs.club_name,
    clubs.club_id
FROM
    events
INNER JOIN
    clubs
ON
    events.club_id = clubs.club_id
WHERE
    events.event_id = ?;

-- Query: getAttendeeCount
-- This query gets the count of attendees who have RSVPed as 'Going' to a specific event by event_id.
SELECT
    COUNT(*) AS attendee_count
FROM
    event_attendees
WHERE
    event_attendees.event_id = ?
AND
    event_attendees.rsvp_status = 'Going';

-- Query: getUserRsvpStatus
-- This query fetches the RSVP status of a specific user for a specific event.
SELECT
    rsvp_status
FROM
    event_attendees
WHERE
    event_id = ? AND user_id = ?;

-- Query: getClubManagers
-- This query fetches the user details for all managers of a specific club by club_id.
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
    memberships.role = 'Manager'

-- Query: rsvpEvent
-- This query either inserts or updates the RSVP status for a user at a specific event.
-- It uses the ON DUPLICATE KEY UPDATE feature of MySQL to perform an UPSERT operation.
INSERT INTO event_attendees (event_id, user_id, rsvp_status)
VALUES (?, ?, ?)
ON DUPLICATE KEY UPDATE rsvp_status = VALUES(rsvp_status);

-- Query: getEventAttendees
-- This query gets the list of all attendees, along with their details and RSVP status, for a specific event.
SELECT
    users.user_id,
    users.first_name,
    users.last_name,
    users.email,
    users.profile_picture,
    users.role,
    event_attendees.rsvp_status
FROM
    event_attendees
INNER JOIN
    users
ON
    event_attendees.user_id = users.user_id
WHERE
    event_attendees.event_id = ?;