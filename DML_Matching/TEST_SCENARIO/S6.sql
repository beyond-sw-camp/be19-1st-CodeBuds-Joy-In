-- 먼저 S4를 통해 제재 인원을 쌓아 줘야한다.(30분 지난 인원이 있어야 30분 전후를 비교할 수 있으니까)

-- 테스트 할 id 선택을 위한 select 문
SELECT * FROM member WHERE is_matching_active = 0;
SELECT * FROM member WHERE is_matching_active = 1;
SELECT * FROM member WHERE is_matching_active = 2;


-- 테스트 진행: 위에서 확인한 member의 id로 변경
SET @is_possible = 0;
-- is_matching_active 가 0인 유저
SELECT id, is_matching_active FROM member WHERE id = 10005;
CALL set_matching_active_status(10005, @is_possible);
SELECT @is_possible;
SELECT id, is_matching_active FROM member WHERE id = 10005;

-- is_matching_active 가 1인 유저
SELECT id, is_matching_active FROM member WHERE id = 10004;
CALL set_matching_active_status(10004, @is_possible);
SELECT @is_possible;
SELECT id, is_matching_active FROM member WHERE id = 10004;

-- is_matching_active 가 2인 유저(방금)
SELECT id, is_matching_active FROM member WHERE id = 10198;
CALL set_matching_active_status(10198, @is_possible);
SELECT @is_possible;
SELECT id, is_matching_active FROM member WHERE id = 10198;

-- is_matching_active 가 2인 유저(30분이 지난)
SELECT id, is_matching_active FROM member WHERE id = 10181;
CALL set_matching_active_status(10181, @is_possible);
SELECT @is_possible;
SELECT id, is_matching_active FROM member WHERE id = 10181;