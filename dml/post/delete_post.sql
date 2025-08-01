-- 1) 게시글 삭제 쿼리
UPDATE post
   SET is_deleted = 1
 WHERE id = 11;

-- 2) 게시글 soft delete 하는 프로시저 
DELIMITER //

CREATE OR REPLACE PROCEDURE deletePost (
	 IN post_id INTEGER 
) 

BEGIN
	UPDATE post
      SET is_deleted = 1
    WHERE id = post_id;
END //

DELIMITER ;

-- 삭제 프로시저 호출
CALL deletePost(11);
