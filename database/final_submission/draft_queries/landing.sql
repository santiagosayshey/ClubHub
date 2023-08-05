-- Query: getSelectedClubs
-- This query fetches all details of selected clubs, ordered randomly.
SELECT *
FROM clubs
WHERE clubs.club_name IN ('Grandmaster Lodge', 'Snap Capture Photography Club', 'One Minute Film Club', 'Pixel Pioneers', 'Rhythm Alliance', "Wordsmiths' Guild")
ORDER BY RAND();

-- Query: getPublicClubUpdates
-- This query fetches all public updates from selected clubs, ordered randomly.
-- The update details are fetched from the club_updates table and associated with their respective clubs.
SELECT clubs.club_name, club_updates.*
FROM clubs
LEFT JOIN club_updates ON clubs.club_id = club_updates.club_id
WHERE clubs.club_name IN ('Grandmaster Lodge', 'Snap Capture Photography Club', 'One Minute Film Club', 'Pixel Pioneers', 'Rhythm Alliance', "Wordsmiths' Guild")
AND club_updates.is_private = false
ORDER BY RAND();

-- Query: getPublicClubEvents
-- This query fetches all public events from selected clubs, ordered randomly.
-- The event details are fetched from the events table and associated with their respective clubs.
SELECT clubs.club_name, events.*
FROM clubs
LEFT JOIN events ON clubs.club_id = events.club_id
WHERE clubs.club_name IN ('Grandmaster Lodge', 'Snap Capture Photography Club', 'One Minute Film Club', 'Pixel Pioneers', 'Rhythm Alliance', "Wordsmiths' Guild")
AND events.is_private = false
ORDER BY RAND();
