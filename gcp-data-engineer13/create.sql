CREATE SCHEMA ecommerce_analysis OPTIONS(location="US");

CREATE TABLE ecommerce_analysis.orders_raw (
  order_id INT64,
  user_id INT64,
  product STRING,
  price NUMERIC,
  order_date TIMESTAMP
);

INSERT INTO ecommerce_analysis.orders_raw (order_id, user_id, product, price, order_date) VALUES
(4, 103, "Laptop", 1250, "2025-01-03 11:20:00"),
(5, 104, "Mouse", 25, "2025-01-04 09:00:00"),
(6, 102, "Keyboard", 50, "2025-01-04 09:05:00"),
(7, 105, "Monitor", 350, "2025-01-05 14:30:00"),
(8, 101, "Mouse", 20, "2025-01-06 10:00:00"),
(9, 106, "Laptop", 1150, "2025-01-07 18:10:00"),
(10, 107, "Headphones", 80, "2025-01-08 12:45:00"),
(11, 103, "Mouse", 22, "2025-01-09 13:00:00"),
(12, 108, "Monitor", 320, "2025-01-10 17:30:00"),
(13, 105, "Webcam", 75, "2025-01-11 09:50:00"),
(14, 109, "Keyboard", 55, "2025-01-12 10:35:00"),
(15, 110, "Laptop", 1300, "2025-01-13 11:55:00"),
(16, 102, "Headphones", 70, "2025-01-14 19:00:00"),
(17, 104, "Monitor", 300, "2025-01-15 14:10:00"),
(18, 106, "Mouse", 25, "2025-01-16 15:20:00"),
(19, 101, "Webcam", 85, "2025-01-17 08:45:00"),
(20, 108, "Keyboard", 60, "2025-01-18 13:45:00"),
(21, 107, "Laptop", 1200, "2025-01-19 16:55:00"),
(22, 103, "Headphones", 90, "2025-01-20 10:15:00"),
(23, 110, "Mouse", 20, "2025-01-21 12:05:00"),
(24, 105, "Laptop", 1220, "2025-01-22 15:00:00"),
(25, 104, "Keyboard", 45, "2025-01-23 16:30:00");