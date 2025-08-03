-- 게시글/댓글 신고 들어올 때 누적 횟수 확인하는 트리거
DELIMITER // 

CREATE OR REPLACE TRIGGER after_insert_board_report
    AFTER insert
    ON board_report
    FOR EACH ROW
BEGIN
	 DECLARE board_report_count INTEGER;
	 DECLARE member_report_count INTEGER;
	 DECLARE member_ban_count INTEGER;
	 
	 DECLARE m_name VARCHAR(255);
	 DECLARE m_birth DATE;
	 DECLARE m_phone VARCHAR(255);

	 SELECT 
	 		  COUNT(*) INTO board_report_count
	 	FROM board_report
	  WHERE member_id = NEW.member_id AND admin_status = 'Y';
	  
	 SELECT 
	 		  COUNT(*) INTO member_report_count
	 	FROM member_report
	  WHERE target_member_id = NEW.member_id AND admin_status = 'Y';
	  
	 SELECT 
	 		  COUNT(*) INTO member_ban_count
	 	FROM member_ban
	  WHERE member_id = NEW.member_id;
	  
	 if board_report_count + member_report_count + member_ban_count >= 10 then
	 	  SELECT 
	 		      name
	 		  	 , birth
	 		  	 , phone
	 		 INTO m_name, m_birth, m_phone
	 		 FROM member
	 		WHERE id = NEW.member_id;

	 	  INSERT 
			 INTO blacklist
	 	  (name, birth, phone, blacklist_rule_id)
		  VALUES 
		  (m_name, m_birth, m_phone, 7);
		  
		  UPDATE member
		     SET status_id = 5
		   WHERE id = NEW.member_id;
	 END if;
END//

DELIMITER ;

-- 회원 신고 들어올 때 누적 횟수 확인하는 트리거
DELIMITER // 

CREATE OR REPLACE TRIGGER after_insert_member_ban
    AFTER insert
    ON member_ban
    FOR EACH ROW
BEGIN
	 DECLARE board_report_count INTEGER;
	 DECLARE member_report_count INTEGER;
	 DECLARE member_ban_count INTEGER;
	 
	 DECLARE m_name VARCHAR(255);
	 DECLARE m_birth DATE;
	 DECLARE m_phone VARCHAR(255);

	 SELECT 
	 		  COUNT(*) INTO board_report_count
	 	FROM board_report
	  WHERE member_id = NEW.member_id AND admin_status = 'Y';
	  
	 SELECT 
	 		  COUNT(*) INTO member_report_count
	 	FROM member_report
	  WHERE target_member_id = NEW.member_id AND admin_status = 'Y';
	  
	 SELECT 
	 		  COUNT(*) INTO member_ban_count
	 	FROM member_ban
	  WHERE member_id = NEW.member_id;
	  
	 if board_report_count + member_report_count + member_ban_count >= 10 then
	 	  SELECT 
	 		      name
	 		  	 , birth
	 		  	 , phone
	 		 INTO m_name, m_birth, m_phone
	 		 FROM member
	 		WHERE id = NEW.member_id;

	 	  INSERT 
			 INTO blacklist
	 	  (name, birth, phone, blacklist_rule_id)
		  VALUES 
		  (m_name, m_birth, m_phone, 7);
		  
		  UPDATE member
		     SET status_id = 5
		   WHERE id = NEW.member_id;
	 END if;
END//

DELIMITER ;

-- 정지될 때 누적 횟수 확인하는 트리거
DELIMITER // 

CREATE OR REPLACE TRIGGER after_insert_member_report
    AFTER insert
    ON member_report
    FOR EACH ROW
BEGIN
	 DECLARE board_report_count INTEGER;
	 DECLARE member_report_count INTEGER;
	 DECLARE member_ban_count INTEGER;
	 
	 DECLARE m_name VARCHAR(255);
	 DECLARE m_birth DATE;
	 DECLARE m_phone VARCHAR(255);

	 SELECT 
	 		  COUNT(*) INTO board_report_count
	 	FROM board_report
	  WHERE member_id = NEW.target_member_id AND admin_status = 'Y';
	  
	 SELECT 
	 		  COUNT(*) INTO member_report_count
	 	FROM member_report
	  WHERE target_member_id = NEW.target_member_id AND admin_status = 'Y';
	  
	 SELECT 
	 		  COUNT(*) INTO member_ban_count
	 	FROM member_ban
	  WHERE member_id = NEW.target_member_id;
	  
	 if board_report_count + member_report_count + member_ban_count >= 10 then
	 	  SELECT 
	 		      name
	 		  	 , birth
	 		  	 , phone
	 		 INTO m_name, m_birth, m_phone
	 		 FROM member
	 		WHERE id = NEW.member_id;

	 	  INSERT 
			 INTO blacklist
	 	  (name, birth, phone, blacklist_rule_id)
		  VALUES 
		  (m_name, m_birth, m_phone, 7);
		  
		  UPDATE member
		     SET status_id = 5
		   WHERE id = NEW.target_member_id;
	 END if;
END//

DELIMITER ;