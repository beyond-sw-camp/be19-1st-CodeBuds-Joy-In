DROP PROCEDURE IF EXISTS review_matching_insert_check;  -- 일대일 매칭 후기 작성의 조건을 체크해서 테이블 삽입 유무 정하기

DELIMITER //

CREATE PROCEDURE review_matching_insert_check(
  IN user_id  INT,
  IN input_matching_id INT,
  IN input_score INT,
  IN input_review VARCHAR(2000),
  OUT is_possible TINYINT 
)
BEGIN 
   DECLARE is_certified TINYINT;
   DECLARE input_target_member_id INT;
	DECLARE is_review TINYINT;
   DECLARE member_matching_id INT;
-- 후기를 작성할 수 있는 상태인지 확인
-- 1. 만남인증이 1인 상태일 것
-- 2. 이미 후기를 작성한 사람이 아닐 것
    
	 SELECT 
	        id INTO member_matching_id
	   FROM member_matching
	  WHERE member_id = user_id AND matching_id = input_matching_id;
	 
	 SELECT 
           certification INTO is_certified
      FROM member_matching
     WHERE id = member_matching_id;
     
    SELECT
           member_id INTO input_target_member_id
      FROM member_matching
     WHERE matching_id = ( 
	                        SELECT 
									       matching_id 
									  FROM member_matching 
									 WHERE id = member_matching_id
								 ) 
		 AND member_id != user_id;
     
    SELECT
           COUNT(*) INTO is_review
      FROM matching_review
     WHERE id = member_matching_id;
        -- 후기 작성이 가능하면 데이터 삽입
        IF is_certified = 1 AND is_review = 0 THEN
           INSERT INTO matching_review(id, score, review, created_by, target_member_id)
           VALUES (member_matching_id, input_score, input_review, NOW(),  input_target_member_id);
           SET is_possible = 1;
      ELSE
           SET is_possible = 0;
       END IF;
END//

DELIMITER ;