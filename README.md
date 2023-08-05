# Repository for WDC Final Project - Semester 1, 2023

This repository hosts the codebase for the final project for Web and Datbase Computing (WDC) for the first semester of 2023.

# ClubHub
Immerse yourself in vibrant student life. Find clubs that match your interests, join them, and never miss an update or event. As a Club Manager, share updates, create events, and foster a thriving community. Stay connected, stay informed, and let your campus life flourish with ClubHub!

# Video Presentation
- Our video is located in /presentation `ClubHub-Presentation.mp4`
- A youtube link can also be found at: https://youtu.be/4M-OcYlWBO4

# Database
- Our schema + draft queries can be found in /database/final_submission
- Backups outlining the development of this database can be found in /database/backups

# Marker Instructions
1. Install packages
2. Start mysql
3. Import database
4. Start the server under development (so that the nessecary files can be compiled)
- Please note that the first time that the files are compiled, it will take roughly a minute. Once they are, you can navigate to localhost:3000
- Once the files have been compiled for the first time, `npm run start` can be used instead if restarting the server

```
npm install
service mysql start
mysql < database/backups/clubhub-v1.sql
npm run dev (wait for files to compile after this)
```

## Installed Packages
The project uses a variety of npm packages for different purposes. Here are some notable ones:

- **Express**: A web application framework for Node.js.
- **Vue**: A JavaScript framework for building user interfaces.
- **Bootstrap**: A CSS framework for building responsive, mobile-first sites.
- **EJS**: A simple templating language that lets you generate HTML markup with plain JavaScript.
- **Sass**: A CSS pre-processor which allows us to use variables, nested rules, mixins, functions, and more.
- **Nodemon**: A utility that monitors changes in your source code and automatically restarts your server.
- **MySQL**: Node.js drivers for MySQL.
- **Bcrypt**: A library to help in hashing passwords.
- **Passport** and **passport-google-oauth20**: Authentication middleware for Node.js, including Google OAuth 2.0 strategy.
- **Nodemailer**: A module to send emails from Node.js.
- **Webpack**: A static module bundler for modern JavaScript applications.
- **Multer**: A middleware for handling multipart/form-data, which is primarily used for uploading files.
- **Quill**: A powerful, free WYSIWYG editor with a modular architecture.
- **jsdom**: A pure-JavaScript implementation of many web standards, for use with Node.js.
- **dompurify**: A DOM-only, super-fast, uber-tolerant XSS sanitizer for HTML, MathML, and SVG.
- **striptags**: An implementation of PHP's strip_tags in JavaScript.
- **body-parser**: Parse incoming request bodies in middleware before your handlers.
- **cookie-parser**: Parse Cookie header and populate req.cookies with an object keyed by the cookie names.
- **express-session**: Create a session middleware with the given options.
- **express-ejs-layouts**: Layout support for EJS in Express.
- **express-mysql-session**: A MySQL session store for Express.


### Installation

To install all the npm Packages, run:
```
npm install
```

In order to have the latest database version for proper functioning, import it into MySQL. Please note that mysql must be running before hand `service mysql start`. Execute the following command:
```
mysql < database/backups/clubhub-v1.sql
```

## Usage

The following are the npm scripts to run for both the production and development environments.

### Production
- Please note that if running for the first time, npm run dev should be executed first so that the proper files can be compiled for use.
To start the application in a production environment and start the database, run:
```
npm run start
```

#### User Roles
- Any new accounts registered will automatically be of the 'member' role, meaning they have no privilages to post to / update the site
- Please log into the provided administrator account if you wish to make any changes, or provide more permissions via role change to your own account if you choose to do so:

```
user: admin@clubhub.com
password: clubadmin
```

- Otherwise, feel free to login through google or create your own account!

### Development

To start the development version of the site, the SCSS and js will be watched. On saving any of the files that are included, all the files will be recompiled. The database will also be started.

To start nodemon and watch Sass, run:

```
npm run dev
```

## Known Issues
We would like to make you aware of the following known issues:

- Multer, the image uploading module, currently encounters an issue when handling some images. Occasionally, users may experience a hang in the image upload process on the site. To resolve this, simply refresh the page and attempt the upload again.

## Other Notes
- Please note that some of the images found onsite, including club logos and banners were generated using Midjourney

