-- 1045. 买下所有产品的客户
-- https://leetcode.cn/problems/customers-who-bought-all-products/
SELECT customer_id
FROM customer
GROUP BY customer_id
HAVING COUNT(DISTINCT product_key) = (
    SELECT count(*)
    FROM product
  )