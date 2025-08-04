-- 게시글 수정할 때
-- 모집인원수가 모집확정인원수보다 적게는 수정 불가
delimiter //

CREATE OR REPLACE TRIGGER RecruitUpdateBan
    BEFORE UPDATE
    ON post
    FOR EACH ROW
BEGIN
    DECLARE not_valid_date CONDITION FOR SQLSTATE '45000';
    DECLARE EXIT HANDLER FOR not_valid_date

        begin
            IF (NEW.recruitment_capacity < NEW.current_count AND NEW.board_id = 2) THEN
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '게시글 수정이 불가능합니다.';
            END IF;
        END;

END //

delimiter ;
