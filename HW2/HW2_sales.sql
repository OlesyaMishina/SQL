# Задача 1. Используя операторы языка SQL, 
# создайте таблицу “sales”. Заполните ее данными.

CREATE DATABASE IF NOT EXISTS HW2_sales;
USE HW2_sales;
DROP TABLE IF EXISTS sales; 

CREATE TABLE sales (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
	order_date DATE NOT NULL,
	count_product INT NOT NULL);

INSERT sales(order_date, count_product) 
VALUES 	("2022-01-01", 156), 
		("2022-01-02", 180), 
		("2022-01-03", 21), 
		("2022-01-04", 124), 
		("2022-01-05", 341);
				
SELECT * FROM sales;

# Задача 2. Сгруппируйте значений количества в 3 сегмента — меньше 100,
# 100-300 и больше 300.

SELECT *,
CASE 
	WHEN count_product < 100 THEN 'Маленький заказ'
	WHEN count_product >= 100 AND count_product <= 300 THEN 'Средний заказ'
	ELSE 'Большой заказ'
END AS order_type
FROM sales;

# Задача 3. Создайте таблицу “orders”, заполните ее значениями. 
-- Покажите “полный” статус заказа, используя оператор CASE.

DROP TABLE IF EXISTS orders; 
CREATE TABLE orders (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
	employee_id VARCHAR(3) NOT NULL,
	amount FLOAT(8,2) NOT NULL,
	order_status VARCHAR(20) NOT NULL);

INSERT orders(employee_id, amount, order_status) 
VALUES 	("e03", 15.00, 'OPEN'),
		("e01", 25.50, 'OPEN'),
		("e05", 100.70, 'CLOSED'),
		("e02", 22.18, 'OPEN'),
		("e04", 9.50, 'CANCELLED');

SELECT * FROM orders;

SELECT *,
CASE 
	WHEN order_status = 'OPEN' THEN 'Order is in open state.'
	WHEN order_status = 'CLOSED' THEN 'Order is closed.'
	WHEN order_status = 'CANCELLED' THEN 'Order is in open state.'
	ELSE 'NONE'
END AS full_order_status
FROM orders;