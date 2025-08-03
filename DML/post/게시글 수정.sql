-- 게시글 수정
update post
   set title = '내일 성심당 같이 갈 사람?!'
     , content = '대전 성심당 내일 같이 가실 분 구합니다! '
     , updated_by = now()
     , start_date = '2025-08-05 16:00:00'
     , end_date = '2025-08-05 18:00:00'
     , recruitment_capacity = 3
     , recruitment_deadline = '2025-08-05 13:00:00'
 where id = 18;