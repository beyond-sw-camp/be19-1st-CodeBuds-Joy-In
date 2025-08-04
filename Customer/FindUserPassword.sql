

-- 비밀번호 찾기 
-- 임시비밀번호로 바꾼후 임시비밀번호 회원에게 제공.

delimiter //

create or replace procedure FindUserPassword(
    in userEmail varchar(255),
    in userPhone varchar(255),
    out returnMessage varchar(2000)
)
main: begin
    declare i int default 1;
    declare ranChar int ;
    declare randomPassword varchar(10);
    declare encryptedPassword varchar(255);
    declare userName varchar(20);
    set randomPassword = '';



    select
        name into userName
    from member
    where email = userEmail
      and phone = userPhone;

    if userName <> '' then

        while i <= 10 do
                select FLOOR(rand() * 90) + 33 into ranChar;
                set randomPassword = concat(randomPassword, char( ranchar));
                set i = i + 1;
            end while;

        call PasswordEncrypted(randomPassword, encryptedPassword);

        update member
        set password = encryptedPassword
        where email = userEmail
          and phone = userPhone;

        set returnMessage = concat(userName, '님의 임시 비밀번호는 : ' , randomPassword, '  입니다. 로그인 후 비밀번호를 변경 해 주세요.');
    else
        set returnMessage = '회원정보가 없습니다.';
    end if;

end //
delimiter ;