-- 내가 작성한 게시글 목록 조회
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
 WHERE is_deleted = 0 AND b.id = 14390
 ORDER BY created_by DESC;