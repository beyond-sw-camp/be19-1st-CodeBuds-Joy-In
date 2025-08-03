-- 동행 요청 신청자 목록 조회 (게시글 작성자 즉 방장이 조회)
SELECT 
		 a.id AS join_request_id
	  , a.status
	  , a.certification
	  , b.id AS post_id
	  , b.title
	  , c.name
	FROM join_request a
   JOIN post b ON a.post_id = b.id
   JOIN member c ON a.member_id = c.id
  WHERE b.id = 18 AND b.member_id != a.member_id;