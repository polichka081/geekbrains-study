create DATABASE instagram;
create table users (
id SERIAL PRIMARY KEY,
firstname VARCHAR(255),
lastname VARCHAR(255),
nickname Varchar(255) UNIQUE,
email VARCHAR(120) UNIQUE,
phone BIGINT, 
web_site VARCHAR(255),
bio VARCHAR(255),
    INDEX users_phone_idx(phone),
    INDEX users_firstname_lastname_idx(firstname, lastname),
    INDEX users_nickname_idx(nickname)
);

CREATE TABLE messages (
	id SERIAL PRIMARY KEY,
	from_user_id BIGINT UNSIGNED NOT NULL,
    to_user_id BIGINT UNSIGNED NOT NULL,
    body TEXT,
    created_at DATETIME DEFAULT NOW(),
    INDEX messages_from_user_id (from_user_id),
    INDEX messages_to_user_id (to_user_id),
    FOREIGN KEY (from_user_id) REFERENCES users(id),
    FOREIGN KEY (to_user_id) REFERENCES users(id)
);

CREATE TABLE friends (
	id SERIAL PRIMARY KEY, 
	initiator_user_id BIGINT UNSIGNED NOT NULL,
    target_user_id BIGINT UNSIGNED NOT NULL,
    `status` ENUM('requested', 'approved', 'unfriended', 'declined'),
	requested_at DATETIME DEFAULT NOW(),
	confirmed_at DATETIME,
    FOREIGN KEY (initiator_user_id) REFERENCES users(id),
    FOREIGN KEY (target_user_id) REFERENCES users(id)
);
drop table likes;
CREATE TABLE likes(
	id SERIAL PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
    media_id BIGINT UNSIGNED NOT NULL,
    created_at DATETIME DEFAULT NOW(),
    FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE restrict,
    FOREIGN KEY (media_id) REFERENCES media_inst(id)
);

drop table comments;
CREATE TABLE comments(
	id SERIAL PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
    media_id BIGINT UNSIGNED NOT NULL,
	body TEXT,
    created_at DATETIME DEFAULT NOW(),
    FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE restrict,
    FOREIGN KEY (media_id) REFERENCES media_inst(id)
);

CREATE TABLE photo(
id SERIAL PRIMARY KEY,
NAME VARCHAR(100),
body TEXT,
CREATED_AT DATETIME DEFAULT NOW()
);

CREATE TABLE video(
id SERIAL PRIMARY KEY,
NAME VARCHAR(100),
body TEXT,
CREATED_AT DATETIME DEFAULT NOW()
);

CREATE TABLE media_inst(
	id SERIAL PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
    photo_id BIGINT unsigned ,
    video_id BIGINT unsigned ,
    foreign key (user_id) REFERENCES users(id),
    FOREIGN KEY (photo_id) REFERENCES photo(id),
    FOREIGN KEY (video_id) REFERENCES video(id)
    );
    
    create table few_photos (
    id SERIAL PRIMARY KEY,
    photo BIGINT unsigned ,
    video BIGINT unsigned ,
    FOREIGN KEY (photo) References media_inst(photo_id),
	FOREIGN KEY (video) References media_inst(video_id)
     );

CREATE TABLE CLOSE_FRIENDS(
ID serial primary key,
FRIENDS_ID BIGINT UNSIGNED NOT NULL unique,
FOREIGN KEY (FRIENDS_id) REFERENCES friends(id)
);

drop table stories;
CREATE TABLE stories(
	id SERIAL PRIMARY KEY,
    stories_id BIGINT UNSIGNED NULL,
    name VARCHAR(255),
    is_actual TINYINT(1),
    created_at DATETIME DEFAULT NOW(),
    FOREIGN KEY (ID) REFERENCES USERS (ID),
    FOREIGN KEY (STORIES_ID) REFERENCES users(ID)
);

use instagram;
INSERT INTO users VALUES
(NULL, 'Angelina', 'Jolie', 'angeactress', 'ange@yandex.ru', '89036547839', 'www.jolie.com', 'Hello, I am an actress and I glad to see you on my page');

