const express = require('express');
const router = express.Router();

const queryClubs = "SELECT * FROM clubs ORDER BY clubs.club_name ASC";
const queryInterests = "SELECT club_interests.club_id, interests.interest_name FROM club_interests JOIN interests ON club_interests.interest_id = interests.interest_id ORDER BY interests.interest_name ASC";
const querySearchClubs = "SELECT * FROM clubs WHERE club_name LIKE ? ORDER BY club_name ASC";

router.get('/search', (req, res) => {
    const searchTerm = req.query.term;
    req.pool.getConnection((err, connection) => {
        if (err) {
            console.error('Failed to get database connection:', err);
            res.sendStatus(500);
            return;
        }
        connection.query(querySearchClubs, [`%${searchTerm}%`], (queryErr, clubData) => {
            connection.release(); // release connection
            if (queryErr) {
                console.error('Failed to query clubs:', queryErr);
                res.sendStatus(500);
                return;
            }

            res.json(clubData);
        });
    });
});

// SQL query to fetch all interests
const modalInterests = "SELECT * FROM interests ORDER BY interest_name ASC";

// GET /club/interests
router.get('/interests', (req, res) => {
    req.pool.getConnection((err, connection) => {
        if (err) {
            console.error('Failed to get database connection:', err);
            res.sendStatus(500);
            return;
        }

        connection.query(modalInterests, (queryErr, interestsData) => {
            connection.release(); // release connection
            if (queryErr) {
                console.error('Failed to query interests:', queryErr);
                res.sendStatus(500);
                return;
            }
            res.json(interestsData);
        });
    });
});

router.post('/new', (req, res) => {
    const {
 club_name, club_description, contact_information, instagram_link, interests
} = req.body;
    const creator_id = req.session.user.user_id;

    // SQL query to insert a new club
    const sqlInsertClub = `
        INSERT INTO clubs (club_name, club_description, contact_information, social_media_links, created_at)
        VALUES (?, ?, ?, ?, NOW());
    `;

    // SQL query to insert a new club manager
    const sqlInsertManager = `
        INSERT INTO memberships (user_id, club_id, status, role, created_at)
        VALUES (?, ?, 'Active', 'Manager', NOW());
    `;

    // Get a connection from the pool
    req.pool.getConnection((err, connection) => {
        if (err) {
            console.error(`Error getting DB connection: ${err}`);
            res.sendStatus(500);
            return;
        }

        // Insert new club
        connection.query(sqlInsertClub, [club_name, club_description, contact_information, instagram_link], (err, result) => {
            if (err) {
                connection.release();
                console.error(`Error running SQL query: ${err}`);
                res.sendStatus(500);
                return;
            }

            const newClubId = result.insertId;

            // Assign creator as the club manager
            connection.query(sqlInsertManager, [creator_id, newClubId], (err) => {
                if (err) {
                    console.error(`Error assigning club manager: ${err}`);
                    res.sendStatus(500);

                }
            });

            // SQL query to insert club interests
            const sqlInsertInterests = `
                INSERT INTO club_interests (club_id, interest_id, created_at)
                VALUES (?, ?, NOW());
            `;

            // For each interest, insert a row into the club_interests table
            interests.forEach((interest_id) => {
                connection.query(sqlInsertInterests, [newClubId, interest_id], (err) => {
                    if (err) {
                        console.error(`Error running SQL query: ${err}`);
                        res.sendStatus(500);

                    }
                });
            });

            connection.release();
            res.json({ newClubId: newClubId });
        });
    });
});

function proceedWithDirectory(req, res) {
    const { user } = req.session;

    req.pool.getConnection(function (err, connection) {
        if (err) {
            console.error('Failed to get database connection:', err);
            res.sendStatus(500);
            return;
        }

        connection.query(queryClubs, function (queryErr, clubData) {
            if (queryErr) {
                console.error('Failed to query clubs:', queryErr);
                connection.release(); // release connection
                res.sendStatus(500);
                return;
            }

            connection.query(queryInterests, function (queryErr, interestsData) {
                connection.release(); // release connection
                if (queryErr) {
                    console.error('Failed to query interests:', queryErr);
                    res.sendStatus(500);
                    return;
                }

                // Merge interests into clubs data
                clubData.forEach((club) => {
                    club.interests = interestsData.filter((interest) => interest.club_id === club.club_id);
                });

                res.render("pages/directory/index.ejs", {
                    title: "Directory",
                    user,
                    scriptPath: "static/js/pages/directory/index.js",
                    clubData,
                    interestsData
                });
            });
        });
    });
}


router.get('/', (req, res) => {
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
                proceedWithDirectory(req, res);
            });
        });
    } else {
        res.redirect('/login');
    }
});


module.exports = router;
