-- 방장이 게시글을 만들면
-- join_request에서 승인상태 수정

delimiter //
create or replace trigger HostCountAdd
    after insert
    on post
    for each row

begin
    if new.board_id = 2 then -- 동행게시글에 글이 추가되면
        insert into join_request
        values (null, 'Y', 0, new.id, new.member_id);

    end if;
end //

delimiter ;