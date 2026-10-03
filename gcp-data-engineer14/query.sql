SELECT
  COUNT(*), AVG(price)
FROM `ecommerce_analysis.big_orders`;

SELECT
  COUNT(*), max(order_date)
FROM `ecommerce_analysis.big_orders`;