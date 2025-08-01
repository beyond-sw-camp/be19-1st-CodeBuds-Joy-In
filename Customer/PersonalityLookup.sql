
-- 내 정보 조회

SELECT
       a.name
     , a.birth
     , a.phone
     , a.email
     , a.nickname
     , b.name
  FROM member as a
  JOIN rank as b
    on a.rank_id = b.id
 WHERE a.id = 15003; -- 조회할 id 입력



-- 내 성향 조회
SELECT
        c.name
  FROM member as a
  JOIN member_preference as b
    on a.id = b.member_id
  JOIN preference as c
    on b.preference_id = c.id
 WHERE a.id = 15003; -- 조회할 id 입력





