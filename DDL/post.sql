CREATE TABLE IF NOT EXISTS post
(
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
	 title VARCHAR(255) NOT NULL,
	 content TEXT NOT NULL,
	 created_by DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	 updated_by DATETIME NULL,
	 is_deleted tinyint(1) NOT NULL DEFAULT 0 COMMENT '게시글 삭제 여부',
	 start_date DATETIME NULL COMMENT '모임 시작일',
	 end_date DATETIME NULL COMMENT '모임 종료일' ,
	 views INTEGER NOT NULL	DEFAULT 0 COMMENT '조회수',
	 recruitment_capacity INTEGER NULL COMMENT '모집 인원 수',
	 recruitment_status INTEGER NULL COMMENT '모집 상태',
	 recruitment_deadline DATETIME NULL COMMENT '모집 마감일',
	 current_count INTEGER NULL COMMENT '모집 확정 인원 수',
	 member_id INTEGER NULL,
	 board_id INTEGER NOT NULL
);

ALTER TABLE post 
ADD CONSTRAINT fk_post_member_member_id FOREIGN KEY(member_id) REFERENCES member(id);

ALTER TABLE post 
ADD CONSTRAINT fk_post_member_board_id FOREIGN KEY(board_id) REFERENCES board(id);