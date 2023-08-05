const express = require('express');
const router = express.Router();

router.post('/users', (req, res) => {
    req.pool.getConnection(function (err, connection) {
        if (err) {
            res.sendStatus(500);
            return;
        }

        let sql = 'SELECT * FROM users ORDER BY users.first_name ASC';
        connection.query(sql, function (queryErr, rows) {
            connection.release();

            if (queryErr) {
                res.sendStatus(500);
                return;
            }

            res.send(rows);
        });
    });
});

router.post('/users/update', (req, res) => {
    req.pool.getConnection(function (err, connection) {
        if (err) {
            res.sendStatus(500);
            return;
        }

        const { user_id, role } = req.body;

        // Validate the role before updating
        if (role !== 'Admin' && role !== 'Member') {
            res.status(400).send('Invalid role');
            return;
        }

        let sql = `UPDATE users SET role = ? WHERE user_id = ?`;
        connection.query(sql, [role, user_id], function (queryErr, result) {
            connection.release();

            if (queryErr) {
                res.sendStatus(500);
                return;
            }

            res.send('User updated');
        });
    });
});

router.post('/users/:id/update', (req, res) => {

    req.pool.getConnection(function (err, connection) {
        if (err) {
            console.error('Database connection error:', err);
            res.sendStatus(500);
            return;
        }

        const { user_id, role } = req.body;
        const clubID = req.params.id;

        // Validate the role before updating
        if (role !== 'Manager' && role !== 'Member') {
            console.warn('Received invalid role:', role);
            res.status(400).send('Invalid role');
            return;
        }

        let sql = `UPDATE memberships SET role = ? WHERE user_id = ? AND club_id = ?`;
        connection.query(sql, [role, user_id, clubID], function (queryErr, result) {
            connection.release();

            if (queryErr) {
                console.error('SQL query error:', queryErr);
                res.sendStatus(500);
                return;
            }

            res.send('User role updated in club');
        });
    });
});

router.post('/users/disable', (req, res) => {
    req.pool.getConnection(function (err, connection) {
        if (err) {
            res.sendStatus(500);
            return;
        }

        const { user_id } = req.body;

        let sql = `UPDATE users SET status = 'Inactive' WHERE user_id = ?`;
        connection.query(sql, [user_id], function (queryErr, result) {
            connection.release();

            if (queryErr) {
                res.sendStatus(500);
                return;
            }

            res.send('User disabled');
        });
    });
});

router.post('/users/enable', (req, res) => {
    req.pool.getConnection(function (err, connection) {
        if (err) {
            res.sendStatus(500);
            return;
        }

        const { user_id } = req.body;

        let sql = `UPDATE users SET status = 'Active' WHERE user_id = ?`;
        connection.query(sql, [user_id], function (queryErr, result) {
            connection.release();

            if (queryErr) {
                res.sendStatus(500);
                return;
            }

            res.send('User Enabled');
        });
    });
});

router.get('/', (req, res) => {
    const { user } = req.session;

    if (!req.session.user || req.session.user.role !== 'Admin') {
        res.render('pages/error', {
            title: 'Error!',
            message: 'Your must be an admin to access this page',
            user
        });
        return;
    }

    res.render("pages/manage/index.ejs", {
        title: "Manage Users",
        user
    });
});

module.exports = router;
