const express = require('express');
const router = express.Router();
const fs = require('fs');
const path = require('path');
const bcrypt = require('bcrypt');
const upload = require('../middleware/upload');

router.get('/logout', (req, res) => {
    // Destroy the session
    req.session.destroy((err) => {
        if (err) {
            console.error('An error occurred while destroying the session:', err);
            res.status(500).send('Error occurred during logout');
        } else {
            res.status(200).send();
        }
    });
});

router.get('/getAccountInfo', (req, res) => {
    const { user } = req.session;

    const sqlQuery = `SELECT * FROM users WHERE user_id = ?`;

    req.pool.getConnection((err, connection) => {
        if (err) {
            console.error('Database connection error:', err);
            res.sendStatus(500);
            return;
        }

        connection.query(sqlQuery, [user.user_id], (queryErr, result) => {
            connection.release();

            if (queryErr) {
                console.error('Database query error:', err);
                res.sendStatus(500);
                return;
            }

            const user = result[0];
            res.status(200).json({ user });
        });
    });
});

router.post('/updateAccountInfo', (req, res) => {
    req.pool.getConnection((err, connection) => {
        if (err) {
            res.status(500).json({ error: 'Database connection error' });
            return;
        }

        const {
            firstname, lastname, email, password
        } = req.body;
        const userId = req.session.user_id;

        const oauthCheckQuery = `SELECT email, is_oauth_user FROM users WHERE user_id = ?;`;

        connection.query(oauthCheckQuery, [userId], (oauthCheckErr, oauthCheckRows, oauthCheckFields) => {
            if (oauthCheckErr) {
                connection.release();
                res.status(500).json({ error: 'Database query error' });
                return;
            }

            const user = oauthCheckRows[0];

            // OAuth users can't change their email or password
            if (user.is_oauth_user && (user.email !== email || (password !== undefined && password !== ''))) {
                connection.release();
                res.status(400).json({ error: 'Cannot change email or password for account signed up using Google' });
                return;
            }

            // Check if the new email is already taken
            const emailCheckQuery = `SELECT * FROM users WHERE email = ? AND user_id != ?;`;
            connection.query(emailCheckQuery, [email, userId], (emailCheckErr, emailCheckRows) => {
                if (emailCheckErr) {
                    connection.release();
                    res.status(500).json({ error: 'Database query error' });
                    return;
                }

                if (emailCheckRows.length > 0) {
                    connection.release();
                    res.status(400).json({ error: 'Email is already taken' });
                    return;
                }

                let sqlUpdate;
                let values;

                // Check if a password was provided
                if (password !== undefined && password !== '') {
                    sqlUpdate = `UPDATE users SET first_name = ?, last_name = ?, email = ?, password = ? WHERE user_id = ?`;
                    const hashedPassword = bcrypt.hashSync(password, 10);
                    values = [firstname, lastname, email, hashedPassword, userId];
                } else {
                    sqlUpdate = `UPDATE users SET first_name = ?, last_name = ?, email = ? WHERE user_id = ?`;
                    values = [firstname, lastname, email, userId];
                }

                connection.query(sqlUpdate, values, (queryErr, result) => {
                    connection.release(); // release the connection

                    if (queryErr) {
                        res.status(500).json({ error: 'Database update error' });
                        return;
                    }

                    res.status(200).json({ message: 'Account updated successfully' });
                });
            });
        });
    });
});


router.post('/uploadProfileImage', upload.single('file'), (req, res) => {
    const { user } = req.session;
    const fileName = path.basename(req.file.path);
    const sql = `UPDATE users SET profile_picture = ? WHERE user_id = ?`;

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

        req.pool.getConnection(function (err2, connection) {
            if (err2) {
                console.error(`Error getting DB connection: ${err2}`);
                res.sendStatus(500);
                return;
            }

            connection.query(sql, [fileName, user.user_id], function (err3) {
                connection.release();
                if (err3) {
                    console.error(`Error running SQL query: ${err3}`);
                    res.sendStatus(500);
                    return;
                }
                res.sendStatus(200);
            });
        });
    });
});


function proceedWithAccount(req, res) {
    const accountID = req.params.id;
    const { user } = req.session;

    const sqlQuery = `SELECT * FROM users WHERE user_id = ?`;

    req.pool.getConnection((err, connection) => {
        if (err) {
            console.error('Database connection error:', err);
            res.sendStatus(500);
            return;
        }

        connection.query(sqlQuery, [accountID], (queryErr, result) => {

            if (queryErr) {
                console.error('Database query error:', err);
                res.sendStatus(500);
                return;
            }

            const chosenUser = result[0];

            if (!chosenUser) {
                res.render("pages/error.ejs", {
                    title: "Error",
                    message: "User not found!",
                    user
                });
                return;
            }

            const clubQuery = "SELECT * FROM clubs INNER JOIN memberships ON clubs.club_id = memberships.club_id WHERE memberships.user_id = ?;";


            connection.query(clubQuery, [chosenUser.user_id], (queryErr2, chosenUserClubs) => {
                connection.release();

                if (queryErr2) {
                    console.error('Database query error:', err);
                    res.sendStatus(500);
                    return;
                }

                res.render("pages/account/index.ejs", {
                    title: "Account",
                    user,
                    chosenUser,
                    chosenUserClubs
                });

                res.status(200);
            });
        });
    });
}

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
                        message: 'Your account has been disabled'
                    });
                    return;
                }
                proceedWithAccount(req, res);
            });
        });
    } else {
        res.redirect('/login');
    }
});

module.exports = router;
