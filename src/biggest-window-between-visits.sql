-- 1709. 访问日期之间最大的空档期
-- https://leetcode.cn/problems/biggest-window-between-visits/
with a as (
  SELECT *,
    LEAD(visit_date, 1, '2021-01-01') OVER (
      PARTITION BY user_id
      ORDER BY visit_date
    ) AS next_visit_date
  FROM UserVisits
)
select user_id,
  max(datediff(next_visit_date, visit_date)) as biggest_window
from a
GROUP BY user_id