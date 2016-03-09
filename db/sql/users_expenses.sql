DROP VIEW users_expenses;

CREATE VIEW users_expenses AS
SELECT u.email, u.encrypted_password, u.reset_password_token, u.reset_password_sent_at, u.remember_created_at, u.sign_in_count, u.current_sign_in_at, u.last_sign_in_at, u.current_sign_in_ip, u.last_sign_in_ip, e.*
FROM users u
JOIN expenses e
ON u.id = e.user_id;
