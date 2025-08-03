-- 게시글 댓글 수정
INSERT 
  INTO reply
(content, post_id, member_id)
VALUES 
('강릉 추천합니다!', 17, 10460);

-- 게시글 대댓글 등록
INSERT 
  INTO reply
(content, parent_id, post_id, member_id)
VALUES 
('추천 감사합니다!', 8, 17, 10510);