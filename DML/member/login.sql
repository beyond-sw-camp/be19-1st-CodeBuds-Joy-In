-- login 프로시저
delimiter //

create or replace procedure Login(
    in userEmail varchar(255),
    in userPassward varchar(255),
    out returnMessage varchar(2000)
)
main: begin

    declare userName varchar(20);
    declare blockedUser varchar(20);
    declare blockedName varchar(20);
    declare userId int;
    declare nowTime datetime;

    call PasswordEncrypted(userPassward,@encrypted);

    select
           b.name
         , a.name
      into
           blockedUser
         , blockedName
      from member_status as a
      join (
            select name, status_id
            from member
            where email = userEmail
              and password = @encrypted
              and status_id <> 1
      ) as b
    on a.id = b.status_id;

    if blockedUser is not null or blockedUser <> '' then
        set returnMessage = concat(blockedUser, '님은 현재 "', blockedName , '" 이유로 접속이 불가능 합니다.');
        LEAVE main; # 프로시저 종료
    end if;

    select
           name
         , id
      into
           userName
         , userId
      from member
     where email = userEmail
       and password = @encrypted;

    if userName is not null or userName <> '' then
        set returnMessage = concat(userName, '님 환영 합니다.');

        set nowTime = now();
        -- 로그인 기록 insert
        insert
          into login_history
        values
        (null, nowTime, 0, 'web', '192.168.0.50',userId );

        update member
           set last_login_at = nowTime
         where id = userId;

    else
        set returnMessage = '입력한 정보와 일치하는 회원이 없습니다.';
    end if;
end //

delimiter ;