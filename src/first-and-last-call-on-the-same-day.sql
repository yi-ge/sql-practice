-- 1972. 同一天的第一个电话和最后一个电话
-- https://leetcode.cn/problems/first-and-last-call-on-the-same-day/
-- 学习自：https://leetcode.cn/problems/first-and-last-call-on-the-same-day/solution/1972-tong-yi-tian-de-di-yi-ge-dian-hua-h-akhm/
SELECT DISTINCT u1 user_id
FROM (
    SELECT u1,
      u2,
      dt
    FROM (
        SELECT -- 2. 用户一天内通话行为的时间先后
          u1,
          u2,
          DATE(call_time) dt,
          ROW_NUMBER() OVER(
            PARTITION BY u1,
            DATE(call_time)
            ORDER BY call_time asc
          ) rk_asc,
          ROW_NUMBER() OVER(
            PARTITION BY u1,
            DATE(call_time)
            ORDER BY call_time desc
          ) rk_desc
        FROM (
            -- 1. 列出用户所有的通话行为(呼出，或接听)
            SELECT caller_id u1,
              recipient_id u2,
              call_time
            FROM Calls
            UNION ALL
            SELECT recipient_id u1,
              caller_id u2,
              call_time
            FROM Calls
          ) t1
      ) t2
    WHERE rk_asc = 1
      or rk_desc = 1 -- 3. 筛选出用户一天内的第一通和最后一通通话
  ) t3
GROUP BY u1,
  dt -- 4. 按用户日期聚合
HAVING COUNT(DISTINCT u2) = 1 -- 5. 筛选出一天内，第一通和最后一通电话都为同一人的记录。
  -- 作者：blacksqaoo
  -- 链接：https://leetcode.cn/problems/first-and-last-call-on-the-same-day/solution/1972-tong-yi-tian-de-di-yi-ge-dian-hua-h-akhm/
  -- 来源：力扣（LeetCode）
  -- 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。