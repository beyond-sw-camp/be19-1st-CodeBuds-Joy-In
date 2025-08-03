-- 1) 전체 게시판에서 게시글 목록 조회
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
 WHERE is_deleted = 0
 ORDER BY created_by DESC;

-- 2) 자유 게시판에서 게시글 목록 조회
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
 WHERE is_deleted = 0 AND c.id = 1
 ORDER BY created_by DESC;
 
-- 3) 여행지 추천 게시판에서 게시글 목록 조회
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
 WHERE is_deleted = 0 AND c.id = 3
 ORDER BY created_by DESC;

-- 3) 동행 게시판에서 키워드로 게시글 목록 조회
SELECT
       a.id
     , title
     , content
     , a.created_by
     , views
     , c.name AS board_name
     , b.nickname
     , a.recruitment_status
  FROM post a
  JOIN MEMBER b ON a.member_id = b.id
  JOIN board c ON a.board_id = c.id
 WHERE is_deleted = 0 AND c.id = 2
 ORDER BY created_by DESC;