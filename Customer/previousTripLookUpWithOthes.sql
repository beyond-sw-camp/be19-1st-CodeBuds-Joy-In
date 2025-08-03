
-- 과거 같이 여행한 인원 프로필 조회


delimiter //
create or replace procedure previousTripLookUpWithOthes(
    in userId int
)
begin

    select
        b.tripDate as '여행 기간'
         , b.title
         , d.nickname as '닉네임'
         , e.name as '등급'
         , group_concat(g.name order by g.id SEPARATOR ',') as '성향'
         , b.member_id
    from (
             select
                 a.member_id
                  , c.title
                  , concat(c.start_date , ' ~ ' , c.end_date) as tripDate
             from join_request as a
                      join post  as c on a.post_id = c.id
             where exists(
                 select 1
                 from join_request
                 where member_id = userId
                   and post_id = a.post_id
             )
               and status = 'Y'
               and certification = 1
               and a.member_id <> userId
             union all
             select
                 a.member_id
                  , '1:1매칭' as title
                  , concat(c.start_date , ' ~ ' , DATE_ADD(DATE(c.start_date), INTERVAL '23:59:59' HOUR_SECOND)) as tripDate
             from member_matching as a
                      join matching as c
                           on a.matching_id = c.id
             where exists(
                 select 1
                 from member_matching
                 where member_id = userId
                   and matching_id = a.matching_id
             )
               and a.status = 'Y'
               and certification = 1
               and member_id <> userId
         )  as b
             join member as d on d.id = b.member_id
             join rank   as e on e.id = d.rank_id
             left join member_preference as f on f.member_id = b.member_id
             left join preference  as g on f.preference_id = g.id
    group by b.tripDate, b.title, d.nickname, e.name,b.title, d.nickname,e.name;

end //

delimiter ;
