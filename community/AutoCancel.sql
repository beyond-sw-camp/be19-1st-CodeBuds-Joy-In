-- 모집 자동 취소

delimiter //
CREATE or replace PROCEDURE AutoCancel(
    IN postID INTEGER
)
BEGIN -- 모집상태(status)를 2로 바꾸기
    DECLARE end_date DATETIME;

    SELECT recruitment_deadline
    INTO end_date
    FROM post
    WHERE id = postID;

    if end_date < NOW() then
        UPDATE post
        SET recruitment_status = 2
        WHERE id = postID;
    END if;

END //


delimiter ;