-- getAccountInfo.sql
-- Retrieves the details of a user with the given user_id.
SELECT * FROM users WHERE user_id = ?;

-- oauthCheckQuery.sql
-- Retrieves the email and is_oauth_user status of a user with the given user_id.
SELECT email, is_oauth_user FROM users WHERE user_id = ?;

-- emailCheckQuery.sql
-- Checks if the provided email is already associated with any other user.
SELECT * FROM users WHERE email = ? AND user_id != ?;

-- updateAccountInfoWithPassword.sql
-- Updates the first_name, last_name, email and password of a user with the given user_id.
UPDATE users SET first_name = ?, last_name = ?, email = ?, password = ? WHERE user_id = ?;

-- updateAccountInfoWithoutPassword.sql
-- Updates the first_name, last_name and email of a user with the given user_id.
UPDATE users SET first_name = ?, last_name = ?, email = ? WHERE user_id = ?;

-- uploadProfileImage.sql
-- Updates the profile_picture of a user with the given user_id.
UPDATE users SET profile_picture = ? WHERE user_id = ?;

-- getUserForProceedWithAccount.sql
-- Retrieves the details of a user with the given user_id.
SELECT * FROM users WHERE user_id = ?;

-- getClubsForUser.sql
-- Retrieves the details of clubs to which the user with the given user_id belongs.
SELECT * FROM clubs INNER JOIN memberships ON clubs.club_id = memberships.club_id WHERE memberships.user_id = ?;

-- checkUserStatus.sql
-- Retrieves the details of a user with the given user_id.
SELECT * FROM users WHERE user_id = ?;