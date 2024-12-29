-- Finding the 5 oldest users
use instagram;
select id,username,created_at from users order by Created_at limit 5;

-- What day of the week do more users register
use instagram;
 select dayname(created_at) as DAY,count(username) as Number_of_Users from users group by dayname(created_at) order by Number_of_users DESC limit 2;
 
 -- Find the users who haven't posted the picture
 use instagram;
select username from users left join photos on users.id=photos.user_id where photos.created_at is null;

-- Find the photo which has Highest likes
USE instagram;
select username,photos.id,image_url,count(likes.user_id) from users 
join photos on users.id=photos.user_id 
join likes on photos.id = likes.photo_id 
group by photos.id 
order by count(likes.user_id) desc
limit 1;

-- Find the avg of phots posted by users
use instagram;
select (select count(*) from photos)/(select count(*) from users) as avg;

-- Find top 5 tags
use instagram;
select count(photo_id) as Number_of_photos,tag_name from photo_tags 
join tags on tags.id=photo_tags.tags_id  
group by tags_id
order by Number_of_photos desc 
 limit 5;
 
 -- Find the user who have liked all post in database
 Use instagram;
 select username,Count(*) as num_likes from users
 join likes on users.id=likes.user_id 
 group by username having num_likes = (select count(*) from photos);