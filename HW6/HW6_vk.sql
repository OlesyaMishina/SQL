
USE lesson_4;

/*1. Создать процедуру, которая решает следующую задачу
Выбрать для одного пользователя 5 пользователей в случайной комбинации, которые удовлетворяют хотя бы одному критерию:
а) из одного города
б) состоят в одной группе
в) друзья друзей*/

DROP PROCEDURE IF EXISTS sp_friendship_offers;
DELIMITER //
CREATE PROCEDURE sp_friendship_offers(for_user_id BIGINT)
BEGIN
-- друзья
WITH friends AS (
SELECT initiator_user_id AS id
    FROM friend_requests
    WHERE status = 'approved' AND target_user_id = for_user_id 
    UNION
    SELECT target_user_id 
    FROM friend_requests
    WHERE status = 'approved' AND initiator_user_id = for_user_id 
)
-- общий город
SELECT p2.user_id FROM profiles p1
JOIN profiles p2 ON p1.hometown = p2.hometown 
WHERE p1.user_id = for_user_id AND p2.user_id <> for_user_id
-- состоят в одной группе
UNION SELECT uc2.user_id FROM users_communities uc1
JOIN users_communities uc2 ON uc1.community_id = uc2.community_id 
WHERE uc1.user_id = for_user_id AND uc2.user_id <> for_user_id
-- друзья друзей
UNION SELECT fr.initiator_user_id FROM friends f
JOIN friend_requests fr ON fr.target_user_id = f.id
WHERE fr.initiator_user_id != for_user_id  AND fr.status = 'approved'
UNION SELECT fr.target_user_id FROM  friends f
JOIN  friend_requests fr ON fr.initiator_user_id = f.id 
WHERE fr.target_user_id != for_user_id  AND status = 'approved'
ORDER BY rand() 
LIMIT 5;
END//
DELIMITER ;
CALL sp_friendship_offers(1);

/* 2. Создать функцию, вычисляющей коэффициент популярности пользователя (по количеству друзей)*/

DROP FUNCTION IF EXISTS friendship_direction;
DELIMITER //
CREATE FUNCTION friendship_direction(check_user_id BIGINT)
RETURNS FLOAT READS SQL DATA 
BEGIN
 DECLARE requests_to_user INT; -- заявок к пользователю
 DECLARE requests_from_user INT; -- заявок от пользователя
 
 SET requests_to_user = (SELECT count(*) FROM friend_requests
 WHERE target_user_id = check_user_id);

 SELECT count(*) INTO  requests_from_user
 FROM friend_requests WHERE initiator_user_id = check_user_id; 

 RETURN requests_to_user / requests_from_user;
END//
DELIMITER ;

CALL friendship_direction(1);

/* 3. Необходимо перебрать всех пользователей и тех пользователей, у которых дата рождения меньше определенной даты обновить
 дату рождения на сегодняшнюю дату. (реализация с помощью цикла)*/
 
 DROP PROCEDURE IF EXISTS birthday_update;
 DELIMITER //
 CREATE PROCEDURE  birthday_update(start_date DATE)
 BEGIN
 DECLARE id_max_users INT;
 DECLARE count_find INT;
 SET id_max_users = (SELECT MAX(user_id) FROM profiles);
 WHILE (id_max_users > 0) DO
 BEGIN
  SET count_find = (SELECT COUNT(*) FROM profiles WHERE user_id = id_max_users AND birthday > start_date); 
  IF (count_find>0 )THEN UPDATE profiles SET birthday=NOW() WHERE user_id=id_max_users; 
  END IF;
  SET id_max_users = id_max_users - 1;
 END;
END WHILE;
END//
CALL birthday_update('2013-05-12');
SELECT * FROM `profiles` ORDER BY birthday;




