-- 게시글 제재
UPDATE post p
    LEFT JOIN (
    SELECT post_id, COUNT(*) AS report_count
    FROM board_report
    GROUP BY post_id
    ) l ON p.id = l.post_id
    SET p.is_deleted = 1
WHERE COALESCE(l.report_count, 0) > 10;