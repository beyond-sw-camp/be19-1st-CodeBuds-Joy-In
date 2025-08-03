-- ---------------------------------------------------------------------------
-- 성사된 모임 조회
select a.id, a.name, a.gender, b.post_id, c.title
from member a join join_request b on a.id = b.member_id
              join post c
where b. status = 'Y' and c.id = b.post_id and b.post_id in
                        (select post_id from join_request
                            where status = 'Y' and certification = 1 group by post_id);