-- 1321. 餐馆营业额变化增长
-- https://leetcode.cn/problems/restaurant-growth/
WITH a AS (
  select visited_on,
    sum(amount) OVER (
      ORDER BY visited_on ROWS 6 PRECEDING
    ) AS amount
  from (
      SELECT visited_on,
        sum(amount) as amount
      from Customer
      GROUP BY visited_on
    ) v
)
select distinct visited_on,
  amount,
  ROUND(amount / 7, 2) as average_amount
from a
where visited_on >= (
    select min(visited_on)
    from Customer
  ) + 6
  /*
   datediff(
   visited_on,
   (
   select min(visited_on)
   from Customer
   )
   ) >= 6
   */