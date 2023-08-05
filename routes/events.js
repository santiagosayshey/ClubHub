const express = require('express');
const router = express.Router();

var queryEvent = `
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
`;

var queryAttendeesCount = `
SELECT
    COUNT(*) AS attendee_count
FROM
    event_attendees
WHERE
    event_attendees.event_id = ?
AND
    event_attendees.rsvp_status = 'Going';
`;

var queryRsvpStatus = `
SELECT
    rsvp_status
FROM
    event_attendees
WHERE
    event_id = ? AND user_id = ?;
`;

// Club Managers Query
const clubManagersQuery = `
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
`;

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

router.post('/:id/rsvp', (req, res) => {
    if (!req.session.user) {
        res.sendStatus(401);
        return;
    }

    const { user } = req.session;
    const eventID = req.params.id;
    const { rsvpStatus } = req.body;

    req.pool.getConnection(function (err, connection) {
        if (err) {
            console.error('Failed to get DB connection', err);
            res.sendStatus(500);
            return;
        }

        var query = `
            INSERT INTO event_attendees (event_id, user_id, rsvp_status)
            VALUES (?, ?, ?)
            ON DUPLICATE KEY UPDATE rsvp_status = VALUES(rsvp_status);
        `;

        connection.query(query, [eventID, user.user_id, rsvpStatus], function (queryErr, result) {
            if (queryErr) {
                console.error('Failed to execute query', queryErr);
                connection.release();
                res.sendStatus(500);
                return;
            }

            connection.query(queryAttendeesCount, [eventID], function (queryErr, attendeeCount) {
                connection.release();
                if (queryErr) {
                    console.error('Failed to execute query', queryErr);
                    res.sendStatus(500);
                    return;
                }

                res.json({ attendeeCount: attendeeCount[0].attendee_count });
            });
        });
    });
});

router.get('/:id/attendees', (req, res) => {
    const eventID = req.params.id;
    req.pool.getConnection(function (err, connection) {
        if (err) {
            res.sendStatus(500);
            return;
        }

        var query = `
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
        `;

        connection.query(query, [eventID], function (queryErr, rows, fields) {
            connection.release();
            if (queryErr) {
                res.sendStatus(500);
                return;
            }
            res.json(rows);
        });
    });
});

router.get('/:id', (req, res) => {
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
                        message: 'Your account has been disabled',
                    });
                    return;
                }
                proceedWithEvent(req, res);
            });
        });
    } else {
        res.redirect('/login');
    }
});


function proceedWithEvent(req, res) {
    const { user } = req.session;
    const eventID = req.params.id;

    req.pool.getConnection(function (err, connection) {
        if (err) {
            res.sendStatus(500);
            return;
        }

        connection.query(queryEvent, [eventID], function (queryErr, eventDetails) {
            if (queryErr) {
                connection.release();
                res.sendStatus(500);
                return;
            }

            if (!eventDetails || eventDetails.length === 0) {
                res.render("pages/error.ejs", {
                    title: "Error",
                    message: "Event not found!",
                    user
                });
                return;
            }

            // Format the event date
            eventDetails[0].event_date = getFormattedDate(new Date(eventDetails[0].event_date));

            connection.query(queryAttendeesCount, [eventID], function (queryErr, attendeeCount) {
                if (queryErr) {
                    connection.release();
                    res.sendStatus(500);
                    return;
                }

                connection.query(queryRsvpStatus, [eventID, user.user_id], function (queryErr, rsvpStatus) {
                    if (queryErr) {
                        res.sendStatus(500);
                        return;
                    }

                    // Fetch club_id for the given event
                    const clubID = eventDetails[0].club_id;

                    connection.query(clubManagersQuery, [clubID], function(err, clubManagers) {
                        connection.release();

                        if (err) {
                            res.sendStatus(500);
                            return;
                        }

                        user.rsvp_status = rsvpStatus[0]?.rsvp_status || 'Not Going'
                        res.render("pages/events/index.ejs", {
                            title: "Event",
                            scriptPath: "static/js/pages/events/index.js",
                            eventDetails: eventDetails[0],
                            attendeeCount: attendeeCount[0].attendee_count,
                            user,
                            clubManagers
                        });
                    });
                });
            });
        });
    });
}

module.exports = router;