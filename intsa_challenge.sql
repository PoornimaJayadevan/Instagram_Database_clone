# 1. Finding first 5 oldest users
USE ig_clone; 
SELECT * FROM users
ORDER BY created_at 
LIMIT 5;

# 2. Most popular registration date

SELECT DAYNAME(created_at) AS weekday, 
COUNT(DAYNAME(created_at)) AS count
 FROM USERS
GROUP BY weekday
order by count desc
limit 2;

 
  SELECT
    DAYNAME(created_at) AS day,
         COUNT(*) AS Total_Registrations
     FROM users
     GROUP BY day
     HAVING Total_Registrations =
     (SELECT COUNT(*)
         FROM users
         GROUP BY DAYNAME(created_at)
         ORDER BY COUNT(*) DESC
         LIMIT 1);        
         
# 3. Identify inactive users         
DESC users;		
SELECT username, users.id, user_id FROM users
LEFT JOIN photos ON users.id = photos.user_id 
WHERE user_id IS NULL
GROUP BY username;

# 4. Most likes on a single photo
DESC LIKES;
DESC photos;
SELECT users.id, username, photos.id FROM users
JOIN photos ON photos.user_id = users.id
JOIN likes ON likes.photo_id = photos.id;

SELECT users.id, username, photo_id, COUNT(*) AS count FROM users
JOIN photos ON photos.user_id = users.id
JOIN likes ON likes.photo_id = photos.id
GROUP BY photo_id
ORDER BY count DESC
LIMIT 1;


# 5. Calculate avg no of photos per user

#DESC photos;
SELECT (SELECT Count(*) 
        FROM   photos) / (SELECT Count(*) 
                          FROM   users) AS avg;
                          
#  6. Five most used hashtags

#DESC tags;
#DESC photo_tags;      
           
SELECT tag_id, COUNT(tag_id), tag_name FROM photo_tags
JOIN tags ON tags.id = photo_tags.tag_id
GROUP BY tag_id
ORDER BY COUNT(tag_id) DESC
LIMIT 8;     

SELECT tag_id, COUNT(tag_id) AS count_name, tag_name FROM photo_tags
JOIN tags ON tags.id = photo_tags.tag_id
GROUP BY tag_id
HAVING count_name >= (SELECT COUNT(*) AS photo_count
    FROM tags
    JOIN photo_tags ON tags.id = photo_tags.tag_id
    GROUP BY tags.tag_name
    ORDER BY photo_count DESC
    LIMIT 1 OFFSET 4)
    ORDER BY COUNT(tag_id) DESC;      
    
# 7. Finding users who have liked all photos
#DESC likes;

SELECT user_id, username, COUNT(user_id) AS total_likes FROM likes
JOIN users ON users.id = likes.user_id
GROUP BY user_id
HAVING total_likes = (SELECT photo_id from likes
 GROUP BY photo_id
 ORDER BY photo_id DESC
 LIMIT 1) ;
 
SELECT user_id, username, COUNT(user_id) AS total_likes FROM likes
JOIN users ON users.id = likes.user_id
GROUP BY user_id
HAVING total_likes = (SELECT COUNT(*) FROM photos) ; 
