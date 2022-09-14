-- 1613. 找到遗失的ID
-- https://leetcode.cn/problems/find-the-missing-ids/
WITH RECURSIVE num AS (
  SELECT 1 AS n
  UNION ALL
  SELECT n + 1
  FROM num
  WHERE n < 100
)
SELECT n AS ids
FROM num
WHERE n NOT IN (
    SELECT customer_id
    FROM Customers
  )
  AND n <=(
    SELECT MAX(customer_id)
    FROM Customers
  )