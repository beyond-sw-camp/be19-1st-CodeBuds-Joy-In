-- 1) 전체 게시판에서 키워드로 검색
SELECT
       a.id
     , title
     , content
     , a.created_by
     , views
     , start_date
     , end_date
     , recruitment_capacity
     , recruitment_status
     , recruitment_deadline
     , current_count
     , c.name
     , b.nickname
     , b.id
  FROM post a
  JOIN MEMBER b ON a.member_id = b.id
  JOIN board c ON a.board_id = c.id
 WHERE is_deleted = 0 AND (a.title LIKE '%일본%' OR a.content LIKE '%일본%')
 ORDER BY created_by DESC;

-- 2) 자유, 여행지 추천 게시판에서 키워드로 게시글 검색
SELECT
       a.id
     , title
     , content
     , a.created_by
     , views
     , c.name
     , b.nickname
     , b.id
  FROM post a
  JOIN MEMBER b ON a.member_id = b.id
  JOIN board c ON a.board_id = c.id
 WHERE is_deleted = 0 AND (a.title LIKE '%일본%' OR a.content LIKE '%일본%') AND c.name IN ('자유', '여행지 추천')
 ORDER BY created_by DESC;

-- 3) 동행 게시판에서 키워드로 게시글 검색
SELECT
       a.id
     , title
     , content
     , a.created_by
     , views
     , start_date
     , end_date
     , recruitment_capacity
     , recruitment_status
     , recruitment_deadline
     , current_count
     , c.name
     , b.nickname
  FROM post a
  JOIN MEMBER b ON a.member_id = b.id
  JOIN board c ON a.board_id = c.id
 WHERE is_deleted = 0 AND (a.title LIKE '%일본%' OR a.content LIKE '%일본%') AND c.name IN ('동행')
 ORDER BY created_by DESC;

-- 4) 게시글 상세 조회 프로시저
DELIMITER //

CREATE OR REPLACE PROCEDURE getDetailPost(
	IN p_id INTEGER
)
BEGIN
    SELECT
           a.id
         , title
         , content
         , a.created_by
         , views
         , start_date
         , end_date
         , recruitment_capacity
         , recruitment_status
         , recruitment_deadline
         , current_count
         , c.name
         , b.nickname
         , COALESCE(d.like_count, 0)  AS likes
         , COALESCE(e.reply_count, 0) AS replies
      FROM post a
      JOIN MEMBER b ON a.member_id = b.id
      JOIN board c ON a.board_id = c.id
      LEFT JOIN (SELECT
                        post_id
                      , COUNT(*) AS like_count
                   FROM likes
                  GROUP BY post_id) d ON a.id = d.post_id
      LEFT JOIN (SELECT
                        post_id
                      , COUNT(*) AS reply_count
                   FROM reply
                  GROUP BY post_id) e ON a.id = e.post_id
     WHERE is_deleted = 0 AND a.id = p_id;

    UPDATE post
       SET views = views + 1
     WHERE id = p_id;
END //

DELIMITER ;

-- 게시판의 게시글 상세 조회 프로시저 호출
CALL getDetailPost(12);
CALL getDetailPost(13);
CALL getDetailPost(14);