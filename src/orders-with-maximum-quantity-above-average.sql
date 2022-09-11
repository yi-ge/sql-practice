-- 1867. 最大数量高于平均水平的订单
-- https://leetcode.cn/problems/orders-with-maximum-quantity-above-average/
select order_id
from OrdersDetails
GROUP BY order_id
HAVING max(quantity) > (
    select avg(quantity)
    from OrdersDetails
    GROUP BY order_id
    ORDER BY avg(quantity) DESC
    LIMIT 1
  )