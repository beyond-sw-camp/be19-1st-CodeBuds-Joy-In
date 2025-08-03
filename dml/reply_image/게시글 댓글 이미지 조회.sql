-- 게시글 댓글 이미지 조회
SELECT 
		 id
	  , origin_name
	  , renaming
	  , path 
	  , reply_id
 FROM reply_image
WHERE reply_id = 8;