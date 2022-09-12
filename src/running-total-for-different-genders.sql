-- 1308. 不同性别每日分数总计
-- https://leetcode.cn/problems/running-total-for-different-genders/
SELECT gender,
  day,
  SUM(score_points) OVER (
    PARTITION BY gender
    ORDER BY day
  ) AS total
FROM Scores