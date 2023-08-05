const express = require('express');
const app = express();
const path = require('path');
const expressLayouts = require("express-ejs-layouts");
const bodyParser = require('body-parser');
const passport = require('passport');

// Middlewares
const dbConnection = require('./middleware/database');
const viewsPath = path.join(__dirname, "src/views");
const sessionConfig = require('./middleware/session-config');
const domPurify = require('./middleware/domPurify.js');
const nodemailer = require('./middleware/nodemailer.js');

// Routes
const landingRoutes = require('./routes/landing');
const dashboardRoutes = require('./routes/dashboard');
const authorizationRoutes = require('./routes/authorization');
const accountRoutes = require('./routes/account');
const eventsRoutes = require('./routes/events');
const clubRoutes = require('./routes/club');
const directoryRoutes = require('./routes/directory');
const manageRoutes = require('./routes/manage');

app.use('/static', express.static(path.join(__dirname, './public')));

app.set("layout", "layout/layout.ejs");
app.set("views", viewsPath);
app.set("layout extractScripts", true);
app.set("view engine", "ejs");

// use middleware
app.use(expressLayouts);
app.use(dbConnection);
app.use(passport.initialize());
app.use(domPurify);
app.use(nodemailer);

// Invoke the sessionConfig function and pass the app instance
sessionConfig(app);

// lim file sizes for updates
const bodyLimit = '1000mb';
app.use(bodyParser.json({ limit: bodyLimit }));
app.use(bodyParser.urlencoded({ limit: bodyLimit, extended: true }));

// use routes
app.use('/', landingRoutes);
app.use('/dashboard', dashboardRoutes);
app.use('/login', authorizationRoutes);
app.use('/account', accountRoutes);
app.use('/events', eventsRoutes);
app.use('/club', clubRoutes);
app.use('/directory', directoryRoutes);
app.use('/manage', manageRoutes);

const PORT = 3000;
app.listen(PORT, () => {
    console.log(`App running on port ${PORT}`);
});


if (process.env.NODE_ENV === 'development') {
    const webpack = require('webpack');
    const webpackConfig = require('./webpack.config.js');

    const compiler = webpack(webpackConfig);
    compiler.watch({}, (err, stats) => {
        if (err) {
            console.error(err);
        } else {
            console.log(stats.toString({
                colors: true,
                modules: false,
                chunks: false,
                chunkModules: false
            }));
        }
    });
}
app.get('*', function(req, res){
    res.redirect('/dashboard');
});
