DROP DATABASE IF EXISTS HW5;
CREATE DATABASE HW5;
USE HW5;
DROP TABLE IF EXISTS cars;
CREATE TABLE cars
(
	id INT NOT NULL PRIMARY KEY,
    name VARCHAR(45),
    cost INT
);

INSERT cars
VALUES
	(1, "Audi", 52642),
    (2, "Mercedes", 57127 ),
    (3, "Skoda", 9000 ),
    (4, "Volvo", 29000),
	(5, "Bentley", 350000),
    (6, "Citroen ", 21000 ), 
    (7, "Hummer", 41400), 
    (8, "Volkswagen ", 21600);
    
SELECT *
FROM cars;

#1.	Создайте представление, в которое попадут автомобили стоимостью  до 25 000 долларов
CREATE VIEW view1 AS
SELECT * FROM cars WHERE cost<25000 ORDER BY cost;
SELECT * FROM view1;

#2.	Изменить в существующем представлении порог для стоимости: пусть цена будет до 30 000 долларов (используя оператор ALTER VIEW) 
ALTER VIEW view1 AS
SELECT * FROM cars WHERE cost<30000 ORDER BY cost;
SELECT * FROM view1;

#3 Создайте представление, в котором будут только автомобили марки “Шкода” и “Ауди”
CREATE VIEW view2 AS
SELECT * FROM cars WHERE `name` IN ('Skoda', 'Audi');
SELECT * FROM view2;

# 4. Добавьте новый столбец под названием «время до следующей станции».
DROP TABLE IF EXISTS trains;
CREATE TABLE trains(
	train_id INT,
    station VARCHAR(20),
    station_time TIME
    );
INSERT trains
VALUES
	(110, 'San Francisco', '10:00:00'),
    (110, 'Redwood City', '10:54:00'),
    (110, 'Palo Alto', '11:02:00'),
    (110, 'San Jzose', '11:35:00'),
    (120, 'San Francisco', '11:00:00'),
    (120, 'Palo Alto', '12:49:00'),
	(120, 'San Jzose', '13:30:00');
SELECT * FROM trains;

SELECT *,
SUBTIME(LEAD(station_time) OVER(PARTITION BY train_id ORDER BY train_id), station_time)
AS time_to_next_station
FROM Trains;
