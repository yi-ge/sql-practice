-- 1384. 按年度列出销售总额
-- https://leetcode.cn/problems/total-sales-amount-by-year/
-- 学习自：https://leetcode.cn/problems/total-sales-amount-by-year/solution/by-coupondeal-e-y8ia/
-- 凡是涉及到range，默认采取“前闭后开”的原则。具体地，由于题目中输入数据的 period_end 被定义为包含当天（即闭区间），
-- 因此需要加1使之变为开区间 ADDDATE(period_end, 1)，因此，与之相对应的下界成为yr 次年的元旦，即 MAKEDATE(yr+1, 1)。
WITH a AS (
  SELECT yr,
    product_id,
    (
      DATEDIFF(
        -- LEAST 取出最小是
        LEAST(ADDDATE(period_end, 1), MAKEDATE(yr + 1, 1)),
        -- MAKEDATE(2018, 1) = DATE("2018-01-01")
        -- GREATEST 取出最大的值
        GREATEST(period_start, MAKEDATE(yr, 1))
      )
    ) * average_daily_sales AS amt
  FROM (
      VALUES ROW(2018),
        ROW(2019),
        ROW(2020)
    ) yr_t(yr),
    -- 2018-2020 编年表 避免重复语句
    Sales
  HAVING amt > 0
)
SELECT p.product_id,
  p.product_name,
  CONCAT("", yr) AS report_year,
  SUM(amt) AS total_amount
FROM product p
  LEFT JOIN a ON p.product_id = a.product_id
GROUP BY 1,
  3
ORDER BY 1,
  3