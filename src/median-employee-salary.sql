-- 569. 员工薪水中位数
-- https://leetcode.cn/problems/median-employee-salary/
-- 学习自：https://leetcode.cn/problems/median-employee-salary/solution/yuan-gong-xin-shui-zhong-wei-shu-by-leetcode/
-- 解题思路：对于一个 奇数 长度数组中的 中位数，大于这个数的数值个数等于小于这个数的数值个数。
SELECT a.Id,
  a.Company,
  a.Salary
FROM Employee a
  LEFT JOIN Employee b ON a.Company = b.Company
GROUP By a.Company,
  a.Salary
HAVING SUM(
    CASE
      WHEN a.Salary = b.Salary THEN 1
      ELSE 0
    END
  ) >= ABS(SUM(SIGN(a.Salary - b.Salary)))
ORDER BY a.Id