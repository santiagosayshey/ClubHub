const express = require('express');
const router = express.Router();
const path = require('path');
const upload = require('../middleware/upload');
const fs = require('fs');
const striptags = require('striptags'); // Require the module at the top of your file

// Club Details Query
const clubDetailsQuery = `
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
`;

// Club Updates Query
const clubUpdatesQuery = `
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
`;

// Club Events Query
const clubEventsQuery = `
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
`;

const clubMembersCountQuery = `
SELECT
    COUNT(*) AS totalMembers
FROM
    memberships
WHERE
    club_id = ? AND
    status = 'Active';
`;

// Club Membership Query
const clubMembershipQuery = `
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
`;

// Update Membership Status Query
const updateMembershipQuery = `
INSERT INTO memberships(user_id, club_id, status) VALUES (?, ?, ?)
ON DUPLICATE KEY UPDATE status = VALUES(status);
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

router.post('/:id/email/update', (req, res) => {
    const clubID = req.params.id;
    const { opt_in_update } = req.body; // Assuming opt_in_update is passed in the request body

    const sqlQuery = `UPDATE memberships SET opt_in_update = ? WHERE club_id = ? AND user_id = ?`;

    req.pool.getConnection((err, connection) => {
        if (err) {
            console.error('Database connection error:', err);
            res.sendStatus(500);
            return;
        }

        connection.query(sqlQuery, [opt_in_update, clubID, req.session.user.user_id], (queryErr, result) => {
            connection.release();

            if (queryErr) {
                console.error('Database query error:', queryErr);
                res.sendStatus(500);
                return;
            }

            res.sendStatus(200);
        });
    });
});

router.post('/:id/email/event', (req, res) => {
    const clubID = req.params.id;
    const { opt_in_event } = req.body; // Assuming opt_in_event is passed in the request body

    const sqlQuery = `UPDATE memberships SET opt_in_event = ? WHERE club_id = ? AND user_id = ?`;

    req.pool.getConnection((err, connection) => {
        if (err) {
            console.error('Database connection error:', err);
            res.sendStatus(500);
            return;
        }

        connection.query(sqlQuery, [opt_in_event, clubID, req.session.user.user_id], (queryErr, result) => {
            connection.release();

            if (queryErr) {
                console.error('Database query error:', queryErr);
                res.sendStatus(500);
                return;
            }

            res.sendStatus(200);
        });
    });
});

router.get('/:id/getDetails', (req, res) => {
    const clubID = req.params.id; // Assuming clubID is passed as a parameter in the request

    const sqlQuery = `SELECT * FROM clubs WHERE clubs.club_id = ?`;

    req.pool.getConnection((err, connection) => {
      if (err) {
        console.error('Database connection error:', err);
        res.sendStatus(500);
        return;
      }

      connection.query(sqlQuery, [clubID], (queryErr, result) => {
        connection.release();

        if (queryErr) {
          console.error('Database query error:', queryErr);
          res.sendStatus(500);
          return;
        }

        const club = result[0]; // Assuming you expect only one club to be returned

        if (!club) {
          console.error('Club not found');
          res.sendStatus(404);
          return;
        }

        const clubInfo = {
          club_id: club.club_id,
          club_name: club.club_name,
          club_logo: club.club_logo,
          club_banner: club.club_banner,
          club_description: club.club_description,
          contact_information: club.contact_information,
          social_media_links: club.social_media_links,
        };

        res.status(200).json({ club: clubInfo });
      });
    });
  });

router.get('/:id/members', (req, res) => {
    const clubID = req.params.id; // Assuming clubID is passed as a parameter in the request

    const clubMembersQuery = `
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
`;

    req.pool.getConnection((err, connection) => {
        if (err) {
            console.error('Database connection error:', err);
            res.sendStatus(500);
            return;
        }

        connection.query(clubMembersQuery, [clubID], (queryErr, results) => {
            connection.release();

            if (queryErr) {
                console.error('Database query error:', queryErr);
                res.sendStatus(500);
                return;
            }

            // Assuming you expect multiple members to be returned
            const members = results.map(result => ({
                user_id: result.user_id,
                first_name: result.first_name,
                last_name: result.last_name,
                email: result.email,
                profile_picture: result.profile_picture,
                role: result.role
            }));

            if (!members.length) {
                console.error('No active members found for this club');
                res.sendStatus(404);
                return;
            }

            res.status(200).json({ members });
        });
    });
});

router.post('/:id/updateDetails', (req, res) => {
    let { name, description, contact, links } = req.body;
    const clubId = req.params.id;

    // Sanitize description field
    description = req.sanitizeHTML(description);

    const sqlUpdate = 'UPDATE clubs SET club_name = ?, club_description = ?, contact_information = ?, social_media_links = ? WHERE club_id = ?';
    const values = [name, description, contact, links, clubId];

    req.pool.getConnection((err, connection) => {
        if (err) {
            console.error('Database connection error:', err);
            res.sendStatus(500);
            return;
        }

        connection.query(sqlUpdate, values, (queryErr, result) => {
            connection.release();

            if (queryErr) {
                console.error('Database query error:', queryErr);
                res.sendStatus(500);
                return;
            }

            res.status(200).json({ message: 'Club details updated successfully' });
        });
    });
});

router.post('/:id/postUpdate', (req, res) => {
    if (!req.session.user) {
        res.sendStatus(401); // Unauthorized
        return;
    }

    let { title, content, private } = req.body;
    const previewContent = 'no';
    const clubID = req.params.id;
    const userID = req.session.user.user_id;  // User's ID from session

    // Sanitize content field
    content = req.sanitizeHTML(content);

    const sql = `
      INSERT INTO club_updates(club_id, update_title, update_preview_content, update_content, update_date, user_id, is_private, created_at)
      VALUES (?, ?, ?, ?, NOW(), ?, ?, NOW());
    `;

    req.pool.getConnection(function (err, connection) {
        if (err) {
            console.error(`Error getting DB connection: ${err}`);
            res.sendStatus(500);
            return;
        }

        connection.query(sql, [clubID, title, previewContent, content, userID, private], function (err) {  // Include userID in the query
            if (err) {
                connection.release();
                res.sendStatus(500);
                return;
            }

            // Fetch all members who have opted in to emails
            const fetchMembersSql = `
                SELECT users.email, clubs.club_name
                FROM users
                INNER JOIN memberships ON memberships.user_id = users.user_id
                INNER JOIN clubs ON clubs.club_id = memberships.club_id
                WHERE memberships.club_id = ? AND memberships.opt_in_update = 1
            `;

            connection.query(fetchMembersSql, [clubID], function (err, results) {
                connection.release();
                if (err) {
                    console.error(`Error fetching members: ${err}`);
                    res.sendStatus(500);
                    return;
                }

                if (results.length === 0) {
                    res.sendStatus(200);
                    return;
                }

                // Create comma-separated list of emails
                const emails = results.map(result => result.email).join(',');
                const clubName = results[0]?.club_name || 'Club'; // Use the club name if available, default to 'Club'

                // Convert HTML content to plain text
                const plainTextContent = striptags(content);

                // Setup email data
                let mailOptions = {
                    from: 'clubhub440@gmail.com', // sender address
                    to: emails, // list of receivers
                    subject: `New Update From ${clubName} - ${title}`, // Subject line
                    text: plainTextContent // plain text body
                };

                // Send the email
                req.transporter.sendMail(mailOptions, (error, info) => {
                    if (error) {
                        return;
                    }
                });

                res.sendStatus(200);
            });
        });
    });
});

router.delete('/:clubId/post/:postId', (req, res) => {
    if (!req.session.user) {
        res.sendStatus(401); // Unauthorized
        return;
    }

    const { clubId, postId } = req.params;

    const sql = `
      DELETE FROM club_updates
      WHERE club_id = ? AND update_id = ?;
    `;

    req.pool.getConnection(function (err, connection) {
        if (err) {
            console.error(`Error getting DB connection: ${err}`);
            res.sendStatus(500);
            return;
        }

        connection.query(sql, [clubId, postId], function (err) {
            connection.release();
            if (err) {
                console.error(`Error running SQL query: ${err}`);
                res.sendStatus(500);
                return;
            }
            res.sendStatus(200);
        });
    });
});

router.delete('/:clubId/event/:eventId', (req, res) => {
    if (!req.session.user) {
        res.sendStatus(401); // Unauthorized
        return;
    }

    const { clubId, eventId } = req.params;

    const sql = `
      DELETE FROM events
      WHERE club_id = ? AND event_id = ?;
    `;

    req.pool.getConnection(function (err, connection) {
        if (err) {
            console.error(`Error getting DB connection: ${err}`);
            res.sendStatus(500);
            return;
        }

        connection.query(sql, [clubId, eventId], function (err) {
            connection.release();
            if (err) {
                res.sendStatus(500);
                return;
            }
            res.sendStatus(200);
        });
    });
});


router.post('/:id/addEvent', (req, res) => {
    if (!req.session.user) {
        res.sendStatus(401); // Unauthorized
        return;
    }

    const { eventName, eventSubtitle, eventDate, eventTime, eventLocation, eventDescription, eventOrganizerInfo, isPrivate } = req.body;
    const clubID = req.params.id;

    const parsedEventDate = new Date(eventDate);

    if (isNaN(parsedEventDate.getTime())) {
        res.status(400).send('Invalid event date');
        return;
    }

    const sql = `
      INSERT INTO events (club_id, event_name, event_subtitle, event_date, event_time, event_location, event_description, event_organizer_info, is_private, created_at)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, NOW());
    `;

    req.pool.getConnection(function (err, connection) {
        if (err) {
            console.error(`Error getting DB connection: ${err}`);
            res.sendStatus(500);
            return;
        }

        connection.query(sql, [clubID, eventName, eventSubtitle, parsedEventDate, eventTime, eventLocation, eventDescription, eventOrganizerInfo, isPrivate], function (err) {
            if (err) {
                console.error(err);
                res.sendStatus(500);
                connection.release();
                return;
            }

            if (!isPrivate) {
                const fetchMembersSql = `
                    SELECT users.email, clubs.club_name
                    FROM users
                    INNER JOIN memberships ON memberships.user_id = users.user_id
                    INNER JOIN clubs ON clubs.club_id = memberships.club_id
                    WHERE memberships.club_id = ? AND memberships.opt_in_event = 1
                `;

                connection.query(fetchMembersSql, [clubID], function (err, results) {
                    if (err) {
                        console.error(`Error fetching members: ${err}`);
                        res.sendStatus(500);
                        connection.release();
                        return;
                    }

                    const emails = results.map(result => result.email).join(',');
                    const clubName = results[0]?.club_name || 'Club';

                    const plainTextContent = striptags(eventDescription);

                    let mailOptions = {
                        from: 'clubhub440@gmail.com',
                        to: emails,
                        subject: `New Event From ${clubName} - ${eventName}`,
                        text: `Subtitle: ${eventSubtitle}\nDate: ${eventDate}\nTime: ${eventTime}\nLocation: ${eventLocation}\nDescription: ${plainTextContent}\nOrganizer Info: ${eventOrganizerInfo}\n`
                    };

                    req.transporter.sendMail(mailOptions, (error, info) => {
                        if (error) {
                            return;
                        }
                    });
                });
            }

            res.sendStatus(200);
            connection.release();
        });
    });
});



router.post('/:id/updateMembershipStatus', (req, res) => {
    if (!req.session.user) {
        res.sendStatus(401); // Unauthorized
        return;
    }

    const { user } = req.session;
    const clubID = req.params.id;
    const { status } = req.body;  // status can be 'joined' or 'left'

    req.pool.getConnection(function (err, connection) {
        if (err) {
            console.error('getConnection error: ', err);
            res.sendStatus(500);
            return;
        }

        if (status === 'Inactive') {
            // if the user wants to leave, we should delete the membership record
            const deleteMembershipQuery = 'DELETE FROM memberships WHERE user_id = ? AND club_id = ?';
            connection.query(deleteMembershipQuery, [user.user_id, clubID], function (err) {
                connection.release();
                if (err) {
                    console.error('deleteMembershipQuery error: ', err);
                    res.sendStatus(500);
                    return;
                }
                res.sendStatus(200);
            });
        } else if (status === 'Active') {
            // if the user wants to join, we should create/update the membership record
            connection.query(updateMembershipQuery, [user.user_id, clubID, status], function (err) {
                connection.release();
                if (err) {
                    console.error('updateMembershipQuery error: ', err);
                    res.sendStatus(500);
                    return;
                }
                res.sendStatus(200);
            });
        }
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
                proceedWithClub(req, res);
            });
        });
    } else {
        res.redirect('/login');
    }
});

function proceedWithClub(req, res) {
    const { user } = req.session;
    const clubID = req.params.id;

    req.pool.getConnection(function (err, connection) {
        if (err) {
            console.error("Error getting connection: ", err);
            res.sendStatus(500);
            return;
        }

        connection.query(clubDetailsQuery, [clubID], function (err, clubDetails) {
            if (err) {
                console.error("Error executing clubDetailsQuery: ", err);
                connection.release();
                res.sendStatus(500);
                return;
            }

            if (!clubDetails || clubDetails.length === 0) {
                connection.release();  // Release the connection
                res.render("pages/error.ejs", {
                    title: "Error",
                    message: "Club not found!",
                    user
                });
                return;
            }

            connection.query(clubUpdatesQuery, [clubID], function (err, updateDetails) {
                if (err) {
                    console.error("Error executing clubUpdatesQuery: ", err);
                    connection.release();
                    res.sendStatus(500);
                    return;
                }

                for (let i = 0; i < updateDetails.length; i++) {
                    updateDetails[i].timeStatement = getTimeStatement(new Date(updateDetails[i].created_at));
                }

                connection.query(clubEventsQuery, [clubID], function (err, eventDetails) {
                    if (err) {
                        console.error("Error executing clubEventsQuery: ", err);
                        connection.release();
                        res.sendStatus(500);
                        return;
                    }

                    for (let i = 0; i < eventDetails.length; i++) {
                        eventDetails[i].formattedDate = getFormattedDate(new Date(eventDetails[i].event_date));
                    }

                    connection.query(clubMembershipQuery, [clubID, user.user_id], function (err, membershipDetails) {
                        if (err) {
                            console.error("Error executing clubMembershipQuery: ", err);
                            connection.release();
                            res.sendStatus(500);
                            return;
                        }

                        // Add a new query here to get opt-in status
                        const optInStatusQuery = `SELECT opt_in_update, opt_in_event FROM memberships WHERE user_id = ? AND club_id = ?`;
                        connection.query(optInStatusQuery, [user.user_id, clubID], function(err, optInStatus) {
                            if (err) {
                                console.error("Error executing optInStatusQuery: ", err);
                                connection.release();
                                res.sendStatus(500);
                                return;
                            }

                            // Extract opt-in status. If no result, default to false.
                            let optInUpdate = false;
                            let optInEvent = false;
                            if(optInStatus[0]) {
                                optInUpdate = optInStatus[0].opt_in_update;
                                optInEvent = optInStatus[0].opt_in_event;
                            }

                            // Add a new query here to get events that the user is attending
                            connection.query(clubEventsAttendingQuery, [user.user_id], function(err, eventsAttending) {
                                if (err) {
                                    console.error("Error executing clubEventsAttendingQuery: ", err);
                                    connection.release();
                                    res.sendStatus(500);
                                    return;
                                }

                                // Query to get club managers
                                connection.query(clubManagersQuery, [clubID], function(err, clubManagers) {
                                    if (err) {
                                        console.error("Error executing clubManagersQuery: ", err);
                                        connection.release();
                                        res.sendStatus(500);
                                        return;
                                    }

                                    const isMember = membershipDetails.length > 0;

                                    // Convert the array of events to a Set for efficient lookups
                                    const attendingEventIds = new Set(eventsAttending.map(event => event.event_id));

                                    // Add a new "isAttending" property to each event
                                    for (let i = 0; i < eventDetails.length; i++) {
                                        eventDetails[i].isAttending = attendingEventIds.has(eventDetails[i].event_id);
                                    }

                                    // Query to get total members count
                                    connection.query(clubMembersCountQuery, [clubID], function(err, result) {
                                        if (err) {
                                            console.error("Error executing clubMembersCountQuery: ", err);
                                            connection.release();
                                            res.sendStatus(500);
                                            return;
                                        }

                                        // Store the total number of members
                                        const totalMembers = result[0].totalMembers;

                                        connection.release();  // Release the connection

                                        res.render("pages/club/index.ejs", {
                                            title: "Club",
                                            scriptPath: "static/js/pages/club/index.js",
                                            user,
                                            clubDetails,
                                            updateDetails,
                                            eventDetails,
                                            isMember,
                                            clubManagers,
                                            totalMembers,
                                            optInUpdate,
                                            optInEvent
                                        });
                                    });
                                });
                            });
                        });
                    });
                });
            });
        });
    });
}

// Ensure uploads directory exists
const uploadDir = 'public/images/uploads/';
if (!fs.existsSync(uploadDir)){
    fs.mkdirSync(uploadDir, { recursive: true });
}

router.post('/:id/uploadBanner', upload.single('file'), (req, res) => {
    const clubID = req.params.id;
    const fileName = path.basename(req.file.path);
    const sql = `UPDATE clubs SET club_banner = ? WHERE club_id = ?`;

    // Verify file exists and is not empty
    fs.stat(req.file.path, (err, stats) => {
        if (err) {
            console.error(`Error checking file: ${err}`);
            res.sendStatus(500);
            return;
        }

        if (stats.size === 0) {
            console.error('Received empty file');
            res.sendStatus(500);
            return;
        }

        req.pool.getConnection(function (err, connection) {
            if (err) {
                console.error(`Error getting DB connection: ${err}`);
                res.sendStatus(500);
                return;
            }

            connection.query(sql, [fileName, clubID], function (err) {
                connection.release();
                if (err) {
                    console.error(`Error running SQL query: ${err}`);
                    res.sendStatus(500);
                    return;
                }
                res.sendStatus(200);
            });
        });
    });
});

router.post('/:id/uploadLogo', upload.single('file'), (req, res) => {
    const clubID = req.params.id;
    const fileName = path.basename(req.file.path);
    const sql = `UPDATE clubs SET club_logo = ? WHERE club_id = ?`;

    // Verify file exists and is not empty
    fs.stat(req.file.path, (err, stats) => {
        if (err) {
            console.error(`Error checking file: ${err}`);
            res.sendStatus(500);
            return;
        }

        if (stats.size === 0) {
            console.error('Received empty file');
            res.sendStatus(500);
            return;
        }

        req.pool.getConnection(function (err, connection) {
            if (err) {
                console.error(`Error getting DB connection: ${err}`);
                res.sendStatus(500);
                return;
            }

            connection.query(sql, [fileName, clubID], function (err) {
                connection.release();
                if (err) {
                    console.error(`Error running SQL query: ${err}`);
                    res.sendStatus(500);
                    return;
                }
                res.sendStatus(200);
            });
        });
    });
});

module.exports = router;
