-- 1303. 求团队人数
-- https://leetcode.cn/problems/find-the-team-size/
SELECT Employee.employee_id,
  a.team_size
FROM Employee
  left join (
    select team_id,
      count(*) as team_size
    from Employee
    GROUP BY team_id
  ) a on Employee.team_id = a.team_id