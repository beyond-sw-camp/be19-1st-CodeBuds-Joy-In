DROP PROCEDURE IF EXISTS review_group_insert_check;     -- 그룹모임에서 후기 작성의 조건을 체크해서 테이블 삽입 유무 정하기 

DELIMITER //

CREATE PROCEDURE review_group_insert_check(
  IN user_id INT,
  IN input_post_id INT,
  IN input_score INT,
  IN input_review VARCHAR(2000),
  IN input_target_member_id INT,
  OUT is_possible TINYINT 
)
proc: BEGIN 
   DECLARE reviewer_id    INT;
	DECLARE is_certified TINYINT;
	DECLARE is_other_certified TINYINT;
	DECLARE is_review TINYINT;
	DECLARE input_join_request_id INT;
-- 후기를 작성할 수 있는 상태인지 확인
-- 1. 만남인증이 1인 상태일 것
-- 2. 이미 후기를 작성한 사람이 아닐 것matching_reviewmatching_review
    SELECT 
           id INTO input_join_request_id
      FROM join_request
     WHERE member_id = user_id AND post_id = input_post_id;
	 
	 SELECT 
	        member_id INTO reviewer_id
	   FROM join_request
	  WHERE id = input_join_request_id;
		  IF input_target_member_id = reviewer_id THEN
		 SET is_possible = 0;
           LEAVE proc;
       END IF;
	      
	 SELECT 
           certification INTO is_certified
      FROM join_request
     WHERE id = input_join_request_id;
    
    select
           certification INTO is_other_certified
      FROM join_request
     WHERE post_id = (
	                    SELECT 
	                           post_id
	                      FROM join_request
	                     WHERE id = input_join_request_id
							)
		 AND member_id = input_target_member_id;
    
    SELECT
           COUNT(*) INTO is_review
      FROM group_review
     WHERE join_request_id = input_join_request_id AND target_member_id = input_target_member_id;
    
    
        IF is_certified = 1 AND is_other_certified = 1 AND is_review = 0 THEN
           INSERT INTO group_review(score, review, created_by, target_member_id, join_request_id)
           VALUES (input_score, input_review, NOW(),  input_target_member_id, input_join_request_id);
              SET is_possible = 1;
      ELSE 
           SET is_possible = 0;
       END IF;
    
END proc;
//

DELIMITER ;