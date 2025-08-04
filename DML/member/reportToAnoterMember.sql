


delimiter //

create or replace procedure reportToAnoterMember(
    in userId int,
    in targetId int,
    in reportId int,
    in reason varchar(2000),
    out returnMessage varchar(2000)
)
main: begin

    declare encryptedPassword varchar(255);
    declare rowCount int; -- 동행했던 회원이 있는지 확인.


select count(*) into rowCount
    from (
        select *
          from join_request as a
          where exists(select 1
                       from join_request
                       where member_id = userId
                         and post_id = a.post_id)
            and status = 'Y'
            and certification = 1
            and a.member_id = targetId
          union all
          select *
          from member_matching as a
          where exists(select 1
                       from member_matching
                       where member_id = userId
                         and matching_id = a.matching_id)
            and a.status = 'Y'
            and certification = 1
            and member_id = targetId
  ) as a;

if rowCount > 0 then
    insert into member_report
    values(null, reason , 'N' , now(), null, reportId, userId, targetId);
    set returnMessage = '신고가 완료 되었습니다.';
else
    set returnMessage = '해당 회원과 동행 했던 기록이 없습니다. 동행을 했던 회원만 신고가 가능 합니다.';
end if;

end //
delimiter ;