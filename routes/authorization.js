const express = require('express');
const router = express.Router();
const passport = require('passport');
const GoogleStrategy = require('passport-google-oauth20').Strategy;
const bcrypt = require('bcrypt');

const query = `
    SELECT user_id, email, password
    FROM users
    WHERE email = ?;
`;

router.get('/', (req, res) => {
    if (req.session.user) {
        res.redirect('/dashboard');
        return;
    }

    const { errorMessage } = req.query;
    res.render("pages/authorization/index.ejs", {
        title: "login",
        scriptPath: "static/js/pages/authorization/index.js",
        errorMessage
    });
});

router.get('/create', (req, res) => {
    if (req.session.user) {
        res.redirect('/dashboard');
        return;
    }

    const { errorMessage } = req.query;
    res.render("pages/authorization/create.ejs", {
        title: "login",
        scriptPath: "static/js/pages/authorization/create.js",
        errorMessage
    });
});

router.post('/authenticate', (req, res) => {
    req.pool.getConnection(function (err, connection) {
        if (err) {
            res.sendStatus(500);
            return;
        }

        const { email, password } = req.body;
        const getUsers = 'SELECT * FROM users WHERE email = ?';

        connection.query(getUsers, [email], function (queryErr, rows, fields) {
            connection.release(); // Release the connection

            if (queryErr) {
                res.sendStatus(500);
                return;
            }

            let isCredentialsMatched = false;
            let user_id;

            const user = rows[0];

            if (!user) {
                res.status(401).json({ error: 'Invalid credentials' });
                return;
            }

            const isPasswordMatched = bcrypt.compareSync(password, user.password);

            if (user.email === email && isPasswordMatched) {
                if(user.status === 'Inactive') {
                    res.status(403).json({ error: 'Your account has been disabled' });
                    return;
                }

                isCredentialsMatched = true;
                user_id = user.user_id;
            }

            if (isCredentialsMatched) {
                req.session.user_id = user_id; // Save the user's ID in their session
                res.status(200).json({ redirect: '/dashboard' });
            } else {
                res.status(401).json({ error: 'Invalid credentials' });
            }
        });
    });
});

router.post('/create', (req, res) => {
    req.pool.getConnection((err, connection) => {
        if (err) {
            res.sendStatus(500);
            return;
        }

        const {
            firstname, lastname, email, password
        } = req.body;
        const hashedPassword = bcrypt.hashSync(password, bcrypt.genSaltSync(10));
        const role = "member";
        const createdAt = new Date().toISOString().slice(0, 19).replace('T', ' ');

        const checkQuery = `SELECT user_id FROM users WHERE email = ?;`;

        connection.query(checkQuery, [email], (checkErr, checkRows, checkFields) => {
            if (checkErr) {
                connection.release();
                res.sendStatus(500);
                return;
            }

            if (checkRows.length > 0) {
                connection.release();
                res.status(400).json({ error: 'Email already exists' });
                return;
            }

            const createQuery = `INSERT INTO users (first_name, last_name, email, password, role, created_at) VALUES (?, ?, ?, ?, ?, ?);`;

            connection.query(createQuery, [firstname, lastname, email, hashedPassword, role, createdAt], (createErr, createResult) => {
                connection.release();

                if (createErr) {
                    res.sendStatus(500);
                    return;
                }

                res.status(200).json({ message: 'User created successfully' });
            });
        });
    });
});


passport.use(new GoogleStrategy(
{
    clientID: '151866152730-8l9fc4ui6pt8s3bldd092uo71cihpnsa.apps.googleusercontent.com',
    clientSecret: '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',
    callbackURL: "/login/auth/google/callback",
    passReqToCallback: true
},
function(req, accessToken, refreshToken, profile, cb) {
    const email = profile.emails[0].value;
    const firstname = profile.name.givenName;
    const lastname = profile.name.familyName || '';

    req.pool.getConnection((err, connection) => {
        if (err) {
            return cb(err);
        }

        const checkQuery = `SELECT user_id FROM users WHERE email = ?;`;

        connection.query(checkQuery, [email], (checkErr, checkRows, checkFields) => {
            if (checkErr) {
                connection.release();
                return cb(checkErr);
            }

            if (checkRows.length === 0) {
                const createQuery = `INSERT INTO users (first_name, last_name, email, role, created_at, is_oauth_user) VALUES (?, ?, ?, ?, ?, TRUE);`;
                const role = "member";
                const createdAt = new Date().toISOString().slice(0, 19).replace('T', ' ');

                connection.query(createQuery, [firstname, lastname, email, role, createdAt], (createErr, createResult) => {
                    connection.release();

                    if (createErr) {
                        return cb(createErr);
                    }

                    return cb(null, createResult.insertId);
                });
            } else {
                return cb(null, checkRows[0].user_id);
            }
        });
    });
}
));

passport.serializeUser(function(user, cb) {
    cb(null, user);
});

passport.deserializeUser(function(user, cb) {
    findUserById(user_id, function(err, user) {
        cb(err, user);
    });
});

function isAuthenticated(req, res, next) {
    if (req.session.user_id) {
        return next();
    }
        res.redirect('/auth/google');

}

router.get('/auth/google', passport.authenticate('google', { scope: ['profile', 'email'] }));

router.get(
'/auth/google/callback',
    passport.authenticate('google', { failureRedirect: '/login', session: false }),
    function(req, res) {
        req.session.user_id = req.user;
        res.redirect('/dashboard');
    }
);


module.exports = router;
