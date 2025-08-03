-- 동행 요청 수락 및 거절
UPDATE join_request 
   SET STATUS = 'Y'
 WHERE id = 9;

-- 동행 요청 거절
UPDATE join_request 
   SET STATUS = 'N'
 WHERE id = 10;