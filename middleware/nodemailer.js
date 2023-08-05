const nodemailer = require('nodemailer');

module.exports = function(req, res, next) {
    // Create a transporter object using the Gmail transport
    let transporter = nodemailer.createTransport({
        service: 'gmail',
        auth: {
            user: 'clubhub440@gmail.com',
            pass: 'kjvnniyqeblpajws'
        }
    });

    req.transporter = transporter;

    next();
};