INSERT INTO users VALUES
(NULL, 'Brad', 'Pitt', 'bradpitt', 'braddpitt@mail.ru', '89036757839', 'www.bradpitt.com', NULL),
(NULL, 'Joseph', 'Tribbiani', 'trib_j', 'jonny@bk.ru.ru', '89266757939', NULL, 'Hello, gyes'),
(NULL, 'Monica', 'Geller', 'mo.ni.ca', 'monic@mail.ru.ru', '89054897839', 'www.monica.twitter.com', 'Hi my dear friends, I am 30 years old and working as a cooker'),
(NULL, 'Ross', 'Geller', 'ross11', 'ross@yandex.ru', '8906447839', 'www.rossgel.com', 'Love you people'),
(NULL, 'Rachel ', 'Green', 'princess_r', 'green@rambler.ru', '8678092839', 'NULL', 'Hello everybody! I love Life!!!'),
(NULL, 'Phoebe', 'Buffay', 'buffaypage', 'bb@yandex.ru', '8929667839', 'NULL', 'musician'),
(NULL, 'Chandler', 'Bing', 'bingbang', 'chandler@yandex.ru', '89098761231', 'www.chandler.com', NULL);

INSERT INTO messages VALUES
(NULL, 1, 2, 'Hi, how are you?', default);

INSERT INTO messages VALUES
(NULL, 2, 1, 'Fine, and you?', default),
(NULL, 3, 5, 'please check my new photo', default),
(NULL, 3, 6, 'cool photo!', default),
(NULL, 6, 3, 'Thank you, do you want with us to the cafe?', default),
(NULL, 3, 6, 'Of cause!!', default),
(NULL, 4, 6, 'I want my dress back)', default),
(NULL, 6, 4, 'Okayyyyy((((', default),
(NULL, 5, 8, 'Hi Chad, I write you in Facebook, read my message', default),
(NULL, 8, 4, 'I am waiting for you at home with cake, watch photo!', default),
(NULL, 6, 1, 'I am your great fan!!!', default),
(NULL, 7, 6, 'Today I am playing in our cafe', default),
(NULL, 7, 3, 'good jokeee', default);

INSERT INTO friends VALUES
(NULL, 1, 2, 'approved' , DEFAULT, DEFAULT),
(NULL, 3, 4, 'approved' , DEFAULT, DEFAULT),
(NULL, 3, 5, 'requested' , DEFAULT, DEFAULT),
(NULL, 3, 6, 'approved' , DEFAULT, DEFAULT),
(NULL, 3, 7, 'approved' , DEFAULT, DEFAULT),
(NULL, 3, 8, 'approved' , DEFAULT, DEFAULT),
(NULL, 4, 5, 'approved' , DEFAULT, DEFAULT),
(NULL, 4, 6, 'approved' , DEFAULT, DEFAULT),
(NULL, 4, 7, 'approved' , DEFAULT, DEFAULT),
(NULL, 4, 8, 'approved' , DEFAULT, DEFAULT),
(NULL, 5, 2, 'declined' , DEFAULT, DEFAULT),
(NULL, 5, 6, 'approved' , DEFAULT, DEFAULT),
(NULL, 5, 7, 'approved' , DEFAULT, DEFAULT),
(NULL, 5, 8, 'approved' , DEFAULT, DEFAULT),
(NULL, 7, 1, 'requested' , DEFAULT, DEFAULT),
(NULL, 7, 6, 'requested' , DEFAULT, DEFAULT),
(NULL, 7, 8, 'approved' , DEFAULT, DEFAULT),
(NULL, 8, 5, 'requested' , DEFAULT, DEFAULT);

INSERT INTO photo VALUES
(NULL, 'fgffgds', 'Me new dog', Default),
(NULL, '34356dfdf', 'Hiii people', Default),
(NULL, '4354356fcgvcbv', 'I bought new iphone', Default),
(NULL, '345456,.ytdfg', 'Beautiful landscape', Default),
(NULL, 'vbvnbmn', 'My Mummy', Default);

INSERT INTO video VALUES
(NULL, '8906573', 'My lovely rabbit', Default),
(NULL, 'gfhdha', 'I am playing guitar, please like me', Default);

Alter table media_inst Add Column user_id BIGINT UNSIGNED NOT NULL after id;

