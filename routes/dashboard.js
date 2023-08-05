const express = require('express');
const router = express.Router();

// Dashboard data
const clubNamesQuery = `
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
`;

const clubUpdatesQuery = `
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
    club_updates.update_date DESC
`;

const clubEventsQuery = `
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
    events.event_date ASC
`;

const clubEventsAttendingQuery = `
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
    event_attendees.rsvp_status = 'Going'
`;

// Helper functions
function getTimeStatement(date) {
    const timeDifference = new Date() - date;
    const secondsAgo = Math.floor(timeDifference / 1000);
    const minutesAgo = Math.floor(secondsAgo / 60);
    const hoursAgo = Math.floor(minutesAgo / 60);
    const daysAgo = Math.floor(hoursAgo / 24);
    let timeStatement = '';

    if (secondsAgo < 60) {
        timeStatement = secondsAgo === 1 ? '1 second ago' : `${secondsAgo} seconds ago`;
    } else if (minutesAgo < 60) {
        timeStatement = minutesAgo === 1 ? '1 minute ago' : `${minutesAgo} minutes ago`;
    } else if (hoursAgo < 24) {
        timeStatement = hoursAgo === 1 ? '1 hour ago' : `${hoursAgo} hours ago`;
    } else {
        timeStatement = daysAgo === 1 ? '1 day ago' : `${daysAgo} days ago`;
    }

    return timeStatement;
}

function getFormattedDate(date) {
    const dd = String(date.getDate()).padStart(2, '0');
    const mm = String(date.getMonth() + 1).padStart(2, '0'); // January is 0!
    const yy = String(date.getFullYear()).substring(2);

    return dd + '/' + mm + '/' + yy;
}

function proceedWithDashboard(req, res, next) {
    const { user } = req.session;

    req.pool.getConnection(function (err, connection) {
        if (err) {
            res.sendStatus(500);
            return;
        }

        connection.query(clubNamesQuery, [user.user_id], function (err, clubDetails) {
            if (err) {
                connection.release();
                res.sendStatus(500);
                return;
            }

            connection.query(clubUpdatesQuery, [user.user_id], function (err, updateDetails) {
                if (err) {
                    connection.release();
                    res.sendStatus(500);
                    return;
                }

                for (let i = 0; i < updateDetails.length; i++) {
                    updateDetails[i].timeStatement = getTimeStatement(new Date(updateDetails[i].created_at));
                }

                connection.query(clubEventsQuery, [user.user_id], function (err, eventDetails) {

                    if (err) {
                        connection.release();
                        res.sendStatus(500);
                        return;
                    }

                    for (let i = 0; i < eventDetails.length; i++) {
                        eventDetails[i].formattedDate = getFormattedDate(new Date(eventDetails[i].event_date));
                    }

                    // Add a new query here to get events that the user is attending
                    connection.query(clubEventsAttendingQuery, [user.user_id], function(err, eventsAttending) {

                        if (err) {
                            res.sendStatus(500);
                            return;
                        }

                        // Convert the array of events to a Set for efficient lookups
                        const attendingEventIds = new Set(eventsAttending.map((event) => event.event_id));

                        // Add a new "isAttending" property to each event
                        for (let i = 0; i < eventDetails.length; i++) {
                            eventDetails[i].isAttending = attendingEventIds.has(eventDetails[i].event_id);
                        }

                        res.render("pages/dashboard/index.ejs", {
                            title: "Dashboard",
                            user,
                            scriptPath: "static/js/pages/dashboard/index.js",
                            clubDetails,
                            updateDetails,
                            eventDetails
                        });

                        connection.release();

                    });
                });
            });
        });
    });
}


router.get('/', (req, res, next) => {
    if (req.session && req.session.user_id) {
        const query = 'SELECT * FROM users WHERE user_id = ?';
        req.pool.getConnection((err, connection) => {
            if (err) {
                next(err);
                return;
            }
            connection.query(query, [req.session.user_id], (queryErr, rows) => {
                connection.release();

                if (queryErr) {
                    next(queryErr);
                    return;
                }

                const user = rows[0];

                if (user && user.status === 'Inactive') {
                    res.render('pages/error', {
                        title: 'Error!',
                        message: 'Your account has been disabled'
                    });
                    return;
                }
                proceedWithDashboard(req, res, next);
            });
        });
    } else {
        res.redirect('/login');
    }
});

module.exports = router;
