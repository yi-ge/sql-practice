-- 178. 分数排名
-- https://leetcode.cn/problems/rank-scores/
select score,
  dense_rank() over(
    ORDER BY score DESC
  ) as 'rank'
from Scores