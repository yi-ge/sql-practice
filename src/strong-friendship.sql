-- 1949. 坚定的友谊
-- https://leetcode.cn/problems/strong-friendship/
-- 这里有个坑 ，坚定的友谊的前提是他们必须是朋友 。
-- 有可能有俩人共同好友大于等于3 ，但是他俩不是朋友 。
-- 由于题目担保了user1_id < user2_id，
-- 因此可以在最后一步用(f1.user_id, f2.user_id) in (select * from Friendship)
-- 查一下这俩是不是朋友。
WITH fAll AS (
  SELECT user1_id as 'user_id',
    user2_id as 'friend_id'
  FROM Friendship
  union
  SELECT user2_id,
    user1_id
  FROM Friendship
)
SELECT f1.user_id as user1_id,
  f2.user_id as user2_id,
  count(*) common_friend
FROM fAll f1
  INNER JOIN fAll f2 ON f1.friend_id = f2.friend_id
  AND f1.user_id < f2.user_id
  AND (f1.user_id, f2.user_id) in (
    select *
    from Friendship
  )
GROUP BY user1_id,
  user2_id
HAVING common_friend >= 3