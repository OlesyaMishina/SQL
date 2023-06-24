CREATE DATABASE IF NOT EXISTS HW1;
USE HW1;
DROP TABLE IF EXISTS HW1;

CREATE TABLE phones (
id INT PRIMARY KEY auto_increment,
ProductName VARCHAR(45), 
Manufacturer VARCHAR(45), 
ProductCount INT, 
Price INT
);

INSERT phones (ProductName, Manufacturer, ProductCount, Price)
VALUES 
('iPhone X', 'Apple', 3, 76000),
('iPhone 8', 'Apple', 2, 51000),
('Galaxy S9', 'Sumsung', 2, 56000),
('Galaxy S8', 'Sumsung', 1, 41000),
('P20 Pro', 'Huawei', 5, 36000);

-- 2. Выведите название, производителя и цену товара, количество которых превышает 2.
SELECT ProductName, Manufacturer, Price
FROM phones
WHERE ProductCount>2;

-- 3. Выведите весь ассортимент товаров Samsung.
SELECT *
FROM phones
WHERE Manufacturer='Sumsung';

-- 4. Выведите информацию о телефонах, где суммарный чек больше 100000 и меньше 145000. 
SELECT *
FROM phones
WHERE ProductCount*Price > 100000 AND ProductCount*Price <145000;

-- 5.1. Вывести товары, где есть упоминание iPhone 
SELECT *
FROM phones
WHERE ProductName LIKE 'iPhone%' ||  Manufacturer LIKE '%iPhone%';

-- 5.2. Вывести товары, где есть упоминание Galaxy 
SELECT *
FROM phones
WHERE ProductName LIKE 'Galaxy%' ||  Manufacturer LIKE '%Galaxy%';

-- 5.4. Вывести товары, где есть цифра 8
SELECT *
FROM phones
WHERE ProductName LIKE '%8%' ||  Manufacturer LIKE '%8%';

-- 5.3. Вывести товары, где есть цифры
SELECT *
FROM phones
WHERE ProductName REGEXP '[0-9]' ||  Manufacturer REGEXP '[0-9]';

SELECT * 
FROM phones
ORDER BY Price Desc;

SELECT COUNT(*) AS count
FROM phones;

SELECT * 
FROM phones
LIMIT 2,3;

SELECT SUM(Price) AS total FROM phones;

SELECT MIN(Price), MAX(Price), AVG(Price)
FROM phones
WHERE Manufacturer='Apple';

SELECT Manufacturer, COUNT(*) AS Model, Price, ProductCount
FROM phones
WHERE Price>40000
GROUP BY Manufacturer;
