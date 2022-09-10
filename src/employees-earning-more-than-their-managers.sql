-- 181. 超过经理收入的员工
-- https://leetcode.cn/problems/employees-earning-more-than-their-managers/
SELECT a.name AS Employee
FROM Employee AS a
  JOIN Employee AS b
WHERE a.managerId = b.id
  AND a.Salary > b.salary