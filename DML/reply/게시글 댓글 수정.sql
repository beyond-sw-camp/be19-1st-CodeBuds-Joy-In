-- 게시글 댓글 수정
UPDATE reply
   SET content = '오 강릉 좋아요! 추천 감사합니다:)'
     , updated_by = NOW()
 WHERE id = 9;