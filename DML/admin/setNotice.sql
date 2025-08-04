-- ---------------------------------------------------------------------------
-- 공지사항 등록
delimiter //
create procedure setNotice(
    IN tit varchar(255),
    IN con text,
    IN adm int
)
begin
insert into notice
values
    (null, tit, con, now(), adm);

end //
delimiter ;

-- call setNotice('안녕하세요', '환영합니다.', 1);