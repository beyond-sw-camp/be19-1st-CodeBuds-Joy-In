-- 북마크 두 번 누른 경우
delimiter //
CREATE OR REPLACE TRIGGER BookmarkCheck
    BEFORE INSERT
    ON bookmark
    FOR EACH ROW

BEGIN
    if EXISTS (SELECT 1 FROM bookmark
               WHERE post_id = NEW.post_id
                 AND member_id = NEW.member_id) then
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '이미 북마크를 누른 게시글입니다.';
END if;

END //

delimiter ;