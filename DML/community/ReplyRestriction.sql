-- 댓글 제재
DELETE p
FROM reply p
         LEFT JOIN (
    SELECT reply_id, COUNT(*) AS report_count
    FROM board_report
    GROUP BY reply_id
) l ON p.id = l.reply_id
WHERE COALESCE(l.report_count, 0) > 10;