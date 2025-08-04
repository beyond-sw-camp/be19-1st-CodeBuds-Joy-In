-- 좋아요 두 번 누른 경우
delimiter //
CREATE OR REPLACE TRIGGER LikesCheck
    BEFORE INSERT
    ON likes
    FOR EACH ROW

BEGIN
    if EXISTS (SELECT 1 FROM likes
               WHERE post_id = NEW.post_id
                 AND member_id = NEW.member_id) then
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '이미 좋아요를 누른 게시글입니다.';
END if;

END //

delimiter ;