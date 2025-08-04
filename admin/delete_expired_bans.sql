-- ---------------------------------------------------------------------------
-- 정지 일수 끝나면 member 테이블의 상태 다시 바꿈
SET GLOBAL event_scheduler = ON;

CREATE EVENT IF NOT EXISTS delete_expired_bans
    ON SCHEDULE EVERY 1 DAY
        STARTS CURRENT_TIMESTAMP
    DO
    begin
        update member set status_id = 1
        where id in (select member_id from member_ban where end_date < now());

    end;