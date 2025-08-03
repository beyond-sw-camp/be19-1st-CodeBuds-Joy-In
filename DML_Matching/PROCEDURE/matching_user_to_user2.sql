DROP PROCEDURE IF EXISTS matching_user_to_user2;          -- 매칭 제안


DELIMITER //

-- 유저에게 매칭을 제안하는 프로시저
CREATE PROCEDURE matching_user_to_user2(
    IN user_index          INT,
	 OUT out_user1_id       INT,
	 OUT out_user2_id       INT,
	 OUT matching_code      INT
)

BEGIN

   DECLARE first_user_id   INT;
   DECLARE second_user_id  INT;
   DECLARE next_index      INT;
       SET next_index = user_index + 1;
   -- 첫 번째 유저 id
    SELECT 
	        id INTO first_user_id
      FROM (
            SELECT 
				       id 
				  FROM member
			    WHERE is_matching_active = 1
				 ORDER BY id
				 LIMIT user_index, 1
			  ) AS sub1;
			   
   -- 두  번째 유저 id
    SELECT id INTO second_user_id
      FROM (
            SELECT id 
				  FROM member
			    WHERE is_matching_active = 1
			    ORDER BY id
		       LIMIT next_index, 1
			  ) AS sub2;
			  
	    SET out_user1_id = first_user_id;
	    SET out_user2_id = second_user_id;
	    
	 -- 매칭 기능을 비활성화 -> 수락 거절 전에 다시 매칭하면 안되니까
	 UPDATE member
	    SET is_matching_active = 0
	  WHERE id IN (first_user_id, second_user_id);
	  
	 INSERT INTO matching (STATUS, start_date) 
	 VALUES (0, NOW());
	  
	    -- 세션 기준으로 마지막에 삽입된 id 
	    -- SELECT로 단순 정렬할 경우 동시성 문제로 에러가 날 확률이 존재함
	    SET matching_code = LAST_INSERT_ID();

END //

DELIMITER ;