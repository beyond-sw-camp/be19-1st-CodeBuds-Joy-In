
-- 비밀번호 변경.

delimiter //

create or replace procedure ChangePassword(
    in userEmail varchar(255),
    in previousPassword varchar(255),
    in newPassword varchar(255),
    out returnMessage varchar(2000)
)
main: begin

    declare prEncryptedPassword varchar(255);
    declare newEncryptedPassword varchar(255);
    declare countVar int ;

    call PasswordEncrypted(previousPassword, prEncryptedPassword);
    call PasswordEncrypted(newPassword, newEncryptedPassword);


    select
         count(*) into countVar
    from member
    where email = userEmail
      and password = prEncryptedPassword;

    if countVar > 0 then
        update member
        set password = newEncryptedPassword
        where email = userEmail;

        set returnMessage = '비밀번호 변경이 완료 되었습니다.';
    else
        set returnMessage = '회원정보가 없습니다.';
    end if;



end //
delimiter ;