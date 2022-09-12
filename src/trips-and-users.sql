-- 262. 行程和用户
-- https://leetcode.cn/problems/trips-and-users/
select a.request_at as 'Day',
  round(cancell_count / all_count, 2) as 'Cancellation Rate'
from (
    select sum(if(Trips.status != 'completed', 1, 0)) as cancell_count,
      request_at
    from Trips,
      Users
    where Trips.client_id = Users.users_id
      and Users.banned = 'No'
      and Trips.request_at BETWEEN "2013-10-01" AND "2013-10-03"
      and Trips.driver_id not in (
        select users_id as driver_id
        from Users
        where banned = 'Yes'
          and role = 'driver'
      )
    GROUP BY request_at
  ) a,
  (
    select count(*) as all_count,
      request_at
    from Trips,
      Users
    where Trips.client_id = Users.users_id
      and Users.banned = 'No'
      and Trips.request_at BETWEEN "2013-10-01" AND "2013-10-03"
      and Trips.driver_id not in (
        select users_id as driver_id
        from Users
        where banned = 'Yes'
          and role = 'driver'
      )
    GROUP BY request_at
  ) b
WHERE a.request_at = b.request_at