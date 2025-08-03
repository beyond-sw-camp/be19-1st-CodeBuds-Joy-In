-- 게시글 댓글 조회
SELECT 
		 a.id
	  , a.content
	  , a.created_by
	  , a.parent_id
	  , b.nickname
  FROM reply a
  JOIN MEMBER b ON a.member_id = b.id
 WHERE a.post_id = 17;