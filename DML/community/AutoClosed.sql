-- 모집 인원수가 다 채워지면 자동으로 마감됨.
delimiter //
CREATE or replace PROCEDURE AutoClosed (
    IN p_post_id INTEGER,
    IN CurCount INTEGER
)
BEGIN
    IF EXISTS (SELECT 1 FROM post WHERE id = p_post_id AND recruitment_capacity = CurCount) THEN
UPDATE post
SET recruitment_status = 1,
    recruitment_deadline = NOW()
WHERE id = p_post_id;
END IF;

END //

delimiter ;
