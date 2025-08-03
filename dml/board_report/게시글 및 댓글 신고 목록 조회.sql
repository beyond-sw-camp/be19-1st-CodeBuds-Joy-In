-- 게시글 신고 목록 조회
SELECT 
       a.id
     , reason
     , a.created_by
     , admin_status
     , report_id
     , b.name
     , c.title
     , c.content
     , d.name
  FROM board_report a
  JOIN report b ON a.report_id = b.id
  JOIN post c ON a.post_id = c.id
  JOIN MEMBER d ON a.member_id = d.id
 WHERE post_id IS NOT NULL
 ORDER BY id desc;

-- 댓글 신고 목록 조회
SELECT 
       a.id
     , reason
     , a.created_by
     , admin_status
     , report_id
     , b.name
     , c.content
     , d.name
  FROM board_report a
  JOIN report b ON a.report_id = b.id
  JOIN reply c ON a.reply_id = c.id
  JOIN MEMBER d ON a.member_id = d.id
 WHERE reply_id IS NOT NULL
 ORDER BY id desc;