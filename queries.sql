-- select * from users limit 10;
-- select * from photos limit 10;
-- select * from comments limit 10;
-- select * from likes limit 10;
-- select * from follows limit 10;
-- select * from tags limit 10;
-- select * from photo_tags limit 10;



-- desc users;
-- desc photos;
-- desc comments;
-- desc likes;
-- desc follows;
-- desc tags;
-- desc photo_tags;




-- Triggers
-- Trigger to show a useless update,i.e., redundant update
UPDATE users SET username = 'Billy52' where username = 'Billy52';

-- Trigger to avoid the user following himself
INSERT INTO follows (follower_id, following_id)  values (2, 2);

-- Trigger to keep a log of users unfollowing
DELETE FROM follows where follower_id = 2 and following_id = 6;
SELECT * FROM unfollows;


-- MySQL Queries
-- To get the first five users joined this instagram 
SELECT * FROM users ORDER BY created_at LIMIT 5;

-- To get the days, when highest users have joined this instagram
SELECT DAYNAME(created_at) AS day, COUNT(*) AS total FROM users
GROUP BY day ORDER BY total DESC;

-- To get the users with no photos(Inactive Users)
SELECT username FROM users LEFT JOIN photos ON
users.id = photos.user_id WHERE photos.id IS NULL;

-- TO get the user and the photo which is most popular
SELECT username, photos.id, photos.image_url, COUNT(*) AS total
FROM photos INNER JOIN likes ON likes.photo_id = photos.id 
INNER JOIN users ON photos.user_id = users.id GROUP BY photos.id
ORDER BY total DESC LIMIT 1;

-- To get the average no. of photos per user
SELECT (SELECT Count(*) FROM   photos) / (SELECT Count(*) FROM   users) AS avg;

-- To get the top 5 tag-names tagged by users
SELECT tags.tag_name, Count(*) AS total FROM   photo_tags JOIN tags 
ON photo_tags.tag_id = tags.id GROUP  BY tags.id ORDER BY total DESC 
LIMIT  5;

-- To get the users who have liked all the photos of every user(BOTS)
SELECT username, Count(*) AS num_likes FROM   users INNER JOIN likes
ON users.id = likes.user_id GROUP  BY likes.user_id 
HAVING num_likes = (SELECT Count(*) FROM   photos);
