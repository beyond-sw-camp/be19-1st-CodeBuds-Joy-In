-- 내가 댓글 작성한 게시글 목록 조회
SELECT
       a.id
     , title
     , content
     , a.created_by
     , views
     , c.name AS board_name
     , b.nickname
  FROM post a
  JOIN MEMBER b ON a.member_id = b.id
  JOIN board c ON a.board_id = c.id
  JOIN (SELECT 
  				   DISTINCT post_id
  			 FROM reply
  			WHERE member_id = 10530) d ON a.id = d.post_id
 WHERE is_deleted = 0
 ORDER BY created_by DESC;