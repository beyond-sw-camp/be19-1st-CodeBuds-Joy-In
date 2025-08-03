-- 방장이 참여자를 강퇴시킨 경우
delimiter //
CREATE OR REPLACE TRIGGER ForcedEviction
    AFTER UPDATE
    ON join_request
    FOR EACH ROW
BEGIN
    DECLARE post_status INTEGER;
    if
        NEW.status = 'N' AND OLD.status <> 'N' then
        UPDATE post
        SET current_count = current_count - 1
        WHERE id = NEW.post_id;

        SELECT recruitment_status
        INTO post_status
        FROM post
        WHERE id = NEW.post_id;
        if
            post_status = 1 then
            UPDATE post
            SET recruitment_status = 0
            WHERE id = NEW.post_id;
        END if;
    END if;
END //
delimiter ;