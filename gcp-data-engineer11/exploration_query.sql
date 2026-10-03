SELECT 
  product,
  COUNT(*) AS total_orders,
  AVG(price) AS avg_price,
  SUM(high_value_order) AS high_value_count
FROM ecommerce_analysis.orders_features
GROUP BY product
ORDER BY 2 DESC, 4 desc, 3 desc;
