-- 1951. 查询具有最多共同关注者的所有两两结对组
-- https://leetcode.cn/problems/all-the-pairs-with-the-maximum-number-of-common-followers/
-- 解题思路：通过自关联的笛卡尔积求得共同关注者的数量，见此处图片：https://leetcode.cn/problems/all-the-pairs-with-the-maximum-number-of-common-followers/solution/qiang-ge-jie-ti-by-xuesql-ao3u/
with a as (
  select a.user_id as a_user_id,
    b.user_id as b_user_id,
    count(*) as common_followers
  from Relations a
    inner join Relations b on a.user_id < b.user_id
    and a.follower_id = b.follower_id
  group by a.user_id,
    b.user_id
)
select a_user_id as user1_id,
  b_user_id as user2_id
from a
WHERE common_followers = (
    select max(common_followers)
    from a
  )