Insert into media_inst Values
(NULL, 2, 1, NULL),
(NULL, 3, 2, NULL),
(NULL, 6, 3, NULL),
(NULL, 8, 4, NULL),
(NULL, 4, 5, NULL);

Insert into media_inst Values
(NULL, 4, NULL, 1),
(NULL, 3, NULL, 2);

Insert into likes Values
(NULL, 1, 13, default),
(NULL, 3, 13, default),
(NULL, 5, 13, default),
(NULL, 7, 13, default),
(NULL, 8, 13, default);

Insert into likes Values
(NULL, 4, 14, default),
(NULL, 5, 14, default),
(NULL, 6, 14, default),
(NULL, 7, 14, default),
(NULL, 8, 14, default),
(NULL, 8, 15, default),
(NULL, 7, 15, default),
(NULL, 5, 15, default),
(NULL, 4, 15, default),
(NULL, 3, 15, default),
(NULL, 2, 15, default),
(NULL, 4, 16, default),
(NULL, 3, 16, default),
(NULL, 5, 16, default),
(NULL, 7, 16, default),
(NULL, 3, 17, default),
(NULL, 5, 17, default),
(NULL, 8, 17, default),
(NULL, 6, 17, default),
(NULL, 2, 18, default),
(NULL, 3, 18, default),
(NULL, 5, 18, default),
(NULL, 6, 18, default),
(NULL, 7, 18, default),
(NULL, 8, 18, default),
(NULL, 4, 19, default),
(NULL, 5, 19, default),
(NULL, 6, 19, default),
(NULL, 7, 19, default),
(NULL, 8, 19, default);

Insert into comments Values
(NULL, 1, 13, 'I love him ', default),
(NULL, 5, 13,'So cute!', default);

Insert into comments Values
(NULL, 4, 15, 'wowwww ', default),
(NULL, 5, 16,'Really beautiful)))!', default),
(NULL, 6, 18, 'likeeeee ', default),
(NULL, 8, 19,'good job!', default);

Insert into close_friends Values
(NULL, 1),
(NULL, 7),
(NULL, 6),
(NULL, 5);

Insert into stories Values
(NULL, 1, '4437474', 1, DEFAULT);

Insert into stories Values
(NULL, 1, '4437474', 1, DEFAULT),
(NULL, 1, '4565465464', 0, DEFAULT),
(NULL, 4, '44gfdhghf67', 0, DEFAULT),
(NULL, 6, '676ytuty', 0, DEFAULT),
(NULL, 6, '44565464', 1, DEFAULT),
(NULL, 7, '4fdgfgfg', 1, DEFAULT);

-------------
Select firstname, phone FrOM users;
Select body FrOM messages WHERE from_user_id = 1 
OR to_user_id = 2;
select id as stories from stories order by (is_actual) DESC;
Select UPPER (nickname) from users;
SELECT email FROM users WHERE email LIKE '%mail%' OR email LIKE '%bk%';
select COUNT(media_id) as photo_likes FROM likes WHERE media_id = 13;
alter table stories ADD COLumn active_inactive varchar (100) after is_actual;
SET SQL_SAFE_UPDATES = 0;
UPDATE stories set active_inactive = CASE 
when is_actual = 1 then 'active story'
when is_actual < 1 then 'inactive stories'
end;
SELECT users.nickname, media_inst.photo_id 
from users left join media_inst
ON users. id = media_inst. user_id;
SELECT users.nickname, media_inst.video_id 
from users left join media_inst
ON users. id = media_inst. user_id;
select nickname from users where id = 1
union select body from messages where from_user_id = 1;
CREATE VIEW photo_user_id4 AS
SELECT photo_id, video_id
FROM Media_inst
WHERE user_id = 4;

CREATE VIEW messages_3 AS
SELECT Count(id)
FROM messages
WHERE from_user_id = 3 and to_user_id = 3;

use instagram;

delimiter $$
create trigger deletemessages after delete on users
FOR each row begin
delete from messages where user_id =OLD.id;
end

delimiter $$
Create procedure getallmedia()
begin
select id, photo_id, video_id from media_inst;
end $$







