-- Query: getUsers
-- Fetches all users, sorted by their first names in ascending order.
SELECT * FROM users ORDER BY users.first_name ASC;

-- Query: updateUserRole
-- Updates the role of a user identified by user_id.
UPDATE users SET role = ? WHERE user_id = ?;

-- Query: updateMembershipRole
-- Updates the role of a user in a specific club, identified by user_id and club_id.
UPDATE memberships SET role = ? WHERE user_id = ? AND club_id = ?;

-- Query: disableUser
-- Sets a user's status to 'Inactive', identified by user_id.
UPDATE users SET status = 'Inactive' WHERE user_id = ?;

-- Query: enableUser
-- Sets a user's status to 'Active', identified by user_id.
UPDATE users SET status = 'Active' WHERE user_id = ?;
