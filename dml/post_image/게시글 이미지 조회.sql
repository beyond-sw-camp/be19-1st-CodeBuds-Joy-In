-- 게시글 이미지 조회
SELECT 
		 id
	  , origin_name
	  , renaming
	  , thumbnail
	  , path 
	  , post_id
 FROM post_image
WHERE post_id = 18;