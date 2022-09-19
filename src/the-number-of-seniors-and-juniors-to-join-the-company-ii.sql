-- 2010. 职员招聘人数 II
-- https://leetcode.cn/problems/the-number-of-seniors-and-juniors-to-join-the-company-ii/
with a as (
  select employee_id,
    experience,
    sum(salary) over (
      partition by experience
      order by salary rows between unbounded preceding and current row -- 包括本行和之前所有的行
    ) as cost
  from Candidates
)
select employee_id
from a
where experience = 'Senior' -- 从a中计算高级职员
  and cost <= 70000 -- 总花费小于7w
union all
select employee_id
from a
where experience = 'Junior'
  and cost <= 70000 -(
    select if(max(cost) <= 70000, max(cost), 0) remain -- 返回雇佣了高级职员后的总花费
    from a
    where experience = 'Senior'
      and cost <= 70000
  )