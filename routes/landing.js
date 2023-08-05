// routes/landing.js

const express = require('express');
const router = express.Router();

const queryClubs = `
SELECT *
FROM clubs
WHERE clubs.club_name IN ('Grandmaster Lodge', 'Snap Capture Photography Club', 'One Minute Film Club', 'Pixel Pioneers', 'Rhythm Alliance', "Wordsmiths' Guild")
ORDER BY RAND();
`;

const queryUpdates = `
SELECT clubs.club_name, club_updates.*
FROM clubs
LEFT JOIN club_updates ON clubs.club_id = club_updates.club_id
WHERE clubs.club_name IN ('Grandmaster Lodge', 'Snap Capture Photography Club', 'One Minute Film Club', 'Pixel Pioneers', 'Rhythm Alliance', "Wordsmiths' Guild")
AND club_updates.is_private = false
ORDER BY RAND();
`;

const queryEvents = `
SELECT clubs.club_name, events.*
FROM clubs
LEFT JOIN events ON clubs.club_id = events.club_id
WHERE clubs.club_name IN ('Grandmaster Lodge', 'Snap Capture Photography Club', 'One Minute Film Club', 'Pixel Pioneers', 'Rhythm Alliance', "Wordsmiths' Guild")
AND events.is_private = false
ORDER BY RAND();
`;


router.get('/', (req, res) => {
    if (req.session.user) {
        res.redirect('/dashboard');
        return;
    }

    req.pool.getConnection(function(err, connection) {
        if (err) {
            console.error('Failed to get database connection:', err);
            res.sendStatus(500);
            return;
        }

        // Query for club details
        connection.query(queryClubs, function(err, clubData) {
            if (err) {
                console.error('Failed to query clubs:', err);
                connection.release();
                res.sendStatus(500);
                return;
            }

            // Query for updates
            connection.query(queryUpdates, function(err, updateData) {
                if (err) {
                    console.error('Failed to query updates:', err);
                    connection.release();
                    res.sendStatus(500);
                    return;
                }

                // Query for events
                connection.query(queryEvents, function(err, eventData) {
                    if (err) {
                        console.error('Failed to query events:', err);
                        connection.release();
                        res.sendStatus(500);
                        return;
                    }

                    // Render the page with all the required data
                    res.render("pages/landing/index.ejs", {
                        title: "Home",
                        clubData,
                        updateData,
                        eventData
                    });

                    // Release connection
                    connection.release();
                });
            });
        });
    });
});


module.exports = router;


