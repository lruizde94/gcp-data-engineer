CREATE OR REPLACE TABLE ecommerce_analysis.orders_features AS
SELECT
  order_id,
  user_id,
  product,
  price,
  order_date,
  EXTRACT(DAYOFWEEK FROM order_date) AS day_of_week,
  EXTRACT(HOUR FROM order_date) AS order_hour,
  CASE WHEN price > 100 THEN 1 ELSE 0 END AS high_value_order
FROM ecommerce_analysis.orders_features;