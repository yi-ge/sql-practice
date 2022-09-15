-- 1454. 活跃用户
-- https://leetcode.cn/problems/active-users/
select distinct id,
  name
from (
    select id,
      login_date,
      datediff(
        lead(login_date, 4) over(
          partition by id
          order by login_date
        ),
        login_date
      ) diff
    from logins
    group by id,
      login_date
  ) a
  left join accounts using(id)
where diff = 4