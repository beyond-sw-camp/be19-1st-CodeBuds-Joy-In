-- 1:1 매칭 제안
-- 거절     -> 멤버의 is_matching_active가 1이어야 한다.
-- 만남인증 -> matching테이블의 status가 0이므로 상태값 변화가 없어야 한다.
-- 후기 작성 -> 만남 인증이 안되었으므로 후기 작성이 안되어야 한다.

-- SELECT * FROM matching;

-- SELECT * FROM member WHERE is_matching_active = 1;

SET @user_index = 1;
SET @out_user1 = -1;
SET @out_user2 = -1;
SET @matching_code = -1;

CALL Matching_user_to_user(@out_user1, @out_user2, @matching_code);
-- CALL Matching_user_to_user(@user_index, @out_user1, @out_user2, @matching_code);
SELECT @out_user1, @out_user2, @matching_code;

-- SELECT * FROM matching;
-- SELECT * FROM member_matching;

SET @user_response1 = 'Y';
SET @user_response2 = 'N';
SET @user_matching_code1 = @matching_code;
SET @user_matching_code2 = @matching_code;

CALL respond_matching_proposal(@out_user1, @out_user2, @user_response1, @user_response2, @user_matching_code1, @user_matching_code2);

-- SELECT * FROM matching;
SELECT * FROM member_matching;

SELECT id INTO @member_matching_id1 FROM member_matching WHERE member_id = @out_user1 AND matching_id = @matching_code;
SELECT id INTO @member_matching_id2 FROM member_matching WHERE member_id = @out_user2 AND matching_id = @matching_code;

CALL set_matching_certification(@member_matching_id1);
CALL set_matching_certification(@member_matching_id2);

SELECT * FROM member_matching;
SET @input_score = 3;
SET @input_review = '좋았어요';
SET @input_target_member_id = @out_user2;
SET @is_possible = 0;

SET @input_score2 = -5;
SET @input_review2 = '별로';
SET @input_target_member_id2 = @out_user1;
SET @is_possible2 = 0;


SELECT id, score, rank_id FROM member WHERE id IN (@out_user1, @out_user2);
CALL review_matching_insert_check(@member_matching_id1, @input_score, @input_review, @input_target_member_id, @is_possible);
SELECT @is_possible;

CALL review_matching_insert_check(@member_matching_id2, @input_score2, @input_review2, @input_target_member_id2, @is_possible2);
SELECT @is_possible2;
-- SELECT * FROM rank;
SELECT * FROM matching_review;
SELECT id, score, rank_id FROM member WHERE id IN (@out_user1, @out_user2);

SELECT * FROM member WHERE id = @out_user1;
SELECT * FROM member WHERE id = @out_user2;