-- 신청승인상태가 Y 가 되면 현재모집된 인원수에 1을 더함.
delimiter //

CREATE OR REPLACE TRIGGER GroupMemberCount
    AFTER update
                               ON join_request
                               FOR EACH ROW

BEGIN
    IF NEW.status = 'Y' AND OLD.status <> 'Y' THEN
UPDATE post
SET current_count = IFNULL(current_count, 0) + 1
WHERE id = NEW.post_id;
END IF;
END //

delimiter ;