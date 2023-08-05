const session = require('express-session');
const MySQLStore = require('express-mysql-session')(session);

const query = `
  SELECT first_name, last_name, role, profile_picture, email, password
  FROM users
  WHERE user_id = ?;
`;


const options = {
  host: 'localhost',
  database: 'clubhub'
};

const queryUser = (req, res, next) => {
  const { user_id } = req.session;

  if (!user_id) {
    next();
    return;
  }

  req.pool.getConnection(function (err, connection) {
    if (err) {
      next();
      return;
    }

    connection.query(query, [user_id], function (queryErr, rows, fields) {
      connection.release();

      if (queryErr) {
        console.error("Query error:", queryErr);
        next();
        return;
      }

      let isAdmin = false;
      let isManager = false;

      if (rows[0].role === "Admin") {
        isAdmin = true;
      } else if (rows[0].role === "Manager") {
        isManager = true;
      }

      if (rows.length > 0) {
        const user = {
          user_id: user_id,
          first_name: rows[0].first_name,
          last_name: rows[0].last_name,
          role: rows[0].role,
          profile_picture: rows[0].profile_picture,
          email: rows[0].email,
          isAdmin: isAdmin,
          isManager: isManager
        };

        req.session.user = user;
      }

      next();
    });
  });
};

const sessionStore = new MySQLStore(options);

const sessionConfig = session({
  secret: 'mb was here',
  resave: false,
  saveUninitialized: false,
  store: sessionStore,
  cookie: { secure: false }
});


// Export a function that sets up the session middleware with user details retrieval
module.exports = (app) => {
  app.use(sessionConfig);
  app.use(queryUser);
};
