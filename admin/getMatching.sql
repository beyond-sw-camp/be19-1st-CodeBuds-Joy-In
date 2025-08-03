-- ---------------------------------------------------------------------------
-- 1:1 매칭 조회

SELECT a.id, a.name, a.gender, b.matching_id
FROM member a
    JOIN member_matching b ON a.id = b.member_id
    WHERE b.status = 'Y'
        AND b.matching_id IN (
        SELECT matching_id
        FROM member_matching
        WHERE status = 'Y'
        GROUP BY matching_id
        HAVING COUNT(*) = 2
);
