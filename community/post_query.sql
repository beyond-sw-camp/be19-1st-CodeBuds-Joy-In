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
WHERE post_id = NEW.post_id;
END IF;
END //

delimiter ;


-- 모집 인원수가 다 채워지면 자동으로 마감됨.
delimiter //
CREATE or replace PROCEDURE AutoClosed (
    IN p_post_id INTEGER,
    IN CurCount INTEGER
)
BEGIN
    IF EXISTS (SELECT 1 FROM post WHERE post_id = p_post_id AND recurit_status = CurCount) THEN
UPDATE post
SET status = 1,
    recruit_end_date = NOW()
WHERE post_id = p_post_id;
END IF;

END //

delimiter ;

-- 방장이 참여자를 강퇴시킨 경우
delimiter //
CREATE OR REPLACE TRIGGER ForcedEviction
    AFTER UPDATE
                                   ON join_request
                                   FOR EACH ROW
BEGIN
    DECLARE post_status INTEGER;

    if NEW.status = 'N' AND OLD.status <> 'N' then
UPDATE post
SET current_count = current_count - 1
WHERE post_id = NEW.post_id;


SELECT status INTO post_status FROM post WHERE post_id = NEW.post_id;

if post_status = 1 then
UPDATE post
SET STATUS = 0
WHERE post_id = NEW.post_id;

END if;
END if;


END //

delimiter ;


-- ----------------------------------------------
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
            IF (NEW.recruit_status < NEW.current_count AND NEW.board_id = 2) THEN
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '게시글 수정이 불가능합니다.';
END IF;
END;

END //

delimiter ;


-- --------------------------------------------------------
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

-- ---------------------------------------------------------
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

-- -----------------------------------------------
-- 모집 자동 취소

delimiter //
CREATE or replace PROCEDURE AutoCancel(
    IN postID INTEGER
)
BEGIN -- 모집상태(status)를 2로 바꾸기
    DECLARE end_date DATETIME;

SELECT recruit_end_date
INTO end_date
FROM post
WHERE post_id = postID;

if end_date < NOW() then
UPDATE post
SET STATUS = 2
WHERE post_id = postID;
END if;

END //


delimiter ;

-- ----------------------------------------------
-- 게시글 제재
UPDATE post p
    LEFT JOIN (
    SELECT post_id, COUNT(*) AS report_count
    FROM board_report
    GROUP BY post_id
    ) l ON p.id = l.post_id
    SET p.is_deleted = 1
WHERE COALESCE(l.report_count, 0) > 10;

-- ----------------------------------------------
-- 댓글 제재
DELETE p
FROM reply p
         LEFT JOIN (
    SELECT reply_id, COUNT(*) AS report_count
    FROM board_report
    GROUP BY reply_id
) l ON p.id = l.reply_id
WHERE COALESCE(l.report_count, 0) > 10;