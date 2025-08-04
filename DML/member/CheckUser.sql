
-- 이미 가입되어있는 회원인지 확인 이름, 전화번호 일치시 있는 회원으로 판단.

DELIMITER //

CREATE OR REPLACE PROCEDURE CheckUser(
    IN name VARCHAR(100),
    IN phone VARCHAR(100),
    OUT found_count INT
)
BEGIN
    -- 세션 변수 설정
    SET @name = name;
    SET @phone = phone;

    -- 동적 SQL 생성 (count 결과를 @cnt에 저장)
    SET @sql = 'SELECT COUNT(*) INTO @cnt FROM member WHERE name = ? AND phone = ?';

    -- 실행
    PREPARE stmt FROM @sql;
    EXECUTE stmt USING @name, @phone;  -- 🔍 여기서 두 개의 변수를 정확히 전달해야 함!
    DEALLOCATE PREPARE stmt;

    -- OUT 파라미터에 결과값 전달
    SET found_count = @cnt;
END //

DELIMITER ;


