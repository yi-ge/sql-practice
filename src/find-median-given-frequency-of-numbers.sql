-- 571. 给定数字的频率查询中位数
-- https://leetcode.cn/problems/find-median-given-frequency-of-numbers/
-- 学习自：https://leetcode.cn/problems/find-median-given-frequency-of-numbers/solution/sum-over-order-by-by-fugue-s/
-- 解题思路：当某一数字的 正序和逆序累计 均大于 整个序列的数字个数的一半 时即为中位数。
select avg(num) median
from (
    select num,
      sum(frequency) over(
        order by num
      ) asc_accumu,
      sum(frequency) over(
        order by num desc
      ) desc_accumu
    from numbers
  ) t1,
  (
    select sum(frequency) total
    from numbers
  ) t2
where asc_accumu >= total / 2
  and desc_accumu >= total / 2