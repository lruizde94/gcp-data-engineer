CREATE OR REPLACE TABLE ecommerce_analysis.big_orders_partitioned
PARTITION BY DATE(order_date) AS
SELECT * FROM ecommerce_analysis.big_orders;