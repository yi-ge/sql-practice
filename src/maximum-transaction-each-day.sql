-- 1831. 每天的最大交易
-- https://leetcode.cn/problems/maximum-transaction-each-day/
SELECT transaction_id
FROM Transactions
WHERE (day(day), amount) in (
    SELECT day(day) as day,
      max(amount) as amount
    FROM Transactions
    GROUP BY day(day)
  )
ORDER BY transaction_id