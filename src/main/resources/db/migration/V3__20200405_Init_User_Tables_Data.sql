INSERT INTO primary_account (id, account_balance, account_number)
VALUES (1, 1700.00, '11223146'),
       (2, 0.00, '11223150');

INSERT INTO savings_account (id, account_balance, account_number)
VALUES (1, 2500.00, '9876543210'),
       (2, 500.00, '9876543211');

INSERT INTO role (role_id, name) VALUES (1, 'ROLE_USER');
INSERT INTO role (role_id, name) VALUES (2, 'ROLE_ADMIN');

INSERT INTO user (user_id, email, enabled, first_name, last_name, password, phone, username, primary_account_id, savings_account_id)
VALUES (1, 'uzumaki_naruto@konohagakure.co.jp', TRUE, 'Uzumaki', 'Naruto',
        '$2a$12$DWCryEwHwbTYCegib92tk.VST.GG1i2WAqfaSwyMdxX0cl0eBeSve', '5551112345', 'UzumakiNaruto', 1, 1),
       (2, 'srikar@gmail.com', TRUE, 'Srikar', 'Padakanti',
        '$2a$12$hZR7pcSf0JU/OTXR3TOyuu8r6C6n.JZE8Ei47E4LZs1t0Aq1AO6oC',
        '1111111111', 'UchihaSasuke', 2, 2);

INSERT INTO user_role (user_id, role_id) VALUES (1, 1);
INSERT INTO user_role (user_id, role_id) VALUES (2, 2);
INSERT INTO user_role (user_id, role_id) VALUES (2, 1);
