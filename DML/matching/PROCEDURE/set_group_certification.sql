DROP PROCEDURE IF EXISTS set_group_certification;       -- 그룹모임에서 만남 인증 변환시에 모임 당일날만 가능


DELIMITER //

CREATE PROCEDURE set_group_certification(
  IN joinrequest_id INT
)
BEGIN 
   DECLARE meeting_date date;

   SELECT
          date(start_date) INTO meeting_date
     FROM post
    WHERE id = (
	              SELECT 
					         post_id
					    FROM join_request
					   WHERE id = joinrequest_id
					);
					
       IF meeting_date = CURDATE() THEN
			 UPDATE join_request
             SET certification = 1
           WHERE id = joinrequest_id AND status = 'Y';
      END IF;
END//

DELIMITER ;