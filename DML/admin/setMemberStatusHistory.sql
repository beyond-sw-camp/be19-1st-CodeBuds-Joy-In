-- ---------------------------------------------------------------------------
-- 회원상태가 변경되면 member_status_history 테이블에 자동으로 로그가 추가되는 trigger
delimiter //
create or replace trigger after_member_status_change
    after update
    on member
    for each row

begin
    declare res varchar(255);
    declare admid int;

    set res = @reason;
    set admid = @admin_id;

    if OLD.status_id != NEW.status_id THEN
        insert into member_status_history(id, reason, member_id, admin_id,
                                          previous_status_id, new_status_id)
        values (NULL, res, NEW.id,admid,
                OLD.status_id, NEW.status_id);

    end if ;

end //
delimiter ;