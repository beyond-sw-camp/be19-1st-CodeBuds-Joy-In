
delimiter //

create or replace procedure cancleMemberReport(
    in userId int,
    in targetId int,
    in reportID int,
    out returnMessage varchar(2000)
)
main: begin

    declare rowCount int;

    select count(*) into rowCount
      from member_report
     where reportID = reportID
       and member_id = userId
       and target_member_id = targetId
       and admin_status = 'N';

    if rowcount > 0 then
        delete
          from member_report
         where id = reportID
           and member_id = userId
           and target_member_id = targetId
           and admin_status = 'N';

        set returnMessage = '신고글 삭제가 완료 되었습니다.';
    else
        set returnMessage = '해당 신고글은 삭제가능 한 상태가 아닙니다.';
    end if;


end //
delimiter ;
