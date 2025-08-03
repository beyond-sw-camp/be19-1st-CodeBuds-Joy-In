-- 5회 제제


-- SELECT * FROM matching;

SELECT * FROM member WHERE is_matching_active = 1;

-- 1번째 거절
SET @user_index = 1;
SET @out_user1 = -1;
SET @out_user2 = -1;
SET @matching_code = -1;

-- CALL matching_user_to_user(@out_user1, @out_user2, @matching_code);
CALL matching_user_to_user2(@user_index, @out_user1, @out_user2, @matching_code);
SELECT @out_user1, @out_user2, @matching_code;

SET @user_response1 = 'Y';
SET @user_response2 = 'N';
SET @user_matching_code1 = @matching_code;
SET @user_matching_code2 = @matching_code;

CALL respond_matching_proposal(@out_user1, @out_user2, @user_response1, @user_response2, @user_matching_code1, @user_matching_code2);

-- 2번째 거절
SET @user_index = 1;
SET @out_user1 = -1;
SET @out_user2 = -1;
SET @matching_code = -1;

-- CALL matching_user_to_user(@out_user1, @out_user2, @matching_code);
CALL matching_user_to_user2(@user_index, @out_user1, @out_user2, @matching_code);
SELECT @out_user1, @out_user2, @matching_code;

SET @user_response1 = 'Y';
SET @user_response2 = 'N';
SET @user_matching_code1 = @matching_code;
SET @user_matching_code2 = @matching_code;

CALL respond_matching_proposal(@out_user1, @out_user2, @user_response1, @user_response2, @user_matching_code1, @user_matching_code2);

-- 3번째 거절
SET @user_index = 1;
SET @out_user1 = -1;
SET @out_user2 = -1;
SET @matching_code = -1;

-- CALL matching_user_to_user(@out_user1, @out_user2, @matching_code);
CALL matching_user_to_user2(@user_index, @out_user1, @out_user2, @matching_code);
SELECT @out_user1, @out_user2, @matching_code;

SET @user_response1 = 'Y';
SET @user_response2 = 'N';
SET @user_matching_code1 = @matching_code;
SET @user_matching_code2 = @matching_code;

CALL respond_matching_proposal(@out_user1, @out_user2, @user_response1, @user_response2, @user_matching_code1, @user_matching_code2);

-- 4번째 거절
SET @user_index = 1;
SET @out_user1 = -1;
SET @out_user2 = -1;
SET @matching_code = -1;

-- CALL matching_user_to_user(@out_user1, @out_user2, @matching_code);
CALL matching_user_to_user2(@user_index, @out_user1, @out_user2, @matching_code);
SELECT @out_user1, @out_user2, @matching_code;

SET @user_response1 = 'Y';
SET @user_response2 = 'N';
SET @user_matching_code1 = @matching_code;
SET @user_matching_code2 = @matching_code;

CALL respond_matching_proposal(@out_user1, @out_user2, @user_response1, @user_response2, @user_matching_code1, @user_matching_code2);

-- 5번째 거절
SET @user_index = 1;
SET @out_user1 = -1;
SET @out_user2 = -1;
SET @matching_code = -1;

-- CALL matching_user_to_user(@out_user1, @out_user2, @matching_code);
CALL matching_user_to_user2(@user_index, @out_user1, @out_user2, @matching_code);
SELECT @out_user1, @out_user2, @matching_code;

SET @user_response1 = 'Y';
SET @user_response2 = 'N';
SET @user_matching_code1 = @matching_code;
SET @user_matching_code2 = @matching_code;

CALL respond_matching_proposal(@out_user1, @out_user2, @user_response1, @user_response2, @user_matching_code1, @user_matching_code2);


SELECT * FROM member WHERE id IN (@out_user1, @out_user2);

SELECT * FROM member_matching WHERE member_id = @out_user2;