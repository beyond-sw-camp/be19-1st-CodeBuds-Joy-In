# 회원가입 프로시저

delimiter //

CREATE OR REPLACE PROCEDURE CustomerSignUp(
    IN userName varchar(20),
    IN gender char,
    IN birth varchar(20),
    IN email varchar(255),
    IN userPhone varchar(255),
    IN nickname varchar(255),
    IN password varchar(255),
    OUT returnMessage varchar(2000) # 프로시저 실행 결과 반환.
)
main: BEGIN

    DECLARE encrypted_password varchar(255);
    declare checkBalckList int;
    set checkBalckList = 0;


    -- 필수 입력항목 제약 조건 확인 후 회원가입 진행.
    -- ---------------------------------------------------------------------------
    if  userName is null then
        SET returnMessage = '이름이 입력되지 않았습니다.';
        LEAVE main; # 프로시저 종료
    end if;

    if not (gender = 'F' or gender = 'M') then
        SET returnMessage = '성별은 F or M 만 입력 가능 합니다.';
        LEAVE main; # 프로시저 종료
    end if;


    if not (birth REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$') then
        SET returnMessage = '날짜 형식을 확인 해 주세요.';
        LEAVE main; # 프로시저 종료
    end if;

    if  userPhone REGEXP '^[0-9]{3}-[0-9]{3,4}-[0-9]{4}$' = 0 then
        SET returnMessage = '전화번호를 확인 해 주세요';
        LEAVE main; # 프로시저 종료
    end if;


    if email REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$' = 0  then
        SET returnMessage = '이메일을 확인 해 주세요';
        LEAVE main; # 프로시저 종료
    end if;


    if  password is null then
        SET returnMessage = '비밀번호를 확인 해 주세요.';
        LEAVE main; # 프로시저 종료
    end if;

    -- ---------------------------------------------------------------------------

    -- 영구 사용 제한 회원
    SELECT
           count(*) into checkBalckList
    from blacklist
    where name = userName
      and phone = userPhone;


    IF checkBalckList = 1 THEN
        SET returnMessage = '영구 사용 제한 회원입니다. 가입이 불가능 합니다.';
        LEAVE main; # 프로시저 종료
    END IF;


    call CheckUser(userName,userPhone,@user);

    IF @user = 1 THEN
        SET returnMessage = '이미 가입한 회원입니다. 기존 아이디로 로그인 해 주세요.';
        LEAVE main; # 프로시저 종료
    END IF;

    call CheckUserDuplication('phone', userPhone, @phone);

    IF @phone = 1 THEN
        SET returnMessage = '이미 존재하는 전화번호 입니다.';
        LEAVE main; # 프로시저 종료
    END IF;

# 기존에 있는값인지 확인.
    call CheckUserDuplication('email', email, @email);

    IF @email  = 1 THEN
        SET returnMessage = '이미 존재하는 이메일 입니다.';
        LEAVE main; # 프로시저 종료
    END IF;

    call CheckUserDuplication('nickname', nickname, @nickname);

    IF @nickname = 1 THEN
        SET returnMessage = '이미 존재하는 닉네임 입니다.';
        LEAVE main; # 프로시저 종료
    END IF;


# 암호화 프로시저 호출
    CALL PasswordEncrypted(password,@encrypted_password);

# 회원정보 insert.
    insert
    into member
    values
        (null, userName, gender, birth, userPhone, email, nickname, @encrypted_password, now(), null, 100, null, null, 0, 0, 1 ,3);

    set returnMessage = '회원가입이 완료 되었습니다.';

END ;

delimiter //
