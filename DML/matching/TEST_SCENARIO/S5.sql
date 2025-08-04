-- 그룹 모임
-- 만남 인증을 완료한 상태임
-- 리뷰 남기기

SELECT *
  FROM join_request;
SELECT id, rank_id
  FROM member
 WHERE id = 10004;

-- 자기 자신에게 남기기 -> 실패
SET @input_join_request_id  = 1;
SET @input_score            = 4;
SET @input_review           = '그저 그랬어요';
SET @input_target_member_id = 10004;
SET @is_possible            =0;
SELECT id, score FROM member WHERE id = @input_target_member_id;
CALL review_group_insert_check(@input_join_request_id, @input_score, @input_review, @input_target_member_id, @is_possible);
SELECT @is_possible;
SELECT id, score FROM member WHERE id = @input_target_member_id;

-- 참가하지 않은 사람에게 남기기 지금은 성공할 듯(status를 조건으로 건게 아니라 certification을 조건으로 걸어서)
SET @input_join_request_id  = 1;
SET @input_score            = 4;
SET @input_review           = '그저 그랬어요';
SET @input_target_member_id = 10005;
SET @is_possible            =0;
SELECT id, score FROM member WHERE id = @input_target_member_id;
CALL review_group_insert_check(@input_join_request_id, @input_score, @input_review, @input_target_member_id, @is_possible);
SELECT @is_possible;
SELECT id, score FROM member WHERE id = @input_target_member_id;

-- 한 명에게 두번 남기기
SET @input_join_request_id  = 1;
SET @input_score            = 4;
SET @input_review           = '그저 그랬어요';
SET @input_target_member_id = 10006;
SET @is_possible            =0;
SELECT id, score FROM member WHERE id = @input_target_member_id;
CALL review_group_insert_check(@input_join_request_id, @input_score, @input_review, @input_target_member_id, @is_possible);
SELECT @is_possible;
SELECT id, score FROM member WHERE id = @input_target_member_id;

SET @input_join_request_id  = 1;
SET @input_score            = 4;
SET @input_review           = '그저 그랬어요';
SET @input_target_member_id = 10006;
SET @is_possible            =0;
SELECT id, score FROM member WHERE id = @input_target_member_id;
CALL review_group_insert_check(@input_join_request_id, @input_score, @input_review, @input_target_member_id, @is_possible);
SELECT @is_possible;
SELECT id, score FROM member WHERE id = @input_target_member_id;

SELECT * FROM group_review;


-- 테스트 1: 성공 케이스 (같은 post_id의 멤버)
SET @input_join_request_id  = 1;
SET @input_score            = 5;
SET @input_review           = '정말 좋았어요';
SET @input_target_member_id = 10007;
SET @is_possible            = 0;
CALL review_group_insert_check(@input_join_request_id, @input_score, @input_review, @input_target_member_id, @is_possible);
SELECT 'Test 1', @is_possible;

-- 테스트 2: 실패 케이스 (같은 post_id 아님)
SET @input_join_request_id  = 1;
SET @input_score            = 3;
SET @input_review           = '모르겠어요';
SET @input_target_member_id = 11030;  -- post_id 18이라 실패
SET @is_possible            = 0;
CALL review_group_insert_check(@input_join_request_id, @input_score, @input_review, @input_target_member_id, @is_possible);
SELECT 'Test 2', @is_possible;

-- 테스트 3: 중복 작성 방지 확인
SET @input_join_request_id  = 1;
SET @input_score            = 2;
SET @input_review           = '또 씀';
SET @input_target_member_id = 10007;
SET @is_possible            = 0;
CALL review_group_insert_check(@input_join_request_id, @input_score, @input_review, @input_target_member_id, @is_possible);
SELECT 'Test 3', @is_possible;

-- 테스트 4: 같은 post_id 다른 사람 (성공)
SET @input_join_request_id  = 5;
SET @input_score            = 4;
SET @input_review           = '좋았어요';
SET @input_target_member_id = 10011;
SET @is_possible            = 0;
CALL review_group_insert_check(@input_join_request_id, @input_score, @input_review, @input_target_member_id, @is_possible);
SELECT 'Test 4', @is_possible;

-- 결과 확인
SELECT * FROM group_review ORDER BY id;