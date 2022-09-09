-- 1747. 应该被禁止的 Leetflex 账户
-- https://leetcode.cn/problems/leetflex-banned-accounts/
SELECT DISTINCT a.account_id
FROM LogInfo a
  INNER JOIN LogInfo b ON a.account_id = b.account_id
  AND a.ip_address != b.ip_address
  AND (
    a.login BETWEEN b.login AND b.logout
    or a.logout BETWEEN b.login AND b.logout
  )