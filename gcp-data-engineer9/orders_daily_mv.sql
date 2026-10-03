CREATE MATERIALIZED VIEW ecommerce_analysis.orders_daily_mv AS
SELECT 
  DATE(order_date) AS order_day,
  COUNT(order_id) AS total_orders,
  SUM(price) AS total_revenue
FROM ecommerce_analysis.orders_raw
GROUP BY order_day;