-- 1501. 可以放心投资的国家
-- https://leetcode.cn/problems/countries-you-can-safely-invest-in/
with t as (
  select country,
    duration
  from (
      select id,
        Country.name as country
      from Person
        left join Country on Country.country_code = substring_index(phone_number, '-', 1)
    ) a,
    (
      select caller_id as id,
        duration
      from Calls
      union all
      select callee_id as id,
        duration
      from Calls
    ) b
  where a.id = b.id
)
select country
from t
group by country
having avg(duration) > (
    select avg(duration)
    from t
  )