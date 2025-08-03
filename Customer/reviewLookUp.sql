
-- 리뷰 조회 , id 혹은 이름으로

create or replace view reviewLookUp
as
select
       a.name
     , b.review
     , b.created_by
     , a.id
  from member as a
join(
        select
               review
             , target_member_id as id
             , created_by
          from group_review
        union all
        select review
             , target_member_id  as id
             , created_by
          from matching_review
  ) as b
on a.id = b.id;