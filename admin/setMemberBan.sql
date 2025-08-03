-- ---------------------------------------------------------------------------
-- 회원 정지
delimiter //
create procedure setMemberban(
    IN code int,         -- ban rule 코드
    IN res varchar(255),
    IN mem int,
    IN adm int
)
begin
    declare ban_days int;
    select days into ban_days from ban_rule where id = code;

    set @reason := res;
    set @admin_id := adm;

    insert into member_ban
    values
        (null, res, now(), now() + interval ban_days day,
         code, mem, adm);

    update member set status_id = 3 where id = mem;
end //
delimiter ;


-- call setMemberban(5, '광고성 댓글 작성', 10003, 1);