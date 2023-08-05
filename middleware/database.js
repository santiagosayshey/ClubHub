const mysql = require('mysql');

const dbConnectionPool = mysql.createPool({
    host: 'localhost',
    database: 'clubhub'
});

module.exports = function (req, res, next) {
    req.pool = dbConnectionPool;
    next();
};
