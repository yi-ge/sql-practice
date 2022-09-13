-- 1596. 每位顾客最经常订购的商品
-- https://leetcode.cn/problems/the-most-frequently-ordered-products-for-each-customer/
SELECT customer_id,
  T.product_id,
  product_name
FROM(
    SELECT customer_id,
      product_id,
      RANK() OVER(
        PARTITION BY customer_id
        ORDER BY COUNT(*) DESC
      ) AS tm
    FROM Orders o
    GROUP BY customer_id,
      product_id
  ) T
  LEFT JOIN Products on Products.product_id = T.product_id
WHERE tm = 1