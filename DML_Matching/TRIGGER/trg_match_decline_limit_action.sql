DROP TRIGGER IF EXISTS trg_match_decline_limit_action;  -- 매칭 연속 거절시 30분 제재 이벤트


DELIMITER //

CREATE TRIGGER trg_match_decline_limit_action
AFTER INSERT ON member_matching
FOR EACH ROW
BEGIN
   DECLARE count_decline INT;
   
   
    SELECT COUNT(*) INTO count_decline
      FROM (
             SELECT a.status
               FROM member_matching AS a
               JOIN matching AS b ON (a.matching_id = b.id)
              WHERE a.member_id = NEW.member_id
                AND b.start_date >= NOW() - INTERVAL 7 DAY
              ORDER BY b.start_date DESC
              LIMIT 5
           ) AS recent_matches
     WHERE recent_matches.status = 'N';
	 
	     IF count_decline >= 5 THEN
	        -- status를 'D'로 변경해서 다음 검사에 걸리지 않게 한다. -> 트리거가 실행되는 도중에 같은 테이블을 다시 수정하는 것은 금지되어 있음.
	        -- 현재 한번 재재를 걸리면 7일 이후 까지 무조건 수락해야 제재에 안걸림...
	        UPDATE member
	           SET is_matching_active = 2
	         WHERE id = NEW.member_id;
	        
	    END IF;
END;
//

DELIMITER ;