TRUNCATE TABLE users RESTART IDENTITY CASCADE;
TRUNCATE TABLE spaces RESTART IDENTITY CASCADE; 
TRUNCATE TABLE bookings RESTART IDENTITY CASCADE; 

INSERT INTO users (email, password) VALUES
('user1@gmail.com', '12345'), 
('user2@gmail.com', 'abcde'), 
('user3@gmail.com', '67890'), 
('user4@gmail.com', 'qwerty');

INSERT INTO spaces (name, description, available_start, available_end, price, user_id) VALUES
('House of Horrors', 'Haunted house with friendly ghost', '2023-07-04', '2023-08-31', 100, 1), 
('House of Dreams', 'Lovely house with a terrace top', '2023-06-01', '2023-08-22', 150, 2), 
('House of Dragons', 'Where Rhaenyra was coronated', '2023-05-04', '2023-07-31', 100, 3);

INSERT INTO bookings (reservation_date, status, user_id, space_id) VALUES
('2023-07-06', 'Approved', 3, 2),
('2023-06-10', 'Pending', 2, 1),
('2023-07-07', 'Rejected', 1, 2);
