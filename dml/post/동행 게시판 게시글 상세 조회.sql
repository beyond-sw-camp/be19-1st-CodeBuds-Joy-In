-- 동행 게시판의 게시글 상세 조회
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
   , c.name AS board_name
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
WHERE is_deleted = 0 AND a.id = 18;

-- 게시글 조회수 증가
UPDATE post
  SET views = views + 1
WHERE id = 18;