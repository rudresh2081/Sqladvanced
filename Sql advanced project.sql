use ig_clone

# We want to reward the user who has been around the longest, Find the 5 oldest users.
select * from users
order by created_at 
limit 5

#2.To target inactive users in an email ad campaign, find the users who have never posted a photo.
select * from photos
select * from users

SELECT username, id
FROM users
WHERE id NOT IN (SELECT distinct user_id  FROM photos as p);

#3.Suppose you are running a contest to find out who got the most likes on a photo. Find out who won?
select * from likes
select * from photos
select * from users

SELECT user_id, MAX(photo_id) AS max_likes
FROM likes
GROUP BY user_id
ORDER BY max_likes DESC
LIMIT 1;

#4.The investors want to know how many times does the average user post.


SELECT AVG(post_count) AS average_posts_per_user
FROM (
    SELECT user_id, COUNT(*) AS post_count
    FROM photos
    GROUP BY user_id
) AS user_posts;

#5.A brand wants to know which hashtag to use on a post, and find the top 5 most used hashtags.
select * from tags
select * from photo_tags

select count(photo_id) as total_count, tag_id from photo_tags
group by tag_id
order by total_count desc
limit 5

#6.To find out if there are bots, find users who have liked every single photo on the site

select * from users
select * from likes

SELECT id, username
FROM users
WHERE id NOT IN (
    SELECT DISTINCT user_id
    FROM photos
    EXCEPT
    SELECT user_id
    FROM likes
);


#7.Find the users who have created instagramid in may and select top 5 newest joinees from it
SELECT id, created_at
FROM users
WHERE EXTRACT(MONTH FROM created_at) = 5
ORDER BY created_at DESC
LIMIT 5;

#8.Can you help me find the users whose name starts with c and ends with any number and have posted the photos as well as liked the photos?

SELECT u.id, u.username
FROM users u
WHERE u.username ~ '^C.*[0-9]$'
AND EXISTS (
    SELECT 1
    FROM photos p
    WHERE p.user_id = u.id
)
AND EXISTS (
    SELECT 1
    FROM likes l
    WHERE l.user_id = u.id
);

#9.Demonstrate the top 30 usernames to the company who have posted photos in the range of 3 to 5.
SELECT username, COUNT(*) AS post_count
FROM users u
JOIN photos p ON u.id = p.user_id
GROUP BY u.username
HAVING COUNT(*) BETWEEN 3 AND 5
ORDER BY post_count DESC
LIMIT 30;
