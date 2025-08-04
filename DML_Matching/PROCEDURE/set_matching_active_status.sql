DROP PROCEDURE IF EXISTS set_matching_active_status;          -- is_matching_active 컬럼 변경 프로시저


DELIMITER //

-- 유저에게 매칭을 제안하는 프로시저
CREATE PROCEDURE set_matching_active_status(
   IN user_id INT,
   OUT is_possible TINYINT,
   OUT output_text VARCHAR(255)
)

BEGIN
	DECLARE is_matching_active_status INT;
   DECLARE sanction_start_at         DATETIME;
   
    SELECT 
           is_matching_active INTO is_matching_active_status
      FROM member
     WHERE id = user_id;
       -- 변경 됨
       SET is_possible = 1;
        IF is_matching_active_status = 0 THEN
           UPDATE member
              SET is_matching_active = 1
            WHERE id = user_id;
    ELSEIF is_matching_active_status = 1 THEN
           UPDATE member
              SET is_matching_active = 0
            WHERE id = user_id;
    ELSEIF is_matching_active_status = 2 THEN
           SELECT 
                  start_date INTO sanction_start_at
             FROM matching
				WHERE id = (
				             select
				                    matching_id
				               FROM member_matching
				              WHERE member_id = user_id
				              ORDER BY matching_id desc
				              LIMIT 1
				           );
				   -- 제재된지 30분이 넘었으면 변경한다.
               IF TIMESTAMPDIFF(MINUTE, sanction_start_at, NOW()) >= 30 THEN
                  UPDATE member
                     SET is_matching_active = 1
                   WHERE id = user_id;
               -- 제재된지 30분이 안되었으면 변경이 안된다.
             ELSE
                  SET is_possible = 0;
                  SET output_text = '연속 5회 거절하여 30분간 사용이 제한되었습니다.';
              END IF;
       END IF;
END //

DELIMITER ;