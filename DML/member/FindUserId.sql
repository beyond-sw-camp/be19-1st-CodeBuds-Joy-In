-- 아이디찾기

delimiter //

create or replace procedure FindUserId(
    in userName varchar(255),
    in userPhone varchar(255),
    out returnMessage varchar(2000)
)
main: begin
    declare userEmail varchar(200);

    select
           email into userEmail
      from member
     where name = userName
       and phone = userPhone;

    if userEmail <> '' then
        set returnMessage = concat(username, '님 의 접속 아이디는 : ' , userEmail);
    else
        set returnMessage = '회원정보가 없습니다.';
    end if;

end //
delimiter ;