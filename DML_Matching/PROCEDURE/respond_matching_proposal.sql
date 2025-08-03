DROP PROCEDURE IF EXISTS respond_matching_proposal;     -- 매칭 수락/거절


DELIMITER //

CREATE PROCEDURE respond_matching_proposal(
    IN user_id1            INT,
    IN user_id2            INT,
    IN user_response1      CHAR,
    IN user_response2      CHAR,
    IN user_matching_code1 INT,
    IN user_matching_code2 INT
)

BEGIN
    -- 코드가 동일하다면
	 IF user_matching_code1 = user_matching_code2 THEN
	    -- 둘 다 수락했는지 확인
       IF user_response1 = 'Y' AND user_response2 = 'Y' THEN
          -- 해당 매칭이 성사되었음으로 변경
			 UPDATE matching
             SET status = 1
           WHERE id = user_matching_code1;
     ELSE 
          UPDATE member
             SET is_matching_active = 1
           WHERE id IN (user_id1, user_id2);
      END IF;
   END IF;
	    -- 유저별 1:1 매칭에 기록
	INSERT INTO member_matching(status,certification, member_id, matching_id)
   VALUES 
		    (user_response1, 0, user_id1, user_matching_code1),
          (user_response2, 0, user_id2, user_matching_code2); 
   
END//

DELIMITER ;