-- ---------------------------------------------------------------------------
-- 블랙리스트 등록
delimiter //
create procedure setBlacklist(
    IN mem int,    -- 멤버 ID
    IN adm int,    -- 관리자 ID
    IN rule int    -- 블랙리스트 룰 ID
)
begin
    declare memname varchar(255);
    declare membirth date;
    declare memphone varchar(255);
    declare res varchar(255);
    select name, birth, phone into memname, membirth, memphone from member where id = mem;

    select name into res from blacklist_rule where id = rule;


    set @reason := res;
    set @admin_id := adm;

    update member set status_id = 5 where id = mem;

    insert into blacklist
    values
        (null, now(), memname, membirth,
         memphone, adm, rule);
end //
delimiter ;

call setBlacklist(10003, 1, 3);