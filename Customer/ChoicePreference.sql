
-- 경향 수정.
-- call ChoicePreference(15003,'\'INTJ\',\'중식\',\'일식\',\'양식\',\'식도락(맛집탐방)\',\'관광지\',\'힐링/휴식\',\'액티비티\',\'하루 5끼 이상\'',@dd);

delimiter //

create or replace procedure ChoicePreference(
    in userId int,
    in preferenceList varchar(2000),
    out returnMessage varchar(2000)
)
main: begin

    declare encryptedPassword varchar(255);


    -- 1. 기존 preference 중 새로 선택되지 않은 것 삭제
    SET @delete_sql = CONCAT(
            'DELETE FROM member_preference ',
            'WHERE member_id = ', userId, ' ',
            'AND preference_id NOT IN ( ',
            '    SELECT id FROM preference WHERE name IN (', preferenceList, ') ',
            ')'
                      );

    PREPARE stmt FROM @delete_sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;

    -- 2. 새 preference 중 기존에 없는 것만 insert
    SET @insert_sql = CONCAT(
            'INSERT INTO member_preference (member_id, preference_id) ',
            'SELECT ', userId, ', p.id ',
            'FROM preference p ',
            'WHERE p.name IN (', preferenceList, ') ',
            'AND NOT EXISTS ( ',
            '    SELECT 1 FROM member_preference mp ',
            '    WHERE mp.member_id = ', userId, ' AND mp.preference_id = p.id ',
            ')'
                      );

    PREPARE stmt2 FROM @insert_sql;
    EXECUTE stmt2;
    DEALLOCATE PREPARE stmt2;

    set returnMessage = '성향 정보가 수정 되었습니다.';


end //
delimiter ;