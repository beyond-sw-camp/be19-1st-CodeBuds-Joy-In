delimiter //
create or replace procedure ReportLookUpFromMe(
    in userId int
)
begin

    -- 내가 신고한 내역 전체 조회
    select -- 게시판 신고
        c.name as '피신고자'
         , d.reason as '신고사유'
         , d.name as '신고자'
         ,d.created_by as '신고날짜'
    from member as c
             join(
        select
            b.member_id
             , a.reason
             , c.name
             , b.created_by
        from board_report as a
                 join post as b
                      on a.post_id = b.id
                 join member as c
                      on c.id = a.member_id
        where a.member_id = userId -- 내가 신고한 내역 확인
    ) as d
                 on d.member_id = c.id
    union all -- 회원신고
    select
        c.name as '피신고자'
         , d.reason as '신고사유'
         , d.name as '신고자'
         , d.created_by as '신고날짜'
    from member as c
             join (
        select
            a.target_member_id
             , a.reason
             , b.name
             , a.created_by
        from member_report as a
                 join member as b
                      on a.member_id = b.id
        where a.member_id = userId -- 내가 신고한 내역 확인
    ) as d
                  on c.id = d.target_member_id;



-- 내가 신고한건중 게시글 신고내용만 조회

    select
        c.name as '피신고자'
         , d.reason as '신고사유'
         , d.title as '신고글'
         , d.created_by as '신고일'
         , d.name as '신고자'
         , d.report_id as '게시판 신고 식별 ID'
    from member as c
             join(
        select
            a.post_id
             , a.reason
             , a.created_by
             , b.member_id
             , b.title
             , c.name
             , a.id as report_id
        from board_report as a
                 join post as b
                      on a.post_id = b.id
                 join member as c
                      on c.id = a.member_id
                 join member_report as d
                      on d.member_id = a.member_id
        where a.member_id = userId -- 내가 신고한 내역 확인
    ) as d
                 on c.id = d.member_id;

    -- 내가 신고한건중 회원 신고를 한 내역만 조회

    select
        c.name as '피신고자'
         , d.reason as '신고사유'
         , d.name as '신고자'
         , d.created_by as '신고날짜'
         , d.memeber_report_id as '신고내역 식별 ID'
    from member as c
             join (
        select
            a.target_member_id
             , a.reason
             , b.name
             , a.created_by
             , a.id as memeber_report_id
        from member_report as a
                 join member as b
                      on a.member_id = b.id
        where a.member_id = userId -- 내가 신고한 내역 확인
    ) as d
                  on c.id = d.target_member_id;
end //
