-- 177. 第N高的薪水
-- https://leetcode.cn/problems/nth-highest-salary/
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT BEGIN
SET N := N -1;
RETURN (
  SELECT salary
  FROM employee
  GROUP BY salary
  ORDER BY salary DESC
  LIMIT N, 1
);
END