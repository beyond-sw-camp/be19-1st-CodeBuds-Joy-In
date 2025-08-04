DROP TRIGGER IF EXISTS trg_insert_group_review;          -- 그룹모임에서 작성된 후기로 멤버의 평점을 계산하고 등급을 조정

DELIMITER //

CREATE TRIGGER trg_insert_groupreview
AFTER INSERT ON group_review
FOR EACH ROW
BEGIN
   DECLARE reviewer_rank_id INT;
   DECLARE reviewee_rank_id INT;
   DECLARE curr_score       INT;
--	DECLARE next_rank_value  INT;
	DECLARE new_rank_id      INT;
	DECLARE weight_          DOUBLE;
   DECLARE adjusted_score   INT;
   
    SELECT 
	        rank_id INTO reviewer_rank_id
      FROM member
     WHERE id = (
	               SELECT 
						       member_id
	                 FROM join_request
	                WHERE id = NEW.id
	             );
    SELECT 
	        weight INTO weight_
      FROM rank
     WHERE id = reviewer_rank_id;
     
       SET adjusted_score = ROUND(NEW.score * weight_);
	 
	 UPDATE member
	    SET score = score + adjusted_score
	  WHERE id = NEW.target_member_id;
	
	
    SELECT 
           score
			, rank_id
	   INTO curr_score
		   , reviewee_rank_id
      FROM member
     WHERE id = NEW.target_member_id;

    SELECT 
	        id INTO new_rank_id
      FROM rank
     WHERE scope <= curr_score
     ORDER BY scope DESC
     LIMIT 1;

        IF new_rank_id != reviewee_rank_id THEN
           UPDATE member
              SET rank_id = new_rank_id
            WHERE id = NEW.target_member_id;
       END IF;

-- 	-- 점수가 떨어졌다면
-- 	IF adjusted_score < 0 THEN
--       
--       -- 블랙리스트 랭크에서 더 떨어질 수는 없으니까
-- 		IF reviewee_rank_id > 1 THEN
--          SELECT
--                 scope INTO next_rank_value
--            FROM rank
--           WHERE id = reviewee_rank_id;
--          -- 기준 점수보다 떨어졌다면 랭크 다운
--          IF curr_score < next_rank_value THEN
--             UPDATE member
--                SET rank_id = rank_id - 1
--              WHERE id = NEW.target_member_id;
--         END IF;
--      END IF;
--    -- 점수가 올라갔다면
--  ELSE 
--       -- 8단계 이상으로 올라갈 곳이 없음
--       IF reviewee_rank_id < 8 THEN
-- 		   SELECT
-- 			       scope INTO next_rank_value
-- 			  FROM rank
-- 			 WHERE id = reviewee_rank_id+1;
-- 			 -- 기준 점수보다 높어졌다면
-- 			 IF curr_score > next_rank_value THEN
-- 			    UPDATE member
-- 				    SET rank_id = rank_id + 1
-- 				  WHERE id = NEW.target_member_id;
--          END IF;
--      END IF;
--   END IF; 
-- 
END;
//

DELIMITER ;