-- 1285. 找到连续区间的开始和结束数字
-- https://leetcode.cn/problems/find-the-start-and-end-number-of-continuous-ranges/
-- 解题思路：https://leetcode.cn/problems/find-the-start-and-end-number-of-continuous-ranges/solution/san-chong-fang-fa-xiang-jie-zhao-dao-lia-mc2h/
select min(log_id) start_id,
  max(log_id) end_id
from (
    SELECT log_id,
      log_id - row_number() OVER() diff
    from logs
  ) a
GROUP BY diff