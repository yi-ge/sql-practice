-- 1126. 查询活跃业务
-- https://leetcode.cn/problems/active-businesses/
SELECT business_id
FROM Events
  JOIN(
    SELECT event_type,
      AVG(occurences) as avg_occurences
    FROM Events
    GROUP BY event_type
  ) as e ON Events.event_type = e.event_type
  AND Events.occurences > e.avg_occurences
GROUP BY business_id
HAVING COUNT(*) >= 2