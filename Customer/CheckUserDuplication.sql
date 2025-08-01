
-- 특정 컬럼의 중복되는게 있는지 확인 하는 프로시저


DELIMITER //

CREATE OR REPLACE PROCEDURE CheckUserDuplication(
    IN col VARCHAR(100),
    IN var VARCHAR(100),
    OUT found_count INT
)
BEGIN
    -- 세션 변수 설정
    SET @var = var;
    SET @col = col;

    -- 동적 SQL 생성 (count 결과를 @cnt에 저장)
    SET @sql = CONCAT('SELECT COUNT(*) INTO @cnt FROM member WHERE ', @col, ' = ?');

    PREPARE stmt FROM @sql;
    EXECUTE stmt USING @var;  -- 여기! 바인딩 변수는 @var여야 합니다!
    DEALLOCATE PREPARE stmt;

    -- OUT 파라미터에 결과값 전달
    SET found_count = @cnt;
END //

DELIMITER ;