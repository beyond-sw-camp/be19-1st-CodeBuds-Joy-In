-- 게시글 조회 수 증가
UPDATE post
  SET views = views + 1
WHERE id = 18;
