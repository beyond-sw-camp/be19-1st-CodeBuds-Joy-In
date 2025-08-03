
-- 단체모임 과거 같이 여행한 인원 프로필 조회


delimiter //
create or replace procedure previousTripLookUpWithOthes(
    in userId int
)
begin
select
       concat(c.start_date , '~' , c.end_date) as '여행 기간'
     , c.title
     , d.nickname as '닉네임'
     , e.name as '등급'
     , group_concat(g.name order by g.id SEPARATOR ',') as '성향'

from (
            select *
              from join_request as a
             where exists(
                 select 1
                 from join_request
                 where member_id = userId
                   and post_id = a.post_id
             )
              and status = 'Y'
              and certification = 1
              and member_id <> userId
) as b
    join post   as c on b.post_id = c.id
    join member as d on d.id = b.member_id
    join rank   as e on e.id = d.rank_id
    left join member_preference as f on f.member_id = b.member_id
    left join preference  as g on f.preference_id = g.id
    group by c.start_date, c.end_date,c.title, d.nickname,e.name;
end //

delimiter ;