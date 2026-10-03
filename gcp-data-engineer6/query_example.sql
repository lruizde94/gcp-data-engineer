SELECT name, COUNT(order_id) AS total_pedidos, SUM(price) AS total_gastado
FROM ecommerce_dataset.denormalized_view
GROUP BY name
ORDER BY total_gastado DESC;
