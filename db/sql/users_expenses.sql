CREATE OR REPLACE VIEW users_expenses AS
SELECT users.email, expenses.*
FROM users
JOIN expenses ON users.id = expenses.user_id;
