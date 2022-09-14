-- 1532. 最近的三笔订单
-- https://leetcode.cn/problems/the-most-recent-three-orders/
SELECT customer_name,
  customer_id,
  order_id,
  order_date
FROM (
    SELECT name as customer_name,
      Orders.customer_id,
      order_id,
      order_date,
      ROW_NUMBER() OVER (
        PARTITION BY Orders.customer_id
        ORDER BY order_date DESC
      ) AS row_id
    FROM Orders,
      Customers
    WHERE Customers.customer_id = Orders.customer_id
  )
WHERE row_id < 4
ORDER BY customer_name,
  Orders.customer_id,
  order_date DESC