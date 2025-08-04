-- 커뮤니티 게시글 등록

-- 1) 자유 또는 여행지 게시판에 게시글 등록
INSERT 
  INTO post
(title, content, member_id, board_id)
VALUES 
('국내 여행지 추천해주세요!', '1박 2일로 짧게 다녀올만한 국내 여행지 추천받습니다', 10510, 1); 

-- 2) 동행 게시판에 게시글 등록
INSERT 
  INTO post
(
  title, content
, start_date, end_date
, recruitment_capacity, recruitment_deadline
, member_id, board_id
, recruitment_status, current_count
)
VALUES 
( 
  '모레 성심당 같이 갈 사람?', '대전 성심당 모레 같이 가실 분!'
, '2025-08-05 16:00:00', '2025-08-05 18:00:00'
, 3, '2025-08-05 13:00:00'
, 14390, 2
, 0, 1
);