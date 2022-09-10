-- 180. 连续出现的数字
-- https://leetcode.cn/problems/consecutive-numbers/
SELECT DISTINCT a.num as ConsecutiveNums
FROM Logs AS a,
  Logs AS b,
  Logs AS c
WHERE a.num = b.num
  AND b.num = c.num
  AND a.id = b.id + 1
  AND b.id = c.id + 1