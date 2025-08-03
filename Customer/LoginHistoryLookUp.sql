
-- 회원 id로 로그인 정보 조회
select *
  from login_history
 where member_id = 15003; -- 로그인 기록을 검색 할 회원의 id


-- 회원 이름으로 로그인 정보 조회
select *
  from login_history
 where member_id = (
     select
            id
       from member
      where name = '홍정훈1' -- 로그인 기록을 검색할 회원의 이름
     );
