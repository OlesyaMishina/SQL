# Создайте процедуру, которая принимает кол-во сек и формат их в кол-во дней, часов, минут и секунд.
# Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds '

DROP DATABASE IF EXISTS HW6;
CREATE DATABASE HW6;
USE HW6;

DELIMITER $$
DROP PROCEDURE IF EXISTS time_format;
CREATE PROCEDURE time_format (seconds INT)
BEGIN
	DECLARE DD char(3);
	DECLARE HH, MM, SS char(2);
	SET DD = cast(floor(seconds/60/60/24) as char(3));
	SET HH = cast(floor(mod(seconds/60/60/24,1)*24) as char(2));
	SET MM = cast(floor(mod(mod(seconds/60/60/24,1)*24,1)*60) as char(2));
	SET SS = cast(round(mod(mod(mod(seconds/60/60/24,1)*24,1)*60,1)*60) as char(2));
    SELECT concat(DD,' days, ',HH,' hours, ',MM,' minutes, ',SS,' seconds. ') AS 'Время в днях, часах, минутах и секундах.';
END$$
CALL time_format(1234567);  

# 2. Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. 
#С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", 
#с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".

DELIMITER $$
DROP FUNCTION IF EXISTS hello;
CREATE FUNCTION hello() 
	RETURNS VARCHAR(20)
	DETERMINISTIC
BEGIN
DECLARE result VARCHAR(20);
IF CURRENT_TIME >= '12:00:00' AND  CURRENT_TIME < '18:00:00' 
    THEN SET result='Добрый день!';
ELSEIF CURRENT_TIME >= '06:00:00' AND  CURRENT_TIME < '12:00:00' 
	THEN SET result='Доброе утро?';
ELSEIF CURRENT_TIME >= '00:00:00' AND  CURRENT_TIME < '06:00:00' 
	THEN SET result='Доброй ночи)';
ELSEIF CURRENT_TIME >= '18:00:00' AND  CURRENT_TIME < '00:00:00' 
	THEN SET result='Добрый вечер!';
END IF ;
RETURN result;
END$$
SELECT hello() AS Приветствие; 