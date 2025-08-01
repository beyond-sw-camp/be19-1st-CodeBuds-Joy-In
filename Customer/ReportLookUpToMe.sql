-- 내가 받은 신고내역 확인

set @member_id = 10004;  -- 내가 받은 내역 확인
select
       a.reason as '신고내용'
     , c.name as '내이름'
     , b.created_by as '신고일'
from board_report as a
 join post as b
      on a.post_id = b.id
 join member as c
      on c.id = b.member_id
where c.id = @member_id -- 내가 받은 내역 확인
union all -- 회원신고
select
      a.reason as '신고내용'
     , b.name as '내이름'
     , a.created_by as '신고일'
from member_report as a
         join member as b
           on a.target_member_id = b.id
where a.target_member_id = @member_id -- 내가 받은 내역 확인



-- 내가 받은 게시글 신고 내역만 확인.

select
       a.reason as '신고사유'
     , b.title as '신고당한글'
     , c.name as '내이름'
     , a.created_by as '신고일'
from board_report as a
 join post as b
      on a.post_id = b.id
 join member as c
      on c.id = b.member_id
 join member_report as d
      on d.member_id = a.member_id
where b.member_id = 10004 -- 내가 받은 신고 내역 확인
