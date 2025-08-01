-- 회원탈퇴 프로시저
-- 호원테이블에서 상태값만 4로 변경.

delimiter //

create or replace procedure DeleteAccount(
    in userEmail varchar(255),
    in userPassword varchar(255),
    out returnMessage varchar(2000)
)
main: begin

    declare encryptedPassword varchar(255);
    declare userId int;
    call PasswordEncrypted(userPassword,encryptedPassword);


    select
           id into userId
      from member
     where email = userEmail
       and password = encryptedPassword;

    if userId > 0 then
        update member
           set status_id = 4
         where id = userId;

        set returnMessage = '회원탈퇴가 완료 되었습니다.';
    else
        set returnMessage = '비밀번호가 일치 하지 않습니다.';
    end if;


end //
delimiter ;