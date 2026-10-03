CREATE OR REPLACE VIEW ecommerce_analysis.orders_weekly AS
SELECT 
  FORMAT_DATE("%G-W%V", DATE(order_date)) AS week,
  COUNT(order_id) AS total_orders,
  SUM(price) AS total_revenue
FROM ecommerce_analysis.orders_raw
GROUP BY week
ORDER BY week;
