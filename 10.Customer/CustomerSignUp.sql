# 회원가입 프로시저

delimiter //

CREATE OR REPLACE PROCEDURE CustomerSignUp(
    IN name varchar(20),
    IN gender char,
    IN birth date,
    IN email varchar(255),
    IN phone varchar(255),
    IN nickname varchar(255),
    IN password varchar(255),
    OUT returnMessage varchar(2000) # 프로시저 실행 결과 반환.
)
main: BEGIN

    DECLARE encrypted_password varchar(255);
    call CheckUser(name,phone,@user);

    IF @user = 1 THEN
        SET returnMessage = '이미 가입한 회원입니다. 기존 아이디로 로그인 해 주세요.';
        LEAVE main; # 프로시저 종료
    END IF;

    call CheckUserDuplication('phone', phone, @phone);

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
        (null, name, gender, birth, phone, email, nickname, @encrypted_password, now(), null, 100, null, null, 0, 0, 1 ,3);

    set returnMessage = '회원가입이 완료 되었습니다.';

END ;

delimiter //
