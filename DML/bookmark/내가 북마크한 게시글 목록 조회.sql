-- 내가 북마크한 게시글 목록 조회
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
  JOIN (SELECT post_id, member_id
  			 FROM bookmark
  			WHERE member_id = 10003) d ON a.id = d.post_id 
 WHERE is_deleted = 0
 ORDER BY created_by DESC;