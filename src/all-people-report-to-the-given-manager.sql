-- 1270. 向公司CEO汇报工作的所有人
-- https://leetcode.cn/problems/all-people-report-to-the-given-manager/
SELECT t1.employee_id
FROM Employees t1
  JOIN Employees t2 ON t1.manager_id = t2.employee_id
  JOIN Employees t3 ON t2.manager_id = t3.employee_id
WHERE t1.employee_id != 1
  AND t3.manager_id = 1