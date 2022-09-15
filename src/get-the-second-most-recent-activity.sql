-- 1369. 获取最近第二次的活动
-- https://leetcode.cn/problems/get-the-second-most-recent-activity/
WITH activity AS (
  SELECT *,
    rank() over(
      partition by username
      order by startDate desc
    ) as rank_id,
    COUNT(*) over(partition by username) as user_count
  FROM UserActivity
)
SELECT username,
  activity,
  startDate,
  endDate
from activity
WHERE rank_id = 2
  or user_count = 1