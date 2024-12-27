-- Create the database
CREATE DATABASE instagram;
USE instagram;

-- Users Table
CREATE table users ( ID int auto_increment,
username varchar(255) unique not null,
Created_at datetime Default now(),
primary key(ID)
);
-- Photos Table
CREATE table photos (ID int auto_increment,
user_id int,
image_url varchar(255) NOT NULL,
Created_at datetime Default now(),
primary key(ID),
Foreign key (user_id) references users(id) ON DELETE CASCADE ON UPDATE CASCADE
);
-- Comments Table
CREATE table comments (ID int auto_increment,
comment_text VARCHAR(1600) not null,
Created_at datetime Default now(),
user_id int,
photo_id int,
primary key (ID),
foreign key (photo_id) references photos(ID) ON UPDATE CASCADE,
foreign key(user_id) references users(ID) ON UPDATE CASCADE
);
-- Likes Table
CREATE table likes (
user_id int,
photo_id int,
Created_at datetime Default now(),
primary key (user_id,photo_id),
foreign key (photo_id) references photos(ID) ON UPDATE CASCADE,
foreign key(user_id) references users(ID) ON UPDATE CASCADE
);

-- Follows Table
CREATE TABLE follows (
    follower_id INT NOT NULL,
    followee_id INT NOT NULL,
    created_at DATETIME DEFAULT NOW(),
    PRIMARY KEY (follower_id, followee_id),
    FOREIGN KEY (follower_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (followee_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE
);
-- Prevent the self follow
DELIMITER $$
CREATE TRIGGER prevent_self_follow
BEFORE INSERT ON follows
FOR EACH ROW
BEGIN
    IF NEW.follower_id = NEW.followee_id THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'A user cannot follow themselves.';
    END IF;
END$$
DELIMITER ;

-- Tags Table
CREATE TABLE Tags (
ID int auto_increment,
tag_name VARCHAR(150),
primary key(ID)
);
-- Photo_tags Table
CREATE TABLE photo_tags (
photo_id int,
tags_id int,
primary key(photo_id,tags_id),
foreign key (photo_id) references photos(ID) on delete CASCADE on update CASCADE,
foreign key(tags_id) references tags(ID)on delete CASCADE on update CASCADE
);
