-- ---------------------------------------------------------------------------
-- 1:1 매칭 조회


select a.id, a.name, a.gender, b.matching_id
from member a
         join member_matching b on a.id = b.member_id
where b.status = 'Y' and b.certification = 1
  and b.matching_id in (
    select matching_id
    from member_matching
    where status = 'Y'
    group by matching_id
    having COUNT(*) = 2
);
