DROP PROCEDURE IF EXISTS set_matching_certification;    -- 일대일 매칭에서 만남 인증 변환시에 모임 당일날만 가능


DELIMITER //

CREATE PROCEDURE set_matching_certification(
  IN member_matching_id INT
)
BEGIN 
   DECLARE meeting_date date;
   DECLARE meeting		TINYINT;
   
   SELECT
          date(start_date) INTO meeting_date
     FROM matching
    WHERE id = (
	              SELECT 
					         matching_id
					    FROM member_matching
					   WHERE id = member_matching_id
					);
					
	 SELECT 
	        status INTO meeting
	   FROM matching
	  WHERE id = (
	               SELECT
	                      matching_id
	                 FROM member_matching
	                WHERE id = member_matching_id
	             );
	 
       IF meeting_date = CURDATE() AND meeting = 1 THEN
			 UPDATE member_matching
             SET certification = 1
           WHERE id = member_matching_id;
      END IF;
END//

DELIMITER ;