-- 1549. 每件商品的最新订单
-- https://leetcode.cn/problems/the-most-recent-orders-for-each-product/
select product_name,
  products.product_id,
  order_id,
  order_date
from products,
  orders
WHERE products.product_id = orders.product_id
  AND (products.product_id, order_date) in (
    SELECT product_id,
      max(order_date) as order_date
    FROM orders
    GROUP BY product_id
  )
order by product_name,
  product_id,
  order_id