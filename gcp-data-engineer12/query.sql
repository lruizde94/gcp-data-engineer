SELECT AVG(price) 
FROM ecommerce_analysis.big_orders
WHERE order_date > TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 30 DAY);

SELECT AVG(price) 
FROM ecommerce_analysis.big_orders_partitioned
WHERE order_date > TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 30 DAY);
