-- 게시글 및 댓글 관리자 승인 및 거절
UPDATE board_report
   SET admin_status = 'Y'
 WHERE id = 94;
 
-- 게시글 및 댓글 관리자 거절
UPDATE board_report
   SET admin_status = 'N'
 WHERE id = 94;