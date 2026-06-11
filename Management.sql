Create database if not exists Cinema;
use Cinema;
-- Drop the junction table first to release the Foreign Key constraints
-- DROP TABLE IF EXISTS WatchLog;

-- -- Now you can safely drop the parent tables
-- DROP TABLE IF EXISTS Movie;
-- DROP TABLE IF EXISTS Users;

create Table if not exists Movie(
movie_id int primary key auto_increment,
title varchar(50) not null,
genre varchar(50) not null,
release_Date int,
rental_rate decimal (5, 2)
);

create Table if not exists Users(
user_id int primary key auto_increment,
username varchar(50) Unique Not null,
email varchar(60),
join_date Date,
status varchar(50)
);

create table if not exists WatchLog(
log_Id int primary key auto_increment,
user_id int,
movie_id int,
watch_Date datetime,
duration_minutes int,
foreign key (user_id) references Users(user_id),
foreign key (movie_id) references Movie(movie_id)
);

INSERT INTO Users (username, email, join_date, status) VALUES 
('Khush', 'khsuhsharma262@gmail.com', '2014-12-29', 'Active'), 
('Sakshi', 'sakshi@gmail.com', '2020-11-27', 'Active'), 
('Anu', 'Meow@gmail.com', '2026-01-27', 'Active'), 
('Major Iqbal', 'ISI@gmail.com', '2025-11-27', 'Inactive'), 
('Hamza', 'Dhurandhar@gmail.com', '2025-12-22', 'Active'), 
('Alam', 'PeeloPeeloAlamDhudh@gmail.com', '2023-01-07', 'Inactive'), 
('Yaleena', 'iammatar@gmail.com', '2026-06-22', 'Active'), 
('Jamil', 'duniyakefarz@gmail.com', '1999-08-17', 'Active'), 
('Rehman', 'Sherebaloch@gmail.com', '2012-04-27', 'Inactive'), 
('Ajit', 'youdidwell@gmail.com', '2010-06-27', 'Active'), 
('Arshad', 'freemainmargaya@gmail.com', '2025-11-27', 'Active');

insert into Movie (title, genre, release_Date, rental_rate) values -- Fixed: Added explicit column target layout to handle auto-increment mapping
('Interstellar', 'Sci-Fi', 2014, 4.99),
('Dhurandhar', 'Spy', 2025, 4.8), 
('Dhurandhar 2', 'Spy', 2026, 4.9),
('Son of Sardar', 'Comedy', 2014, 3.9),
('Son of Sardar 2', 'No Comedy', 2026, 1.2),
('Dictator', 'Comedy', 2010, 4.8),
('The Exorcism of God', 'Horrer', 2019, 4.6),
('Royals', 'Drama', 2025, 3.8),
('You', 'Dark Love', 2020, 4.0),
('One piece', 'Adventure', 1998, 5.0),
('Naruto', 'Ninja', 2003, 5.0);

INSERT INTO WatchLog (user_id, movie_id, watch_date, duration_minutes) VALUES
(1, 10, '2026-01-15 20:30:00', 169),
(1, 11, '2023-11-11 10:30:00', 290),
(2, 6, '2022-02-12 23:10:03', 2),
(2, 5, '2023-05-25 12:40:40', 1),
(3, 7, '1992-02-05 01:30:40', 2),
(4, 3, '2022-08-15 14:50:50', 4),
(4, 2, '2022-08-15 18:50:50', 4),
(5, 1, '2025-02-14 10:20:00', 3),
(6, 4, '2021-04-05 16:30:40', 3),
(7, 8, '1994-02-14 10:40:20', 6),
(8, 3, '2023-07-16 20:30:00', 4),
(9, 10, '2026-01-15 20:30:00', 2),
(10, 11, '2002-02-25 20:30:00', 169),
(11, 9, '2016-01-15 20:30:00', 111);

SELECT username, join_date, status 
FROM Users 
WHERE join_date > '2025-01-01' AND status = 'Active';
-- ALTER TABLE Users MODIFY COLUMN join_date DATE;

UPDATE Users
SET status = 'Active'
WHERE username = 'Major Iqbal';

DELETE FROM Users
WHERE status = 'Inactive'
  AND user_id NOT IN (SELECT DISTINCT user_id FROM WatchLog);
  
  
SELECT 
m.genre AS "Genre Name", 
COUNT(w.log_Id) AS "Total Watch Count"
FROM WatchLog w
INNER JOIN Movie m ON w.movie_id = m.movie_id
GROUP BY m.genre
ORDER BY COUNT(w.log_Id) DESC;

