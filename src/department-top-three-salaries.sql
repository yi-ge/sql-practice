-- 185. 部门工资前三高的所有员工
-- https://leetcode.cn/problems/department-top-three-salaries/
SELECT c.Name AS 'Department',
  a.Name as 'Employee',
  a.Salary
from Employee a
  JOIN Department c ON a.DepartmentId = c.Id
where (
    select count(distinct b.Salary)
    from Employee b
    where b.Salary > a.Salary
      AND a.DepartmentId = b.DepartmentId
  ) < 3