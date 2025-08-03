-- 게시글 및 댓글 신고 등록  
INSERT 
  INTO board_report
(reason, post_id, report_id, member_id, admin_status)
VALUES
('같은 내용으로 게시글 도배하는 행위 발생하여 신고하였습니다, 신속한 처리 부탁드립니다.', 20, 7, 14390, 'U');

INSERT 
  INTO board_report
(reason, reply_id, report_id, member_id, admin_status)
VALUES
('같은 내용으로 게시글 도배하는 행위 발생하여 신고하였습니다, 신속한 처리 부탁드립니다.', 1, 7, 14390, 'U');